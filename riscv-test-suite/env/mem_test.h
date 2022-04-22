

#define mseccfg         0x747

#define OK              0x00000000
#define FAILED          0x0000000F

#define MODE_M          0x00000010
#define MODE_S          0x00000020
#define MODE_U          0x00000030

#define ACCESS_X        0x00000100
#define ACCESS_W        0x00000200
#define ACCESS_R        0x00000300


////////////////////////////////////////////////////////////////////////////////
// DEFINE PMP ENTRY OF GIVEN BASE AND SIZE
////////////////////////////////////////////////////////////////////////////////

#define PMP_ENTRY_NA(_BASE, _SIZE)  (((_BASE) + ((_SIZE)/2) - 1) >> 2)

#define PMP_CFG(_L, _MODE, _PRIV)   (((_L)<<7) + ((_MODE)<<3) + (_PRIV))

#ifdef RVMODEL_ASSERT        
        #define ASSERT_WRITE_STR(_SP, _STR)     RVMODEL_IO_WRITE_STR(_SP, _STR)
#else
        #define ASSERT_WRITE_STR(_SP, _STR) 
#endif

.align 4

defaultMScratch:
        .fill 16, 8, 0

defaultSScratch:
        .fill 16, 8, 0

defaultVSScratch:
        .fill 16, 8, 0

defaultUScratch:
        .fill 16, 8, 0

////////////////////////////////////////////////////////////////////////////////
// SETUP_*HANDLER <base>, <scratch>: set exception handler address and
// scratch area address for exception taken to each mode (destroys t0)
////////////////////////////////////////////////////////////////////////////////

.macro SETUP_M_HANDLER _BASE=defaultMHandler, _SCRATCH=defaultMScratch
        la          t0, \_BASE
        csrw        mtvec, t0
        la          t0, \_SCRATCH
        csrw        mscratch, t0
.endm

.macro SETUP_S_HANDLER _BASE=defaultSHandler, _SCRATCH=defaultSScratch
        la          t0, \_BASE
        csrw        stvec, t0
        la          t0, \_SCRATCH
        csrw        sscratch, t0
.endm

.macro SETUP_VS_HANDLER _BASE=defaultVSHandler, _SCRATCH=defaultVSScratch
        la          t0, \_BASE
        csrw        vstvec, t0
        la          t0, \_SCRATCH
        csrw        vsscratch, t0
.endm

.macro SETUP_U_HANDLER _BASE=defaultUHandler, _SCRATCH=defaultUScratch
        la          t0, \_BASE
        csrw        utvec, t0
        la          t0, \_SCRATCH
        csrw        uscratch, t0
.endm




.macro APPLY_S_Q _TGT

        // set mstatus.MPP=1 (return to Supervisor mode)
        li          t0, 1<<11
        csrs        mstatus, t0

        // set resume address
        la          t0, \_TGT
        csrw        mepc, t0

        // get resume address on mode switch return
        la          s8, 100f

        // return to switch mode
        mret
100:
.endm


.macro APPLY_U_Q _TGT

        // set mstatus.MPP=0 (return to User mode)
        li          t0, 1<<11
        csrc        mstatus, t0

        // set resume address
        la          t0, \_TGT
        csrw        mepc, t0

        // get resume address on mode switch return
        la          s8, 100f

        // return to switch mode
        mret
100:
.endm


#define TEST_ACCESS_X(_NUM, _REGION, _MODE) \
        li          s7, 0; \
        call  mapped##_REGION; \
        li t2, (_NUM << 24)|(_REGION << 16) | ACCESS_X|_MODE; \
        or t2, t2, s7; \
        sw t2, 0(s4); \
        addi s4, s4, 4;

#define TEST_ACCESS_W(_NUM, _REGION, _MODE) \
        li          s7, 0; \
        la          a6, mapped##_REGION; \
        li    t0, 0x00018082; \
        sw    t0, 0(a6); \
        nop; \
        li t2, (_NUM << 24)|(_REGION << 16) | ACCESS_W|_MODE; \
        or t2, t2, s7; \
        sw t2, 0(s4); \
        addi s4, s4, 4;

#define TEST_ACCESS_R(_NUM, _REGION, _MODE) \
        li          s7, 0; \
        la          a6, mapped##_REGION; \
        lw    t0, 0(a6); \
        nop; \
        li t2, (_NUM << 24)|(_REGION << 16) | ACCESS_R|_MODE; \
        or t2, t2, s7; \
        sw t2, 0(s4); \
        addi s4, s4, 4;

.balign 64

customHandler:
        li          s7, 10
        csrr        t1, mcause
                                     
        // handle ecall-from-U instruction (code 0x8)
        li          t0, CAUSE_USER_ECALL
        bne         t1, t0, 1f
        
        call           write_tohost

        // special code: resume in Machine mode
        jr          s8

1:      // handle ecall-from-S instruction (code 0x9)
        li          t0, CAUSE_SUPERVISOR_ECALL
        bne         t1, t0, 1f

        call           write_tohost

        // special code: resume in Machine mode
        jr          s8

1:      li          t0, CAUSE_MACHINE_ECALL
        bne         t1, t0, 1f

        call           write_tohost

        // handle fault type
1:      li          t0, 1
        bne         t1, t0, 1f


        // instruction access fault: resume at ra
        //li          s7, 0x02
        csrw        mepc, ra
        j           2f

        // data access fault / mode switch : skip faulting instruction
1:      
        //li          s7, 0x03
        csrr        t0, mepc
        addi        t0, t0, 4
        csrw        mepc, t0

        // set failure code
2:      
        csrr        s7, mcause 

        mret