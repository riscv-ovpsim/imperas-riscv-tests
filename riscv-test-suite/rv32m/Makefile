#=======================================================================
# Makefile for riscv-tests/isa
#-----------------------------------------------------------------------
    #
    # Copyright (c) 2005-2020 Imperas Software Ltd., www.imperas.com
    #
    # The contents of this file are provided under the Software License
    # Agreement that you accepted before downloading this file.
    #
    # This source forms part of the Software and can be used for educational,
    # training, and demonstration purposes but cannot be used for derivative
    # works except in cases where the derivative works require OVP technology
    # to run.
    #
    # For open source models released under licenses that you can use for
    # derivative works, please visit www.OVPworld.org or www.imperas.com
    # for the location of the open source models.
    #
    

#

act_dir := .
src_dir := $(act_dir)/src
work_dir := $(ROOTDIR)/work
work_dir_isa := $(work_dir)/$(RISCV_ISA)

include $(act_dir)/Makefrag
ifneq ($(RISCV_TEST),)
    target_tests = $(RISCV_TEST).elf
endif

default: all

#--------------------------------------------------------------------
# Build rules
#--------------------------------------------------------------------

vpath %.S $(act_dir)

INCLUDE=$(TARGETDIR)/$(RISCV_TARGET)/device/$(RISCV_DEVICE)/Makefile.include
ifeq ($(wildcard $(INCLUDE)),)
    $(error Cannot find '$(INCLUDE)`. Check that RISCV_TARGET and RISCV_DEVICE are set correctly.)
endif
-include $(INCLUDE)

#------------------------------------------------------------
# Build and run assembly tests

%.log: %.elf
	$(V) echo "Execute $(@)"
	$(V) $(RUN_TARGET)


define compile_template

$(work_dir_isa)/%.elf: $(src_dir)/%.S
	$(V) echo "Compile $$(@)"
	@mkdir -p $$(@D)
	$(V) $(COMPILE_TARGET)

.PRECIOUS: $(work_dir_isa)/%.elf

endef

comma := ,
$(eval $(call compile_template,-march=rv32im -mabi=ilp32))


target_elf = $(foreach e,$(target_tests),$(work_dir_isa)/$(e))
target_log = $(patsubst %.elf,%.log,$(target_elf))

run: $(target_log)

#------------------------------------------------------------
# Clean up

clean:
	rm -rf $(work_dir_isa)

