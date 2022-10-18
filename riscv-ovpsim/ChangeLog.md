riscvOVPsim Change Log
===
Copyright (c) 2005-2022 Imperas Software Ltd., www.imperas.com

This CHANGELOG contains information for the riscvOVPsim (and derivative) fixed platforms which include information of the OVP Simulator and RISCV processor model

---

NOTE: X-commit messages below refer to git commits in the following
      Risc-V specification document repositories:
  I-commit: https://github.com/riscv/riscv-isa-manual
  V-commit: https://github.com/riscv/riscv-v-spec
  C-commit: https://github.com/riscv/riscv-fast-interrupt

- Compressed extension version 1.0.0-RC5.7 is now implemented if parameter
  compress_version is set to "1.0.0-RC5.7". Compared to version 0.70.5:
  - jt/jalt instruction encodings are changed;
  - Zcmb subset is removed.
- Presence of the CLIC software interrupt signal (CSIP) is now indicated by
  Boolean parameter CSIP_present - previously, this signal was always present if
  the CLIC is implemented. If present, the signal is now forced to be
  positive-edge triggered - previously, this was configurable. These changes
  reflect specification clarifications made on 11th October 2022.
- Issues have been corrected that caused undesired behavior for vector
  instructions when the agnostic_ones parameter is True: in some cases, tail
  elements were left undisturbed instead of being set to all-ones. Although
  this is permitted by the specification, it was not the intended behavior of
  this parameter.
- Resumable NMI extension version 0.4 is now implemented if parameter
  rnmi_version is set to "0.4". Compared to version 0.2.1, this version:
  - changes mnscratch, mnepc, mncause and mnstatus CSR addresses;
  - defines behavior for exceptions from VS and VU modes; and:
  - specifies that mnstatus.NMIE resets to 0.
- In the CLIC master version, CSIP now has ID 16 and is treated as a local
  interrupt. Previously, CSIP had ID 12 and was not treated as a local
  interrupt.
- When PMP is implemented, read-only 8-bit integration support registers named
  pmp0cfg0, pmp1cfg0 etc have been added that show the configuration of a single
  PMP region.
- When the CLIC is implemented, new parameter nlbits_valid specifies a bitmask
  of valid values for the CLIC cliccfg.nlbits field; for example,
  cliccfg.nlbits=8 is only valid if nlbits_valid has bit 8 set. This complements
  the existing CLICCFGLBITS parameter by allowing a discontinuous range of valid
  values.
- Code size reduction extension instruction mvsa01 now causes an Illegal
  Instruction trap if the two destinations are the same register.
- New parameter trigger_match indicates legal values for 'match' field for
  trigger types 2 and 6.
- When PMP TOR region matching is enabled, low address bounds are now masked
  using the region grain size: previously, only high region bounds were masked.
- New parameter lr_sc_match_size indicates whether data sizes of LR/SC 
  instructions must match for the SC instruction to succeed.
- An issue causing a segmentation fault when executing vcompress.vm when
  vtype.vma=1 has been corrected.
- Behavior of CLIC xscratchcsw CSRs has been corrected - previously, logic
  determining whether the swap should proceed was incorrect.
- The CLIC version master branch currently has these differences compared to
  the previous 0.9-draft-20220315 version:
  - C-commit ad08bd8: vector table read now requires execute permission (not
    read permission);
  - C-commit 12b98cc: algorithm used for xscratchcsw accesses changed;
  - C-commit 8f98d6a: new parameter INTTHRESHBITS allows implemented bits in
    xintthresh CSRs to be restricted.

Date 2022-June-27
Release 20220727.0
===

- Parameter mstatus_fs_mode now supports option force_dirty; if selected, this
  forces the value of mstatus.FS to Dirty (3) and prevents floating-point
  instructions from being disabled.
- New parameters mcycle_undefined, minstret_undefined and mhpmcounter_undefined
  define whether mcycle, minstret and mhpmcounter CSRs are undefined,
  respectively. Previously, presence of these was defined by cycle_undefined, 
  instret_undefined and hpmcounter_undefined parameters; now, those
  parameters control only User-mode CSR presence (as indicated by their names).
  This change allows specification of a core which implements M-mode counters
  but does not implement U-mode counters.
- Some issues with code size reduction extension instructions 0.70.1 have been
  corrected:
  - behavior of c.lbu instruction has been corrected (it was previously 
    sign-extending the byte value instead of zero-extending it).
  - cm.lb instructions with immediate less than 4 are now allowed;
  - encodings for cm.lb and cm.lbu have been exchanged;
  - encodings for cm.lh and cm.lhu have been exchanged;
  - the order in which registers are handled in push and pop instructions has
    been modified to reflect the 0.70.1 specification (it differs to 0.50.1);
  - handling of the stack adjustment in push and pop instructions has been
    corrected.
  - a simulator assertion for push/pop instructions when both Zcmp and Zcmpe
    are absent has been corrected.
  - push/pop instructions no longer require the stack pointer to be aligned
    as was the case in previous specification versions.
  - the immediate reported in disassembly for jalt instructions no longer has 64
    subtracted (behavior of the instruction is unchanged).
-Zc version 0.70.5 has been added, with these features:
  - writeable bits in the jvt CSR may now be configured using the jvt_mask
    parameter.
  - jvt CSR access is now controlled by bit 2 of xstateen0 CSRs, if implemented.
- New Boolean parameter nmi_is_latched specifies whether the NMI input is
  latched on a rising edge of the NMI input or is level-sensitive.
- New Boolean parameter amo_aborts_lr_sc indicates that execution of AMO
  instructions will abort any currently-active LR/SC pair.

Date 2022-May-30
Release 20220527.0
===

- New Boolean parameter no_pseudo_inst disables generation of pseudo-
  instructions in disassembly and trace and enables architectural instructions
  instead.
- An issue has been corrected that caused some accesses of the seed CSR to
  be permitted when an Illegal Instruction trap should have been raised.
- An issue has been corrected that caused updates to Vector Extension vta/vma 
  bits to be ignored in some cases.

Date 2022-April-22
Release 20220421.0
===

- An issue has been corrected that caused incorrect behavior for vector
  narrowing operations when tail agnostic behavior is enabled.
- New parameter unaligned_low_pri indicates that address misaligned faults
  are lower priority than page fault or access fault exceptions.
- New parameter PMP_undefined indicates whether accesses to unimplemented PMP
  registers should cause Illegal Instruction exceptions. By default, such
  accesses read as zero and are write-ignored.
- When Debug mode is implemented, new parameter debug_priority allows a modified
  exception priority order to be specified, as described in Debug Specification
  pull request 693. This mode resolves some anomalous behavior of the original
  specification.
- Smclic version 0.9-draft-20220315 is now implemented.
- Smepmp version 1.0 is now implemented.
- Compressed extension version 0.70.1 is now implemented if parameter
  compress_version is set to "0.70.1". Parameters Zca, Zcb, Zcf, Zcmb, Zcmp, 
  Zcmpe and Zcm are used to specify the presence of each subset.
- When the vector extension is implemented, behavior for fractional LMUL has
  been modified to allow all legal options for the vector configuration;
  previously, only the minimal mandatory set was supported.
- When the vector extension is implemented, an error has been corrected in
  calculated values for VFRSQRTE instructions when SEW=16.
- Privileged Version 1.12 has been added (equivalent to the existing 20211203
  version).
- When the vector extension is implemented, new parameter unalignedV specifies
  whether unaligned vector load/stores are allowed - previously, only aligned
  accesses were permitted.
- When the vector extension is implemented, segment load instructions with
  fractional LMUL are now always reserved if the destination register group
  overlaps the source vector register group - previously, some cases were
  allowed.
- When the vector extension is implemented, segment load and store instructions
  for which the vector register numbers accessed would increment past 31 are
  reserved - previously, indexes wrapped around.

Date 2022-February-9
Release 20220208.0
===

- When the vector extension is implemented and XLEN<SEW, values from X registers
  are now sign-extended (previously, they were zero-extended).

Date 2022-January-13
Release 20220112.0
===

- New privileged version 20211203 has been introduced and is used by default in
  riscv.ovpworld.org envelope model variants. This corresponds to the ratified
  Privileged Specification of that date.
- HLVX instruction behavior has been corrected to always check for read
  permission on matching PMP entries (previously, execute permission was
  checked instead in some cases).
- The vector version master branch currently has these differences compared to
  the previous 1.0 version:
  - V-commit ef8b3a4: instruction encodings are reserved if the same vector
    register would be read with two or more different EEWs.
- New vector version 1.0 has been added, with these differences compared to the
  previous 1.0-rc1-20210608 version:
  - V-commit 8fab4e3: instruction vpopc.m renamed vcpop.m;
  - V-commit c027517: instruction vmandnot.mm renamed vmandn.mm;
  - V-commit c027517: instruction vmornot.mm renamed vmorn.mm.
- Bit Manipulation version 0.93 only, instruction add.uw has been corrected to
  zero extend argument rs1 instead of argument rs2.
- When the Hypervisor is implemented, new parameter fence_g_preserves_vs
  controls the effect of HFENCE.GVMA on cached VS-stage address translations:
  - if fence_g_preserves_vs is False, all cached VS-stage address translations
    with matching VMID specification are invalidated by HFENCE.GVMA;
  - if fence_g_preserves_vs is True, cached VS-stage address translations are
    not affected by HFENCE.GVMA.
- Default model behavior has changed so that HFENCE.GVMA invalidates all cached
  VS-stage address translations with matching VMID specification; previously,
  VS-stage address translations were unaffected. Set parameter
  fence_g_preserves_vs to True to revert to the previous behavior.
- Some corner case behaviors for SIMD extension saturating instructions have
  been corrected. Instructions affected are KMDA, KMSDA, KMSXDA, KMSDA32 and
  KMSXDA32.
- New parameter use_hw_reg_names enables use of hardware register names x0-x31
  and f0-f31 instead of ABI register names. This affects tracing and all
  register access by name via the OP API.
- When the Hypervisor extension is implemented, only interrupts delegated by
  mideleg are now visible in hideleg, hip and hie.

Date 2021-November-18
Release 20211117.0
===

- The ratified specifications are enabled in riscvOVPsim for B (bitmanip), K (crypto) and V (vector) extensions.

- The  processor(s) in the riscvOVPsim fixed platform now have verbose output enabled by default.
  To disable add  _--override riscvOVPsim/cpu/verbose=F_  to the command line. Use  _--showoverrides_  to find all processors.

- Extension Svpbmt is now implemented and enabled using the Svpbmt parameter if
  required.
- Extension Svinval is now implemented and enabled using the Svinval parameter 
  if required.
- Extension Svnapot is now implemented with intermediate page sizes specified
  using the Svnapot_page_mask parameter if required.
- Extension Zicbom is now implemented and enabled using the Zicbom parameter if
  required.
- Extension Zicbop is now implemented and enabled using the Zicbop parameter if
  required.
- Extension Zicboz is now implemented and enabled using the Zicboz parameter if
  required.
- Extension Zmmul is now implemented and enabled using the Zmmul parameter if
  required.
- Extension Zfhmin is now implemented and enabled using the Zfhmin parameter if
  required.
- Extension Smepmp version 0.9.5 is now implemented and enabled using the
  Smepmp_version parameter if required.
- When the Hypervisor extension is implemented, custom interrupts may now be
  delegated to VS mode using hideleg.
- Syndromes are now reported in mtinst and htinst for all access and alignment
  faults; previously, only page faults caused syndromes to be reported.  
- New User Architecture version 20191213 has been added. This is identical to
  previously-existing version 20190305, but has a name conforming to the
  ratified version of the User Architecture specification.
- New Privileged Architecture version 20190608 has been added. This is identical
  to previously-existing version 20190405, but has a name conforming to the
  ratified version of the Privileged Architecture specification.
- The master Privileged Architecture version now supports these new CSRs:
  - mconfigptr  (always implemented)
  - mseccfg     (when Cryptographic Extension 0.9.2 or later also selected)
  - menvcfg     (always implemented)
  - menvcfgh    (when RV32)
  - senvcfg     (when Supervisor mode implemented)
  - henvcfg     (when Hypervisor mode implemented)
  - henvcfgh    (when RV32 Hypervisor mode implemented)
- For K extension 1.0.0-rc1 and later, a bug has been fixed which caused
  sha256sum0, sha256sum1, sha256sig0 and sha256sig1 to generate Illegal
  Instruction exceptions.
- New parameter trap_preserves_lr defines whether an active LR/SC transaction is
  preserved on a trap (if False, any active LR/SC is aborted when a trap is
  taken).
- An issue has been corrected that could cause the htinst address offset to
  be incorrectly filled for a guest page fault (when Hypervisor mode is
  implemented).

Date 2021-October-20
Release 20211019.0
===

- An issue has been corrected that prevented pending interrupts being
  immediately taken after transition from CLIC mode to non-CLIC mode.
- DSP (P) Extension versions 0.5.2 and 0.9.6 are implemented.
- If the B extension is present, from version 1.0.0 it is implicitly always 
  enabled and not subject to control by misa.B, which is zero.
- If the K extension is present, from version 1.0.0-rc1 it is implicitly always 
  enabled and not subject to control by misa.K, which is zero.
- A page table walk encountering an Sv39/Sv48 PTE with reserved bits 63:54
  non-zero now causes a Page Fault exception, conforming with the evolving
  Privileged Specification.
- Behavior of parameter counteren_mask has been modified so that it only affects
  the writable bits in counteren CSRs and does not make unimplemented counters
  undefined, to conform with the Privileged Specification which states that 
  unimplemented counters must appear hard-wired to zero.
- An issue has been corrected that caused stale PMP TOR mappings to be preserved
  when lower bound address registers were modified.
- A bug has been corrected that caused the value of instret to be incorrect
  when an address match trigger and halt request interrupt occur simultaneously.
- New cryptographic version 1.0.0-rc has been added, with these differences
  compared to the previous 0.9.2 version:
  - aes32* opcodes have been changed;
  - all scalar crypto specific instructions which produce 32-bit results now 
    sign-extend them to XLEN bits where relevant (previously they were zero 
    extended);
  - encodings for ES16 and WAIT states have changed.
- Some minor vector extension changes have been implemented:
  - instruction vpopc.m renamed vcpop.m;
  - instruction vmandnot.mm renamed vmandn.mm;
  - instruction vmornot.mm renamed vmorn.mm.

Date 2021-July-22
Release 20210721.0
===

- Initial implementation of Zcee version 1.0.0-rc
- Some Hypervisor extension issues have been corrected:
  - an HLVX instruction failing because of fault when reading a stage 1 table
    address is now reported as a load fault, not an instruction fault;
  - update of xstatus.GVA on a memory fault has been corrected.

Date 2021-July-12
Release 20210709.0
===

- The default value of parameter tval_zero_ebreak has been changed to False,
  conforming to Privileged Architecture specification clarifications of
  13 October 2020 (see https://github.com/riscv/riscv-isa-manual/pull/601)
- CLIC behavior has been enhanced:
  - Version 20180831 has been added (a legacy configuration required by some
    SiFive cores).
  - New parameters posedge_0_63, poslevel_0_63, posedge_other and poslevel_other
    enable some interrupts to be specified as fixed positive edge and fixed
    positive level triggered if required.
  - The riscv.ovpworld.org RISC-V model now implements software interrupts (0-3
    and 12) as fixed positive edge triggered by default. This choice can be
    changed using the parameters described above.
- NMI implementation has been enhanced:
  - New port nmi_cause allows cause of NMI exception to be applied externally;
  - Resumable NMI extension version 0.2.1 is now implemented if parameter
    rnmi_version is set to "0.2.1".

Date 2021-June-29
Release 20210628.0
===

- When connected to a client gdb, floating point register values are now
  available using 'p' packet transactions instead of being passed in the 'p'
  packet (which does not work reliably on some versions of gdb).
- CLIC behavior when exceptions occur in trap vector table reads occur has been
  corrected - this is now indicated by setting inhv in the source mode cause
  register (previously, it was indicated by setting inhv in the target mode
  cause register)
- Debug Mode has been enhanced:
  - Version 1.0.0 has been defined;
  - Trigger matching using sbytemask in textra32/textra64 is now implemented.
- New cryptographic version 0.9.2 has been added, with these differences
  compared to the previous 0.9.0 version:
  - aes32* and sm4* instruction encodings have been changed;
  - Extensions Zbkx, Zbkc and Zbkb have been implemented;
  - packu[w] and rev8.w instructions have been removed from Zbkb;
  - mentropy CSR has been removed;
  - sentropy and mseccnf CSRs have been added.
- The signature dump library has been updated to ensure the signature region 
  is written by the test program. This check is not performed if the test is
  found to contain the symbol main().
- New vector version 1.0-rc1-20210608 has been added, with these differences
  compared to the previous 1.0-draft-20210130 version:
  - V-commit c841730: whole-register loads and stores use the encoded EEW to 
    determine element size (previously, this was a hint and element size 8 was 
    used);
  - V-commit 4ab6506: vle1.v/vse1.v renamed vlm.v/vsm.v;
  - V-commit a66753c: vfredsum.vs/vfwredsum.vs renamed vfredusum.vs/
    vfwredusum.vs;
  - V-commit 808a6f8: parameters Zve32x, Zve32f, Zve64x, Zve64f and Zve64d have
    been added to enable embedded profiles.
- Writes to PMP configuration registers that attempt to set the reserved
  combination R=0/W=1 now set R=0/W=0 instead (following WARL semantics).
- New Boolean parameter agnostic_ones has been added; when True, agnostic
  elements of vector registers will be filled with ones; when False, they will
  be left undisturbed.
- New Boolean parameter enable_fflags_i has been added; when True, an additional
  8-bit artifact register fflags_i is configured, which reports the floating 
  point flags set by the current instruction only (unlike the standard fflags
  CSR, which reports cumulative results). 
- New parameters mtvec_sext, stvec_sext, utvec_sext, mtvt_sext, stvt_sext and
  utvt_sext enable sign-extension of xtvec and xtvt registers from the most
  significant writable bit (as specified by equivalent mask parameters).
- Behavior of xperm.w has been corrected for large rs2 values.
- For SC instructions, both alignment and access permissions are now checked
  irrespective of whether a reservation is active. Previously, only alignment
  constraints were checked if the reservation was inactive.
- Writes to CSRs that disable counters (e.g. mcountinhibit) now take effect
  before the next instruction instead of on the current instruction.
- Behavior for Privileged Version 1.11 has been changed so that ECALL and EBREAK
  instructions no longer count as retired (as specified in version 1.12), since
  this appears to be an omission from the 1.11 specification and not an
  intentional enhancement in version 1.12.
- Zfinx version 0.41 is implemented. This is identical to version 0.4 except
  that misa fields F, D and Q are hardwired to zero.
- CLIC behavior when Selective Hardware Vectoring is enabled has been modified
  to allow recovery from vertical traps.
- Triggers that cause exceptions now write xtval registers with any address
  causing the trigger, instead of the current program counter.
- A bug has been fixed in which TLB entry mappings were not correctly
  invalidated by hfence.gvma if those mappings were used for Guest page table
  walks.
- Decodes for Bit Manipulation instructions greviw, gorciw, sloiw, sroiw and 
  roriw have been corrected.
- New parameter PMP_decompose forces unaligned PMP accesses to be decomposed
  into separate aligned accesses.
- Scalar floating point fmin/fmax operations now execute successfully when the
  current rounding mode is illegal; previously, an Illegal Instruction
  exception was raised.
- Some Vector Extension issues have been corrected:
  - A bug in vfrec7.v when rounding to the maximum value has been fixed.
  - For whole-register load/store instructions, the memory layout has been
    corrected so that the lowest-numbered vector register is held in the 
    lowest-numbered memory addresses and successive vector register numbers are
    placed contiguously in memory

Date 2021-March-15
Release 20210312.0
===

- New parameter endianFixed forces mstatus.{MBE,SBE,UBE} to be read-only.
- Cryptographic extension is now implemented in the model with version defined
  using by parameter crypto_version (0.7.2, 0.8.1 or 0.9.0).
  - When enabled, parameters Zkb, Zkg, Zkr, Zknd, Zkne, Zknh, Zksed and Zksh
    allow the precise subset of supported instructions to be specified.
- Some Vector Extension issues have been corrected:
  - vmsbf.m, vmsif.m and vmsof.m no longer allow overlap of destination with 
    source or mask registers for vector version 0.9 and later.

Date 2021-February-26
Release 20210226.0
===
  
- Parameter Zfinx replaced with Zfinx_version (enabling support for different
  Zfinx versions in future). Currently, values "none" and "0.4" are implemented.

Date 2021-February-19
Release 20210218.0
===

- Some Vector Extension issues have been corrected:
  - whole-register load/store instructions now allow register counts of 2, 4 or
    8 in addition to 1 for vector versions 1.0-draft-20210130 and master.
- New parameter Zfinx enables option to reuse the integer register file for all
  floating point instructions.
- Behavior has changed so that mstatus.FS is writable if Supervisor mode is
  implemented and floating point is absent. The previous behavior may be
  obtained using parameter mstatus_FS_zero if required.

Date 2021-February-03
Release 20210202.0
===

- New optional reset_addr and nmi_addr nets allow addresses for reset and NMI
  exceptions to by asserted externally if required.
- Support for half-precision scalar floating point has been added, with format
  defined by parameter fp16_version.
- Access fault exceptions are now raised for misaligned LR/SC/AMO operations
  if a normal load or store using that address and access width would succeed;
  previously, such accesses caused address misaligned exceptions (see section
  "Physical Memory Attributes" in the RISC-V Privileged Architecture 
  specification).
- Bit-Manipulation Extension version 0.93 has been created. This differs from
  the previous 0.93-draft as follows:
  - exchange encodings of max and minu instructions;
  - add xperm.[nbhw] instructions;
  - instructions named *u.w renamed to *.uw;
  - instructions named sb* renamed to b*;
  - instructions named pcnt* renamed to cpop*;
  - instructions subu.w, addiwu, addwu, subwu, clmulw, clmulrw and clmulhw
    removed.
  - instructions bext/bdep renamed to bcompress/bdecompress (this change is 
    documented under the draft 0.94 version but is required to resolve an 
    instruction name conflict introduced by instruction renames above).
- Bit-Manipulation Extension draft version 0.94 has been updated as follows:
  - instructions bset[i]w, bclr[i]w, binv[i]w and bextw removed.
- New vector version 1.0-draft-20210130 added.
  - V-commit 7cf5349: vle1.v and vse1.v instructions added.
  - V-commit 8bf26e8: vsetivli instruction added.

Date 2020-December-11
Release 20201209.0
===

- Default bit manipulation changed to v0.93
  - note this is not a released version and so is correct as of the snapshot date June 2020

Date 2020-November-13
Release 20201113.0
===

- The vector version master branch currently has these additional differences
  compared to the previous 0.9 version:
  - V-commit 511d0b8: ordered/unordered indexed vector memory instructions
    added.

Date 2020-November-04
Release 20201103.0
===

- Some Vector Extension issues have been corrected:
  - whole-register move instructions now respect the current setting of vstart
    (elements with index < vstart are not modified).
- The vector version master branch has these additional differences compared to
  the previous 0.9 version:
  - V-commit 579fef9: vsetvli x0, x0, imm instruction is reserved if it would
    cause vl to change.
- New parameter vill_trap can be used to specify that illegal updates to the
  vtype register cause an Illegal Instruction trap instead of setting 
  vtype.vill=1.

- changes to the included intercept libraries, exitControl, customControl and signatureDump,
  to clean the available functionality.
  -exitControl
     - can finish simulation on execution of terminate() or write_to_host()
     - can finish simulation on the execution of a specified opcode
     - can finish simulation at a specified symbol or address
     - can detect pass/fail status in register on ecall
  - customControl
     - provides character stream on custom instruction
     - will finish simulation on execution of _test_exit()
  -signatureDump
     - provides signature dump at end of simulation or on execution of write_to_host()
     - includes new SignatureGranularity parameter to select 4 or 16 byte line size
     - can detect pass/fail status in register on ecall and when enabled will also 
       finish simulation on execution of terminate() or write_to_host()
  
Date 2020-September-23
Release 20201021.0
===

- The trigger module has been partially implemented - see variant-specific 
  documentation.
- Some Vector Extension issues have been corrected:
  - vfslide1up.vf and vfslide1down.vf now correctly detect illegal floating
    point SEW.

Date 2020-September-21
Release 20200918.0
===

- Hypervisor mode is now implemented.
- Debug mode step breakpoint is now implemented as an interrupt before the
  start of the next instruction.
- Some Vector Extension issues have been corrected:
  - For vector version 0.8, instruction vid.v v0, v0.m is now legal; previously,
    an Illegal Instruction was generated. This has no effect for vector version
    0.9 and later.
- The vector version master branch currently has these differences compared to
  the previous 0.9 version:
  - V-commit d35b23f: Instructions vfrsqrte7.v and vfrece7.v added with 
    defined implementations.

Date 2020-July-23
Release 20200722.0
===

- Vector Extension
  - V-commit b8cd98b: CSR vtype format changed to make vlmul bits contiguous.

Date 2020-July-21
Release 20200720.0
===

- First release of Imperas Instruction Functional Coverage engine to provide
  coverage of RISC-V Compliance Test Suites.
- mintstatus, sintstatus and uintstatus CSRs have been reassigned to addresses
  0x346, 0x146 and 0x046, respectively.
- The vector version master branch currently has these differences compared to
  the previous 0.9 version:
  - V-commit a679250: instruction vrgatherei16.vv added.

Date 2020-July-09
Release 20200708.0
===

- Reads of instret and cycle CSRs now exclude the current instruction from the
  reported count.
- The vector version master branch currently has these differences compared to
  the previous 0.9 version:
  - V-commit 7facdcc: SLEN=VLEN register layout is mandatory;
  - V-commit b454810: ELEN>VLEN is now supported for LMUL>1;
  - V-commit 20f673c: Whole register moves and load/stores now have element size
    hints;
  - V-commit d35b23f: Instructions vfrsqrte7.v and vfrece7.v added, with 
    candidate implementations (precise behavior is not yet defined).

Date 2020-June-30
Release 20200629.0
===

- Vector Extension
  - behavior of vslidedown.vx and vslidedown.vi with a slide of 0 when source
    and destination vector registers are the same has been corrected.

Date 2020-June-22
Release 20200619.0
===

- Vector Extension
  - sstatus.VS field alias has been implemented in its new position (from
    specification version 0.9).

Date 2020-June-17
Release 20200616.0
===

- Core-Local Interrupt Controller (CLIC)
  - address for xintthresh CSRs have been changed to 0xm47 (previously 0xm4A)
- Vector Extension
  - Checking of overlap of vector registers for vector indexed segment loads and
    stores has been corrected.

Date 2020-June-09
Release 20200608.0
===

- The Bit-Manipulation Extension is now implemented in the model, with version
  defined by parameter bitmanip_version.
- Some Vector Extension issues have been corrected:
  - Parameter order shown by disassembly of vector AMO instructions has been
    corrected. Model behavior is not affected by this change.
  - Encodings of integer extension instructions have been corrected for Vector
    Extension version 0.9.
- The vector version master branch currently has these differences compared to
  the previous 0.9 version:
  - V-commit 443ce5b: overlap constraints for different source/destination EEW
    changed.

Date 2020-May-27
Release 20200526.0
===

- Memory accesses that straddle PMP region boundaries are now disallowed for
  M-mode, even if those regions imply full M-mode access.

Date 2020-May-22
Release 20200521.0
===

- Memory accesses that straddle PMP region boundaries are now disallowed.
- EBREAK now sets tval to 0 if priv_version is set to master.
- Some Vector Extension issues have been corrected:
  - Encodings of VFUNARY0/VFUNARY1 instructions have been corrected for Vector
    Extension version 0.9.
  - Alignment of vector register groups when explicit EEW is being used has been
    corrected for Vector Extension version 0.9.

Date 2020-May-19
Release 20200518.0
===

- EBREAK and ECALL no longer count as retired instructions if priv_version
  is set to master.
- SC instruction behavior has been changed so that store address alignment is
  validated even if the reservation check fails (previously, alignment was
  validated only if the reservation check succeeded).
- Masking of the mcountinhibit CSR has been corrected - previously, bit 1 and
  bits 63...32 were writeable when they should have been 0.
- The nmi signal has been corrected to match the documented behavior, execution
  resumes at the nmi_address parameter value when the nmi signal goes high
- The optional Core-Local Interrupt Controller (CLIC) has been implemented
  (version 0.9-draft-20191208).
- Vector version 0.9 has been added, and is now used by default. Differences
  compared to the previous 0.8 version are as follows (with the associated
  specification V-commit identifiers):
  - V-commit bdb8b55: mstatus.VS and sstatus.VS fields have moved to bits 10:9;
  - V-commit b25b643: new CSR vcsr has been added and fields VXSAT and VXRM
    fields relocated there from CSR fcsr;
  - V-commit 951b64f: mirrors of fcsr fields have been removed from vcsr.
  - V-commit 1aceea2: vfslide1up.vf and vfslide1down.vf instructions added.
  - V-commit e256d65: vfcvt.rtz.xu.f.v, vfcvt.rtz.x.f.v, vfwcvt.rtz.xu.f.v,
    vfwcvt.rtz.x.f.v, vfncvt.rtz.xu.f.v and vfncvt.rtz.x.f.v instructions added;
  - V-commit 8a9fbce (and others): fractional LMUL support added, controlled by
    an extended vtype.vlmul CSR field;
  - V-commit f414f4d (and others): vector tail agnostic and vector mask agnostic
    fields added to the vtype CSR;
  - V-commit a526fb9 (and others): all vector load/store instructions replaced
    with new instructions that explicitly encode EEW of data or index;
  - V-commit ef531ea: whole register load and store operation encodings changed;
  - V-commit bdc85cd: vzext.vf2, vsext.vf2, vzext.vf4, vsext.vf4, vzext.vf8 and
     vsext.vf8 instructions added;
  - V-commit 9a77e12: MLEN is always 1.
- Some Vector Extension issues have been corrected:
  - Instructions vfmv.s.f and vfmv.f.s now require that SEW is a supported
    floating point size (pending vector specification clarification).

Date 2020-March-31
Release 20200330.0
===

- The priority order for handling simultaneous interrupts destined for the
  same privilege level has been corrected (previously, these were handled so
  that higher interrupt numbers were higher priority).
- Some Vector Extension issues have been corrected:
  - All vector floating point instructions now generate Illegal Instruction
    exceptions if the current rounding mode is invalid, even if those
    instructions do not use the rounding mode.

Date 2020-March-13
Release 20200312.0
===

- Support for Debug mode has been added; see RISCV processor documentation for
  more details.
- The priv_version parameter now includes a choice of 'master', which specifies
  that the evolving 1.12 Privileged Architecture Specification should be used.
  This has the following changes compared to the ratified 1.11 version:
  - MRET and SRET instruction clear mstatus.MPRV when leaving M-mode;
  - For RV32, a new mstatush CSR has been added;
  - Data endian is now configurable using UBE, SBE and MBE fields in mstatus
    and the new mstatush CSR.
- New parameter SEW_min has been added to specify the minimum SEW supported when
  the Vector Extension is implemented; the default is 8 bits.
- When the Vector Extension is implemented, the maximum VLEN value supported
  has increased from 2048 to 65536 bits.
- Some Vector Extension issues have been corrected:
  - Behavior of vslidedown has been corrected in cases when vl<vlmax. Previously
    elements where source element i satisfied vl<=i+offset were being zeroed;
    now, elements where source element i satisfies vlmax<=i+offset are zeroed.
- Some Vector Extension specification changes have been implemented:
  - V-commit 951b64f: Mirrors of fcsr fields have been removed from vcsr.
  - V-commit 45da90d: segment loads and stores have been restricted to SEW
    element size only.

Date 2020-February-19
Release 20200218.0
===

---

- Some Vector Extension issues have been corrected:
  - Behavior of vmv.x.s and vfmv.f.s has been corrected when vstart>=vl so that
    the result register is correctly updated (previously it was left unchanged 
    in this case).
  - Behavior of whole-register operations when vtype.vill=1 has been corrected
    (these instructions should execute even when vtype.vill=1).
  - Behavior of vid.v has been corrected when vstart!=0.

Date 2020-February-13
Release 20200212.0
===

- Some details of CSR access behavior have been corrected:
  - For Vector Extension version 0.8, access to vxsat and vxrm now requires both
    mstatus.FS and mstatus.VS to be non-zero; previously, only non-zero
    mstatus.FS was required. Note that from Vector Extension version 0.9
    onwards, only mstatus.VS is required because these two fields are now
    aliased in the new vcsr CSR instead of the fcsr CSR.
- An issue has been fixed in which an incorrect exception was raised on an
  access error during a page table walk.
- Some Vector Extension issues have been corrected:
  - Behavior of vpopc.m and vfirst.m has been corrected when vl==0.
  - Executing vsetvl/vsetvli instructions now sets vector state to dirty.
  - Behavior of whole-register operations when vstart!=0 has been corrected.
  - Vector indexed segment load instructions now raise an Illegal Instruction
    if the destination vector register overlaps either source or mask.
  - Decodes for vqmaccus and vqmaccsu instructions have been exchanged to match
    the specification
  - Implementations of vmv.s.x, vfmv.f.s and vfmv.s.f have been corrected to
    prevent Illegal Instruction exceptions being reported for odd-numbered
    vector registers for non-zero LMUL. These instructions should ignore LMUL.
  - Instruction vfmv.s.f has been corrected to validate that the argument is
    NaN-boxed when required.
- The vector version master branch currently has these differences compared to
  the previous 0.8 version:
  - V-commit bdb8b55: mstatus.VS and sstatus.VS fields have moved to bits 10:9;
  - V-commit b25b643: new CSR vcsr has been added and fields VXSAT and VXRM
    fields relocated there from CSR fcsr

Date 2020-February-06
Release 20200206.0
===

- Bit Manipulation Extension
  - Corrected sign extension for addwu, subwu, addiwu and slliu.w that were 
    incorrectly changed in the last fix.

- Command line argument 'memory' is modified so that permissions argument is required
  and uses the characters rR, wW and xX for read, write and execute.


Date 2020-January-21
Release 20200120.0
===

- Fix the vector version (0.7.1-draft-20190605) selected by Vector example scripts
  to match the cross compiler toolchain used to build the ELF files executed.

- Fixed memory argument so that more than two memory regions can be added 

Date 2020-January-17
Release 20200116.0
===

- Some Vector Extension issues have been corrected:
  - V-commit b9fd7c9: For vector versions 0.8-draft-20190906 and later, vmv.s.x
    and vmv.x.s now sign extend their operands if required (previously, they
    were zero extended)

Date 2020-January-15
Release 20200114.0
===

- Some Vector Extension issues have been corrected:
  - An issue has been corrected that caused a simulator error in blocks with
    some variants of vsetvl/vsetvli instructions.

Date 2020-January-10
Release 20200110.0
===

- Bit Manipulation Extension
  - Added sign extension for *w instructions on 64-bit processors.

- Command line argument 'memory' allows regions of memory to be defined using
  a string of form "low:high:permission"
  for example
     -memory 0x0000:0xffff:7 -memory 0xffff0000:0xffffffff:7
  or, as a comma separated list
     -memory 0x0000:0xffff:7,0xffff0000:0xffffffff:7
  both create two memory regions with read, write and execute permissions.
  The permissions field is optional, the default is RWX, if defined the
  bits signify 1:Read, 2:Write, 3:eXecute permission for the memory region. 
 
- V-commit f4056da: Encodings for vwmaccsu and vwmaccus instruction variants
  have been changed in 0.8-draft-20191004 and all subsequent versions to comply
  with a specification change of September 17th 2019.

Date 2019-December-18
Release 20191217.0
===

- Vector version 0.8 has been added, and is now used by default. Differences
  compared to the previous 0.8-draft-20191118 version are as follows (with the
  associated specification V-commit identifiers):
  - V-commit a6f94e7: vector context status in mstatus register is now
    implemented;
  - V-commit 49cbd95: whole register load and store operations have been
    restricted to a single register only;
  - V-commit 49cbd95: whole register move operations have been restricted to
    aligned groups of 1, 2, 4 or 8 registers only.
- The vector version master branch currently has no differences compared to
  the previous 0.8 version, but will change as the specification evolves.

Date 2019-December-09
Release 20191206.0
===

- Some Vector Extension issues have been corrected:
  - vfmne behavior has been corrected to return 1 for unordered operands
    (previously, 0 was returned).

Date 2019-November-29
Release 20191128.0
===

- New parameter require_vstart0 has been added to control whether
  non-interruptible Vector Extension instructions require CSR vstart to be zero.
- Some Vector Extension issues have been corrected:
  - An issue has been corrected that caused some variants of AMO instructions
    discarding the operation result to cause Illegal Instruction exceptions
    incorrectly.
  - Reduction operations with destination overlapping a source are now legal
    when LMUL>1; previously, such operations caused Illegal Instruction
    exceptions.

Date 2019-November-26
Release 20191126.0
===

- Bit Manipulation Extension has been updated to Version 0.92
- The vector version master branch currently has these differences compared to
  the previous 0.8-draft-20191118 version:
  - V-commit a6f94e7: vector context status in mstatus register is now
    implemented;
  - V-commit 49cbd95: whole register load and store operations have been
    restricted to a single register only;
  - V-commit 49cbd95: whole register move operations have been restricted to
    aligned groups of 1, 2, 4 or 8 registers only.
  This set of changes will increase as the master specification evolves.

Date 2019-November-25
Release 20191122.0
===

- Memory exceptions now produce information about the failure in verbose mode.
- Vector version 0.8-draft-20190906 has been added. The only difference between
  this version and the stable 0.8-draft-20191004 version is the encodings of
  vwsmaccsu and vwsmaccus instruction variants.
- Vector version 0.8-draft-20191117 has been added. Differences to the previous
  0.8-draft-20191004 version are as follows (with the associated specification
  V-commit identifiers):
  - V-commit 8d4492e: Indexed load/store instructions now zero extend offsets
    (in version 0.8-draft-20191004, they are sign-extended);
  - V-commit d06438e: vslide1up/vslide1down instructions now sign extend XLEN
    values to SEW length (in version 0.8-draft-20191004, they are
    zero-extended);
  - V-commit 5a038da: vadc/vsbc instruction encodings now require vm=0 (in 
    version 0.8-draft-20191004, they require vm=1);
  - V-commit 5a038da: vmadc/vmsbc instruction encodings now allow both vm=0,
    implying carry input is used, and vm=1, implying carry input is zero (in
    version 0.8-draft-20191004, only vm=1 is permitted implying carry input is
    used);
  - V-commit c2f3157: vaaddu.vv, vaaddu.vx, vasubu.vv and vasubu.vx
    instructions have been added;
  - V-commit c2f3157: vaadd.vv and vaadd.vx, instruction encodings have been
    changed;
  - V-commit c2f3157: vaadd.vi instruction has been removed;
  - V-commit 063b128: all widening saturating scaled multiply-add instructions
    have been removed;
  - V-commit 200a557: vqmaccu.vv, vqmaccu.vx, vqmacc.vv, vqmacc.vx, vqmacc.vx, 
    vqmaccsu.vx and vqmaccus.vx instructions have been added;
  - V-commit 7b02297: CSR vlenb has been added (giving vector register length
    in bytes);
  - V-commit 7b02297: load/store whole register instructions have been added;
  - V-commit 7b02297: whole register move instructions have been added.
- Vector version 0.8-draft-20191118 has been added. Differences to the previous
  0.8-draft-20191117 version are as follows (with the associated specification
  V-commit identifiers):
  - V-commit b6c48c3: vsetvl/vsetvli with rd!=zero and rs1=zero sets vl to the
    maximum vector length (previously, this combination preserved vl).
- The vector_version master branch is currently identical to the stable
  0.8-draft-20191118 version, but will change as the master specification
  evolves.

Date 2019-November-19
Release 20191119.0
===

- Some Vector Extension issues have been corrected:
  - Behavior of vnclipu.wi and vnclip.wi instructions has been corrected
  - Behavior of some polymorphic instructions when vl=0 has been corrected

Date 2019-November-14
Release 20191114.0
===

- Some Vector Extension issues have been corrected:
  - Behavior of vsetvl instruction on RV64 base has been corrected
  - Vector AMO operations for memory element bits less than 32 now cause Illegal
    Instruction exceptions.
  - Alignment required for vector AMO operations accessing 32-bit data is now
    four bytes - previously, eight-byte alignment was required for SEW=64.
  - Encodings for vwsmaccsu and vwsmaccus instruction variants has been changed
    in 0.8-draft-20191004 and master versions to comply with a specification
    change of September 17th 2019.
- Vector version 0.8-draft-20190906 has been added. The only difference between
  this version and the stable 0.8-draft-20191004 version is the encodings of
  vwsmaccsu and vwsmaccus instruction variants.
- The vector_version master branch currently has the following changes compared
  to the stable 0.8-draft-20191004 version:
  - Indexed load/store instructions now zero extend offsets (in version
    0.8-draft-20191004, they are sign-extended);
  - vslide1up/vslide1down instructions now sign extend XLEN values to SEW length
    (in version 0.8-draft-20191004, they are zero-extended);
  - vadc/vsbc instruction encodings now require vm=0 (in version
    0.8-draft-20191004, they require vm=1);
  - vmadc/vmsbc instruction encodings now allow both vm=0, implying carry input
    is used, and vm=1, implying carry input is zero (in version
    0.8-draft-20191004, only vm=1 is permitted implying carry input is used).
  This set of changes will increase as the master specification evolves.

Date 2019-November-04
Release 20191104.0
===
- Behavior for fault-only-first vector segment load instructions has been corrected.
- Behavior for vector atomic operations with 32-bit memory element width has been corrected.
- Behavior for vector register gather operations when index>=VL and index<=VLMAX has been corrected.
- Vector atomic operations with SEW greater than XLEN now cause an Illegal Instruction exception.

Date 2019-October-09
Release 20191009.0
===
- The model has a new parameter vector_version which can be used to select
  either the stable 0.7.1 Vector Extension (the default) or the unstable master
  branch. The master branch currently has the following changes compared to the
  stable 0.7.1 branch:
  - behavior of vsetvl and vsetvli instructions when rs1 = x0 preserves the
    current vl instead of selecting the maximum possible vl.
  - tail vector and scalar elements are preserved, not zeroed.
  - vext.s.v, vmford.vv and vmford.vf instructions have been removed;
  - encodings for vfmv.f.s, vfmv.s.f, vmv.s.x, vpopc.m, vfirst.m, vmsbf.m, 
    vmsif.m, vmsof.m, viota.m and vid.v instructions have changed;
  - overlap constraints for slideup and slidedown instructions have been relaxed
    to allow overlap of destination and mask when SEW=1.
  - 64-bit vector AMO operations have been replaced with SEW-width vector AMO
    operations.
  - The double-width source vector register group for narrowing operations is
    now signified by a 'w' in the source operand suffix. Previously, a 'v' was
    used.
  - Instruction vfncvt.rod.f.f.w has been added (to allow narrowing floating
    point conversions with jamming semantics).
  This set of changes will increase as the master specification evolves.
- Default semihosting has been changed to use the ecall and ebreak instruction
  as the interception point for the host to implement the system call. This
  uses the same set of syscall numbers which are defined as part of the proxy
  kernel library for newlib.

Date 2019-Sept-23
Release 20190923.0
===
- The model has a new parameter vector_version which can be used to select
  either the stable 0.7.1 Vector Extension (the default) or the unstable master
  branch. The master branch currently has the following changes compared to the
  stable 0.7.1 branch:
  - behavior of vsetvl and vsetvli instructions when rs1 = x0 preserves the
    current vl instead of selecting the maximum possible vl.
  - tail vector and scalar elements are preserved, not zeroed.
  - vext.s.v and vmford.vv instructions have been removed;
  - vmv.s.x instruction has been added;
  - encodings for vpopc.m, vfirst.m, vmsbf.m, vmsif.m, vmsof.m, viota.m and
    vid.v instructions have changed;
  - overlap constraints for slideup and slidedown instructions have been relaxed
    to allow overlap of destination and mask when SEW=1.
  - 64-bit vector AMO operations have been replaced with SEW-width vector AMO
    operations.
  This set of changes will increase as the master specification evolves.
- Some vector extension issues have been corrected:
  - Behavior of vsetvl and vsetvli instructions when requested vector size
    exceeds the implementation limits has been corrected.
  - Two decodes for non-existent vector compare instructions have been removed.
  - The constraint on legal LMUL for segmented load/store operations has been
    changed from requiring LMUL=1 to requiring LMUL*NFIELDS<=8. This corresponds
    to a specification change made on 2019-June-06.
  - decodes for instructions which only exist in unmasked form have been
    changed so that the vm field in the instruction must be 1 (previously, this
    bit was treated as a don't-care).
  - instruction disassembly has been improved for 'move' instructions (this
    change does not affect model behavior).
  - A bug has been fixed which caused an error when an attempt was made to
    execute floating point instructions with a scalar argument and with SLEN
    less than 32.
  - A bug has been fixed which caused narrowing floating point/integer type
    conversion instructions targeting integer types to raise illegal instruction
    exceptions when the current SEW is smaller than the smallest supported
    floating point SEW. These instructions should be legal when SEW*2 is the
    smallest supported floating point SEW and SEW is legal for integer types.
- Enhancements to the B Extensions to include the instructions as part of the
  v0.91 specification, also added a parameter for version selection, currently
  v0.90 and v 0.91. The default will always be the later specification
- A bug has been fixed which caused some instructions that update the fcsr 
  register not to also update mstatus.FS when required.
- Parameter "fs_always_dirty" has been removed; new parameter "mstatus_fs_mode"
  has been added to allow the conditions under which mstatus.FS is set to Dirty
  to be specified more precisely. See processor variant documentation for a
  detailed description of the available options.
- A fix has been made to the cmix instruction so it no longer writes the t0 
  register. Note this is not in the base model, but in the extB prototype bit 
  manipulation extension library.
- New functions to support modeling Transactional Memory features in an 
  extension library have been added to the enhanced model support call backs in 
  the base model. 
- Corrected memory sizing in the riscvOVPsim fixed platform to use address 
  range specified by argument addressbits.
- Fixed bug when using new vmi_IMULSU operation.
- Bug fixed which could cause incorrect results for floating point round or 
  convert to unsigned operations when non-vmi_FPR_CURRENT rounding modes are
  used in general arithmetic operations, as per RISC-V.
- A bug was fixed that could cause incorrect behavior when PMP region mappings
  change.

Date 2019-June-28
Release 20190628.0
===

- Fixed bug that caused the Model Specific Documentation for the SiFive 
  U54MC model to be missing the sections under Overview.
- The vector extension is now implemented and enabled if the V bit is set in
  the misa register. Variants RV32GCV and RV64GCV have been added which enable
  this extension as standard. See the processor documentation for these variants
  for more information.
- New parameter 'add_Extensions' can be used to specify extensions to add to a
  base variant, by misa letter. For example, value "VD" specifies that vector
  and double-precision floating point extensions should be added.
- New parameter 'add_Extensions_mask' can be used to specify that bits in the
  misa register should be writable, by letter. For example, value "VD" specifies
  that vector and double-precision floating point extensions can be dynamically
  enabled.
- Newlib semihost library for RiscV processors now support the naming convention 
  for defining the start of the heap that is used by the linker scripts in
  the BSPs provided in the SiFive freedom-e-sdk.
- Semihosting of the _sbrk() function will now report an error if it is called 
  and cannot find the expected symbol that defines the start of the heap area.
- The Model Specific Information document for each variant now includes 
  information on the extensions that are supported by the model but not enabled 
  on the specific variant being documented. 
- Various changes have been made to implement conformance with Privileged
  Architecture specification 20190405-Priv-MSU-Ratification, as follows:
  - The priority order of synchronous exceptions has been modified;
  - A new parameter, xret_preserves_lr, allows specification that xRET
    instructions should preserve the current value of LR (if False, LR is
    cleared by these instructions);
  - Behavior of misa and xepc registers on systems with variable IALIGN has been
    changed to match the specification;
  - misa.I is now writable if the write mask permits it. misa.E is read only and
    always the complement of misa.I;
  - The mcountinhibit CSR has been implemented.
- Various changes have been made to implement conformance with Base Architecture
  specification 20190303-User-Ratification, as follows:
  - A new parameter, unalignedAMO, controls whether AMO instructions support
    unaligned addresses. LR/SC instructions now never support unaligned
    addresses.
  - RV32E may now be used in conjunction with other extensions. misa.E is now
    always a read-only complement of misa.I.
- The SFENCE.VMA instruction is now only supported if Supervisor mode is
  implemented.
- When Privileged Level version 1.11 is enabled (see the priv_version parameter)
  mstatus.TW is now writable if any Privilege Level other than Machine mode is
  implemented. When Privileged Level version 1.10 is enabled, this field is
  writable only if Supervisor mode is implemented.
- A bug has been fixed which caused PMP privileges to be incorrectly set in some
  cases (where a high priority unlocked region was disabled and covered the same
  address range as a lower priority locked region).
- The model has been simplified to use the built-in VMI RMM rounding mode
  support.

Date 2019-March-06
Release 20190306.0
===
- Relaxed the fence instruction for finer grain as per specification of values
  for imm[11:0], rs1 and rd fields
- The model now supports save and restore.
- Field mstatus.MPP has been changed from WLRL to WARL in accordance with
  version 1.11 of the Privileged Specification). When written with an illegal
  value, the previous legal value is preserved.
- RMM rounding mode is now fully implemented for all operations.
- A bug has been fixed in which some floating point convert operations were not
  causing Illegal Instruction exceptions when rounding modes 5 and 6 were
  specified in the instruction.
- A bug has been fixed which could cause permissions for locked PMP regions to
  be ignored in Machine mode in some cases.
- A bug has been fixed which would prevent instruction access faults being
  raised in some circumstances for instructions that straddle PMP region
  boundaries.
- A new parameter PMP_grain allows the grain size (G) of PMP regions to be
  specified. For example, a value of 3 indicates that the smallest implemented
  PMP region size is 32 bytes.

Date 2018-November-14
Release 20181114.0
===
- A bug has been fixed which allowed User mode accesses to unimplemented
  hardware performance registers irrespective of the settings in the counter
  enable registers.
- Instruction address misaligned faults are now taken on the branch or jump
  instruction instead of the target instruction.
- A bug has been fixed in which RV64 instructions like sraiw with shifts >= 32
  bits (e.g. sraiw a2,a2,0x20) did not cause an exception.
- A bug has been fixed in which compressed instructions with shifts >= 32 bits
  (e.g. srai a2,a2,0x20) did not cause an exception when RV64I is absent or
  disabled.
- Decode for compressed instructions c.addi4spn, c.addi16sp, c.lui, c.jr,
  c.addiw, c.lwsp and c.ldsp has been corrected to properly handle reserved
  cases.
- A bug has been fixed in which the source value of fmv.s instructions was not
  being checked as NaN-boxed.
- A bug has been fixed which caused sedeleg and sideleg registers to be present
  when user-level interrupts were present and supervisor mode was absent. These
  registers should be present only if both supervisor mode and user-level
  interrupts are present.

Date 2018-August-03
Release 20180716.2
===

Date 2018-July-16
Release 20180716.0
===
- The RISCV processor model has been changed to set the default initial PC at 
  simulation start to the value indicated by the processor model's reset_address
  parameter. Previously the default start address was 0x0.
  NOTE: The --startaddress command line argument or the start address from an 
  ELF file that is loaded will override this value.
  NOTE: The default value for the reset_address can vary by variant, since this
  is defined to be an implementation dependent value by the RISCV specification.
  See the Model Specific Information document to see what value is implemented 
  for a specific variant.
  
Date 2018-March-12
Release 20180221.1
===

Date 2018-February-21
Release 20180221.0
===
- The model has been extensively rewritten to implement privilege levels and
  state consistent with Privileged Architecture version 1.10, including virtual
  memory and physical memory protection registers.

Date 2017-September-19
Release 20170919.0
===
This is the first release of the RISC-V models. There is a generic
model that implements the RISC-V ISA variants and there are vendor specific
cores.

To see the available processor models use:
    iss.exe --showlibraryprocessors
and to see the specific variants these contain use:
    iss.exe --showvariants --processorname riscv

Date 2017-May-12
Release 20170511.0
===
- The model supporting variants RV32G, RV32I, RV64G and RV64I is released.

Date 2017-February-01
Release 20170201.0
===
