#
# Ensure the compiler and necessary executables are on the search PATH
#

#
# Ensure you have set the following Variables
#
#
export ROOTDIR    = $(shell pwd)
export WORK      ?= $(ROOTDIR)/work

include Makefile.include

pipe:= |
empty:=
comma:= ,
space:= $(empty) $(empty)

RISCV_DEVICE_ALL = $(shell ls $(TARGETDIR)/$(RISCV_TARGET)/device/rv$(XLEN)$(RISCV_BASE)_$(RISCV_MODE))
RISCV_DEVICE_OPT = $(subst $(space),$(pipe),$(RISCV_DEVICE_ALL))

RISCV_DEVICE_ALL := $(filter-out Makefile.include,$(RISCV_DEVICE_ALL))

ifeq ($(strip $(RISCV_DEVICE)),)
    DEFAULT_TARGET=all_variant
    # If make target is specified use this as default
    DEFAULT_CLEAN_TARGET=all_clean
else
    DEFAULT_TARGET=variant
    DEFAULT_CLEAN_TARGET=one_clean
endif
export SUITEDIR   = $(ROOTDIR)/riscv-test-suite/rv$(XLEN)$(RISCV_BASE)_$(RISCV_MODE)/$(RISCV_DEVICE)

ifeq ($(RISCV_TARGET),)
    # Check riscvOVPsim present
    ifneq ($(wildcard $(ROOTDIR)/riscv-ovpsim/bin/*/riscvOVPsim.exe),)
        export RISCV_TARGET=riscvOVPsim
    else
        # Check riscvOVPsimPlus present
        ifneq ($(wildcard $(ROOTDIR)/riscv-ovpsim-plus/bin/*/riscvOVPsimPlus.exe),)
            export RISCV_TARGET=riscvOVPsimPlus
        else
            ERROR:=$(error Cannot find either default RISCV_TARGET riscvOVPsim or riscvOVPsimPlus)
        endif
    endif
endif

$(info )
$(info ============================ VARIABLE INFO ==================================)
$(info ROOTDIR: $(ROOTDIR) [origin: $(origin ROOTDIR)])
$(info WORK: $(WORK) [origin: $(origin WORK)])
$(info TARGETDIR: $(TARGETDIR) [origin: $(origin TARGETDIR)])
$(info RISCV_TARGET: $(RISCV_TARGET) [origin: $(origin RISCV_TARGET)])
$(info XLEN: $(XLEN) [origin: $(origin XLEN)])
$(info RISCV_BASE: $(RISCV_BASE) [origin: $(origin RISCV_BASE)])
$(info RISCV_MODE: $(RISCV_MODE) [origin: $(origin RISCV_MODE)])
$(info RISCV_DEVICE: $(RISCV_DEVICE) [origin: $(origin RISCV_DEVICE)])
$(info =============================================================================)
$(info )

export RISCV_PREFIX       ?= riscv64-unknown-elf-

# Check Toolchain on PATH
ifeq (,$(shell which $(RISCV_PREFIX)gcc))
  ifeq (,$(shell which $(RISCV_PREFIX)as))
$(error No $(RISCV_PREFIX)gcc or $(RISCV_PREFIX)as on PATH, consider correcting RISCV_PREFIX and/or adding bin directory to PATH)
  endif
endif


RVTEST_DEFINES = 
ifeq ($(RISCV_ASSERT),1)
	RVTEST_DEFINES += -DRVMODEL_ASSERT
endif
ifeq ($(RISCV_ASSERT),2)
	RVTEST_DEFINES += -DRVMODEL_ASSERT -DRVMODEL_ASSERT_SHORT
endif
export RVTEST_DEFINES

VERBOSE ?= 0
ifeq ($(VERBOSE),1)
    export V=
    export REDIR =
    export REDIR1 =
    export REDIR2 =
else
    export V=@
    export REDIR  =  >/dev/null
    export REDIR1 = 1>/dev/null
    export REDIR2 = 2>/dev/null
endif

PARALLEL ?= 1
ifeq ($(RISCV_TARGET),spike)
	PARALLEL = 0
endif
ifeq ($(PARALLEL),0)
    JOBS =
endif

default: $(DEFAULT_TARGET)

variant: simulate verify

all_variant:
	for isa in $(RISCV_DEVICE_ALL); do \
		$(MAKE) $(JOBS) RISCV_TARGET=$(RISCV_TARGET) RISCV_MODE=$(RISCV_MODE) RISCV_BASE=$(RISCV_BASE) RISCV_TARGET_FLAGS="$(RISCV_TARGET_FLAGS)" RISCV_DEVICE=$$isa variant; \
			rc=$$?; \
			if [ $$rc -ne 0 ]; then \
				exit $$rc; \
			fi \
	done

build: compile
run: simulate

compile:
ifeq ($(wildcard $(SUITEDIR)/Makefile),)
	@echo "# Ignore riscv-test-suite/rv$(XLEN)$(RISCV_BASE)_$(RISCV_MODE)/$(RISCV_DEVICE)"
else
	$(MAKE) $(JOBS) \
		RISCV_TARGET=$(RISCV_TARGET) \
		RISCV_DEVICE=$(RISCV_DEVICE) \
		RISCV_BASE=$(RISCV_BASE) \
		RISCV_MODE=$(RISCV_MODE) \
		RISCV_PREFIX=$(RISCV_PREFIX) \
		compile -C $(SUITEDIR)
endif

simulate:
ifeq ($(wildcard $(SUITEDIR)/Makefile),)
	@echo "# Ignore riscv-test-suite/rv$(XLEN)$(RISCV_BASE)_$(RISCV_MODE)/$(RISCV_DEVICE)"
else
	$(MAKE) $(JOBS) \
		RISCV_TARGET=$(RISCV_TARGET) \
		RISCV_DEVICE=$(RISCV_DEVICE) \
		RISCV_BASE=$(RISCV_BASE) \
		RISCV_MODE=$(RISCV_MODE) \
		RISCV_PREFIX=$(RISCV_PREFIX) \
		run -C $(SUITEDIR)
endif

verify: simulate
	riscv-test-env/verify.sh \
		RISCV_TARGET=$(RISCV_TARGET) \
		RISCV_DEVICE=$(RISCV_DEVICE) \
		RISCV_BASE=$(RISCV_BASE) \
		RISCV_MODE=$(RISCV_MODE) \
		RISCV_PREFIX=$(RISCV_PREFIX)

cover: postverify
postverify:
ifeq ($(wildcard $(TARGETDIR)/$(RISCV_TARGET)/postverify.sh),)
	$(info No post verify script found $(TARGETDIR)/$(RISCV_TARGET)/postverify.sh)
else
	$(TARGETDIR)/$(RISCV_TARGET)/postverify.sh \
		RISCV_TARGET=$(RISCV_TARGET) \
		RISCV_DEVICE=$(RISCV_DEVICE) \
		RISCV_BASE=$(RISCV_BASE) \
		RISCV_MODE=$(RISCV_MODE) \
		RISCV_PREFIX=$(RISCV_PREFIX)
endif

clean: $(DEFAULT_CLEAN_TARGET)

all_clean:
	for isa in $(RISCV_DEVICE_ALL); do \
		$(MAKE) $(JOBS) RISCV_TARGET=$(RISCV_TARGET) RISCV_MODE=$(RISCV_MODE) RISCV_BASE=$(RISCV_BASE) RISCV_DEVICE=$$isa clean; \
			rc=$$?; \
			if [ $$rc -ne 0 ]; then \
				exit $$rc; \
			fi \
	done

one_clean:
ifeq ($(wildcard $(SUITEDIR)/Makefile),)
	@echo "# Ignore riscv-test-suite/rv$(XLEN)$(RISCV_BASE)_$(RISCV_MODE)/$(RISCV_DEVICE)"
else
	$(MAKE) $(JOBS) \
		RISCV_TARGET=$(RISCV_TARGET) \
		RISCV_DEVICE=$(RISCV_DEVICE) \
		RISCV_BASE=$(RISCV_BASE) \
		RISCV_MODE=$(RISCV_MODE) \
		RISCV_PREFIX=$(RISCV_PREFIX) \
		clean -C $(SUITEDIR)
endif

help:
	@echo "RISC-V Architectural Tests"
	@echo ""
	@echo "  Makefile Environment Variables to be set per Target"
	@echo "     -- TARGETDIR='<directory containing the target folder>'"
	@echo "     -- XLEN='<make supported xlen>'"
	@echo "     -- RISCV_TARGET='<name of target>'"
	@echo "     -- RISCV_TARGET_FLAGS='<any flags to be passed to target>'"
	@echo "     -- RISCV_DEVICE='$(RISCV_DEVICE_OPT)' [ leave empty to run all devices ]"
	@echo "     -- RISCV_BASE='<isa i or e>'"
	@echo "     -- RISCV_MODE='<mode m or mu or msu>'"
	@echo "     -- RISCV_TEST='<name of the test. eg. I-ADD-01'"
	@echo "    "
	@echo "  Other Options"
	@echo "     -- RISCV_ASSERT='0/1/2' 0(default)-no assertions, 1-full information, 2-report only"
	@echo "     -- RISCV_GENERATE_OBJFILE='0/1' 0(default)-no object file, 1-object file generated with ELF"
	@echo "    "
	@echo "  Makefile targets available"
	@echo "     -- build: To compile all the tests within the RISCV_DEVICE suite and generate the elfs. Note this will default to running on the I extension alone if RISCV_DEVICE is empty"
	@echo "     -- run: To run compiled tests on the target model and generate signatures. Note this will default to run aning on the I extension alone if RISCV_DEVICE is empty"
	@echo "     -- verify: To verify if the generated signatures match the corresponding reference signatures. Note this will default to running on the I extension alone if RISCV_DEVICE is empty"
	@echo "     -- postverify: To execute a target specific verify script. Note this will default to running on the I extension alone if RISCV_DEVICE is empty"
	@echo "     -- clean : removes the working directory from the root folder and also from the respective device folders of the target"
	@echo "     -- default: build, run, and verify on all devices enabled"


