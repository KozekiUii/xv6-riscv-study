
kernel/kernel：     文件格式 elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	0000b117          	auipc	sp,0xb
    80000004:	80010113          	addi	sp,sp,-2048 # 8000a800 <stack0>
    80000008:	6505                	lui	a0,0x1
    8000000a:	f14025f3          	csrr	a1,mhartid
    8000000e:	0585                	addi	a1,a1,1
    80000010:	02b50533          	mul	a0,a0,a1
    80000014:	912a                	add	sp,sp,a0
    80000016:	076000ef          	jal	8000008c <start>

000000008000001a <junk>:
    8000001a:	a001                	j	8000001a <junk>

000000008000001c <timerinit>:
// which arrive at timervec in kernelvec.S,
// which turns them into software interrupts for
// devintr() in trap.c.
void
timerinit()
{
    8000001c:	1141                	addi	sp,sp,-16
    8000001e:	e406                	sd	ra,8(sp)
    80000020:	e022                	sd	s0,0(sp)
    80000022:	0800                	addi	s0,sp,16
// which hart (core) is this?
static inline uint64
r_mhartid()
{
  uint64 x;
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    80000024:	f14027f3          	csrr	a5,mhartid
  // each CPU has a separate source of timer interrupts.
  int id = r_mhartid();
    80000028:	2781                	sext.w	a5,a5

  // ask the CLINT for a timer interrupt.
  int interval = 1000000; // cycles; about 1/10th second in qemu.
  *(uint64*)CLINT_MTIMECMP(id) = *(uint64*)CLINT_MTIME + interval;
    8000002a:	0037969b          	slliw	a3,a5,0x3
    8000002e:	02004737          	lui	a4,0x2004
    80000032:	96ba                	add	a3,a3,a4
    80000034:	0200c737          	lui	a4,0x200c
    80000038:	ff873603          	ld	a2,-8(a4) # 200bff8 <_entry-0x7dff4008>
    8000003c:	000f4737          	lui	a4,0xf4
    80000040:	24070713          	addi	a4,a4,576 # f4240 <_entry-0x7ff0bdc0>
    80000044:	963a                	add	a2,a2,a4
    80000046:	e290                	sd	a2,0(a3)

  // prepare information in scratch[] for timervec.
  // scratch[0..3] : space for timervec to save registers.
  // scratch[4] : address of CLINT MTIMECMP register.
  // scratch[5] : desired interval (in cycles) between timer interrupts.
  uint64 *scratch = &mscratch0[32 * id];
    80000048:	0057979b          	slliw	a5,a5,0x5
    8000004c:	078e                	slli	a5,a5,0x3
    8000004e:	0000a617          	auipc	a2,0xa
    80000052:	fb260613          	addi	a2,a2,-78 # 8000a000 <mscratch0>
    80000056:	97b2                	add	a5,a5,a2
  scratch[4] = CLINT_MTIMECMP(id);
    80000058:	f394                	sd	a3,32(a5)
  scratch[5] = interval;
    8000005a:	f798                	sd	a4,40(a5)
}

static inline void 
w_mscratch(uint64 x)
{
  asm volatile("csrw mscratch, %0" : : "r" (x));
    8000005c:	34079073          	csrw	mscratch,a5
  asm volatile("csrw mtvec, %0" : : "r" (x));
    80000060:	00006797          	auipc	a5,0x6
    80000064:	ec078793          	addi	a5,a5,-320 # 80005f20 <timervec>
    80000068:	30579073          	csrw	mtvec,a5
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    8000006c:	300027f3          	csrr	a5,mstatus

  // set the machine-mode trap handler.
  w_mtvec((uint64)timervec);

  // enable machine-mode interrupts.
  w_mstatus(r_mstatus() | MSTATUS_MIE);
    80000070:	0087e793          	ori	a5,a5,8
  asm volatile("csrw mstatus, %0" : : "r" (x));
    80000074:	30079073          	csrw	mstatus,a5
  asm volatile("csrr %0, mie" : "=r" (x) );
    80000078:	304027f3          	csrr	a5,mie

  // enable machine-mode timer interrupts.
  w_mie(r_mie() | MIE_MTIE);
    8000007c:	0807e793          	ori	a5,a5,128
  asm volatile("csrw mie, %0" : : "r" (x));
    80000080:	30479073          	csrw	mie,a5
}
    80000084:	60a2                	ld	ra,8(sp)
    80000086:	6402                	ld	s0,0(sp)
    80000088:	0141                	addi	sp,sp,16
    8000008a:	8082                	ret

000000008000008c <start>:
{
    8000008c:	1141                	addi	sp,sp,-16
    8000008e:	e406                	sd	ra,8(sp)
    80000090:	e022                	sd	s0,0(sp)
    80000092:	0800                	addi	s0,sp,16
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    80000094:	300027f3          	csrr	a5,mstatus
  x &= ~MSTATUS_MPP_MASK;
    80000098:	7779                	lui	a4,0xffffe
    8000009a:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7ffd67a3>
    8000009e:	8ff9                	and	a5,a5,a4
  x |= MSTATUS_MPP_S;
    800000a0:	6705                	lui	a4,0x1
    800000a2:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    800000a6:	8fd9                	or	a5,a5,a4
  asm volatile("csrw mstatus, %0" : : "r" (x));
    800000a8:	30079073          	csrw	mstatus,a5
  asm volatile("csrw mepc, %0" : : "r" (x));
    800000ac:	00001797          	auipc	a5,0x1
    800000b0:	ece78793          	addi	a5,a5,-306 # 80000f7a <main>
    800000b4:	34179073          	csrw	mepc,a5
  asm volatile("csrw satp, %0" : : "r" (x));
    800000b8:	4781                	li	a5,0
    800000ba:	18079073          	csrw	satp,a5
  asm volatile("csrw medeleg, %0" : : "r" (x));
    800000be:	67c1                	lui	a5,0x10
    800000c0:	17fd                	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    800000c2:	30279073          	csrw	medeleg,a5
  asm volatile("csrw mideleg, %0" : : "r" (x));
    800000c6:	30379073          	csrw	mideleg,a5
  asm volatile("csrr %0, sie" : "=r" (x) );
    800000ca:	104027f3          	csrr	a5,sie
  w_sie(r_sie() | SIE_SEIE | SIE_STIE | SIE_SSIE);
    800000ce:	2227e793          	ori	a5,a5,546
  asm volatile("csrw sie, %0" : : "r" (x));
    800000d2:	10479073          	csrw	sie,a5
  timerinit();
    800000d6:	00000097          	auipc	ra,0x0
    800000da:	f46080e7          	jalr	-186(ra) # 8000001c <timerinit>
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    800000de:	f14027f3          	csrr	a5,mhartid
  w_tp(id);
    800000e2:	2781                	sext.w	a5,a5
}

static inline void 
w_tp(uint64 x)
{
  asm volatile("mv tp, %0" : : "r" (x));
    800000e4:	823e                	mv	tp,a5
  asm volatile("mret");
    800000e6:	30200073          	mret
}
    800000ea:	60a2                	ld	ra,8(sp)
    800000ec:	6402                	ld	s0,0(sp)
    800000ee:	0141                	addi	sp,sp,16
    800000f0:	8082                	ret

00000000800000f2 <consoleread>:
// user_dist indicates whether dst is a user
// or kernel address.
//
int
consoleread(struct file *f, int user_dst, uint64 dst, int n)
{
    800000f2:	711d                	addi	sp,sp,-96
    800000f4:	ec86                	sd	ra,88(sp)
    800000f6:	e8a2                	sd	s0,80(sp)
    800000f8:	e4a6                	sd	s1,72(sp)
    800000fa:	e0ca                	sd	s2,64(sp)
    800000fc:	fc4e                	sd	s3,56(sp)
    800000fe:	f852                	sd	s4,48(sp)
    80000100:	f05a                	sd	s6,32(sp)
    80000102:	ec5e                	sd	s7,24(sp)
    80000104:	1080                	addi	s0,sp,96
    80000106:	8b2e                	mv	s6,a1
    80000108:	8a32                	mv	s4,a2
    8000010a:	89b6                	mv	s3,a3
  uint target;
  int c;
  char cbuf;

  target = n;
    8000010c:	8bb6                	mv	s7,a3
  acquire(&cons.lock);
    8000010e:	00012517          	auipc	a0,0x12
    80000112:	6f250513          	addi	a0,a0,1778 # 80012800 <cons>
    80000116:	00001097          	auipc	ra,0x1
    8000011a:	9ee080e7          	jalr	-1554(ra) # 80000b04 <acquire>
  while(n > 0){
    // wait until interrupt handler has put some
    // input into cons.buffer.
    while(cons.r == cons.w){
    8000011e:	00012497          	auipc	s1,0x12
    80000122:	6e248493          	addi	s1,s1,1762 # 80012800 <cons>
      if(myproc()->killed){
        release(&cons.lock);
        return -1;
      }
      sleep(&cons.r, &cons.lock);
    80000126:	00012917          	auipc	s2,0x12
    8000012a:	77a90913          	addi	s2,s2,1914 # 800128a0 <cons+0xa0>
  while(n > 0){
    8000012e:	0d305263          	blez	s3,800001f2 <consoleread+0x100>
    while(cons.r == cons.w){
    80000132:	0a04a783          	lw	a5,160(s1)
    80000136:	0a44a703          	lw	a4,164(s1)
    8000013a:	0af71763          	bne	a4,a5,800001e8 <consoleread+0xf6>
      if(myproc()->killed){
    8000013e:	00002097          	auipc	ra,0x2
    80000142:	9c2080e7          	jalr	-1598(ra) # 80001b00 <myproc>
    80000146:	5d1c                	lw	a5,56(a0)
    80000148:	e7ad                	bnez	a5,800001b2 <consoleread+0xc0>
      sleep(&cons.r, &cons.lock);
    8000014a:	85a6                	mv	a1,s1
    8000014c:	854a                	mv	a0,s2
    8000014e:	00002097          	auipc	ra,0x2
    80000152:	176080e7          	jalr	374(ra) # 800022c4 <sleep>
    while(cons.r == cons.w){
    80000156:	0a04a783          	lw	a5,160(s1)
    8000015a:	0a44a703          	lw	a4,164(s1)
    8000015e:	fef700e3          	beq	a4,a5,8000013e <consoleread+0x4c>
    80000162:	f456                	sd	s5,40(sp)
    }

    c = cons.buf[cons.r++ % INPUT_BUF];
    80000164:	00012717          	auipc	a4,0x12
    80000168:	69c70713          	addi	a4,a4,1692 # 80012800 <cons>
    8000016c:	0017869b          	addiw	a3,a5,1
    80000170:	0ad72023          	sw	a3,160(a4)
    80000174:	07f7f693          	andi	a3,a5,127
    80000178:	9736                	add	a4,a4,a3
    8000017a:	02074703          	lbu	a4,32(a4)
    8000017e:	00070a9b          	sext.w	s5,a4

    if(c == C('D')){  // end-of-file
    80000182:	4691                	li	a3,4
    80000184:	04da8a63          	beq	s5,a3,800001d8 <consoleread+0xe6>
      }
      break;
    }

    // copy the input byte to the user-space buffer.
    cbuf = c;
    80000188:	fae407a3          	sb	a4,-81(s0)
    if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
    8000018c:	4685                	li	a3,1
    8000018e:	faf40613          	addi	a2,s0,-81
    80000192:	85d2                	mv	a1,s4
    80000194:	855a                	mv	a0,s6
    80000196:	00002097          	auipc	ra,0x2
    8000019a:	382080e7          	jalr	898(ra) # 80002518 <either_copyout>
    8000019e:	57fd                	li	a5,-1
    800001a0:	04f50863          	beq	a0,a5,800001f0 <consoleread+0xfe>
      break;

    dst++;
    800001a4:	0a05                	addi	s4,s4,1
    --n;
    800001a6:	39fd                	addiw	s3,s3,-1

    if(c == '\n'){
    800001a8:	47a9                	li	a5,10
    800001aa:	04fa8f63          	beq	s5,a5,80000208 <consoleread+0x116>
    800001ae:	7aa2                	ld	s5,40(sp)
    800001b0:	bfbd                	j	8000012e <consoleread+0x3c>
        release(&cons.lock);
    800001b2:	00012517          	auipc	a0,0x12
    800001b6:	64e50513          	addi	a0,a0,1614 # 80012800 <cons>
    800001ba:	00001097          	auipc	ra,0x1
    800001be:	a0e080e7          	jalr	-1522(ra) # 80000bc8 <release>
        return -1;
    800001c2:	557d                	li	a0,-1
    }
  }
  release(&cons.lock);

  return target - n;
}
    800001c4:	60e6                	ld	ra,88(sp)
    800001c6:	6446                	ld	s0,80(sp)
    800001c8:	64a6                	ld	s1,72(sp)
    800001ca:	6906                	ld	s2,64(sp)
    800001cc:	79e2                	ld	s3,56(sp)
    800001ce:	7a42                	ld	s4,48(sp)
    800001d0:	7b02                	ld	s6,32(sp)
    800001d2:	6be2                	ld	s7,24(sp)
    800001d4:	6125                	addi	sp,sp,96
    800001d6:	8082                	ret
      if(n < target){
    800001d8:	0179fa63          	bgeu	s3,s7,800001ec <consoleread+0xfa>
        cons.r--;
    800001dc:	00012717          	auipc	a4,0x12
    800001e0:	6cf72223          	sw	a5,1732(a4) # 800128a0 <cons+0xa0>
    800001e4:	7aa2                	ld	s5,40(sp)
    800001e6:	a031                	j	800001f2 <consoleread+0x100>
    800001e8:	f456                	sd	s5,40(sp)
    800001ea:	bfad                	j	80000164 <consoleread+0x72>
    800001ec:	7aa2                	ld	s5,40(sp)
    800001ee:	a011                	j	800001f2 <consoleread+0x100>
    800001f0:	7aa2                	ld	s5,40(sp)
  release(&cons.lock);
    800001f2:	00012517          	auipc	a0,0x12
    800001f6:	60e50513          	addi	a0,a0,1550 # 80012800 <cons>
    800001fa:	00001097          	auipc	ra,0x1
    800001fe:	9ce080e7          	jalr	-1586(ra) # 80000bc8 <release>
  return target - n;
    80000202:	413b853b          	subw	a0,s7,s3
    80000206:	bf7d                	j	800001c4 <consoleread+0xd2>
    80000208:	7aa2                	ld	s5,40(sp)
    8000020a:	b7e5                	j	800001f2 <consoleread+0x100>

000000008000020c <consputc>:
  if(panicked){
    8000020c:	00028797          	auipc	a5,0x28
    80000210:	e147a783          	lw	a5,-492(a5) # 80028020 <panicked>
    80000214:	c391                	beqz	a5,80000218 <consputc+0xc>
    for(;;)
    80000216:	a001                	j	80000216 <consputc+0xa>
{
    80000218:	1141                	addi	sp,sp,-16
    8000021a:	e406                	sd	ra,8(sp)
    8000021c:	e022                	sd	s0,0(sp)
    8000021e:	0800                	addi	s0,sp,16
  if(c == BACKSPACE){
    80000220:	10000793          	li	a5,256
    80000224:	00f50a63          	beq	a0,a5,80000238 <consputc+0x2c>
    uartputc(c);
    80000228:	00000097          	auipc	ra,0x0
    8000022c:	61a080e7          	jalr	1562(ra) # 80000842 <uartputc>
}
    80000230:	60a2                	ld	ra,8(sp)
    80000232:	6402                	ld	s0,0(sp)
    80000234:	0141                	addi	sp,sp,16
    80000236:	8082                	ret
    uartputc('\b'); uartputc(' '); uartputc('\b');
    80000238:	4521                	li	a0,8
    8000023a:	00000097          	auipc	ra,0x0
    8000023e:	608080e7          	jalr	1544(ra) # 80000842 <uartputc>
    80000242:	02000513          	li	a0,32
    80000246:	00000097          	auipc	ra,0x0
    8000024a:	5fc080e7          	jalr	1532(ra) # 80000842 <uartputc>
    8000024e:	4521                	li	a0,8
    80000250:	00000097          	auipc	ra,0x0
    80000254:	5f2080e7          	jalr	1522(ra) # 80000842 <uartputc>
    80000258:	bfe1                	j	80000230 <consputc+0x24>

000000008000025a <consolewrite>:
{
    8000025a:	711d                	addi	sp,sp,-96
    8000025c:	ec86                	sd	ra,88(sp)
    8000025e:	e8a2                	sd	s0,80(sp)
    80000260:	e4a6                	sd	s1,72(sp)
    80000262:	e0ca                	sd	s2,64(sp)
    80000264:	ec5e                	sd	s7,24(sp)
    80000266:	1080                	addi	s0,sp,96
    80000268:	892e                	mv	s2,a1
    8000026a:	84b2                	mv	s1,a2
    8000026c:	8bb6                	mv	s7,a3
  acquire(&cons.lock);
    8000026e:	00012517          	auipc	a0,0x12
    80000272:	59250513          	addi	a0,a0,1426 # 80012800 <cons>
    80000276:	00001097          	auipc	ra,0x1
    8000027a:	88e080e7          	jalr	-1906(ra) # 80000b04 <acquire>
  for(i = 0; i < n; i++){
    8000027e:	05705863          	blez	s7,800002ce <consolewrite+0x74>
    80000282:	fc4e                	sd	s3,56(sp)
    80000284:	f852                	sd	s4,48(sp)
    80000286:	f456                	sd	s5,40(sp)
    80000288:	f05a                	sd	s6,32(sp)
    8000028a:	009b8b33          	add	s6,s7,s1
    if(either_copyin(&c, user_src, src+i, 1) == -1)
    8000028e:	faf40a93          	addi	s5,s0,-81
    80000292:	4a05                	li	s4,1
    80000294:	59fd                	li	s3,-1
    80000296:	86d2                	mv	a3,s4
    80000298:	8626                	mv	a2,s1
    8000029a:	85ca                	mv	a1,s2
    8000029c:	8556                	mv	a0,s5
    8000029e:	00002097          	auipc	ra,0x2
    800002a2:	2d0080e7          	jalr	720(ra) # 8000256e <either_copyin>
    800002a6:	03350063          	beq	a0,s3,800002c6 <consolewrite+0x6c>
    consputc(c);
    800002aa:	faf44503          	lbu	a0,-81(s0)
    800002ae:	00000097          	auipc	ra,0x0
    800002b2:	f5e080e7          	jalr	-162(ra) # 8000020c <consputc>
  for(i = 0; i < n; i++){
    800002b6:	0485                	addi	s1,s1,1
    800002b8:	fd649fe3          	bne	s1,s6,80000296 <consolewrite+0x3c>
    800002bc:	79e2                	ld	s3,56(sp)
    800002be:	7a42                	ld	s4,48(sp)
    800002c0:	7aa2                	ld	s5,40(sp)
    800002c2:	7b02                	ld	s6,32(sp)
    800002c4:	a029                	j	800002ce <consolewrite+0x74>
    800002c6:	79e2                	ld	s3,56(sp)
    800002c8:	7a42                	ld	s4,48(sp)
    800002ca:	7aa2                	ld	s5,40(sp)
    800002cc:	7b02                	ld	s6,32(sp)
  release(&cons.lock);
    800002ce:	00012517          	auipc	a0,0x12
    800002d2:	53250513          	addi	a0,a0,1330 # 80012800 <cons>
    800002d6:	00001097          	auipc	ra,0x1
    800002da:	8f2080e7          	jalr	-1806(ra) # 80000bc8 <release>
}
    800002de:	855e                	mv	a0,s7
    800002e0:	60e6                	ld	ra,88(sp)
    800002e2:	6446                	ld	s0,80(sp)
    800002e4:	64a6                	ld	s1,72(sp)
    800002e6:	6906                	ld	s2,64(sp)
    800002e8:	6be2                	ld	s7,24(sp)
    800002ea:	6125                	addi	sp,sp,96
    800002ec:	8082                	ret

00000000800002ee <consoleintr>:
// do erase/kill processing, append to cons.buf,
// wake up consoleread() if a whole line has arrived.
//
void
consoleintr(int c)
{
    800002ee:	1101                	addi	sp,sp,-32
    800002f0:	ec06                	sd	ra,24(sp)
    800002f2:	e822                	sd	s0,16(sp)
    800002f4:	e426                	sd	s1,8(sp)
    800002f6:	1000                	addi	s0,sp,32
    800002f8:	84aa                	mv	s1,a0
  acquire(&cons.lock);
    800002fa:	00012517          	auipc	a0,0x12
    800002fe:	50650513          	addi	a0,a0,1286 # 80012800 <cons>
    80000302:	00001097          	auipc	ra,0x1
    80000306:	802080e7          	jalr	-2046(ra) # 80000b04 <acquire>

  switch(c){
    8000030a:	47d5                	li	a5,21
    8000030c:	0af48263          	beq	s1,a5,800003b0 <consoleintr+0xc2>
    80000310:	0297c963          	blt	a5,s1,80000342 <consoleintr+0x54>
    80000314:	47a1                	li	a5,8
    80000316:	0ef48963          	beq	s1,a5,80000408 <consoleintr+0x11a>
    8000031a:	47c1                	li	a5,16
    8000031c:	10f49c63          	bne	s1,a5,80000434 <consoleintr+0x146>
  case C('P'):  // Print process list.
    procdump();
    80000320:	00002097          	auipc	ra,0x2
    80000324:	2a4080e7          	jalr	676(ra) # 800025c4 <procdump>
      }
    }
    break;
  }
  
  release(&cons.lock);
    80000328:	00012517          	auipc	a0,0x12
    8000032c:	4d850513          	addi	a0,a0,1240 # 80012800 <cons>
    80000330:	00001097          	auipc	ra,0x1
    80000334:	898080e7          	jalr	-1896(ra) # 80000bc8 <release>
}
    80000338:	60e2                	ld	ra,24(sp)
    8000033a:	6442                	ld	s0,16(sp)
    8000033c:	64a2                	ld	s1,8(sp)
    8000033e:	6105                	addi	sp,sp,32
    80000340:	8082                	ret
  switch(c){
    80000342:	07f00793          	li	a5,127
    80000346:	0cf48163          	beq	s1,a5,80000408 <consoleintr+0x11a>
    if(c != 0 && cons.e-cons.r < INPUT_BUF){
    8000034a:	00012717          	auipc	a4,0x12
    8000034e:	4b670713          	addi	a4,a4,1206 # 80012800 <cons>
    80000352:	0a872783          	lw	a5,168(a4)
    80000356:	0a072703          	lw	a4,160(a4)
    8000035a:	9f99                	subw	a5,a5,a4
    8000035c:	07f00713          	li	a4,127
    80000360:	fcf764e3          	bltu	a4,a5,80000328 <consoleintr+0x3a>
      c = (c == '\r') ? '\n' : c;
    80000364:	47b5                	li	a5,13
    80000366:	0cf48a63          	beq	s1,a5,8000043a <consoleintr+0x14c>
      consputc(c);
    8000036a:	8526                	mv	a0,s1
    8000036c:	00000097          	auipc	ra,0x0
    80000370:	ea0080e7          	jalr	-352(ra) # 8000020c <consputc>
      cons.buf[cons.e++ % INPUT_BUF] = c;
    80000374:	00012717          	auipc	a4,0x12
    80000378:	48c70713          	addi	a4,a4,1164 # 80012800 <cons>
    8000037c:	0a872683          	lw	a3,168(a4)
    80000380:	0016879b          	addiw	a5,a3,1
    80000384:	863e                	mv	a2,a5
    80000386:	0af72423          	sw	a5,168(a4)
    8000038a:	07f6f693          	andi	a3,a3,127
    8000038e:	9736                	add	a4,a4,a3
    80000390:	02970023          	sb	s1,32(a4)
      if(c == '\n' || c == C('D') || cons.e == cons.r+INPUT_BUF){
    80000394:	ff648713          	addi	a4,s1,-10
    80000398:	c779                	beqz	a4,80000466 <consoleintr+0x178>
    8000039a:	14f1                	addi	s1,s1,-4
    8000039c:	c4e9                	beqz	s1,80000466 <consoleintr+0x178>
    8000039e:	00012797          	auipc	a5,0x12
    800003a2:	5027a783          	lw	a5,1282(a5) # 800128a0 <cons+0xa0>
    800003a6:	0807879b          	addiw	a5,a5,128
    800003aa:	f6f61fe3          	bne	a2,a5,80000328 <consoleintr+0x3a>
    800003ae:	a865                	j	80000466 <consoleintr+0x178>
    800003b0:	e04a                	sd	s2,0(sp)
    while(cons.e != cons.w &&
    800003b2:	00012717          	auipc	a4,0x12
    800003b6:	44e70713          	addi	a4,a4,1102 # 80012800 <cons>
    800003ba:	0a872783          	lw	a5,168(a4)
    800003be:	0a472703          	lw	a4,164(a4)
          cons.buf[(cons.e-1) % INPUT_BUF] != '\n'){
    800003c2:	00012497          	auipc	s1,0x12
    800003c6:	43e48493          	addi	s1,s1,1086 # 80012800 <cons>
    while(cons.e != cons.w &&
    800003ca:	4929                	li	s2,10
    800003cc:	02f70a63          	beq	a4,a5,80000400 <consoleintr+0x112>
          cons.buf[(cons.e-1) % INPUT_BUF] != '\n'){
    800003d0:	37fd                	addiw	a5,a5,-1
    800003d2:	07f7f713          	andi	a4,a5,127
    800003d6:	9726                	add	a4,a4,s1
    while(cons.e != cons.w &&
    800003d8:	02074703          	lbu	a4,32(a4)
    800003dc:	03270463          	beq	a4,s2,80000404 <consoleintr+0x116>
      cons.e--;
    800003e0:	0af4a423          	sw	a5,168(s1)
      consputc(BACKSPACE);
    800003e4:	10000513          	li	a0,256
    800003e8:	00000097          	auipc	ra,0x0
    800003ec:	e24080e7          	jalr	-476(ra) # 8000020c <consputc>
    while(cons.e != cons.w &&
    800003f0:	0a84a783          	lw	a5,168(s1)
    800003f4:	0a44a703          	lw	a4,164(s1)
    800003f8:	fcf71ce3          	bne	a4,a5,800003d0 <consoleintr+0xe2>
    800003fc:	6902                	ld	s2,0(sp)
    800003fe:	b72d                	j	80000328 <consoleintr+0x3a>
    80000400:	6902                	ld	s2,0(sp)
    80000402:	b71d                	j	80000328 <consoleintr+0x3a>
    80000404:	6902                	ld	s2,0(sp)
    80000406:	b70d                	j	80000328 <consoleintr+0x3a>
    if(cons.e != cons.w){
    80000408:	00012717          	auipc	a4,0x12
    8000040c:	3f870713          	addi	a4,a4,1016 # 80012800 <cons>
    80000410:	0a872783          	lw	a5,168(a4)
    80000414:	0a472703          	lw	a4,164(a4)
    80000418:	f0f708e3          	beq	a4,a5,80000328 <consoleintr+0x3a>
      cons.e--;
    8000041c:	37fd                	addiw	a5,a5,-1
    8000041e:	00012717          	auipc	a4,0x12
    80000422:	48f72523          	sw	a5,1162(a4) # 800128a8 <cons+0xa8>
      consputc(BACKSPACE);
    80000426:	10000513          	li	a0,256
    8000042a:	00000097          	auipc	ra,0x0
    8000042e:	de2080e7          	jalr	-542(ra) # 8000020c <consputc>
    80000432:	bddd                	j	80000328 <consoleintr+0x3a>
    if(c != 0 && cons.e-cons.r < INPUT_BUF){
    80000434:	ee048ae3          	beqz	s1,80000328 <consoleintr+0x3a>
    80000438:	bf09                	j	8000034a <consoleintr+0x5c>
      consputc(c);
    8000043a:	4529                	li	a0,10
    8000043c:	00000097          	auipc	ra,0x0
    80000440:	dd0080e7          	jalr	-560(ra) # 8000020c <consputc>
      cons.buf[cons.e++ % INPUT_BUF] = c;
    80000444:	00012717          	auipc	a4,0x12
    80000448:	3bc70713          	addi	a4,a4,956 # 80012800 <cons>
    8000044c:	0a872683          	lw	a3,168(a4)
    80000450:	0016861b          	addiw	a2,a3,1
    80000454:	87b2                	mv	a5,a2
    80000456:	0ac72423          	sw	a2,168(a4)
    8000045a:	07f6f693          	andi	a3,a3,127
    8000045e:	9736                	add	a4,a4,a3
    80000460:	46a9                	li	a3,10
    80000462:	02d70023          	sb	a3,32(a4)
        cons.w = cons.e;
    80000466:	00012717          	auipc	a4,0x12
    8000046a:	42f72f23          	sw	a5,1086(a4) # 800128a4 <cons+0xa4>
        wakeup(&cons.r);
    8000046e:	00012517          	auipc	a0,0x12
    80000472:	43250513          	addi	a0,a0,1074 # 800128a0 <cons+0xa0>
    80000476:	00002097          	auipc	ra,0x2
    8000047a:	fc8080e7          	jalr	-56(ra) # 8000243e <wakeup>
    8000047e:	b56d                	j	80000328 <consoleintr+0x3a>

0000000080000480 <consoleinit>:

void
consoleinit(void)
{
    80000480:	1141                	addi	sp,sp,-16
    80000482:	e406                	sd	ra,8(sp)
    80000484:	e022                	sd	s0,0(sp)
    80000486:	0800                	addi	s0,sp,16
  initlock(&cons.lock, "cons");
    80000488:	00008597          	auipc	a1,0x8
    8000048c:	c9058593          	addi	a1,a1,-880 # 80008118 <userret+0x88>
    80000490:	00012517          	auipc	a0,0x12
    80000494:	37050513          	addi	a0,a0,880 # 80012800 <cons>
    80000498:	00000097          	auipc	ra,0x0
    8000049c:	598080e7          	jalr	1432(ra) # 80000a30 <initlock>

  uartinit();
    800004a0:	00000097          	auipc	ra,0x0
    800004a4:	360080e7          	jalr	864(ra) # 80000800 <uartinit>

  // connect read and write system calls
  // to consoleread and consolewrite.
  devsw[CONSOLE].read = consoleread;
    800004a8:	00020797          	auipc	a5,0x20
    800004ac:	bb878793          	addi	a5,a5,-1096 # 80020060 <devsw>
    800004b0:	00000717          	auipc	a4,0x0
    800004b4:	c4270713          	addi	a4,a4,-958 # 800000f2 <consoleread>
    800004b8:	eb98                	sd	a4,16(a5)
  devsw[CONSOLE].write = consolewrite;
    800004ba:	00000717          	auipc	a4,0x0
    800004be:	da070713          	addi	a4,a4,-608 # 8000025a <consolewrite>
    800004c2:	ef98                	sd	a4,24(a5)
}
    800004c4:	60a2                	ld	ra,8(sp)
    800004c6:	6402                	ld	s0,0(sp)
    800004c8:	0141                	addi	sp,sp,16
    800004ca:	8082                	ret

00000000800004cc <printint>:

static char digits[] = "0123456789abcdef";

static void
printint(int xx, int base, int sign)
{
    800004cc:	7179                	addi	sp,sp,-48
    800004ce:	f406                	sd	ra,40(sp)
    800004d0:	f022                	sd	s0,32(sp)
    800004d2:	e84a                	sd	s2,16(sp)
    800004d4:	1800                	addi	s0,sp,48
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
    800004d6:	c219                	beqz	a2,800004dc <printint+0x10>
    800004d8:	08054563          	bltz	a0,80000562 <printint+0x96>
    x = -xx;
  else
    x = xx;
    800004dc:	4301                	li	t1,0

  i = 0;
    800004de:	fd040913          	addi	s2,s0,-48
    x = xx;
    800004e2:	86ca                	mv	a3,s2
  i = 0;
    800004e4:	4701                	li	a4,0
  do {
    buf[i++] = digits[x % base];
    800004e6:	00009817          	auipc	a6,0x9
    800004ea:	85280813          	addi	a6,a6,-1966 # 80008d38 <digits>
    800004ee:	88ba                	mv	a7,a4
    800004f0:	0017061b          	addiw	a2,a4,1
    800004f4:	8732                	mv	a4,a2
    800004f6:	02b577bb          	remuw	a5,a0,a1
    800004fa:	1782                	slli	a5,a5,0x20
    800004fc:	9381                	srli	a5,a5,0x20
    800004fe:	97c2                	add	a5,a5,a6
    80000500:	0007c783          	lbu	a5,0(a5)
    80000504:	00f68023          	sb	a5,0(a3)
  } while((x /= base) != 0);
    80000508:	87aa                	mv	a5,a0
    8000050a:	02b5553b          	divuw	a0,a0,a1
    8000050e:	0685                	addi	a3,a3,1
    80000510:	fcb7ffe3          	bgeu	a5,a1,800004ee <printint+0x22>

  if(sign)
    80000514:	00030c63          	beqz	t1,8000052c <printint+0x60>
    buf[i++] = '-';
    80000518:	fe060793          	addi	a5,a2,-32
    8000051c:	00878633          	add	a2,a5,s0
    80000520:	02d00793          	li	a5,45
    80000524:	fef60823          	sb	a5,-16(a2)
    80000528:	0028871b          	addiw	a4,a7,2

  while(--i >= 0)
    8000052c:	02e05663          	blez	a4,80000558 <printint+0x8c>
    80000530:	ec26                	sd	s1,24(sp)
    80000532:	377d                	addiw	a4,a4,-1
    80000534:	00e904b3          	add	s1,s2,a4
    80000538:	197d                	addi	s2,s2,-1
    8000053a:	993a                	add	s2,s2,a4
    8000053c:	1702                	slli	a4,a4,0x20
    8000053e:	9301                	srli	a4,a4,0x20
    80000540:	40e90933          	sub	s2,s2,a4
    consputc(buf[i]);
    80000544:	0004c503          	lbu	a0,0(s1)
    80000548:	00000097          	auipc	ra,0x0
    8000054c:	cc4080e7          	jalr	-828(ra) # 8000020c <consputc>
  while(--i >= 0)
    80000550:	14fd                	addi	s1,s1,-1
    80000552:	ff2499e3          	bne	s1,s2,80000544 <printint+0x78>
    80000556:	64e2                	ld	s1,24(sp)
}
    80000558:	70a2                	ld	ra,40(sp)
    8000055a:	7402                	ld	s0,32(sp)
    8000055c:	6942                	ld	s2,16(sp)
    8000055e:	6145                	addi	sp,sp,48
    80000560:	8082                	ret
    x = -xx;
    80000562:	40a0053b          	negw	a0,a0
  if(sign && (sign = xx < 0))
    80000566:	4305                	li	t1,1
    x = -xx;
    80000568:	bf9d                	j	800004de <printint+0x12>

000000008000056a <panic>:
    release(&pr.lock);
}

void
panic(char *s)
{
    8000056a:	1101                	addi	sp,sp,-32
    8000056c:	ec06                	sd	ra,24(sp)
    8000056e:	e822                	sd	s0,16(sp)
    80000570:	e426                	sd	s1,8(sp)
    80000572:	1000                	addi	s0,sp,32
    80000574:	84aa                	mv	s1,a0
  pr.locking = 0;
    80000576:	00012797          	auipc	a5,0x12
    8000057a:	3407ad23          	sw	zero,858(a5) # 800128d0 <pr+0x20>
  printf("PANIC: ");
    8000057e:	00008517          	auipc	a0,0x8
    80000582:	ba250513          	addi	a0,a0,-1118 # 80008120 <userret+0x90>
    80000586:	00000097          	auipc	ra,0x0
    8000058a:	03e080e7          	jalr	62(ra) # 800005c4 <printf>
  printf(s);
    8000058e:	8526                	mv	a0,s1
    80000590:	00000097          	auipc	ra,0x0
    80000594:	034080e7          	jalr	52(ra) # 800005c4 <printf>
  printf("\n");
    80000598:	00008517          	auipc	a0,0x8
    8000059c:	b9050513          	addi	a0,a0,-1136 # 80008128 <userret+0x98>
    800005a0:	00000097          	auipc	ra,0x0
    800005a4:	024080e7          	jalr	36(ra) # 800005c4 <printf>
  printf("HINT: restart xv6 using 'make qemu-gdb', type 'b panic' (to set breakpoint in panic) in the gdb window, followed by 'c' (continue), and when the kernel hits the breakpoint, type 'bt' to get a backtrace\n");
    800005a8:	00008517          	auipc	a0,0x8
    800005ac:	b8850513          	addi	a0,a0,-1144 # 80008130 <userret+0xa0>
    800005b0:	00000097          	auipc	ra,0x0
    800005b4:	014080e7          	jalr	20(ra) # 800005c4 <printf>
  panicked = 1; // freeze other CPUs
    800005b8:	4785                	li	a5,1
    800005ba:	00028717          	auipc	a4,0x28
    800005be:	a6f72323          	sw	a5,-1434(a4) # 80028020 <panicked>
  for(;;)
    800005c2:	a001                	j	800005c2 <panic+0x58>

00000000800005c4 <printf>:
{
    800005c4:	7131                	addi	sp,sp,-192
    800005c6:	fc86                	sd	ra,120(sp)
    800005c8:	f8a2                	sd	s0,112(sp)
    800005ca:	e8d2                	sd	s4,80(sp)
    800005cc:	ec6e                	sd	s11,24(sp)
    800005ce:	0100                	addi	s0,sp,128
    800005d0:	8a2a                	mv	s4,a0
    800005d2:	e40c                	sd	a1,8(s0)
    800005d4:	e810                	sd	a2,16(s0)
    800005d6:	ec14                	sd	a3,24(s0)
    800005d8:	f018                	sd	a4,32(s0)
    800005da:	f41c                	sd	a5,40(s0)
    800005dc:	03043823          	sd	a6,48(s0)
    800005e0:	03143c23          	sd	a7,56(s0)
  locking = pr.locking;
    800005e4:	00012d97          	auipc	s11,0x12
    800005e8:	2ecdad83          	lw	s11,748(s11) # 800128d0 <pr+0x20>
  if(locking)
    800005ec:	040d9463          	bnez	s11,80000634 <printf+0x70>
  if (fmt == 0)
    800005f0:	040a0b63          	beqz	s4,80000646 <printf+0x82>
  va_start(ap, fmt);
    800005f4:	00840793          	addi	a5,s0,8
    800005f8:	f8f43423          	sd	a5,-120(s0)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    800005fc:	000a4503          	lbu	a0,0(s4)
    80000600:	18050c63          	beqz	a0,80000798 <printf+0x1d4>
    80000604:	f4a6                	sd	s1,104(sp)
    80000606:	f0ca                	sd	s2,96(sp)
    80000608:	ecce                	sd	s3,88(sp)
    8000060a:	e4d6                	sd	s5,72(sp)
    8000060c:	e0da                	sd	s6,64(sp)
    8000060e:	fc5e                	sd	s7,56(sp)
    80000610:	f862                	sd	s8,48(sp)
    80000612:	f466                	sd	s9,40(sp)
    80000614:	f06a                	sd	s10,32(sp)
    80000616:	4981                	li	s3,0
    if(c != '%'){
    80000618:	02500b13          	li	s6,37
    switch(c){
    8000061c:	07000b93          	li	s7,112
  consputc('x');
    80000620:	07800c93          	li	s9,120
    80000624:	4d41                	li	s10,16
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    80000626:	00008a97          	auipc	s5,0x8
    8000062a:	712a8a93          	addi	s5,s5,1810 # 80008d38 <digits>
    switch(c){
    8000062e:	07300c13          	li	s8,115
    80000632:	a0b9                	j	80000680 <printf+0xbc>
    acquire(&pr.lock);
    80000634:	00012517          	auipc	a0,0x12
    80000638:	27c50513          	addi	a0,a0,636 # 800128b0 <pr>
    8000063c:	00000097          	auipc	ra,0x0
    80000640:	4c8080e7          	jalr	1224(ra) # 80000b04 <acquire>
    80000644:	b775                	j	800005f0 <printf+0x2c>
    80000646:	f4a6                	sd	s1,104(sp)
    80000648:	f0ca                	sd	s2,96(sp)
    8000064a:	ecce                	sd	s3,88(sp)
    8000064c:	e4d6                	sd	s5,72(sp)
    8000064e:	e0da                	sd	s6,64(sp)
    80000650:	fc5e                	sd	s7,56(sp)
    80000652:	f862                	sd	s8,48(sp)
    80000654:	f466                	sd	s9,40(sp)
    80000656:	f06a                	sd	s10,32(sp)
    panic("null fmt");
    80000658:	00008517          	auipc	a0,0x8
    8000065c:	bb050513          	addi	a0,a0,-1104 # 80008208 <userret+0x178>
    80000660:	00000097          	auipc	ra,0x0
    80000664:	f0a080e7          	jalr	-246(ra) # 8000056a <panic>
      consputc(c);
    80000668:	00000097          	auipc	ra,0x0
    8000066c:	ba4080e7          	jalr	-1116(ra) # 8000020c <consputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    80000670:	0019879b          	addiw	a5,s3,1
    80000674:	89be                	mv	s3,a5
    80000676:	97d2                	add	a5,a5,s4
    80000678:	0007c503          	lbu	a0,0(a5)
    8000067c:	10050563          	beqz	a0,80000786 <printf+0x1c2>
    if(c != '%'){
    80000680:	ff6514e3          	bne	a0,s6,80000668 <printf+0xa4>
    c = fmt[++i] & 0xff;
    80000684:	0019879b          	addiw	a5,s3,1
    80000688:	89be                	mv	s3,a5
    8000068a:	97d2                	add	a5,a5,s4
    8000068c:	0007c783          	lbu	a5,0(a5)
    80000690:	0007849b          	sext.w	s1,a5
    if(c == 0)
    80000694:	10078a63          	beqz	a5,800007a8 <printf+0x1e4>
    switch(c){
    80000698:	05778a63          	beq	a5,s7,800006ec <printf+0x128>
    8000069c:	02fbf463          	bgeu	s7,a5,800006c4 <printf+0x100>
    800006a0:	09878763          	beq	a5,s8,8000072e <printf+0x16a>
    800006a4:	0d979663          	bne	a5,s9,80000770 <printf+0x1ac>
      printint(va_arg(ap, int), 16, 1);
    800006a8:	f8843783          	ld	a5,-120(s0)
    800006ac:	00878713          	addi	a4,a5,8
    800006b0:	f8e43423          	sd	a4,-120(s0)
    800006b4:	4605                	li	a2,1
    800006b6:	85ea                	mv	a1,s10
    800006b8:	4388                	lw	a0,0(a5)
    800006ba:	00000097          	auipc	ra,0x0
    800006be:	e12080e7          	jalr	-494(ra) # 800004cc <printint>
      break;
    800006c2:	b77d                	j	80000670 <printf+0xac>
    switch(c){
    800006c4:	0b678063          	beq	a5,s6,80000764 <printf+0x1a0>
    800006c8:	06400713          	li	a4,100
    800006cc:	0ae79263          	bne	a5,a4,80000770 <printf+0x1ac>
      printint(va_arg(ap, int), 10, 1);
    800006d0:	f8843783          	ld	a5,-120(s0)
    800006d4:	00878713          	addi	a4,a5,8
    800006d8:	f8e43423          	sd	a4,-120(s0)
    800006dc:	4605                	li	a2,1
    800006de:	45a9                	li	a1,10
    800006e0:	4388                	lw	a0,0(a5)
    800006e2:	00000097          	auipc	ra,0x0
    800006e6:	dea080e7          	jalr	-534(ra) # 800004cc <printint>
      break;
    800006ea:	b759                	j	80000670 <printf+0xac>
      printptr(va_arg(ap, uint64));
    800006ec:	f8843783          	ld	a5,-120(s0)
    800006f0:	00878713          	addi	a4,a5,8
    800006f4:	f8e43423          	sd	a4,-120(s0)
    800006f8:	0007b903          	ld	s2,0(a5)
  consputc('0');
    800006fc:	03000513          	li	a0,48
    80000700:	00000097          	auipc	ra,0x0
    80000704:	b0c080e7          	jalr	-1268(ra) # 8000020c <consputc>
  consputc('x');
    80000708:	8566                	mv	a0,s9
    8000070a:	00000097          	auipc	ra,0x0
    8000070e:	b02080e7          	jalr	-1278(ra) # 8000020c <consputc>
    80000712:	84ea                	mv	s1,s10
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    80000714:	03c95793          	srli	a5,s2,0x3c
    80000718:	97d6                	add	a5,a5,s5
    8000071a:	0007c503          	lbu	a0,0(a5)
    8000071e:	00000097          	auipc	ra,0x0
    80000722:	aee080e7          	jalr	-1298(ra) # 8000020c <consputc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    80000726:	0912                	slli	s2,s2,0x4
    80000728:	34fd                	addiw	s1,s1,-1
    8000072a:	f4ed                	bnez	s1,80000714 <printf+0x150>
    8000072c:	b791                	j	80000670 <printf+0xac>
      if((s = va_arg(ap, char*)) == 0)
    8000072e:	f8843783          	ld	a5,-120(s0)
    80000732:	00878713          	addi	a4,a5,8
    80000736:	f8e43423          	sd	a4,-120(s0)
    8000073a:	6384                	ld	s1,0(a5)
    8000073c:	cc89                	beqz	s1,80000756 <printf+0x192>
      for(; *s; s++)
    8000073e:	0004c503          	lbu	a0,0(s1)
    80000742:	d51d                	beqz	a0,80000670 <printf+0xac>
        consputc(*s);
    80000744:	00000097          	auipc	ra,0x0
    80000748:	ac8080e7          	jalr	-1336(ra) # 8000020c <consputc>
      for(; *s; s++)
    8000074c:	0485                	addi	s1,s1,1
    8000074e:	0004c503          	lbu	a0,0(s1)
    80000752:	f96d                	bnez	a0,80000744 <printf+0x180>
    80000754:	bf31                	j	80000670 <printf+0xac>
        s = "(null)";
    80000756:	00008497          	auipc	s1,0x8
    8000075a:	aaa48493          	addi	s1,s1,-1366 # 80008200 <userret+0x170>
      for(; *s; s++)
    8000075e:	02800513          	li	a0,40
    80000762:	b7cd                	j	80000744 <printf+0x180>
      consputc('%');
    80000764:	855a                	mv	a0,s6
    80000766:	00000097          	auipc	ra,0x0
    8000076a:	aa6080e7          	jalr	-1370(ra) # 8000020c <consputc>
      break;
    8000076e:	b709                	j	80000670 <printf+0xac>
      consputc('%');
    80000770:	855a                	mv	a0,s6
    80000772:	00000097          	auipc	ra,0x0
    80000776:	a9a080e7          	jalr	-1382(ra) # 8000020c <consputc>
      consputc(c);
    8000077a:	8526                	mv	a0,s1
    8000077c:	00000097          	auipc	ra,0x0
    80000780:	a90080e7          	jalr	-1392(ra) # 8000020c <consputc>
      break;
    80000784:	b5f5                	j	80000670 <printf+0xac>
    80000786:	74a6                	ld	s1,104(sp)
    80000788:	7906                	ld	s2,96(sp)
    8000078a:	69e6                	ld	s3,88(sp)
    8000078c:	6aa6                	ld	s5,72(sp)
    8000078e:	6b06                	ld	s6,64(sp)
    80000790:	7be2                	ld	s7,56(sp)
    80000792:	7c42                	ld	s8,48(sp)
    80000794:	7ca2                	ld	s9,40(sp)
    80000796:	7d02                	ld	s10,32(sp)
  if(locking)
    80000798:	020d9263          	bnez	s11,800007bc <printf+0x1f8>
}
    8000079c:	70e6                	ld	ra,120(sp)
    8000079e:	7446                	ld	s0,112(sp)
    800007a0:	6a46                	ld	s4,80(sp)
    800007a2:	6de2                	ld	s11,24(sp)
    800007a4:	6129                	addi	sp,sp,192
    800007a6:	8082                	ret
    800007a8:	74a6                	ld	s1,104(sp)
    800007aa:	7906                	ld	s2,96(sp)
    800007ac:	69e6                	ld	s3,88(sp)
    800007ae:	6aa6                	ld	s5,72(sp)
    800007b0:	6b06                	ld	s6,64(sp)
    800007b2:	7be2                	ld	s7,56(sp)
    800007b4:	7c42                	ld	s8,48(sp)
    800007b6:	7ca2                	ld	s9,40(sp)
    800007b8:	7d02                	ld	s10,32(sp)
    800007ba:	bff9                	j	80000798 <printf+0x1d4>
    release(&pr.lock);
    800007bc:	00012517          	auipc	a0,0x12
    800007c0:	0f450513          	addi	a0,a0,244 # 800128b0 <pr>
    800007c4:	00000097          	auipc	ra,0x0
    800007c8:	404080e7          	jalr	1028(ra) # 80000bc8 <release>
}
    800007cc:	bfc1                	j	8000079c <printf+0x1d8>

00000000800007ce <printfinit>:
    ;
}

void
printfinit(void)
{
    800007ce:	1141                	addi	sp,sp,-16
    800007d0:	e406                	sd	ra,8(sp)
    800007d2:	e022                	sd	s0,0(sp)
    800007d4:	0800                	addi	s0,sp,16
  initlock(&pr.lock, "pr");
    800007d6:	00008597          	auipc	a1,0x8
    800007da:	a4258593          	addi	a1,a1,-1470 # 80008218 <userret+0x188>
    800007de:	00012517          	auipc	a0,0x12
    800007e2:	0d250513          	addi	a0,a0,210 # 800128b0 <pr>
    800007e6:	00000097          	auipc	ra,0x0
    800007ea:	24a080e7          	jalr	586(ra) # 80000a30 <initlock>
  pr.locking = 1;
    800007ee:	4785                	li	a5,1
    800007f0:	00012717          	auipc	a4,0x12
    800007f4:	0ef72023          	sw	a5,224(a4) # 800128d0 <pr+0x20>
}
    800007f8:	60a2                	ld	ra,8(sp)
    800007fa:	6402                	ld	s0,0(sp)
    800007fc:	0141                	addi	sp,sp,16
    800007fe:	8082                	ret

0000000080000800 <uartinit>:
#define ReadReg(reg) (*(Reg(reg)))
#define WriteReg(reg, v) (*(Reg(reg)) = (v))

void
uartinit(void)
{
    80000800:	1141                	addi	sp,sp,-16
    80000802:	e406                	sd	ra,8(sp)
    80000804:	e022                	sd	s0,0(sp)
    80000806:	0800                	addi	s0,sp,16
  // disable interrupts.
  WriteReg(IER, 0x00);
    80000808:	100007b7          	lui	a5,0x10000
    8000080c:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>

  // special mode to set baud rate.
  WriteReg(LCR, 0x80);
    80000810:	10000737          	lui	a4,0x10000
    80000814:	f8000693          	li	a3,-128
    80000818:	00d701a3          	sb	a3,3(a4) # 10000003 <_entry-0x6ffffffd>

  // LSB for baud rate of 38.4K.
  WriteReg(0, 0x03);
    8000081c:	468d                	li	a3,3
    8000081e:	10000637          	lui	a2,0x10000
    80000822:	00d60023          	sb	a3,0(a2) # 10000000 <_entry-0x70000000>

  // MSB for baud rate of 38.4K.
  WriteReg(1, 0x00);
    80000826:	000780a3          	sb	zero,1(a5)

  // leave set-baud mode,
  // and set word length to 8 bits, no parity.
  WriteReg(LCR, 0x03);
    8000082a:	00d701a3          	sb	a3,3(a4)

  // reset and enable FIFOs.
  WriteReg(FCR, 0x07);
    8000082e:	469d                	li	a3,7
    80000830:	00d60123          	sb	a3,2(a2)

  // enable receive interrupts.
  WriteReg(IER, 0x01);
    80000834:	4705                	li	a4,1
    80000836:	00e780a3          	sb	a4,1(a5)
}
    8000083a:	60a2                	ld	ra,8(sp)
    8000083c:	6402                	ld	s0,0(sp)
    8000083e:	0141                	addi	sp,sp,16
    80000840:	8082                	ret

0000000080000842 <uartputc>:

// write one output character to the UART.
void
uartputc(int c)
{
    80000842:	1141                	addi	sp,sp,-16
    80000844:	e406                	sd	ra,8(sp)
    80000846:	e022                	sd	s0,0(sp)
    80000848:	0800                	addi	s0,sp,16
  // wait for Transmit Holding Empty to be set in LSR.
  while((ReadReg(LSR) & (1 << 5)) == 0)
    8000084a:	10000737          	lui	a4,0x10000
    8000084e:	0715                	addi	a4,a4,5 # 10000005 <_entry-0x6ffffffb>
    80000850:	00074783          	lbu	a5,0(a4)
    80000854:	0207f793          	andi	a5,a5,32
    80000858:	dfe5                	beqz	a5,80000850 <uartputc+0xe>
    ;
  WriteReg(THR, c);
    8000085a:	0ff57513          	zext.b	a0,a0
    8000085e:	100007b7          	lui	a5,0x10000
    80000862:	00a78023          	sb	a0,0(a5) # 10000000 <_entry-0x70000000>
}
    80000866:	60a2                	ld	ra,8(sp)
    80000868:	6402                	ld	s0,0(sp)
    8000086a:	0141                	addi	sp,sp,16
    8000086c:	8082                	ret

000000008000086e <uartgetc>:

// read one input character from the UART.
// return -1 if none is waiting.
int
uartgetc(void)
{
    8000086e:	1141                	addi	sp,sp,-16
    80000870:	e406                	sd	ra,8(sp)
    80000872:	e022                	sd	s0,0(sp)
    80000874:	0800                	addi	s0,sp,16
  if(ReadReg(LSR) & 0x01){
    80000876:	100007b7          	lui	a5,0x10000
    8000087a:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    8000087e:	8b85                	andi	a5,a5,1
    80000880:	cb89                	beqz	a5,80000892 <uartgetc+0x24>
    // input data is ready.
    return ReadReg(RHR);
    80000882:	100007b7          	lui	a5,0x10000
    80000886:	0007c503          	lbu	a0,0(a5) # 10000000 <_entry-0x70000000>
  } else {
    return -1;
  }
}
    8000088a:	60a2                	ld	ra,8(sp)
    8000088c:	6402                	ld	s0,0(sp)
    8000088e:	0141                	addi	sp,sp,16
    80000890:	8082                	ret
    return -1;
    80000892:	557d                	li	a0,-1
    80000894:	bfdd                	j	8000088a <uartgetc+0x1c>

0000000080000896 <uartintr>:

// trap.c calls here when the uart interrupts.
void
uartintr(void)
{
    80000896:	1101                	addi	sp,sp,-32
    80000898:	ec06                	sd	ra,24(sp)
    8000089a:	e822                	sd	s0,16(sp)
    8000089c:	e426                	sd	s1,8(sp)
    8000089e:	1000                	addi	s0,sp,32
  while(1){
    int c = uartgetc();
    if(c == -1)
    800008a0:	54fd                	li	s1,-1
    int c = uartgetc();
    800008a2:	00000097          	auipc	ra,0x0
    800008a6:	fcc080e7          	jalr	-52(ra) # 8000086e <uartgetc>
    if(c == -1)
    800008aa:	00950763          	beq	a0,s1,800008b8 <uartintr+0x22>
      break;
    consoleintr(c);
    800008ae:	00000097          	auipc	ra,0x0
    800008b2:	a40080e7          	jalr	-1472(ra) # 800002ee <consoleintr>
  while(1){
    800008b6:	b7f5                	j	800008a2 <uartintr+0xc>
  }
}
    800008b8:	60e2                	ld	ra,24(sp)
    800008ba:	6442                	ld	s0,16(sp)
    800008bc:	64a2                	ld	s1,8(sp)
    800008be:	6105                	addi	sp,sp,32
    800008c0:	8082                	ret

00000000800008c2 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(void *pa)
{
    800008c2:	1101                	addi	sp,sp,-32
    800008c4:	ec06                	sd	ra,24(sp)
    800008c6:	e822                	sd	s0,16(sp)
    800008c8:	e426                	sd	s1,8(sp)
    800008ca:	e04a                	sd	s2,0(sp)
    800008cc:	1000                	addi	s0,sp,32
  struct run *r;

  if(((uint64)pa % PGSIZE) != 0 || (char*)pa < end || (uint64)pa >= PHYSTOP)
    800008ce:	00027797          	auipc	a5,0x27
    800008d2:	78e78793          	addi	a5,a5,1934 # 8002805c <end>
    800008d6:	00f53733          	sltu	a4,a0,a5
    800008da:	47c5                	li	a5,17
    800008dc:	07ee                	slli	a5,a5,0x1b
    800008de:	17fd                	addi	a5,a5,-1
    800008e0:	00a7b7b3          	sltu	a5,a5,a0
    800008e4:	8fd9                	or	a5,a5,a4
    800008e6:	e7a1                	bnez	a5,8000092e <kfree+0x6c>
    800008e8:	84aa                	mv	s1,a0
    800008ea:	03451793          	slli	a5,a0,0x34
    800008ee:	e3a1                	bnez	a5,8000092e <kfree+0x6c>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(pa, 1, PGSIZE);
    800008f0:	6605                	lui	a2,0x1
    800008f2:	4585                	li	a1,1
    800008f4:	00000097          	auipc	ra,0x0
    800008f8:	4ca080e7          	jalr	1226(ra) # 80000dbe <memset>

  r = (struct run*)pa;

  acquire(&kmem.lock);
    800008fc:	00012917          	auipc	s2,0x12
    80000900:	fdc90913          	addi	s2,s2,-36 # 800128d8 <kmem>
    80000904:	854a                	mv	a0,s2
    80000906:	00000097          	auipc	ra,0x0
    8000090a:	1fe080e7          	jalr	510(ra) # 80000b04 <acquire>
  r->next = kmem.freelist;
    8000090e:	02093783          	ld	a5,32(s2)
    80000912:	e09c                	sd	a5,0(s1)
  kmem.freelist = r;
    80000914:	02993023          	sd	s1,32(s2)
  release(&kmem.lock);
    80000918:	854a                	mv	a0,s2
    8000091a:	00000097          	auipc	ra,0x0
    8000091e:	2ae080e7          	jalr	686(ra) # 80000bc8 <release>
}
    80000922:	60e2                	ld	ra,24(sp)
    80000924:	6442                	ld	s0,16(sp)
    80000926:	64a2                	ld	s1,8(sp)
    80000928:	6902                	ld	s2,0(sp)
    8000092a:	6105                	addi	sp,sp,32
    8000092c:	8082                	ret
    panic("kfree");
    8000092e:	00008517          	auipc	a0,0x8
    80000932:	8f250513          	addi	a0,a0,-1806 # 80008220 <userret+0x190>
    80000936:	00000097          	auipc	ra,0x0
    8000093a:	c34080e7          	jalr	-972(ra) # 8000056a <panic>

000000008000093e <freerange>:
{
    8000093e:	7179                	addi	sp,sp,-48
    80000940:	f406                	sd	ra,40(sp)
    80000942:	f022                	sd	s0,32(sp)
    80000944:	ec26                	sd	s1,24(sp)
    80000946:	1800                	addi	s0,sp,48
  p = (char*)PGROUNDUP((uint64)pa_start);
    80000948:	6785                	lui	a5,0x1
    8000094a:	fff78713          	addi	a4,a5,-1 # fff <_entry-0x7ffff001>
    8000094e:	00e504b3          	add	s1,a0,a4
    80000952:	777d                	lui	a4,0xfffff
    80000954:	8cf9                	and	s1,s1,a4
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    80000956:	94be                	add	s1,s1,a5
    80000958:	0295e463          	bltu	a1,s1,80000980 <freerange+0x42>
    8000095c:	e84a                	sd	s2,16(sp)
    8000095e:	e44e                	sd	s3,8(sp)
    80000960:	e052                	sd	s4,0(sp)
    80000962:	892e                	mv	s2,a1
    kfree(p);
    80000964:	8a3a                	mv	s4,a4
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    80000966:	89be                	mv	s3,a5
    kfree(p);
    80000968:	01448533          	add	a0,s1,s4
    8000096c:	00000097          	auipc	ra,0x0
    80000970:	f56080e7          	jalr	-170(ra) # 800008c2 <kfree>
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    80000974:	94ce                	add	s1,s1,s3
    80000976:	fe9979e3          	bgeu	s2,s1,80000968 <freerange+0x2a>
    8000097a:	6942                	ld	s2,16(sp)
    8000097c:	69a2                	ld	s3,8(sp)
    8000097e:	6a02                	ld	s4,0(sp)
}
    80000980:	70a2                	ld	ra,40(sp)
    80000982:	7402                	ld	s0,32(sp)
    80000984:	64e2                	ld	s1,24(sp)
    80000986:	6145                	addi	sp,sp,48
    80000988:	8082                	ret

000000008000098a <kinit>:
{
    8000098a:	1141                	addi	sp,sp,-16
    8000098c:	e406                	sd	ra,8(sp)
    8000098e:	e022                	sd	s0,0(sp)
    80000990:	0800                	addi	s0,sp,16
  initlock(&kmem.lock, "kmem");
    80000992:	00008597          	auipc	a1,0x8
    80000996:	89658593          	addi	a1,a1,-1898 # 80008228 <userret+0x198>
    8000099a:	00012517          	auipc	a0,0x12
    8000099e:	f3e50513          	addi	a0,a0,-194 # 800128d8 <kmem>
    800009a2:	00000097          	auipc	ra,0x0
    800009a6:	08e080e7          	jalr	142(ra) # 80000a30 <initlock>
  freerange(end, (void*)PHYSTOP);
    800009aa:	45c5                	li	a1,17
    800009ac:	05ee                	slli	a1,a1,0x1b
    800009ae:	00027517          	auipc	a0,0x27
    800009b2:	6ae50513          	addi	a0,a0,1710 # 8002805c <end>
    800009b6:	00000097          	auipc	ra,0x0
    800009ba:	f88080e7          	jalr	-120(ra) # 8000093e <freerange>
}
    800009be:	60a2                	ld	ra,8(sp)
    800009c0:	6402                	ld	s0,0(sp)
    800009c2:	0141                	addi	sp,sp,16
    800009c4:	8082                	ret

00000000800009c6 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
void *
kalloc(void)
{
    800009c6:	1101                	addi	sp,sp,-32
    800009c8:	ec06                	sd	ra,24(sp)
    800009ca:	e822                	sd	s0,16(sp)
    800009cc:	e426                	sd	s1,8(sp)
    800009ce:	1000                	addi	s0,sp,32
  struct run *r;

  acquire(&kmem.lock);
    800009d0:	00012517          	auipc	a0,0x12
    800009d4:	f0850513          	addi	a0,a0,-248 # 800128d8 <kmem>
    800009d8:	00000097          	auipc	ra,0x0
    800009dc:	12c080e7          	jalr	300(ra) # 80000b04 <acquire>
  r = kmem.freelist;
    800009e0:	00012497          	auipc	s1,0x12
    800009e4:	f184b483          	ld	s1,-232(s1) # 800128f8 <kmem+0x20>
  if(r)
    800009e8:	c89d                	beqz	s1,80000a1e <kalloc+0x58>
    kmem.freelist = r->next;
    800009ea:	609c                	ld	a5,0(s1)
    800009ec:	00012717          	auipc	a4,0x12
    800009f0:	f0f73623          	sd	a5,-244(a4) # 800128f8 <kmem+0x20>
  release(&kmem.lock);
    800009f4:	00012517          	auipc	a0,0x12
    800009f8:	ee450513          	addi	a0,a0,-284 # 800128d8 <kmem>
    800009fc:	00000097          	auipc	ra,0x0
    80000a00:	1cc080e7          	jalr	460(ra) # 80000bc8 <release>

  if(r)
    memset((char*)r, 5, PGSIZE); // fill with junk
    80000a04:	6605                	lui	a2,0x1
    80000a06:	4595                	li	a1,5
    80000a08:	8526                	mv	a0,s1
    80000a0a:	00000097          	auipc	ra,0x0
    80000a0e:	3b4080e7          	jalr	948(ra) # 80000dbe <memset>
  return (void*)r;
}
    80000a12:	8526                	mv	a0,s1
    80000a14:	60e2                	ld	ra,24(sp)
    80000a16:	6442                	ld	s0,16(sp)
    80000a18:	64a2                	ld	s1,8(sp)
    80000a1a:	6105                	addi	sp,sp,32
    80000a1c:	8082                	ret
  release(&kmem.lock);
    80000a1e:	00012517          	auipc	a0,0x12
    80000a22:	eba50513          	addi	a0,a0,-326 # 800128d8 <kmem>
    80000a26:	00000097          	auipc	ra,0x0
    80000a2a:	1a2080e7          	jalr	418(ra) # 80000bc8 <release>
  if(r)
    80000a2e:	b7d5                	j	80000a12 <kalloc+0x4c>

0000000080000a30 <initlock>:

// assumes locks are not freed
void
initlock(struct spinlock *lk, char *name)
{
  lk->name = name;
    80000a30:	e50c                	sd	a1,8(a0)
  lk->locked = 0;
    80000a32:	00052023          	sw	zero,0(a0)
  lk->cpu = 0;
    80000a36:	00053823          	sd	zero,16(a0)
  lk->nts = 0;
    80000a3a:	00052e23          	sw	zero,28(a0)
  lk->n = 0;
    80000a3e:	00052c23          	sw	zero,24(a0)
  if(nlock >= NLOCK)
    80000a42:	00027797          	auipc	a5,0x27
    80000a46:	5e27a783          	lw	a5,1506(a5) # 80028024 <nlock>
    80000a4a:	3e700713          	li	a4,999
    80000a4e:	02f74063          	blt	a4,a5,80000a6e <initlock+0x3e>
    panic("initlock");
  locks[nlock] = lk;
    80000a52:	00379693          	slli	a3,a5,0x3
    80000a56:	00012717          	auipc	a4,0x12
    80000a5a:	eaa70713          	addi	a4,a4,-342 # 80012900 <locks>
    80000a5e:	9736                	add	a4,a4,a3
    80000a60:	e308                	sd	a0,0(a4)
  nlock++;
    80000a62:	2785                	addiw	a5,a5,1
    80000a64:	00027717          	auipc	a4,0x27
    80000a68:	5cf72023          	sw	a5,1472(a4) # 80028024 <nlock>
    80000a6c:	8082                	ret
{
    80000a6e:	1141                	addi	sp,sp,-16
    80000a70:	e406                	sd	ra,8(sp)
    80000a72:	e022                	sd	s0,0(sp)
    80000a74:	0800                	addi	s0,sp,16
    panic("initlock");
    80000a76:	00007517          	auipc	a0,0x7
    80000a7a:	7ba50513          	addi	a0,a0,1978 # 80008230 <userret+0x1a0>
    80000a7e:	00000097          	auipc	ra,0x0
    80000a82:	aec080e7          	jalr	-1300(ra) # 8000056a <panic>

0000000080000a86 <holding>:
// Must be called with interrupts off.
int
holding(struct spinlock *lk)
{
  int r;
  r = (lk->locked && lk->cpu == mycpu());
    80000a86:	411c                	lw	a5,0(a0)
    80000a88:	e399                	bnez	a5,80000a8e <holding+0x8>
    80000a8a:	4501                	li	a0,0
  return r;
}
    80000a8c:	8082                	ret
{
    80000a8e:	1101                	addi	sp,sp,-32
    80000a90:	ec06                	sd	ra,24(sp)
    80000a92:	e822                	sd	s0,16(sp)
    80000a94:	e426                	sd	s1,8(sp)
    80000a96:	1000                	addi	s0,sp,32
  r = (lk->locked && lk->cpu == mycpu());
    80000a98:	691c                	ld	a5,16(a0)
    80000a9a:	84be                	mv	s1,a5
    80000a9c:	00001097          	auipc	ra,0x1
    80000aa0:	044080e7          	jalr	68(ra) # 80001ae0 <mycpu>
    80000aa4:	40a48533          	sub	a0,s1,a0
    80000aa8:	00153513          	seqz	a0,a0
}
    80000aac:	60e2                	ld	ra,24(sp)
    80000aae:	6442                	ld	s0,16(sp)
    80000ab0:	64a2                	ld	s1,8(sp)
    80000ab2:	6105                	addi	sp,sp,32
    80000ab4:	8082                	ret

0000000080000ab6 <push_off>:
// it takes two pop_off()s to undo two push_off()s.  Also, if interrupts
// are initially off, then push_off, pop_off leaves them off.

void
push_off(void)
{
    80000ab6:	1101                	addi	sp,sp,-32
    80000ab8:	ec06                	sd	ra,24(sp)
    80000aba:	e822                	sd	s0,16(sp)
    80000abc:	e426                	sd	s1,8(sp)
    80000abe:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80000ac0:	100024f3          	csrr	s1,sstatus
  return (x & SSTATUS_SIE) != 0;
    80000ac4:	8889                	andi	s1,s1,2
  int old = intr_get();
  if(old)
    80000ac6:	c491                	beqz	s1,80000ad2 <push_off+0x1c>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80000ac8:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80000acc:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80000ace:	10079073          	csrw	sstatus,a5
    intr_off();
  if(mycpu()->noff == 0)
    80000ad2:	00001097          	auipc	ra,0x1
    80000ad6:	00e080e7          	jalr	14(ra) # 80001ae0 <mycpu>
    80000ada:	5d3c                	lw	a5,120(a0)
    80000adc:	cf89                	beqz	a5,80000af6 <push_off+0x40>
    mycpu()->intena = old;
  mycpu()->noff += 1;
    80000ade:	00001097          	auipc	ra,0x1
    80000ae2:	002080e7          	jalr	2(ra) # 80001ae0 <mycpu>
    80000ae6:	5d3c                	lw	a5,120(a0)
    80000ae8:	2785                	addiw	a5,a5,1
    80000aea:	dd3c                	sw	a5,120(a0)
}
    80000aec:	60e2                	ld	ra,24(sp)
    80000aee:	6442                	ld	s0,16(sp)
    80000af0:	64a2                	ld	s1,8(sp)
    80000af2:	6105                	addi	sp,sp,32
    80000af4:	8082                	ret
    mycpu()->intena = old;
    80000af6:	00001097          	auipc	ra,0x1
    80000afa:	fea080e7          	jalr	-22(ra) # 80001ae0 <mycpu>
  return (x & SSTATUS_SIE) != 0;
    80000afe:	8085                	srli	s1,s1,0x1
    80000b00:	dd64                	sw	s1,124(a0)
    80000b02:	bff1                	j	80000ade <push_off+0x28>

0000000080000b04 <acquire>:
{
    80000b04:	1101                	addi	sp,sp,-32
    80000b06:	ec06                	sd	ra,24(sp)
    80000b08:	e822                	sd	s0,16(sp)
    80000b0a:	e426                	sd	s1,8(sp)
    80000b0c:	1000                	addi	s0,sp,32
    80000b0e:	84aa                	mv	s1,a0
  push_off(); // disable interrupts to avoid deadlock.
    80000b10:	00000097          	auipc	ra,0x0
    80000b14:	fa6080e7          	jalr	-90(ra) # 80000ab6 <push_off>
  if(holding(lk))
    80000b18:	8526                	mv	a0,s1
    80000b1a:	00000097          	auipc	ra,0x0
    80000b1e:	f6c080e7          	jalr	-148(ra) # 80000a86 <holding>
    80000b22:	e901                	bnez	a0,80000b32 <acquire+0x2e>
  __sync_fetch_and_add(&(lk->n), 1);
    80000b24:	4785                	li	a5,1
    80000b26:	01848713          	addi	a4,s1,24
    80000b2a:	06f7202f          	amoadd.w.aqrl	zero,a5,(a4)
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0) {
    80000b2e:	873e                	mv	a4,a5
    80000b30:	a829                	j	80000b4a <acquire+0x46>
    panic("acquire");
    80000b32:	00007517          	auipc	a0,0x7
    80000b36:	70e50513          	addi	a0,a0,1806 # 80008240 <userret+0x1b0>
    80000b3a:	00000097          	auipc	ra,0x0
    80000b3e:	a30080e7          	jalr	-1488(ra) # 8000056a <panic>
     __sync_fetch_and_add(&lk->nts, 1);
    80000b42:	01c48793          	addi	a5,s1,28
    80000b46:	06e7a02f          	amoadd.w.aqrl	zero,a4,(a5)
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0) {
    80000b4a:	87ba                	mv	a5,a4
    80000b4c:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80000b50:	2781                	sext.w	a5,a5
    80000b52:	fbe5                	bnez	a5,80000b42 <acquire+0x3e>
  __sync_synchronize();
    80000b54:	0330000f          	fence	rw,rw
  lk->cpu = mycpu();
    80000b58:	00001097          	auipc	ra,0x1
    80000b5c:	f88080e7          	jalr	-120(ra) # 80001ae0 <mycpu>
    80000b60:	e888                	sd	a0,16(s1)
}
    80000b62:	60e2                	ld	ra,24(sp)
    80000b64:	6442                	ld	s0,16(sp)
    80000b66:	64a2                	ld	s1,8(sp)
    80000b68:	6105                	addi	sp,sp,32
    80000b6a:	8082                	ret

0000000080000b6c <pop_off>:

void
pop_off(void)
{
    80000b6c:	1141                	addi	sp,sp,-16
    80000b6e:	e406                	sd	ra,8(sp)
    80000b70:	e022                	sd	s0,0(sp)
    80000b72:	0800                	addi	s0,sp,16
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80000b74:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80000b78:	8b89                	andi	a5,a5,2
  if(intr_get())
    80000b7a:	e79d                	bnez	a5,80000ba8 <pop_off+0x3c>
    panic("pop_off - interruptible");
  struct cpu *c = mycpu();
    80000b7c:	00001097          	auipc	ra,0x1
    80000b80:	f64080e7          	jalr	-156(ra) # 80001ae0 <mycpu>
  if(c->noff < 1)
    80000b84:	5d3c                	lw	a5,120(a0)
    80000b86:	02f05963          	blez	a5,80000bb8 <pop_off+0x4c>
    panic("pop_off");
  c->noff -= 1;
    80000b8a:	37fd                	addiw	a5,a5,-1
    80000b8c:	dd3c                	sw	a5,120(a0)
  if(c->noff == 0 && c->intena)
    80000b8e:	eb89                	bnez	a5,80000ba0 <pop_off+0x34>
    80000b90:	5d7c                	lw	a5,124(a0)
    80000b92:	c799                	beqz	a5,80000ba0 <pop_off+0x34>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80000b94:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80000b98:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80000b9c:	10079073          	csrw	sstatus,a5
    intr_on();
}
    80000ba0:	60a2                	ld	ra,8(sp)
    80000ba2:	6402                	ld	s0,0(sp)
    80000ba4:	0141                	addi	sp,sp,16
    80000ba6:	8082                	ret
    panic("pop_off - interruptible");
    80000ba8:	00007517          	auipc	a0,0x7
    80000bac:	6a050513          	addi	a0,a0,1696 # 80008248 <userret+0x1b8>
    80000bb0:	00000097          	auipc	ra,0x0
    80000bb4:	9ba080e7          	jalr	-1606(ra) # 8000056a <panic>
    panic("pop_off");
    80000bb8:	00007517          	auipc	a0,0x7
    80000bbc:	6a850513          	addi	a0,a0,1704 # 80008260 <userret+0x1d0>
    80000bc0:	00000097          	auipc	ra,0x0
    80000bc4:	9aa080e7          	jalr	-1622(ra) # 8000056a <panic>

0000000080000bc8 <release>:
{
    80000bc8:	1101                	addi	sp,sp,-32
    80000bca:	ec06                	sd	ra,24(sp)
    80000bcc:	e822                	sd	s0,16(sp)
    80000bce:	e426                	sd	s1,8(sp)
    80000bd0:	1000                	addi	s0,sp,32
    80000bd2:	84aa                	mv	s1,a0
  if(!holding(lk))
    80000bd4:	00000097          	auipc	ra,0x0
    80000bd8:	eb2080e7          	jalr	-334(ra) # 80000a86 <holding>
    80000bdc:	c115                	beqz	a0,80000c00 <release+0x38>
  lk->cpu = 0;
    80000bde:	0004b823          	sd	zero,16(s1)
  __sync_synchronize();
    80000be2:	0330000f          	fence	rw,rw
  __sync_lock_release(&lk->locked);
    80000be6:	0310000f          	fence	rw,w
    80000bea:	0004a023          	sw	zero,0(s1)
  pop_off();
    80000bee:	00000097          	auipc	ra,0x0
    80000bf2:	f7e080e7          	jalr	-130(ra) # 80000b6c <pop_off>
}
    80000bf6:	60e2                	ld	ra,24(sp)
    80000bf8:	6442                	ld	s0,16(sp)
    80000bfa:	64a2                	ld	s1,8(sp)
    80000bfc:	6105                	addi	sp,sp,32
    80000bfe:	8082                	ret
    panic("release");
    80000c00:	00007517          	auipc	a0,0x7
    80000c04:	66850513          	addi	a0,a0,1640 # 80008268 <userret+0x1d8>
    80000c08:	00000097          	auipc	ra,0x0
    80000c0c:	962080e7          	jalr	-1694(ra) # 8000056a <panic>

0000000080000c10 <print_lock>:

void
print_lock(struct spinlock *lk)
{
  if(lk->n > 0) 
    80000c10:	4d14                	lw	a3,24(a0)
    80000c12:	e291                	bnez	a3,80000c16 <print_lock+0x6>
    80000c14:	8082                	ret
{
    80000c16:	1141                	addi	sp,sp,-16
    80000c18:	e406                	sd	ra,8(sp)
    80000c1a:	e022                	sd	s0,0(sp)
    80000c1c:	0800                	addi	s0,sp,16
    printf("lock: %s: #test-and-set %d #acquire() %d\n", lk->name, lk->nts, lk->n);
    80000c1e:	4d50                	lw	a2,28(a0)
    80000c20:	650c                	ld	a1,8(a0)
    80000c22:	00007517          	auipc	a0,0x7
    80000c26:	64e50513          	addi	a0,a0,1614 # 80008270 <userret+0x1e0>
    80000c2a:	00000097          	auipc	ra,0x0
    80000c2e:	99a080e7          	jalr	-1638(ra) # 800005c4 <printf>
}
    80000c32:	60a2                	ld	ra,8(sp)
    80000c34:	6402                	ld	s0,0(sp)
    80000c36:	0141                	addi	sp,sp,16
    80000c38:	8082                	ret

0000000080000c3a <sys_ntas>:

uint64
sys_ntas(void)
{
    80000c3a:	711d                	addi	sp,sp,-96
    80000c3c:	ec86                	sd	ra,88(sp)
    80000c3e:	e8a2                	sd	s0,80(sp)
    80000c40:	1080                	addi	s0,sp,96
  int zero = 0;
    80000c42:	fa042623          	sw	zero,-84(s0)
  int tot = 0;
  
  if (argint(0, &zero) < 0) {
    80000c46:	fac40593          	addi	a1,s0,-84
    80000c4a:	4501                	li	a0,0
    80000c4c:	00002097          	auipc	ra,0x2
    80000c50:	fd4080e7          	jalr	-44(ra) # 80002c20 <argint>
    80000c54:	16054163          	bltz	a0,80000db6 <sys_ntas+0x17c>
    return -1;
  }
  if(zero == 0) {
    80000c58:	fac42783          	lw	a5,-84(s0)
    80000c5c:	e78d                	bnez	a5,80000c86 <sys_ntas+0x4c>
    80000c5e:	00012797          	auipc	a5,0x12
    80000c62:	ca278793          	addi	a5,a5,-862 # 80012900 <locks>
    80000c66:	00014697          	auipc	a3,0x14
    80000c6a:	bda68693          	addi	a3,a3,-1062 # 80014840 <pid_lock>
    for(int i = 0; i < NLOCK; i++) {
      if(locks[i] == 0)
    80000c6e:	6398                	ld	a4,0(a5)
    80000c70:	14070563          	beqz	a4,80000dba <sys_ntas+0x180>
        break;
      locks[i]->nts = 0;
    80000c74:	00072e23          	sw	zero,28(a4)
      locks[i]->n = 0;
    80000c78:	00072c23          	sw	zero,24(a4)
    for(int i = 0; i < NLOCK; i++) {
    80000c7c:	07a1                	addi	a5,a5,8
    80000c7e:	fed798e3          	bne	a5,a3,80000c6e <sys_ntas+0x34>
    }
    return 0;
    80000c82:	4501                	li	a0,0
    80000c84:	a22d                	j	80000dae <sys_ntas+0x174>
    80000c86:	e4a6                	sd	s1,72(sp)
    80000c88:	e0ca                	sd	s2,64(sp)
    80000c8a:	fc4e                	sd	s3,56(sp)
    80000c8c:	f852                	sd	s4,48(sp)
    80000c8e:	f456                	sd	s5,40(sp)
    80000c90:	f05a                	sd	s6,32(sp)
    80000c92:	ec5e                	sd	s7,24(sp)
  }

  printf("=== lock kmem/bcache stats\n");
    80000c94:	00007517          	auipc	a0,0x7
    80000c98:	60c50513          	addi	a0,a0,1548 # 800082a0 <userret+0x210>
    80000c9c:	00000097          	auipc	ra,0x0
    80000ca0:	928080e7          	jalr	-1752(ra) # 800005c4 <printf>
  for(int i = 0; i < NLOCK; i++) {
    80000ca4:	00014a97          	auipc	s5,0x14
    80000ca8:	b9ca8a93          	addi	s5,s5,-1124 # 80014840 <pid_lock>
  printf("=== lock kmem/bcache stats\n");
    80000cac:	00012497          	auipc	s1,0x12
    80000cb0:	c5448493          	addi	s1,s1,-940 # 80012900 <locks>
  int tot = 0;
    80000cb4:	4981                	li	s3,0
    if(locks[i] == 0)
      break;
    if(strncmp(locks[i]->name, "bcache", strlen("bcache")) == 0 ||
    80000cb6:	00007917          	auipc	s2,0x7
    80000cba:	60a90913          	addi	s2,s2,1546 # 800082c0 <userret+0x230>
       strncmp(locks[i]->name, "kmem", strlen("kmem")) == 0) {
    80000cbe:	00007b17          	auipc	s6,0x7
    80000cc2:	56ab0b13          	addi	s6,s6,1386 # 80008228 <userret+0x198>
    80000cc6:	a829                	j	80000ce0 <sys_ntas+0xa6>
      tot += locks[i]->nts;
    80000cc8:	000bb503          	ld	a0,0(s7)
    80000ccc:	4d5c                	lw	a5,28(a0)
    80000cce:	013789bb          	addw	s3,a5,s3
      print_lock(locks[i]);
    80000cd2:	00000097          	auipc	ra,0x0
    80000cd6:	f3e080e7          	jalr	-194(ra) # 80000c10 <print_lock>
  for(int i = 0; i < NLOCK; i++) {
    80000cda:	04a1                	addi	s1,s1,8
    80000cdc:	05548563          	beq	s1,s5,80000d26 <sys_ntas+0xec>
    if(locks[i] == 0)
    80000ce0:	8ba6                	mv	s7,s1
    80000ce2:	609c                	ld	a5,0(s1)
    80000ce4:	c3a9                	beqz	a5,80000d26 <sys_ntas+0xec>
    if(strncmp(locks[i]->name, "bcache", strlen("bcache")) == 0 ||
    80000ce6:	0087ba03          	ld	s4,8(a5)
    80000cea:	854a                	mv	a0,s2
    80000cec:	00000097          	auipc	ra,0x0
    80000cf0:	262080e7          	jalr	610(ra) # 80000f4e <strlen>
    80000cf4:	862a                	mv	a2,a0
    80000cf6:	85ca                	mv	a1,s2
    80000cf8:	8552                	mv	a0,s4
    80000cfa:	00000097          	auipc	ra,0x0
    80000cfe:	19e080e7          	jalr	414(ra) # 80000e98 <strncmp>
    80000d02:	d179                	beqz	a0,80000cc8 <sys_ntas+0x8e>
       strncmp(locks[i]->name, "kmem", strlen("kmem")) == 0) {
    80000d04:	609c                	ld	a5,0(s1)
    80000d06:	0087ba03          	ld	s4,8(a5)
    80000d0a:	855a                	mv	a0,s6
    80000d0c:	00000097          	auipc	ra,0x0
    80000d10:	242080e7          	jalr	578(ra) # 80000f4e <strlen>
    80000d14:	862a                	mv	a2,a0
    80000d16:	85da                	mv	a1,s6
    80000d18:	8552                	mv	a0,s4
    80000d1a:	00000097          	auipc	ra,0x0
    80000d1e:	17e080e7          	jalr	382(ra) # 80000e98 <strncmp>
    if(strncmp(locks[i]->name, "bcache", strlen("bcache")) == 0 ||
    80000d22:	fd45                	bnez	a0,80000cda <sys_ntas+0xa0>
    80000d24:	b755                	j	80000cc8 <sys_ntas+0x8e>
    }
  }

  printf("=== top 5 contended locks:\n");
    80000d26:	00007517          	auipc	a0,0x7
    80000d2a:	5a250513          	addi	a0,a0,1442 # 800082c8 <userret+0x238>
    80000d2e:	00000097          	auipc	ra,0x0
    80000d32:	896080e7          	jalr	-1898(ra) # 800005c4 <printf>
    80000d36:	4a15                	li	s4,5
  int last = 100000000;
    80000d38:	05f5e537          	lui	a0,0x5f5e
    80000d3c:	10050513          	addi	a0,a0,256 # 5f5e100 <_entry-0x7a0a1f00>
  for(int t= 0; t < 5; t++) {
    int top = 0;
    for(int i = 0; i < NLOCK; i++) {
      if(locks[i] == 0)
        break;
      if(locks[i]->nts > locks[top]->nts && locks[i]->nts < last) {
    80000d40:	00012497          	auipc	s1,0x12
    80000d44:	bc048493          	addi	s1,s1,-1088 # 80012900 <locks>
    for(int i = 0; i < NLOCK; i++) {
    80000d48:	3e800913          	li	s2,1000
    80000d4c:	a091                	j	80000d90 <sys_ntas+0x156>
        top = i;
    80000d4e:	85ba                	mv	a1,a4
    for(int i = 0; i < NLOCK; i++) {
    80000d50:	2705                	addiw	a4,a4,1
    80000d52:	06a1                	addi	a3,a3,8
    80000d54:	01270f63          	beq	a4,s2,80000d72 <sys_ntas+0x138>
      if(locks[i] == 0)
    80000d58:	629c                	ld	a5,0(a3)
    80000d5a:	cf81                	beqz	a5,80000d72 <sys_ntas+0x138>
      if(locks[i]->nts > locks[top]->nts && locks[i]->nts < last) {
    80000d5c:	4fd0                	lw	a2,28(a5)
    80000d5e:	00359793          	slli	a5,a1,0x3
    80000d62:	97a6                	add	a5,a5,s1
    80000d64:	639c                	ld	a5,0(a5)
    80000d66:	4fdc                	lw	a5,28(a5)
    80000d68:	fec7f4e3          	bgeu	a5,a2,80000d50 <sys_ntas+0x116>
    80000d6c:	fea672e3          	bgeu	a2,a0,80000d50 <sys_ntas+0x116>
    80000d70:	bff9                	j	80000d4e <sys_ntas+0x114>
      }
    }
    print_lock(locks[top]);
    80000d72:	058e                	slli	a1,a1,0x3
    80000d74:	00b48ab3          	add	s5,s1,a1
    80000d78:	000ab503          	ld	a0,0(s5)
    80000d7c:	00000097          	auipc	ra,0x0
    80000d80:	e94080e7          	jalr	-364(ra) # 80000c10 <print_lock>
    last = locks[top]->nts;
    80000d84:	000ab783          	ld	a5,0(s5)
    80000d88:	4fc8                	lw	a0,28(a5)
  for(int t= 0; t < 5; t++) {
    80000d8a:	3a7d                	addiw	s4,s4,-1
    80000d8c:	000a0963          	beqz	s4,80000d9e <sys_ntas+0x164>
  int tot = 0;
    80000d90:	00012697          	auipc	a3,0x12
    80000d94:	b7068693          	addi	a3,a3,-1168 # 80012900 <locks>
    for(int i = 0; i < NLOCK; i++) {
    80000d98:	4701                	li	a4,0
    int top = 0;
    80000d9a:	4581                	li	a1,0
    80000d9c:	bf75                	j	80000d58 <sys_ntas+0x11e>
  }
  return tot;
    80000d9e:	854e                	mv	a0,s3
    80000da0:	64a6                	ld	s1,72(sp)
    80000da2:	6906                	ld	s2,64(sp)
    80000da4:	79e2                	ld	s3,56(sp)
    80000da6:	7a42                	ld	s4,48(sp)
    80000da8:	7aa2                	ld	s5,40(sp)
    80000daa:	7b02                	ld	s6,32(sp)
    80000dac:	6be2                	ld	s7,24(sp)
}
    80000dae:	60e6                	ld	ra,88(sp)
    80000db0:	6446                	ld	s0,80(sp)
    80000db2:	6125                	addi	sp,sp,96
    80000db4:	8082                	ret
    return -1;
    80000db6:	557d                	li	a0,-1
    80000db8:	bfdd                	j	80000dae <sys_ntas+0x174>
    return 0;
    80000dba:	4501                	li	a0,0
    80000dbc:	bfcd                	j	80000dae <sys_ntas+0x174>

0000000080000dbe <memset>:
#include "types.h"

void*
memset(void *dst, int c, uint n)
{
    80000dbe:	1141                	addi	sp,sp,-16
    80000dc0:	e406                	sd	ra,8(sp)
    80000dc2:	e022                	sd	s0,0(sp)
    80000dc4:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    80000dc6:	ca19                	beqz	a2,80000ddc <memset+0x1e>
    80000dc8:	87aa                	mv	a5,a0
    80000dca:	1602                	slli	a2,a2,0x20
    80000dcc:	9201                	srli	a2,a2,0x20
    80000dce:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    80000dd2:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    80000dd6:	0785                	addi	a5,a5,1
    80000dd8:	fee79de3          	bne	a5,a4,80000dd2 <memset+0x14>
  }
  return dst;
}
    80000ddc:	60a2                	ld	ra,8(sp)
    80000dde:	6402                	ld	s0,0(sp)
    80000de0:	0141                	addi	sp,sp,16
    80000de2:	8082                	ret

0000000080000de4 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
    80000de4:	1141                	addi	sp,sp,-16
    80000de6:	e406                	sd	ra,8(sp)
    80000de8:	e022                	sd	s0,0(sp)
    80000dea:	0800                	addi	s0,sp,16
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    80000dec:	c61d                	beqz	a2,80000e1a <memcmp+0x36>
    80000dee:	1602                	slli	a2,a2,0x20
    80000df0:	9201                	srli	a2,a2,0x20
    80000df2:	00c506b3          	add	a3,a0,a2
    if(*s1 != *s2)
    80000df6:	00054783          	lbu	a5,0(a0)
    80000dfa:	0005c703          	lbu	a4,0(a1)
    80000dfe:	00e79863          	bne	a5,a4,80000e0e <memcmp+0x2a>
      return *s1 - *s2;
    s1++, s2++;
    80000e02:	0505                	addi	a0,a0,1
    80000e04:	0585                	addi	a1,a1,1
  while(n-- > 0){
    80000e06:	fed518e3          	bne	a0,a3,80000df6 <memcmp+0x12>
  }

  return 0;
    80000e0a:	4501                	li	a0,0
    80000e0c:	a019                	j	80000e12 <memcmp+0x2e>
      return *s1 - *s2;
    80000e0e:	40e7853b          	subw	a0,a5,a4
}
    80000e12:	60a2                	ld	ra,8(sp)
    80000e14:	6402                	ld	s0,0(sp)
    80000e16:	0141                	addi	sp,sp,16
    80000e18:	8082                	ret
  return 0;
    80000e1a:	4501                	li	a0,0
    80000e1c:	bfdd                	j	80000e12 <memcmp+0x2e>

0000000080000e1e <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
    80000e1e:	1141                	addi	sp,sp,-16
    80000e20:	e406                	sd	ra,8(sp)
    80000e22:	e022                	sd	s0,0(sp)
    80000e24:	0800                	addi	s0,sp,16
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
    80000e26:	02a5e463          	bltu	a1,a0,80000e4e <memmove+0x30>
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
    80000e2a:	ce11                	beqz	a2,80000e46 <memmove+0x28>
    80000e2c:	1602                	slli	a2,a2,0x20
    80000e2e:	9201                	srli	a2,a2,0x20
    80000e30:	00c58733          	add	a4,a1,a2
    80000e34:	87aa                	mv	a5,a0
      *d++ = *s++;
    80000e36:	0585                	addi	a1,a1,1
    80000e38:	0785                	addi	a5,a5,1
    80000e3a:	fff5c683          	lbu	a3,-1(a1)
    80000e3e:	fed78fa3          	sb	a3,-1(a5)
    while(n-- > 0)
    80000e42:	feb71ae3          	bne	a4,a1,80000e36 <memmove+0x18>

  return dst;
}
    80000e46:	60a2                	ld	ra,8(sp)
    80000e48:	6402                	ld	s0,0(sp)
    80000e4a:	0141                	addi	sp,sp,16
    80000e4c:	8082                	ret
  if(s < d && s + n > d){
    80000e4e:	02061693          	slli	a3,a2,0x20
    80000e52:	9281                	srli	a3,a3,0x20
    80000e54:	00d58733          	add	a4,a1,a3
    80000e58:	fce579e3          	bgeu	a0,a4,80000e2a <memmove+0xc>
    while(n-- > 0)
    80000e5c:	d66d                	beqz	a2,80000e46 <memmove+0x28>
    d += n;
    80000e5e:	96aa                	add	a3,a3,a0
    while(n-- > 0)
    80000e60:	fff6079b          	addiw	a5,a2,-1 # fff <_entry-0x7ffff001>
    80000e64:	1782                	slli	a5,a5,0x20
    80000e66:	9381                	srli	a5,a5,0x20
    80000e68:	fff7c793          	not	a5,a5
    80000e6c:	97ba                	add	a5,a5,a4
      *--d = *--s;
    80000e6e:	177d                	addi	a4,a4,-1
    80000e70:	16fd                	addi	a3,a3,-1
    80000e72:	00074603          	lbu	a2,0(a4)
    80000e76:	00c68023          	sb	a2,0(a3)
    while(n-- > 0)
    80000e7a:	fee79ae3          	bne	a5,a4,80000e6e <memmove+0x50>
    80000e7e:	b7e1                	j	80000e46 <memmove+0x28>

0000000080000e80 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
    80000e80:	1141                	addi	sp,sp,-16
    80000e82:	e406                	sd	ra,8(sp)
    80000e84:	e022                	sd	s0,0(sp)
    80000e86:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    80000e88:	00000097          	auipc	ra,0x0
    80000e8c:	f96080e7          	jalr	-106(ra) # 80000e1e <memmove>
}
    80000e90:	60a2                	ld	ra,8(sp)
    80000e92:	6402                	ld	s0,0(sp)
    80000e94:	0141                	addi	sp,sp,16
    80000e96:	8082                	ret

0000000080000e98 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
    80000e98:	1141                	addi	sp,sp,-16
    80000e9a:	e406                	sd	ra,8(sp)
    80000e9c:	e022                	sd	s0,0(sp)
    80000e9e:	0800                	addi	s0,sp,16
  while(n > 0 && *p && *p == *q)
    80000ea0:	ce11                	beqz	a2,80000ebc <strncmp+0x24>
    80000ea2:	00054783          	lbu	a5,0(a0)
    80000ea6:	cf89                	beqz	a5,80000ec0 <strncmp+0x28>
    80000ea8:	0005c703          	lbu	a4,0(a1)
    80000eac:	00f71a63          	bne	a4,a5,80000ec0 <strncmp+0x28>
    n--, p++, q++;
    80000eb0:	367d                	addiw	a2,a2,-1
    80000eb2:	0505                	addi	a0,a0,1
    80000eb4:	0585                	addi	a1,a1,1
  while(n > 0 && *p && *p == *q)
    80000eb6:	f675                	bnez	a2,80000ea2 <strncmp+0xa>
  if(n == 0)
    return 0;
    80000eb8:	4501                	li	a0,0
    80000eba:	a801                	j	80000eca <strncmp+0x32>
    80000ebc:	4501                	li	a0,0
    80000ebe:	a031                	j	80000eca <strncmp+0x32>
  return (uchar)*p - (uchar)*q;
    80000ec0:	00054503          	lbu	a0,0(a0)
    80000ec4:	0005c783          	lbu	a5,0(a1)
    80000ec8:	9d1d                	subw	a0,a0,a5
}
    80000eca:	60a2                	ld	ra,8(sp)
    80000ecc:	6402                	ld	s0,0(sp)
    80000ece:	0141                	addi	sp,sp,16
    80000ed0:	8082                	ret

0000000080000ed2 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
    80000ed2:	1141                	addi	sp,sp,-16
    80000ed4:	e406                	sd	ra,8(sp)
    80000ed6:	e022                	sd	s0,0(sp)
    80000ed8:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    80000eda:	87aa                	mv	a5,a0
    80000edc:	a011                	j	80000ee0 <strncpy+0xe>
    80000ede:	8636                	mv	a2,a3
    80000ee0:	02c05863          	blez	a2,80000f10 <strncpy+0x3e>
    80000ee4:	fff6069b          	addiw	a3,a2,-1
    80000ee8:	8836                	mv	a6,a3
    80000eea:	0785                	addi	a5,a5,1
    80000eec:	0005c703          	lbu	a4,0(a1)
    80000ef0:	fee78fa3          	sb	a4,-1(a5)
    80000ef4:	0585                	addi	a1,a1,1
    80000ef6:	f765                	bnez	a4,80000ede <strncpy+0xc>
    ;
  while(n-- > 0)
    80000ef8:	873e                	mv	a4,a5
    80000efa:	01005b63          	blez	a6,80000f10 <strncpy+0x3e>
    80000efe:	9fb1                	addw	a5,a5,a2
    80000f00:	37fd                	addiw	a5,a5,-1
    *s++ = 0;
    80000f02:	0705                	addi	a4,a4,1
    80000f04:	fe070fa3          	sb	zero,-1(a4)
  while(n-- > 0)
    80000f08:	40e786bb          	subw	a3,a5,a4
    80000f0c:	fed04be3          	bgtz	a3,80000f02 <strncpy+0x30>
  return os;
}
    80000f10:	60a2                	ld	ra,8(sp)
    80000f12:	6402                	ld	s0,0(sp)
    80000f14:	0141                	addi	sp,sp,16
    80000f16:	8082                	ret

0000000080000f18 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
    80000f18:	1141                	addi	sp,sp,-16
    80000f1a:	e406                	sd	ra,8(sp)
    80000f1c:	e022                	sd	s0,0(sp)
    80000f1e:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  if(n <= 0)
    80000f20:	02c05363          	blez	a2,80000f46 <safestrcpy+0x2e>
    80000f24:	fff6069b          	addiw	a3,a2,-1
    80000f28:	1682                	slli	a3,a3,0x20
    80000f2a:	9281                	srli	a3,a3,0x20
    80000f2c:	96ae                	add	a3,a3,a1
    80000f2e:	87aa                	mv	a5,a0
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
    80000f30:	00d58963          	beq	a1,a3,80000f42 <safestrcpy+0x2a>
    80000f34:	0585                	addi	a1,a1,1
    80000f36:	0785                	addi	a5,a5,1
    80000f38:	fff5c703          	lbu	a4,-1(a1)
    80000f3c:	fee78fa3          	sb	a4,-1(a5)
    80000f40:	fb65                	bnez	a4,80000f30 <safestrcpy+0x18>
    ;
  *s = 0;
    80000f42:	00078023          	sb	zero,0(a5)
  return os;
}
    80000f46:	60a2                	ld	ra,8(sp)
    80000f48:	6402                	ld	s0,0(sp)
    80000f4a:	0141                	addi	sp,sp,16
    80000f4c:	8082                	ret

0000000080000f4e <strlen>:

int
strlen(const char *s)
{
    80000f4e:	1141                	addi	sp,sp,-16
    80000f50:	e406                	sd	ra,8(sp)
    80000f52:	e022                	sd	s0,0(sp)
    80000f54:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    80000f56:	00054783          	lbu	a5,0(a0)
    80000f5a:	cf91                	beqz	a5,80000f76 <strlen+0x28>
    80000f5c:	00150793          	addi	a5,a0,1
    80000f60:	86be                	mv	a3,a5
    80000f62:	0785                	addi	a5,a5,1
    80000f64:	fff7c703          	lbu	a4,-1(a5)
    80000f68:	ff65                	bnez	a4,80000f60 <strlen+0x12>
    80000f6a:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
    80000f6e:	60a2                	ld	ra,8(sp)
    80000f70:	6402                	ld	s0,0(sp)
    80000f72:	0141                	addi	sp,sp,16
    80000f74:	8082                	ret
  for(n = 0; s[n]; n++)
    80000f76:	4501                	li	a0,0
    80000f78:	bfdd                	j	80000f6e <strlen+0x20>

0000000080000f7a <main>:

volatile static int started = 0;

// start() jumps here in supervisor mode on all CPUs.
void main()
{
    80000f7a:	1141                	addi	sp,sp,-16
    80000f7c:	e406                	sd	ra,8(sp)
    80000f7e:	e022                	sd	s0,0(sp)
    80000f80:	0800                	addi	s0,sp,16
  if (cpuid() == 0)
    80000f82:	00001097          	auipc	ra,0x1
    80000f86:	b4a080e7          	jalr	-1206(ra) # 80001acc <cpuid>
    __sync_synchronize();
    started = 1;
  }
  else
  {
    while (started == 0)
    80000f8a:	00027717          	auipc	a4,0x27
    80000f8e:	09e70713          	addi	a4,a4,158 # 80028028 <started>
  if (cpuid() == 0)
    80000f92:	c139                	beqz	a0,80000fd8 <main+0x5e>
    while (started == 0)
    80000f94:	431c                	lw	a5,0(a4)
    80000f96:	2781                	sext.w	a5,a5
    80000f98:	dff5                	beqz	a5,80000f94 <main+0x1a>
      ;
    __sync_synchronize();
    80000f9a:	0330000f          	fence	rw,rw
    printf("hart %d starting\n", cpuid());
    80000f9e:	00001097          	auipc	ra,0x1
    80000fa2:	b2e080e7          	jalr	-1234(ra) # 80001acc <cpuid>
    80000fa6:	85aa                	mv	a1,a0
    80000fa8:	00007517          	auipc	a0,0x7
    80000fac:	37850513          	addi	a0,a0,888 # 80008320 <userret+0x290>
    80000fb0:	fffff097          	auipc	ra,0xfffff
    80000fb4:	614080e7          	jalr	1556(ra) # 800005c4 <printf>
    kvminithart();  // turn on paging
    80000fb8:	00000097          	auipc	ra,0x0
    80000fbc:	1f8080e7          	jalr	504(ra) # 800011b0 <kvminithart>
    trapinithart(); // install kernel trap vector
    80000fc0:	00001097          	auipc	ra,0x1
    80000fc4:	7d8080e7          	jalr	2008(ra) # 80002798 <trapinithart>
    plicinithart(); // ask PLIC for device interrupts
    80000fc8:	00005097          	auipc	ra,0x5
    80000fcc:	f9c080e7          	jalr	-100(ra) # 80005f64 <plicinithart>
  }

  scheduler();
    80000fd0:	00001097          	auipc	ra,0x1
    80000fd4:	010080e7          	jalr	16(ra) # 80001fe0 <scheduler>
    consoleinit();
    80000fd8:	fffff097          	auipc	ra,0xfffff
    80000fdc:	4a8080e7          	jalr	1192(ra) # 80000480 <consoleinit>
    printf("DEBUG: after consoleinit\n");
    80000fe0:	00007517          	auipc	a0,0x7
    80000fe4:	30850513          	addi	a0,a0,776 # 800082e8 <userret+0x258>
    80000fe8:	fffff097          	auipc	ra,0xfffff
    80000fec:	5dc080e7          	jalr	1500(ra) # 800005c4 <printf>
    printfinit();
    80000ff0:	fffff097          	auipc	ra,0xfffff
    80000ff4:	7de080e7          	jalr	2014(ra) # 800007ce <printfinit>
    printf("\n");
    80000ff8:	00007517          	auipc	a0,0x7
    80000ffc:	13050513          	addi	a0,a0,304 # 80008128 <userret+0x98>
    80001000:	fffff097          	auipc	ra,0xfffff
    80001004:	5c4080e7          	jalr	1476(ra) # 800005c4 <printf>
    printf("xv6 kernel is booting\n");
    80001008:	00007517          	auipc	a0,0x7
    8000100c:	30050513          	addi	a0,a0,768 # 80008308 <userret+0x278>
    80001010:	fffff097          	auipc	ra,0xfffff
    80001014:	5b4080e7          	jalr	1460(ra) # 800005c4 <printf>
    printf("\n");
    80001018:	00007517          	auipc	a0,0x7
    8000101c:	11050513          	addi	a0,a0,272 # 80008128 <userret+0x98>
    80001020:	fffff097          	auipc	ra,0xfffff
    80001024:	5a4080e7          	jalr	1444(ra) # 800005c4 <printf>
    kinit();                          // physical page allocator
    80001028:	00000097          	auipc	ra,0x0
    8000102c:	962080e7          	jalr	-1694(ra) # 8000098a <kinit>
    kvminit();                        // create kernel page table
    80001030:	00000097          	auipc	ra,0x0
    80001034:	30c080e7          	jalr	780(ra) # 8000133c <kvminit>
    kvminithart();                    // turn on paging
    80001038:	00000097          	auipc	ra,0x0
    8000103c:	178080e7          	jalr	376(ra) # 800011b0 <kvminithart>
    procinit();                       // process table
    80001040:	00001097          	auipc	ra,0x1
    80001044:	9a2080e7          	jalr	-1630(ra) # 800019e2 <procinit>
    trapinit();                       // trap vectors
    80001048:	00001097          	auipc	ra,0x1
    8000104c:	728080e7          	jalr	1832(ra) # 80002770 <trapinit>
    trapinithart();                   // install kernel trap vector
    80001050:	00001097          	auipc	ra,0x1
    80001054:	748080e7          	jalr	1864(ra) # 80002798 <trapinithart>
    plicinit();                       // set up interrupt controller
    80001058:	00005097          	auipc	ra,0x5
    8000105c:	ef2080e7          	jalr	-270(ra) # 80005f4a <plicinit>
    plicinithart();                   // ask PLIC for device interrupts
    80001060:	00005097          	auipc	ra,0x5
    80001064:	f04080e7          	jalr	-252(ra) # 80005f64 <plicinithart>
    binit();                          // buffer cache
    80001068:	00002097          	auipc	ra,0x2
    8000106c:	ea6080e7          	jalr	-346(ra) # 80002f0e <binit>
    iinit();                          // inode cache
    80001070:	00002097          	auipc	ra,0x2
    80001074:	508080e7          	jalr	1288(ra) # 80003578 <iinit>
    fileinit();                       // file table
    80001078:	00003097          	auipc	ra,0x3
    8000107c:	5ba080e7          	jalr	1466(ra) # 80004632 <fileinit>
    virtio_disk_init(minor(ROOTDEV)); // emulated hard disk
    80001080:	4501                	li	a0,0
    80001082:	00005097          	auipc	ra,0x5
    80001086:	002080e7          	jalr	2(ra) # 80006084 <virtio_disk_init>
    userinit();                       // first user process
    8000108a:	00001097          	auipc	ra,0x1
    8000108e:	cea080e7          	jalr	-790(ra) # 80001d74 <userinit>
    __sync_synchronize();
    80001092:	0330000f          	fence	rw,rw
    started = 1;
    80001096:	4785                	li	a5,1
    80001098:	00027717          	auipc	a4,0x27
    8000109c:	f8f72823          	sw	a5,-112(a4) # 80028028 <started>
    800010a0:	bf05                	j	80000fd0 <main+0x56>

00000000800010a2 <walk>:
//   21..39 -- 9 bits of level-1 index.
//   12..20 -- 9 bits of level-0 index.
//    0..12 -- 12 bits of byte offset within the page.
static pte_t *
walk(pagetable_t pagetable, uint64 va, int alloc)
{
    800010a2:	7139                	addi	sp,sp,-64
    800010a4:	fc06                	sd	ra,56(sp)
    800010a6:	f822                	sd	s0,48(sp)
    800010a8:	f426                	sd	s1,40(sp)
    800010aa:	f04a                	sd	s2,32(sp)
    800010ac:	ec4e                	sd	s3,24(sp)
    800010ae:	e852                	sd	s4,16(sp)
    800010b0:	e456                	sd	s5,8(sp)
    800010b2:	e05a                	sd	s6,0(sp)
    800010b4:	0080                	addi	s0,sp,64
    800010b6:	84aa                	mv	s1,a0
    800010b8:	89ae                	mv	s3,a1
    800010ba:	8b32                	mv	s6,a2
  if(va >= MAXVA)
    800010bc:	57fd                	li	a5,-1
    800010be:	83e9                	srli	a5,a5,0x1a
    800010c0:	4a79                	li	s4,30
    panic("walk");

  for(int level = 2; level > 0; level--) {
    800010c2:	4ab1                	li	s5,12
  if(va >= MAXVA)
    800010c4:	04b7e263          	bltu	a5,a1,80001108 <walk+0x66>
    pte_t *pte = &pagetable[PX(level, va)];
    800010c8:	0149d933          	srl	s2,s3,s4
    800010cc:	1ff97913          	andi	s2,s2,511
    800010d0:	090e                	slli	s2,s2,0x3
    800010d2:	9926                	add	s2,s2,s1
    if(*pte & PTE_V) {
    800010d4:	00093483          	ld	s1,0(s2)
    800010d8:	0014f793          	andi	a5,s1,1
    800010dc:	cf95                	beqz	a5,80001118 <walk+0x76>
      pagetable = (pagetable_t)PTE2PA(*pte);
    800010de:	80a9                	srli	s1,s1,0xa
    800010e0:	04b2                	slli	s1,s1,0xc
  for(int level = 2; level > 0; level--) {
    800010e2:	3a5d                	addiw	s4,s4,-9
    800010e4:	ff5a12e3          	bne	s4,s5,800010c8 <walk+0x26>
        return 0;
      memset(pagetable, 0, PGSIZE);
      *pte = PA2PTE(pagetable) | PTE_V;
    }
  }
  return &pagetable[PX(0, va)];
    800010e8:	00c9d513          	srli	a0,s3,0xc
    800010ec:	1ff57513          	andi	a0,a0,511
    800010f0:	050e                	slli	a0,a0,0x3
    800010f2:	9526                	add	a0,a0,s1
}
    800010f4:	70e2                	ld	ra,56(sp)
    800010f6:	7442                	ld	s0,48(sp)
    800010f8:	74a2                	ld	s1,40(sp)
    800010fa:	7902                	ld	s2,32(sp)
    800010fc:	69e2                	ld	s3,24(sp)
    800010fe:	6a42                	ld	s4,16(sp)
    80001100:	6aa2                	ld	s5,8(sp)
    80001102:	6b02                	ld	s6,0(sp)
    80001104:	6121                	addi	sp,sp,64
    80001106:	8082                	ret
    panic("walk");
    80001108:	00007517          	auipc	a0,0x7
    8000110c:	23050513          	addi	a0,a0,560 # 80008338 <userret+0x2a8>
    80001110:	fffff097          	auipc	ra,0xfffff
    80001114:	45a080e7          	jalr	1114(ra) # 8000056a <panic>
      if(!alloc || (pagetable = (pde_t*)kalloc()) == 0)
    80001118:	020b0663          	beqz	s6,80001144 <walk+0xa2>
    8000111c:	00000097          	auipc	ra,0x0
    80001120:	8aa080e7          	jalr	-1878(ra) # 800009c6 <kalloc>
    80001124:	84aa                	mv	s1,a0
    80001126:	d579                	beqz	a0,800010f4 <walk+0x52>
      memset(pagetable, 0, PGSIZE);
    80001128:	6605                	lui	a2,0x1
    8000112a:	4581                	li	a1,0
    8000112c:	00000097          	auipc	ra,0x0
    80001130:	c92080e7          	jalr	-878(ra) # 80000dbe <memset>
      *pte = PA2PTE(pagetable) | PTE_V;
    80001134:	00c4d793          	srli	a5,s1,0xc
    80001138:	07aa                	slli	a5,a5,0xa
    8000113a:	0017e793          	ori	a5,a5,1
    8000113e:	00f93023          	sd	a5,0(s2)
    80001142:	b745                	j	800010e2 <walk+0x40>
        return 0;
    80001144:	4501                	li	a0,0
    80001146:	b77d                	j	800010f4 <walk+0x52>

0000000080001148 <freewalk>:

// Recursively free page-table pages.
// All leaf mappings must already have been removed.
static void
freewalk(pagetable_t pagetable)
{
    80001148:	7179                	addi	sp,sp,-48
    8000114a:	f406                	sd	ra,40(sp)
    8000114c:	f022                	sd	s0,32(sp)
    8000114e:	ec26                	sd	s1,24(sp)
    80001150:	e84a                	sd	s2,16(sp)
    80001152:	e44e                	sd	s3,8(sp)
    80001154:	1800                	addi	s0,sp,48
    80001156:	89aa                	mv	s3,a0
  // there are 2^9 = 512 PTEs in a page table.
  for(int i = 0; i < 512; i++){
    80001158:	84aa                	mv	s1,a0
    8000115a:	6905                	lui	s2,0x1
    8000115c:	992a                	add	s2,s2,a0
    8000115e:	a821                	j	80001176 <freewalk+0x2e>
      // this PTE points to a lower-level page table.
      uint64 child = PTE2PA(pte);
      freewalk((pagetable_t)child);
      pagetable[i] = 0;
    } else if(pte & PTE_V){
      panic("freewalk: leaf");
    80001160:	00007517          	auipc	a0,0x7
    80001164:	1e050513          	addi	a0,a0,480 # 80008340 <userret+0x2b0>
    80001168:	fffff097          	auipc	ra,0xfffff
    8000116c:	402080e7          	jalr	1026(ra) # 8000056a <panic>
  for(int i = 0; i < 512; i++){
    80001170:	04a1                	addi	s1,s1,8
    80001172:	03248363          	beq	s1,s2,80001198 <freewalk+0x50>
    pte_t pte = pagetable[i];
    80001176:	609c                	ld	a5,0(s1)
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    80001178:	0017f713          	andi	a4,a5,1
    8000117c:	db75                	beqz	a4,80001170 <freewalk+0x28>
    8000117e:	00e7f713          	andi	a4,a5,14
    80001182:	ff79                	bnez	a4,80001160 <freewalk+0x18>
      uint64 child = PTE2PA(pte);
    80001184:	83a9                	srli	a5,a5,0xa
      freewalk((pagetable_t)child);
    80001186:	00c79513          	slli	a0,a5,0xc
    8000118a:	00000097          	auipc	ra,0x0
    8000118e:	fbe080e7          	jalr	-66(ra) # 80001148 <freewalk>
      pagetable[i] = 0;
    80001192:	0004b023          	sd	zero,0(s1)
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    80001196:	bfe9                	j	80001170 <freewalk+0x28>
    }
  }
  kfree((void*)pagetable);
    80001198:	854e                	mv	a0,s3
    8000119a:	fffff097          	auipc	ra,0xfffff
    8000119e:	728080e7          	jalr	1832(ra) # 800008c2 <kfree>
}
    800011a2:	70a2                	ld	ra,40(sp)
    800011a4:	7402                	ld	s0,32(sp)
    800011a6:	64e2                	ld	s1,24(sp)
    800011a8:	6942                	ld	s2,16(sp)
    800011aa:	69a2                	ld	s3,8(sp)
    800011ac:	6145                	addi	sp,sp,48
    800011ae:	8082                	ret

00000000800011b0 <kvminithart>:
{
    800011b0:	1141                	addi	sp,sp,-16
    800011b2:	e406                	sd	ra,8(sp)
    800011b4:	e022                	sd	s0,0(sp)
    800011b6:	0800                	addi	s0,sp,16
  w_satp(MAKE_SATP(kernel_pagetable));
    800011b8:	00027797          	auipc	a5,0x27
    800011bc:	e787b783          	ld	a5,-392(a5) # 80028030 <kernel_pagetable>
    800011c0:	83b1                	srli	a5,a5,0xc
    800011c2:	577d                	li	a4,-1
    800011c4:	177e                	slli	a4,a4,0x3f
    800011c6:	8fd9                	or	a5,a5,a4
  asm volatile("csrw satp, %0" : : "r" (x));
    800011c8:	18079073          	csrw	satp,a5
// flush the TLB.
static inline void
sfence_vma()
{
  // the zero, zero means flush all TLB entries.
  asm volatile("sfence.vma zero, zero");
    800011cc:	12000073          	sfence.vma
}
    800011d0:	60a2                	ld	ra,8(sp)
    800011d2:	6402                	ld	s0,0(sp)
    800011d4:	0141                	addi	sp,sp,16
    800011d6:	8082                	ret

00000000800011d8 <walkaddr>:
  if(va >= MAXVA)
    800011d8:	57fd                	li	a5,-1
    800011da:	83e9                	srli	a5,a5,0x1a
    800011dc:	00b7f463          	bgeu	a5,a1,800011e4 <walkaddr+0xc>
    return 0;
    800011e0:	4501                	li	a0,0
}
    800011e2:	8082                	ret
{
    800011e4:	1141                	addi	sp,sp,-16
    800011e6:	e406                	sd	ra,8(sp)
    800011e8:	e022                	sd	s0,0(sp)
    800011ea:	0800                	addi	s0,sp,16
  pte = walk(pagetable, va, 0);
    800011ec:	4601                	li	a2,0
    800011ee:	00000097          	auipc	ra,0x0
    800011f2:	eb4080e7          	jalr	-332(ra) # 800010a2 <walk>
  if(pte == 0)
    800011f6:	c901                	beqz	a0,80001206 <walkaddr+0x2e>
  if((*pte & PTE_V) == 0)
    800011f8:	611c                	ld	a5,0(a0)
  if((*pte & PTE_U) == 0)
    800011fa:	0117f693          	andi	a3,a5,17
    800011fe:	4745                	li	a4,17
    return 0;
    80001200:	4501                	li	a0,0
  if((*pte & PTE_U) == 0)
    80001202:	00e68663          	beq	a3,a4,8000120e <walkaddr+0x36>
}
    80001206:	60a2                	ld	ra,8(sp)
    80001208:	6402                	ld	s0,0(sp)
    8000120a:	0141                	addi	sp,sp,16
    8000120c:	8082                	ret
  pa = PTE2PA(*pte);
    8000120e:	83a9                	srli	a5,a5,0xa
    80001210:	00c79513          	slli	a0,a5,0xc
  return pa;
    80001214:	bfcd                	j	80001206 <walkaddr+0x2e>

0000000080001216 <kvmpa>:
{
    80001216:	1101                	addi	sp,sp,-32
    80001218:	ec06                	sd	ra,24(sp)
    8000121a:	e822                	sd	s0,16(sp)
    8000121c:	e426                	sd	s1,8(sp)
    8000121e:	1000                	addi	s0,sp,32
    80001220:	84aa                	mv	s1,a0
  pte = walk(kernel_pagetable, va, 0);
    80001222:	4601                	li	a2,0
    80001224:	85aa                	mv	a1,a0
    80001226:	00027517          	auipc	a0,0x27
    8000122a:	e0a53503          	ld	a0,-502(a0) # 80028030 <kernel_pagetable>
    8000122e:	00000097          	auipc	ra,0x0
    80001232:	e74080e7          	jalr	-396(ra) # 800010a2 <walk>
  if(pte == 0)
    80001236:	cd19                	beqz	a0,80001254 <kvmpa+0x3e>
  if((*pte & PTE_V) == 0)
    80001238:	6108                	ld	a0,0(a0)
    8000123a:	00157793          	andi	a5,a0,1
    8000123e:	c39d                	beqz	a5,80001264 <kvmpa+0x4e>
  pa = PTE2PA(*pte);
    80001240:	8129                	srli	a0,a0,0xa
    80001242:	0532                	slli	a0,a0,0xc
  uint64 off = va % PGSIZE;
    80001244:	14d2                	slli	s1,s1,0x34
    80001246:	90d1                	srli	s1,s1,0x34
}
    80001248:	9526                	add	a0,a0,s1
    8000124a:	60e2                	ld	ra,24(sp)
    8000124c:	6442                	ld	s0,16(sp)
    8000124e:	64a2                	ld	s1,8(sp)
    80001250:	6105                	addi	sp,sp,32
    80001252:	8082                	ret
    panic("kvmpa");
    80001254:	00007517          	auipc	a0,0x7
    80001258:	0fc50513          	addi	a0,a0,252 # 80008350 <userret+0x2c0>
    8000125c:	fffff097          	auipc	ra,0xfffff
    80001260:	30e080e7          	jalr	782(ra) # 8000056a <panic>
    panic("kvmpa");
    80001264:	00007517          	auipc	a0,0x7
    80001268:	0ec50513          	addi	a0,a0,236 # 80008350 <userret+0x2c0>
    8000126c:	fffff097          	auipc	ra,0xfffff
    80001270:	2fe080e7          	jalr	766(ra) # 8000056a <panic>

0000000080001274 <mappages>:
{
    80001274:	715d                	addi	sp,sp,-80
    80001276:	e486                	sd	ra,72(sp)
    80001278:	e0a2                	sd	s0,64(sp)
    8000127a:	fc26                	sd	s1,56(sp)
    8000127c:	f84a                	sd	s2,48(sp)
    8000127e:	f44e                	sd	s3,40(sp)
    80001280:	f052                	sd	s4,32(sp)
    80001282:	ec56                	sd	s5,24(sp)
    80001284:	e85a                	sd	s6,16(sp)
    80001286:	e45e                	sd	s7,8(sp)
    80001288:	0880                	addi	s0,sp,80
    8000128a:	89aa                	mv	s3,a0
    8000128c:	8aba                	mv	s5,a4
  a = PGROUNDDOWN(va);
    8000128e:	777d                	lui	a4,0xfffff
    80001290:	00e5f7b3          	and	a5,a1,a4
  last = PGROUNDDOWN(va + size - 1);
    80001294:	fff60913          	addi	s2,a2,-1 # fff <_entry-0x7ffff001>
    80001298:	992e                	add	s2,s2,a1
    8000129a:	00e97933          	and	s2,s2,a4
  a = PGROUNDDOWN(va);
    8000129e:	84be                	mv	s1,a5
    if((pte = walk(pagetable, a, 1)) == 0)
    800012a0:	4b05                	li	s6,1
    800012a2:	40f68a33          	sub	s4,a3,a5
    a += PGSIZE;
    800012a6:	6b85                	lui	s7,0x1
    if((pte = walk(pagetable, a, 1)) == 0)
    800012a8:	865a                	mv	a2,s6
    800012aa:	85a6                	mv	a1,s1
    800012ac:	854e                	mv	a0,s3
    800012ae:	00000097          	auipc	ra,0x0
    800012b2:	df4080e7          	jalr	-524(ra) # 800010a2 <walk>
    800012b6:	c90d                	beqz	a0,800012e8 <mappages+0x74>
    if(*pte & PTE_V)
    800012b8:	611c                	ld	a5,0(a0)
    800012ba:	8b85                	andi	a5,a5,1
    800012bc:	ef91                	bnez	a5,800012d8 <mappages+0x64>
    *pte = PA2PTE(pa) | perm | PTE_V;
    800012be:	014487b3          	add	a5,s1,s4
    800012c2:	83b1                	srli	a5,a5,0xc
    800012c4:	07aa                	slli	a5,a5,0xa
    800012c6:	0157e7b3          	or	a5,a5,s5
    800012ca:	0017e793          	ori	a5,a5,1
    800012ce:	e11c                	sd	a5,0(a0)
    if(a == last)
    800012d0:	03248863          	beq	s1,s2,80001300 <mappages+0x8c>
    a += PGSIZE;
    800012d4:	94de                	add	s1,s1,s7
    if((pte = walk(pagetable, a, 1)) == 0)
    800012d6:	bfc9                	j	800012a8 <mappages+0x34>
      panic("remap");
    800012d8:	00007517          	auipc	a0,0x7
    800012dc:	08050513          	addi	a0,a0,128 # 80008358 <userret+0x2c8>
    800012e0:	fffff097          	auipc	ra,0xfffff
    800012e4:	28a080e7          	jalr	650(ra) # 8000056a <panic>
      return -1;
    800012e8:	557d                	li	a0,-1
}
    800012ea:	60a6                	ld	ra,72(sp)
    800012ec:	6406                	ld	s0,64(sp)
    800012ee:	74e2                	ld	s1,56(sp)
    800012f0:	7942                	ld	s2,48(sp)
    800012f2:	79a2                	ld	s3,40(sp)
    800012f4:	7a02                	ld	s4,32(sp)
    800012f6:	6ae2                	ld	s5,24(sp)
    800012f8:	6b42                	ld	s6,16(sp)
    800012fa:	6ba2                	ld	s7,8(sp)
    800012fc:	6161                	addi	sp,sp,80
    800012fe:	8082                	ret
  return 0;
    80001300:	4501                	li	a0,0
    80001302:	b7e5                	j	800012ea <mappages+0x76>

0000000080001304 <kvmmap>:
{
    80001304:	1141                	addi	sp,sp,-16
    80001306:	e406                	sd	ra,8(sp)
    80001308:	e022                	sd	s0,0(sp)
    8000130a:	0800                	addi	s0,sp,16
    8000130c:	8736                	mv	a4,a3
  if(mappages(kernel_pagetable, va, sz, pa, perm) != 0)
    8000130e:	86ae                	mv	a3,a1
    80001310:	85aa                	mv	a1,a0
    80001312:	00027517          	auipc	a0,0x27
    80001316:	d1e53503          	ld	a0,-738(a0) # 80028030 <kernel_pagetable>
    8000131a:	00000097          	auipc	ra,0x0
    8000131e:	f5a080e7          	jalr	-166(ra) # 80001274 <mappages>
    80001322:	e509                	bnez	a0,8000132c <kvmmap+0x28>
}
    80001324:	60a2                	ld	ra,8(sp)
    80001326:	6402                	ld	s0,0(sp)
    80001328:	0141                	addi	sp,sp,16
    8000132a:	8082                	ret
    panic("kvmmap");
    8000132c:	00007517          	auipc	a0,0x7
    80001330:	03450513          	addi	a0,a0,52 # 80008360 <userret+0x2d0>
    80001334:	fffff097          	auipc	ra,0xfffff
    80001338:	236080e7          	jalr	566(ra) # 8000056a <panic>

000000008000133c <kvminit>:
{
    8000133c:	1141                	addi	sp,sp,-16
    8000133e:	e406                	sd	ra,8(sp)
    80001340:	e022                	sd	s0,0(sp)
    80001342:	0800                	addi	s0,sp,16
  kernel_pagetable = (pagetable_t) kalloc();
    80001344:	fffff097          	auipc	ra,0xfffff
    80001348:	682080e7          	jalr	1666(ra) # 800009c6 <kalloc>
    8000134c:	00027717          	auipc	a4,0x27
    80001350:	cea73223          	sd	a0,-796(a4) # 80028030 <kernel_pagetable>
  memset(kernel_pagetable, 0, PGSIZE);
    80001354:	6605                	lui	a2,0x1
    80001356:	4581                	li	a1,0
    80001358:	00000097          	auipc	ra,0x0
    8000135c:	a66080e7          	jalr	-1434(ra) # 80000dbe <memset>
  kvmmap(UART0, UART0, PGSIZE, PTE_R | PTE_W);
    80001360:	4699                	li	a3,6
    80001362:	6605                	lui	a2,0x1
    80001364:	100005b7          	lui	a1,0x10000
    80001368:	852e                	mv	a0,a1
    8000136a:	00000097          	auipc	ra,0x0
    8000136e:	f9a080e7          	jalr	-102(ra) # 80001304 <kvmmap>
  kvmmap(VIRTION(0), VIRTION(0), PGSIZE, PTE_R | PTE_W);
    80001372:	4699                	li	a3,6
    80001374:	6605                	lui	a2,0x1
    80001376:	100015b7          	lui	a1,0x10001
    8000137a:	852e                	mv	a0,a1
    8000137c:	00000097          	auipc	ra,0x0
    80001380:	f88080e7          	jalr	-120(ra) # 80001304 <kvmmap>
  kvmmap(VIRTION(1), VIRTION(1), PGSIZE, PTE_R | PTE_W);
    80001384:	4699                	li	a3,6
    80001386:	6605                	lui	a2,0x1
    80001388:	100025b7          	lui	a1,0x10002
    8000138c:	852e                	mv	a0,a1
    8000138e:	00000097          	auipc	ra,0x0
    80001392:	f76080e7          	jalr	-138(ra) # 80001304 <kvmmap>
  kvmmap(CLINT, CLINT, 0x10000, PTE_R | PTE_W);
    80001396:	4699                	li	a3,6
    80001398:	6641                	lui	a2,0x10
    8000139a:	020005b7          	lui	a1,0x2000
    8000139e:	852e                	mv	a0,a1
    800013a0:	00000097          	auipc	ra,0x0
    800013a4:	f64080e7          	jalr	-156(ra) # 80001304 <kvmmap>
  kvmmap(PLIC, PLIC, 0x400000, PTE_R | PTE_W);
    800013a8:	4699                	li	a3,6
    800013aa:	00400637          	lui	a2,0x400
    800013ae:	0c0005b7          	lui	a1,0xc000
    800013b2:	852e                	mv	a0,a1
    800013b4:	00000097          	auipc	ra,0x0
    800013b8:	f50080e7          	jalr	-176(ra) # 80001304 <kvmmap>
  kvmmap(KERNBASE, KERNBASE, (uint64)etext-KERNBASE, PTE_R | PTE_X);
    800013bc:	46a9                	li	a3,10
    800013be:	80008617          	auipc	a2,0x80008
    800013c2:	c4260613          	addi	a2,a2,-958 # 9000 <_entry-0x7fff7000>
    800013c6:	4585                	li	a1,1
    800013c8:	05fe                	slli	a1,a1,0x1f
    800013ca:	852e                	mv	a0,a1
    800013cc:	00000097          	auipc	ra,0x0
    800013d0:	f38080e7          	jalr	-200(ra) # 80001304 <kvmmap>
  kvmmap((uint64)etext, (uint64)etext, PHYSTOP-(uint64)etext, PTE_R | PTE_W);
    800013d4:	4699                	li	a3,6
    800013d6:	00008617          	auipc	a2,0x8
    800013da:	c2a60613          	addi	a2,a2,-982 # 80009000 <initcode>
    800013de:	47c5                	li	a5,17
    800013e0:	07ee                	slli	a5,a5,0x1b
    800013e2:	40c78633          	sub	a2,a5,a2
    800013e6:	00008597          	auipc	a1,0x8
    800013ea:	c1a58593          	addi	a1,a1,-998 # 80009000 <initcode>
    800013ee:	852e                	mv	a0,a1
    800013f0:	00000097          	auipc	ra,0x0
    800013f4:	f14080e7          	jalr	-236(ra) # 80001304 <kvmmap>
  kvmmap(TRAMPOLINE, (uint64)trampoline, PGSIZE, PTE_R | PTE_X);
    800013f8:	46a9                	li	a3,10
    800013fa:	6605                	lui	a2,0x1
    800013fc:	00007597          	auipc	a1,0x7
    80001400:	c0458593          	addi	a1,a1,-1020 # 80008000 <trampoline>
    80001404:	04000537          	lui	a0,0x4000
    80001408:	157d                	addi	a0,a0,-1 # 3ffffff <_entry-0x7c000001>
    8000140a:	0532                	slli	a0,a0,0xc
    8000140c:	00000097          	auipc	ra,0x0
    80001410:	ef8080e7          	jalr	-264(ra) # 80001304 <kvmmap>
}
    80001414:	60a2                	ld	ra,8(sp)
    80001416:	6402                	ld	s0,0(sp)
    80001418:	0141                	addi	sp,sp,16
    8000141a:	8082                	ret

000000008000141c <uvmunmap>:
{
    8000141c:	715d                	addi	sp,sp,-80
    8000141e:	e486                	sd	ra,72(sp)
    80001420:	e0a2                	sd	s0,64(sp)
    80001422:	fc26                	sd	s1,56(sp)
    80001424:	f84a                	sd	s2,48(sp)
    80001426:	f44e                	sd	s3,40(sp)
    80001428:	f052                	sd	s4,32(sp)
    8000142a:	ec56                	sd	s5,24(sp)
    8000142c:	e85a                	sd	s6,16(sp)
    8000142e:	e45e                	sd	s7,8(sp)
    80001430:	0880                	addi	s0,sp,80
    80001432:	8a2a                	mv	s4,a0
    80001434:	8ab6                	mv	s5,a3
  a = PGROUNDDOWN(va);
    80001436:	77fd                	lui	a5,0xfffff
    80001438:	00f5f933          	and	s2,a1,a5
  last = PGROUNDDOWN(va + size - 1);
    8000143c:	fff60993          	addi	s3,a2,-1 # fff <_entry-0x7ffff001>
    80001440:	99ae                	add	s3,s3,a1
    80001442:	00f9f9b3          	and	s3,s3,a5
    if(PTE_FLAGS(*pte) == PTE_V)
    80001446:	4b05                	li	s6,1
    a += PGSIZE;
    80001448:	6b85                	lui	s7,0x1
    8000144a:	a0b9                	j	80001498 <uvmunmap+0x7c>
      panic("uvmunmap: walk");
    8000144c:	00007517          	auipc	a0,0x7
    80001450:	f1c50513          	addi	a0,a0,-228 # 80008368 <userret+0x2d8>
    80001454:	fffff097          	auipc	ra,0xfffff
    80001458:	116080e7          	jalr	278(ra) # 8000056a <panic>
      printf("va=%p pte=%p\n", a, *pte);
    8000145c:	85ca                	mv	a1,s2
    8000145e:	00007517          	auipc	a0,0x7
    80001462:	f1a50513          	addi	a0,a0,-230 # 80008378 <userret+0x2e8>
    80001466:	fffff097          	auipc	ra,0xfffff
    8000146a:	15e080e7          	jalr	350(ra) # 800005c4 <printf>
      panic("uvmunmap: not mapped");
    8000146e:	00007517          	auipc	a0,0x7
    80001472:	f1a50513          	addi	a0,a0,-230 # 80008388 <userret+0x2f8>
    80001476:	fffff097          	auipc	ra,0xfffff
    8000147a:	0f4080e7          	jalr	244(ra) # 8000056a <panic>
      panic("uvmunmap: not a leaf");
    8000147e:	00007517          	auipc	a0,0x7
    80001482:	f2250513          	addi	a0,a0,-222 # 800083a0 <userret+0x310>
    80001486:	fffff097          	auipc	ra,0xfffff
    8000148a:	0e4080e7          	jalr	228(ra) # 8000056a <panic>
    *pte = 0;
    8000148e:	0004b023          	sd	zero,0(s1)
    if(a == last)
    80001492:	03390e63          	beq	s2,s3,800014ce <uvmunmap+0xb2>
    a += PGSIZE;
    80001496:	995e                	add	s2,s2,s7
    if((pte = walk(pagetable, a, 0)) == 0)
    80001498:	4601                	li	a2,0
    8000149a:	85ca                	mv	a1,s2
    8000149c:	8552                	mv	a0,s4
    8000149e:	00000097          	auipc	ra,0x0
    800014a2:	c04080e7          	jalr	-1020(ra) # 800010a2 <walk>
    800014a6:	84aa                	mv	s1,a0
    800014a8:	d155                	beqz	a0,8000144c <uvmunmap+0x30>
    if((*pte & PTE_V) == 0){
    800014aa:	6110                	ld	a2,0(a0)
    800014ac:	00167793          	andi	a5,a2,1
    800014b0:	d7d5                	beqz	a5,8000145c <uvmunmap+0x40>
    if(PTE_FLAGS(*pte) == PTE_V)
    800014b2:	3ff67793          	andi	a5,a2,1023
    800014b6:	fd6784e3          	beq	a5,s6,8000147e <uvmunmap+0x62>
    if(do_free){
    800014ba:	fc0a8ae3          	beqz	s5,8000148e <uvmunmap+0x72>
      pa = PTE2PA(*pte);
    800014be:	8229                	srli	a2,a2,0xa
      kfree((void*)pa);
    800014c0:	00c61513          	slli	a0,a2,0xc
    800014c4:	fffff097          	auipc	ra,0xfffff
    800014c8:	3fe080e7          	jalr	1022(ra) # 800008c2 <kfree>
    800014cc:	b7c9                	j	8000148e <uvmunmap+0x72>
}
    800014ce:	60a6                	ld	ra,72(sp)
    800014d0:	6406                	ld	s0,64(sp)
    800014d2:	74e2                	ld	s1,56(sp)
    800014d4:	7942                	ld	s2,48(sp)
    800014d6:	79a2                	ld	s3,40(sp)
    800014d8:	7a02                	ld	s4,32(sp)
    800014da:	6ae2                	ld	s5,24(sp)
    800014dc:	6b42                	ld	s6,16(sp)
    800014de:	6ba2                	ld	s7,8(sp)
    800014e0:	6161                	addi	sp,sp,80
    800014e2:	8082                	ret

00000000800014e4 <uvmcreate>:
{
    800014e4:	1101                	addi	sp,sp,-32
    800014e6:	ec06                	sd	ra,24(sp)
    800014e8:	e822                	sd	s0,16(sp)
    800014ea:	e426                	sd	s1,8(sp)
    800014ec:	1000                	addi	s0,sp,32
  pagetable = (pagetable_t) kalloc();
    800014ee:	fffff097          	auipc	ra,0xfffff
    800014f2:	4d8080e7          	jalr	1240(ra) # 800009c6 <kalloc>
  if(pagetable == 0)
    800014f6:	cd11                	beqz	a0,80001512 <uvmcreate+0x2e>
    800014f8:	84aa                	mv	s1,a0
  memset(pagetable, 0, PGSIZE);
    800014fa:	6605                	lui	a2,0x1
    800014fc:	4581                	li	a1,0
    800014fe:	00000097          	auipc	ra,0x0
    80001502:	8c0080e7          	jalr	-1856(ra) # 80000dbe <memset>
}
    80001506:	8526                	mv	a0,s1
    80001508:	60e2                	ld	ra,24(sp)
    8000150a:	6442                	ld	s0,16(sp)
    8000150c:	64a2                	ld	s1,8(sp)
    8000150e:	6105                	addi	sp,sp,32
    80001510:	8082                	ret
    panic("uvmcreate: out of memory");
    80001512:	00007517          	auipc	a0,0x7
    80001516:	ea650513          	addi	a0,a0,-346 # 800083b8 <userret+0x328>
    8000151a:	fffff097          	auipc	ra,0xfffff
    8000151e:	050080e7          	jalr	80(ra) # 8000056a <panic>

0000000080001522 <uvminit>:
{
    80001522:	7179                	addi	sp,sp,-48
    80001524:	f406                	sd	ra,40(sp)
    80001526:	f022                	sd	s0,32(sp)
    80001528:	ec26                	sd	s1,24(sp)
    8000152a:	e84a                	sd	s2,16(sp)
    8000152c:	e44e                	sd	s3,8(sp)
    8000152e:	e052                	sd	s4,0(sp)
    80001530:	1800                	addi	s0,sp,48
  if(sz >= PGSIZE)
    80001532:	6785                	lui	a5,0x1
    80001534:	04f67863          	bgeu	a2,a5,80001584 <uvminit+0x62>
    80001538:	89aa                	mv	s3,a0
    8000153a:	8a2e                	mv	s4,a1
    8000153c:	84b2                	mv	s1,a2
  mem = kalloc();
    8000153e:	fffff097          	auipc	ra,0xfffff
    80001542:	488080e7          	jalr	1160(ra) # 800009c6 <kalloc>
    80001546:	892a                	mv	s2,a0
  memset(mem, 0, PGSIZE);
    80001548:	6605                	lui	a2,0x1
    8000154a:	4581                	li	a1,0
    8000154c:	00000097          	auipc	ra,0x0
    80001550:	872080e7          	jalr	-1934(ra) # 80000dbe <memset>
  mappages(pagetable, 0, PGSIZE, (uint64)mem, PTE_W|PTE_R|PTE_X|PTE_U);
    80001554:	4779                	li	a4,30
    80001556:	86ca                	mv	a3,s2
    80001558:	6605                	lui	a2,0x1
    8000155a:	4581                	li	a1,0
    8000155c:	854e                	mv	a0,s3
    8000155e:	00000097          	auipc	ra,0x0
    80001562:	d16080e7          	jalr	-746(ra) # 80001274 <mappages>
  memmove(mem, src, sz);
    80001566:	8626                	mv	a2,s1
    80001568:	85d2                	mv	a1,s4
    8000156a:	854a                	mv	a0,s2
    8000156c:	00000097          	auipc	ra,0x0
    80001570:	8b2080e7          	jalr	-1870(ra) # 80000e1e <memmove>
}
    80001574:	70a2                	ld	ra,40(sp)
    80001576:	7402                	ld	s0,32(sp)
    80001578:	64e2                	ld	s1,24(sp)
    8000157a:	6942                	ld	s2,16(sp)
    8000157c:	69a2                	ld	s3,8(sp)
    8000157e:	6a02                	ld	s4,0(sp)
    80001580:	6145                	addi	sp,sp,48
    80001582:	8082                	ret
    panic("inituvm: more than a page");
    80001584:	00007517          	auipc	a0,0x7
    80001588:	e5450513          	addi	a0,a0,-428 # 800083d8 <userret+0x348>
    8000158c:	fffff097          	auipc	ra,0xfffff
    80001590:	fde080e7          	jalr	-34(ra) # 8000056a <panic>

0000000080001594 <uvmdealloc>:
{
    80001594:	1101                	addi	sp,sp,-32
    80001596:	ec06                	sd	ra,24(sp)
    80001598:	e822                	sd	s0,16(sp)
    8000159a:	e426                	sd	s1,8(sp)
    8000159c:	1000                	addi	s0,sp,32
    return oldsz;
    8000159e:	84ae                	mv	s1,a1
  if(newsz >= oldsz)
    800015a0:	00b67d63          	bgeu	a2,a1,800015ba <uvmdealloc+0x26>
    800015a4:	84b2                	mv	s1,a2
  uint64 newup = PGROUNDUP(newsz);
    800015a6:	6785                	lui	a5,0x1
    800015a8:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    800015aa:	00f60733          	add	a4,a2,a5
    800015ae:	76fd                	lui	a3,0xfffff
    800015b0:	8f75                	and	a4,a4,a3
  if(newup < PGROUNDUP(oldsz))
    800015b2:	97ae                	add	a5,a5,a1
    800015b4:	8ff5                	and	a5,a5,a3
    800015b6:	00f76863          	bltu	a4,a5,800015c6 <uvmdealloc+0x32>
}
    800015ba:	8526                	mv	a0,s1
    800015bc:	60e2                	ld	ra,24(sp)
    800015be:	6442                	ld	s0,16(sp)
    800015c0:	64a2                	ld	s1,8(sp)
    800015c2:	6105                	addi	sp,sp,32
    800015c4:	8082                	ret
    uvmunmap(pagetable, newup, oldsz - newup, 1);
    800015c6:	4685                	li	a3,1
    800015c8:	40e58633          	sub	a2,a1,a4
    800015cc:	85ba                	mv	a1,a4
    800015ce:	00000097          	auipc	ra,0x0
    800015d2:	e4e080e7          	jalr	-434(ra) # 8000141c <uvmunmap>
    800015d6:	b7d5                	j	800015ba <uvmdealloc+0x26>

00000000800015d8 <uvmalloc>:
  if(newsz < oldsz)
    800015d8:	0ab66c63          	bltu	a2,a1,80001690 <uvmalloc+0xb8>
{
    800015dc:	715d                	addi	sp,sp,-80
    800015de:	e486                	sd	ra,72(sp)
    800015e0:	e0a2                	sd	s0,64(sp)
    800015e2:	f84a                	sd	s2,48(sp)
    800015e4:	f052                	sd	s4,32(sp)
    800015e6:	ec56                	sd	s5,24(sp)
    800015e8:	e45e                	sd	s7,8(sp)
    800015ea:	0880                	addi	s0,sp,80
    800015ec:	8aaa                	mv	s5,a0
    800015ee:	8a32                	mv	s4,a2
  oldsz = PGROUNDUP(oldsz);
    800015f0:	6785                	lui	a5,0x1
    800015f2:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    800015f4:	95be                	add	a1,a1,a5
    800015f6:	77fd                	lui	a5,0xfffff
    800015f8:	00f5f933          	and	s2,a1,a5
    800015fc:	8bca                	mv	s7,s2
  for(; a < newsz; a += PGSIZE){
    800015fe:	08c97b63          	bgeu	s2,a2,80001694 <uvmalloc+0xbc>
    80001602:	fc26                	sd	s1,56(sp)
    80001604:	f44e                	sd	s3,40(sp)
    80001606:	e85a                	sd	s6,16(sp)
    memset(mem, 0, PGSIZE);
    80001608:	6985                	lui	s3,0x1
    if(mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_W|PTE_X|PTE_R|PTE_U) != 0){
    8000160a:	4b79                	li	s6,30
    mem = kalloc();
    8000160c:	fffff097          	auipc	ra,0xfffff
    80001610:	3ba080e7          	jalr	954(ra) # 800009c6 <kalloc>
    80001614:	84aa                	mv	s1,a0
    if(mem == 0){
    80001616:	c90d                	beqz	a0,80001648 <uvmalloc+0x70>
    memset(mem, 0, PGSIZE);
    80001618:	864e                	mv	a2,s3
    8000161a:	4581                	li	a1,0
    8000161c:	fffff097          	auipc	ra,0xfffff
    80001620:	7a2080e7          	jalr	1954(ra) # 80000dbe <memset>
    if(mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_W|PTE_X|PTE_R|PTE_U) != 0){
    80001624:	875a                	mv	a4,s6
    80001626:	86a6                	mv	a3,s1
    80001628:	864e                	mv	a2,s3
    8000162a:	85ca                	mv	a1,s2
    8000162c:	8556                	mv	a0,s5
    8000162e:	00000097          	auipc	ra,0x0
    80001632:	c46080e7          	jalr	-954(ra) # 80001274 <mappages>
    80001636:	ed05                	bnez	a0,8000166e <uvmalloc+0x96>
  for(; a < newsz; a += PGSIZE){
    80001638:	994e                	add	s2,s2,s3
    8000163a:	fd4969e3          	bltu	s2,s4,8000160c <uvmalloc+0x34>
  return newsz;
    8000163e:	8552                	mv	a0,s4
    80001640:	74e2                	ld	s1,56(sp)
    80001642:	79a2                	ld	s3,40(sp)
    80001644:	6b42                	ld	s6,16(sp)
    80001646:	a821                	j	8000165e <uvmalloc+0x86>
      uvmdealloc(pagetable, a, oldsz);
    80001648:	865e                	mv	a2,s7
    8000164a:	85ca                	mv	a1,s2
    8000164c:	8556                	mv	a0,s5
    8000164e:	00000097          	auipc	ra,0x0
    80001652:	f46080e7          	jalr	-186(ra) # 80001594 <uvmdealloc>
      return 0;
    80001656:	4501                	li	a0,0
    80001658:	74e2                	ld	s1,56(sp)
    8000165a:	79a2                	ld	s3,40(sp)
    8000165c:	6b42                	ld	s6,16(sp)
}
    8000165e:	60a6                	ld	ra,72(sp)
    80001660:	6406                	ld	s0,64(sp)
    80001662:	7942                	ld	s2,48(sp)
    80001664:	7a02                	ld	s4,32(sp)
    80001666:	6ae2                	ld	s5,24(sp)
    80001668:	6ba2                	ld	s7,8(sp)
    8000166a:	6161                	addi	sp,sp,80
    8000166c:	8082                	ret
      kfree(mem);
    8000166e:	8526                	mv	a0,s1
    80001670:	fffff097          	auipc	ra,0xfffff
    80001674:	252080e7          	jalr	594(ra) # 800008c2 <kfree>
      uvmdealloc(pagetable, a, oldsz);
    80001678:	865e                	mv	a2,s7
    8000167a:	85ca                	mv	a1,s2
    8000167c:	8556                	mv	a0,s5
    8000167e:	00000097          	auipc	ra,0x0
    80001682:	f16080e7          	jalr	-234(ra) # 80001594 <uvmdealloc>
      return 0;
    80001686:	4501                	li	a0,0
    80001688:	74e2                	ld	s1,56(sp)
    8000168a:	79a2                	ld	s3,40(sp)
    8000168c:	6b42                	ld	s6,16(sp)
    8000168e:	bfc1                	j	8000165e <uvmalloc+0x86>
    return oldsz;
    80001690:	852e                	mv	a0,a1
}
    80001692:	8082                	ret
  return newsz;
    80001694:	8532                	mv	a0,a2
    80001696:	b7e1                	j	8000165e <uvmalloc+0x86>

0000000080001698 <uvmfree>:

// Free user memory pages,
// then free page-table pages.
void
uvmfree(pagetable_t pagetable, uint64 sz)
{
    80001698:	1101                	addi	sp,sp,-32
    8000169a:	ec06                	sd	ra,24(sp)
    8000169c:	e822                	sd	s0,16(sp)
    8000169e:	e426                	sd	s1,8(sp)
    800016a0:	1000                	addi	s0,sp,32
    800016a2:	84aa                	mv	s1,a0
    800016a4:	862e                	mv	a2,a1
  uvmunmap(pagetable, 0, sz, 1);
    800016a6:	4685                	li	a3,1
    800016a8:	4581                	li	a1,0
    800016aa:	00000097          	auipc	ra,0x0
    800016ae:	d72080e7          	jalr	-654(ra) # 8000141c <uvmunmap>
  freewalk(pagetable);
    800016b2:	8526                	mv	a0,s1
    800016b4:	00000097          	auipc	ra,0x0
    800016b8:	a94080e7          	jalr	-1388(ra) # 80001148 <freewalk>
}
    800016bc:	60e2                	ld	ra,24(sp)
    800016be:	6442                	ld	s0,16(sp)
    800016c0:	64a2                	ld	s1,8(sp)
    800016c2:	6105                	addi	sp,sp,32
    800016c4:	8082                	ret

00000000800016c6 <uvmcopy>:
  pte_t *pte;
  uint64 pa, i;
  uint flags;
  char *mem;

  for(i = 0; i < sz; i += PGSIZE){
    800016c6:	c661                	beqz	a2,8000178e <uvmcopy+0xc8>
{
    800016c8:	715d                	addi	sp,sp,-80
    800016ca:	e486                	sd	ra,72(sp)
    800016cc:	e0a2                	sd	s0,64(sp)
    800016ce:	fc26                	sd	s1,56(sp)
    800016d0:	f84a                	sd	s2,48(sp)
    800016d2:	f44e                	sd	s3,40(sp)
    800016d4:	f052                	sd	s4,32(sp)
    800016d6:	ec56                	sd	s5,24(sp)
    800016d8:	e85a                	sd	s6,16(sp)
    800016da:	e45e                	sd	s7,8(sp)
    800016dc:	0880                	addi	s0,sp,80
    800016de:	8b2a                	mv	s6,a0
    800016e0:	8aae                	mv	s5,a1
    800016e2:	8a32                	mv	s4,a2
  for(i = 0; i < sz; i += PGSIZE){
    800016e4:	4901                	li	s2,0
      panic("uvmcopy: page not present");
    pa = PTE2PA(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto err;
    memmove(mem, (char*)pa, PGSIZE);
    800016e6:	6985                	lui	s3,0x1
    if((pte = walk(old, i, 0)) == 0)
    800016e8:	4601                	li	a2,0
    800016ea:	85ca                	mv	a1,s2
    800016ec:	855a                	mv	a0,s6
    800016ee:	00000097          	auipc	ra,0x0
    800016f2:	9b4080e7          	jalr	-1612(ra) # 800010a2 <walk>
    800016f6:	c139                	beqz	a0,8000173c <uvmcopy+0x76>
    if((*pte & PTE_V) == 0)
    800016f8:	00053b83          	ld	s7,0(a0)
    800016fc:	001bf793          	andi	a5,s7,1
    80001700:	c7b1                	beqz	a5,8000174c <uvmcopy+0x86>
    if((mem = kalloc()) == 0)
    80001702:	fffff097          	auipc	ra,0xfffff
    80001706:	2c4080e7          	jalr	708(ra) # 800009c6 <kalloc>
    8000170a:	84aa                	mv	s1,a0
    8000170c:	cd29                	beqz	a0,80001766 <uvmcopy+0xa0>
    pa = PTE2PA(*pte);
    8000170e:	00abd593          	srli	a1,s7,0xa
    memmove(mem, (char*)pa, PGSIZE);
    80001712:	864e                	mv	a2,s3
    80001714:	05b2                	slli	a1,a1,0xc
    80001716:	fffff097          	auipc	ra,0xfffff
    8000171a:	708080e7          	jalr	1800(ra) # 80000e1e <memmove>
    if(mappages(new, i, PGSIZE, (uint64)mem, flags) != 0){
    8000171e:	3ffbf713          	andi	a4,s7,1023
    80001722:	86a6                	mv	a3,s1
    80001724:	864e                	mv	a2,s3
    80001726:	85ca                	mv	a1,s2
    80001728:	8556                	mv	a0,s5
    8000172a:	00000097          	auipc	ra,0x0
    8000172e:	b4a080e7          	jalr	-1206(ra) # 80001274 <mappages>
    80001732:	e50d                	bnez	a0,8000175c <uvmcopy+0x96>
  for(i = 0; i < sz; i += PGSIZE){
    80001734:	994e                	add	s2,s2,s3
    80001736:	fb4969e3          	bltu	s2,s4,800016e8 <uvmcopy+0x22>
    8000173a:	a83d                	j	80001778 <uvmcopy+0xb2>
      panic("uvmcopy: pte should exist");
    8000173c:	00007517          	auipc	a0,0x7
    80001740:	cbc50513          	addi	a0,a0,-836 # 800083f8 <userret+0x368>
    80001744:	fffff097          	auipc	ra,0xfffff
    80001748:	e26080e7          	jalr	-474(ra) # 8000056a <panic>
      panic("uvmcopy: page not present");
    8000174c:	00007517          	auipc	a0,0x7
    80001750:	ccc50513          	addi	a0,a0,-820 # 80008418 <userret+0x388>
    80001754:	fffff097          	auipc	ra,0xfffff
    80001758:	e16080e7          	jalr	-490(ra) # 8000056a <panic>
      kfree(mem);
    8000175c:	8526                	mv	a0,s1
    8000175e:	fffff097          	auipc	ra,0xfffff
    80001762:	164080e7          	jalr	356(ra) # 800008c2 <kfree>
    }
  }
  return 0;

 err:
  uvmunmap(new, 0, i, 1);
    80001766:	4685                	li	a3,1
    80001768:	864a                	mv	a2,s2
    8000176a:	4581                	li	a1,0
    8000176c:	8556                	mv	a0,s5
    8000176e:	00000097          	auipc	ra,0x0
    80001772:	cae080e7          	jalr	-850(ra) # 8000141c <uvmunmap>
  return -1;
    80001776:	557d                	li	a0,-1
}
    80001778:	60a6                	ld	ra,72(sp)
    8000177a:	6406                	ld	s0,64(sp)
    8000177c:	74e2                	ld	s1,56(sp)
    8000177e:	7942                	ld	s2,48(sp)
    80001780:	79a2                	ld	s3,40(sp)
    80001782:	7a02                	ld	s4,32(sp)
    80001784:	6ae2                	ld	s5,24(sp)
    80001786:	6b42                	ld	s6,16(sp)
    80001788:	6ba2                	ld	s7,8(sp)
    8000178a:	6161                	addi	sp,sp,80
    8000178c:	8082                	ret
  return 0;
    8000178e:	4501                	li	a0,0
}
    80001790:	8082                	ret

0000000080001792 <uvmclear>:

// mark a PTE invalid for user access.
// used by exec for the user stack guard page.
void
uvmclear(pagetable_t pagetable, uint64 va)
{
    80001792:	1141                	addi	sp,sp,-16
    80001794:	e406                	sd	ra,8(sp)
    80001796:	e022                	sd	s0,0(sp)
    80001798:	0800                	addi	s0,sp,16
  pte_t *pte;
  
  pte = walk(pagetable, va, 0);
    8000179a:	4601                	li	a2,0
    8000179c:	00000097          	auipc	ra,0x0
    800017a0:	906080e7          	jalr	-1786(ra) # 800010a2 <walk>
  if(pte == 0)
    800017a4:	c901                	beqz	a0,800017b4 <uvmclear+0x22>
    panic("uvmclear");
  *pte &= ~PTE_U;
    800017a6:	611c                	ld	a5,0(a0)
    800017a8:	9bbd                	andi	a5,a5,-17
    800017aa:	e11c                	sd	a5,0(a0)
}
    800017ac:	60a2                	ld	ra,8(sp)
    800017ae:	6402                	ld	s0,0(sp)
    800017b0:	0141                	addi	sp,sp,16
    800017b2:	8082                	ret
    panic("uvmclear");
    800017b4:	00007517          	auipc	a0,0x7
    800017b8:	c8450513          	addi	a0,a0,-892 # 80008438 <userret+0x3a8>
    800017bc:	fffff097          	auipc	ra,0xfffff
    800017c0:	dae080e7          	jalr	-594(ra) # 8000056a <panic>

00000000800017c4 <copyout>:
int
copyout(pagetable_t pagetable, uint64 dstva, char *src, uint64 len)
{
  uint64 n, va0, pa0;

  while(len > 0){
    800017c4:	c6bd                	beqz	a3,80001832 <copyout+0x6e>
{
    800017c6:	715d                	addi	sp,sp,-80
    800017c8:	e486                	sd	ra,72(sp)
    800017ca:	e0a2                	sd	s0,64(sp)
    800017cc:	fc26                	sd	s1,56(sp)
    800017ce:	f84a                	sd	s2,48(sp)
    800017d0:	f44e                	sd	s3,40(sp)
    800017d2:	f052                	sd	s4,32(sp)
    800017d4:	ec56                	sd	s5,24(sp)
    800017d6:	e85a                	sd	s6,16(sp)
    800017d8:	e45e                	sd	s7,8(sp)
    800017da:	e062                	sd	s8,0(sp)
    800017dc:	0880                	addi	s0,sp,80
    800017de:	8b2a                	mv	s6,a0
    800017e0:	8c2e                	mv	s8,a1
    800017e2:	8a32                	mv	s4,a2
    800017e4:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(dstva);
    800017e6:	7bfd                	lui	s7,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (dstva - va0);
    800017e8:	6a85                	lui	s5,0x1
    800017ea:	a015                	j	8000180e <copyout+0x4a>
    if(n > len)
      n = len;
    memmove((void *)(pa0 + (dstva - va0)), src, n);
    800017ec:	9562                	add	a0,a0,s8
    800017ee:	0004861b          	sext.w	a2,s1
    800017f2:	85d2                	mv	a1,s4
    800017f4:	41250533          	sub	a0,a0,s2
    800017f8:	fffff097          	auipc	ra,0xfffff
    800017fc:	626080e7          	jalr	1574(ra) # 80000e1e <memmove>

    len -= n;
    80001800:	409989b3          	sub	s3,s3,s1
    src += n;
    80001804:	9a26                	add	s4,s4,s1
    dstva = va0 + PGSIZE;
    80001806:	01590c33          	add	s8,s2,s5
  while(len > 0){
    8000180a:	02098263          	beqz	s3,8000182e <copyout+0x6a>
    va0 = PGROUNDDOWN(dstva);
    8000180e:	017c7933          	and	s2,s8,s7
    pa0 = walkaddr(pagetable, va0);
    80001812:	85ca                	mv	a1,s2
    80001814:	855a                	mv	a0,s6
    80001816:	00000097          	auipc	ra,0x0
    8000181a:	9c2080e7          	jalr	-1598(ra) # 800011d8 <walkaddr>
    if(pa0 == 0)
    8000181e:	cd01                	beqz	a0,80001836 <copyout+0x72>
    n = PGSIZE - (dstva - va0);
    80001820:	418904b3          	sub	s1,s2,s8
    80001824:	94d6                	add	s1,s1,s5
    if(n > len)
    80001826:	fc99f3e3          	bgeu	s3,s1,800017ec <copyout+0x28>
    8000182a:	84ce                	mv	s1,s3
    8000182c:	b7c1                	j	800017ec <copyout+0x28>
  }
  return 0;
    8000182e:	4501                	li	a0,0
    80001830:	a021                	j	80001838 <copyout+0x74>
    80001832:	4501                	li	a0,0
}
    80001834:	8082                	ret
      return -1;
    80001836:	557d                	li	a0,-1
}
    80001838:	60a6                	ld	ra,72(sp)
    8000183a:	6406                	ld	s0,64(sp)
    8000183c:	74e2                	ld	s1,56(sp)
    8000183e:	7942                	ld	s2,48(sp)
    80001840:	79a2                	ld	s3,40(sp)
    80001842:	7a02                	ld	s4,32(sp)
    80001844:	6ae2                	ld	s5,24(sp)
    80001846:	6b42                	ld	s6,16(sp)
    80001848:	6ba2                	ld	s7,8(sp)
    8000184a:	6c02                	ld	s8,0(sp)
    8000184c:	6161                	addi	sp,sp,80
    8000184e:	8082                	ret

0000000080001850 <copyin>:
int
copyin(pagetable_t pagetable, char *dst, uint64 srcva, uint64 len)
{
  uint64 n, va0, pa0;

  while(len > 0){
    80001850:	caa5                	beqz	a3,800018c0 <copyin+0x70>
{
    80001852:	715d                	addi	sp,sp,-80
    80001854:	e486                	sd	ra,72(sp)
    80001856:	e0a2                	sd	s0,64(sp)
    80001858:	fc26                	sd	s1,56(sp)
    8000185a:	f84a                	sd	s2,48(sp)
    8000185c:	f44e                	sd	s3,40(sp)
    8000185e:	f052                	sd	s4,32(sp)
    80001860:	ec56                	sd	s5,24(sp)
    80001862:	e85a                	sd	s6,16(sp)
    80001864:	e45e                	sd	s7,8(sp)
    80001866:	e062                	sd	s8,0(sp)
    80001868:	0880                	addi	s0,sp,80
    8000186a:	8b2a                	mv	s6,a0
    8000186c:	8a2e                	mv	s4,a1
    8000186e:	8c32                	mv	s8,a2
    80001870:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(srcva);
    80001872:	7bfd                	lui	s7,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (srcva - va0);
    80001874:	6a85                	lui	s5,0x1
    80001876:	a01d                	j	8000189c <copyin+0x4c>
    if(n > len)
      n = len;
    memmove(dst, (void *)(pa0 + (srcva - va0)), n);
    80001878:	018505b3          	add	a1,a0,s8
    8000187c:	0004861b          	sext.w	a2,s1
    80001880:	412585b3          	sub	a1,a1,s2
    80001884:	8552                	mv	a0,s4
    80001886:	fffff097          	auipc	ra,0xfffff
    8000188a:	598080e7          	jalr	1432(ra) # 80000e1e <memmove>

    len -= n;
    8000188e:	409989b3          	sub	s3,s3,s1
    dst += n;
    80001892:	9a26                	add	s4,s4,s1
    srcva = va0 + PGSIZE;
    80001894:	01590c33          	add	s8,s2,s5
  while(len > 0){
    80001898:	02098263          	beqz	s3,800018bc <copyin+0x6c>
    va0 = PGROUNDDOWN(srcva);
    8000189c:	017c7933          	and	s2,s8,s7
    pa0 = walkaddr(pagetable, va0);
    800018a0:	85ca                	mv	a1,s2
    800018a2:	855a                	mv	a0,s6
    800018a4:	00000097          	auipc	ra,0x0
    800018a8:	934080e7          	jalr	-1740(ra) # 800011d8 <walkaddr>
    if(pa0 == 0)
    800018ac:	cd01                	beqz	a0,800018c4 <copyin+0x74>
    n = PGSIZE - (srcva - va0);
    800018ae:	418904b3          	sub	s1,s2,s8
    800018b2:	94d6                	add	s1,s1,s5
    if(n > len)
    800018b4:	fc99f2e3          	bgeu	s3,s1,80001878 <copyin+0x28>
    800018b8:	84ce                	mv	s1,s3
    800018ba:	bf7d                	j	80001878 <copyin+0x28>
  }
  return 0;
    800018bc:	4501                	li	a0,0
    800018be:	a021                	j	800018c6 <copyin+0x76>
    800018c0:	4501                	li	a0,0
}
    800018c2:	8082                	ret
      return -1;
    800018c4:	557d                	li	a0,-1
}
    800018c6:	60a6                	ld	ra,72(sp)
    800018c8:	6406                	ld	s0,64(sp)
    800018ca:	74e2                	ld	s1,56(sp)
    800018cc:	7942                	ld	s2,48(sp)
    800018ce:	79a2                	ld	s3,40(sp)
    800018d0:	7a02                	ld	s4,32(sp)
    800018d2:	6ae2                	ld	s5,24(sp)
    800018d4:	6b42                	ld	s6,16(sp)
    800018d6:	6ba2                	ld	s7,8(sp)
    800018d8:	6c02                	ld	s8,0(sp)
    800018da:	6161                	addi	sp,sp,80
    800018dc:	8082                	ret

00000000800018de <copyinstr>:
copyinstr(pagetable_t pagetable, char *dst, uint64 srcva, uint64 max)
{
  uint64 n, va0, pa0;
  int got_null = 0;

  while(got_null == 0 && max > 0){
    800018de:	cad5                	beqz	a3,80001992 <copyinstr+0xb4>
{
    800018e0:	715d                	addi	sp,sp,-80
    800018e2:	e486                	sd	ra,72(sp)
    800018e4:	e0a2                	sd	s0,64(sp)
    800018e6:	fc26                	sd	s1,56(sp)
    800018e8:	f84a                	sd	s2,48(sp)
    800018ea:	f44e                	sd	s3,40(sp)
    800018ec:	f052                	sd	s4,32(sp)
    800018ee:	ec56                	sd	s5,24(sp)
    800018f0:	e85a                	sd	s6,16(sp)
    800018f2:	e45e                	sd	s7,8(sp)
    800018f4:	0880                	addi	s0,sp,80
    800018f6:	8aaa                	mv	s5,a0
    800018f8:	84ae                	mv	s1,a1
    800018fa:	8bb2                	mv	s7,a2
    800018fc:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(srcva);
    800018fe:	7b7d                	lui	s6,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (srcva - va0);
    80001900:	6a05                	lui	s4,0x1
    80001902:	a82d                	j	8000193c <copyinstr+0x5e>
      n = max;

    char *p = (char *) (pa0 + (srcva - va0));
    while(n > 0){
      if(*p == '\0'){
        *dst = '\0';
    80001904:	00078023          	sb	zero,0(a5) # fffffffffffff000 <end+0xffffffff7ffd6fa4>
        got_null = 1;
    80001908:	4785                	li	a5,1
      dst++;
    }

    srcva = va0 + PGSIZE;
  }
  if(got_null){
    8000190a:	0017c793          	xori	a5,a5,1
    8000190e:	40f0053b          	negw	a0,a5
    return 0;
  } else {
    return -1;
  }
}
    80001912:	60a6                	ld	ra,72(sp)
    80001914:	6406                	ld	s0,64(sp)
    80001916:	74e2                	ld	s1,56(sp)
    80001918:	7942                	ld	s2,48(sp)
    8000191a:	79a2                	ld	s3,40(sp)
    8000191c:	7a02                	ld	s4,32(sp)
    8000191e:	6ae2                	ld	s5,24(sp)
    80001920:	6b42                	ld	s6,16(sp)
    80001922:	6ba2                	ld	s7,8(sp)
    80001924:	6161                	addi	sp,sp,80
    80001926:	8082                	ret
    80001928:	fff98713          	addi	a4,s3,-1 # fff <_entry-0x7ffff001>
    8000192c:	9726                	add	a4,a4,s1
      --max;
    8000192e:	40b709b3          	sub	s3,a4,a1
    srcva = va0 + PGSIZE;
    80001932:	01490bb3          	add	s7,s2,s4
  while(got_null == 0 && max > 0){
    80001936:	04e58663          	beq	a1,a4,80001982 <copyinstr+0xa4>
{
    8000193a:	84be                	mv	s1,a5
    va0 = PGROUNDDOWN(srcva);
    8000193c:	016bf933          	and	s2,s7,s6
    pa0 = walkaddr(pagetable, va0);
    80001940:	85ca                	mv	a1,s2
    80001942:	8556                	mv	a0,s5
    80001944:	00000097          	auipc	ra,0x0
    80001948:	894080e7          	jalr	-1900(ra) # 800011d8 <walkaddr>
    if(pa0 == 0)
    8000194c:	cd0d                	beqz	a0,80001986 <copyinstr+0xa8>
    n = PGSIZE - (srcva - va0);
    8000194e:	417906b3          	sub	a3,s2,s7
    80001952:	96d2                	add	a3,a3,s4
    if(n > max)
    80001954:	00d9f363          	bgeu	s3,a3,8000195a <copyinstr+0x7c>
    80001958:	86ce                	mv	a3,s3
    while(n > 0){
    8000195a:	ca85                	beqz	a3,8000198a <copyinstr+0xac>
    char *p = (char *) (pa0 + (srcva - va0));
    8000195c:	01750633          	add	a2,a0,s7
    80001960:	41260633          	sub	a2,a2,s2
    80001964:	87a6                	mv	a5,s1
      if(*p == '\0'){
    80001966:	8e05                	sub	a2,a2,s1
    while(n > 0){
    80001968:	96a6                	add	a3,a3,s1
    8000196a:	85be                	mv	a1,a5
      if(*p == '\0'){
    8000196c:	00f60733          	add	a4,a2,a5
    80001970:	00074703          	lbu	a4,0(a4)
    80001974:	db41                	beqz	a4,80001904 <copyinstr+0x26>
        *dst = *p;
    80001976:	00e78023          	sb	a4,0(a5)
      dst++;
    8000197a:	0785                	addi	a5,a5,1
    while(n > 0){
    8000197c:	fed797e3          	bne	a5,a3,8000196a <copyinstr+0x8c>
    80001980:	b765                	j	80001928 <copyinstr+0x4a>
    80001982:	4781                	li	a5,0
    80001984:	b759                	j	8000190a <copyinstr+0x2c>
      return -1;
    80001986:	557d                	li	a0,-1
    80001988:	b769                	j	80001912 <copyinstr+0x34>
    srcva = va0 + PGSIZE;
    8000198a:	6b85                	lui	s7,0x1
    8000198c:	9bca                	add	s7,s7,s2
    8000198e:	87a6                	mv	a5,s1
    80001990:	b76d                	j	8000193a <copyinstr+0x5c>
  int got_null = 0;
    80001992:	4781                	li	a5,0
  if(got_null){
    80001994:	0017c793          	xori	a5,a5,1
    80001998:	40f0053b          	negw	a0,a5
}
    8000199c:	8082                	ret

000000008000199e <wakeup1>:

// Wake up p if it is sleeping in wait(); used by exit().
// Caller must hold p->lock.
static void
wakeup1(struct proc *p)
{
    8000199e:	1101                	addi	sp,sp,-32
    800019a0:	ec06                	sd	ra,24(sp)
    800019a2:	e822                	sd	s0,16(sp)
    800019a4:	e426                	sd	s1,8(sp)
    800019a6:	1000                	addi	s0,sp,32
    800019a8:	84aa                	mv	s1,a0
  if(!holding(&p->lock))
    800019aa:	fffff097          	auipc	ra,0xfffff
    800019ae:	0dc080e7          	jalr	220(ra) # 80000a86 <holding>
    800019b2:	c909                	beqz	a0,800019c4 <wakeup1+0x26>
    panic("wakeup1");
  if(p->chan == p && p->state == SLEEPING) {
    800019b4:	789c                	ld	a5,48(s1)
    800019b6:	00978f63          	beq	a5,s1,800019d4 <wakeup1+0x36>
    p->state = RUNNABLE;
  }
}
    800019ba:	60e2                	ld	ra,24(sp)
    800019bc:	6442                	ld	s0,16(sp)
    800019be:	64a2                	ld	s1,8(sp)
    800019c0:	6105                	addi	sp,sp,32
    800019c2:	8082                	ret
    panic("wakeup1");
    800019c4:	00007517          	auipc	a0,0x7
    800019c8:	a8450513          	addi	a0,a0,-1404 # 80008448 <userret+0x3b8>
    800019cc:	fffff097          	auipc	ra,0xfffff
    800019d0:	b9e080e7          	jalr	-1122(ra) # 8000056a <panic>
  if(p->chan == p && p->state == SLEEPING) {
    800019d4:	5098                	lw	a4,32(s1)
    800019d6:	4785                	li	a5,1
    800019d8:	fef711e3          	bne	a4,a5,800019ba <wakeup1+0x1c>
    p->state = RUNNABLE;
    800019dc:	4789                	li	a5,2
    800019de:	d09c                	sw	a5,32(s1)
}
    800019e0:	bfe9                	j	800019ba <wakeup1+0x1c>

00000000800019e2 <procinit>:
{
    800019e2:	711d                	addi	sp,sp,-96
    800019e4:	ec86                	sd	ra,88(sp)
    800019e6:	e8a2                	sd	s0,80(sp)
    800019e8:	e4a6                	sd	s1,72(sp)
    800019ea:	e0ca                	sd	s2,64(sp)
    800019ec:	fc4e                	sd	s3,56(sp)
    800019ee:	f852                	sd	s4,48(sp)
    800019f0:	f456                	sd	s5,40(sp)
    800019f2:	f05a                	sd	s6,32(sp)
    800019f4:	ec5e                	sd	s7,24(sp)
    800019f6:	e862                	sd	s8,16(sp)
    800019f8:	e466                	sd	s9,8(sp)
    800019fa:	1080                	addi	s0,sp,96
  initlock(&pid_lock, "nextpid");
    800019fc:	00007597          	auipc	a1,0x7
    80001a00:	a5458593          	addi	a1,a1,-1452 # 80008450 <userret+0x3c0>
    80001a04:	00013517          	auipc	a0,0x13
    80001a08:	e3c50513          	addi	a0,a0,-452 # 80014840 <pid_lock>
    80001a0c:	fffff097          	auipc	ra,0xfffff
    80001a10:	024080e7          	jalr	36(ra) # 80000a30 <initlock>
  for(p = proc; p < &proc[NPROC]; p++) {
    80001a14:	00013917          	auipc	s2,0x13
    80001a18:	24c90913          	addi	s2,s2,588 # 80014c60 <proc>
      initlock(&p->lock, "proc");
    80001a1c:	00007a97          	auipc	s5,0x7
    80001a20:	a3ca8a93          	addi	s5,s5,-1476 # 80008458 <userret+0x3c8>
      uint64 va = KSTACK((int) (p - proc));
    80001a24:	8cca                	mv	s9,s2
    80001a26:	ff4df9b7          	lui	s3,0xff4df
    80001a2a:	9bd98993          	addi	s3,s3,-1603 # ffffffffff4de9bd <end+0xffffffff7f4b6961>
    80001a2e:	09b6                	slli	s3,s3,0xd
    80001a30:	6f598993          	addi	s3,s3,1781
    80001a34:	09b6                	slli	s3,s3,0xd
    80001a36:	bd398993          	addi	s3,s3,-1069
    80001a3a:	09b2                	slli	s3,s3,0xc
    80001a3c:	7a798993          	addi	s3,s3,1959
    80001a40:	04000a37          	lui	s4,0x4000
    80001a44:	1a7d                	addi	s4,s4,-1 # 3ffffff <_entry-0x7c000001>
    80001a46:	0a32                	slli	s4,s4,0xc
      kvmmap(va, (uint64)pa, PGSIZE, PTE_R | PTE_W);
    80001a48:	4c19                	li	s8,6
    80001a4a:	6b85                	lui	s7,0x1
  for(p = proc; p < &proc[NPROC]; p++) {
    80001a4c:	00014b17          	auipc	s6,0x14
    80001a50:	074b0b13          	addi	s6,s6,116 # 80015ac0 <tickslock>
      initlock(&p->lock, "proc");
    80001a54:	85d6                	mv	a1,s5
    80001a56:	854a                	mv	a0,s2
    80001a58:	fffff097          	auipc	ra,0xfffff
    80001a5c:	fd8080e7          	jalr	-40(ra) # 80000a30 <initlock>
      char *pa = kalloc();
    80001a60:	fffff097          	auipc	ra,0xfffff
    80001a64:	f66080e7          	jalr	-154(ra) # 800009c6 <kalloc>
    80001a68:	85aa                	mv	a1,a0
      if(pa == 0)
    80001a6a:	c929                	beqz	a0,80001abc <procinit+0xda>
      uint64 va = KSTACK((int) (p - proc));
    80001a6c:	419904b3          	sub	s1,s2,s9
    80001a70:	8491                	srai	s1,s1,0x4
    80001a72:	033484b3          	mul	s1,s1,s3
    80001a76:	04b6                	slli	s1,s1,0xd
    80001a78:	6789                	lui	a5,0x2
    80001a7a:	9cbd                	addw	s1,s1,a5
    80001a7c:	409a04b3          	sub	s1,s4,s1
      kvmmap(va, (uint64)pa, PGSIZE, PTE_R | PTE_W);
    80001a80:	86e2                	mv	a3,s8
    80001a82:	865e                	mv	a2,s7
    80001a84:	8526                	mv	a0,s1
    80001a86:	00000097          	auipc	ra,0x0
    80001a8a:	87e080e7          	jalr	-1922(ra) # 80001304 <kvmmap>
      p->kstack = va;
    80001a8e:	04993423          	sd	s1,72(s2)
  for(p = proc; p < &proc[NPROC]; p++) {
    80001a92:	17090913          	addi	s2,s2,368
    80001a96:	fb691fe3          	bne	s2,s6,80001a54 <procinit+0x72>
  kvminithart();
    80001a9a:	fffff097          	auipc	ra,0xfffff
    80001a9e:	716080e7          	jalr	1814(ra) # 800011b0 <kvminithart>
}
    80001aa2:	60e6                	ld	ra,88(sp)
    80001aa4:	6446                	ld	s0,80(sp)
    80001aa6:	64a6                	ld	s1,72(sp)
    80001aa8:	6906                	ld	s2,64(sp)
    80001aaa:	79e2                	ld	s3,56(sp)
    80001aac:	7a42                	ld	s4,48(sp)
    80001aae:	7aa2                	ld	s5,40(sp)
    80001ab0:	7b02                	ld	s6,32(sp)
    80001ab2:	6be2                	ld	s7,24(sp)
    80001ab4:	6c42                	ld	s8,16(sp)
    80001ab6:	6ca2                	ld	s9,8(sp)
    80001ab8:	6125                	addi	sp,sp,96
    80001aba:	8082                	ret
        panic("kalloc");
    80001abc:	00007517          	auipc	a0,0x7
    80001ac0:	9a450513          	addi	a0,a0,-1628 # 80008460 <userret+0x3d0>
    80001ac4:	fffff097          	auipc	ra,0xfffff
    80001ac8:	aa6080e7          	jalr	-1370(ra) # 8000056a <panic>

0000000080001acc <cpuid>:
{
    80001acc:	1141                	addi	sp,sp,-16
    80001ace:	e406                	sd	ra,8(sp)
    80001ad0:	e022                	sd	s0,0(sp)
    80001ad2:	0800                	addi	s0,sp,16
  asm volatile("mv %0, tp" : "=r" (x) );
    80001ad4:	8512                	mv	a0,tp
}
    80001ad6:	2501                	sext.w	a0,a0
    80001ad8:	60a2                	ld	ra,8(sp)
    80001ada:	6402                	ld	s0,0(sp)
    80001adc:	0141                	addi	sp,sp,16
    80001ade:	8082                	ret

0000000080001ae0 <mycpu>:
mycpu(void) {
    80001ae0:	1141                	addi	sp,sp,-16
    80001ae2:	e406                	sd	ra,8(sp)
    80001ae4:	e022                	sd	s0,0(sp)
    80001ae6:	0800                	addi	s0,sp,16
    80001ae8:	8792                	mv	a5,tp
  struct cpu *c = &cpus[id];
    80001aea:	2781                	sext.w	a5,a5
    80001aec:	079e                	slli	a5,a5,0x7
}
    80001aee:	00013517          	auipc	a0,0x13
    80001af2:	d7250513          	addi	a0,a0,-654 # 80014860 <cpus>
    80001af6:	953e                	add	a0,a0,a5
    80001af8:	60a2                	ld	ra,8(sp)
    80001afa:	6402                	ld	s0,0(sp)
    80001afc:	0141                	addi	sp,sp,16
    80001afe:	8082                	ret

0000000080001b00 <myproc>:
myproc(void) {
    80001b00:	1101                	addi	sp,sp,-32
    80001b02:	ec06                	sd	ra,24(sp)
    80001b04:	e822                	sd	s0,16(sp)
    80001b06:	e426                	sd	s1,8(sp)
    80001b08:	1000                	addi	s0,sp,32
  push_off();
    80001b0a:	fffff097          	auipc	ra,0xfffff
    80001b0e:	fac080e7          	jalr	-84(ra) # 80000ab6 <push_off>
    80001b12:	8792                	mv	a5,tp
  struct proc *p = c->proc;
    80001b14:	2781                	sext.w	a5,a5
    80001b16:	079e                	slli	a5,a5,0x7
    80001b18:	00013717          	auipc	a4,0x13
    80001b1c:	d2870713          	addi	a4,a4,-728 # 80014840 <pid_lock>
    80001b20:	97ba                	add	a5,a5,a4
    80001b22:	739c                	ld	a5,32(a5)
    80001b24:	84be                	mv	s1,a5
  pop_off();
    80001b26:	fffff097          	auipc	ra,0xfffff
    80001b2a:	046080e7          	jalr	70(ra) # 80000b6c <pop_off>
}
    80001b2e:	8526                	mv	a0,s1
    80001b30:	60e2                	ld	ra,24(sp)
    80001b32:	6442                	ld	s0,16(sp)
    80001b34:	64a2                	ld	s1,8(sp)
    80001b36:	6105                	addi	sp,sp,32
    80001b38:	8082                	ret

0000000080001b3a <forkret>:
{
    80001b3a:	1141                	addi	sp,sp,-16
    80001b3c:	e406                	sd	ra,8(sp)
    80001b3e:	e022                	sd	s0,0(sp)
    80001b40:	0800                	addi	s0,sp,16
  release(&myproc()->lock);
    80001b42:	00000097          	auipc	ra,0x0
    80001b46:	fbe080e7          	jalr	-66(ra) # 80001b00 <myproc>
    80001b4a:	fffff097          	auipc	ra,0xfffff
    80001b4e:	07e080e7          	jalr	126(ra) # 80000bc8 <release>
  if (first) {
    80001b52:	00007797          	auipc	a5,0x7
    80001b56:	4e27a783          	lw	a5,1250(a5) # 80009034 <first.1>
    80001b5a:	eb89                	bnez	a5,80001b6c <forkret+0x32>
  usertrapret();
    80001b5c:	00001097          	auipc	ra,0x1
    80001b60:	c58080e7          	jalr	-936(ra) # 800027b4 <usertrapret>
}
    80001b64:	60a2                	ld	ra,8(sp)
    80001b66:	6402                	ld	s0,0(sp)
    80001b68:	0141                	addi	sp,sp,16
    80001b6a:	8082                	ret
    first = 0;
    80001b6c:	00007797          	auipc	a5,0x7
    80001b70:	4c07a423          	sw	zero,1224(a5) # 80009034 <first.1>
    fsinit(minor(ROOTDEV));
    80001b74:	4501                	li	a0,0
    80001b76:	00002097          	auipc	ra,0x2
    80001b7a:	984080e7          	jalr	-1660(ra) # 800034fa <fsinit>
    80001b7e:	bff9                	j	80001b5c <forkret+0x22>

0000000080001b80 <allocpid>:
allocpid() {
    80001b80:	1101                	addi	sp,sp,-32
    80001b82:	ec06                	sd	ra,24(sp)
    80001b84:	e822                	sd	s0,16(sp)
    80001b86:	e426                	sd	s1,8(sp)
    80001b88:	1000                	addi	s0,sp,32
  acquire(&pid_lock);
    80001b8a:	00013517          	auipc	a0,0x13
    80001b8e:	cb650513          	addi	a0,a0,-842 # 80014840 <pid_lock>
    80001b92:	fffff097          	auipc	ra,0xfffff
    80001b96:	f72080e7          	jalr	-142(ra) # 80000b04 <acquire>
  pid = nextpid;
    80001b9a:	00007797          	auipc	a5,0x7
    80001b9e:	49e78793          	addi	a5,a5,1182 # 80009038 <nextpid>
    80001ba2:	4384                	lw	s1,0(a5)
  nextpid = nextpid + 1;
    80001ba4:	0014871b          	addiw	a4,s1,1
    80001ba8:	c398                	sw	a4,0(a5)
  release(&pid_lock);
    80001baa:	00013517          	auipc	a0,0x13
    80001bae:	c9650513          	addi	a0,a0,-874 # 80014840 <pid_lock>
    80001bb2:	fffff097          	auipc	ra,0xfffff
    80001bb6:	016080e7          	jalr	22(ra) # 80000bc8 <release>
}
    80001bba:	8526                	mv	a0,s1
    80001bbc:	60e2                	ld	ra,24(sp)
    80001bbe:	6442                	ld	s0,16(sp)
    80001bc0:	64a2                	ld	s1,8(sp)
    80001bc2:	6105                	addi	sp,sp,32
    80001bc4:	8082                	ret

0000000080001bc6 <proc_pagetable>:
{
    80001bc6:	1101                	addi	sp,sp,-32
    80001bc8:	ec06                	sd	ra,24(sp)
    80001bca:	e822                	sd	s0,16(sp)
    80001bcc:	e426                	sd	s1,8(sp)
    80001bce:	e04a                	sd	s2,0(sp)
    80001bd0:	1000                	addi	s0,sp,32
    80001bd2:	892a                	mv	s2,a0
  pagetable = uvmcreate();
    80001bd4:	00000097          	auipc	ra,0x0
    80001bd8:	910080e7          	jalr	-1776(ra) # 800014e4 <uvmcreate>
    80001bdc:	84aa                	mv	s1,a0
  mappages(pagetable, TRAMPOLINE, PGSIZE,
    80001bde:	4729                	li	a4,10
    80001be0:	00006697          	auipc	a3,0x6
    80001be4:	42068693          	addi	a3,a3,1056 # 80008000 <trampoline>
    80001be8:	6605                	lui	a2,0x1
    80001bea:	040005b7          	lui	a1,0x4000
    80001bee:	15fd                	addi	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    80001bf0:	05b2                	slli	a1,a1,0xc
    80001bf2:	fffff097          	auipc	ra,0xfffff
    80001bf6:	682080e7          	jalr	1666(ra) # 80001274 <mappages>
  mappages(pagetable, TRAPFRAME, PGSIZE,
    80001bfa:	4719                	li	a4,6
    80001bfc:	06093683          	ld	a3,96(s2)
    80001c00:	6605                	lui	a2,0x1
    80001c02:	020005b7          	lui	a1,0x2000
    80001c06:	15fd                	addi	a1,a1,-1 # 1ffffff <_entry-0x7e000001>
    80001c08:	05b6                	slli	a1,a1,0xd
    80001c0a:	8526                	mv	a0,s1
    80001c0c:	fffff097          	auipc	ra,0xfffff
    80001c10:	668080e7          	jalr	1640(ra) # 80001274 <mappages>
}
    80001c14:	8526                	mv	a0,s1
    80001c16:	60e2                	ld	ra,24(sp)
    80001c18:	6442                	ld	s0,16(sp)
    80001c1a:	64a2                	ld	s1,8(sp)
    80001c1c:	6902                	ld	s2,0(sp)
    80001c1e:	6105                	addi	sp,sp,32
    80001c20:	8082                	ret

0000000080001c22 <allocproc>:
{
    80001c22:	1101                	addi	sp,sp,-32
    80001c24:	ec06                	sd	ra,24(sp)
    80001c26:	e822                	sd	s0,16(sp)
    80001c28:	e426                	sd	s1,8(sp)
    80001c2a:	e04a                	sd	s2,0(sp)
    80001c2c:	1000                	addi	s0,sp,32
  for(p = proc; p < &proc[NPROC]; p++) {
    80001c2e:	00013497          	auipc	s1,0x13
    80001c32:	03248493          	addi	s1,s1,50 # 80014c60 <proc>
    80001c36:	00014917          	auipc	s2,0x14
    80001c3a:	e8a90913          	addi	s2,s2,-374 # 80015ac0 <tickslock>
    acquire(&p->lock);
    80001c3e:	8526                	mv	a0,s1
    80001c40:	fffff097          	auipc	ra,0xfffff
    80001c44:	ec4080e7          	jalr	-316(ra) # 80000b04 <acquire>
    if(p->state == UNUSED) {
    80001c48:	509c                	lw	a5,32(s1)
    80001c4a:	c395                	beqz	a5,80001c6e <allocproc+0x4c>
      release(&p->lock);
    80001c4c:	8526                	mv	a0,s1
    80001c4e:	fffff097          	auipc	ra,0xfffff
    80001c52:	f7a080e7          	jalr	-134(ra) # 80000bc8 <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    80001c56:	17048493          	addi	s1,s1,368
    80001c5a:	ff2492e3          	bne	s1,s2,80001c3e <allocproc+0x1c>
  return 0;
    80001c5e:	4481                	li	s1,0
}
    80001c60:	8526                	mv	a0,s1
    80001c62:	60e2                	ld	ra,24(sp)
    80001c64:	6442                	ld	s0,16(sp)
    80001c66:	64a2                	ld	s1,8(sp)
    80001c68:	6902                	ld	s2,0(sp)
    80001c6a:	6105                	addi	sp,sp,32
    80001c6c:	8082                	ret
  p->pid = allocpid();
    80001c6e:	00000097          	auipc	ra,0x0
    80001c72:	f12080e7          	jalr	-238(ra) # 80001b80 <allocpid>
    80001c76:	c0a8                	sw	a0,64(s1)
  if((p->tf = (struct trapframe *)kalloc()) == 0){
    80001c78:	fffff097          	auipc	ra,0xfffff
    80001c7c:	d4e080e7          	jalr	-690(ra) # 800009c6 <kalloc>
    80001c80:	892a                	mv	s2,a0
    80001c82:	f0a8                	sd	a0,96(s1)
    80001c84:	c915                	beqz	a0,80001cb8 <allocproc+0x96>
  p->pagetable = proc_pagetable(p);
    80001c86:	8526                	mv	a0,s1
    80001c88:	00000097          	auipc	ra,0x0
    80001c8c:	f3e080e7          	jalr	-194(ra) # 80001bc6 <proc_pagetable>
    80001c90:	eca8                	sd	a0,88(s1)
  memset(&p->context, 0, sizeof p->context);
    80001c92:	07000613          	li	a2,112
    80001c96:	4581                	li	a1,0
    80001c98:	06848513          	addi	a0,s1,104
    80001c9c:	fffff097          	auipc	ra,0xfffff
    80001ca0:	122080e7          	jalr	290(ra) # 80000dbe <memset>
  p->context.ra = (uint64)forkret;
    80001ca4:	00000797          	auipc	a5,0x0
    80001ca8:	e9678793          	addi	a5,a5,-362 # 80001b3a <forkret>
    80001cac:	f4bc                	sd	a5,104(s1)
  p->context.sp = p->kstack + PGSIZE;
    80001cae:	64bc                	ld	a5,72(s1)
    80001cb0:	6705                	lui	a4,0x1
    80001cb2:	97ba                	add	a5,a5,a4
    80001cb4:	f8bc                	sd	a5,112(s1)
  return p;
    80001cb6:	b76d                	j	80001c60 <allocproc+0x3e>
    release(&p->lock);
    80001cb8:	8526                	mv	a0,s1
    80001cba:	fffff097          	auipc	ra,0xfffff
    80001cbe:	f0e080e7          	jalr	-242(ra) # 80000bc8 <release>
    return 0;
    80001cc2:	84ca                	mv	s1,s2
    80001cc4:	bf71                	j	80001c60 <allocproc+0x3e>

0000000080001cc6 <proc_freepagetable>:
{
    80001cc6:	1101                	addi	sp,sp,-32
    80001cc8:	ec06                	sd	ra,24(sp)
    80001cca:	e822                	sd	s0,16(sp)
    80001ccc:	e426                	sd	s1,8(sp)
    80001cce:	e04a                	sd	s2,0(sp)
    80001cd0:	1000                	addi	s0,sp,32
    80001cd2:	892a                	mv	s2,a0
    80001cd4:	84ae                	mv	s1,a1
  uvmunmap(pagetable, TRAMPOLINE, PGSIZE, 0);
    80001cd6:	4681                	li	a3,0
    80001cd8:	6605                	lui	a2,0x1
    80001cda:	040005b7          	lui	a1,0x4000
    80001cde:	15fd                	addi	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    80001ce0:	05b2                	slli	a1,a1,0xc
    80001ce2:	fffff097          	auipc	ra,0xfffff
    80001ce6:	73a080e7          	jalr	1850(ra) # 8000141c <uvmunmap>
  uvmunmap(pagetable, TRAPFRAME, PGSIZE, 0);
    80001cea:	4681                	li	a3,0
    80001cec:	6605                	lui	a2,0x1
    80001cee:	020005b7          	lui	a1,0x2000
    80001cf2:	15fd                	addi	a1,a1,-1 # 1ffffff <_entry-0x7e000001>
    80001cf4:	05b6                	slli	a1,a1,0xd
    80001cf6:	854a                	mv	a0,s2
    80001cf8:	fffff097          	auipc	ra,0xfffff
    80001cfc:	724080e7          	jalr	1828(ra) # 8000141c <uvmunmap>
  if(sz > 0)
    80001d00:	e499                	bnez	s1,80001d0e <proc_freepagetable+0x48>
}
    80001d02:	60e2                	ld	ra,24(sp)
    80001d04:	6442                	ld	s0,16(sp)
    80001d06:	64a2                	ld	s1,8(sp)
    80001d08:	6902                	ld	s2,0(sp)
    80001d0a:	6105                	addi	sp,sp,32
    80001d0c:	8082                	ret
    uvmfree(pagetable, sz);
    80001d0e:	85a6                	mv	a1,s1
    80001d10:	854a                	mv	a0,s2
    80001d12:	00000097          	auipc	ra,0x0
    80001d16:	986080e7          	jalr	-1658(ra) # 80001698 <uvmfree>
}
    80001d1a:	b7e5                	j	80001d02 <proc_freepagetable+0x3c>

0000000080001d1c <freeproc>:
{
    80001d1c:	1101                	addi	sp,sp,-32
    80001d1e:	ec06                	sd	ra,24(sp)
    80001d20:	e822                	sd	s0,16(sp)
    80001d22:	e426                	sd	s1,8(sp)
    80001d24:	1000                	addi	s0,sp,32
    80001d26:	84aa                	mv	s1,a0
  if(p->tf)
    80001d28:	7128                	ld	a0,96(a0)
    80001d2a:	c509                	beqz	a0,80001d34 <freeproc+0x18>
    kfree((void*)p->tf);
    80001d2c:	fffff097          	auipc	ra,0xfffff
    80001d30:	b96080e7          	jalr	-1130(ra) # 800008c2 <kfree>
  p->tf = 0;
    80001d34:	0604b023          	sd	zero,96(s1)
  if(p->pagetable)
    80001d38:	6ca8                	ld	a0,88(s1)
    80001d3a:	c511                	beqz	a0,80001d46 <freeproc+0x2a>
    proc_freepagetable(p->pagetable, p->sz);
    80001d3c:	68ac                	ld	a1,80(s1)
    80001d3e:	00000097          	auipc	ra,0x0
    80001d42:	f88080e7          	jalr	-120(ra) # 80001cc6 <proc_freepagetable>
  p->pagetable = 0;
    80001d46:	0404bc23          	sd	zero,88(s1)
  p->sz = 0;
    80001d4a:	0404b823          	sd	zero,80(s1)
  p->pid = 0;
    80001d4e:	0404a023          	sw	zero,64(s1)
  p->parent = 0;
    80001d52:	0204b423          	sd	zero,40(s1)
  p->name[0] = 0;
    80001d56:	16048023          	sb	zero,352(s1)
  p->chan = 0;
    80001d5a:	0204b823          	sd	zero,48(s1)
  p->killed = 0;
    80001d5e:	0204ac23          	sw	zero,56(s1)
  p->xstate = 0;
    80001d62:	0204ae23          	sw	zero,60(s1)
  p->state = UNUSED;
    80001d66:	0204a023          	sw	zero,32(s1)
}
    80001d6a:	60e2                	ld	ra,24(sp)
    80001d6c:	6442                	ld	s0,16(sp)
    80001d6e:	64a2                	ld	s1,8(sp)
    80001d70:	6105                	addi	sp,sp,32
    80001d72:	8082                	ret

0000000080001d74 <userinit>:
{
    80001d74:	1101                	addi	sp,sp,-32
    80001d76:	ec06                	sd	ra,24(sp)
    80001d78:	e822                	sd	s0,16(sp)
    80001d7a:	e426                	sd	s1,8(sp)
    80001d7c:	1000                	addi	s0,sp,32
  p = allocproc();
    80001d7e:	00000097          	auipc	ra,0x0
    80001d82:	ea4080e7          	jalr	-348(ra) # 80001c22 <allocproc>
    80001d86:	84aa                	mv	s1,a0
  initproc = p;
    80001d88:	00026797          	auipc	a5,0x26
    80001d8c:	2aa7b823          	sd	a0,688(a5) # 80028038 <initproc>
  uvminit(p->pagetable, initcode, sizeof(initcode));
    80001d90:	03300613          	li	a2,51
    80001d94:	00007597          	auipc	a1,0x7
    80001d98:	26c58593          	addi	a1,a1,620 # 80009000 <initcode>
    80001d9c:	6d28                	ld	a0,88(a0)
    80001d9e:	fffff097          	auipc	ra,0xfffff
    80001da2:	784080e7          	jalr	1924(ra) # 80001522 <uvminit>
  p->sz = PGSIZE;
    80001da6:	6785                	lui	a5,0x1
    80001da8:	e8bc                	sd	a5,80(s1)
  p->tf->epc = 0;      // user program counter
    80001daa:	70b8                	ld	a4,96(s1)
    80001dac:	00073c23          	sd	zero,24(a4) # 1018 <_entry-0x7fffefe8>
  p->tf->sp = PGSIZE;  // user stack pointer
    80001db0:	70b8                	ld	a4,96(s1)
    80001db2:	fb1c                	sd	a5,48(a4)
  safestrcpy(p->name, "initcode", sizeof(p->name));
    80001db4:	4641                	li	a2,16
    80001db6:	00006597          	auipc	a1,0x6
    80001dba:	6b258593          	addi	a1,a1,1714 # 80008468 <userret+0x3d8>
    80001dbe:	16048513          	addi	a0,s1,352
    80001dc2:	fffff097          	auipc	ra,0xfffff
    80001dc6:	156080e7          	jalr	342(ra) # 80000f18 <safestrcpy>
  p->cwd = namei("/");
    80001dca:	00006517          	auipc	a0,0x6
    80001dce:	6ae50513          	addi	a0,a0,1710 # 80008478 <userret+0x3e8>
    80001dd2:	00002097          	auipc	ra,0x2
    80001dd6:	156080e7          	jalr	342(ra) # 80003f28 <namei>
    80001dda:	14a4bc23          	sd	a0,344(s1)
  p->state = RUNNABLE;
    80001dde:	4789                	li	a5,2
    80001de0:	d09c                	sw	a5,32(s1)
  release(&p->lock);
    80001de2:	8526                	mv	a0,s1
    80001de4:	fffff097          	auipc	ra,0xfffff
    80001de8:	de4080e7          	jalr	-540(ra) # 80000bc8 <release>
}
    80001dec:	60e2                	ld	ra,24(sp)
    80001dee:	6442                	ld	s0,16(sp)
    80001df0:	64a2                	ld	s1,8(sp)
    80001df2:	6105                	addi	sp,sp,32
    80001df4:	8082                	ret

0000000080001df6 <growproc>:
{
    80001df6:	1101                	addi	sp,sp,-32
    80001df8:	ec06                	sd	ra,24(sp)
    80001dfa:	e822                	sd	s0,16(sp)
    80001dfc:	e426                	sd	s1,8(sp)
    80001dfe:	e04a                	sd	s2,0(sp)
    80001e00:	1000                	addi	s0,sp,32
    80001e02:	84aa                	mv	s1,a0
  struct proc *p = myproc();
    80001e04:	00000097          	auipc	ra,0x0
    80001e08:	cfc080e7          	jalr	-772(ra) # 80001b00 <myproc>
    80001e0c:	892a                	mv	s2,a0
  sz = p->sz;
    80001e0e:	692c                	ld	a1,80(a0)
    80001e10:	0005879b          	sext.w	a5,a1
  if(n > 0){
    80001e14:	00904f63          	bgtz	s1,80001e32 <growproc+0x3c>
  } else if(n < 0){
    80001e18:	0204cd63          	bltz	s1,80001e52 <growproc+0x5c>
  p->sz = sz;
    80001e1c:	1782                	slli	a5,a5,0x20
    80001e1e:	9381                	srli	a5,a5,0x20
    80001e20:	04f93823          	sd	a5,80(s2)
  return 0;
    80001e24:	4501                	li	a0,0
}
    80001e26:	60e2                	ld	ra,24(sp)
    80001e28:	6442                	ld	s0,16(sp)
    80001e2a:	64a2                	ld	s1,8(sp)
    80001e2c:	6902                	ld	s2,0(sp)
    80001e2e:	6105                	addi	sp,sp,32
    80001e30:	8082                	ret
    if((sz = uvmalloc(p->pagetable, sz, sz + n)) == 0) {
    80001e32:	00f4863b          	addw	a2,s1,a5
    80001e36:	1602                	slli	a2,a2,0x20
    80001e38:	9201                	srli	a2,a2,0x20
    80001e3a:	1582                	slli	a1,a1,0x20
    80001e3c:	9181                	srli	a1,a1,0x20
    80001e3e:	6d28                	ld	a0,88(a0)
    80001e40:	fffff097          	auipc	ra,0xfffff
    80001e44:	798080e7          	jalr	1944(ra) # 800015d8 <uvmalloc>
    80001e48:	0005079b          	sext.w	a5,a0
    80001e4c:	fbe1                	bnez	a5,80001e1c <growproc+0x26>
      return -1;
    80001e4e:	557d                	li	a0,-1
    80001e50:	bfd9                	j	80001e26 <growproc+0x30>
    sz = uvmdealloc(p->pagetable, sz, sz + n);
    80001e52:	00f4863b          	addw	a2,s1,a5
    80001e56:	1602                	slli	a2,a2,0x20
    80001e58:	9201                	srli	a2,a2,0x20
    80001e5a:	1582                	slli	a1,a1,0x20
    80001e5c:	9181                	srli	a1,a1,0x20
    80001e5e:	6d28                	ld	a0,88(a0)
    80001e60:	fffff097          	auipc	ra,0xfffff
    80001e64:	734080e7          	jalr	1844(ra) # 80001594 <uvmdealloc>
    80001e68:	0005079b          	sext.w	a5,a0
    80001e6c:	bf45                	j	80001e1c <growproc+0x26>

0000000080001e6e <fork>:
{
    80001e6e:	7139                	addi	sp,sp,-64
    80001e70:	fc06                	sd	ra,56(sp)
    80001e72:	f822                	sd	s0,48(sp)
    80001e74:	f426                	sd	s1,40(sp)
    80001e76:	e456                	sd	s5,8(sp)
    80001e78:	0080                	addi	s0,sp,64
  struct proc *p = myproc();
    80001e7a:	00000097          	auipc	ra,0x0
    80001e7e:	c86080e7          	jalr	-890(ra) # 80001b00 <myproc>
    80001e82:	8aaa                	mv	s5,a0
  if((np = allocproc()) == 0){
    80001e84:	00000097          	auipc	ra,0x0
    80001e88:	d9e080e7          	jalr	-610(ra) # 80001c22 <allocproc>
    80001e8c:	c56d                	beqz	a0,80001f76 <fork+0x108>
    80001e8e:	e852                	sd	s4,16(sp)
    80001e90:	8a2a                	mv	s4,a0
  if(uvmcopy(p->pagetable, np->pagetable, p->sz) < 0){
    80001e92:	050ab603          	ld	a2,80(s5)
    80001e96:	6d2c                	ld	a1,88(a0)
    80001e98:	058ab503          	ld	a0,88(s5)
    80001e9c:	00000097          	auipc	ra,0x0
    80001ea0:	82a080e7          	jalr	-2006(ra) # 800016c6 <uvmcopy>
    80001ea4:	04054a63          	bltz	a0,80001ef8 <fork+0x8a>
    80001ea8:	f04a                	sd	s2,32(sp)
    80001eaa:	ec4e                	sd	s3,24(sp)
  np->sz = p->sz;
    80001eac:	050ab783          	ld	a5,80(s5)
    80001eb0:	04fa3823          	sd	a5,80(s4)
  np->parent = p;
    80001eb4:	035a3423          	sd	s5,40(s4)
  *(np->tf) = *(p->tf);
    80001eb8:	060ab683          	ld	a3,96(s5)
    80001ebc:	87b6                	mv	a5,a3
    80001ebe:	060a3703          	ld	a4,96(s4)
    80001ec2:	12068693          	addi	a3,a3,288
    80001ec6:	6388                	ld	a0,0(a5)
    80001ec8:	678c                	ld	a1,8(a5)
    80001eca:	6b90                	ld	a2,16(a5)
    80001ecc:	e308                	sd	a0,0(a4)
    80001ece:	e70c                	sd	a1,8(a4)
    80001ed0:	eb10                	sd	a2,16(a4)
    80001ed2:	6f90                	ld	a2,24(a5)
    80001ed4:	ef10                	sd	a2,24(a4)
    80001ed6:	02078793          	addi	a5,a5,32 # 1020 <_entry-0x7fffefe0>
    80001eda:	02070713          	addi	a4,a4,32
    80001ede:	fed794e3          	bne	a5,a3,80001ec6 <fork+0x58>
  np->tf->a0 = 0;
    80001ee2:	060a3783          	ld	a5,96(s4)
    80001ee6:	0607b823          	sd	zero,112(a5)
  for(i = 0; i < NOFILE; i++)
    80001eea:	0d8a8493          	addi	s1,s5,216
    80001eee:	0d8a0913          	addi	s2,s4,216
    80001ef2:	158a8993          	addi	s3,s5,344
    80001ef6:	a015                	j	80001f1a <fork+0xac>
    freeproc(np);
    80001ef8:	8552                	mv	a0,s4
    80001efa:	00000097          	auipc	ra,0x0
    80001efe:	e22080e7          	jalr	-478(ra) # 80001d1c <freeproc>
    release(&np->lock);
    80001f02:	8552                	mv	a0,s4
    80001f04:	fffff097          	auipc	ra,0xfffff
    80001f08:	cc4080e7          	jalr	-828(ra) # 80000bc8 <release>
    return -1;
    80001f0c:	54fd                	li	s1,-1
    80001f0e:	6a42                	ld	s4,16(sp)
    80001f10:	a8a1                	j	80001f68 <fork+0xfa>
  for(i = 0; i < NOFILE; i++)
    80001f12:	04a1                	addi	s1,s1,8
    80001f14:	0921                	addi	s2,s2,8
    80001f16:	01348b63          	beq	s1,s3,80001f2c <fork+0xbe>
    if(p->ofile[i])
    80001f1a:	6088                	ld	a0,0(s1)
    80001f1c:	d97d                	beqz	a0,80001f12 <fork+0xa4>
      np->ofile[i] = filedup(p->ofile[i]);
    80001f1e:	00002097          	auipc	ra,0x2
    80001f22:	7a6080e7          	jalr	1958(ra) # 800046c4 <filedup>
    80001f26:	00a93023          	sd	a0,0(s2)
    80001f2a:	b7e5                	j	80001f12 <fork+0xa4>
  np->cwd = idup(p->cwd);
    80001f2c:	158ab503          	ld	a0,344(s5)
    80001f30:	00001097          	auipc	ra,0x1
    80001f34:	7fe080e7          	jalr	2046(ra) # 8000372e <idup>
    80001f38:	14aa3c23          	sd	a0,344(s4)
  safestrcpy(np->name, p->name, sizeof(p->name));
    80001f3c:	4641                	li	a2,16
    80001f3e:	160a8593          	addi	a1,s5,352
    80001f42:	160a0513          	addi	a0,s4,352
    80001f46:	fffff097          	auipc	ra,0xfffff
    80001f4a:	fd2080e7          	jalr	-46(ra) # 80000f18 <safestrcpy>
  pid = np->pid;
    80001f4e:	040a2483          	lw	s1,64(s4)
  np->state = RUNNABLE;
    80001f52:	4789                	li	a5,2
    80001f54:	02fa2023          	sw	a5,32(s4)
  release(&np->lock);
    80001f58:	8552                	mv	a0,s4
    80001f5a:	fffff097          	auipc	ra,0xfffff
    80001f5e:	c6e080e7          	jalr	-914(ra) # 80000bc8 <release>
  return pid;
    80001f62:	7902                	ld	s2,32(sp)
    80001f64:	69e2                	ld	s3,24(sp)
    80001f66:	6a42                	ld	s4,16(sp)
}
    80001f68:	8526                	mv	a0,s1
    80001f6a:	70e2                	ld	ra,56(sp)
    80001f6c:	7442                	ld	s0,48(sp)
    80001f6e:	74a2                	ld	s1,40(sp)
    80001f70:	6aa2                	ld	s5,8(sp)
    80001f72:	6121                	addi	sp,sp,64
    80001f74:	8082                	ret
    return -1;
    80001f76:	54fd                	li	s1,-1
    80001f78:	bfc5                	j	80001f68 <fork+0xfa>

0000000080001f7a <reparent>:
{
    80001f7a:	7179                	addi	sp,sp,-48
    80001f7c:	f406                	sd	ra,40(sp)
    80001f7e:	f022                	sd	s0,32(sp)
    80001f80:	ec26                	sd	s1,24(sp)
    80001f82:	e84a                	sd	s2,16(sp)
    80001f84:	e44e                	sd	s3,8(sp)
    80001f86:	e052                	sd	s4,0(sp)
    80001f88:	1800                	addi	s0,sp,48
    80001f8a:	892a                	mv	s2,a0
  for(pp = proc; pp < &proc[NPROC]; pp++){
    80001f8c:	00013497          	auipc	s1,0x13
    80001f90:	cd448493          	addi	s1,s1,-812 # 80014c60 <proc>
      pp->parent = initproc;
    80001f94:	00026a17          	auipc	s4,0x26
    80001f98:	0a4a0a13          	addi	s4,s4,164 # 80028038 <initproc>
  for(pp = proc; pp < &proc[NPROC]; pp++){
    80001f9c:	00014997          	auipc	s3,0x14
    80001fa0:	b2498993          	addi	s3,s3,-1244 # 80015ac0 <tickslock>
    80001fa4:	a029                	j	80001fae <reparent+0x34>
    80001fa6:	17048493          	addi	s1,s1,368
    80001faa:	03348363          	beq	s1,s3,80001fd0 <reparent+0x56>
    if(pp->parent == p){
    80001fae:	749c                	ld	a5,40(s1)
    80001fb0:	ff279be3          	bne	a5,s2,80001fa6 <reparent+0x2c>
      acquire(&pp->lock);
    80001fb4:	8526                	mv	a0,s1
    80001fb6:	fffff097          	auipc	ra,0xfffff
    80001fba:	b4e080e7          	jalr	-1202(ra) # 80000b04 <acquire>
      pp->parent = initproc;
    80001fbe:	000a3783          	ld	a5,0(s4)
    80001fc2:	f49c                	sd	a5,40(s1)
      release(&pp->lock);
    80001fc4:	8526                	mv	a0,s1
    80001fc6:	fffff097          	auipc	ra,0xfffff
    80001fca:	c02080e7          	jalr	-1022(ra) # 80000bc8 <release>
    80001fce:	bfe1                	j	80001fa6 <reparent+0x2c>
}
    80001fd0:	70a2                	ld	ra,40(sp)
    80001fd2:	7402                	ld	s0,32(sp)
    80001fd4:	64e2                	ld	s1,24(sp)
    80001fd6:	6942                	ld	s2,16(sp)
    80001fd8:	69a2                	ld	s3,8(sp)
    80001fda:	6a02                	ld	s4,0(sp)
    80001fdc:	6145                	addi	sp,sp,48
    80001fde:	8082                	ret

0000000080001fe0 <scheduler>:
{
    80001fe0:	715d                	addi	sp,sp,-80
    80001fe2:	e486                	sd	ra,72(sp)
    80001fe4:	e0a2                	sd	s0,64(sp)
    80001fe6:	fc26                	sd	s1,56(sp)
    80001fe8:	f84a                	sd	s2,48(sp)
    80001fea:	f44e                	sd	s3,40(sp)
    80001fec:	f052                	sd	s4,32(sp)
    80001fee:	ec56                	sd	s5,24(sp)
    80001ff0:	e85a                	sd	s6,16(sp)
    80001ff2:	e45e                	sd	s7,8(sp)
    80001ff4:	e062                	sd	s8,0(sp)
    80001ff6:	0880                	addi	s0,sp,80
    80001ff8:	8792                	mv	a5,tp
  int id = r_tp();
    80001ffa:	2781                	sext.w	a5,a5
  c->proc = 0;
    80001ffc:	00779b13          	slli	s6,a5,0x7
    80002000:	00013717          	auipc	a4,0x13
    80002004:	84070713          	addi	a4,a4,-1984 # 80014840 <pid_lock>
    80002008:	975a                	add	a4,a4,s6
    8000200a:	02073023          	sd	zero,32(a4)
        swtch(&c->scheduler, &p->context);
    8000200e:	00013717          	auipc	a4,0x13
    80002012:	85a70713          	addi	a4,a4,-1958 # 80014868 <cpus+0x8>
    80002016:	9b3a                	add	s6,s6,a4
        p->state = RUNNING;
    80002018:	4b8d                	li	s7,3
        c->proc = p;
    8000201a:	079e                	slli	a5,a5,0x7
    8000201c:	00013917          	auipc	s2,0x13
    80002020:	82490913          	addi	s2,s2,-2012 # 80014840 <pid_lock>
    80002024:	993e                	add	s2,s2,a5
    80002026:	a0b9                	j	80002074 <scheduler+0x94>
      c->intena = 0;
    80002028:	08092e23          	sw	zero,156(s2)
      release(&p->lock);
    8000202c:	8526                	mv	a0,s1
    8000202e:	fffff097          	auipc	ra,0xfffff
    80002032:	b9a080e7          	jalr	-1126(ra) # 80000bc8 <release>
    for(p = proc; p < &proc[NPROC]; p++) {
    80002036:	17048493          	addi	s1,s1,368
    8000203a:	03348963          	beq	s1,s3,8000206c <scheduler+0x8c>
      acquire(&p->lock);
    8000203e:	8526                	mv	a0,s1
    80002040:	fffff097          	auipc	ra,0xfffff
    80002044:	ac4080e7          	jalr	-1340(ra) # 80000b04 <acquire>
      if(p->state == RUNNABLE) {
    80002048:	509c                	lw	a5,32(s1)
    8000204a:	fd479fe3          	bne	a5,s4,80002028 <scheduler+0x48>
        p->state = RUNNING;
    8000204e:	0374a023          	sw	s7,32(s1)
        c->proc = p;
    80002052:	02993023          	sd	s1,32(s2)
        swtch(&c->scheduler, &p->context);
    80002056:	06848593          	addi	a1,s1,104
    8000205a:	855a                	mv	a0,s6
    8000205c:	00000097          	auipc	ra,0x0
    80002060:	618080e7          	jalr	1560(ra) # 80002674 <swtch>
        c->proc = 0;
    80002064:	02093023          	sd	zero,32(s2)
        found = 1;
    80002068:	8ae2                	mv	s5,s8
    8000206a:	bf7d                	j	80002028 <scheduler+0x48>
    if(found == 0){
    8000206c:	000a9463          	bnez	s5,80002074 <scheduler+0x94>
      asm volatile("wfi");
    80002070:	10500073          	wfi
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80002074:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80002078:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    8000207c:	10079073          	csrw	sstatus,a5
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80002080:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80002084:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80002086:	10079073          	csrw	sstatus,a5
    int found = 0;
    8000208a:	4a81                	li	s5,0
    for(p = proc; p < &proc[NPROC]; p++) {
    8000208c:	00013497          	auipc	s1,0x13
    80002090:	bd448493          	addi	s1,s1,-1068 # 80014c60 <proc>
      if(p->state == RUNNABLE) {
    80002094:	4a09                	li	s4,2
        found = 1;
    80002096:	4c05                	li	s8,1
    for(p = proc; p < &proc[NPROC]; p++) {
    80002098:	00014997          	auipc	s3,0x14
    8000209c:	a2898993          	addi	s3,s3,-1496 # 80015ac0 <tickslock>
    800020a0:	bf79                	j	8000203e <scheduler+0x5e>

00000000800020a2 <sched>:
{
    800020a2:	7179                	addi	sp,sp,-48
    800020a4:	f406                	sd	ra,40(sp)
    800020a6:	f022                	sd	s0,32(sp)
    800020a8:	ec26                	sd	s1,24(sp)
    800020aa:	e84a                	sd	s2,16(sp)
    800020ac:	e44e                	sd	s3,8(sp)
    800020ae:	1800                	addi	s0,sp,48
  struct proc *p = myproc();
    800020b0:	00000097          	auipc	ra,0x0
    800020b4:	a50080e7          	jalr	-1456(ra) # 80001b00 <myproc>
    800020b8:	84aa                	mv	s1,a0
  if(!holding(&p->lock))
    800020ba:	fffff097          	auipc	ra,0xfffff
    800020be:	9cc080e7          	jalr	-1588(ra) # 80000a86 <holding>
    800020c2:	cd25                	beqz	a0,8000213a <sched+0x98>
  asm volatile("mv %0, tp" : "=r" (x) );
    800020c4:	8792                	mv	a5,tp
  if(mycpu()->noff != 1)
    800020c6:	2781                	sext.w	a5,a5
    800020c8:	079e                	slli	a5,a5,0x7
    800020ca:	00012717          	auipc	a4,0x12
    800020ce:	77670713          	addi	a4,a4,1910 # 80014840 <pid_lock>
    800020d2:	97ba                	add	a5,a5,a4
    800020d4:	0987a703          	lw	a4,152(a5)
    800020d8:	4785                	li	a5,1
    800020da:	06f71863          	bne	a4,a5,8000214a <sched+0xa8>
  if(p->state == RUNNING)
    800020de:	5098                	lw	a4,32(s1)
    800020e0:	478d                	li	a5,3
    800020e2:	06f70c63          	beq	a4,a5,8000215a <sched+0xb8>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800020e6:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    800020ea:	8b89                	andi	a5,a5,2
  if(intr_get())
    800020ec:	efbd                	bnez	a5,8000216a <sched+0xc8>
  asm volatile("mv %0, tp" : "=r" (x) );
    800020ee:	8792                	mv	a5,tp
  intena = mycpu()->intena;
    800020f0:	00012917          	auipc	s2,0x12
    800020f4:	75090913          	addi	s2,s2,1872 # 80014840 <pid_lock>
    800020f8:	2781                	sext.w	a5,a5
    800020fa:	079e                	slli	a5,a5,0x7
    800020fc:	97ca                	add	a5,a5,s2
    800020fe:	09c7a983          	lw	s3,156(a5)
    80002102:	8792                	mv	a5,tp
  swtch(&p->context, &mycpu()->scheduler);
    80002104:	2781                	sext.w	a5,a5
    80002106:	079e                	slli	a5,a5,0x7
    80002108:	07a1                	addi	a5,a5,8
    8000210a:	00012597          	auipc	a1,0x12
    8000210e:	75658593          	addi	a1,a1,1878 # 80014860 <cpus>
    80002112:	95be                	add	a1,a1,a5
    80002114:	06848513          	addi	a0,s1,104
    80002118:	00000097          	auipc	ra,0x0
    8000211c:	55c080e7          	jalr	1372(ra) # 80002674 <swtch>
    80002120:	8792                	mv	a5,tp
  mycpu()->intena = intena;
    80002122:	2781                	sext.w	a5,a5
    80002124:	079e                	slli	a5,a5,0x7
    80002126:	993e                	add	s2,s2,a5
    80002128:	09392e23          	sw	s3,156(s2)
}
    8000212c:	70a2                	ld	ra,40(sp)
    8000212e:	7402                	ld	s0,32(sp)
    80002130:	64e2                	ld	s1,24(sp)
    80002132:	6942                	ld	s2,16(sp)
    80002134:	69a2                	ld	s3,8(sp)
    80002136:	6145                	addi	sp,sp,48
    80002138:	8082                	ret
    panic("sched p->lock");
    8000213a:	00006517          	auipc	a0,0x6
    8000213e:	34650513          	addi	a0,a0,838 # 80008480 <userret+0x3f0>
    80002142:	ffffe097          	auipc	ra,0xffffe
    80002146:	428080e7          	jalr	1064(ra) # 8000056a <panic>
    panic("sched locks");
    8000214a:	00006517          	auipc	a0,0x6
    8000214e:	34650513          	addi	a0,a0,838 # 80008490 <userret+0x400>
    80002152:	ffffe097          	auipc	ra,0xffffe
    80002156:	418080e7          	jalr	1048(ra) # 8000056a <panic>
    panic("sched running");
    8000215a:	00006517          	auipc	a0,0x6
    8000215e:	34650513          	addi	a0,a0,838 # 800084a0 <userret+0x410>
    80002162:	ffffe097          	auipc	ra,0xffffe
    80002166:	408080e7          	jalr	1032(ra) # 8000056a <panic>
    panic("sched interruptible");
    8000216a:	00006517          	auipc	a0,0x6
    8000216e:	34650513          	addi	a0,a0,838 # 800084b0 <userret+0x420>
    80002172:	ffffe097          	auipc	ra,0xffffe
    80002176:	3f8080e7          	jalr	1016(ra) # 8000056a <panic>

000000008000217a <exit>:
{
    8000217a:	7179                	addi	sp,sp,-48
    8000217c:	f406                	sd	ra,40(sp)
    8000217e:	f022                	sd	s0,32(sp)
    80002180:	ec26                	sd	s1,24(sp)
    80002182:	e84a                	sd	s2,16(sp)
    80002184:	e44e                	sd	s3,8(sp)
    80002186:	e052                	sd	s4,0(sp)
    80002188:	1800                	addi	s0,sp,48
    8000218a:	8a2a                	mv	s4,a0
  struct proc *p = myproc();
    8000218c:	00000097          	auipc	ra,0x0
    80002190:	974080e7          	jalr	-1676(ra) # 80001b00 <myproc>
    80002194:	89aa                	mv	s3,a0
  if(p == initproc)
    80002196:	00026797          	auipc	a5,0x26
    8000219a:	ea27b783          	ld	a5,-350(a5) # 80028038 <initproc>
    8000219e:	0d850493          	addi	s1,a0,216
    800021a2:	15850913          	addi	s2,a0,344
    800021a6:	00a79d63          	bne	a5,a0,800021c0 <exit+0x46>
    panic("init exiting");
    800021aa:	00006517          	auipc	a0,0x6
    800021ae:	31e50513          	addi	a0,a0,798 # 800084c8 <userret+0x438>
    800021b2:	ffffe097          	auipc	ra,0xffffe
    800021b6:	3b8080e7          	jalr	952(ra) # 8000056a <panic>
  for(int fd = 0; fd < NOFILE; fd++){
    800021ba:	04a1                	addi	s1,s1,8
    800021bc:	01248b63          	beq	s1,s2,800021d2 <exit+0x58>
    if(p->ofile[fd]){
    800021c0:	6088                	ld	a0,0(s1)
    800021c2:	dd65                	beqz	a0,800021ba <exit+0x40>
      fileclose(f);
    800021c4:	00002097          	auipc	ra,0x2
    800021c8:	552080e7          	jalr	1362(ra) # 80004716 <fileclose>
      p->ofile[fd] = 0;
    800021cc:	0004b023          	sd	zero,0(s1)
    800021d0:	b7ed                	j	800021ba <exit+0x40>
  begin_op(ROOTDEV);
    800021d2:	4501                	li	a0,0
    800021d4:	00002097          	auipc	ra,0x2
    800021d8:	fa6080e7          	jalr	-90(ra) # 8000417a <begin_op>
  iput(p->cwd);
    800021dc:	1589b503          	ld	a0,344(s3)
    800021e0:	00001097          	auipc	ra,0x1
    800021e4:	69e080e7          	jalr	1694(ra) # 8000387e <iput>
  end_op(ROOTDEV);
    800021e8:	4501                	li	a0,0
    800021ea:	00002097          	auipc	ra,0x2
    800021ee:	032080e7          	jalr	50(ra) # 8000421c <end_op>
  p->cwd = 0;
    800021f2:	1409bc23          	sd	zero,344(s3)
  acquire(&initproc->lock);
    800021f6:	00026497          	auipc	s1,0x26
    800021fa:	e4248493          	addi	s1,s1,-446 # 80028038 <initproc>
    800021fe:	6088                	ld	a0,0(s1)
    80002200:	fffff097          	auipc	ra,0xfffff
    80002204:	904080e7          	jalr	-1788(ra) # 80000b04 <acquire>
  wakeup1(initproc);
    80002208:	6088                	ld	a0,0(s1)
    8000220a:	fffff097          	auipc	ra,0xfffff
    8000220e:	794080e7          	jalr	1940(ra) # 8000199e <wakeup1>
  release(&initproc->lock);
    80002212:	6088                	ld	a0,0(s1)
    80002214:	fffff097          	auipc	ra,0xfffff
    80002218:	9b4080e7          	jalr	-1612(ra) # 80000bc8 <release>
  acquire(&p->lock);
    8000221c:	854e                	mv	a0,s3
    8000221e:	fffff097          	auipc	ra,0xfffff
    80002222:	8e6080e7          	jalr	-1818(ra) # 80000b04 <acquire>
  struct proc *original_parent = p->parent;
    80002226:	0289b483          	ld	s1,40(s3)
  release(&p->lock);
    8000222a:	854e                	mv	a0,s3
    8000222c:	fffff097          	auipc	ra,0xfffff
    80002230:	99c080e7          	jalr	-1636(ra) # 80000bc8 <release>
  acquire(&original_parent->lock);
    80002234:	8526                	mv	a0,s1
    80002236:	fffff097          	auipc	ra,0xfffff
    8000223a:	8ce080e7          	jalr	-1842(ra) # 80000b04 <acquire>
  acquire(&p->lock);
    8000223e:	854e                	mv	a0,s3
    80002240:	fffff097          	auipc	ra,0xfffff
    80002244:	8c4080e7          	jalr	-1852(ra) # 80000b04 <acquire>
  reparent(p);
    80002248:	854e                	mv	a0,s3
    8000224a:	00000097          	auipc	ra,0x0
    8000224e:	d30080e7          	jalr	-720(ra) # 80001f7a <reparent>
  wakeup1(original_parent);
    80002252:	8526                	mv	a0,s1
    80002254:	fffff097          	auipc	ra,0xfffff
    80002258:	74a080e7          	jalr	1866(ra) # 8000199e <wakeup1>
  p->xstate = status;
    8000225c:	0349ae23          	sw	s4,60(s3)
  p->state = ZOMBIE;
    80002260:	4791                	li	a5,4
    80002262:	02f9a023          	sw	a5,32(s3)
  release(&original_parent->lock);
    80002266:	8526                	mv	a0,s1
    80002268:	fffff097          	auipc	ra,0xfffff
    8000226c:	960080e7          	jalr	-1696(ra) # 80000bc8 <release>
  sched();
    80002270:	00000097          	auipc	ra,0x0
    80002274:	e32080e7          	jalr	-462(ra) # 800020a2 <sched>
  panic("zombie exit");
    80002278:	00006517          	auipc	a0,0x6
    8000227c:	26050513          	addi	a0,a0,608 # 800084d8 <userret+0x448>
    80002280:	ffffe097          	auipc	ra,0xffffe
    80002284:	2ea080e7          	jalr	746(ra) # 8000056a <panic>

0000000080002288 <yield>:
{
    80002288:	1101                	addi	sp,sp,-32
    8000228a:	ec06                	sd	ra,24(sp)
    8000228c:	e822                	sd	s0,16(sp)
    8000228e:	e426                	sd	s1,8(sp)
    80002290:	1000                	addi	s0,sp,32
  struct proc *p = myproc();
    80002292:	00000097          	auipc	ra,0x0
    80002296:	86e080e7          	jalr	-1938(ra) # 80001b00 <myproc>
    8000229a:	84aa                	mv	s1,a0
  acquire(&p->lock);
    8000229c:	fffff097          	auipc	ra,0xfffff
    800022a0:	868080e7          	jalr	-1944(ra) # 80000b04 <acquire>
  p->state = RUNNABLE;
    800022a4:	4789                	li	a5,2
    800022a6:	d09c                	sw	a5,32(s1)
  sched();
    800022a8:	00000097          	auipc	ra,0x0
    800022ac:	dfa080e7          	jalr	-518(ra) # 800020a2 <sched>
  release(&p->lock);
    800022b0:	8526                	mv	a0,s1
    800022b2:	fffff097          	auipc	ra,0xfffff
    800022b6:	916080e7          	jalr	-1770(ra) # 80000bc8 <release>
}
    800022ba:	60e2                	ld	ra,24(sp)
    800022bc:	6442                	ld	s0,16(sp)
    800022be:	64a2                	ld	s1,8(sp)
    800022c0:	6105                	addi	sp,sp,32
    800022c2:	8082                	ret

00000000800022c4 <sleep>:
{
    800022c4:	7179                	addi	sp,sp,-48
    800022c6:	f406                	sd	ra,40(sp)
    800022c8:	f022                	sd	s0,32(sp)
    800022ca:	ec26                	sd	s1,24(sp)
    800022cc:	e84a                	sd	s2,16(sp)
    800022ce:	e44e                	sd	s3,8(sp)
    800022d0:	1800                	addi	s0,sp,48
    800022d2:	89aa                	mv	s3,a0
    800022d4:	892e                	mv	s2,a1
  struct proc *p = myproc();
    800022d6:	00000097          	auipc	ra,0x0
    800022da:	82a080e7          	jalr	-2006(ra) # 80001b00 <myproc>
    800022de:	84aa                	mv	s1,a0
  if(lk != &p->lock){  //DOC: sleeplock0
    800022e0:	05250663          	beq	a0,s2,8000232c <sleep+0x68>
    acquire(&p->lock);  //DOC: sleeplock1
    800022e4:	fffff097          	auipc	ra,0xfffff
    800022e8:	820080e7          	jalr	-2016(ra) # 80000b04 <acquire>
    release(lk);
    800022ec:	854a                	mv	a0,s2
    800022ee:	fffff097          	auipc	ra,0xfffff
    800022f2:	8da080e7          	jalr	-1830(ra) # 80000bc8 <release>
  p->chan = chan;
    800022f6:	0334b823          	sd	s3,48(s1)
  p->state = SLEEPING;
    800022fa:	4785                	li	a5,1
    800022fc:	d09c                	sw	a5,32(s1)
  sched();
    800022fe:	00000097          	auipc	ra,0x0
    80002302:	da4080e7          	jalr	-604(ra) # 800020a2 <sched>
  p->chan = 0;
    80002306:	0204b823          	sd	zero,48(s1)
    release(&p->lock);
    8000230a:	8526                	mv	a0,s1
    8000230c:	fffff097          	auipc	ra,0xfffff
    80002310:	8bc080e7          	jalr	-1860(ra) # 80000bc8 <release>
    acquire(lk);
    80002314:	854a                	mv	a0,s2
    80002316:	ffffe097          	auipc	ra,0xffffe
    8000231a:	7ee080e7          	jalr	2030(ra) # 80000b04 <acquire>
}
    8000231e:	70a2                	ld	ra,40(sp)
    80002320:	7402                	ld	s0,32(sp)
    80002322:	64e2                	ld	s1,24(sp)
    80002324:	6942                	ld	s2,16(sp)
    80002326:	69a2                	ld	s3,8(sp)
    80002328:	6145                	addi	sp,sp,48
    8000232a:	8082                	ret
  p->chan = chan;
    8000232c:	0334b823          	sd	s3,48(s1)
  p->state = SLEEPING;
    80002330:	4785                	li	a5,1
    80002332:	d11c                	sw	a5,32(a0)
  sched();
    80002334:	00000097          	auipc	ra,0x0
    80002338:	d6e080e7          	jalr	-658(ra) # 800020a2 <sched>
  p->chan = 0;
    8000233c:	0204b823          	sd	zero,48(s1)
  if(lk != &p->lock){
    80002340:	bff9                	j	8000231e <sleep+0x5a>

0000000080002342 <wait>:
{
    80002342:	7139                	addi	sp,sp,-64
    80002344:	fc06                	sd	ra,56(sp)
    80002346:	f822                	sd	s0,48(sp)
    80002348:	f426                	sd	s1,40(sp)
    8000234a:	f04a                	sd	s2,32(sp)
    8000234c:	ec4e                	sd	s3,24(sp)
    8000234e:	e852                	sd	s4,16(sp)
    80002350:	e456                	sd	s5,8(sp)
    80002352:	e05a                	sd	s6,0(sp)
    80002354:	0080                	addi	s0,sp,64
    80002356:	8b2a                	mv	s6,a0
  struct proc *p = myproc();
    80002358:	fffff097          	auipc	ra,0xfffff
    8000235c:	7a8080e7          	jalr	1960(ra) # 80001b00 <myproc>
    80002360:	892a                	mv	s2,a0
  acquire(&p->lock);
    80002362:	ffffe097          	auipc	ra,0xffffe
    80002366:	7a2080e7          	jalr	1954(ra) # 80000b04 <acquire>
        if(np->state == ZOMBIE){
    8000236a:	4a11                	li	s4,4
        havekids = 1;
    8000236c:	4a85                	li	s5,1
    for(np = proc; np < &proc[NPROC]; np++){
    8000236e:	00013997          	auipc	s3,0x13
    80002372:	75298993          	addi	s3,s3,1874 # 80015ac0 <tickslock>
    80002376:	a07d                	j	80002424 <wait+0xe2>
          pid = np->pid;
    80002378:	0404a983          	lw	s3,64(s1)
          if(addr != 0 && copyout(p->pagetable, addr, (char *)&np->xstate,
    8000237c:	000b0e63          	beqz	s6,80002398 <wait+0x56>
    80002380:	4691                	li	a3,4
    80002382:	03c48613          	addi	a2,s1,60
    80002386:	85da                	mv	a1,s6
    80002388:	05893503          	ld	a0,88(s2)
    8000238c:	fffff097          	auipc	ra,0xfffff
    80002390:	438080e7          	jalr	1080(ra) # 800017c4 <copyout>
    80002394:	02054c63          	bltz	a0,800023cc <wait+0x8a>
          freeproc(np);
    80002398:	8526                	mv	a0,s1
    8000239a:	00000097          	auipc	ra,0x0
    8000239e:	982080e7          	jalr	-1662(ra) # 80001d1c <freeproc>
          release(&np->lock);
    800023a2:	8526                	mv	a0,s1
    800023a4:	fffff097          	auipc	ra,0xfffff
    800023a8:	824080e7          	jalr	-2012(ra) # 80000bc8 <release>
          release(&p->lock);
    800023ac:	854a                	mv	a0,s2
    800023ae:	fffff097          	auipc	ra,0xfffff
    800023b2:	81a080e7          	jalr	-2022(ra) # 80000bc8 <release>
}
    800023b6:	854e                	mv	a0,s3
    800023b8:	70e2                	ld	ra,56(sp)
    800023ba:	7442                	ld	s0,48(sp)
    800023bc:	74a2                	ld	s1,40(sp)
    800023be:	7902                	ld	s2,32(sp)
    800023c0:	69e2                	ld	s3,24(sp)
    800023c2:	6a42                	ld	s4,16(sp)
    800023c4:	6aa2                	ld	s5,8(sp)
    800023c6:	6b02                	ld	s6,0(sp)
    800023c8:	6121                	addi	sp,sp,64
    800023ca:	8082                	ret
            release(&np->lock);
    800023cc:	8526                	mv	a0,s1
    800023ce:	ffffe097          	auipc	ra,0xffffe
    800023d2:	7fa080e7          	jalr	2042(ra) # 80000bc8 <release>
            release(&p->lock);
    800023d6:	854a                	mv	a0,s2
    800023d8:	ffffe097          	auipc	ra,0xffffe
    800023dc:	7f0080e7          	jalr	2032(ra) # 80000bc8 <release>
            return -1;
    800023e0:	59fd                	li	s3,-1
    800023e2:	bfd1                	j	800023b6 <wait+0x74>
    for(np = proc; np < &proc[NPROC]; np++){
    800023e4:	17048493          	addi	s1,s1,368
    800023e8:	03348463          	beq	s1,s3,80002410 <wait+0xce>
      if(np->parent == p){
    800023ec:	749c                	ld	a5,40(s1)
    800023ee:	ff279be3          	bne	a5,s2,800023e4 <wait+0xa2>
        acquire(&np->lock);
    800023f2:	8526                	mv	a0,s1
    800023f4:	ffffe097          	auipc	ra,0xffffe
    800023f8:	710080e7          	jalr	1808(ra) # 80000b04 <acquire>
        if(np->state == ZOMBIE){
    800023fc:	509c                	lw	a5,32(s1)
    800023fe:	f7478de3          	beq	a5,s4,80002378 <wait+0x36>
        release(&np->lock);
    80002402:	8526                	mv	a0,s1
    80002404:	ffffe097          	auipc	ra,0xffffe
    80002408:	7c4080e7          	jalr	1988(ra) # 80000bc8 <release>
        havekids = 1;
    8000240c:	8756                	mv	a4,s5
    8000240e:	bfd9                	j	800023e4 <wait+0xa2>
    if(!havekids || p->killed){
    80002410:	c305                	beqz	a4,80002430 <wait+0xee>
    80002412:	03892783          	lw	a5,56(s2)
    80002416:	ef89                	bnez	a5,80002430 <wait+0xee>
    sleep(p, &p->lock);  //DOC: wait-sleep
    80002418:	85ca                	mv	a1,s2
    8000241a:	854a                	mv	a0,s2
    8000241c:	00000097          	auipc	ra,0x0
    80002420:	ea8080e7          	jalr	-344(ra) # 800022c4 <sleep>
    havekids = 0;
    80002424:	4701                	li	a4,0
    for(np = proc; np < &proc[NPROC]; np++){
    80002426:	00013497          	auipc	s1,0x13
    8000242a:	83a48493          	addi	s1,s1,-1990 # 80014c60 <proc>
    8000242e:	bf7d                	j	800023ec <wait+0xaa>
      release(&p->lock);
    80002430:	854a                	mv	a0,s2
    80002432:	ffffe097          	auipc	ra,0xffffe
    80002436:	796080e7          	jalr	1942(ra) # 80000bc8 <release>
      return -1;
    8000243a:	59fd                	li	s3,-1
    8000243c:	bfad                	j	800023b6 <wait+0x74>

000000008000243e <wakeup>:
{
    8000243e:	7139                	addi	sp,sp,-64
    80002440:	fc06                	sd	ra,56(sp)
    80002442:	f822                	sd	s0,48(sp)
    80002444:	f426                	sd	s1,40(sp)
    80002446:	f04a                	sd	s2,32(sp)
    80002448:	ec4e                	sd	s3,24(sp)
    8000244a:	e852                	sd	s4,16(sp)
    8000244c:	e456                	sd	s5,8(sp)
    8000244e:	0080                	addi	s0,sp,64
    80002450:	8a2a                	mv	s4,a0
  for(p = proc; p < &proc[NPROC]; p++) {
    80002452:	00013497          	auipc	s1,0x13
    80002456:	80e48493          	addi	s1,s1,-2034 # 80014c60 <proc>
    if(p->state == SLEEPING && p->chan == chan) {
    8000245a:	4985                	li	s3,1
      p->state = RUNNABLE;
    8000245c:	4a89                	li	s5,2
  for(p = proc; p < &proc[NPROC]; p++) {
    8000245e:	00013917          	auipc	s2,0x13
    80002462:	66290913          	addi	s2,s2,1634 # 80015ac0 <tickslock>
    80002466:	a811                	j	8000247a <wakeup+0x3c>
    release(&p->lock);
    80002468:	8526                	mv	a0,s1
    8000246a:	ffffe097          	auipc	ra,0xffffe
    8000246e:	75e080e7          	jalr	1886(ra) # 80000bc8 <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    80002472:	17048493          	addi	s1,s1,368
    80002476:	03248063          	beq	s1,s2,80002496 <wakeup+0x58>
    acquire(&p->lock);
    8000247a:	8526                	mv	a0,s1
    8000247c:	ffffe097          	auipc	ra,0xffffe
    80002480:	688080e7          	jalr	1672(ra) # 80000b04 <acquire>
    if(p->state == SLEEPING && p->chan == chan) {
    80002484:	509c                	lw	a5,32(s1)
    80002486:	ff3791e3          	bne	a5,s3,80002468 <wakeup+0x2a>
    8000248a:	789c                	ld	a5,48(s1)
    8000248c:	fd479ee3          	bne	a5,s4,80002468 <wakeup+0x2a>
      p->state = RUNNABLE;
    80002490:	0354a023          	sw	s5,32(s1)
    80002494:	bfd1                	j	80002468 <wakeup+0x2a>
}
    80002496:	70e2                	ld	ra,56(sp)
    80002498:	7442                	ld	s0,48(sp)
    8000249a:	74a2                	ld	s1,40(sp)
    8000249c:	7902                	ld	s2,32(sp)
    8000249e:	69e2                	ld	s3,24(sp)
    800024a0:	6a42                	ld	s4,16(sp)
    800024a2:	6aa2                	ld	s5,8(sp)
    800024a4:	6121                	addi	sp,sp,64
    800024a6:	8082                	ret

00000000800024a8 <kill>:
// Kill the process with the given pid.
// The victim won't exit until it tries to return
// to user space (see usertrap() in trap.c).
int
kill(int pid)
{
    800024a8:	7179                	addi	sp,sp,-48
    800024aa:	f406                	sd	ra,40(sp)
    800024ac:	f022                	sd	s0,32(sp)
    800024ae:	ec26                	sd	s1,24(sp)
    800024b0:	e84a                	sd	s2,16(sp)
    800024b2:	e44e                	sd	s3,8(sp)
    800024b4:	1800                	addi	s0,sp,48
    800024b6:	892a                	mv	s2,a0
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++){
    800024b8:	00012497          	auipc	s1,0x12
    800024bc:	7a848493          	addi	s1,s1,1960 # 80014c60 <proc>
    800024c0:	00013997          	auipc	s3,0x13
    800024c4:	60098993          	addi	s3,s3,1536 # 80015ac0 <tickslock>
    acquire(&p->lock);
    800024c8:	8526                	mv	a0,s1
    800024ca:	ffffe097          	auipc	ra,0xffffe
    800024ce:	63a080e7          	jalr	1594(ra) # 80000b04 <acquire>
    if(p->pid == pid){
    800024d2:	40bc                	lw	a5,64(s1)
    800024d4:	03278363          	beq	a5,s2,800024fa <kill+0x52>
        p->state = RUNNABLE;
      }
      release(&p->lock);
      return 0;
    }
    release(&p->lock);
    800024d8:	8526                	mv	a0,s1
    800024da:	ffffe097          	auipc	ra,0xffffe
    800024de:	6ee080e7          	jalr	1774(ra) # 80000bc8 <release>
  for(p = proc; p < &proc[NPROC]; p++){
    800024e2:	17048493          	addi	s1,s1,368
    800024e6:	ff3491e3          	bne	s1,s3,800024c8 <kill+0x20>
  }
  return -1;
    800024ea:	557d                	li	a0,-1
}
    800024ec:	70a2                	ld	ra,40(sp)
    800024ee:	7402                	ld	s0,32(sp)
    800024f0:	64e2                	ld	s1,24(sp)
    800024f2:	6942                	ld	s2,16(sp)
    800024f4:	69a2                	ld	s3,8(sp)
    800024f6:	6145                	addi	sp,sp,48
    800024f8:	8082                	ret
      p->killed = 1;
    800024fa:	4785                	li	a5,1
    800024fc:	dc9c                	sw	a5,56(s1)
      if(p->state == SLEEPING){
    800024fe:	5098                	lw	a4,32(s1)
    80002500:	00f70963          	beq	a4,a5,80002512 <kill+0x6a>
      release(&p->lock);
    80002504:	8526                	mv	a0,s1
    80002506:	ffffe097          	auipc	ra,0xffffe
    8000250a:	6c2080e7          	jalr	1730(ra) # 80000bc8 <release>
      return 0;
    8000250e:	4501                	li	a0,0
    80002510:	bff1                	j	800024ec <kill+0x44>
        p->state = RUNNABLE;
    80002512:	4789                	li	a5,2
    80002514:	d09c                	sw	a5,32(s1)
    80002516:	b7fd                	j	80002504 <kill+0x5c>

0000000080002518 <either_copyout>:
// Copy to either a user address, or kernel address,
// depending on usr_dst.
// Returns 0 on success, -1 on error.
int
either_copyout(int user_dst, uint64 dst, void *src, uint64 len)
{
    80002518:	7179                	addi	sp,sp,-48
    8000251a:	f406                	sd	ra,40(sp)
    8000251c:	f022                	sd	s0,32(sp)
    8000251e:	ec26                	sd	s1,24(sp)
    80002520:	e84a                	sd	s2,16(sp)
    80002522:	e44e                	sd	s3,8(sp)
    80002524:	e052                	sd	s4,0(sp)
    80002526:	1800                	addi	s0,sp,48
    80002528:	84aa                	mv	s1,a0
    8000252a:	8a2e                	mv	s4,a1
    8000252c:	89b2                	mv	s3,a2
    8000252e:	8936                	mv	s2,a3
  struct proc *p = myproc();
    80002530:	fffff097          	auipc	ra,0xfffff
    80002534:	5d0080e7          	jalr	1488(ra) # 80001b00 <myproc>
  if(user_dst){
    80002538:	c08d                	beqz	s1,8000255a <either_copyout+0x42>
    return copyout(p->pagetable, dst, src, len);
    8000253a:	86ca                	mv	a3,s2
    8000253c:	864e                	mv	a2,s3
    8000253e:	85d2                	mv	a1,s4
    80002540:	6d28                	ld	a0,88(a0)
    80002542:	fffff097          	auipc	ra,0xfffff
    80002546:	282080e7          	jalr	642(ra) # 800017c4 <copyout>
  } else {
    memmove((char *)dst, src, len);
    return 0;
  }
}
    8000254a:	70a2                	ld	ra,40(sp)
    8000254c:	7402                	ld	s0,32(sp)
    8000254e:	64e2                	ld	s1,24(sp)
    80002550:	6942                	ld	s2,16(sp)
    80002552:	69a2                	ld	s3,8(sp)
    80002554:	6a02                	ld	s4,0(sp)
    80002556:	6145                	addi	sp,sp,48
    80002558:	8082                	ret
    memmove((char *)dst, src, len);
    8000255a:	0009061b          	sext.w	a2,s2
    8000255e:	85ce                	mv	a1,s3
    80002560:	8552                	mv	a0,s4
    80002562:	fffff097          	auipc	ra,0xfffff
    80002566:	8bc080e7          	jalr	-1860(ra) # 80000e1e <memmove>
    return 0;
    8000256a:	8526                	mv	a0,s1
    8000256c:	bff9                	j	8000254a <either_copyout+0x32>

000000008000256e <either_copyin>:
// Copy from either a user address, or kernel address,
// depending on usr_src.
// Returns 0 on success, -1 on error.
int
either_copyin(void *dst, int user_src, uint64 src, uint64 len)
{
    8000256e:	7179                	addi	sp,sp,-48
    80002570:	f406                	sd	ra,40(sp)
    80002572:	f022                	sd	s0,32(sp)
    80002574:	ec26                	sd	s1,24(sp)
    80002576:	e84a                	sd	s2,16(sp)
    80002578:	e44e                	sd	s3,8(sp)
    8000257a:	e052                	sd	s4,0(sp)
    8000257c:	1800                	addi	s0,sp,48
    8000257e:	8a2a                	mv	s4,a0
    80002580:	84ae                	mv	s1,a1
    80002582:	89b2                	mv	s3,a2
    80002584:	8936                	mv	s2,a3
  struct proc *p = myproc();
    80002586:	fffff097          	auipc	ra,0xfffff
    8000258a:	57a080e7          	jalr	1402(ra) # 80001b00 <myproc>
  if(user_src){
    8000258e:	c08d                	beqz	s1,800025b0 <either_copyin+0x42>
    return copyin(p->pagetable, dst, src, len);
    80002590:	86ca                	mv	a3,s2
    80002592:	864e                	mv	a2,s3
    80002594:	85d2                	mv	a1,s4
    80002596:	6d28                	ld	a0,88(a0)
    80002598:	fffff097          	auipc	ra,0xfffff
    8000259c:	2b8080e7          	jalr	696(ra) # 80001850 <copyin>
  } else {
    memmove(dst, (char*)src, len);
    return 0;
  }
}
    800025a0:	70a2                	ld	ra,40(sp)
    800025a2:	7402                	ld	s0,32(sp)
    800025a4:	64e2                	ld	s1,24(sp)
    800025a6:	6942                	ld	s2,16(sp)
    800025a8:	69a2                	ld	s3,8(sp)
    800025aa:	6a02                	ld	s4,0(sp)
    800025ac:	6145                	addi	sp,sp,48
    800025ae:	8082                	ret
    memmove(dst, (char*)src, len);
    800025b0:	0009061b          	sext.w	a2,s2
    800025b4:	85ce                	mv	a1,s3
    800025b6:	8552                	mv	a0,s4
    800025b8:	fffff097          	auipc	ra,0xfffff
    800025bc:	866080e7          	jalr	-1946(ra) # 80000e1e <memmove>
    return 0;
    800025c0:	8526                	mv	a0,s1
    800025c2:	bff9                	j	800025a0 <either_copyin+0x32>

00000000800025c4 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
    800025c4:	715d                	addi	sp,sp,-80
    800025c6:	e486                	sd	ra,72(sp)
    800025c8:	e0a2                	sd	s0,64(sp)
    800025ca:	fc26                	sd	s1,56(sp)
    800025cc:	f84a                	sd	s2,48(sp)
    800025ce:	f44e                	sd	s3,40(sp)
    800025d0:	f052                	sd	s4,32(sp)
    800025d2:	ec56                	sd	s5,24(sp)
    800025d4:	e85a                	sd	s6,16(sp)
    800025d6:	e45e                	sd	s7,8(sp)
    800025d8:	0880                	addi	s0,sp,80
  [ZOMBIE]    "zombie"
  };
  struct proc *p;
  char *state;

  printf("\n");
    800025da:	00006517          	auipc	a0,0x6
    800025de:	b4e50513          	addi	a0,a0,-1202 # 80008128 <userret+0x98>
    800025e2:	ffffe097          	auipc	ra,0xffffe
    800025e6:	fe2080e7          	jalr	-30(ra) # 800005c4 <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    800025ea:	00012497          	auipc	s1,0x12
    800025ee:	7d648493          	addi	s1,s1,2006 # 80014dc0 <proc+0x160>
    800025f2:	00013917          	auipc	s2,0x13
    800025f6:	62e90913          	addi	s2,s2,1582 # 80015c20 <bcache+0x140>
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    800025fa:	4b11                	li	s6,4
      state = states[p->state];
    else
      state = "???";
    800025fc:	00006997          	auipc	s3,0x6
    80002600:	eec98993          	addi	s3,s3,-276 # 800084e8 <userret+0x458>
    printf("%d %s %s", p->pid, state, p->name);
    80002604:	00006a97          	auipc	s5,0x6
    80002608:	eeca8a93          	addi	s5,s5,-276 # 800084f0 <userret+0x460>
    printf("\n");
    8000260c:	00006a17          	auipc	s4,0x6
    80002610:	b1ca0a13          	addi	s4,s4,-1252 # 80008128 <userret+0x98>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80002614:	00006b97          	auipc	s7,0x6
    80002618:	73cb8b93          	addi	s7,s7,1852 # 80008d50 <states.0>
    8000261c:	a00d                	j	8000263e <procdump+0x7a>
    printf("%d %s %s", p->pid, state, p->name);
    8000261e:	ee06a583          	lw	a1,-288(a3)
    80002622:	8556                	mv	a0,s5
    80002624:	ffffe097          	auipc	ra,0xffffe
    80002628:	fa0080e7          	jalr	-96(ra) # 800005c4 <printf>
    printf("\n");
    8000262c:	8552                	mv	a0,s4
    8000262e:	ffffe097          	auipc	ra,0xffffe
    80002632:	f96080e7          	jalr	-106(ra) # 800005c4 <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    80002636:	17048493          	addi	s1,s1,368
    8000263a:	03248263          	beq	s1,s2,8000265e <procdump+0x9a>
    if(p->state == UNUSED)
    8000263e:	86a6                	mv	a3,s1
    80002640:	ec04a783          	lw	a5,-320(s1)
    80002644:	dbed                	beqz	a5,80002636 <procdump+0x72>
      state = "???";
    80002646:	864e                	mv	a2,s3
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80002648:	fcfb6be3          	bltu	s6,a5,8000261e <procdump+0x5a>
    8000264c:	02079713          	slli	a4,a5,0x20
    80002650:	01d75793          	srli	a5,a4,0x1d
    80002654:	97de                	add	a5,a5,s7
    80002656:	6390                	ld	a2,0(a5)
    80002658:	f279                	bnez	a2,8000261e <procdump+0x5a>
      state = "???";
    8000265a:	864e                	mv	a2,s3
    8000265c:	b7c9                	j	8000261e <procdump+0x5a>
  }
}
    8000265e:	60a6                	ld	ra,72(sp)
    80002660:	6406                	ld	s0,64(sp)
    80002662:	74e2                	ld	s1,56(sp)
    80002664:	7942                	ld	s2,48(sp)
    80002666:	79a2                	ld	s3,40(sp)
    80002668:	7a02                	ld	s4,32(sp)
    8000266a:	6ae2                	ld	s5,24(sp)
    8000266c:	6b42                	ld	s6,16(sp)
    8000266e:	6ba2                	ld	s7,8(sp)
    80002670:	6161                	addi	sp,sp,80
    80002672:	8082                	ret

0000000080002674 <swtch>:
    80002674:	00153023          	sd	ra,0(a0)
    80002678:	00253423          	sd	sp,8(a0)
    8000267c:	e900                	sd	s0,16(a0)
    8000267e:	ed04                	sd	s1,24(a0)
    80002680:	03253023          	sd	s2,32(a0)
    80002684:	03353423          	sd	s3,40(a0)
    80002688:	03453823          	sd	s4,48(a0)
    8000268c:	03553c23          	sd	s5,56(a0)
    80002690:	05653023          	sd	s6,64(a0)
    80002694:	05753423          	sd	s7,72(a0)
    80002698:	05853823          	sd	s8,80(a0)
    8000269c:	05953c23          	sd	s9,88(a0)
    800026a0:	07a53023          	sd	s10,96(a0)
    800026a4:	07b53423          	sd	s11,104(a0)
    800026a8:	0005b083          	ld	ra,0(a1)
    800026ac:	0085b103          	ld	sp,8(a1)
    800026b0:	6980                	ld	s0,16(a1)
    800026b2:	6d84                	ld	s1,24(a1)
    800026b4:	0205b903          	ld	s2,32(a1)
    800026b8:	0285b983          	ld	s3,40(a1)
    800026bc:	0305ba03          	ld	s4,48(a1)
    800026c0:	0385ba83          	ld	s5,56(a1)
    800026c4:	0405bb03          	ld	s6,64(a1)
    800026c8:	0485bb83          	ld	s7,72(a1)
    800026cc:	0505bc03          	ld	s8,80(a1)
    800026d0:	0585bc83          	ld	s9,88(a1)
    800026d4:	0605bd03          	ld	s10,96(a1)
    800026d8:	0685bd83          	ld	s11,104(a1)
    800026dc:	8082                	ret

00000000800026de <scause_desc>:
  }
}

static const char *
scause_desc(uint64 stval)
{
    800026de:	1141                	addi	sp,sp,-16
    800026e0:	e406                	sd	ra,8(sp)
    800026e2:	e022                	sd	s0,0(sp)
    800026e4:	0800                	addi	s0,sp,16
    800026e6:	87aa                	mv	a5,a0
    [13] "load page fault",
    [14] "<reserved for future standard use>",
    [15] "store/AMO page fault",
  };
  uint64 interrupt = stval & 0x8000000000000000L;
  uint64 code = stval & ~0x8000000000000000L;
    800026e8:	00151713          	slli	a4,a0,0x1
    800026ec:	8305                	srli	a4,a4,0x1
  if (interrupt) {
    800026ee:	04054663          	bltz	a0,8000273a <scause_desc+0x5c>
      return intr_desc[code];
    } else {
      return "<reserved for platform use>";
    }
  } else {
    if (code < NELEM(nointr_desc)) {
    800026f2:	00151693          	slli	a3,a0,0x1
    800026f6:	8295                	srli	a3,a3,0x5
    800026f8:	c6a5                	beqz	a3,80002760 <scause_desc+0x82>
      return nointr_desc[code];
    } else if (code <= 23) {
    800026fa:	46dd                	li	a3,23
      return "<reserved for future standard use>";
    800026fc:	00006517          	auipc	a0,0x6
    80002700:	e4c50513          	addi	a0,a0,-436 # 80008548 <userret+0x4b8>
    } else if (code <= 23) {
    80002704:	04e6fa63          	bgeu	a3,a4,80002758 <scause_desc+0x7a>
    } else if (code <= 31) {
      return "<reserved for custom use>";
    80002708:	00006517          	auipc	a0,0x6
    8000270c:	e6850513          	addi	a0,a0,-408 # 80008570 <userret+0x4e0>
    } else if (code <= 31) {
    80002710:	00179693          	slli	a3,a5,0x1
    80002714:	8299                	srli	a3,a3,0x6
    80002716:	c2a9                	beqz	a3,80002758 <scause_desc+0x7a>
    } else if (code <= 47) {
    80002718:	02f00693          	li	a3,47
      return "<reserved for future standard use>";
    8000271c:	00006517          	auipc	a0,0x6
    80002720:	e2c50513          	addi	a0,a0,-468 # 80008548 <userret+0x4b8>
    } else if (code <= 47) {
    80002724:	02e6fa63          	bgeu	a3,a4,80002758 <scause_desc+0x7a>
    } else if (code <= 63) {
    80002728:	00179713          	slli	a4,a5,0x1
    8000272c:	831d                	srli	a4,a4,0x7
    8000272e:	e70d                	bnez	a4,80002758 <scause_desc+0x7a>
      return "<reserved for custom use>";
    80002730:	00006517          	auipc	a0,0x6
    80002734:	e4050513          	addi	a0,a0,-448 # 80008570 <userret+0x4e0>
    80002738:	a005                	j	80002758 <scause_desc+0x7a>
      return "<reserved for platform use>";
    8000273a:	00006517          	auipc	a0,0x6
    8000273e:	dee50513          	addi	a0,a0,-530 # 80008528 <userret+0x498>
    if (code < NELEM(intr_desc)) {
    80002742:	00179693          	slli	a3,a5,0x1
    80002746:	8295                	srli	a3,a3,0x5
    80002748:	ea81                	bnez	a3,80002758 <scause_desc+0x7a>
      return intr_desc[code];
    8000274a:	070e                	slli	a4,a4,0x3
    8000274c:	00006797          	auipc	a5,0x6
    80002750:	62c78793          	addi	a5,a5,1580 # 80008d78 <intr_desc.1>
    80002754:	97ba                	add	a5,a5,a4
    80002756:	6388                	ld	a0,0(a5)
    } else {
      return "<reserved for future standard use>";
    }
  }
}
    80002758:	60a2                	ld	ra,8(sp)
    8000275a:	6402                	ld	s0,0(sp)
    8000275c:	0141                	addi	sp,sp,16
    8000275e:	8082                	ret
      return nointr_desc[code];
    80002760:	070e                	slli	a4,a4,0x3
    80002762:	00006797          	auipc	a5,0x6
    80002766:	61678793          	addi	a5,a5,1558 # 80008d78 <intr_desc.1>
    8000276a:	97ba                	add	a5,a5,a4
    8000276c:	63c8                	ld	a0,128(a5)
    8000276e:	b7ed                	j	80002758 <scause_desc+0x7a>

0000000080002770 <trapinit>:
{
    80002770:	1141                	addi	sp,sp,-16
    80002772:	e406                	sd	ra,8(sp)
    80002774:	e022                	sd	s0,0(sp)
    80002776:	0800                	addi	s0,sp,16
  initlock(&tickslock, "time");
    80002778:	00006597          	auipc	a1,0x6
    8000277c:	e1858593          	addi	a1,a1,-488 # 80008590 <userret+0x500>
    80002780:	00013517          	auipc	a0,0x13
    80002784:	34050513          	addi	a0,a0,832 # 80015ac0 <tickslock>
    80002788:	ffffe097          	auipc	ra,0xffffe
    8000278c:	2a8080e7          	jalr	680(ra) # 80000a30 <initlock>
}
    80002790:	60a2                	ld	ra,8(sp)
    80002792:	6402                	ld	s0,0(sp)
    80002794:	0141                	addi	sp,sp,16
    80002796:	8082                	ret

0000000080002798 <trapinithart>:
{
    80002798:	1141                	addi	sp,sp,-16
    8000279a:	e406                	sd	ra,8(sp)
    8000279c:	e022                	sd	s0,0(sp)
    8000279e:	0800                	addi	s0,sp,16
  asm volatile("csrw stvec, %0" : : "r" (x));
    800027a0:	00003797          	auipc	a5,0x3
    800027a4:	6f078793          	addi	a5,a5,1776 # 80005e90 <kernelvec>
    800027a8:	10579073          	csrw	stvec,a5
}
    800027ac:	60a2                	ld	ra,8(sp)
    800027ae:	6402                	ld	s0,0(sp)
    800027b0:	0141                	addi	sp,sp,16
    800027b2:	8082                	ret

00000000800027b4 <usertrapret>:
{
    800027b4:	1141                	addi	sp,sp,-16
    800027b6:	e406                	sd	ra,8(sp)
    800027b8:	e022                	sd	s0,0(sp)
    800027ba:	0800                	addi	s0,sp,16
  struct proc *p = myproc();
    800027bc:	fffff097          	auipc	ra,0xfffff
    800027c0:	344080e7          	jalr	836(ra) # 80001b00 <myproc>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800027c4:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    800027c8:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800027ca:	10079073          	csrw	sstatus,a5
  w_stvec(TRAMPOLINE + (uservec - trampoline));
    800027ce:	00006697          	auipc	a3,0x6
    800027d2:	83268693          	addi	a3,a3,-1998 # 80008000 <trampoline>
    800027d6:	00006717          	auipc	a4,0x6
    800027da:	82a70713          	addi	a4,a4,-2006 # 80008000 <trampoline>
    800027de:	8f15                	sub	a4,a4,a3
    800027e0:	040007b7          	lui	a5,0x4000
    800027e4:	17fd                	addi	a5,a5,-1 # 3ffffff <_entry-0x7c000001>
    800027e6:	07b2                	slli	a5,a5,0xc
    800027e8:	973e                	add	a4,a4,a5
  asm volatile("csrw stvec, %0" : : "r" (x));
    800027ea:	10571073          	csrw	stvec,a4
  p->tf->kernel_satp = r_satp();         // kernel page table
    800027ee:	7138                	ld	a4,96(a0)
  asm volatile("csrr %0, satp" : "=r" (x) );
    800027f0:	18002673          	csrr	a2,satp
    800027f4:	e310                	sd	a2,0(a4)
  p->tf->kernel_sp = p->kstack + PGSIZE; // process's kernel stack
    800027f6:	7130                	ld	a2,96(a0)
    800027f8:	6538                	ld	a4,72(a0)
    800027fa:	6585                	lui	a1,0x1
    800027fc:	972e                	add	a4,a4,a1
    800027fe:	e618                	sd	a4,8(a2)
  p->tf->kernel_trap = (uint64)usertrap;
    80002800:	7138                	ld	a4,96(a0)
    80002802:	00000617          	auipc	a2,0x0
    80002806:	13460613          	addi	a2,a2,308 # 80002936 <usertrap>
    8000280a:	eb10                	sd	a2,16(a4)
  p->tf->kernel_hartid = r_tp();         // hartid for cpuid()
    8000280c:	7138                	ld	a4,96(a0)
  asm volatile("mv %0, tp" : "=r" (x) );
    8000280e:	8612                	mv	a2,tp
    80002810:	f310                	sd	a2,32(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80002812:	10002773          	csrr	a4,sstatus
  x &= ~SSTATUS_SPP; // clear SPP to 0 for user mode
    80002816:	eff77713          	andi	a4,a4,-257
  x |= SSTATUS_SPIE; // enable interrupts in user mode
    8000281a:	02076713          	ori	a4,a4,32
  asm volatile("csrw sstatus, %0" : : "r" (x));
    8000281e:	10071073          	csrw	sstatus,a4
  w_sepc(p->tf->epc);
    80002822:	7138                	ld	a4,96(a0)
  asm volatile("csrw sepc, %0" : : "r" (x));
    80002824:	6f18                	ld	a4,24(a4)
    80002826:	14171073          	csrw	sepc,a4
  uint64 satp = MAKE_SATP(p->pagetable);
    8000282a:	6d2c                	ld	a1,88(a0)
    8000282c:	81b1                	srli	a1,a1,0xc
  uint64 fn = TRAMPOLINE + (userret - trampoline);
    8000282e:	00006717          	auipc	a4,0x6
    80002832:	86270713          	addi	a4,a4,-1950 # 80008090 <userret>
    80002836:	8f15                	sub	a4,a4,a3
    80002838:	97ba                	add	a5,a5,a4
  ((void (*)(uint64,uint64))fn)(TRAPFRAME, satp);
    8000283a:	577d                	li	a4,-1
    8000283c:	177e                	slli	a4,a4,0x3f
    8000283e:	8dd9                	or	a1,a1,a4
    80002840:	02000537          	lui	a0,0x2000
    80002844:	157d                	addi	a0,a0,-1 # 1ffffff <_entry-0x7e000001>
    80002846:	0536                	slli	a0,a0,0xd
    80002848:	9782                	jalr	a5
}
    8000284a:	60a2                	ld	ra,8(sp)
    8000284c:	6402                	ld	s0,0(sp)
    8000284e:	0141                	addi	sp,sp,16
    80002850:	8082                	ret

0000000080002852 <clockintr>:
{
    80002852:	1141                	addi	sp,sp,-16
    80002854:	e406                	sd	ra,8(sp)
    80002856:	e022                	sd	s0,0(sp)
    80002858:	0800                	addi	s0,sp,16
  acquire(&tickslock);
    8000285a:	00013517          	auipc	a0,0x13
    8000285e:	26650513          	addi	a0,a0,614 # 80015ac0 <tickslock>
    80002862:	ffffe097          	auipc	ra,0xffffe
    80002866:	2a2080e7          	jalr	674(ra) # 80000b04 <acquire>
  ticks++;
    8000286a:	00025717          	auipc	a4,0x25
    8000286e:	7d670713          	addi	a4,a4,2006 # 80028040 <ticks>
    80002872:	431c                	lw	a5,0(a4)
    80002874:	2785                	addiw	a5,a5,1
    80002876:	c31c                	sw	a5,0(a4)
  wakeup(&ticks);
    80002878:	853a                	mv	a0,a4
    8000287a:	00000097          	auipc	ra,0x0
    8000287e:	bc4080e7          	jalr	-1084(ra) # 8000243e <wakeup>
  release(&tickslock);
    80002882:	00013517          	auipc	a0,0x13
    80002886:	23e50513          	addi	a0,a0,574 # 80015ac0 <tickslock>
    8000288a:	ffffe097          	auipc	ra,0xffffe
    8000288e:	33e080e7          	jalr	830(ra) # 80000bc8 <release>
}
    80002892:	60a2                	ld	ra,8(sp)
    80002894:	6402                	ld	s0,0(sp)
    80002896:	0141                	addi	sp,sp,16
    80002898:	8082                	ret

000000008000289a <devintr>:
  asm volatile("csrr %0, scause" : "=r" (x) );
    8000289a:	142027f3          	csrr	a5,scause
    return 0;
    8000289e:	4501                	li	a0,0
  if((scause & 0x8000000000000000L) &&
    800028a0:	0807da63          	bgez	a5,80002934 <devintr+0x9a>
{
    800028a4:	1101                	addi	sp,sp,-32
    800028a6:	ec06                	sd	ra,24(sp)
    800028a8:	e822                	sd	s0,16(sp)
    800028aa:	1000                	addi	s0,sp,32
     (scause & 0xff) == 9){
    800028ac:	0ff7f713          	zext.b	a4,a5
  if((scause & 0x8000000000000000L) &&
    800028b0:	46a5                	li	a3,9
    800028b2:	00d70c63          	beq	a4,a3,800028ca <devintr+0x30>
  } else if(scause == 0x8000000000000001L){
    800028b6:	577d                	li	a4,-1
    800028b8:	177e                	slli	a4,a4,0x3f
    800028ba:	0705                	addi	a4,a4,1
    return 0;
    800028bc:	4501                	li	a0,0
  } else if(scause == 0x8000000000000001L){
    800028be:	04e78a63          	beq	a5,a4,80002912 <devintr+0x78>
}
    800028c2:	60e2                	ld	ra,24(sp)
    800028c4:	6442                	ld	s0,16(sp)
    800028c6:	6105                	addi	sp,sp,32
    800028c8:	8082                	ret
    800028ca:	e426                	sd	s1,8(sp)
    int irq = plic_claim();
    800028cc:	00003097          	auipc	ra,0x3
    800028d0:	6d0080e7          	jalr	1744(ra) # 80005f9c <plic_claim>
    800028d4:	84aa                	mv	s1,a0
    if(irq == UART0_IRQ){
    800028d6:	47a9                	li	a5,10
    800028d8:	00f50b63          	beq	a0,a5,800028ee <devintr+0x54>
    } else if(irq == VIRTIO0_IRQ || irq == VIRTIO1_IRQ ){
    800028dc:	fff5079b          	addiw	a5,a0,-1
    800028e0:	4705                	li	a4,1
    800028e2:	00f77b63          	bgeu	a4,a5,800028f8 <devintr+0x5e>
    return 1;
    800028e6:	4505                	li	a0,1
    if(irq)
    800028e8:	ec89                	bnez	s1,80002902 <devintr+0x68>
    800028ea:	64a2                	ld	s1,8(sp)
    800028ec:	bfd9                	j	800028c2 <devintr+0x28>
      uartintr();
    800028ee:	ffffe097          	auipc	ra,0xffffe
    800028f2:	fa8080e7          	jalr	-88(ra) # 80000896 <uartintr>
    if(irq)
    800028f6:	a031                	j	80002902 <devintr+0x68>
      virtio_disk_intr(irq - VIRTIO0_IRQ);
    800028f8:	357d                	addiw	a0,a0,-1
    800028fa:	00004097          	auipc	ra,0x4
    800028fe:	c7c080e7          	jalr	-900(ra) # 80006576 <virtio_disk_intr>
      plic_complete(irq);
    80002902:	8526                	mv	a0,s1
    80002904:	00003097          	auipc	ra,0x3
    80002908:	6bc080e7          	jalr	1724(ra) # 80005fc0 <plic_complete>
    return 1;
    8000290c:	4505                	li	a0,1
    8000290e:	64a2                	ld	s1,8(sp)
    80002910:	bf4d                	j	800028c2 <devintr+0x28>
    if(cpuid() == 0){
    80002912:	fffff097          	auipc	ra,0xfffff
    80002916:	1ba080e7          	jalr	442(ra) # 80001acc <cpuid>
    8000291a:	c901                	beqz	a0,8000292a <devintr+0x90>
  asm volatile("csrr %0, sip" : "=r" (x) );
    8000291c:	144027f3          	csrr	a5,sip
    w_sip(r_sip() & ~2);
    80002920:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sip, %0" : : "r" (x));
    80002922:	14479073          	csrw	sip,a5
    return 2;
    80002926:	4509                	li	a0,2
    80002928:	bf69                	j	800028c2 <devintr+0x28>
      clockintr();
    8000292a:	00000097          	auipc	ra,0x0
    8000292e:	f28080e7          	jalr	-216(ra) # 80002852 <clockintr>
    80002932:	b7ed                	j	8000291c <devintr+0x82>
}
    80002934:	8082                	ret

0000000080002936 <usertrap>:
{
    80002936:	7179                	addi	sp,sp,-48
    80002938:	f406                	sd	ra,40(sp)
    8000293a:	f022                	sd	s0,32(sp)
    8000293c:	1800                	addi	s0,sp,48
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8000293e:	100027f3          	csrr	a5,sstatus
  if((r_sstatus() & SSTATUS_SPP) != 0)
    80002942:	1007f793          	andi	a5,a5,256
    80002946:	e3bd                	bnez	a5,800029ac <usertrap+0x76>
    80002948:	ec26                	sd	s1,24(sp)
    8000294a:	e44e                	sd	s3,8(sp)
  asm volatile("csrw stvec, %0" : : "r" (x));
    8000294c:	00003797          	auipc	a5,0x3
    80002950:	54478793          	addi	a5,a5,1348 # 80005e90 <kernelvec>
    80002954:	10579073          	csrw	stvec,a5
  struct proc *p = myproc();
    80002958:	fffff097          	auipc	ra,0xfffff
    8000295c:	1a8080e7          	jalr	424(ra) # 80001b00 <myproc>
    80002960:	84aa                	mv	s1,a0
  p->tf->epc = r_sepc();
    80002962:	713c                	ld	a5,96(a0)
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80002964:	14102773          	csrr	a4,sepc
    80002968:	ef98                	sd	a4,24(a5)
  asm volatile("csrr %0, scause" : "=r" (x) );
    8000296a:	14202773          	csrr	a4,scause
  if(r_scause() == 8){
    8000296e:	47a1                	li	a5,8
    80002970:	04f71f63          	bne	a4,a5,800029ce <usertrap+0x98>
    if(p->killed)
    80002974:	5d1c                	lw	a5,56(a0)
    80002976:	e7b1                	bnez	a5,800029c2 <usertrap+0x8c>
    p->tf->epc += 4;
    80002978:	70b8                	ld	a4,96(s1)
    8000297a:	6f1c                	ld	a5,24(a4)
    8000297c:	0791                	addi	a5,a5,4
    8000297e:	ef1c                	sd	a5,24(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80002980:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80002984:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80002988:	10079073          	csrw	sstatus,a5
    syscall();
    8000298c:	00000097          	auipc	ra,0x0
    80002990:	308080e7          	jalr	776(ra) # 80002c94 <syscall>
  if(p->killed)
    80002994:	5c9c                	lw	a5,56(s1)
    80002996:	e7cd                	bnez	a5,80002a40 <usertrap+0x10a>
  usertrapret();
    80002998:	00000097          	auipc	ra,0x0
    8000299c:	e1c080e7          	jalr	-484(ra) # 800027b4 <usertrapret>
    800029a0:	64e2                	ld	s1,24(sp)
    800029a2:	69a2                	ld	s3,8(sp)
}
    800029a4:	70a2                	ld	ra,40(sp)
    800029a6:	7402                	ld	s0,32(sp)
    800029a8:	6145                	addi	sp,sp,48
    800029aa:	8082                	ret
    800029ac:	ec26                	sd	s1,24(sp)
    800029ae:	e84a                	sd	s2,16(sp)
    800029b0:	e44e                	sd	s3,8(sp)
    panic("usertrap: not from user mode");
    800029b2:	00006517          	auipc	a0,0x6
    800029b6:	be650513          	addi	a0,a0,-1050 # 80008598 <userret+0x508>
    800029ba:	ffffe097          	auipc	ra,0xffffe
    800029be:	bb0080e7          	jalr	-1104(ra) # 8000056a <panic>
      exit(-1);
    800029c2:	557d                	li	a0,-1
    800029c4:	fffff097          	auipc	ra,0xfffff
    800029c8:	7b6080e7          	jalr	1974(ra) # 8000217a <exit>
    800029cc:	b775                	j	80002978 <usertrap+0x42>
  } else if((which_dev = devintr()) != 0){
    800029ce:	00000097          	auipc	ra,0x0
    800029d2:	ecc080e7          	jalr	-308(ra) # 8000289a <devintr>
    800029d6:	89aa                	mv	s3,a0
    800029d8:	c501                	beqz	a0,800029e0 <usertrap+0xaa>
  if(p->killed)
    800029da:	5c9c                	lw	a5,56(s1)
    800029dc:	cbb1                	beqz	a5,80002a30 <usertrap+0xfa>
    800029de:	a0a1                	j	80002a26 <usertrap+0xf0>
    800029e0:	e84a                	sd	s2,16(sp)
  asm volatile("csrr %0, scause" : "=r" (x) );
    800029e2:	14202973          	csrr	s2,scause
    800029e6:	14202573          	csrr	a0,scause
    printf("usertrap(): unexpected scause %p (%s) pid=%d\n", r_scause(), scause_desc(r_scause()), p->pid);
    800029ea:	00000097          	auipc	ra,0x0
    800029ee:	cf4080e7          	jalr	-780(ra) # 800026de <scause_desc>
    800029f2:	862a                	mv	a2,a0
    800029f4:	40b4                	lw	a3,64(s1)
    800029f6:	85ca                	mv	a1,s2
    800029f8:	00006517          	auipc	a0,0x6
    800029fc:	bc050513          	addi	a0,a0,-1088 # 800085b8 <userret+0x528>
    80002a00:	ffffe097          	auipc	ra,0xffffe
    80002a04:	bc4080e7          	jalr	-1084(ra) # 800005c4 <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80002a08:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80002a0c:	14302673          	csrr	a2,stval
    printf("            sepc=%p stval=%p\n", r_sepc(), r_stval());
    80002a10:	00006517          	auipc	a0,0x6
    80002a14:	bd850513          	addi	a0,a0,-1064 # 800085e8 <userret+0x558>
    80002a18:	ffffe097          	auipc	ra,0xffffe
    80002a1c:	bac080e7          	jalr	-1108(ra) # 800005c4 <printf>
    p->killed = 1;
    80002a20:	4785                	li	a5,1
    80002a22:	dc9c                	sw	a5,56(s1)
  if(p->killed)
    80002a24:	6942                	ld	s2,16(sp)
    exit(-1);
    80002a26:	557d                	li	a0,-1
    80002a28:	fffff097          	auipc	ra,0xfffff
    80002a2c:	752080e7          	jalr	1874(ra) # 8000217a <exit>
  if(which_dev == 2)
    80002a30:	4789                	li	a5,2
    80002a32:	f6f993e3          	bne	s3,a5,80002998 <usertrap+0x62>
    yield();
    80002a36:	00000097          	auipc	ra,0x0
    80002a3a:	852080e7          	jalr	-1966(ra) # 80002288 <yield>
    80002a3e:	bfa9                	j	80002998 <usertrap+0x62>
  int which_dev = 0;
    80002a40:	4981                	li	s3,0
    80002a42:	b7d5                	j	80002a26 <usertrap+0xf0>

0000000080002a44 <kerneltrap>:
{
    80002a44:	7179                	addi	sp,sp,-48
    80002a46:	f406                	sd	ra,40(sp)
    80002a48:	f022                	sd	s0,32(sp)
    80002a4a:	ec26                	sd	s1,24(sp)
    80002a4c:	e84a                	sd	s2,16(sp)
    80002a4e:	e44e                	sd	s3,8(sp)
    80002a50:	1800                	addi	s0,sp,48
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80002a52:	14102973          	csrr	s2,sepc
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80002a56:	100024f3          	csrr	s1,sstatus
  asm volatile("csrr %0, scause" : "=r" (x) );
    80002a5a:	142027f3          	csrr	a5,scause
    80002a5e:	89be                	mv	s3,a5
  if((sstatus & SSTATUS_SPP) == 0)
    80002a60:	1004f793          	andi	a5,s1,256
    80002a64:	cb85                	beqz	a5,80002a94 <kerneltrap+0x50>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80002a66:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80002a6a:	8b89                	andi	a5,a5,2
  if(intr_get() != 0)
    80002a6c:	ef85                	bnez	a5,80002aa4 <kerneltrap+0x60>
  if((which_dev = devintr()) == 0){
    80002a6e:	00000097          	auipc	ra,0x0
    80002a72:	e2c080e7          	jalr	-468(ra) # 8000289a <devintr>
    80002a76:	cd1d                	beqz	a0,80002ab4 <kerneltrap+0x70>
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    80002a78:	4789                	li	a5,2
    80002a7a:	08f50063          	beq	a0,a5,80002afa <kerneltrap+0xb6>
  asm volatile("csrw sepc, %0" : : "r" (x));
    80002a7e:	14191073          	csrw	sepc,s2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80002a82:	10049073          	csrw	sstatus,s1
}
    80002a86:	70a2                	ld	ra,40(sp)
    80002a88:	7402                	ld	s0,32(sp)
    80002a8a:	64e2                	ld	s1,24(sp)
    80002a8c:	6942                	ld	s2,16(sp)
    80002a8e:	69a2                	ld	s3,8(sp)
    80002a90:	6145                	addi	sp,sp,48
    80002a92:	8082                	ret
    panic("kerneltrap: not from supervisor mode");
    80002a94:	00006517          	auipc	a0,0x6
    80002a98:	b7450513          	addi	a0,a0,-1164 # 80008608 <userret+0x578>
    80002a9c:	ffffe097          	auipc	ra,0xffffe
    80002aa0:	ace080e7          	jalr	-1330(ra) # 8000056a <panic>
    panic("kerneltrap: interrupts enabled");
    80002aa4:	00006517          	auipc	a0,0x6
    80002aa8:	b8c50513          	addi	a0,a0,-1140 # 80008630 <userret+0x5a0>
    80002aac:	ffffe097          	auipc	ra,0xffffe
    80002ab0:	abe080e7          	jalr	-1346(ra) # 8000056a <panic>
    printf("scause %p (%s)\n", scause, scause_desc(scause));
    80002ab4:	854e                	mv	a0,s3
    80002ab6:	00000097          	auipc	ra,0x0
    80002aba:	c28080e7          	jalr	-984(ra) # 800026de <scause_desc>
    80002abe:	862a                	mv	a2,a0
    80002ac0:	85ce                	mv	a1,s3
    80002ac2:	00006517          	auipc	a0,0x6
    80002ac6:	b8e50513          	addi	a0,a0,-1138 # 80008650 <userret+0x5c0>
    80002aca:	ffffe097          	auipc	ra,0xffffe
    80002ace:	afa080e7          	jalr	-1286(ra) # 800005c4 <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80002ad2:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80002ad6:	14302673          	csrr	a2,stval
    printf("sepc=%p stval=%p\n", r_sepc(), r_stval());
    80002ada:	00006517          	auipc	a0,0x6
    80002ade:	b8650513          	addi	a0,a0,-1146 # 80008660 <userret+0x5d0>
    80002ae2:	ffffe097          	auipc	ra,0xffffe
    80002ae6:	ae2080e7          	jalr	-1310(ra) # 800005c4 <printf>
    panic("kerneltrap");
    80002aea:	00006517          	auipc	a0,0x6
    80002aee:	b8e50513          	addi	a0,a0,-1138 # 80008678 <userret+0x5e8>
    80002af2:	ffffe097          	auipc	ra,0xffffe
    80002af6:	a78080e7          	jalr	-1416(ra) # 8000056a <panic>
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    80002afa:	fffff097          	auipc	ra,0xfffff
    80002afe:	006080e7          	jalr	6(ra) # 80001b00 <myproc>
    80002b02:	dd35                	beqz	a0,80002a7e <kerneltrap+0x3a>
    80002b04:	fffff097          	auipc	ra,0xfffff
    80002b08:	ffc080e7          	jalr	-4(ra) # 80001b00 <myproc>
    80002b0c:	5118                	lw	a4,32(a0)
    80002b0e:	478d                	li	a5,3
    80002b10:	f6f717e3          	bne	a4,a5,80002a7e <kerneltrap+0x3a>
    yield();
    80002b14:	fffff097          	auipc	ra,0xfffff
    80002b18:	774080e7          	jalr	1908(ra) # 80002288 <yield>
    80002b1c:	b78d                	j	80002a7e <kerneltrap+0x3a>

0000000080002b1e <argraw>:
  return strlen(buf);
}

static uint64
argraw(int n)
{
    80002b1e:	1101                	addi	sp,sp,-32
    80002b20:	ec06                	sd	ra,24(sp)
    80002b22:	e822                	sd	s0,16(sp)
    80002b24:	e426                	sd	s1,8(sp)
    80002b26:	1000                	addi	s0,sp,32
    80002b28:	84aa                	mv	s1,a0
  struct proc *p = myproc();
    80002b2a:	fffff097          	auipc	ra,0xfffff
    80002b2e:	fd6080e7          	jalr	-42(ra) # 80001b00 <myproc>
  switch (n) {
    80002b32:	4795                	li	a5,5
    80002b34:	0497e163          	bltu	a5,s1,80002b76 <argraw+0x58>
    80002b38:	048a                	slli	s1,s1,0x2
    80002b3a:	00006717          	auipc	a4,0x6
    80002b3e:	33e70713          	addi	a4,a4,830 # 80008e78 <nointr_desc.0+0x80>
    80002b42:	94ba                	add	s1,s1,a4
    80002b44:	409c                	lw	a5,0(s1)
    80002b46:	97ba                	add	a5,a5,a4
    80002b48:	8782                	jr	a5
  case 0:
    return p->tf->a0;
    80002b4a:	713c                	ld	a5,96(a0)
    80002b4c:	7ba8                	ld	a0,112(a5)
  case 5:
    return p->tf->a5;
  }
  panic("argraw");
  return -1;
}
    80002b4e:	60e2                	ld	ra,24(sp)
    80002b50:	6442                	ld	s0,16(sp)
    80002b52:	64a2                	ld	s1,8(sp)
    80002b54:	6105                	addi	sp,sp,32
    80002b56:	8082                	ret
    return p->tf->a1;
    80002b58:	713c                	ld	a5,96(a0)
    80002b5a:	7fa8                	ld	a0,120(a5)
    80002b5c:	bfcd                	j	80002b4e <argraw+0x30>
    return p->tf->a2;
    80002b5e:	713c                	ld	a5,96(a0)
    80002b60:	63c8                	ld	a0,128(a5)
    80002b62:	b7f5                	j	80002b4e <argraw+0x30>
    return p->tf->a3;
    80002b64:	713c                	ld	a5,96(a0)
    80002b66:	67c8                	ld	a0,136(a5)
    80002b68:	b7dd                	j	80002b4e <argraw+0x30>
    return p->tf->a4;
    80002b6a:	713c                	ld	a5,96(a0)
    80002b6c:	6bc8                	ld	a0,144(a5)
    80002b6e:	b7c5                	j	80002b4e <argraw+0x30>
    return p->tf->a5;
    80002b70:	713c                	ld	a5,96(a0)
    80002b72:	6fc8                	ld	a0,152(a5)
    80002b74:	bfe9                	j	80002b4e <argraw+0x30>
  panic("argraw");
    80002b76:	00006517          	auipc	a0,0x6
    80002b7a:	d0a50513          	addi	a0,a0,-758 # 80008880 <userret+0x7f0>
    80002b7e:	ffffe097          	auipc	ra,0xffffe
    80002b82:	9ec080e7          	jalr	-1556(ra) # 8000056a <panic>

0000000080002b86 <fetchaddr>:
{
    80002b86:	1101                	addi	sp,sp,-32
    80002b88:	ec06                	sd	ra,24(sp)
    80002b8a:	e822                	sd	s0,16(sp)
    80002b8c:	e426                	sd	s1,8(sp)
    80002b8e:	e04a                	sd	s2,0(sp)
    80002b90:	1000                	addi	s0,sp,32
    80002b92:	84aa                	mv	s1,a0
    80002b94:	892e                	mv	s2,a1
  struct proc *p = myproc();
    80002b96:	fffff097          	auipc	ra,0xfffff
    80002b9a:	f6a080e7          	jalr	-150(ra) # 80001b00 <myproc>
  if(addr >= p->sz || addr+sizeof(uint64) > p->sz)
    80002b9e:	693c                	ld	a5,80(a0)
    80002ba0:	02f4f863          	bgeu	s1,a5,80002bd0 <fetchaddr+0x4a>
    80002ba4:	00848713          	addi	a4,s1,8
    80002ba8:	02e7e663          	bltu	a5,a4,80002bd4 <fetchaddr+0x4e>
  if(copyin(p->pagetable, (char *)ip, addr, sizeof(*ip)) != 0)
    80002bac:	46a1                	li	a3,8
    80002bae:	8626                	mv	a2,s1
    80002bb0:	85ca                	mv	a1,s2
    80002bb2:	6d28                	ld	a0,88(a0)
    80002bb4:	fffff097          	auipc	ra,0xfffff
    80002bb8:	c9c080e7          	jalr	-868(ra) # 80001850 <copyin>
    80002bbc:	00a03533          	snez	a0,a0
    80002bc0:	40a0053b          	negw	a0,a0
}
    80002bc4:	60e2                	ld	ra,24(sp)
    80002bc6:	6442                	ld	s0,16(sp)
    80002bc8:	64a2                	ld	s1,8(sp)
    80002bca:	6902                	ld	s2,0(sp)
    80002bcc:	6105                	addi	sp,sp,32
    80002bce:	8082                	ret
    return -1;
    80002bd0:	557d                	li	a0,-1
    80002bd2:	bfcd                	j	80002bc4 <fetchaddr+0x3e>
    80002bd4:	557d                	li	a0,-1
    80002bd6:	b7fd                	j	80002bc4 <fetchaddr+0x3e>

0000000080002bd8 <fetchstr>:
{
    80002bd8:	7179                	addi	sp,sp,-48
    80002bda:	f406                	sd	ra,40(sp)
    80002bdc:	f022                	sd	s0,32(sp)
    80002bde:	ec26                	sd	s1,24(sp)
    80002be0:	e84a                	sd	s2,16(sp)
    80002be2:	e44e                	sd	s3,8(sp)
    80002be4:	1800                	addi	s0,sp,48
    80002be6:	89aa                	mv	s3,a0
    80002be8:	84ae                	mv	s1,a1
    80002bea:	8932                	mv	s2,a2
  struct proc *p = myproc();
    80002bec:	fffff097          	auipc	ra,0xfffff
    80002bf0:	f14080e7          	jalr	-236(ra) # 80001b00 <myproc>
  int err = copyinstr(p->pagetable, buf, addr, max);
    80002bf4:	86ca                	mv	a3,s2
    80002bf6:	864e                	mv	a2,s3
    80002bf8:	85a6                	mv	a1,s1
    80002bfa:	6d28                	ld	a0,88(a0)
    80002bfc:	fffff097          	auipc	ra,0xfffff
    80002c00:	ce2080e7          	jalr	-798(ra) # 800018de <copyinstr>
  if(err < 0)
    80002c04:	00054763          	bltz	a0,80002c12 <fetchstr+0x3a>
  return strlen(buf);
    80002c08:	8526                	mv	a0,s1
    80002c0a:	ffffe097          	auipc	ra,0xffffe
    80002c0e:	344080e7          	jalr	836(ra) # 80000f4e <strlen>
}
    80002c12:	70a2                	ld	ra,40(sp)
    80002c14:	7402                	ld	s0,32(sp)
    80002c16:	64e2                	ld	s1,24(sp)
    80002c18:	6942                	ld	s2,16(sp)
    80002c1a:	69a2                	ld	s3,8(sp)
    80002c1c:	6145                	addi	sp,sp,48
    80002c1e:	8082                	ret

0000000080002c20 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
    80002c20:	1101                	addi	sp,sp,-32
    80002c22:	ec06                	sd	ra,24(sp)
    80002c24:	e822                	sd	s0,16(sp)
    80002c26:	e426                	sd	s1,8(sp)
    80002c28:	1000                	addi	s0,sp,32
    80002c2a:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80002c2c:	00000097          	auipc	ra,0x0
    80002c30:	ef2080e7          	jalr	-270(ra) # 80002b1e <argraw>
    80002c34:	c088                	sw	a0,0(s1)
  return 0;
}
    80002c36:	4501                	li	a0,0
    80002c38:	60e2                	ld	ra,24(sp)
    80002c3a:	6442                	ld	s0,16(sp)
    80002c3c:	64a2                	ld	s1,8(sp)
    80002c3e:	6105                	addi	sp,sp,32
    80002c40:	8082                	ret

0000000080002c42 <argaddr>:
// Retrieve an argument as a pointer.
// Doesn't check for legality, since
// copyin/copyout will do that.
int
argaddr(int n, uint64 *ip)
{
    80002c42:	1101                	addi	sp,sp,-32
    80002c44:	ec06                	sd	ra,24(sp)
    80002c46:	e822                	sd	s0,16(sp)
    80002c48:	e426                	sd	s1,8(sp)
    80002c4a:	1000                	addi	s0,sp,32
    80002c4c:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80002c4e:	00000097          	auipc	ra,0x0
    80002c52:	ed0080e7          	jalr	-304(ra) # 80002b1e <argraw>
    80002c56:	e088                	sd	a0,0(s1)
  return 0;
}
    80002c58:	4501                	li	a0,0
    80002c5a:	60e2                	ld	ra,24(sp)
    80002c5c:	6442                	ld	s0,16(sp)
    80002c5e:	64a2                	ld	s1,8(sp)
    80002c60:	6105                	addi	sp,sp,32
    80002c62:	8082                	ret

0000000080002c64 <argstr>:
// Fetch the nth word-sized system call argument as a null-terminated string.
// Copies into buf, at most max.
// Returns string length if OK (including nul), -1 if error.
int
argstr(int n, char *buf, int max)
{
    80002c64:	1101                	addi	sp,sp,-32
    80002c66:	ec06                	sd	ra,24(sp)
    80002c68:	e822                	sd	s0,16(sp)
    80002c6a:	e426                	sd	s1,8(sp)
    80002c6c:	e04a                	sd	s2,0(sp)
    80002c6e:	1000                	addi	s0,sp,32
    80002c70:	892e                	mv	s2,a1
    80002c72:	84b2                	mv	s1,a2
  *ip = argraw(n);
    80002c74:	00000097          	auipc	ra,0x0
    80002c78:	eaa080e7          	jalr	-342(ra) # 80002b1e <argraw>
  uint64 addr;
  if(argaddr(n, &addr) < 0)
    return -1;
  return fetchstr(addr, buf, max);
    80002c7c:	8626                	mv	a2,s1
    80002c7e:	85ca                	mv	a1,s2
    80002c80:	00000097          	auipc	ra,0x0
    80002c84:	f58080e7          	jalr	-168(ra) # 80002bd8 <fetchstr>
}
    80002c88:	60e2                	ld	ra,24(sp)
    80002c8a:	6442                	ld	s0,16(sp)
    80002c8c:	64a2                	ld	s1,8(sp)
    80002c8e:	6902                	ld	s2,0(sp)
    80002c90:	6105                	addi	sp,sp,32
    80002c92:	8082                	ret

0000000080002c94 <syscall>:
[SYS_ntas]    sys_ntas,
};

void
syscall(void)
{
    80002c94:	1101                	addi	sp,sp,-32
    80002c96:	ec06                	sd	ra,24(sp)
    80002c98:	e822                	sd	s0,16(sp)
    80002c9a:	e426                	sd	s1,8(sp)
    80002c9c:	e04a                	sd	s2,0(sp)
    80002c9e:	1000                	addi	s0,sp,32
  int num;
  struct proc *p = myproc();
    80002ca0:	fffff097          	auipc	ra,0xfffff
    80002ca4:	e60080e7          	jalr	-416(ra) # 80001b00 <myproc>
    80002ca8:	84aa                	mv	s1,a0

  num = p->tf->a7;
    80002caa:	06053903          	ld	s2,96(a0)
    80002cae:	0a893783          	ld	a5,168(s2)
    80002cb2:	0007869b          	sext.w	a3,a5
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    80002cb6:	37fd                	addiw	a5,a5,-1
    80002cb8:	4755                	li	a4,21
    80002cba:	00f76f63          	bltu	a4,a5,80002cd8 <syscall+0x44>
    80002cbe:	00369713          	slli	a4,a3,0x3
    80002cc2:	00006797          	auipc	a5,0x6
    80002cc6:	1ce78793          	addi	a5,a5,462 # 80008e90 <syscalls>
    80002cca:	97ba                	add	a5,a5,a4
    80002ccc:	639c                	ld	a5,0(a5)
    80002cce:	c789                	beqz	a5,80002cd8 <syscall+0x44>
    p->tf->a0 = syscalls[num]();
    80002cd0:	9782                	jalr	a5
    80002cd2:	06a93823          	sd	a0,112(s2)
    80002cd6:	a839                	j	80002cf4 <syscall+0x60>
  } else {
    printf("%d %s: unknown sys call %d\n",
    80002cd8:	16048613          	addi	a2,s1,352
    80002cdc:	40ac                	lw	a1,64(s1)
    80002cde:	00006517          	auipc	a0,0x6
    80002ce2:	baa50513          	addi	a0,a0,-1110 # 80008888 <userret+0x7f8>
    80002ce6:	ffffe097          	auipc	ra,0xffffe
    80002cea:	8de080e7          	jalr	-1826(ra) # 800005c4 <printf>
            p->pid, p->name, num);
    p->tf->a0 = -1;
    80002cee:	70bc                	ld	a5,96(s1)
    80002cf0:	577d                	li	a4,-1
    80002cf2:	fbb8                	sd	a4,112(a5)
  }
}
    80002cf4:	60e2                	ld	ra,24(sp)
    80002cf6:	6442                	ld	s0,16(sp)
    80002cf8:	64a2                	ld	s1,8(sp)
    80002cfa:	6902                	ld	s2,0(sp)
    80002cfc:	6105                	addi	sp,sp,32
    80002cfe:	8082                	ret

0000000080002d00 <sys_exit>:
#include "spinlock.h"
#include "proc.h"

uint64
sys_exit(void)
{
    80002d00:	1101                	addi	sp,sp,-32
    80002d02:	ec06                	sd	ra,24(sp)
    80002d04:	e822                	sd	s0,16(sp)
    80002d06:	1000                	addi	s0,sp,32
  int n;
  if(argint(0, &n) < 0)
    80002d08:	fec40593          	addi	a1,s0,-20
    80002d0c:	4501                	li	a0,0
    80002d0e:	00000097          	auipc	ra,0x0
    80002d12:	f12080e7          	jalr	-238(ra) # 80002c20 <argint>
    return -1;
    80002d16:	57fd                	li	a5,-1
  if(argint(0, &n) < 0)
    80002d18:	00054963          	bltz	a0,80002d2a <sys_exit+0x2a>
  exit(n);
    80002d1c:	fec42503          	lw	a0,-20(s0)
    80002d20:	fffff097          	auipc	ra,0xfffff
    80002d24:	45a080e7          	jalr	1114(ra) # 8000217a <exit>
  return 0;  // not reached
    80002d28:	4781                	li	a5,0
}
    80002d2a:	853e                	mv	a0,a5
    80002d2c:	60e2                	ld	ra,24(sp)
    80002d2e:	6442                	ld	s0,16(sp)
    80002d30:	6105                	addi	sp,sp,32
    80002d32:	8082                	ret

0000000080002d34 <sys_getpid>:

uint64
sys_getpid(void)
{
    80002d34:	1141                	addi	sp,sp,-16
    80002d36:	e406                	sd	ra,8(sp)
    80002d38:	e022                	sd	s0,0(sp)
    80002d3a:	0800                	addi	s0,sp,16
  return myproc()->pid;
    80002d3c:	fffff097          	auipc	ra,0xfffff
    80002d40:	dc4080e7          	jalr	-572(ra) # 80001b00 <myproc>
}
    80002d44:	4128                	lw	a0,64(a0)
    80002d46:	60a2                	ld	ra,8(sp)
    80002d48:	6402                	ld	s0,0(sp)
    80002d4a:	0141                	addi	sp,sp,16
    80002d4c:	8082                	ret

0000000080002d4e <sys_fork>:

uint64
sys_fork(void)
{
    80002d4e:	1141                	addi	sp,sp,-16
    80002d50:	e406                	sd	ra,8(sp)
    80002d52:	e022                	sd	s0,0(sp)
    80002d54:	0800                	addi	s0,sp,16
  return fork();
    80002d56:	fffff097          	auipc	ra,0xfffff
    80002d5a:	118080e7          	jalr	280(ra) # 80001e6e <fork>
}
    80002d5e:	60a2                	ld	ra,8(sp)
    80002d60:	6402                	ld	s0,0(sp)
    80002d62:	0141                	addi	sp,sp,16
    80002d64:	8082                	ret

0000000080002d66 <sys_wait>:

uint64
sys_wait(void)
{
    80002d66:	1101                	addi	sp,sp,-32
    80002d68:	ec06                	sd	ra,24(sp)
    80002d6a:	e822                	sd	s0,16(sp)
    80002d6c:	1000                	addi	s0,sp,32
  uint64 p;
  if(argaddr(0, &p) < 0)
    80002d6e:	fe840593          	addi	a1,s0,-24
    80002d72:	4501                	li	a0,0
    80002d74:	00000097          	auipc	ra,0x0
    80002d78:	ece080e7          	jalr	-306(ra) # 80002c42 <argaddr>
    80002d7c:	87aa                	mv	a5,a0
    return -1;
    80002d7e:	557d                	li	a0,-1
  if(argaddr(0, &p) < 0)
    80002d80:	0007c863          	bltz	a5,80002d90 <sys_wait+0x2a>
  return wait(p);
    80002d84:	fe843503          	ld	a0,-24(s0)
    80002d88:	fffff097          	auipc	ra,0xfffff
    80002d8c:	5ba080e7          	jalr	1466(ra) # 80002342 <wait>
}
    80002d90:	60e2                	ld	ra,24(sp)
    80002d92:	6442                	ld	s0,16(sp)
    80002d94:	6105                	addi	sp,sp,32
    80002d96:	8082                	ret

0000000080002d98 <sys_sbrk>:

uint64
sys_sbrk(void)
{
    80002d98:	7179                	addi	sp,sp,-48
    80002d9a:	f406                	sd	ra,40(sp)
    80002d9c:	f022                	sd	s0,32(sp)
    80002d9e:	1800                	addi	s0,sp,48
  int addr;
  int n;

  if(argint(0, &n) < 0)
    80002da0:	fdc40593          	addi	a1,s0,-36
    80002da4:	4501                	li	a0,0
    80002da6:	00000097          	auipc	ra,0x0
    80002daa:	e7a080e7          	jalr	-390(ra) # 80002c20 <argint>
    return -1;
    80002dae:	57fd                	li	a5,-1
  if(argint(0, &n) < 0)
    80002db0:	02054363          	bltz	a0,80002dd6 <sys_sbrk+0x3e>
    80002db4:	ec26                	sd	s1,24(sp)
  addr = myproc()->sz;
    80002db6:	fffff097          	auipc	ra,0xfffff
    80002dba:	d4a080e7          	jalr	-694(ra) # 80001b00 <myproc>
    80002dbe:	6924                	ld	s1,80(a0)
  if(growproc(n) < 0)
    80002dc0:	fdc42503          	lw	a0,-36(s0)
    80002dc4:	fffff097          	auipc	ra,0xfffff
    80002dc8:	032080e7          	jalr	50(ra) # 80001df6 <growproc>
    80002dcc:	00054a63          	bltz	a0,80002de0 <sys_sbrk+0x48>
    return -1;
  return addr;
    80002dd0:	0004879b          	sext.w	a5,s1
    80002dd4:	64e2                	ld	s1,24(sp)
}
    80002dd6:	853e                	mv	a0,a5
    80002dd8:	70a2                	ld	ra,40(sp)
    80002dda:	7402                	ld	s0,32(sp)
    80002ddc:	6145                	addi	sp,sp,48
    80002dde:	8082                	ret
    return -1;
    80002de0:	57fd                	li	a5,-1
    80002de2:	64e2                	ld	s1,24(sp)
    80002de4:	bfcd                	j	80002dd6 <sys_sbrk+0x3e>

0000000080002de6 <sys_sleep>:

uint64
sys_sleep(void)
{
    80002de6:	7139                	addi	sp,sp,-64
    80002de8:	fc06                	sd	ra,56(sp)
    80002dea:	f822                	sd	s0,48(sp)
    80002dec:	0080                	addi	s0,sp,64
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    80002dee:	fcc40593          	addi	a1,s0,-52
    80002df2:	4501                	li	a0,0
    80002df4:	00000097          	auipc	ra,0x0
    80002df8:	e2c080e7          	jalr	-468(ra) # 80002c20 <argint>
    return -1;
    80002dfc:	57fd                	li	a5,-1
  if(argint(0, &n) < 0)
    80002dfe:	06054b63          	bltz	a0,80002e74 <sys_sleep+0x8e>
  acquire(&tickslock);
    80002e02:	00013517          	auipc	a0,0x13
    80002e06:	cbe50513          	addi	a0,a0,-834 # 80015ac0 <tickslock>
    80002e0a:	ffffe097          	auipc	ra,0xffffe
    80002e0e:	cfa080e7          	jalr	-774(ra) # 80000b04 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
    80002e12:	fcc42783          	lw	a5,-52(s0)
    80002e16:	c7b1                	beqz	a5,80002e62 <sys_sleep+0x7c>
    80002e18:	f426                	sd	s1,40(sp)
    80002e1a:	f04a                	sd	s2,32(sp)
    80002e1c:	ec4e                	sd	s3,24(sp)
  ticks0 = ticks;
    80002e1e:	00025997          	auipc	s3,0x25
    80002e22:	2229a983          	lw	s3,546(s3) # 80028040 <ticks>
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
    80002e26:	00013917          	auipc	s2,0x13
    80002e2a:	c9a90913          	addi	s2,s2,-870 # 80015ac0 <tickslock>
    80002e2e:	00025497          	auipc	s1,0x25
    80002e32:	21248493          	addi	s1,s1,530 # 80028040 <ticks>
    if(myproc()->killed){
    80002e36:	fffff097          	auipc	ra,0xfffff
    80002e3a:	cca080e7          	jalr	-822(ra) # 80001b00 <myproc>
    80002e3e:	5d1c                	lw	a5,56(a0)
    80002e40:	ef9d                	bnez	a5,80002e7e <sys_sleep+0x98>
    sleep(&ticks, &tickslock);
    80002e42:	85ca                	mv	a1,s2
    80002e44:	8526                	mv	a0,s1
    80002e46:	fffff097          	auipc	ra,0xfffff
    80002e4a:	47e080e7          	jalr	1150(ra) # 800022c4 <sleep>
  while(ticks - ticks0 < n){
    80002e4e:	409c                	lw	a5,0(s1)
    80002e50:	413787bb          	subw	a5,a5,s3
    80002e54:	fcc42703          	lw	a4,-52(s0)
    80002e58:	fce7efe3          	bltu	a5,a4,80002e36 <sys_sleep+0x50>
    80002e5c:	74a2                	ld	s1,40(sp)
    80002e5e:	7902                	ld	s2,32(sp)
    80002e60:	69e2                	ld	s3,24(sp)
  }
  release(&tickslock);
    80002e62:	00013517          	auipc	a0,0x13
    80002e66:	c5e50513          	addi	a0,a0,-930 # 80015ac0 <tickslock>
    80002e6a:	ffffe097          	auipc	ra,0xffffe
    80002e6e:	d5e080e7          	jalr	-674(ra) # 80000bc8 <release>
  return 0;
    80002e72:	4781                	li	a5,0
}
    80002e74:	853e                	mv	a0,a5
    80002e76:	70e2                	ld	ra,56(sp)
    80002e78:	7442                	ld	s0,48(sp)
    80002e7a:	6121                	addi	sp,sp,64
    80002e7c:	8082                	ret
      release(&tickslock);
    80002e7e:	00013517          	auipc	a0,0x13
    80002e82:	c4250513          	addi	a0,a0,-958 # 80015ac0 <tickslock>
    80002e86:	ffffe097          	auipc	ra,0xffffe
    80002e8a:	d42080e7          	jalr	-702(ra) # 80000bc8 <release>
      return -1;
    80002e8e:	57fd                	li	a5,-1
    80002e90:	74a2                	ld	s1,40(sp)
    80002e92:	7902                	ld	s2,32(sp)
    80002e94:	69e2                	ld	s3,24(sp)
    80002e96:	bff9                	j	80002e74 <sys_sleep+0x8e>

0000000080002e98 <sys_kill>:

uint64
sys_kill(void)
{
    80002e98:	1101                	addi	sp,sp,-32
    80002e9a:	ec06                	sd	ra,24(sp)
    80002e9c:	e822                	sd	s0,16(sp)
    80002e9e:	1000                	addi	s0,sp,32
  int pid;

  if(argint(0, &pid) < 0)
    80002ea0:	fec40593          	addi	a1,s0,-20
    80002ea4:	4501                	li	a0,0
    80002ea6:	00000097          	auipc	ra,0x0
    80002eaa:	d7a080e7          	jalr	-646(ra) # 80002c20 <argint>
    80002eae:	87aa                	mv	a5,a0
    return -1;
    80002eb0:	557d                	li	a0,-1
  if(argint(0, &pid) < 0)
    80002eb2:	0007c863          	bltz	a5,80002ec2 <sys_kill+0x2a>
  return kill(pid);
    80002eb6:	fec42503          	lw	a0,-20(s0)
    80002eba:	fffff097          	auipc	ra,0xfffff
    80002ebe:	5ee080e7          	jalr	1518(ra) # 800024a8 <kill>
}
    80002ec2:	60e2                	ld	ra,24(sp)
    80002ec4:	6442                	ld	s0,16(sp)
    80002ec6:	6105                	addi	sp,sp,32
    80002ec8:	8082                	ret

0000000080002eca <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
uint64
sys_uptime(void)
{
    80002eca:	1101                	addi	sp,sp,-32
    80002ecc:	ec06                	sd	ra,24(sp)
    80002ece:	e822                	sd	s0,16(sp)
    80002ed0:	e426                	sd	s1,8(sp)
    80002ed2:	1000                	addi	s0,sp,32
  uint xticks;

  acquire(&tickslock);
    80002ed4:	00013517          	auipc	a0,0x13
    80002ed8:	bec50513          	addi	a0,a0,-1044 # 80015ac0 <tickslock>
    80002edc:	ffffe097          	auipc	ra,0xffffe
    80002ee0:	c28080e7          	jalr	-984(ra) # 80000b04 <acquire>
  xticks = ticks;
    80002ee4:	00025797          	auipc	a5,0x25
    80002ee8:	15c7a783          	lw	a5,348(a5) # 80028040 <ticks>
    80002eec:	84be                	mv	s1,a5
  release(&tickslock);
    80002eee:	00013517          	auipc	a0,0x13
    80002ef2:	bd250513          	addi	a0,a0,-1070 # 80015ac0 <tickslock>
    80002ef6:	ffffe097          	auipc	ra,0xffffe
    80002efa:	cd2080e7          	jalr	-814(ra) # 80000bc8 <release>
  return xticks;
}
    80002efe:	02049513          	slli	a0,s1,0x20
    80002f02:	9101                	srli	a0,a0,0x20
    80002f04:	60e2                	ld	ra,24(sp)
    80002f06:	6442                	ld	s0,16(sp)
    80002f08:	64a2                	ld	s1,8(sp)
    80002f0a:	6105                	addi	sp,sp,32
    80002f0c:	8082                	ret

0000000080002f0e <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
    80002f0e:	7179                	addi	sp,sp,-48
    80002f10:	f406                	sd	ra,40(sp)
    80002f12:	f022                	sd	s0,32(sp)
    80002f14:	ec26                	sd	s1,24(sp)
    80002f16:	e84a                	sd	s2,16(sp)
    80002f18:	e44e                	sd	s3,8(sp)
    80002f1a:	e052                	sd	s4,0(sp)
    80002f1c:	1800                	addi	s0,sp,48
  struct buf *b;

  initlock(&bcache.lock, "bcache");
    80002f1e:	00005597          	auipc	a1,0x5
    80002f22:	3a258593          	addi	a1,a1,930 # 800082c0 <userret+0x230>
    80002f26:	00013517          	auipc	a0,0x13
    80002f2a:	bba50513          	addi	a0,a0,-1094 # 80015ae0 <bcache>
    80002f2e:	ffffe097          	auipc	ra,0xffffe
    80002f32:	b02080e7          	jalr	-1278(ra) # 80000a30 <initlock>

  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
    80002f36:	0001b797          	auipc	a5,0x1b
    80002f3a:	baa78793          	addi	a5,a5,-1110 # 8001dae0 <bcache+0x8000>
    80002f3e:	0001b717          	auipc	a4,0x1b
    80002f42:	f0270713          	addi	a4,a4,-254 # 8001de40 <bcache+0x8360>
    80002f46:	3ae7b823          	sd	a4,944(a5)
  bcache.head.next = &bcache.head;
    80002f4a:	3ae7bc23          	sd	a4,952(a5)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    80002f4e:	00013497          	auipc	s1,0x13
    80002f52:	bb248493          	addi	s1,s1,-1102 # 80015b00 <bcache+0x20>
    b->next = bcache.head.next;
    80002f56:	893e                	mv	s2,a5
    b->prev = &bcache.head;
    80002f58:	89ba                	mv	s3,a4
    initsleeplock(&b->lock, "buffer");
    80002f5a:	00006a17          	auipc	s4,0x6
    80002f5e:	94ea0a13          	addi	s4,s4,-1714 # 800088a8 <userret+0x818>
    b->next = bcache.head.next;
    80002f62:	3b893783          	ld	a5,952(s2)
    80002f66:	ecbc                	sd	a5,88(s1)
    b->prev = &bcache.head;
    80002f68:	0534b823          	sd	s3,80(s1)
    initsleeplock(&b->lock, "buffer");
    80002f6c:	85d2                	mv	a1,s4
    80002f6e:	01048513          	addi	a0,s1,16
    80002f72:	00001097          	auipc	ra,0x1
    80002f76:	596080e7          	jalr	1430(ra) # 80004508 <initsleeplock>
    bcache.head.next->prev = b;
    80002f7a:	3b893783          	ld	a5,952(s2)
    80002f7e:	eba4                	sd	s1,80(a5)
    bcache.head.next = b;
    80002f80:	3a993c23          	sd	s1,952(s2)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    80002f84:	46048493          	addi	s1,s1,1120
    80002f88:	fd349de3          	bne	s1,s3,80002f62 <binit+0x54>
  }
}
    80002f8c:	70a2                	ld	ra,40(sp)
    80002f8e:	7402                	ld	s0,32(sp)
    80002f90:	64e2                	ld	s1,24(sp)
    80002f92:	6942                	ld	s2,16(sp)
    80002f94:	69a2                	ld	s3,8(sp)
    80002f96:	6a02                	ld	s4,0(sp)
    80002f98:	6145                	addi	sp,sp,48
    80002f9a:	8082                	ret

0000000080002f9c <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
    80002f9c:	7179                	addi	sp,sp,-48
    80002f9e:	f406                	sd	ra,40(sp)
    80002fa0:	f022                	sd	s0,32(sp)
    80002fa2:	ec26                	sd	s1,24(sp)
    80002fa4:	e84a                	sd	s2,16(sp)
    80002fa6:	e44e                	sd	s3,8(sp)
    80002fa8:	1800                	addi	s0,sp,48
    80002faa:	892a                	mv	s2,a0
    80002fac:	89ae                	mv	s3,a1
  acquire(&bcache.lock);
    80002fae:	00013517          	auipc	a0,0x13
    80002fb2:	b3250513          	addi	a0,a0,-1230 # 80015ae0 <bcache>
    80002fb6:	ffffe097          	auipc	ra,0xffffe
    80002fba:	b4e080e7          	jalr	-1202(ra) # 80000b04 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
    80002fbe:	0001b497          	auipc	s1,0x1b
    80002fc2:	eda4b483          	ld	s1,-294(s1) # 8001de98 <bcache+0x83b8>
    80002fc6:	0001b797          	auipc	a5,0x1b
    80002fca:	e7a78793          	addi	a5,a5,-390 # 8001de40 <bcache+0x8360>
    80002fce:	02f48f63          	beq	s1,a5,8000300c <bread+0x70>
    80002fd2:	873e                	mv	a4,a5
    80002fd4:	a021                	j	80002fdc <bread+0x40>
    80002fd6:	6ca4                	ld	s1,88(s1)
    80002fd8:	02e48a63          	beq	s1,a4,8000300c <bread+0x70>
    if(b->dev == dev && b->blockno == blockno){
    80002fdc:	449c                	lw	a5,8(s1)
    80002fde:	ff279ce3          	bne	a5,s2,80002fd6 <bread+0x3a>
    80002fe2:	44dc                	lw	a5,12(s1)
    80002fe4:	ff3799e3          	bne	a5,s3,80002fd6 <bread+0x3a>
      b->refcnt++;
    80002fe8:	44bc                	lw	a5,72(s1)
    80002fea:	2785                	addiw	a5,a5,1
    80002fec:	c4bc                	sw	a5,72(s1)
      release(&bcache.lock);
    80002fee:	00013517          	auipc	a0,0x13
    80002ff2:	af250513          	addi	a0,a0,-1294 # 80015ae0 <bcache>
    80002ff6:	ffffe097          	auipc	ra,0xffffe
    80002ffa:	bd2080e7          	jalr	-1070(ra) # 80000bc8 <release>
      acquiresleep(&b->lock);
    80002ffe:	01048513          	addi	a0,s1,16
    80003002:	00001097          	auipc	ra,0x1
    80003006:	540080e7          	jalr	1344(ra) # 80004542 <acquiresleep>
      return b;
    8000300a:	a8b9                	j	80003068 <bread+0xcc>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    8000300c:	0001b497          	auipc	s1,0x1b
    80003010:	e844b483          	ld	s1,-380(s1) # 8001de90 <bcache+0x83b0>
    80003014:	0001b797          	auipc	a5,0x1b
    80003018:	e2c78793          	addi	a5,a5,-468 # 8001de40 <bcache+0x8360>
    8000301c:	00f48863          	beq	s1,a5,8000302c <bread+0x90>
    80003020:	873e                	mv	a4,a5
    if(b->refcnt == 0) {
    80003022:	44bc                	lw	a5,72(s1)
    80003024:	cf81                	beqz	a5,8000303c <bread+0xa0>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    80003026:	68a4                	ld	s1,80(s1)
    80003028:	fee49de3          	bne	s1,a4,80003022 <bread+0x86>
  panic("bget: no buffers");
    8000302c:	00006517          	auipc	a0,0x6
    80003030:	88450513          	addi	a0,a0,-1916 # 800088b0 <userret+0x820>
    80003034:	ffffd097          	auipc	ra,0xffffd
    80003038:	536080e7          	jalr	1334(ra) # 8000056a <panic>
      b->dev = dev;
    8000303c:	0124a423          	sw	s2,8(s1)
      b->blockno = blockno;
    80003040:	0134a623          	sw	s3,12(s1)
      b->valid = 0;
    80003044:	0004a023          	sw	zero,0(s1)
      b->refcnt = 1;
    80003048:	4785                	li	a5,1
    8000304a:	c4bc                	sw	a5,72(s1)
      release(&bcache.lock);
    8000304c:	00013517          	auipc	a0,0x13
    80003050:	a9450513          	addi	a0,a0,-1388 # 80015ae0 <bcache>
    80003054:	ffffe097          	auipc	ra,0xffffe
    80003058:	b74080e7          	jalr	-1164(ra) # 80000bc8 <release>
      acquiresleep(&b->lock);
    8000305c:	01048513          	addi	a0,s1,16
    80003060:	00001097          	auipc	ra,0x1
    80003064:	4e2080e7          	jalr	1250(ra) # 80004542 <acquiresleep>
  struct buf *b;

  b = bget(dev, blockno);
  if(!b->valid) {
    80003068:	409c                	lw	a5,0(s1)
    8000306a:	cb89                	beqz	a5,8000307c <bread+0xe0>
    virtio_disk_rw(b->dev, b, 0);
    b->valid = 1;
  }
  return b;
}
    8000306c:	8526                	mv	a0,s1
    8000306e:	70a2                	ld	ra,40(sp)
    80003070:	7402                	ld	s0,32(sp)
    80003072:	64e2                	ld	s1,24(sp)
    80003074:	6942                	ld	s2,16(sp)
    80003076:	69a2                	ld	s3,8(sp)
    80003078:	6145                	addi	sp,sp,48
    8000307a:	8082                	ret
    virtio_disk_rw(b->dev, b, 0);
    8000307c:	4601                	li	a2,0
    8000307e:	85a6                	mv	a1,s1
    80003080:	4488                	lw	a0,8(s1)
    80003082:	00003097          	auipc	ra,0x3
    80003086:	1fa080e7          	jalr	506(ra) # 8000627c <virtio_disk_rw>
    b->valid = 1;
    8000308a:	4785                	li	a5,1
    8000308c:	c09c                	sw	a5,0(s1)
  return b;
    8000308e:	bff9                	j	8000306c <bread+0xd0>

0000000080003090 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
    80003090:	1101                	addi	sp,sp,-32
    80003092:	ec06                	sd	ra,24(sp)
    80003094:	e822                	sd	s0,16(sp)
    80003096:	e426                	sd	s1,8(sp)
    80003098:	1000                	addi	s0,sp,32
    8000309a:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    8000309c:	0541                	addi	a0,a0,16
    8000309e:	00001097          	auipc	ra,0x1
    800030a2:	53e080e7          	jalr	1342(ra) # 800045dc <holdingsleep>
    800030a6:	cd09                	beqz	a0,800030c0 <bwrite+0x30>
    panic("bwrite");
  virtio_disk_rw(b->dev, b, 1);
    800030a8:	4605                	li	a2,1
    800030aa:	85a6                	mv	a1,s1
    800030ac:	4488                	lw	a0,8(s1)
    800030ae:	00003097          	auipc	ra,0x3
    800030b2:	1ce080e7          	jalr	462(ra) # 8000627c <virtio_disk_rw>
}
    800030b6:	60e2                	ld	ra,24(sp)
    800030b8:	6442                	ld	s0,16(sp)
    800030ba:	64a2                	ld	s1,8(sp)
    800030bc:	6105                	addi	sp,sp,32
    800030be:	8082                	ret
    panic("bwrite");
    800030c0:	00006517          	auipc	a0,0x6
    800030c4:	80850513          	addi	a0,a0,-2040 # 800088c8 <userret+0x838>
    800030c8:	ffffd097          	auipc	ra,0xffffd
    800030cc:	4a2080e7          	jalr	1186(ra) # 8000056a <panic>

00000000800030d0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
    800030d0:	1101                	addi	sp,sp,-32
    800030d2:	ec06                	sd	ra,24(sp)
    800030d4:	e822                	sd	s0,16(sp)
    800030d6:	e426                	sd	s1,8(sp)
    800030d8:	e04a                	sd	s2,0(sp)
    800030da:	1000                	addi	s0,sp,32
    800030dc:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    800030de:	01050913          	addi	s2,a0,16
    800030e2:	854a                	mv	a0,s2
    800030e4:	00001097          	auipc	ra,0x1
    800030e8:	4f8080e7          	jalr	1272(ra) # 800045dc <holdingsleep>
    800030ec:	c535                	beqz	a0,80003158 <brelse+0x88>
    panic("brelse");

  releasesleep(&b->lock);
    800030ee:	854a                	mv	a0,s2
    800030f0:	00001097          	auipc	ra,0x1
    800030f4:	4a8080e7          	jalr	1192(ra) # 80004598 <releasesleep>

  acquire(&bcache.lock);
    800030f8:	00013517          	auipc	a0,0x13
    800030fc:	9e850513          	addi	a0,a0,-1560 # 80015ae0 <bcache>
    80003100:	ffffe097          	auipc	ra,0xffffe
    80003104:	a04080e7          	jalr	-1532(ra) # 80000b04 <acquire>
  b->refcnt--;
    80003108:	44bc                	lw	a5,72(s1)
    8000310a:	37fd                	addiw	a5,a5,-1
    8000310c:	c4bc                	sw	a5,72(s1)
  if (b->refcnt == 0) {
    8000310e:	e79d                	bnez	a5,8000313c <brelse+0x6c>
    // no one is waiting for it.
    b->next->prev = b->prev;
    80003110:	6cb8                	ld	a4,88(s1)
    80003112:	68bc                	ld	a5,80(s1)
    80003114:	eb3c                	sd	a5,80(a4)
    b->prev->next = b->next;
    80003116:	6cb8                	ld	a4,88(s1)
    80003118:	efb8                	sd	a4,88(a5)
    b->next = bcache.head.next;
    8000311a:	0001b797          	auipc	a5,0x1b
    8000311e:	9c678793          	addi	a5,a5,-1594 # 8001dae0 <bcache+0x8000>
    80003122:	3b87b703          	ld	a4,952(a5)
    80003126:	ecb8                	sd	a4,88(s1)
    b->prev = &bcache.head;
    80003128:	0001b717          	auipc	a4,0x1b
    8000312c:	d1870713          	addi	a4,a4,-744 # 8001de40 <bcache+0x8360>
    80003130:	e8b8                	sd	a4,80(s1)
    bcache.head.next->prev = b;
    80003132:	3b87b703          	ld	a4,952(a5)
    80003136:	eb24                	sd	s1,80(a4)
    bcache.head.next = b;
    80003138:	3a97bc23          	sd	s1,952(a5)
  }
  
  release(&bcache.lock);
    8000313c:	00013517          	auipc	a0,0x13
    80003140:	9a450513          	addi	a0,a0,-1628 # 80015ae0 <bcache>
    80003144:	ffffe097          	auipc	ra,0xffffe
    80003148:	a84080e7          	jalr	-1404(ra) # 80000bc8 <release>
}
    8000314c:	60e2                	ld	ra,24(sp)
    8000314e:	6442                	ld	s0,16(sp)
    80003150:	64a2                	ld	s1,8(sp)
    80003152:	6902                	ld	s2,0(sp)
    80003154:	6105                	addi	sp,sp,32
    80003156:	8082                	ret
    panic("brelse");
    80003158:	00005517          	auipc	a0,0x5
    8000315c:	77850513          	addi	a0,a0,1912 # 800088d0 <userret+0x840>
    80003160:	ffffd097          	auipc	ra,0xffffd
    80003164:	40a080e7          	jalr	1034(ra) # 8000056a <panic>

0000000080003168 <bpin>:

void
bpin(struct buf *b) {
    80003168:	1101                	addi	sp,sp,-32
    8000316a:	ec06                	sd	ra,24(sp)
    8000316c:	e822                	sd	s0,16(sp)
    8000316e:	e426                	sd	s1,8(sp)
    80003170:	1000                	addi	s0,sp,32
    80003172:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    80003174:	00013517          	auipc	a0,0x13
    80003178:	96c50513          	addi	a0,a0,-1684 # 80015ae0 <bcache>
    8000317c:	ffffe097          	auipc	ra,0xffffe
    80003180:	988080e7          	jalr	-1656(ra) # 80000b04 <acquire>
  b->refcnt++;
    80003184:	44bc                	lw	a5,72(s1)
    80003186:	2785                	addiw	a5,a5,1
    80003188:	c4bc                	sw	a5,72(s1)
  release(&bcache.lock);
    8000318a:	00013517          	auipc	a0,0x13
    8000318e:	95650513          	addi	a0,a0,-1706 # 80015ae0 <bcache>
    80003192:	ffffe097          	auipc	ra,0xffffe
    80003196:	a36080e7          	jalr	-1482(ra) # 80000bc8 <release>
}
    8000319a:	60e2                	ld	ra,24(sp)
    8000319c:	6442                	ld	s0,16(sp)
    8000319e:	64a2                	ld	s1,8(sp)
    800031a0:	6105                	addi	sp,sp,32
    800031a2:	8082                	ret

00000000800031a4 <bunpin>:

void
bunpin(struct buf *b) {
    800031a4:	1101                	addi	sp,sp,-32
    800031a6:	ec06                	sd	ra,24(sp)
    800031a8:	e822                	sd	s0,16(sp)
    800031aa:	e426                	sd	s1,8(sp)
    800031ac:	1000                	addi	s0,sp,32
    800031ae:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    800031b0:	00013517          	auipc	a0,0x13
    800031b4:	93050513          	addi	a0,a0,-1744 # 80015ae0 <bcache>
    800031b8:	ffffe097          	auipc	ra,0xffffe
    800031bc:	94c080e7          	jalr	-1716(ra) # 80000b04 <acquire>
  b->refcnt--;
    800031c0:	44bc                	lw	a5,72(s1)
    800031c2:	37fd                	addiw	a5,a5,-1
    800031c4:	c4bc                	sw	a5,72(s1)
  release(&bcache.lock);
    800031c6:	00013517          	auipc	a0,0x13
    800031ca:	91a50513          	addi	a0,a0,-1766 # 80015ae0 <bcache>
    800031ce:	ffffe097          	auipc	ra,0xffffe
    800031d2:	9fa080e7          	jalr	-1542(ra) # 80000bc8 <release>
}
    800031d6:	60e2                	ld	ra,24(sp)
    800031d8:	6442                	ld	s0,16(sp)
    800031da:	64a2                	ld	s1,8(sp)
    800031dc:	6105                	addi	sp,sp,32
    800031de:	8082                	ret

00000000800031e0 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
    800031e0:	1101                	addi	sp,sp,-32
    800031e2:	ec06                	sd	ra,24(sp)
    800031e4:	e822                	sd	s0,16(sp)
    800031e6:	e426                	sd	s1,8(sp)
    800031e8:	e04a                	sd	s2,0(sp)
    800031ea:	1000                	addi	s0,sp,32
    800031ec:	84ae                	mv	s1,a1
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
    800031ee:	00d5d79b          	srliw	a5,a1,0xd
    800031f2:	0001b597          	auipc	a1,0x1b
    800031f6:	0ca5a583          	lw	a1,202(a1) # 8001e2bc <sb+0x1c>
    800031fa:	9dbd                	addw	a1,a1,a5
    800031fc:	00000097          	auipc	ra,0x0
    80003200:	da0080e7          	jalr	-608(ra) # 80002f9c <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
    80003204:	0074f713          	andi	a4,s1,7
    80003208:	4785                	li	a5,1
    8000320a:	00e797bb          	sllw	a5,a5,a4
  bi = b % BPB;
    8000320e:	14ce                	slli	s1,s1,0x33
  if((bp->data[bi/8] & m) == 0)
    80003210:	90d9                	srli	s1,s1,0x36
    80003212:	00950733          	add	a4,a0,s1
    80003216:	06074703          	lbu	a4,96(a4)
    8000321a:	00e7f6b3          	and	a3,a5,a4
    8000321e:	c69d                	beqz	a3,8000324c <bfree+0x6c>
    80003220:	892a                	mv	s2,a0
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
    80003222:	94aa                	add	s1,s1,a0
    80003224:	fff7c793          	not	a5,a5
    80003228:	8f7d                	and	a4,a4,a5
    8000322a:	06e48023          	sb	a4,96(s1)
  log_write(bp);
    8000322e:	00001097          	auipc	ra,0x1
    80003232:	194080e7          	jalr	404(ra) # 800043c2 <log_write>
  brelse(bp);
    80003236:	854a                	mv	a0,s2
    80003238:	00000097          	auipc	ra,0x0
    8000323c:	e98080e7          	jalr	-360(ra) # 800030d0 <brelse>
}
    80003240:	60e2                	ld	ra,24(sp)
    80003242:	6442                	ld	s0,16(sp)
    80003244:	64a2                	ld	s1,8(sp)
    80003246:	6902                	ld	s2,0(sp)
    80003248:	6105                	addi	sp,sp,32
    8000324a:	8082                	ret
    panic("freeing free block");
    8000324c:	00005517          	auipc	a0,0x5
    80003250:	68c50513          	addi	a0,a0,1676 # 800088d8 <userret+0x848>
    80003254:	ffffd097          	auipc	ra,0xffffd
    80003258:	316080e7          	jalr	790(ra) # 8000056a <panic>

000000008000325c <balloc>:
{
    8000325c:	715d                	addi	sp,sp,-80
    8000325e:	e486                	sd	ra,72(sp)
    80003260:	e0a2                	sd	s0,64(sp)
    80003262:	fc26                	sd	s1,56(sp)
    80003264:	f84a                	sd	s2,48(sp)
    80003266:	f44e                	sd	s3,40(sp)
    80003268:	f052                	sd	s4,32(sp)
    8000326a:	ec56                	sd	s5,24(sp)
    8000326c:	e85a                	sd	s6,16(sp)
    8000326e:	e45e                	sd	s7,8(sp)
    80003270:	e062                	sd	s8,0(sp)
    80003272:	0880                	addi	s0,sp,80
  for(b = 0; b < sb.size; b += BPB){
    80003274:	0001b797          	auipc	a5,0x1b
    80003278:	0307a783          	lw	a5,48(a5) # 8001e2a4 <sb+0x4>
    8000327c:	cfb5                	beqz	a5,800032f8 <balloc+0x9c>
    8000327e:	8baa                	mv	s7,a0
    80003280:	4a81                	li	s5,0
    bp = bread(dev, BBLOCK(b, sb));
    80003282:	0001bb17          	auipc	s6,0x1b
    80003286:	01eb0b13          	addi	s6,s6,30 # 8001e2a0 <sb>
      m = 1 << (bi % 8);
    8000328a:	4985                	li	s3,1
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    8000328c:	6a09                	lui	s4,0x2
  for(b = 0; b < sb.size; b += BPB){
    8000328e:	6c09                	lui	s8,0x2
    80003290:	a821                	j	800032a8 <balloc+0x4c>
    brelse(bp);
    80003292:	854a                	mv	a0,s2
    80003294:	00000097          	auipc	ra,0x0
    80003298:	e3c080e7          	jalr	-452(ra) # 800030d0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
    8000329c:	015c0abb          	addw	s5,s8,s5
    800032a0:	004b2783          	lw	a5,4(s6)
    800032a4:	04fafa63          	bgeu	s5,a5,800032f8 <balloc+0x9c>
    bp = bread(dev, BBLOCK(b, sb));
    800032a8:	40dad59b          	sraiw	a1,s5,0xd
    800032ac:	01cb2783          	lw	a5,28(s6)
    800032b0:	9dbd                	addw	a1,a1,a5
    800032b2:	855e                	mv	a0,s7
    800032b4:	00000097          	auipc	ra,0x0
    800032b8:	ce8080e7          	jalr	-792(ra) # 80002f9c <bread>
    800032bc:	892a                	mv	s2,a0
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    800032be:	004b2503          	lw	a0,4(s6)
    800032c2:	84d6                	mv	s1,s5
    800032c4:	4701                	li	a4,0
    800032c6:	fca4f6e3          	bgeu	s1,a0,80003292 <balloc+0x36>
      m = 1 << (bi % 8);
    800032ca:	00777693          	andi	a3,a4,7
    800032ce:	00d996bb          	sllw	a3,s3,a3
      if((bp->data[bi/8] & m) == 0){  // Is block free?
    800032d2:	41f7579b          	sraiw	a5,a4,0x1f
    800032d6:	01d7d79b          	srliw	a5,a5,0x1d
    800032da:	9fb9                	addw	a5,a5,a4
    800032dc:	4037d79b          	sraiw	a5,a5,0x3
    800032e0:	00f90633          	add	a2,s2,a5
    800032e4:	06064603          	lbu	a2,96(a2)
    800032e8:	00c6f5b3          	and	a1,a3,a2
    800032ec:	cd91                	beqz	a1,80003308 <balloc+0xac>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    800032ee:	2705                	addiw	a4,a4,1
    800032f0:	2485                	addiw	s1,s1,1
    800032f2:	fd471ae3          	bne	a4,s4,800032c6 <balloc+0x6a>
    800032f6:	bf71                	j	80003292 <balloc+0x36>
  panic("balloc: out of blocks");
    800032f8:	00005517          	auipc	a0,0x5
    800032fc:	5f850513          	addi	a0,a0,1528 # 800088f0 <userret+0x860>
    80003300:	ffffd097          	auipc	ra,0xffffd
    80003304:	26a080e7          	jalr	618(ra) # 8000056a <panic>
        bp->data[bi/8] |= m;  // Mark block in use.
    80003308:	97ca                	add	a5,a5,s2
    8000330a:	8e55                	or	a2,a2,a3
    8000330c:	06c78023          	sb	a2,96(a5)
        log_write(bp);
    80003310:	854a                	mv	a0,s2
    80003312:	00001097          	auipc	ra,0x1
    80003316:	0b0080e7          	jalr	176(ra) # 800043c2 <log_write>
        brelse(bp);
    8000331a:	854a                	mv	a0,s2
    8000331c:	00000097          	auipc	ra,0x0
    80003320:	db4080e7          	jalr	-588(ra) # 800030d0 <brelse>
  bp = bread(dev, bno);
    80003324:	85a6                	mv	a1,s1
    80003326:	855e                	mv	a0,s7
    80003328:	00000097          	auipc	ra,0x0
    8000332c:	c74080e7          	jalr	-908(ra) # 80002f9c <bread>
    80003330:	892a                	mv	s2,a0
  memset(bp->data, 0, BSIZE);
    80003332:	40000613          	li	a2,1024
    80003336:	4581                	li	a1,0
    80003338:	06050513          	addi	a0,a0,96
    8000333c:	ffffe097          	auipc	ra,0xffffe
    80003340:	a82080e7          	jalr	-1406(ra) # 80000dbe <memset>
  log_write(bp);
    80003344:	854a                	mv	a0,s2
    80003346:	00001097          	auipc	ra,0x1
    8000334a:	07c080e7          	jalr	124(ra) # 800043c2 <log_write>
  brelse(bp);
    8000334e:	854a                	mv	a0,s2
    80003350:	00000097          	auipc	ra,0x0
    80003354:	d80080e7          	jalr	-640(ra) # 800030d0 <brelse>
}
    80003358:	8526                	mv	a0,s1
    8000335a:	60a6                	ld	ra,72(sp)
    8000335c:	6406                	ld	s0,64(sp)
    8000335e:	74e2                	ld	s1,56(sp)
    80003360:	7942                	ld	s2,48(sp)
    80003362:	79a2                	ld	s3,40(sp)
    80003364:	7a02                	ld	s4,32(sp)
    80003366:	6ae2                	ld	s5,24(sp)
    80003368:	6b42                	ld	s6,16(sp)
    8000336a:	6ba2                	ld	s7,8(sp)
    8000336c:	6c02                	ld	s8,0(sp)
    8000336e:	6161                	addi	sp,sp,80
    80003370:	8082                	ret

0000000080003372 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
    80003372:	7179                	addi	sp,sp,-48
    80003374:	f406                	sd	ra,40(sp)
    80003376:	f022                	sd	s0,32(sp)
    80003378:	ec26                	sd	s1,24(sp)
    8000337a:	e84a                	sd	s2,16(sp)
    8000337c:	e44e                	sd	s3,8(sp)
    8000337e:	1800                	addi	s0,sp,48
    80003380:	892a                	mv	s2,a0
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    80003382:	47ad                	li	a5,11
    80003384:	04b7fd63          	bgeu	a5,a1,800033de <bmap+0x6c>
    80003388:	e052                	sd	s4,0(sp)
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
    8000338a:	ff45849b          	addiw	s1,a1,-12

  if(bn < NINDIRECT){
    8000338e:	0ff00793          	li	a5,255
    80003392:	0897ef63          	bltu	a5,s1,80003430 <bmap+0xbe>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
    80003396:	08852583          	lw	a1,136(a0)
    8000339a:	c5a5                	beqz	a1,80003402 <bmap+0x90>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
    8000339c:	00092503          	lw	a0,0(s2)
    800033a0:	00000097          	auipc	ra,0x0
    800033a4:	bfc080e7          	jalr	-1028(ra) # 80002f9c <bread>
    800033a8:	8a2a                	mv	s4,a0
    a = (uint*)bp->data;
    800033aa:	06050793          	addi	a5,a0,96
    if((addr = a[bn]) == 0){
    800033ae:	02049713          	slli	a4,s1,0x20
    800033b2:	01e75593          	srli	a1,a4,0x1e
    800033b6:	00b784b3          	add	s1,a5,a1
    800033ba:	0004a983          	lw	s3,0(s1)
    800033be:	04098b63          	beqz	s3,80003414 <bmap+0xa2>
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
    800033c2:	8552                	mv	a0,s4
    800033c4:	00000097          	auipc	ra,0x0
    800033c8:	d0c080e7          	jalr	-756(ra) # 800030d0 <brelse>
    return addr;
    800033cc:	6a02                	ld	s4,0(sp)
  }

  panic("bmap: out of range");
}
    800033ce:	854e                	mv	a0,s3
    800033d0:	70a2                	ld	ra,40(sp)
    800033d2:	7402                	ld	s0,32(sp)
    800033d4:	64e2                	ld	s1,24(sp)
    800033d6:	6942                	ld	s2,16(sp)
    800033d8:	69a2                	ld	s3,8(sp)
    800033da:	6145                	addi	sp,sp,48
    800033dc:	8082                	ret
    if((addr = ip->addrs[bn]) == 0)
    800033de:	02059793          	slli	a5,a1,0x20
    800033e2:	01e7d593          	srli	a1,a5,0x1e
    800033e6:	00b504b3          	add	s1,a0,a1
    800033ea:	0584a983          	lw	s3,88(s1)
    800033ee:	fe0990e3          	bnez	s3,800033ce <bmap+0x5c>
      ip->addrs[bn] = addr = balloc(ip->dev);
    800033f2:	4108                	lw	a0,0(a0)
    800033f4:	00000097          	auipc	ra,0x0
    800033f8:	e68080e7          	jalr	-408(ra) # 8000325c <balloc>
    800033fc:	89aa                	mv	s3,a0
    800033fe:	cca8                	sw	a0,88(s1)
    80003400:	b7f9                	j	800033ce <bmap+0x5c>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    80003402:	4108                	lw	a0,0(a0)
    80003404:	00000097          	auipc	ra,0x0
    80003408:	e58080e7          	jalr	-424(ra) # 8000325c <balloc>
    8000340c:	85aa                	mv	a1,a0
    8000340e:	08a92423          	sw	a0,136(s2)
    80003412:	b769                	j	8000339c <bmap+0x2a>
      a[bn] = addr = balloc(ip->dev);
    80003414:	00092503          	lw	a0,0(s2)
    80003418:	00000097          	auipc	ra,0x0
    8000341c:	e44080e7          	jalr	-444(ra) # 8000325c <balloc>
    80003420:	89aa                	mv	s3,a0
    80003422:	c088                	sw	a0,0(s1)
      log_write(bp);
    80003424:	8552                	mv	a0,s4
    80003426:	00001097          	auipc	ra,0x1
    8000342a:	f9c080e7          	jalr	-100(ra) # 800043c2 <log_write>
    8000342e:	bf51                	j	800033c2 <bmap+0x50>
  panic("bmap: out of range");
    80003430:	00005517          	auipc	a0,0x5
    80003434:	4d850513          	addi	a0,a0,1240 # 80008908 <userret+0x878>
    80003438:	ffffd097          	auipc	ra,0xffffd
    8000343c:	132080e7          	jalr	306(ra) # 8000056a <panic>

0000000080003440 <iget>:
{
    80003440:	7179                	addi	sp,sp,-48
    80003442:	f406                	sd	ra,40(sp)
    80003444:	f022                	sd	s0,32(sp)
    80003446:	ec26                	sd	s1,24(sp)
    80003448:	e84a                	sd	s2,16(sp)
    8000344a:	e44e                	sd	s3,8(sp)
    8000344c:	e052                	sd	s4,0(sp)
    8000344e:	1800                	addi	s0,sp,48
    80003450:	892a                	mv	s2,a0
    80003452:	8a2e                	mv	s4,a1
  acquire(&icache.lock);
    80003454:	0001b517          	auipc	a0,0x1b
    80003458:	e6c50513          	addi	a0,a0,-404 # 8001e2c0 <icache>
    8000345c:	ffffd097          	auipc	ra,0xffffd
    80003460:	6a8080e7          	jalr	1704(ra) # 80000b04 <acquire>
  empty = 0;
    80003464:	4981                	li	s3,0
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    80003466:	0001b497          	auipc	s1,0x1b
    8000346a:	e7a48493          	addi	s1,s1,-390 # 8001e2e0 <icache+0x20>
    8000346e:	0001d697          	auipc	a3,0x1d
    80003472:	a9268693          	addi	a3,a3,-1390 # 8001ff00 <log>
    80003476:	a809                	j	80003488 <iget+0x48>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    80003478:	e781                	bnez	a5,80003480 <iget+0x40>
    8000347a:	00099363          	bnez	s3,80003480 <iget+0x40>
      empty = ip;
    8000347e:	89a6                	mv	s3,s1
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    80003480:	09048493          	addi	s1,s1,144
    80003484:	02d48763          	beq	s1,a3,800034b2 <iget+0x72>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
    80003488:	449c                	lw	a5,8(s1)
    8000348a:	fef057e3          	blez	a5,80003478 <iget+0x38>
    8000348e:	4098                	lw	a4,0(s1)
    80003490:	ff2718e3          	bne	a4,s2,80003480 <iget+0x40>
    80003494:	40d8                	lw	a4,4(s1)
    80003496:	ff4715e3          	bne	a4,s4,80003480 <iget+0x40>
      ip->ref++;
    8000349a:	2785                	addiw	a5,a5,1
    8000349c:	c49c                	sw	a5,8(s1)
      release(&icache.lock);
    8000349e:	0001b517          	auipc	a0,0x1b
    800034a2:	e2250513          	addi	a0,a0,-478 # 8001e2c0 <icache>
    800034a6:	ffffd097          	auipc	ra,0xffffd
    800034aa:	722080e7          	jalr	1826(ra) # 80000bc8 <release>
      return ip;
    800034ae:	89a6                	mv	s3,s1
    800034b0:	a025                	j	800034d8 <iget+0x98>
  if(empty == 0)
    800034b2:	02098c63          	beqz	s3,800034ea <iget+0xaa>
  ip->dev = dev;
    800034b6:	0129a023          	sw	s2,0(s3)
  ip->inum = inum;
    800034ba:	0149a223          	sw	s4,4(s3)
  ip->ref = 1;
    800034be:	4785                	li	a5,1
    800034c0:	00f9a423          	sw	a5,8(s3)
  ip->valid = 0;
    800034c4:	0409a423          	sw	zero,72(s3)
  release(&icache.lock);
    800034c8:	0001b517          	auipc	a0,0x1b
    800034cc:	df850513          	addi	a0,a0,-520 # 8001e2c0 <icache>
    800034d0:	ffffd097          	auipc	ra,0xffffd
    800034d4:	6f8080e7          	jalr	1784(ra) # 80000bc8 <release>
}
    800034d8:	854e                	mv	a0,s3
    800034da:	70a2                	ld	ra,40(sp)
    800034dc:	7402                	ld	s0,32(sp)
    800034de:	64e2                	ld	s1,24(sp)
    800034e0:	6942                	ld	s2,16(sp)
    800034e2:	69a2                	ld	s3,8(sp)
    800034e4:	6a02                	ld	s4,0(sp)
    800034e6:	6145                	addi	sp,sp,48
    800034e8:	8082                	ret
    panic("iget: no inodes");
    800034ea:	00005517          	auipc	a0,0x5
    800034ee:	43650513          	addi	a0,a0,1078 # 80008920 <userret+0x890>
    800034f2:	ffffd097          	auipc	ra,0xffffd
    800034f6:	078080e7          	jalr	120(ra) # 8000056a <panic>

00000000800034fa <fsinit>:
fsinit(int dev) {
    800034fa:	1101                	addi	sp,sp,-32
    800034fc:	ec06                	sd	ra,24(sp)
    800034fe:	e822                	sd	s0,16(sp)
    80003500:	e426                	sd	s1,8(sp)
    80003502:	e04a                	sd	s2,0(sp)
    80003504:	1000                	addi	s0,sp,32
    80003506:	892a                	mv	s2,a0
  bp = bread(dev, 1);
    80003508:	4585                	li	a1,1
    8000350a:	00000097          	auipc	ra,0x0
    8000350e:	a92080e7          	jalr	-1390(ra) # 80002f9c <bread>
    80003512:	84aa                	mv	s1,a0
  memmove(sb, bp->data, sizeof(*sb));
    80003514:	02000613          	li	a2,32
    80003518:	06050593          	addi	a1,a0,96
    8000351c:	0001b517          	auipc	a0,0x1b
    80003520:	d8450513          	addi	a0,a0,-636 # 8001e2a0 <sb>
    80003524:	ffffe097          	auipc	ra,0xffffe
    80003528:	8fa080e7          	jalr	-1798(ra) # 80000e1e <memmove>
  brelse(bp);
    8000352c:	8526                	mv	a0,s1
    8000352e:	00000097          	auipc	ra,0x0
    80003532:	ba2080e7          	jalr	-1118(ra) # 800030d0 <brelse>
  if(sb.magic != FSMAGIC)
    80003536:	0001b717          	auipc	a4,0x1b
    8000353a:	d6a72703          	lw	a4,-662(a4) # 8001e2a0 <sb>
    8000353e:	102037b7          	lui	a5,0x10203
    80003542:	04078793          	addi	a5,a5,64 # 10203040 <_entry-0x6fdfcfc0>
    80003546:	02f71163          	bne	a4,a5,80003568 <fsinit+0x6e>
  initlog(dev, &sb);
    8000354a:	0001b597          	auipc	a1,0x1b
    8000354e:	d5658593          	addi	a1,a1,-682 # 8001e2a0 <sb>
    80003552:	854a                	mv	a0,s2
    80003554:	00001097          	auipc	ra,0x1
    80003558:	b68080e7          	jalr	-1176(ra) # 800040bc <initlog>
}
    8000355c:	60e2                	ld	ra,24(sp)
    8000355e:	6442                	ld	s0,16(sp)
    80003560:	64a2                	ld	s1,8(sp)
    80003562:	6902                	ld	s2,0(sp)
    80003564:	6105                	addi	sp,sp,32
    80003566:	8082                	ret
    panic("invalid file system");
    80003568:	00005517          	auipc	a0,0x5
    8000356c:	3c850513          	addi	a0,a0,968 # 80008930 <userret+0x8a0>
    80003570:	ffffd097          	auipc	ra,0xffffd
    80003574:	ffa080e7          	jalr	-6(ra) # 8000056a <panic>

0000000080003578 <iinit>:
{
    80003578:	7179                	addi	sp,sp,-48
    8000357a:	f406                	sd	ra,40(sp)
    8000357c:	f022                	sd	s0,32(sp)
    8000357e:	ec26                	sd	s1,24(sp)
    80003580:	e84a                	sd	s2,16(sp)
    80003582:	e44e                	sd	s3,8(sp)
    80003584:	1800                	addi	s0,sp,48
  initlock(&icache.lock, "icache");
    80003586:	00005597          	auipc	a1,0x5
    8000358a:	3c258593          	addi	a1,a1,962 # 80008948 <userret+0x8b8>
    8000358e:	0001b517          	auipc	a0,0x1b
    80003592:	d3250513          	addi	a0,a0,-718 # 8001e2c0 <icache>
    80003596:	ffffd097          	auipc	ra,0xffffd
    8000359a:	49a080e7          	jalr	1178(ra) # 80000a30 <initlock>
  for(i = 0; i < NINODE; i++) {
    8000359e:	0001b497          	auipc	s1,0x1b
    800035a2:	d5248493          	addi	s1,s1,-686 # 8001e2f0 <icache+0x30>
    800035a6:	0001d997          	auipc	s3,0x1d
    800035aa:	96a98993          	addi	s3,s3,-1686 # 8001ff10 <log+0x10>
    initsleeplock(&icache.inode[i].lock, "inode");
    800035ae:	00005917          	auipc	s2,0x5
    800035b2:	3a290913          	addi	s2,s2,930 # 80008950 <userret+0x8c0>
    800035b6:	85ca                	mv	a1,s2
    800035b8:	8526                	mv	a0,s1
    800035ba:	00001097          	auipc	ra,0x1
    800035be:	f4e080e7          	jalr	-178(ra) # 80004508 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
    800035c2:	09048493          	addi	s1,s1,144
    800035c6:	ff3498e3          	bne	s1,s3,800035b6 <iinit+0x3e>
}
    800035ca:	70a2                	ld	ra,40(sp)
    800035cc:	7402                	ld	s0,32(sp)
    800035ce:	64e2                	ld	s1,24(sp)
    800035d0:	6942                	ld	s2,16(sp)
    800035d2:	69a2                	ld	s3,8(sp)
    800035d4:	6145                	addi	sp,sp,48
    800035d6:	8082                	ret

00000000800035d8 <ialloc>:
{
    800035d8:	7139                	addi	sp,sp,-64
    800035da:	fc06                	sd	ra,56(sp)
    800035dc:	f822                	sd	s0,48(sp)
    800035de:	f426                	sd	s1,40(sp)
    800035e0:	f04a                	sd	s2,32(sp)
    800035e2:	ec4e                	sd	s3,24(sp)
    800035e4:	e852                	sd	s4,16(sp)
    800035e6:	e456                	sd	s5,8(sp)
    800035e8:	e05a                	sd	s6,0(sp)
    800035ea:	0080                	addi	s0,sp,64
  for(inum = 1; inum < sb.ninodes; inum++){
    800035ec:	0001b717          	auipc	a4,0x1b
    800035f0:	cc072703          	lw	a4,-832(a4) # 8001e2ac <sb+0xc>
    800035f4:	4785                	li	a5,1
    800035f6:	04e7f863          	bgeu	a5,a4,80003646 <ialloc+0x6e>
    800035fa:	8aaa                	mv	s5,a0
    800035fc:	8b2e                	mv	s6,a1
    800035fe:	893e                	mv	s2,a5
    bp = bread(dev, IBLOCK(inum, sb));
    80003600:	0001ba17          	auipc	s4,0x1b
    80003604:	ca0a0a13          	addi	s4,s4,-864 # 8001e2a0 <sb>
    80003608:	00495593          	srli	a1,s2,0x4
    8000360c:	018a2783          	lw	a5,24(s4)
    80003610:	9dbd                	addw	a1,a1,a5
    80003612:	8556                	mv	a0,s5
    80003614:	00000097          	auipc	ra,0x0
    80003618:	988080e7          	jalr	-1656(ra) # 80002f9c <bread>
    8000361c:	84aa                	mv	s1,a0
    dip = (struct dinode*)bp->data + inum%IPB;
    8000361e:	06050993          	addi	s3,a0,96
    80003622:	00f97793          	andi	a5,s2,15
    80003626:	079a                	slli	a5,a5,0x6
    80003628:	99be                	add	s3,s3,a5
    if(dip->type == 0){  // a free inode
    8000362a:	00099783          	lh	a5,0(s3)
    8000362e:	c785                	beqz	a5,80003656 <ialloc+0x7e>
    brelse(bp);
    80003630:	00000097          	auipc	ra,0x0
    80003634:	aa0080e7          	jalr	-1376(ra) # 800030d0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
    80003638:	0905                	addi	s2,s2,1
    8000363a:	00ca2703          	lw	a4,12(s4)
    8000363e:	0009079b          	sext.w	a5,s2
    80003642:	fce7e3e3          	bltu	a5,a4,80003608 <ialloc+0x30>
  panic("ialloc: no inodes");
    80003646:	00005517          	auipc	a0,0x5
    8000364a:	31250513          	addi	a0,a0,786 # 80008958 <userret+0x8c8>
    8000364e:	ffffd097          	auipc	ra,0xffffd
    80003652:	f1c080e7          	jalr	-228(ra) # 8000056a <panic>
      memset(dip, 0, sizeof(*dip));
    80003656:	04000613          	li	a2,64
    8000365a:	4581                	li	a1,0
    8000365c:	854e                	mv	a0,s3
    8000365e:	ffffd097          	auipc	ra,0xffffd
    80003662:	760080e7          	jalr	1888(ra) # 80000dbe <memset>
      dip->type = type;
    80003666:	01699023          	sh	s6,0(s3)
      log_write(bp);   // mark it allocated on the disk
    8000366a:	8526                	mv	a0,s1
    8000366c:	00001097          	auipc	ra,0x1
    80003670:	d56080e7          	jalr	-682(ra) # 800043c2 <log_write>
      brelse(bp);
    80003674:	8526                	mv	a0,s1
    80003676:	00000097          	auipc	ra,0x0
    8000367a:	a5a080e7          	jalr	-1446(ra) # 800030d0 <brelse>
      return iget(dev, inum);
    8000367e:	0009059b          	sext.w	a1,s2
    80003682:	8556                	mv	a0,s5
    80003684:	00000097          	auipc	ra,0x0
    80003688:	dbc080e7          	jalr	-580(ra) # 80003440 <iget>
}
    8000368c:	70e2                	ld	ra,56(sp)
    8000368e:	7442                	ld	s0,48(sp)
    80003690:	74a2                	ld	s1,40(sp)
    80003692:	7902                	ld	s2,32(sp)
    80003694:	69e2                	ld	s3,24(sp)
    80003696:	6a42                	ld	s4,16(sp)
    80003698:	6aa2                	ld	s5,8(sp)
    8000369a:	6b02                	ld	s6,0(sp)
    8000369c:	6121                	addi	sp,sp,64
    8000369e:	8082                	ret

00000000800036a0 <iupdate>:
{
    800036a0:	1101                	addi	sp,sp,-32
    800036a2:	ec06                	sd	ra,24(sp)
    800036a4:	e822                	sd	s0,16(sp)
    800036a6:	e426                	sd	s1,8(sp)
    800036a8:	e04a                	sd	s2,0(sp)
    800036aa:	1000                	addi	s0,sp,32
    800036ac:	84aa                	mv	s1,a0
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    800036ae:	415c                	lw	a5,4(a0)
    800036b0:	0047d79b          	srliw	a5,a5,0x4
    800036b4:	0001b597          	auipc	a1,0x1b
    800036b8:	c045a583          	lw	a1,-1020(a1) # 8001e2b8 <sb+0x18>
    800036bc:	9dbd                	addw	a1,a1,a5
    800036be:	4108                	lw	a0,0(a0)
    800036c0:	00000097          	auipc	ra,0x0
    800036c4:	8dc080e7          	jalr	-1828(ra) # 80002f9c <bread>
    800036c8:	892a                	mv	s2,a0
  dip = (struct dinode*)bp->data + ip->inum%IPB;
    800036ca:	06050793          	addi	a5,a0,96
    800036ce:	40d8                	lw	a4,4(s1)
    800036d0:	8b3d                	andi	a4,a4,15
    800036d2:	071a                	slli	a4,a4,0x6
    800036d4:	97ba                	add	a5,a5,a4
  dip->type = ip->type;
    800036d6:	04c49703          	lh	a4,76(s1)
    800036da:	00e79023          	sh	a4,0(a5)
  dip->major = ip->major;
    800036de:	04e49703          	lh	a4,78(s1)
    800036e2:	00e79123          	sh	a4,2(a5)
  dip->minor = ip->minor;
    800036e6:	05049703          	lh	a4,80(s1)
    800036ea:	00e79223          	sh	a4,4(a5)
  dip->nlink = ip->nlink;
    800036ee:	05249703          	lh	a4,82(s1)
    800036f2:	00e79323          	sh	a4,6(a5)
  dip->size = ip->size;
    800036f6:	48f8                	lw	a4,84(s1)
    800036f8:	c798                	sw	a4,8(a5)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
    800036fa:	03400613          	li	a2,52
    800036fe:	05848593          	addi	a1,s1,88
    80003702:	00c78513          	addi	a0,a5,12
    80003706:	ffffd097          	auipc	ra,0xffffd
    8000370a:	718080e7          	jalr	1816(ra) # 80000e1e <memmove>
  log_write(bp);
    8000370e:	854a                	mv	a0,s2
    80003710:	00001097          	auipc	ra,0x1
    80003714:	cb2080e7          	jalr	-846(ra) # 800043c2 <log_write>
  brelse(bp);
    80003718:	854a                	mv	a0,s2
    8000371a:	00000097          	auipc	ra,0x0
    8000371e:	9b6080e7          	jalr	-1610(ra) # 800030d0 <brelse>
}
    80003722:	60e2                	ld	ra,24(sp)
    80003724:	6442                	ld	s0,16(sp)
    80003726:	64a2                	ld	s1,8(sp)
    80003728:	6902                	ld	s2,0(sp)
    8000372a:	6105                	addi	sp,sp,32
    8000372c:	8082                	ret

000000008000372e <idup>:
{
    8000372e:	1101                	addi	sp,sp,-32
    80003730:	ec06                	sd	ra,24(sp)
    80003732:	e822                	sd	s0,16(sp)
    80003734:	e426                	sd	s1,8(sp)
    80003736:	1000                	addi	s0,sp,32
    80003738:	84aa                	mv	s1,a0
  acquire(&icache.lock);
    8000373a:	0001b517          	auipc	a0,0x1b
    8000373e:	b8650513          	addi	a0,a0,-1146 # 8001e2c0 <icache>
    80003742:	ffffd097          	auipc	ra,0xffffd
    80003746:	3c2080e7          	jalr	962(ra) # 80000b04 <acquire>
  ip->ref++;
    8000374a:	449c                	lw	a5,8(s1)
    8000374c:	2785                	addiw	a5,a5,1
    8000374e:	c49c                	sw	a5,8(s1)
  release(&icache.lock);
    80003750:	0001b517          	auipc	a0,0x1b
    80003754:	b7050513          	addi	a0,a0,-1168 # 8001e2c0 <icache>
    80003758:	ffffd097          	auipc	ra,0xffffd
    8000375c:	470080e7          	jalr	1136(ra) # 80000bc8 <release>
}
    80003760:	8526                	mv	a0,s1
    80003762:	60e2                	ld	ra,24(sp)
    80003764:	6442                	ld	s0,16(sp)
    80003766:	64a2                	ld	s1,8(sp)
    80003768:	6105                	addi	sp,sp,32
    8000376a:	8082                	ret

000000008000376c <ilock>:
{
    8000376c:	1101                	addi	sp,sp,-32
    8000376e:	ec06                	sd	ra,24(sp)
    80003770:	e822                	sd	s0,16(sp)
    80003772:	e426                	sd	s1,8(sp)
    80003774:	1000                	addi	s0,sp,32
  if(ip == 0 || ip->ref < 1)
    80003776:	c10d                	beqz	a0,80003798 <ilock+0x2c>
    80003778:	84aa                	mv	s1,a0
    8000377a:	451c                	lw	a5,8(a0)
    8000377c:	00f05e63          	blez	a5,80003798 <ilock+0x2c>
  acquiresleep(&ip->lock);
    80003780:	0541                	addi	a0,a0,16
    80003782:	00001097          	auipc	ra,0x1
    80003786:	dc0080e7          	jalr	-576(ra) # 80004542 <acquiresleep>
  if(ip->valid == 0){
    8000378a:	44bc                	lw	a5,72(s1)
    8000378c:	cf99                	beqz	a5,800037aa <ilock+0x3e>
}
    8000378e:	60e2                	ld	ra,24(sp)
    80003790:	6442                	ld	s0,16(sp)
    80003792:	64a2                	ld	s1,8(sp)
    80003794:	6105                	addi	sp,sp,32
    80003796:	8082                	ret
    80003798:	e04a                	sd	s2,0(sp)
    panic("ilock");
    8000379a:	00005517          	auipc	a0,0x5
    8000379e:	1d650513          	addi	a0,a0,470 # 80008970 <userret+0x8e0>
    800037a2:	ffffd097          	auipc	ra,0xffffd
    800037a6:	dc8080e7          	jalr	-568(ra) # 8000056a <panic>
    800037aa:	e04a                	sd	s2,0(sp)
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    800037ac:	40dc                	lw	a5,4(s1)
    800037ae:	0047d79b          	srliw	a5,a5,0x4
    800037b2:	0001b597          	auipc	a1,0x1b
    800037b6:	b065a583          	lw	a1,-1274(a1) # 8001e2b8 <sb+0x18>
    800037ba:	9dbd                	addw	a1,a1,a5
    800037bc:	4088                	lw	a0,0(s1)
    800037be:	fffff097          	auipc	ra,0xfffff
    800037c2:	7de080e7          	jalr	2014(ra) # 80002f9c <bread>
    800037c6:	892a                	mv	s2,a0
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    800037c8:	06050593          	addi	a1,a0,96
    800037cc:	40dc                	lw	a5,4(s1)
    800037ce:	8bbd                	andi	a5,a5,15
    800037d0:	079a                	slli	a5,a5,0x6
    800037d2:	95be                	add	a1,a1,a5
    ip->type = dip->type;
    800037d4:	00059783          	lh	a5,0(a1)
    800037d8:	04f49623          	sh	a5,76(s1)
    ip->major = dip->major;
    800037dc:	00259783          	lh	a5,2(a1)
    800037e0:	04f49723          	sh	a5,78(s1)
    ip->minor = dip->minor;
    800037e4:	00459783          	lh	a5,4(a1)
    800037e8:	04f49823          	sh	a5,80(s1)
    ip->nlink = dip->nlink;
    800037ec:	00659783          	lh	a5,6(a1)
    800037f0:	04f49923          	sh	a5,82(s1)
    ip->size = dip->size;
    800037f4:	459c                	lw	a5,8(a1)
    800037f6:	c8fc                	sw	a5,84(s1)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
    800037f8:	03400613          	li	a2,52
    800037fc:	05b1                	addi	a1,a1,12
    800037fe:	05848513          	addi	a0,s1,88
    80003802:	ffffd097          	auipc	ra,0xffffd
    80003806:	61c080e7          	jalr	1564(ra) # 80000e1e <memmove>
    brelse(bp);
    8000380a:	854a                	mv	a0,s2
    8000380c:	00000097          	auipc	ra,0x0
    80003810:	8c4080e7          	jalr	-1852(ra) # 800030d0 <brelse>
    ip->valid = 1;
    80003814:	4785                	li	a5,1
    80003816:	c4bc                	sw	a5,72(s1)
    if(ip->type == 0)
    80003818:	04c49783          	lh	a5,76(s1)
    8000381c:	c399                	beqz	a5,80003822 <ilock+0xb6>
    8000381e:	6902                	ld	s2,0(sp)
    80003820:	b7bd                	j	8000378e <ilock+0x22>
      panic("ilock: no type");
    80003822:	00005517          	auipc	a0,0x5
    80003826:	15650513          	addi	a0,a0,342 # 80008978 <userret+0x8e8>
    8000382a:	ffffd097          	auipc	ra,0xffffd
    8000382e:	d40080e7          	jalr	-704(ra) # 8000056a <panic>

0000000080003832 <iunlock>:
{
    80003832:	1101                	addi	sp,sp,-32
    80003834:	ec06                	sd	ra,24(sp)
    80003836:	e822                	sd	s0,16(sp)
    80003838:	e426                	sd	s1,8(sp)
    8000383a:	e04a                	sd	s2,0(sp)
    8000383c:	1000                	addi	s0,sp,32
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    8000383e:	c905                	beqz	a0,8000386e <iunlock+0x3c>
    80003840:	84aa                	mv	s1,a0
    80003842:	01050913          	addi	s2,a0,16
    80003846:	854a                	mv	a0,s2
    80003848:	00001097          	auipc	ra,0x1
    8000384c:	d94080e7          	jalr	-620(ra) # 800045dc <holdingsleep>
    80003850:	cd19                	beqz	a0,8000386e <iunlock+0x3c>
    80003852:	449c                	lw	a5,8(s1)
    80003854:	00f05d63          	blez	a5,8000386e <iunlock+0x3c>
  releasesleep(&ip->lock);
    80003858:	854a                	mv	a0,s2
    8000385a:	00001097          	auipc	ra,0x1
    8000385e:	d3e080e7          	jalr	-706(ra) # 80004598 <releasesleep>
}
    80003862:	60e2                	ld	ra,24(sp)
    80003864:	6442                	ld	s0,16(sp)
    80003866:	64a2                	ld	s1,8(sp)
    80003868:	6902                	ld	s2,0(sp)
    8000386a:	6105                	addi	sp,sp,32
    8000386c:	8082                	ret
    panic("iunlock");
    8000386e:	00005517          	auipc	a0,0x5
    80003872:	11a50513          	addi	a0,a0,282 # 80008988 <userret+0x8f8>
    80003876:	ffffd097          	auipc	ra,0xffffd
    8000387a:	cf4080e7          	jalr	-780(ra) # 8000056a <panic>

000000008000387e <iput>:
{
    8000387e:	7139                	addi	sp,sp,-64
    80003880:	fc06                	sd	ra,56(sp)
    80003882:	f822                	sd	s0,48(sp)
    80003884:	f426                	sd	s1,40(sp)
    80003886:	0080                	addi	s0,sp,64
    80003888:	84aa                	mv	s1,a0
  acquire(&icache.lock);
    8000388a:	0001b517          	auipc	a0,0x1b
    8000388e:	a3650513          	addi	a0,a0,-1482 # 8001e2c0 <icache>
    80003892:	ffffd097          	auipc	ra,0xffffd
    80003896:	272080e7          	jalr	626(ra) # 80000b04 <acquire>
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    8000389a:	4498                	lw	a4,8(s1)
    8000389c:	4785                	li	a5,1
    8000389e:	02f70263          	beq	a4,a5,800038c2 <iput+0x44>
  ip->ref--;
    800038a2:	449c                	lw	a5,8(s1)
    800038a4:	37fd                	addiw	a5,a5,-1
    800038a6:	c49c                	sw	a5,8(s1)
  release(&icache.lock);
    800038a8:	0001b517          	auipc	a0,0x1b
    800038ac:	a1850513          	addi	a0,a0,-1512 # 8001e2c0 <icache>
    800038b0:	ffffd097          	auipc	ra,0xffffd
    800038b4:	318080e7          	jalr	792(ra) # 80000bc8 <release>
}
    800038b8:	70e2                	ld	ra,56(sp)
    800038ba:	7442                	ld	s0,48(sp)
    800038bc:	74a2                	ld	s1,40(sp)
    800038be:	6121                	addi	sp,sp,64
    800038c0:	8082                	ret
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    800038c2:	44bc                	lw	a5,72(s1)
    800038c4:	dff9                	beqz	a5,800038a2 <iput+0x24>
    800038c6:	05249783          	lh	a5,82(s1)
    800038ca:	ffe1                	bnez	a5,800038a2 <iput+0x24>
    800038cc:	f04a                	sd	s2,32(sp)
    800038ce:	ec4e                	sd	s3,24(sp)
    800038d0:	e852                	sd	s4,16(sp)
    acquiresleep(&ip->lock);
    800038d2:	01048793          	addi	a5,s1,16
    800038d6:	8a3e                	mv	s4,a5
    800038d8:	853e                	mv	a0,a5
    800038da:	00001097          	auipc	ra,0x1
    800038de:	c68080e7          	jalr	-920(ra) # 80004542 <acquiresleep>
    release(&icache.lock);
    800038e2:	0001b517          	auipc	a0,0x1b
    800038e6:	9de50513          	addi	a0,a0,-1570 # 8001e2c0 <icache>
    800038ea:	ffffd097          	auipc	ra,0xffffd
    800038ee:	2de080e7          	jalr	734(ra) # 80000bc8 <release>
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
    800038f2:	05848913          	addi	s2,s1,88
    800038f6:	08848993          	addi	s3,s1,136
    800038fa:	a021                	j	80003902 <iput+0x84>
    800038fc:	0911                	addi	s2,s2,4
    800038fe:	01390d63          	beq	s2,s3,80003918 <iput+0x9a>
    if(ip->addrs[i]){
    80003902:	00092583          	lw	a1,0(s2)
    80003906:	d9fd                	beqz	a1,800038fc <iput+0x7e>
      bfree(ip->dev, ip->addrs[i]);
    80003908:	4088                	lw	a0,0(s1)
    8000390a:	00000097          	auipc	ra,0x0
    8000390e:	8d6080e7          	jalr	-1834(ra) # 800031e0 <bfree>
      ip->addrs[i] = 0;
    80003912:	00092023          	sw	zero,0(s2)
    80003916:	b7dd                	j	800038fc <iput+0x7e>
    }
  }

  if(ip->addrs[NDIRECT]){
    80003918:	0884a583          	lw	a1,136(s1)
    8000391c:	e1b1                	bnez	a1,80003960 <iput+0xe2>
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
    8000391e:	0404aa23          	sw	zero,84(s1)
  iupdate(ip);
    80003922:	8526                	mv	a0,s1
    80003924:	00000097          	auipc	ra,0x0
    80003928:	d7c080e7          	jalr	-644(ra) # 800036a0 <iupdate>
    ip->type = 0;
    8000392c:	04049623          	sh	zero,76(s1)
    iupdate(ip);
    80003930:	8526                	mv	a0,s1
    80003932:	00000097          	auipc	ra,0x0
    80003936:	d6e080e7          	jalr	-658(ra) # 800036a0 <iupdate>
    ip->valid = 0;
    8000393a:	0404a423          	sw	zero,72(s1)
    releasesleep(&ip->lock);
    8000393e:	8552                	mv	a0,s4
    80003940:	00001097          	auipc	ra,0x1
    80003944:	c58080e7          	jalr	-936(ra) # 80004598 <releasesleep>
    acquire(&icache.lock);
    80003948:	0001b517          	auipc	a0,0x1b
    8000394c:	97850513          	addi	a0,a0,-1672 # 8001e2c0 <icache>
    80003950:	ffffd097          	auipc	ra,0xffffd
    80003954:	1b4080e7          	jalr	436(ra) # 80000b04 <acquire>
    80003958:	7902                	ld	s2,32(sp)
    8000395a:	69e2                	ld	s3,24(sp)
    8000395c:	6a42                	ld	s4,16(sp)
    8000395e:	b791                	j	800038a2 <iput+0x24>
    80003960:	e456                	sd	s5,8(sp)
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    80003962:	4088                	lw	a0,0(s1)
    80003964:	fffff097          	auipc	ra,0xfffff
    80003968:	638080e7          	jalr	1592(ra) # 80002f9c <bread>
    8000396c:	8aaa                	mv	s5,a0
    for(j = 0; j < NINDIRECT; j++){
    8000396e:	06050913          	addi	s2,a0,96
    80003972:	46050993          	addi	s3,a0,1120
    80003976:	a809                	j	80003988 <iput+0x10a>
        bfree(ip->dev, a[j]);
    80003978:	4088                	lw	a0,0(s1)
    8000397a:	00000097          	auipc	ra,0x0
    8000397e:	866080e7          	jalr	-1946(ra) # 800031e0 <bfree>
    for(j = 0; j < NINDIRECT; j++){
    80003982:	0911                	addi	s2,s2,4
    80003984:	01390663          	beq	s2,s3,80003990 <iput+0x112>
      if(a[j])
    80003988:	00092583          	lw	a1,0(s2)
    8000398c:	d9fd                	beqz	a1,80003982 <iput+0x104>
    8000398e:	b7ed                	j	80003978 <iput+0xfa>
    brelse(bp);
    80003990:	8556                	mv	a0,s5
    80003992:	fffff097          	auipc	ra,0xfffff
    80003996:	73e080e7          	jalr	1854(ra) # 800030d0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    8000399a:	0884a583          	lw	a1,136(s1)
    8000399e:	4088                	lw	a0,0(s1)
    800039a0:	00000097          	auipc	ra,0x0
    800039a4:	840080e7          	jalr	-1984(ra) # 800031e0 <bfree>
    ip->addrs[NDIRECT] = 0;
    800039a8:	0804a423          	sw	zero,136(s1)
    800039ac:	6aa2                	ld	s5,8(sp)
    800039ae:	bf85                	j	8000391e <iput+0xa0>

00000000800039b0 <iunlockput>:
{
    800039b0:	1101                	addi	sp,sp,-32
    800039b2:	ec06                	sd	ra,24(sp)
    800039b4:	e822                	sd	s0,16(sp)
    800039b6:	e426                	sd	s1,8(sp)
    800039b8:	1000                	addi	s0,sp,32
    800039ba:	84aa                	mv	s1,a0
  iunlock(ip);
    800039bc:	00000097          	auipc	ra,0x0
    800039c0:	e76080e7          	jalr	-394(ra) # 80003832 <iunlock>
  iput(ip);
    800039c4:	8526                	mv	a0,s1
    800039c6:	00000097          	auipc	ra,0x0
    800039ca:	eb8080e7          	jalr	-328(ra) # 8000387e <iput>
}
    800039ce:	60e2                	ld	ra,24(sp)
    800039d0:	6442                	ld	s0,16(sp)
    800039d2:	64a2                	ld	s1,8(sp)
    800039d4:	6105                	addi	sp,sp,32
    800039d6:	8082                	ret

00000000800039d8 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
    800039d8:	1141                	addi	sp,sp,-16
    800039da:	e406                	sd	ra,8(sp)
    800039dc:	e022                	sd	s0,0(sp)
    800039de:	0800                	addi	s0,sp,16
  st->dev = ip->dev;
    800039e0:	411c                	lw	a5,0(a0)
    800039e2:	c19c                	sw	a5,0(a1)
  st->ino = ip->inum;
    800039e4:	415c                	lw	a5,4(a0)
    800039e6:	c1dc                	sw	a5,4(a1)
  st->type = ip->type;
    800039e8:	04c51783          	lh	a5,76(a0)
    800039ec:	00f59423          	sh	a5,8(a1)
  st->nlink = ip->nlink;
    800039f0:	05251783          	lh	a5,82(a0)
    800039f4:	00f59523          	sh	a5,10(a1)
  st->size = ip->size;
    800039f8:	05456783          	lwu	a5,84(a0)
    800039fc:	e99c                	sd	a5,16(a1)
}
    800039fe:	60a2                	ld	ra,8(sp)
    80003a00:	6402                	ld	s0,0(sp)
    80003a02:	0141                	addi	sp,sp,16
    80003a04:	8082                	ret

0000000080003a06 <readi>:
readi(struct inode *ip, int user_dst, uint64 dst, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    80003a06:	497c                	lw	a5,84(a0)
    80003a08:	0ed7e763          	bltu	a5,a3,80003af6 <readi+0xf0>
{
    80003a0c:	7159                	addi	sp,sp,-112
    80003a0e:	f486                	sd	ra,104(sp)
    80003a10:	f0a2                	sd	s0,96(sp)
    80003a12:	e8ca                	sd	s2,80(sp)
    80003a14:	fc56                	sd	s5,56(sp)
    80003a16:	f45e                	sd	s7,40(sp)
    80003a18:	f062                	sd	s8,32(sp)
    80003a1a:	ec66                	sd	s9,24(sp)
    80003a1c:	1880                	addi	s0,sp,112
    80003a1e:	8c2a                	mv	s8,a0
    80003a20:	8cae                	mv	s9,a1
    80003a22:	8ab2                	mv	s5,a2
    80003a24:	8936                	mv	s2,a3
    80003a26:	8bba                	mv	s7,a4
  if(off > ip->size || off + n < off)
    80003a28:	9f35                	addw	a4,a4,a3
    80003a2a:	0cd76863          	bltu	a4,a3,80003afa <readi+0xf4>
    return -1;
  if(off + n > ip->size)
    80003a2e:	00e7f463          	bgeu	a5,a4,80003a36 <readi+0x30>
    n = ip->size - off;
    80003a32:	40d78bbb          	subw	s7,a5,a3

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80003a36:	080b8f63          	beqz	s7,80003ad4 <readi+0xce>
    80003a3a:	eca6                	sd	s1,88(sp)
    80003a3c:	e4ce                	sd	s3,72(sp)
    80003a3e:	e0d2                	sd	s4,64(sp)
    80003a40:	f85a                	sd	s6,48(sp)
    80003a42:	e86a                	sd	s10,16(sp)
    80003a44:	e46e                	sd	s11,8(sp)
    80003a46:	4a01                	li	s4,0
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    80003a48:	40000d93          	li	s11,1024
    if(either_copyout(user_dst, dst, bp->data + (off % BSIZE), m) == -1) {
    80003a4c:	5d7d                	li	s10,-1
    80003a4e:	a82d                	j	80003a88 <readi+0x82>
    80003a50:	02099b13          	slli	s6,s3,0x20
    80003a54:	020b5b13          	srli	s6,s6,0x20
    80003a58:	06048613          	addi	a2,s1,96
    80003a5c:	86da                	mv	a3,s6
    80003a5e:	963e                	add	a2,a2,a5
    80003a60:	85d6                	mv	a1,s5
    80003a62:	8566                	mv	a0,s9
    80003a64:	fffff097          	auipc	ra,0xfffff
    80003a68:	ab4080e7          	jalr	-1356(ra) # 80002518 <either_copyout>
    80003a6c:	05a50963          	beq	a0,s10,80003abe <readi+0xb8>
      brelse(bp);
      break;
    }
    brelse(bp);
    80003a70:	8526                	mv	a0,s1
    80003a72:	fffff097          	auipc	ra,0xfffff
    80003a76:	65e080e7          	jalr	1630(ra) # 800030d0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80003a7a:	01498a3b          	addw	s4,s3,s4
    80003a7e:	0129893b          	addw	s2,s3,s2
    80003a82:	9ada                	add	s5,s5,s6
    80003a84:	077a7263          	bgeu	s4,s7,80003ae8 <readi+0xe2>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    80003a88:	000c2483          	lw	s1,0(s8) # 2000 <_entry-0x7fffe000>
    80003a8c:	00a9559b          	srliw	a1,s2,0xa
    80003a90:	8562                	mv	a0,s8
    80003a92:	00000097          	auipc	ra,0x0
    80003a96:	8e0080e7          	jalr	-1824(ra) # 80003372 <bmap>
    80003a9a:	85aa                	mv	a1,a0
    80003a9c:	8526                	mv	a0,s1
    80003a9e:	fffff097          	auipc	ra,0xfffff
    80003aa2:	4fe080e7          	jalr	1278(ra) # 80002f9c <bread>
    80003aa6:	84aa                	mv	s1,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    80003aa8:	3ff97793          	andi	a5,s2,1023
    80003aac:	40fd873b          	subw	a4,s11,a5
    80003ab0:	414b86bb          	subw	a3,s7,s4
    80003ab4:	89ba                	mv	s3,a4
    80003ab6:	f8e6fde3          	bgeu	a3,a4,80003a50 <readi+0x4a>
    80003aba:	89b6                	mv	s3,a3
    80003abc:	bf51                	j	80003a50 <readi+0x4a>
      brelse(bp);
    80003abe:	8526                	mv	a0,s1
    80003ac0:	fffff097          	auipc	ra,0xfffff
    80003ac4:	610080e7          	jalr	1552(ra) # 800030d0 <brelse>
      break;
    80003ac8:	64e6                	ld	s1,88(sp)
    80003aca:	69a6                	ld	s3,72(sp)
    80003acc:	6a06                	ld	s4,64(sp)
    80003ace:	7b42                	ld	s6,48(sp)
    80003ad0:	6d42                	ld	s10,16(sp)
    80003ad2:	6da2                	ld	s11,8(sp)
  }
  return n;
    80003ad4:	855e                	mv	a0,s7
}
    80003ad6:	70a6                	ld	ra,104(sp)
    80003ad8:	7406                	ld	s0,96(sp)
    80003ada:	6946                	ld	s2,80(sp)
    80003adc:	7ae2                	ld	s5,56(sp)
    80003ade:	7ba2                	ld	s7,40(sp)
    80003ae0:	7c02                	ld	s8,32(sp)
    80003ae2:	6ce2                	ld	s9,24(sp)
    80003ae4:	6165                	addi	sp,sp,112
    80003ae6:	8082                	ret
    80003ae8:	64e6                	ld	s1,88(sp)
    80003aea:	69a6                	ld	s3,72(sp)
    80003aec:	6a06                	ld	s4,64(sp)
    80003aee:	7b42                	ld	s6,48(sp)
    80003af0:	6d42                	ld	s10,16(sp)
    80003af2:	6da2                	ld	s11,8(sp)
    80003af4:	b7c5                	j	80003ad4 <readi+0xce>
    return -1;
    80003af6:	557d                	li	a0,-1
}
    80003af8:	8082                	ret
    return -1;
    80003afa:	557d                	li	a0,-1
    80003afc:	bfe9                	j	80003ad6 <readi+0xd0>

0000000080003afe <writei>:
writei(struct inode *ip, int user_src, uint64 src, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    80003afe:	497c                	lw	a5,84(a0)
    80003b00:	10d7e163          	bltu	a5,a3,80003c02 <writei+0x104>
{
    80003b04:	7159                	addi	sp,sp,-112
    80003b06:	f486                	sd	ra,104(sp)
    80003b08:	f0a2                	sd	s0,96(sp)
    80003b0a:	e8ca                	sd	s2,80(sp)
    80003b0c:	fc56                	sd	s5,56(sp)
    80003b0e:	f45e                	sd	s7,40(sp)
    80003b10:	f062                	sd	s8,32(sp)
    80003b12:	ec66                	sd	s9,24(sp)
    80003b14:	1880                	addi	s0,sp,112
    80003b16:	8c2a                	mv	s8,a0
    80003b18:	8cae                	mv	s9,a1
    80003b1a:	8ab2                	mv	s5,a2
    80003b1c:	8936                	mv	s2,a3
    80003b1e:	8bba                	mv	s7,a4
  if(off > ip->size || off + n < off)
    80003b20:	00e687bb          	addw	a5,a3,a4
    return -1;
  if(off + n > MAXFILE*BSIZE)
    80003b24:	00043737          	lui	a4,0x43
    80003b28:	0cf76f63          	bltu	a4,a5,80003c06 <writei+0x108>
    80003b2c:	0cd7ed63          	bltu	a5,a3,80003c06 <writei+0x108>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80003b30:	0a0b8f63          	beqz	s7,80003bee <writei+0xf0>
    80003b34:	eca6                	sd	s1,88(sp)
    80003b36:	e4ce                	sd	s3,72(sp)
    80003b38:	e0d2                	sd	s4,64(sp)
    80003b3a:	f85a                	sd	s6,48(sp)
    80003b3c:	e86a                	sd	s10,16(sp)
    80003b3e:	e46e                	sd	s11,8(sp)
    80003b40:	4a01                	li	s4,0
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    80003b42:	40000d93          	li	s11,1024
    if(either_copyin(bp->data + (off % BSIZE), user_src, src, m) == -1) {
    80003b46:	5d7d                	li	s10,-1
    80003b48:	a091                	j	80003b8c <writei+0x8e>
    80003b4a:	02099b13          	slli	s6,s3,0x20
    80003b4e:	020b5b13          	srli	s6,s6,0x20
    80003b52:	06048513          	addi	a0,s1,96
    80003b56:	86da                	mv	a3,s6
    80003b58:	8656                	mv	a2,s5
    80003b5a:	85e6                	mv	a1,s9
    80003b5c:	953e                	add	a0,a0,a5
    80003b5e:	fffff097          	auipc	ra,0xfffff
    80003b62:	a10080e7          	jalr	-1520(ra) # 8000256e <either_copyin>
    80003b66:	05a50e63          	beq	a0,s10,80003bc2 <writei+0xc4>
      brelse(bp);
      break;
    }
    log_write(bp);
    80003b6a:	8526                	mv	a0,s1
    80003b6c:	00001097          	auipc	ra,0x1
    80003b70:	856080e7          	jalr	-1962(ra) # 800043c2 <log_write>
    brelse(bp);
    80003b74:	8526                	mv	a0,s1
    80003b76:	fffff097          	auipc	ra,0xfffff
    80003b7a:	55a080e7          	jalr	1370(ra) # 800030d0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80003b7e:	01498a3b          	addw	s4,s3,s4
    80003b82:	0129893b          	addw	s2,s3,s2
    80003b86:	9ada                	add	s5,s5,s6
    80003b88:	057a7263          	bgeu	s4,s7,80003bcc <writei+0xce>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    80003b8c:	000c2483          	lw	s1,0(s8)
    80003b90:	00a9559b          	srliw	a1,s2,0xa
    80003b94:	8562                	mv	a0,s8
    80003b96:	fffff097          	auipc	ra,0xfffff
    80003b9a:	7dc080e7          	jalr	2012(ra) # 80003372 <bmap>
    80003b9e:	85aa                	mv	a1,a0
    80003ba0:	8526                	mv	a0,s1
    80003ba2:	fffff097          	auipc	ra,0xfffff
    80003ba6:	3fa080e7          	jalr	1018(ra) # 80002f9c <bread>
    80003baa:	84aa                	mv	s1,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    80003bac:	3ff97793          	andi	a5,s2,1023
    80003bb0:	40fd873b          	subw	a4,s11,a5
    80003bb4:	414b86bb          	subw	a3,s7,s4
    80003bb8:	89ba                	mv	s3,a4
    80003bba:	f8e6f8e3          	bgeu	a3,a4,80003b4a <writei+0x4c>
    80003bbe:	89b6                	mv	s3,a3
    80003bc0:	b769                	j	80003b4a <writei+0x4c>
      brelse(bp);
    80003bc2:	8526                	mv	a0,s1
    80003bc4:	fffff097          	auipc	ra,0xfffff
    80003bc8:	50c080e7          	jalr	1292(ra) # 800030d0 <brelse>
  }

  if(n > 0){
    if(off > ip->size)
    80003bcc:	054c2783          	lw	a5,84(s8)
    80003bd0:	0127f463          	bgeu	a5,s2,80003bd8 <writei+0xda>
      ip->size = off;
    80003bd4:	052c2a23          	sw	s2,84(s8)
    // write the i-node back to disk even if the size didn't change
    // because the loop above might have called bmap() and added a new
    // block to ip->addrs[].
    iupdate(ip);
    80003bd8:	8562                	mv	a0,s8
    80003bda:	00000097          	auipc	ra,0x0
    80003bde:	ac6080e7          	jalr	-1338(ra) # 800036a0 <iupdate>
    80003be2:	64e6                	ld	s1,88(sp)
    80003be4:	69a6                	ld	s3,72(sp)
    80003be6:	6a06                	ld	s4,64(sp)
    80003be8:	7b42                	ld	s6,48(sp)
    80003bea:	6d42                	ld	s10,16(sp)
    80003bec:	6da2                	ld	s11,8(sp)
  }

  return n;
    80003bee:	855e                	mv	a0,s7
}
    80003bf0:	70a6                	ld	ra,104(sp)
    80003bf2:	7406                	ld	s0,96(sp)
    80003bf4:	6946                	ld	s2,80(sp)
    80003bf6:	7ae2                	ld	s5,56(sp)
    80003bf8:	7ba2                	ld	s7,40(sp)
    80003bfa:	7c02                	ld	s8,32(sp)
    80003bfc:	6ce2                	ld	s9,24(sp)
    80003bfe:	6165                	addi	sp,sp,112
    80003c00:	8082                	ret
    return -1;
    80003c02:	557d                	li	a0,-1
}
    80003c04:	8082                	ret
    return -1;
    80003c06:	557d                	li	a0,-1
    80003c08:	b7e5                	j	80003bf0 <writei+0xf2>

0000000080003c0a <namecmp>:

// Directories

int
namecmp(const char *s, const char *t)
{
    80003c0a:	1141                	addi	sp,sp,-16
    80003c0c:	e406                	sd	ra,8(sp)
    80003c0e:	e022                	sd	s0,0(sp)
    80003c10:	0800                	addi	s0,sp,16
  return strncmp(s, t, DIRSIZ);
    80003c12:	4639                	li	a2,14
    80003c14:	ffffd097          	auipc	ra,0xffffd
    80003c18:	284080e7          	jalr	644(ra) # 80000e98 <strncmp>
}
    80003c1c:	60a2                	ld	ra,8(sp)
    80003c1e:	6402                	ld	s0,0(sp)
    80003c20:	0141                	addi	sp,sp,16
    80003c22:	8082                	ret

0000000080003c24 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
    80003c24:	711d                	addi	sp,sp,-96
    80003c26:	ec86                	sd	ra,88(sp)
    80003c28:	e8a2                	sd	s0,80(sp)
    80003c2a:	e4a6                	sd	s1,72(sp)
    80003c2c:	e0ca                	sd	s2,64(sp)
    80003c2e:	fc4e                	sd	s3,56(sp)
    80003c30:	f852                	sd	s4,48(sp)
    80003c32:	f456                	sd	s5,40(sp)
    80003c34:	f05a                	sd	s6,32(sp)
    80003c36:	ec5e                	sd	s7,24(sp)
    80003c38:	1080                	addi	s0,sp,96
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    80003c3a:	04c51703          	lh	a4,76(a0)
    80003c3e:	4785                	li	a5,1
    80003c40:	00f71f63          	bne	a4,a5,80003c5e <dirlookup+0x3a>
    80003c44:	892a                	mv	s2,a0
    80003c46:	8aae                	mv	s5,a1
    80003c48:	8bb2                	mv	s7,a2
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
    80003c4a:	497c                	lw	a5,84(a0)
    80003c4c:	4481                	li	s1,0
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80003c4e:	fa040a13          	addi	s4,s0,-96
    80003c52:	49c1                	li	s3,16
      panic("dirlookup read");
    if(de.inum == 0)
      continue;
    if(namecmp(name, de.name) == 0){
    80003c54:	fa240b13          	addi	s6,s0,-94
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
    80003c58:	4501                	li	a0,0
  for(off = 0; off < dp->size; off += sizeof(de)){
    80003c5a:	e79d                	bnez	a5,80003c88 <dirlookup+0x64>
    80003c5c:	a88d                	j	80003cce <dirlookup+0xaa>
    panic("dirlookup not DIR");
    80003c5e:	00005517          	auipc	a0,0x5
    80003c62:	d3250513          	addi	a0,a0,-718 # 80008990 <userret+0x900>
    80003c66:	ffffd097          	auipc	ra,0xffffd
    80003c6a:	904080e7          	jalr	-1788(ra) # 8000056a <panic>
      panic("dirlookup read");
    80003c6e:	00005517          	auipc	a0,0x5
    80003c72:	d3a50513          	addi	a0,a0,-710 # 800089a8 <userret+0x918>
    80003c76:	ffffd097          	auipc	ra,0xffffd
    80003c7a:	8f4080e7          	jalr	-1804(ra) # 8000056a <panic>
  for(off = 0; off < dp->size; off += sizeof(de)){
    80003c7e:	24c1                	addiw	s1,s1,16
    80003c80:	05492783          	lw	a5,84(s2)
    80003c84:	04f4f463          	bgeu	s1,a5,80003ccc <dirlookup+0xa8>
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80003c88:	874e                	mv	a4,s3
    80003c8a:	86a6                	mv	a3,s1
    80003c8c:	8652                	mv	a2,s4
    80003c8e:	4581                	li	a1,0
    80003c90:	854a                	mv	a0,s2
    80003c92:	00000097          	auipc	ra,0x0
    80003c96:	d74080e7          	jalr	-652(ra) # 80003a06 <readi>
    80003c9a:	fd351ae3          	bne	a0,s3,80003c6e <dirlookup+0x4a>
    if(de.inum == 0)
    80003c9e:	fa045783          	lhu	a5,-96(s0)
    80003ca2:	dff1                	beqz	a5,80003c7e <dirlookup+0x5a>
    if(namecmp(name, de.name) == 0){
    80003ca4:	85da                	mv	a1,s6
    80003ca6:	8556                	mv	a0,s5
    80003ca8:	00000097          	auipc	ra,0x0
    80003cac:	f62080e7          	jalr	-158(ra) # 80003c0a <namecmp>
    80003cb0:	f579                	bnez	a0,80003c7e <dirlookup+0x5a>
      if(poff)
    80003cb2:	000b8463          	beqz	s7,80003cba <dirlookup+0x96>
        *poff = off;
    80003cb6:	009ba023          	sw	s1,0(s7)
      return iget(dp->dev, inum);
    80003cba:	fa045583          	lhu	a1,-96(s0)
    80003cbe:	00092503          	lw	a0,0(s2)
    80003cc2:	fffff097          	auipc	ra,0xfffff
    80003cc6:	77e080e7          	jalr	1918(ra) # 80003440 <iget>
    80003cca:	a011                	j	80003cce <dirlookup+0xaa>
  return 0;
    80003ccc:	4501                	li	a0,0
}
    80003cce:	60e6                	ld	ra,88(sp)
    80003cd0:	6446                	ld	s0,80(sp)
    80003cd2:	64a6                	ld	s1,72(sp)
    80003cd4:	6906                	ld	s2,64(sp)
    80003cd6:	79e2                	ld	s3,56(sp)
    80003cd8:	7a42                	ld	s4,48(sp)
    80003cda:	7aa2                	ld	s5,40(sp)
    80003cdc:	7b02                	ld	s6,32(sp)
    80003cde:	6be2                	ld	s7,24(sp)
    80003ce0:	6125                	addi	sp,sp,96
    80003ce2:	8082                	ret

0000000080003ce4 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
    80003ce4:	711d                	addi	sp,sp,-96
    80003ce6:	ec86                	sd	ra,88(sp)
    80003ce8:	e8a2                	sd	s0,80(sp)
    80003cea:	e4a6                	sd	s1,72(sp)
    80003cec:	e0ca                	sd	s2,64(sp)
    80003cee:	fc4e                	sd	s3,56(sp)
    80003cf0:	f852                	sd	s4,48(sp)
    80003cf2:	f456                	sd	s5,40(sp)
    80003cf4:	f05a                	sd	s6,32(sp)
    80003cf6:	ec5e                	sd	s7,24(sp)
    80003cf8:	e862                	sd	s8,16(sp)
    80003cfa:	e466                	sd	s9,8(sp)
    80003cfc:	e06a                	sd	s10,0(sp)
    80003cfe:	1080                	addi	s0,sp,96
    80003d00:	84aa                	mv	s1,a0
    80003d02:	8b2e                	mv	s6,a1
    80003d04:	8ab2                	mv	s5,a2
  struct inode *ip, *next;

  if(*path == '/')
    80003d06:	00054703          	lbu	a4,0(a0)
    80003d0a:	02f00793          	li	a5,47
    80003d0e:	02f70363          	beq	a4,a5,80003d34 <namex+0x50>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
    80003d12:	ffffe097          	auipc	ra,0xffffe
    80003d16:	dee080e7          	jalr	-530(ra) # 80001b00 <myproc>
    80003d1a:	15853503          	ld	a0,344(a0)
    80003d1e:	00000097          	auipc	ra,0x0
    80003d22:	a10080e7          	jalr	-1520(ra) # 8000372e <idup>
    80003d26:	8a2a                	mv	s4,a0
  while(*path == '/')
    80003d28:	02f00993          	li	s3,47
  if(len >= DIRSIZ)
    80003d2c:	4c35                	li	s8,13
    memmove(name, s, DIRSIZ);
    80003d2e:	4cb9                	li	s9,14

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
    if(ip->type != T_DIR){
    80003d30:	4b85                	li	s7,1
    80003d32:	a87d                	j	80003df0 <namex+0x10c>
    ip = iget(ROOTDEV, ROOTINO);
    80003d34:	4585                	li	a1,1
    80003d36:	4501                	li	a0,0
    80003d38:	fffff097          	auipc	ra,0xfffff
    80003d3c:	708080e7          	jalr	1800(ra) # 80003440 <iget>
    80003d40:	8a2a                	mv	s4,a0
    80003d42:	b7dd                	j	80003d28 <namex+0x44>
      iunlockput(ip);
    80003d44:	8552                	mv	a0,s4
    80003d46:	00000097          	auipc	ra,0x0
    80003d4a:	c6a080e7          	jalr	-918(ra) # 800039b0 <iunlockput>
      return 0;
    80003d4e:	4a01                	li	s4,0
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
    80003d50:	8552                	mv	a0,s4
    80003d52:	60e6                	ld	ra,88(sp)
    80003d54:	6446                	ld	s0,80(sp)
    80003d56:	64a6                	ld	s1,72(sp)
    80003d58:	6906                	ld	s2,64(sp)
    80003d5a:	79e2                	ld	s3,56(sp)
    80003d5c:	7a42                	ld	s4,48(sp)
    80003d5e:	7aa2                	ld	s5,40(sp)
    80003d60:	7b02                	ld	s6,32(sp)
    80003d62:	6be2                	ld	s7,24(sp)
    80003d64:	6c42                	ld	s8,16(sp)
    80003d66:	6ca2                	ld	s9,8(sp)
    80003d68:	6d02                	ld	s10,0(sp)
    80003d6a:	6125                	addi	sp,sp,96
    80003d6c:	8082                	ret
      iunlock(ip);
    80003d6e:	8552                	mv	a0,s4
    80003d70:	00000097          	auipc	ra,0x0
    80003d74:	ac2080e7          	jalr	-1342(ra) # 80003832 <iunlock>
      return ip;
    80003d78:	bfe1                	j	80003d50 <namex+0x6c>
      iunlockput(ip);
    80003d7a:	8552                	mv	a0,s4
    80003d7c:	00000097          	auipc	ra,0x0
    80003d80:	c34080e7          	jalr	-972(ra) # 800039b0 <iunlockput>
      return 0;
    80003d84:	8a4a                	mv	s4,s2
    80003d86:	b7e9                	j	80003d50 <namex+0x6c>
  len = path - s;
    80003d88:	40990633          	sub	a2,s2,s1
    80003d8c:	00060d1b          	sext.w	s10,a2
  if(len >= DIRSIZ)
    80003d90:	09ac5c63          	bge	s8,s10,80003e28 <namex+0x144>
    memmove(name, s, DIRSIZ);
    80003d94:	8666                	mv	a2,s9
    80003d96:	85a6                	mv	a1,s1
    80003d98:	8556                	mv	a0,s5
    80003d9a:	ffffd097          	auipc	ra,0xffffd
    80003d9e:	084080e7          	jalr	132(ra) # 80000e1e <memmove>
    80003da2:	84ca                	mv	s1,s2
  while(*path == '/')
    80003da4:	0004c783          	lbu	a5,0(s1)
    80003da8:	01379763          	bne	a5,s3,80003db6 <namex+0xd2>
    path++;
    80003dac:	0485                	addi	s1,s1,1
  while(*path == '/')
    80003dae:	0004c783          	lbu	a5,0(s1)
    80003db2:	ff378de3          	beq	a5,s3,80003dac <namex+0xc8>
    ilock(ip);
    80003db6:	8552                	mv	a0,s4
    80003db8:	00000097          	auipc	ra,0x0
    80003dbc:	9b4080e7          	jalr	-1612(ra) # 8000376c <ilock>
    if(ip->type != T_DIR){
    80003dc0:	04ca1783          	lh	a5,76(s4)
    80003dc4:	f97790e3          	bne	a5,s7,80003d44 <namex+0x60>
    if(nameiparent && *path == '\0'){
    80003dc8:	000b0563          	beqz	s6,80003dd2 <namex+0xee>
    80003dcc:	0004c783          	lbu	a5,0(s1)
    80003dd0:	dfd9                	beqz	a5,80003d6e <namex+0x8a>
    if((next = dirlookup(ip, name, 0)) == 0){
    80003dd2:	4601                	li	a2,0
    80003dd4:	85d6                	mv	a1,s5
    80003dd6:	8552                	mv	a0,s4
    80003dd8:	00000097          	auipc	ra,0x0
    80003ddc:	e4c080e7          	jalr	-436(ra) # 80003c24 <dirlookup>
    80003de0:	892a                	mv	s2,a0
    80003de2:	dd41                	beqz	a0,80003d7a <namex+0x96>
    iunlockput(ip);
    80003de4:	8552                	mv	a0,s4
    80003de6:	00000097          	auipc	ra,0x0
    80003dea:	bca080e7          	jalr	-1078(ra) # 800039b0 <iunlockput>
    ip = next;
    80003dee:	8a4a                	mv	s4,s2
  while(*path == '/')
    80003df0:	0004c783          	lbu	a5,0(s1)
    80003df4:	01379763          	bne	a5,s3,80003e02 <namex+0x11e>
    path++;
    80003df8:	0485                	addi	s1,s1,1
  while(*path == '/')
    80003dfa:	0004c783          	lbu	a5,0(s1)
    80003dfe:	ff378de3          	beq	a5,s3,80003df8 <namex+0x114>
  if(*path == 0)
    80003e02:	cf9d                	beqz	a5,80003e40 <namex+0x15c>
  while(*path != '/' && *path != 0)
    80003e04:	0004c783          	lbu	a5,0(s1)
    80003e08:	fd178713          	addi	a4,a5,-47
    80003e0c:	cb19                	beqz	a4,80003e22 <namex+0x13e>
    80003e0e:	cb91                	beqz	a5,80003e22 <namex+0x13e>
    80003e10:	8926                	mv	s2,s1
    path++;
    80003e12:	0905                	addi	s2,s2,1
  while(*path != '/' && *path != 0)
    80003e14:	00094783          	lbu	a5,0(s2)
    80003e18:	fd178713          	addi	a4,a5,-47
    80003e1c:	d735                	beqz	a4,80003d88 <namex+0xa4>
    80003e1e:	fbf5                	bnez	a5,80003e12 <namex+0x12e>
    80003e20:	b7a5                	j	80003d88 <namex+0xa4>
    80003e22:	8926                	mv	s2,s1
  len = path - s;
    80003e24:	4d01                	li	s10,0
    80003e26:	4601                	li	a2,0
    memmove(name, s, len);
    80003e28:	2601                	sext.w	a2,a2
    80003e2a:	85a6                	mv	a1,s1
    80003e2c:	8556                	mv	a0,s5
    80003e2e:	ffffd097          	auipc	ra,0xffffd
    80003e32:	ff0080e7          	jalr	-16(ra) # 80000e1e <memmove>
    name[len] = 0;
    80003e36:	9d56                	add	s10,s10,s5
    80003e38:	000d0023          	sb	zero,0(s10)
    80003e3c:	84ca                	mv	s1,s2
    80003e3e:	b79d                	j	80003da4 <namex+0xc0>
  if(nameiparent){
    80003e40:	f00b08e3          	beqz	s6,80003d50 <namex+0x6c>
    iput(ip);
    80003e44:	8552                	mv	a0,s4
    80003e46:	00000097          	auipc	ra,0x0
    80003e4a:	a38080e7          	jalr	-1480(ra) # 8000387e <iput>
    return 0;
    80003e4e:	4a01                	li	s4,0
    80003e50:	b701                	j	80003d50 <namex+0x6c>

0000000080003e52 <dirlink>:
{
    80003e52:	715d                	addi	sp,sp,-80
    80003e54:	e486                	sd	ra,72(sp)
    80003e56:	e0a2                	sd	s0,64(sp)
    80003e58:	f84a                	sd	s2,48(sp)
    80003e5a:	ec56                	sd	s5,24(sp)
    80003e5c:	e85a                	sd	s6,16(sp)
    80003e5e:	0880                	addi	s0,sp,80
    80003e60:	892a                	mv	s2,a0
    80003e62:	8aae                	mv	s5,a1
    80003e64:	8b32                	mv	s6,a2
  if((ip = dirlookup(dp, name, 0)) != 0){
    80003e66:	4601                	li	a2,0
    80003e68:	00000097          	auipc	ra,0x0
    80003e6c:	dbc080e7          	jalr	-580(ra) # 80003c24 <dirlookup>
    80003e70:	e129                	bnez	a0,80003eb2 <dirlink+0x60>
    80003e72:	fc26                	sd	s1,56(sp)
  for(off = 0; off < dp->size; off += sizeof(de)){
    80003e74:	05492483          	lw	s1,84(s2)
    80003e78:	cca9                	beqz	s1,80003ed2 <dirlink+0x80>
    80003e7a:	f44e                	sd	s3,40(sp)
    80003e7c:	f052                	sd	s4,32(sp)
    80003e7e:	4481                	li	s1,0
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80003e80:	fb040a13          	addi	s4,s0,-80
    80003e84:	49c1                	li	s3,16
    80003e86:	874e                	mv	a4,s3
    80003e88:	86a6                	mv	a3,s1
    80003e8a:	8652                	mv	a2,s4
    80003e8c:	4581                	li	a1,0
    80003e8e:	854a                	mv	a0,s2
    80003e90:	00000097          	auipc	ra,0x0
    80003e94:	b76080e7          	jalr	-1162(ra) # 80003a06 <readi>
    80003e98:	03351363          	bne	a0,s3,80003ebe <dirlink+0x6c>
    if(de.inum == 0)
    80003e9c:	fb045783          	lhu	a5,-80(s0)
    80003ea0:	c79d                	beqz	a5,80003ece <dirlink+0x7c>
  for(off = 0; off < dp->size; off += sizeof(de)){
    80003ea2:	24c1                	addiw	s1,s1,16
    80003ea4:	05492783          	lw	a5,84(s2)
    80003ea8:	fcf4efe3          	bltu	s1,a5,80003e86 <dirlink+0x34>
    80003eac:	79a2                	ld	s3,40(sp)
    80003eae:	7a02                	ld	s4,32(sp)
    80003eb0:	a00d                	j	80003ed2 <dirlink+0x80>
    iput(ip);
    80003eb2:	00000097          	auipc	ra,0x0
    80003eb6:	9cc080e7          	jalr	-1588(ra) # 8000387e <iput>
    return -1;
    80003eba:	557d                	li	a0,-1
    80003ebc:	a0a9                	j	80003f06 <dirlink+0xb4>
      panic("dirlink read");
    80003ebe:	00005517          	auipc	a0,0x5
    80003ec2:	afa50513          	addi	a0,a0,-1286 # 800089b8 <userret+0x928>
    80003ec6:	ffffc097          	auipc	ra,0xffffc
    80003eca:	6a4080e7          	jalr	1700(ra) # 8000056a <panic>
    80003ece:	79a2                	ld	s3,40(sp)
    80003ed0:	7a02                	ld	s4,32(sp)
  strncpy(de.name, name, DIRSIZ);
    80003ed2:	4639                	li	a2,14
    80003ed4:	85d6                	mv	a1,s5
    80003ed6:	fb240513          	addi	a0,s0,-78
    80003eda:	ffffd097          	auipc	ra,0xffffd
    80003ede:	ff8080e7          	jalr	-8(ra) # 80000ed2 <strncpy>
  de.inum = inum;
    80003ee2:	fb641823          	sh	s6,-80(s0)
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80003ee6:	4741                	li	a4,16
    80003ee8:	86a6                	mv	a3,s1
    80003eea:	fb040613          	addi	a2,s0,-80
    80003eee:	4581                	li	a1,0
    80003ef0:	854a                	mv	a0,s2
    80003ef2:	00000097          	auipc	ra,0x0
    80003ef6:	c0c080e7          	jalr	-1012(ra) # 80003afe <writei>
    80003efa:	872a                	mv	a4,a0
    80003efc:	47c1                	li	a5,16
  return 0;
    80003efe:	4501                	li	a0,0
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80003f00:	00f71a63          	bne	a4,a5,80003f14 <dirlink+0xc2>
    80003f04:	74e2                	ld	s1,56(sp)
}
    80003f06:	60a6                	ld	ra,72(sp)
    80003f08:	6406                	ld	s0,64(sp)
    80003f0a:	7942                	ld	s2,48(sp)
    80003f0c:	6ae2                	ld	s5,24(sp)
    80003f0e:	6b42                	ld	s6,16(sp)
    80003f10:	6161                	addi	sp,sp,80
    80003f12:	8082                	ret
    80003f14:	f44e                	sd	s3,40(sp)
    80003f16:	f052                	sd	s4,32(sp)
    panic("dirlink");
    80003f18:	00005517          	auipc	a0,0x5
    80003f1c:	bc050513          	addi	a0,a0,-1088 # 80008ad8 <userret+0xa48>
    80003f20:	ffffc097          	auipc	ra,0xffffc
    80003f24:	64a080e7          	jalr	1610(ra) # 8000056a <panic>

0000000080003f28 <namei>:

struct inode*
namei(char *path)
{
    80003f28:	1101                	addi	sp,sp,-32
    80003f2a:	ec06                	sd	ra,24(sp)
    80003f2c:	e822                	sd	s0,16(sp)
    80003f2e:	1000                	addi	s0,sp,32
  char name[DIRSIZ];
  return namex(path, 0, name);
    80003f30:	fe040613          	addi	a2,s0,-32
    80003f34:	4581                	li	a1,0
    80003f36:	00000097          	auipc	ra,0x0
    80003f3a:	dae080e7          	jalr	-594(ra) # 80003ce4 <namex>
}
    80003f3e:	60e2                	ld	ra,24(sp)
    80003f40:	6442                	ld	s0,16(sp)
    80003f42:	6105                	addi	sp,sp,32
    80003f44:	8082                	ret

0000000080003f46 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
    80003f46:	1141                	addi	sp,sp,-16
    80003f48:	e406                	sd	ra,8(sp)
    80003f4a:	e022                	sd	s0,0(sp)
    80003f4c:	0800                	addi	s0,sp,16
    80003f4e:	862e                	mv	a2,a1
  return namex(path, 1, name);
    80003f50:	4585                	li	a1,1
    80003f52:	00000097          	auipc	ra,0x0
    80003f56:	d92080e7          	jalr	-622(ra) # 80003ce4 <namex>
}
    80003f5a:	60a2                	ld	ra,8(sp)
    80003f5c:	6402                	ld	s0,0(sp)
    80003f5e:	0141                	addi	sp,sp,16
    80003f60:	8082                	ret

0000000080003f62 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(int dev)
{
    80003f62:	7179                	addi	sp,sp,-48
    80003f64:	f406                	sd	ra,40(sp)
    80003f66:	f022                	sd	s0,32(sp)
    80003f68:	ec26                	sd	s1,24(sp)
    80003f6a:	e84a                	sd	s2,16(sp)
    80003f6c:	e44e                	sd	s3,8(sp)
    80003f6e:	1800                	addi	s0,sp,48
    80003f70:	84aa                	mv	s1,a0
  struct buf *buf = bread(dev, log[dev].start);
    80003f72:	0b000793          	li	a5,176
    80003f76:	02f507b3          	mul	a5,a0,a5
    80003f7a:	0001c997          	auipc	s3,0x1c
    80003f7e:	f8698993          	addi	s3,s3,-122 # 8001ff00 <log>
    80003f82:	99be                	add	s3,s3,a5
    80003f84:	0209a583          	lw	a1,32(s3)
    80003f88:	fffff097          	auipc	ra,0xfffff
    80003f8c:	014080e7          	jalr	20(ra) # 80002f9c <bread>
    80003f90:	892a                	mv	s2,a0
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log[dev].lh.n;
    80003f92:	0349a783          	lw	a5,52(s3)
    80003f96:	d13c                	sw	a5,96(a0)
  for (i = 0; i < log[dev].lh.n; i++) {
    80003f98:	0349a783          	lw	a5,52(s3)
    80003f9c:	02f05763          	blez	a5,80003fca <write_head+0x68>
    80003fa0:	0b000793          	li	a5,176
    80003fa4:	02f487b3          	mul	a5,s1,a5
    80003fa8:	0001c717          	auipc	a4,0x1c
    80003fac:	f9070713          	addi	a4,a4,-112 # 8001ff38 <log+0x38>
    80003fb0:	97ba                	add	a5,a5,a4
    80003fb2:	06450693          	addi	a3,a0,100
    80003fb6:	4701                	li	a4,0
    80003fb8:	85ce                	mv	a1,s3
    hb->block[i] = log[dev].lh.block[i];
    80003fba:	4390                	lw	a2,0(a5)
    80003fbc:	c290                	sw	a2,0(a3)
  for (i = 0; i < log[dev].lh.n; i++) {
    80003fbe:	2705                	addiw	a4,a4,1
    80003fc0:	0791                	addi	a5,a5,4
    80003fc2:	0691                	addi	a3,a3,4
    80003fc4:	59d0                	lw	a2,52(a1)
    80003fc6:	fec74ae3          	blt	a4,a2,80003fba <write_head+0x58>
  }
  bwrite(buf);
    80003fca:	854a                	mv	a0,s2
    80003fcc:	fffff097          	auipc	ra,0xfffff
    80003fd0:	0c4080e7          	jalr	196(ra) # 80003090 <bwrite>
  brelse(buf);
    80003fd4:	854a                	mv	a0,s2
    80003fd6:	fffff097          	auipc	ra,0xfffff
    80003fda:	0fa080e7          	jalr	250(ra) # 800030d0 <brelse>
}
    80003fde:	70a2                	ld	ra,40(sp)
    80003fe0:	7402                	ld	s0,32(sp)
    80003fe2:	64e2                	ld	s1,24(sp)
    80003fe4:	6942                	ld	s2,16(sp)
    80003fe6:	69a2                	ld	s3,8(sp)
    80003fe8:	6145                	addi	sp,sp,48
    80003fea:	8082                	ret

0000000080003fec <install_trans>:
  for (tail = 0; tail < log[dev].lh.n; tail++) {
    80003fec:	0b000713          	li	a4,176
    80003ff0:	02e50733          	mul	a4,a0,a4
    80003ff4:	0001c797          	auipc	a5,0x1c
    80003ff8:	f0c78793          	addi	a5,a5,-244 # 8001ff00 <log>
    80003ffc:	97ba                	add	a5,a5,a4
    80003ffe:	5bdc                	lw	a5,52(a5)
    80004000:	0af05d63          	blez	a5,800040ba <install_trans+0xce>
{
    80004004:	715d                	addi	sp,sp,-80
    80004006:	e486                	sd	ra,72(sp)
    80004008:	e0a2                	sd	s0,64(sp)
    8000400a:	fc26                	sd	s1,56(sp)
    8000400c:	f84a                	sd	s2,48(sp)
    8000400e:	f44e                	sd	s3,40(sp)
    80004010:	f052                	sd	s4,32(sp)
    80004012:	ec56                	sd	s5,24(sp)
    80004014:	e85a                	sd	s6,16(sp)
    80004016:	e45e                	sd	s7,8(sp)
    80004018:	0880                	addi	s0,sp,80
    8000401a:	8aaa                	mv	s5,a0
    8000401c:	0001c797          	auipc	a5,0x1c
    80004020:	f1c78793          	addi	a5,a5,-228 # 8001ff38 <log+0x38>
    80004024:	00f70a33          	add	s4,a4,a5
  for (tail = 0; tail < log[dev].lh.n; tail++) {
    80004028:	4981                	li	s3,0
    struct buf *lbuf = bread(dev, log[dev].start+tail+1); // read log block
    8000402a:	0001cb17          	auipc	s6,0x1c
    8000402e:	ed6b0b13          	addi	s6,s6,-298 # 8001ff00 <log>
    80004032:	9b3a                	add	s6,s6,a4
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    80004034:	40000b93          	li	s7,1024
    struct buf *lbuf = bread(dev, log[dev].start+tail+1); // read log block
    80004038:	020b2583          	lw	a1,32(s6)
    8000403c:	013585bb          	addw	a1,a1,s3
    80004040:	2585                	addiw	a1,a1,1
    80004042:	8556                	mv	a0,s5
    80004044:	fffff097          	auipc	ra,0xfffff
    80004048:	f58080e7          	jalr	-168(ra) # 80002f9c <bread>
    8000404c:	892a                	mv	s2,a0
    struct buf *dbuf = bread(dev, log[dev].lh.block[tail]); // read dst
    8000404e:	000a2583          	lw	a1,0(s4)
    80004052:	8556                	mv	a0,s5
    80004054:	fffff097          	auipc	ra,0xfffff
    80004058:	f48080e7          	jalr	-184(ra) # 80002f9c <bread>
    8000405c:	84aa                	mv	s1,a0
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    8000405e:	865e                	mv	a2,s7
    80004060:	06090593          	addi	a1,s2,96
    80004064:	06050513          	addi	a0,a0,96
    80004068:	ffffd097          	auipc	ra,0xffffd
    8000406c:	db6080e7          	jalr	-586(ra) # 80000e1e <memmove>
    bwrite(dbuf);  // write dst to disk
    80004070:	8526                	mv	a0,s1
    80004072:	fffff097          	auipc	ra,0xfffff
    80004076:	01e080e7          	jalr	30(ra) # 80003090 <bwrite>
    bunpin(dbuf);
    8000407a:	8526                	mv	a0,s1
    8000407c:	fffff097          	auipc	ra,0xfffff
    80004080:	128080e7          	jalr	296(ra) # 800031a4 <bunpin>
    brelse(lbuf);
    80004084:	854a                	mv	a0,s2
    80004086:	fffff097          	auipc	ra,0xfffff
    8000408a:	04a080e7          	jalr	74(ra) # 800030d0 <brelse>
    brelse(dbuf);
    8000408e:	8526                	mv	a0,s1
    80004090:	fffff097          	auipc	ra,0xfffff
    80004094:	040080e7          	jalr	64(ra) # 800030d0 <brelse>
  for (tail = 0; tail < log[dev].lh.n; tail++) {
    80004098:	2985                	addiw	s3,s3,1
    8000409a:	0a11                	addi	s4,s4,4
    8000409c:	034b2783          	lw	a5,52(s6)
    800040a0:	f8f9cce3          	blt	s3,a5,80004038 <install_trans+0x4c>
}
    800040a4:	60a6                	ld	ra,72(sp)
    800040a6:	6406                	ld	s0,64(sp)
    800040a8:	74e2                	ld	s1,56(sp)
    800040aa:	7942                	ld	s2,48(sp)
    800040ac:	79a2                	ld	s3,40(sp)
    800040ae:	7a02                	ld	s4,32(sp)
    800040b0:	6ae2                	ld	s5,24(sp)
    800040b2:	6b42                	ld	s6,16(sp)
    800040b4:	6ba2                	ld	s7,8(sp)
    800040b6:	6161                	addi	sp,sp,80
    800040b8:	8082                	ret
    800040ba:	8082                	ret

00000000800040bc <initlog>:
{
    800040bc:	7179                	addi	sp,sp,-48
    800040be:	f406                	sd	ra,40(sp)
    800040c0:	f022                	sd	s0,32(sp)
    800040c2:	ec26                	sd	s1,24(sp)
    800040c4:	e84a                	sd	s2,16(sp)
    800040c6:	e44e                	sd	s3,8(sp)
    800040c8:	e052                	sd	s4,0(sp)
    800040ca:	1800                	addi	s0,sp,48
    800040cc:	84aa                	mv	s1,a0
    800040ce:	89ae                	mv	s3,a1
  initlock(&log[dev].lock, "log");
    800040d0:	0b000a13          	li	s4,176
    800040d4:	03450a33          	mul	s4,a0,s4
    800040d8:	0001c917          	auipc	s2,0x1c
    800040dc:	e2890913          	addi	s2,s2,-472 # 8001ff00 <log>
    800040e0:	9952                	add	s2,s2,s4
    800040e2:	00005597          	auipc	a1,0x5
    800040e6:	8e658593          	addi	a1,a1,-1818 # 800089c8 <userret+0x938>
    800040ea:	854a                	mv	a0,s2
    800040ec:	ffffd097          	auipc	ra,0xffffd
    800040f0:	944080e7          	jalr	-1724(ra) # 80000a30 <initlock>
  log[dev].start = sb->logstart;
    800040f4:	0149a583          	lw	a1,20(s3)
    800040f8:	02b92023          	sw	a1,32(s2)
  log[dev].size = sb->nlog;
    800040fc:	0109a783          	lw	a5,16(s3)
    80004100:	02f92223          	sw	a5,36(s2)
  log[dev].dev = dev;
    80004104:	02992823          	sw	s1,48(s2)
  struct buf *buf = bread(dev, log[dev].start);
    80004108:	8526                	mv	a0,s1
    8000410a:	fffff097          	auipc	ra,0xfffff
    8000410e:	e92080e7          	jalr	-366(ra) # 80002f9c <bread>
  log[dev].lh.n = lh->n;
    80004112:	5130                	lw	a2,96(a0)
    80004114:	02c92a23          	sw	a2,52(s2)
  for (i = 0; i < log[dev].lh.n; i++) {
    80004118:	02c05063          	blez	a2,80004138 <initlog+0x7c>
    8000411c:	87aa                	mv	a5,a0
    8000411e:	0001c717          	auipc	a4,0x1c
    80004122:	e1a70713          	addi	a4,a4,-486 # 8001ff38 <log+0x38>
    80004126:	9752                	add	a4,a4,s4
    80004128:	060a                	slli	a2,a2,0x2
    8000412a:	962a                	add	a2,a2,a0
    log[dev].lh.block[i] = lh->block[i];
    8000412c:	53f4                	lw	a3,100(a5)
    8000412e:	c314                	sw	a3,0(a4)
  for (i = 0; i < log[dev].lh.n; i++) {
    80004130:	0791                	addi	a5,a5,4
    80004132:	0711                	addi	a4,a4,4
    80004134:	fec79ce3          	bne	a5,a2,8000412c <initlog+0x70>
  brelse(buf);
    80004138:	fffff097          	auipc	ra,0xfffff
    8000413c:	f98080e7          	jalr	-104(ra) # 800030d0 <brelse>

static void
recover_from_log(int dev)
{
  read_head(dev);
  install_trans(dev); // if committed, copy from log to disk
    80004140:	8526                	mv	a0,s1
    80004142:	00000097          	auipc	ra,0x0
    80004146:	eaa080e7          	jalr	-342(ra) # 80003fec <install_trans>
  log[dev].lh.n = 0;
    8000414a:	0b000713          	li	a4,176
    8000414e:	02e48733          	mul	a4,s1,a4
    80004152:	0001c797          	auipc	a5,0x1c
    80004156:	dae78793          	addi	a5,a5,-594 # 8001ff00 <log>
    8000415a:	97ba                	add	a5,a5,a4
    8000415c:	0207aa23          	sw	zero,52(a5)
  write_head(dev); // clear the log
    80004160:	8526                	mv	a0,s1
    80004162:	00000097          	auipc	ra,0x0
    80004166:	e00080e7          	jalr	-512(ra) # 80003f62 <write_head>
}
    8000416a:	70a2                	ld	ra,40(sp)
    8000416c:	7402                	ld	s0,32(sp)
    8000416e:	64e2                	ld	s1,24(sp)
    80004170:	6942                	ld	s2,16(sp)
    80004172:	69a2                	ld	s3,8(sp)
    80004174:	6a02                	ld	s4,0(sp)
    80004176:	6145                	addi	sp,sp,48
    80004178:	8082                	ret

000000008000417a <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(int dev)
{
    8000417a:	7139                	addi	sp,sp,-64
    8000417c:	fc06                	sd	ra,56(sp)
    8000417e:	f822                	sd	s0,48(sp)
    80004180:	f426                	sd	s1,40(sp)
    80004182:	f04a                	sd	s2,32(sp)
    80004184:	ec4e                	sd	s3,24(sp)
    80004186:	e852                	sd	s4,16(sp)
    80004188:	e456                	sd	s5,8(sp)
    8000418a:	0080                	addi	s0,sp,64
    8000418c:	8aaa                	mv	s5,a0
  acquire(&log[dev].lock);
    8000418e:	0b000793          	li	a5,176
    80004192:	02f507b3          	mul	a5,a0,a5
    80004196:	0001c917          	auipc	s2,0x1c
    8000419a:	d6a90913          	addi	s2,s2,-662 # 8001ff00 <log>
    8000419e:	993e                	add	s2,s2,a5
    800041a0:	854a                	mv	a0,s2
    800041a2:	ffffd097          	auipc	ra,0xffffd
    800041a6:	962080e7          	jalr	-1694(ra) # 80000b04 <acquire>
  while(1){
    if(log[dev].committing){
    800041aa:	0001c997          	auipc	s3,0x1c
    800041ae:	d5698993          	addi	s3,s3,-682 # 8001ff00 <log>
    800041b2:	84ca                	mv	s1,s2
      sleep(&log, &log[dev].lock);
    } else if(log[dev].lh.n + (log[dev].outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    800041b4:	4a79                	li	s4,30
    800041b6:	a039                	j	800041c4 <begin_op+0x4a>
      sleep(&log, &log[dev].lock);
    800041b8:	85ca                	mv	a1,s2
    800041ba:	854e                	mv	a0,s3
    800041bc:	ffffe097          	auipc	ra,0xffffe
    800041c0:	108080e7          	jalr	264(ra) # 800022c4 <sleep>
    if(log[dev].committing){
    800041c4:	54dc                	lw	a5,44(s1)
    800041c6:	fbed                	bnez	a5,800041b8 <begin_op+0x3e>
    } else if(log[dev].lh.n + (log[dev].outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    800041c8:	5498                	lw	a4,40(s1)
    800041ca:	2705                	addiw	a4,a4,1
    800041cc:	0027179b          	slliw	a5,a4,0x2
    800041d0:	9fb9                	addw	a5,a5,a4
    800041d2:	0017979b          	slliw	a5,a5,0x1
    800041d6:	58d4                	lw	a3,52(s1)
    800041d8:	9fb5                	addw	a5,a5,a3
    800041da:	00fa5963          	bge	s4,a5,800041ec <begin_op+0x72>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log[dev].lock);
    800041de:	85ca                	mv	a1,s2
    800041e0:	854e                	mv	a0,s3
    800041e2:	ffffe097          	auipc	ra,0xffffe
    800041e6:	0e2080e7          	jalr	226(ra) # 800022c4 <sleep>
    800041ea:	bfe9                	j	800041c4 <begin_op+0x4a>
    } else {
      log[dev].outstanding += 1;
    800041ec:	0b000793          	li	a5,176
    800041f0:	02fa8ab3          	mul	s5,s5,a5
    800041f4:	0001c797          	auipc	a5,0x1c
    800041f8:	d0c78793          	addi	a5,a5,-756 # 8001ff00 <log>
    800041fc:	97d6                	add	a5,a5,s5
    800041fe:	d798                	sw	a4,40(a5)
      release(&log[dev].lock);
    80004200:	854a                	mv	a0,s2
    80004202:	ffffd097          	auipc	ra,0xffffd
    80004206:	9c6080e7          	jalr	-1594(ra) # 80000bc8 <release>
      break;
    }
  }
}
    8000420a:	70e2                	ld	ra,56(sp)
    8000420c:	7442                	ld	s0,48(sp)
    8000420e:	74a2                	ld	s1,40(sp)
    80004210:	7902                	ld	s2,32(sp)
    80004212:	69e2                	ld	s3,24(sp)
    80004214:	6a42                	ld	s4,16(sp)
    80004216:	6aa2                	ld	s5,8(sp)
    80004218:	6121                	addi	sp,sp,64
    8000421a:	8082                	ret

000000008000421c <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(int dev)
{
    8000421c:	715d                	addi	sp,sp,-80
    8000421e:	e486                	sd	ra,72(sp)
    80004220:	e0a2                	sd	s0,64(sp)
    80004222:	fc26                	sd	s1,56(sp)
    80004224:	f84a                	sd	s2,48(sp)
    80004226:	f44e                	sd	s3,40(sp)
    80004228:	f052                	sd	s4,32(sp)
    8000422a:	0880                	addi	s0,sp,80
    8000422c:	892a                	mv	s2,a0
  int do_commit = 0;

  acquire(&log[dev].lock);
    8000422e:	0b000993          	li	s3,176
    80004232:	033509b3          	mul	s3,a0,s3
    80004236:	0001c497          	auipc	s1,0x1c
    8000423a:	cca48493          	addi	s1,s1,-822 # 8001ff00 <log>
    8000423e:	94ce                	add	s1,s1,s3
    80004240:	8526                	mv	a0,s1
    80004242:	ffffd097          	auipc	ra,0xffffd
    80004246:	8c2080e7          	jalr	-1854(ra) # 80000b04 <acquire>
  log[dev].outstanding -= 1;
    8000424a:	549c                	lw	a5,40(s1)
    8000424c:	37fd                	addiw	a5,a5,-1
    8000424e:	8a3e                	mv	s4,a5
    80004250:	d49c                	sw	a5,40(s1)
  if(log[dev].committing)
    80004252:	54dc                	lw	a5,44(s1)
    80004254:	eba5                	bnez	a5,800042c4 <end_op+0xa8>
    panic("log[dev].committing");
  if(log[dev].outstanding == 0){
    80004256:	080a1263          	bnez	s4,800042da <end_op+0xbe>
    8000425a:	ec56                	sd	s5,24(sp)
    do_commit = 1;
    log[dev].committing = 1;
    8000425c:	0b000793          	li	a5,176
    80004260:	02f907b3          	mul	a5,s2,a5
    80004264:	0001ca97          	auipc	s5,0x1c
    80004268:	c9ca8a93          	addi	s5,s5,-868 # 8001ff00 <log>
    8000426c:	9abe                	add	s5,s5,a5
    8000426e:	4785                	li	a5,1
    80004270:	02faa623          	sw	a5,44(s5)
    // begin_op() may be waiting for log space,
    // and decrementing log[dev].outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log[dev].lock);
    80004274:	8526                	mv	a0,s1
    80004276:	ffffd097          	auipc	ra,0xffffd
    8000427a:	952080e7          	jalr	-1710(ra) # 80000bc8 <release>
}

static void
commit(int dev)
{
  if (log[dev].lh.n > 0) {
    8000427e:	034aa783          	lw	a5,52(s5)
    80004282:	08f04163          	bgtz	a5,80004304 <end_op+0xe8>
    acquire(&log[dev].lock);
    80004286:	8526                	mv	a0,s1
    80004288:	ffffd097          	auipc	ra,0xffffd
    8000428c:	87c080e7          	jalr	-1924(ra) # 80000b04 <acquire>
    log[dev].committing = 0;
    80004290:	0b000793          	li	a5,176
    80004294:	02f90933          	mul	s2,s2,a5
    80004298:	0001c797          	auipc	a5,0x1c
    8000429c:	c6878793          	addi	a5,a5,-920 # 8001ff00 <log>
    800042a0:	97ca                	add	a5,a5,s2
    800042a2:	0207a623          	sw	zero,44(a5)
    wakeup(&log);
    800042a6:	0001c517          	auipc	a0,0x1c
    800042aa:	c5a50513          	addi	a0,a0,-934 # 8001ff00 <log>
    800042ae:	ffffe097          	auipc	ra,0xffffe
    800042b2:	190080e7          	jalr	400(ra) # 8000243e <wakeup>
    release(&log[dev].lock);
    800042b6:	8526                	mv	a0,s1
    800042b8:	ffffd097          	auipc	ra,0xffffd
    800042bc:	910080e7          	jalr	-1776(ra) # 80000bc8 <release>
    800042c0:	6ae2                	ld	s5,24(sp)
}
    800042c2:	a80d                	j	800042f4 <end_op+0xd8>
    800042c4:	ec56                	sd	s5,24(sp)
    800042c6:	e85a                	sd	s6,16(sp)
    800042c8:	e45e                	sd	s7,8(sp)
    panic("log[dev].committing");
    800042ca:	00004517          	auipc	a0,0x4
    800042ce:	70650513          	addi	a0,a0,1798 # 800089d0 <userret+0x940>
    800042d2:	ffffc097          	auipc	ra,0xffffc
    800042d6:	298080e7          	jalr	664(ra) # 8000056a <panic>
    wakeup(&log);
    800042da:	0001c517          	auipc	a0,0x1c
    800042de:	c2650513          	addi	a0,a0,-986 # 8001ff00 <log>
    800042e2:	ffffe097          	auipc	ra,0xffffe
    800042e6:	15c080e7          	jalr	348(ra) # 8000243e <wakeup>
  release(&log[dev].lock);
    800042ea:	8526                	mv	a0,s1
    800042ec:	ffffd097          	auipc	ra,0xffffd
    800042f0:	8dc080e7          	jalr	-1828(ra) # 80000bc8 <release>
}
    800042f4:	60a6                	ld	ra,72(sp)
    800042f6:	6406                	ld	s0,64(sp)
    800042f8:	74e2                	ld	s1,56(sp)
    800042fa:	7942                	ld	s2,48(sp)
    800042fc:	79a2                	ld	s3,40(sp)
    800042fe:	7a02                	ld	s4,32(sp)
    80004300:	6161                	addi	sp,sp,80
    80004302:	8082                	ret
    80004304:	e85a                	sd	s6,16(sp)
    80004306:	e45e                	sd	s7,8(sp)
  for (tail = 0; tail < log[dev].lh.n; tail++) {
    80004308:	0001cb17          	auipc	s6,0x1c
    8000430c:	c30b0b13          	addi	s6,s6,-976 # 8001ff38 <log+0x38>
    80004310:	9b4e                	add	s6,s6,s3
    struct buf *to = bread(dev, log[dev].start+tail+1); // log block
    80004312:	0b000793          	li	a5,176
    80004316:	02f907b3          	mul	a5,s2,a5
    8000431a:	0001cb97          	auipc	s7,0x1c
    8000431e:	be6b8b93          	addi	s7,s7,-1050 # 8001ff00 <log>
    80004322:	9bbe                	add	s7,s7,a5
    80004324:	020ba583          	lw	a1,32(s7)
    80004328:	014585bb          	addw	a1,a1,s4
    8000432c:	2585                	addiw	a1,a1,1
    8000432e:	854a                	mv	a0,s2
    80004330:	fffff097          	auipc	ra,0xfffff
    80004334:	c6c080e7          	jalr	-916(ra) # 80002f9c <bread>
    80004338:	89aa                	mv	s3,a0
    struct buf *from = bread(dev, log[dev].lh.block[tail]); // cache block
    8000433a:	000b2583          	lw	a1,0(s6)
    8000433e:	854a                	mv	a0,s2
    80004340:	fffff097          	auipc	ra,0xfffff
    80004344:	c5c080e7          	jalr	-932(ra) # 80002f9c <bread>
    80004348:	8aaa                	mv	s5,a0
    memmove(to->data, from->data, BSIZE);
    8000434a:	40000613          	li	a2,1024
    8000434e:	06050593          	addi	a1,a0,96
    80004352:	06098513          	addi	a0,s3,96
    80004356:	ffffd097          	auipc	ra,0xffffd
    8000435a:	ac8080e7          	jalr	-1336(ra) # 80000e1e <memmove>
    bwrite(to);  // write the log
    8000435e:	854e                	mv	a0,s3
    80004360:	fffff097          	auipc	ra,0xfffff
    80004364:	d30080e7          	jalr	-720(ra) # 80003090 <bwrite>
    brelse(from);
    80004368:	8556                	mv	a0,s5
    8000436a:	fffff097          	auipc	ra,0xfffff
    8000436e:	d66080e7          	jalr	-666(ra) # 800030d0 <brelse>
    brelse(to);
    80004372:	854e                	mv	a0,s3
    80004374:	fffff097          	auipc	ra,0xfffff
    80004378:	d5c080e7          	jalr	-676(ra) # 800030d0 <brelse>
  for (tail = 0; tail < log[dev].lh.n; tail++) {
    8000437c:	2a05                	addiw	s4,s4,1
    8000437e:	0b11                	addi	s6,s6,4
    80004380:	034ba783          	lw	a5,52(s7)
    80004384:	fafa40e3          	blt	s4,a5,80004324 <end_op+0x108>
    write_log(dev);     // Write modified blocks from cache to log
    write_head(dev);    // Write header to disk -- the real commit
    80004388:	854a                	mv	a0,s2
    8000438a:	00000097          	auipc	ra,0x0
    8000438e:	bd8080e7          	jalr	-1064(ra) # 80003f62 <write_head>
    install_trans(dev); // Now install writes to home locations
    80004392:	854a                	mv	a0,s2
    80004394:	00000097          	auipc	ra,0x0
    80004398:	c58080e7          	jalr	-936(ra) # 80003fec <install_trans>
    log[dev].lh.n = 0;
    8000439c:	0b000713          	li	a4,176
    800043a0:	02e90733          	mul	a4,s2,a4
    800043a4:	0001c797          	auipc	a5,0x1c
    800043a8:	b5c78793          	addi	a5,a5,-1188 # 8001ff00 <log>
    800043ac:	97ba                	add	a5,a5,a4
    800043ae:	0207aa23          	sw	zero,52(a5)
    write_head(dev);    // Erase the transaction from the log
    800043b2:	854a                	mv	a0,s2
    800043b4:	00000097          	auipc	ra,0x0
    800043b8:	bae080e7          	jalr	-1106(ra) # 80003f62 <write_head>
    800043bc:	6b42                	ld	s6,16(sp)
    800043be:	6ba2                	ld	s7,8(sp)
    800043c0:	b5d9                	j	80004286 <end_op+0x6a>

00000000800043c2 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
    800043c2:	7179                	addi	sp,sp,-48
    800043c4:	f406                	sd	ra,40(sp)
    800043c6:	f022                	sd	s0,32(sp)
    800043c8:	ec26                	sd	s1,24(sp)
    800043ca:	e84a                	sd	s2,16(sp)
    800043cc:	e44e                	sd	s3,8(sp)
    800043ce:	e052                	sd	s4,0(sp)
    800043d0:	1800                	addi	s0,sp,48
  int i;

  int dev = b->dev;
    800043d2:	4504                	lw	s1,8(a0)
  if (log[dev].lh.n >= LOGSIZE || log[dev].lh.n >= log[dev].size - 1)
    800043d4:	0b000713          	li	a4,176
    800043d8:	02e48733          	mul	a4,s1,a4
    800043dc:	0001c797          	auipc	a5,0x1c
    800043e0:	b2478793          	addi	a5,a5,-1244 # 8001ff00 <log>
    800043e4:	97ba                	add	a5,a5,a4
    800043e6:	5bd4                	lw	a3,52(a5)
    800043e8:	47f5                	li	a5,29
    800043ea:	0ad7cf63          	blt	a5,a3,800044a8 <log_write+0xe6>
    800043ee:	892a                	mv	s2,a0
    800043f0:	0b000713          	li	a4,176
    800043f4:	02e48733          	mul	a4,s1,a4
    800043f8:	0001c797          	auipc	a5,0x1c
    800043fc:	b0878793          	addi	a5,a5,-1272 # 8001ff00 <log>
    80004400:	97ba                	add	a5,a5,a4
    80004402:	53dc                	lw	a5,36(a5)
    80004404:	37fd                	addiw	a5,a5,-1
    80004406:	0af6d163          	bge	a3,a5,800044a8 <log_write+0xe6>
    panic("too big a transaction");
  if (log[dev].outstanding < 1)
    8000440a:	0b000713          	li	a4,176
    8000440e:	02e48733          	mul	a4,s1,a4
    80004412:	0001c797          	auipc	a5,0x1c
    80004416:	aee78793          	addi	a5,a5,-1298 # 8001ff00 <log>
    8000441a:	97ba                	add	a5,a5,a4
    8000441c:	579c                	lw	a5,40(a5)
    8000441e:	08f05d63          	blez	a5,800044b8 <log_write+0xf6>
    panic("log_write outside of trans");

  acquire(&log[dev].lock);
    80004422:	0b000a13          	li	s4,176
    80004426:	03448a33          	mul	s4,s1,s4
    8000442a:	0001c997          	auipc	s3,0x1c
    8000442e:	ad698993          	addi	s3,s3,-1322 # 8001ff00 <log>
    80004432:	99d2                	add	s3,s3,s4
    80004434:	854e                	mv	a0,s3
    80004436:	ffffc097          	auipc	ra,0xffffc
    8000443a:	6ce080e7          	jalr	1742(ra) # 80000b04 <acquire>
  for (i = 0; i < log[dev].lh.n; i++) {
    8000443e:	0349a603          	lw	a2,52(s3)
    80004442:	08c05363          	blez	a2,800044c8 <log_write+0x106>
    if (log[dev].lh.block[i] == b->blockno)   // log absorbtion
    80004446:	00c92583          	lw	a1,12(s2)
    8000444a:	0001c797          	auipc	a5,0x1c
    8000444e:	aee78793          	addi	a5,a5,-1298 # 8001ff38 <log+0x38>
    80004452:	97d2                	add	a5,a5,s4
  for (i = 0; i < log[dev].lh.n; i++) {
    80004454:	4701                	li	a4,0
    if (log[dev].lh.block[i] == b->blockno)   // log absorbtion
    80004456:	4394                	lw	a3,0(a5)
    80004458:	06b68963          	beq	a3,a1,800044ca <log_write+0x108>
  for (i = 0; i < log[dev].lh.n; i++) {
    8000445c:	2705                	addiw	a4,a4,1
    8000445e:	0791                	addi	a5,a5,4
    80004460:	fec71be3          	bne	a4,a2,80004456 <log_write+0x94>
      break;
  }
  log[dev].lh.block[i] = b->blockno;
    80004464:	02c00793          	li	a5,44
    80004468:	02f487b3          	mul	a5,s1,a5
    8000446c:	97b2                	add	a5,a5,a2
    8000446e:	078a                	slli	a5,a5,0x2
    80004470:	03078793          	addi	a5,a5,48
    80004474:	0001c717          	auipc	a4,0x1c
    80004478:	a8c70713          	addi	a4,a4,-1396 # 8001ff00 <log>
    8000447c:	97ba                	add	a5,a5,a4
    8000447e:	00c92703          	lw	a4,12(s2)
    80004482:	c798                	sw	a4,8(a5)
  if (i == log[dev].lh.n) {  // Add new block to log?
    bpin(b);
    80004484:	854a                	mv	a0,s2
    80004486:	fffff097          	auipc	ra,0xfffff
    8000448a:	ce2080e7          	jalr	-798(ra) # 80003168 <bpin>
    log[dev].lh.n++;
    8000448e:	0b000713          	li	a4,176
    80004492:	02e48733          	mul	a4,s1,a4
    80004496:	0001c797          	auipc	a5,0x1c
    8000449a:	a6a78793          	addi	a5,a5,-1430 # 8001ff00 <log>
    8000449e:	97ba                	add	a5,a5,a4
    800044a0:	5bd8                	lw	a4,52(a5)
    800044a2:	2705                	addiw	a4,a4,1
    800044a4:	dbd8                	sw	a4,52(a5)
    800044a6:	a0a1                	j	800044ee <log_write+0x12c>
    panic("too big a transaction");
    800044a8:	00004517          	auipc	a0,0x4
    800044ac:	54050513          	addi	a0,a0,1344 # 800089e8 <userret+0x958>
    800044b0:	ffffc097          	auipc	ra,0xffffc
    800044b4:	0ba080e7          	jalr	186(ra) # 8000056a <panic>
    panic("log_write outside of trans");
    800044b8:	00004517          	auipc	a0,0x4
    800044bc:	54850513          	addi	a0,a0,1352 # 80008a00 <userret+0x970>
    800044c0:	ffffc097          	auipc	ra,0xffffc
    800044c4:	0aa080e7          	jalr	170(ra) # 8000056a <panic>
  for (i = 0; i < log[dev].lh.n; i++) {
    800044c8:	4701                	li	a4,0
  log[dev].lh.block[i] = b->blockno;
    800044ca:	02c00793          	li	a5,44
    800044ce:	02f487b3          	mul	a5,s1,a5
    800044d2:	97ba                	add	a5,a5,a4
    800044d4:	078a                	slli	a5,a5,0x2
    800044d6:	03078793          	addi	a5,a5,48
    800044da:	0001c697          	auipc	a3,0x1c
    800044de:	a2668693          	addi	a3,a3,-1498 # 8001ff00 <log>
    800044e2:	97b6                	add	a5,a5,a3
    800044e4:	00c92683          	lw	a3,12(s2)
    800044e8:	c794                	sw	a3,8(a5)
  if (i == log[dev].lh.n) {  // Add new block to log?
    800044ea:	f8e60de3          	beq	a2,a4,80004484 <log_write+0xc2>
  }
  release(&log[dev].lock);
    800044ee:	854e                	mv	a0,s3
    800044f0:	ffffc097          	auipc	ra,0xffffc
    800044f4:	6d8080e7          	jalr	1752(ra) # 80000bc8 <release>
}
    800044f8:	70a2                	ld	ra,40(sp)
    800044fa:	7402                	ld	s0,32(sp)
    800044fc:	64e2                	ld	s1,24(sp)
    800044fe:	6942                	ld	s2,16(sp)
    80004500:	69a2                	ld	s3,8(sp)
    80004502:	6a02                	ld	s4,0(sp)
    80004504:	6145                	addi	sp,sp,48
    80004506:	8082                	ret

0000000080004508 <initsleeplock>:
#include "proc.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
    80004508:	1101                	addi	sp,sp,-32
    8000450a:	ec06                	sd	ra,24(sp)
    8000450c:	e822                	sd	s0,16(sp)
    8000450e:	e426                	sd	s1,8(sp)
    80004510:	e04a                	sd	s2,0(sp)
    80004512:	1000                	addi	s0,sp,32
    80004514:	84aa                	mv	s1,a0
    80004516:	892e                	mv	s2,a1
  initlock(&lk->lk, "sleep lock");
    80004518:	00004597          	auipc	a1,0x4
    8000451c:	50858593          	addi	a1,a1,1288 # 80008a20 <userret+0x990>
    80004520:	0521                	addi	a0,a0,8
    80004522:	ffffc097          	auipc	ra,0xffffc
    80004526:	50e080e7          	jalr	1294(ra) # 80000a30 <initlock>
  lk->name = name;
    8000452a:	0324b423          	sd	s2,40(s1)
  lk->locked = 0;
    8000452e:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    80004532:	0204a823          	sw	zero,48(s1)
}
    80004536:	60e2                	ld	ra,24(sp)
    80004538:	6442                	ld	s0,16(sp)
    8000453a:	64a2                	ld	s1,8(sp)
    8000453c:	6902                	ld	s2,0(sp)
    8000453e:	6105                	addi	sp,sp,32
    80004540:	8082                	ret

0000000080004542 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
    80004542:	1101                	addi	sp,sp,-32
    80004544:	ec06                	sd	ra,24(sp)
    80004546:	e822                	sd	s0,16(sp)
    80004548:	e426                	sd	s1,8(sp)
    8000454a:	e04a                	sd	s2,0(sp)
    8000454c:	1000                	addi	s0,sp,32
    8000454e:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    80004550:	00850913          	addi	s2,a0,8
    80004554:	854a                	mv	a0,s2
    80004556:	ffffc097          	auipc	ra,0xffffc
    8000455a:	5ae080e7          	jalr	1454(ra) # 80000b04 <acquire>
  while (lk->locked) {
    8000455e:	409c                	lw	a5,0(s1)
    80004560:	cb89                	beqz	a5,80004572 <acquiresleep+0x30>
    sleep(lk, &lk->lk);
    80004562:	85ca                	mv	a1,s2
    80004564:	8526                	mv	a0,s1
    80004566:	ffffe097          	auipc	ra,0xffffe
    8000456a:	d5e080e7          	jalr	-674(ra) # 800022c4 <sleep>
  while (lk->locked) {
    8000456e:	409c                	lw	a5,0(s1)
    80004570:	fbed                	bnez	a5,80004562 <acquiresleep+0x20>
  }
  lk->locked = 1;
    80004572:	4785                	li	a5,1
    80004574:	c09c                	sw	a5,0(s1)
  lk->pid = myproc()->pid;
    80004576:	ffffd097          	auipc	ra,0xffffd
    8000457a:	58a080e7          	jalr	1418(ra) # 80001b00 <myproc>
    8000457e:	413c                	lw	a5,64(a0)
    80004580:	d89c                	sw	a5,48(s1)
  release(&lk->lk);
    80004582:	854a                	mv	a0,s2
    80004584:	ffffc097          	auipc	ra,0xffffc
    80004588:	644080e7          	jalr	1604(ra) # 80000bc8 <release>
}
    8000458c:	60e2                	ld	ra,24(sp)
    8000458e:	6442                	ld	s0,16(sp)
    80004590:	64a2                	ld	s1,8(sp)
    80004592:	6902                	ld	s2,0(sp)
    80004594:	6105                	addi	sp,sp,32
    80004596:	8082                	ret

0000000080004598 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
    80004598:	1101                	addi	sp,sp,-32
    8000459a:	ec06                	sd	ra,24(sp)
    8000459c:	e822                	sd	s0,16(sp)
    8000459e:	e426                	sd	s1,8(sp)
    800045a0:	e04a                	sd	s2,0(sp)
    800045a2:	1000                	addi	s0,sp,32
    800045a4:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    800045a6:	00850913          	addi	s2,a0,8
    800045aa:	854a                	mv	a0,s2
    800045ac:	ffffc097          	auipc	ra,0xffffc
    800045b0:	558080e7          	jalr	1368(ra) # 80000b04 <acquire>
  lk->locked = 0;
    800045b4:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    800045b8:	0204a823          	sw	zero,48(s1)
  wakeup(lk);
    800045bc:	8526                	mv	a0,s1
    800045be:	ffffe097          	auipc	ra,0xffffe
    800045c2:	e80080e7          	jalr	-384(ra) # 8000243e <wakeup>
  release(&lk->lk);
    800045c6:	854a                	mv	a0,s2
    800045c8:	ffffc097          	auipc	ra,0xffffc
    800045cc:	600080e7          	jalr	1536(ra) # 80000bc8 <release>
}
    800045d0:	60e2                	ld	ra,24(sp)
    800045d2:	6442                	ld	s0,16(sp)
    800045d4:	64a2                	ld	s1,8(sp)
    800045d6:	6902                	ld	s2,0(sp)
    800045d8:	6105                	addi	sp,sp,32
    800045da:	8082                	ret

00000000800045dc <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
    800045dc:	7179                	addi	sp,sp,-48
    800045de:	f406                	sd	ra,40(sp)
    800045e0:	f022                	sd	s0,32(sp)
    800045e2:	ec26                	sd	s1,24(sp)
    800045e4:	e84a                	sd	s2,16(sp)
    800045e6:	1800                	addi	s0,sp,48
    800045e8:	84aa                	mv	s1,a0
  int r;
  
  acquire(&lk->lk);
    800045ea:	00850913          	addi	s2,a0,8
    800045ee:	854a                	mv	a0,s2
    800045f0:	ffffc097          	auipc	ra,0xffffc
    800045f4:	514080e7          	jalr	1300(ra) # 80000b04 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
    800045f8:	409c                	lw	a5,0(s1)
    800045fa:	ef91                	bnez	a5,80004616 <holdingsleep+0x3a>
    800045fc:	4481                	li	s1,0
  release(&lk->lk);
    800045fe:	854a                	mv	a0,s2
    80004600:	ffffc097          	auipc	ra,0xffffc
    80004604:	5c8080e7          	jalr	1480(ra) # 80000bc8 <release>
  return r;
}
    80004608:	8526                	mv	a0,s1
    8000460a:	70a2                	ld	ra,40(sp)
    8000460c:	7402                	ld	s0,32(sp)
    8000460e:	64e2                	ld	s1,24(sp)
    80004610:	6942                	ld	s2,16(sp)
    80004612:	6145                	addi	sp,sp,48
    80004614:	8082                	ret
    80004616:	e44e                	sd	s3,8(sp)
  r = lk->locked && (lk->pid == myproc()->pid);
    80004618:	0304a983          	lw	s3,48(s1)
    8000461c:	ffffd097          	auipc	ra,0xffffd
    80004620:	4e4080e7          	jalr	1252(ra) # 80001b00 <myproc>
    80004624:	4124                	lw	s1,64(a0)
    80004626:	413484b3          	sub	s1,s1,s3
    8000462a:	0014b493          	seqz	s1,s1
    8000462e:	69a2                	ld	s3,8(sp)
    80004630:	b7f9                	j	800045fe <holdingsleep+0x22>

0000000080004632 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
    80004632:	1141                	addi	sp,sp,-16
    80004634:	e406                	sd	ra,8(sp)
    80004636:	e022                	sd	s0,0(sp)
    80004638:	0800                	addi	s0,sp,16
  initlock(&ftable.lock, "ftable");
    8000463a:	00004597          	auipc	a1,0x4
    8000463e:	3f658593          	addi	a1,a1,1014 # 80008a30 <userret+0x9a0>
    80004642:	0001c517          	auipc	a0,0x1c
    80004646:	abe50513          	addi	a0,a0,-1346 # 80020100 <ftable>
    8000464a:	ffffc097          	auipc	ra,0xffffc
    8000464e:	3e6080e7          	jalr	998(ra) # 80000a30 <initlock>
}
    80004652:	60a2                	ld	ra,8(sp)
    80004654:	6402                	ld	s0,0(sp)
    80004656:	0141                	addi	sp,sp,16
    80004658:	8082                	ret

000000008000465a <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
    8000465a:	1101                	addi	sp,sp,-32
    8000465c:	ec06                	sd	ra,24(sp)
    8000465e:	e822                	sd	s0,16(sp)
    80004660:	e426                	sd	s1,8(sp)
    80004662:	1000                	addi	s0,sp,32
  struct file *f;

  acquire(&ftable.lock);
    80004664:	0001c517          	auipc	a0,0x1c
    80004668:	a9c50513          	addi	a0,a0,-1380 # 80020100 <ftable>
    8000466c:	ffffc097          	auipc	ra,0xffffc
    80004670:	498080e7          	jalr	1176(ra) # 80000b04 <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    80004674:	0001c497          	auipc	s1,0x1c
    80004678:	aac48493          	addi	s1,s1,-1364 # 80020120 <ftable+0x20>
    8000467c:	0001d717          	auipc	a4,0x1d
    80004680:	a4470713          	addi	a4,a4,-1468 # 800210c0 <ftable+0xfc0>
    if(f->ref == 0){
    80004684:	40dc                	lw	a5,4(s1)
    80004686:	cf99                	beqz	a5,800046a4 <filealloc+0x4a>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    80004688:	02848493          	addi	s1,s1,40
    8000468c:	fee49ce3          	bne	s1,a4,80004684 <filealloc+0x2a>
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
    80004690:	0001c517          	auipc	a0,0x1c
    80004694:	a7050513          	addi	a0,a0,-1424 # 80020100 <ftable>
    80004698:	ffffc097          	auipc	ra,0xffffc
    8000469c:	530080e7          	jalr	1328(ra) # 80000bc8 <release>
  return 0;
    800046a0:	4481                	li	s1,0
    800046a2:	a819                	j	800046b8 <filealloc+0x5e>
      f->ref = 1;
    800046a4:	4785                	li	a5,1
    800046a6:	c0dc                	sw	a5,4(s1)
      release(&ftable.lock);
    800046a8:	0001c517          	auipc	a0,0x1c
    800046ac:	a5850513          	addi	a0,a0,-1448 # 80020100 <ftable>
    800046b0:	ffffc097          	auipc	ra,0xffffc
    800046b4:	518080e7          	jalr	1304(ra) # 80000bc8 <release>
}
    800046b8:	8526                	mv	a0,s1
    800046ba:	60e2                	ld	ra,24(sp)
    800046bc:	6442                	ld	s0,16(sp)
    800046be:	64a2                	ld	s1,8(sp)
    800046c0:	6105                	addi	sp,sp,32
    800046c2:	8082                	ret

00000000800046c4 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
    800046c4:	1101                	addi	sp,sp,-32
    800046c6:	ec06                	sd	ra,24(sp)
    800046c8:	e822                	sd	s0,16(sp)
    800046ca:	e426                	sd	s1,8(sp)
    800046cc:	1000                	addi	s0,sp,32
    800046ce:	84aa                	mv	s1,a0
  acquire(&ftable.lock);
    800046d0:	0001c517          	auipc	a0,0x1c
    800046d4:	a3050513          	addi	a0,a0,-1488 # 80020100 <ftable>
    800046d8:	ffffc097          	auipc	ra,0xffffc
    800046dc:	42c080e7          	jalr	1068(ra) # 80000b04 <acquire>
  if(f->ref < 1)
    800046e0:	40dc                	lw	a5,4(s1)
    800046e2:	02f05263          	blez	a5,80004706 <filedup+0x42>
    panic("filedup");
  f->ref++;
    800046e6:	2785                	addiw	a5,a5,1
    800046e8:	c0dc                	sw	a5,4(s1)
  release(&ftable.lock);
    800046ea:	0001c517          	auipc	a0,0x1c
    800046ee:	a1650513          	addi	a0,a0,-1514 # 80020100 <ftable>
    800046f2:	ffffc097          	auipc	ra,0xffffc
    800046f6:	4d6080e7          	jalr	1238(ra) # 80000bc8 <release>
  return f;
}
    800046fa:	8526                	mv	a0,s1
    800046fc:	60e2                	ld	ra,24(sp)
    800046fe:	6442                	ld	s0,16(sp)
    80004700:	64a2                	ld	s1,8(sp)
    80004702:	6105                	addi	sp,sp,32
    80004704:	8082                	ret
    panic("filedup");
    80004706:	00004517          	auipc	a0,0x4
    8000470a:	33250513          	addi	a0,a0,818 # 80008a38 <userret+0x9a8>
    8000470e:	ffffc097          	auipc	ra,0xffffc
    80004712:	e5c080e7          	jalr	-420(ra) # 8000056a <panic>

0000000080004716 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
    80004716:	7139                	addi	sp,sp,-64
    80004718:	fc06                	sd	ra,56(sp)
    8000471a:	f822                	sd	s0,48(sp)
    8000471c:	f426                	sd	s1,40(sp)
    8000471e:	0080                	addi	s0,sp,64
    80004720:	84aa                	mv	s1,a0
  struct file ff;

  acquire(&ftable.lock);
    80004722:	0001c517          	auipc	a0,0x1c
    80004726:	9de50513          	addi	a0,a0,-1570 # 80020100 <ftable>
    8000472a:	ffffc097          	auipc	ra,0xffffc
    8000472e:	3da080e7          	jalr	986(ra) # 80000b04 <acquire>
  if(f->ref < 1)
    80004732:	40dc                	lw	a5,4(s1)
    80004734:	04f05c63          	blez	a5,8000478c <fileclose+0x76>
    panic("fileclose");
  if(--f->ref > 0){
    80004738:	37fd                	addiw	a5,a5,-1
    8000473a:	c0dc                	sw	a5,4(s1)
    8000473c:	06f04463          	bgtz	a5,800047a4 <fileclose+0x8e>
    80004740:	f04a                	sd	s2,32(sp)
    80004742:	ec4e                	sd	s3,24(sp)
    80004744:	e852                	sd	s4,16(sp)
    80004746:	e456                	sd	s5,8(sp)
    release(&ftable.lock);
    return;
  }
  ff = *f;
    80004748:	0004a903          	lw	s2,0(s1)
    8000474c:	0094c783          	lbu	a5,9(s1)
    80004750:	89be                	mv	s3,a5
    80004752:	689c                	ld	a5,16(s1)
    80004754:	8a3e                	mv	s4,a5
    80004756:	6c9c                	ld	a5,24(s1)
    80004758:	8abe                	mv	s5,a5
  f->ref = 0;
    8000475a:	0004a223          	sw	zero,4(s1)
  f->type = FD_NONE;
    8000475e:	0004a023          	sw	zero,0(s1)
  release(&ftable.lock);
    80004762:	0001c517          	auipc	a0,0x1c
    80004766:	99e50513          	addi	a0,a0,-1634 # 80020100 <ftable>
    8000476a:	ffffc097          	auipc	ra,0xffffc
    8000476e:	45e080e7          	jalr	1118(ra) # 80000bc8 <release>

  if(ff.type == FD_PIPE){
    80004772:	4785                	li	a5,1
    80004774:	04f90563          	beq	s2,a5,800047be <fileclose+0xa8>
    pipeclose(ff.pipe, ff.writable);
  } else if(ff.type == FD_INODE || ff.type == FD_DEVICE){
    80004778:	ffe9079b          	addiw	a5,s2,-2
    8000477c:	4705                	li	a4,1
    8000477e:	04f77b63          	bgeu	a4,a5,800047d4 <fileclose+0xbe>
    80004782:	7902                	ld	s2,32(sp)
    80004784:	69e2                	ld	s3,24(sp)
    80004786:	6a42                	ld	s4,16(sp)
    80004788:	6aa2                	ld	s5,8(sp)
    8000478a:	a02d                	j	800047b4 <fileclose+0x9e>
    8000478c:	f04a                	sd	s2,32(sp)
    8000478e:	ec4e                	sd	s3,24(sp)
    80004790:	e852                	sd	s4,16(sp)
    80004792:	e456                	sd	s5,8(sp)
    panic("fileclose");
    80004794:	00004517          	auipc	a0,0x4
    80004798:	2ac50513          	addi	a0,a0,684 # 80008a40 <userret+0x9b0>
    8000479c:	ffffc097          	auipc	ra,0xffffc
    800047a0:	dce080e7          	jalr	-562(ra) # 8000056a <panic>
    release(&ftable.lock);
    800047a4:	0001c517          	auipc	a0,0x1c
    800047a8:	95c50513          	addi	a0,a0,-1700 # 80020100 <ftable>
    800047ac:	ffffc097          	auipc	ra,0xffffc
    800047b0:	41c080e7          	jalr	1052(ra) # 80000bc8 <release>
    begin_op(ff.ip->dev);
    iput(ff.ip);
    end_op(ff.ip->dev);
  }
}
    800047b4:	70e2                	ld	ra,56(sp)
    800047b6:	7442                	ld	s0,48(sp)
    800047b8:	74a2                	ld	s1,40(sp)
    800047ba:	6121                	addi	sp,sp,64
    800047bc:	8082                	ret
    pipeclose(ff.pipe, ff.writable);
    800047be:	85ce                	mv	a1,s3
    800047c0:	8552                	mv	a0,s4
    800047c2:	00000097          	auipc	ra,0x0
    800047c6:	3e8080e7          	jalr	1000(ra) # 80004baa <pipeclose>
    800047ca:	7902                	ld	s2,32(sp)
    800047cc:	69e2                	ld	s3,24(sp)
    800047ce:	6a42                	ld	s4,16(sp)
    800047d0:	6aa2                	ld	s5,8(sp)
    800047d2:	b7cd                	j	800047b4 <fileclose+0x9e>
    begin_op(ff.ip->dev);
    800047d4:	000aa503          	lw	a0,0(s5)
    800047d8:	00000097          	auipc	ra,0x0
    800047dc:	9a2080e7          	jalr	-1630(ra) # 8000417a <begin_op>
    iput(ff.ip);
    800047e0:	8556                	mv	a0,s5
    800047e2:	fffff097          	auipc	ra,0xfffff
    800047e6:	09c080e7          	jalr	156(ra) # 8000387e <iput>
    end_op(ff.ip->dev);
    800047ea:	000aa503          	lw	a0,0(s5)
    800047ee:	00000097          	auipc	ra,0x0
    800047f2:	a2e080e7          	jalr	-1490(ra) # 8000421c <end_op>
    800047f6:	7902                	ld	s2,32(sp)
    800047f8:	69e2                	ld	s3,24(sp)
    800047fa:	6a42                	ld	s4,16(sp)
    800047fc:	6aa2                	ld	s5,8(sp)
    800047fe:	bf5d                	j	800047b4 <fileclose+0x9e>

0000000080004800 <filestat>:

// Get metadata about file f.
// addr is a user virtual address, pointing to a struct stat.
int
filestat(struct file *f, uint64 addr)
{
    80004800:	715d                	addi	sp,sp,-80
    80004802:	e486                	sd	ra,72(sp)
    80004804:	e0a2                	sd	s0,64(sp)
    80004806:	fc26                	sd	s1,56(sp)
    80004808:	f052                	sd	s4,32(sp)
    8000480a:	0880                	addi	s0,sp,80
    8000480c:	84aa                	mv	s1,a0
    8000480e:	8a2e                	mv	s4,a1
  struct proc *p = myproc();
    80004810:	ffffd097          	auipc	ra,0xffffd
    80004814:	2f0080e7          	jalr	752(ra) # 80001b00 <myproc>
  struct stat st;
  
  if(f->type == FD_INODE || f->type == FD_DEVICE){
    80004818:	409c                	lw	a5,0(s1)
    8000481a:	37f9                	addiw	a5,a5,-2
    8000481c:	4705                	li	a4,1
    8000481e:	04f76a63          	bltu	a4,a5,80004872 <filestat+0x72>
    80004822:	f84a                	sd	s2,48(sp)
    80004824:	f44e                	sd	s3,40(sp)
    80004826:	89aa                	mv	s3,a0
    ilock(f->ip);
    80004828:	6c88                	ld	a0,24(s1)
    8000482a:	fffff097          	auipc	ra,0xfffff
    8000482e:	f42080e7          	jalr	-190(ra) # 8000376c <ilock>
    stati(f->ip, &st);
    80004832:	fb840913          	addi	s2,s0,-72
    80004836:	85ca                	mv	a1,s2
    80004838:	6c88                	ld	a0,24(s1)
    8000483a:	fffff097          	auipc	ra,0xfffff
    8000483e:	19e080e7          	jalr	414(ra) # 800039d8 <stati>
    iunlock(f->ip);
    80004842:	6c88                	ld	a0,24(s1)
    80004844:	fffff097          	auipc	ra,0xfffff
    80004848:	fee080e7          	jalr	-18(ra) # 80003832 <iunlock>
    if(copyout(p->pagetable, addr, (char *)&st, sizeof(st)) < 0)
    8000484c:	46e1                	li	a3,24
    8000484e:	864a                	mv	a2,s2
    80004850:	85d2                	mv	a1,s4
    80004852:	0589b503          	ld	a0,88(s3)
    80004856:	ffffd097          	auipc	ra,0xffffd
    8000485a:	f6e080e7          	jalr	-146(ra) # 800017c4 <copyout>
    8000485e:	41f5551b          	sraiw	a0,a0,0x1f
    80004862:	7942                	ld	s2,48(sp)
    80004864:	79a2                	ld	s3,40(sp)
      return -1;
    return 0;
  }
  return -1;
}
    80004866:	60a6                	ld	ra,72(sp)
    80004868:	6406                	ld	s0,64(sp)
    8000486a:	74e2                	ld	s1,56(sp)
    8000486c:	7a02                	ld	s4,32(sp)
    8000486e:	6161                	addi	sp,sp,80
    80004870:	8082                	ret
  return -1;
    80004872:	557d                	li	a0,-1
    80004874:	bfcd                	j	80004866 <filestat+0x66>

0000000080004876 <fileread>:

// Read from file f.
// addr is a user virtual address.
int
fileread(struct file *f, uint64 addr, int n)
{
    80004876:	7179                	addi	sp,sp,-48
    80004878:	f406                	sd	ra,40(sp)
    8000487a:	f022                	sd	s0,32(sp)
    8000487c:	e84a                	sd	s2,16(sp)
    8000487e:	1800                	addi	s0,sp,48
  int r = 0;

  if(f->readable == 0)
    80004880:	00854783          	lbu	a5,8(a0)
    80004884:	cbd5                	beqz	a5,80004938 <fileread+0xc2>
    80004886:	ec26                	sd	s1,24(sp)
    80004888:	e44e                	sd	s3,8(sp)
    8000488a:	84aa                	mv	s1,a0
    8000488c:	892e                	mv	s2,a1
    8000488e:	89b2                	mv	s3,a2
    return -1;

  if(f->type == FD_PIPE){
    80004890:	411c                	lw	a5,0(a0)
    80004892:	4705                	li	a4,1
    80004894:	04e78963          	beq	a5,a4,800048e6 <fileread+0x70>
    r = piperead(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    80004898:	470d                	li	a4,3
    8000489a:	04e78f63          	beq	a5,a4,800048f8 <fileread+0x82>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
      return -1;
    r = devsw[f->major].read(f, 1, addr, n);
  } else if(f->type == FD_INODE){
    8000489e:	4709                	li	a4,2
    800048a0:	08e79463          	bne	a5,a4,80004928 <fileread+0xb2>
    ilock(f->ip);
    800048a4:	6d08                	ld	a0,24(a0)
    800048a6:	fffff097          	auipc	ra,0xfffff
    800048aa:	ec6080e7          	jalr	-314(ra) # 8000376c <ilock>
    if((r = readi(f->ip, 1, addr, f->off, n)) > 0)
    800048ae:	874e                	mv	a4,s3
    800048b0:	5094                	lw	a3,32(s1)
    800048b2:	864a                	mv	a2,s2
    800048b4:	4585                	li	a1,1
    800048b6:	6c88                	ld	a0,24(s1)
    800048b8:	fffff097          	auipc	ra,0xfffff
    800048bc:	14e080e7          	jalr	334(ra) # 80003a06 <readi>
    800048c0:	892a                	mv	s2,a0
    800048c2:	00a05563          	blez	a0,800048cc <fileread+0x56>
      f->off += r;
    800048c6:	509c                	lw	a5,32(s1)
    800048c8:	9fa9                	addw	a5,a5,a0
    800048ca:	d09c                	sw	a5,32(s1)
    iunlock(f->ip);
    800048cc:	6c88                	ld	a0,24(s1)
    800048ce:	fffff097          	auipc	ra,0xfffff
    800048d2:	f64080e7          	jalr	-156(ra) # 80003832 <iunlock>
    800048d6:	64e2                	ld	s1,24(sp)
    800048d8:	69a2                	ld	s3,8(sp)
  } else {
    panic("fileread");
  }

  return r;
}
    800048da:	854a                	mv	a0,s2
    800048dc:	70a2                	ld	ra,40(sp)
    800048de:	7402                	ld	s0,32(sp)
    800048e0:	6942                	ld	s2,16(sp)
    800048e2:	6145                	addi	sp,sp,48
    800048e4:	8082                	ret
    r = piperead(f->pipe, addr, n);
    800048e6:	6908                	ld	a0,16(a0)
    800048e8:	00000097          	auipc	ra,0x0
    800048ec:	446080e7          	jalr	1094(ra) # 80004d2e <piperead>
    800048f0:	892a                	mv	s2,a0
    800048f2:	64e2                	ld	s1,24(sp)
    800048f4:	69a2                	ld	s3,8(sp)
    800048f6:	b7d5                	j	800048da <fileread+0x64>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
    800048f8:	02451783          	lh	a5,36(a0)
    800048fc:	03079693          	slli	a3,a5,0x30
    80004900:	92c1                	srli	a3,a3,0x30
    80004902:	4725                	li	a4,9
    80004904:	02d76d63          	bltu	a4,a3,8000493e <fileread+0xc8>
    80004908:	0792                	slli	a5,a5,0x4
    8000490a:	0001b717          	auipc	a4,0x1b
    8000490e:	75670713          	addi	a4,a4,1878 # 80020060 <devsw>
    80004912:	97ba                	add	a5,a5,a4
    80004914:	639c                	ld	a5,0(a5)
    80004916:	cb8d                	beqz	a5,80004948 <fileread+0xd2>
    r = devsw[f->major].read(f, 1, addr, n);
    80004918:	86b2                	mv	a3,a2
    8000491a:	862e                	mv	a2,a1
    8000491c:	4585                	li	a1,1
    8000491e:	9782                	jalr	a5
    80004920:	892a                	mv	s2,a0
    80004922:	64e2                	ld	s1,24(sp)
    80004924:	69a2                	ld	s3,8(sp)
    80004926:	bf55                	j	800048da <fileread+0x64>
    panic("fileread");
    80004928:	00004517          	auipc	a0,0x4
    8000492c:	12850513          	addi	a0,a0,296 # 80008a50 <userret+0x9c0>
    80004930:	ffffc097          	auipc	ra,0xffffc
    80004934:	c3a080e7          	jalr	-966(ra) # 8000056a <panic>
    return -1;
    80004938:	57fd                	li	a5,-1
    8000493a:	893e                	mv	s2,a5
    8000493c:	bf79                	j	800048da <fileread+0x64>
      return -1;
    8000493e:	57fd                	li	a5,-1
    80004940:	893e                	mv	s2,a5
    80004942:	64e2                	ld	s1,24(sp)
    80004944:	69a2                	ld	s3,8(sp)
    80004946:	bf51                	j	800048da <fileread+0x64>
    80004948:	57fd                	li	a5,-1
    8000494a:	893e                	mv	s2,a5
    8000494c:	64e2                	ld	s1,24(sp)
    8000494e:	69a2                	ld	s3,8(sp)
    80004950:	b769                	j	800048da <fileread+0x64>

0000000080004952 <filewrite>:
int
filewrite(struct file *f, uint64 addr, int n)
{
  int r, ret = 0;

  if(f->writable == 0)
    80004952:	00954783          	lbu	a5,9(a0)
    80004956:	16078263          	beqz	a5,80004aba <filewrite+0x168>
{
    8000495a:	711d                	addi	sp,sp,-96
    8000495c:	ec86                	sd	ra,88(sp)
    8000495e:	e8a2                	sd	s0,80(sp)
    80004960:	e4a6                	sd	s1,72(sp)
    80004962:	f456                	sd	s5,40(sp)
    80004964:	f05a                	sd	s6,32(sp)
    80004966:	1080                	addi	s0,sp,96
    80004968:	84aa                	mv	s1,a0
    8000496a:	8b2e                	mv	s6,a1
    8000496c:	8ab2                	mv	s5,a2
    return -1;

  if(f->type == FD_PIPE){
    8000496e:	411c                	lw	a5,0(a0)
    80004970:	4705                	li	a4,1
    80004972:	02e78a63          	beq	a5,a4,800049a6 <filewrite+0x54>
    ret = pipewrite(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    80004976:	470d                	li	a4,3
    80004978:	02e78d63          	beq	a5,a4,800049b2 <filewrite+0x60>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
      return -1;
    ret = devsw[f->major].write(f, 1, addr, n);
  } else if(f->type == FD_INODE){
    8000497c:	4709                	li	a4,2
    8000497e:	12e79063          	bne	a5,a4,80004a9e <filewrite+0x14c>
    80004982:	f852                	sd	s4,48(sp)
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * BSIZE;
    int i = 0;
    while(i < n){
    80004984:	10c05b63          	blez	a2,80004a9a <filewrite+0x148>
    80004988:	e0ca                	sd	s2,64(sp)
    8000498a:	fc4e                	sd	s3,56(sp)
    8000498c:	ec5e                	sd	s7,24(sp)
    8000498e:	e862                	sd	s8,16(sp)
    80004990:	e466                	sd	s9,8(sp)
    int i = 0;
    80004992:	4a01                	li	s4,0
      int n1 = n - i;
      if(n1 > max)
    80004994:	6b85                	lui	s7,0x1
    80004996:	c00b8b93          	addi	s7,s7,-1024 # c00 <_entry-0x7ffff400>
    8000499a:	6785                	lui	a5,0x1
    8000499c:	c007879b          	addiw	a5,a5,-1024 # c00 <_entry-0x7ffff400>
    800049a0:	8cbe                	mv	s9,a5
        n1 = max;

      begin_op(f->ip->dev);
      ilock(f->ip);
      if ((r = writei(f->ip, 1, addr + i, f->off, n1)) > 0)
    800049a2:	4c05                	li	s8,1
    800049a4:	a849                	j	80004a36 <filewrite+0xe4>
    ret = pipewrite(f->pipe, addr, n);
    800049a6:	6908                	ld	a0,16(a0)
    800049a8:	00000097          	auipc	ra,0x0
    800049ac:	278080e7          	jalr	632(ra) # 80004c20 <pipewrite>
    800049b0:	a0c1                	j	80004a70 <filewrite+0x11e>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
    800049b2:	02451783          	lh	a5,36(a0)
    800049b6:	03079693          	slli	a3,a5,0x30
    800049ba:	92c1                	srli	a3,a3,0x30
    800049bc:	4725                	li	a4,9
    800049be:	10d76063          	bltu	a4,a3,80004abe <filewrite+0x16c>
    800049c2:	0792                	slli	a5,a5,0x4
    800049c4:	0001b717          	auipc	a4,0x1b
    800049c8:	69c70713          	addi	a4,a4,1692 # 80020060 <devsw>
    800049cc:	97ba                	add	a5,a5,a4
    800049ce:	679c                	ld	a5,8(a5)
    800049d0:	cbed                	beqz	a5,80004ac2 <filewrite+0x170>
    ret = devsw[f->major].write(f, 1, addr, n);
    800049d2:	86b2                	mv	a3,a2
    800049d4:	862e                	mv	a2,a1
    800049d6:	4585                	li	a1,1
    800049d8:	9782                	jalr	a5
    800049da:	a859                	j	80004a70 <filewrite+0x11e>
      if(n1 > max)
    800049dc:	2981                	sext.w	s3,s3
      begin_op(f->ip->dev);
    800049de:	6c9c                	ld	a5,24(s1)
    800049e0:	4388                	lw	a0,0(a5)
    800049e2:	fffff097          	auipc	ra,0xfffff
    800049e6:	798080e7          	jalr	1944(ra) # 8000417a <begin_op>
      ilock(f->ip);
    800049ea:	6c88                	ld	a0,24(s1)
    800049ec:	fffff097          	auipc	ra,0xfffff
    800049f0:	d80080e7          	jalr	-640(ra) # 8000376c <ilock>
      if ((r = writei(f->ip, 1, addr + i, f->off, n1)) > 0)
    800049f4:	874e                	mv	a4,s3
    800049f6:	5094                	lw	a3,32(s1)
    800049f8:	016a0633          	add	a2,s4,s6
    800049fc:	85e2                	mv	a1,s8
    800049fe:	6c88                	ld	a0,24(s1)
    80004a00:	fffff097          	auipc	ra,0xfffff
    80004a04:	0fe080e7          	jalr	254(ra) # 80003afe <writei>
    80004a08:	892a                	mv	s2,a0
    80004a0a:	02a05d63          	blez	a0,80004a44 <filewrite+0xf2>
        f->off += r;
    80004a0e:	509c                	lw	a5,32(s1)
    80004a10:	9fa9                	addw	a5,a5,a0
    80004a12:	d09c                	sw	a5,32(s1)
      iunlock(f->ip);
    80004a14:	6c88                	ld	a0,24(s1)
    80004a16:	fffff097          	auipc	ra,0xfffff
    80004a1a:	e1c080e7          	jalr	-484(ra) # 80003832 <iunlock>
      end_op(f->ip->dev);
    80004a1e:	6c9c                	ld	a5,24(s1)
    80004a20:	4388                	lw	a0,0(a5)
    80004a22:	fffff097          	auipc	ra,0xfffff
    80004a26:	7fa080e7          	jalr	2042(ra) # 8000421c <end_op>

      if(r < 0)
        break;
      if(r != n1)
    80004a2a:	05299a63          	bne	s3,s2,80004a7e <filewrite+0x12c>
        panic("short filewrite");
      i += r;
    80004a2e:	01490a3b          	addw	s4,s2,s4
    while(i < n){
    80004a32:	055a5e63          	bge	s4,s5,80004a8e <filewrite+0x13c>
      int n1 = n - i;
    80004a36:	414a87bb          	subw	a5,s5,s4
    80004a3a:	89be                	mv	s3,a5
      if(n1 > max)
    80004a3c:	fafbd0e3          	bge	s7,a5,800049dc <filewrite+0x8a>
    80004a40:	89e6                	mv	s3,s9
    80004a42:	bf69                	j	800049dc <filewrite+0x8a>
      iunlock(f->ip);
    80004a44:	6c88                	ld	a0,24(s1)
    80004a46:	fffff097          	auipc	ra,0xfffff
    80004a4a:	dec080e7          	jalr	-532(ra) # 80003832 <iunlock>
      end_op(f->ip->dev);
    80004a4e:	6c9c                	ld	a5,24(s1)
    80004a50:	4388                	lw	a0,0(a5)
    80004a52:	fffff097          	auipc	ra,0xfffff
    80004a56:	7ca080e7          	jalr	1994(ra) # 8000421c <end_op>
      if(r < 0)
    80004a5a:	fc0958e3          	bgez	s2,80004a2a <filewrite+0xd8>
    80004a5e:	6906                	ld	s2,64(sp)
    80004a60:	79e2                	ld	s3,56(sp)
    80004a62:	6be2                	ld	s7,24(sp)
    80004a64:	6c42                	ld	s8,16(sp)
    80004a66:	6ca2                	ld	s9,8(sp)
    }
    ret = (i == n ? n : -1);
    80004a68:	054a9f63          	bne	s5,s4,80004ac6 <filewrite+0x174>
    80004a6c:	8556                	mv	a0,s5
    80004a6e:	7a42                	ld	s4,48(sp)
  } else {
    panic("filewrite");
  }

  return ret;
}
    80004a70:	60e6                	ld	ra,88(sp)
    80004a72:	6446                	ld	s0,80(sp)
    80004a74:	64a6                	ld	s1,72(sp)
    80004a76:	7aa2                	ld	s5,40(sp)
    80004a78:	7b02                	ld	s6,32(sp)
    80004a7a:	6125                	addi	sp,sp,96
    80004a7c:	8082                	ret
        panic("short filewrite");
    80004a7e:	00004517          	auipc	a0,0x4
    80004a82:	fe250513          	addi	a0,a0,-30 # 80008a60 <userret+0x9d0>
    80004a86:	ffffc097          	auipc	ra,0xffffc
    80004a8a:	ae4080e7          	jalr	-1308(ra) # 8000056a <panic>
    80004a8e:	6906                	ld	s2,64(sp)
    80004a90:	79e2                	ld	s3,56(sp)
    80004a92:	6be2                	ld	s7,24(sp)
    80004a94:	6c42                	ld	s8,16(sp)
    80004a96:	6ca2                	ld	s9,8(sp)
    80004a98:	bfc1                	j	80004a68 <filewrite+0x116>
    int i = 0;
    80004a9a:	4a01                	li	s4,0
    80004a9c:	b7f1                	j	80004a68 <filewrite+0x116>
    80004a9e:	e0ca                	sd	s2,64(sp)
    80004aa0:	fc4e                	sd	s3,56(sp)
    80004aa2:	f852                	sd	s4,48(sp)
    80004aa4:	ec5e                	sd	s7,24(sp)
    80004aa6:	e862                	sd	s8,16(sp)
    80004aa8:	e466                	sd	s9,8(sp)
    panic("filewrite");
    80004aaa:	00004517          	auipc	a0,0x4
    80004aae:	fc650513          	addi	a0,a0,-58 # 80008a70 <userret+0x9e0>
    80004ab2:	ffffc097          	auipc	ra,0xffffc
    80004ab6:	ab8080e7          	jalr	-1352(ra) # 8000056a <panic>
    return -1;
    80004aba:	557d                	li	a0,-1
}
    80004abc:	8082                	ret
      return -1;
    80004abe:	557d                	li	a0,-1
    80004ac0:	bf45                	j	80004a70 <filewrite+0x11e>
    80004ac2:	557d                	li	a0,-1
    80004ac4:	b775                	j	80004a70 <filewrite+0x11e>
    ret = (i == n ? n : -1);
    80004ac6:	557d                	li	a0,-1
    80004ac8:	7a42                	ld	s4,48(sp)
    80004aca:	b75d                	j	80004a70 <filewrite+0x11e>

0000000080004acc <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
    80004acc:	7179                	addi	sp,sp,-48
    80004ace:	f406                	sd	ra,40(sp)
    80004ad0:	f022                	sd	s0,32(sp)
    80004ad2:	ec26                	sd	s1,24(sp)
    80004ad4:	e052                	sd	s4,0(sp)
    80004ad6:	1800                	addi	s0,sp,48
    80004ad8:	84aa                	mv	s1,a0
    80004ada:	8a2e                	mv	s4,a1
  struct pipe *pi;

  pi = 0;
  *f0 = *f1 = 0;
    80004adc:	0005b023          	sd	zero,0(a1)
    80004ae0:	00053023          	sd	zero,0(a0)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    80004ae4:	00000097          	auipc	ra,0x0
    80004ae8:	b76080e7          	jalr	-1162(ra) # 8000465a <filealloc>
    80004aec:	e088                	sd	a0,0(s1)
    80004aee:	cd41                	beqz	a0,80004b86 <pipealloc+0xba>
    80004af0:	00000097          	auipc	ra,0x0
    80004af4:	b6a080e7          	jalr	-1174(ra) # 8000465a <filealloc>
    80004af8:	00aa3023          	sd	a0,0(s4)
    80004afc:	cd3d                	beqz	a0,80004b7a <pipealloc+0xae>
    80004afe:	e84a                	sd	s2,16(sp)
    goto bad;
  if((pi = (struct pipe*)kalloc()) == 0)
    80004b00:	ffffc097          	auipc	ra,0xffffc
    80004b04:	ec6080e7          	jalr	-314(ra) # 800009c6 <kalloc>
    80004b08:	892a                	mv	s2,a0
    80004b0a:	c135                	beqz	a0,80004b6e <pipealloc+0xa2>
    80004b0c:	e44e                	sd	s3,8(sp)
    goto bad;
  pi->readopen = 1;
    80004b0e:	4985                	li	s3,1
    80004b10:	23352423          	sw	s3,552(a0)
  pi->writeopen = 1;
    80004b14:	23352623          	sw	s3,556(a0)
  pi->nwrite = 0;
    80004b18:	22052223          	sw	zero,548(a0)
  pi->nread = 0;
    80004b1c:	22052023          	sw	zero,544(a0)
  memset(&pi->lock, 0, sizeof(pi->lock));
    80004b20:	02000613          	li	a2,32
    80004b24:	4581                	li	a1,0
    80004b26:	ffffc097          	auipc	ra,0xffffc
    80004b2a:	298080e7          	jalr	664(ra) # 80000dbe <memset>
  (*f0)->type = FD_PIPE;
    80004b2e:	609c                	ld	a5,0(s1)
    80004b30:	0137a023          	sw	s3,0(a5)
  (*f0)->readable = 1;
    80004b34:	609c                	ld	a5,0(s1)
    80004b36:	01378423          	sb	s3,8(a5)
  (*f0)->writable = 0;
    80004b3a:	609c                	ld	a5,0(s1)
    80004b3c:	000784a3          	sb	zero,9(a5)
  (*f0)->pipe = pi;
    80004b40:	609c                	ld	a5,0(s1)
    80004b42:	0127b823          	sd	s2,16(a5)
  (*f1)->type = FD_PIPE;
    80004b46:	000a3783          	ld	a5,0(s4)
    80004b4a:	0137a023          	sw	s3,0(a5)
  (*f1)->readable = 0;
    80004b4e:	000a3783          	ld	a5,0(s4)
    80004b52:	00078423          	sb	zero,8(a5)
  (*f1)->writable = 1;
    80004b56:	000a3783          	ld	a5,0(s4)
    80004b5a:	013784a3          	sb	s3,9(a5)
  (*f1)->pipe = pi;
    80004b5e:	000a3783          	ld	a5,0(s4)
    80004b62:	0127b823          	sd	s2,16(a5)
  return 0;
    80004b66:	4501                	li	a0,0
    80004b68:	6942                	ld	s2,16(sp)
    80004b6a:	69a2                	ld	s3,8(sp)
    80004b6c:	a03d                	j	80004b9a <pipealloc+0xce>

 bad:
  if(pi)
    kfree((char*)pi);
  if(*f0)
    80004b6e:	6088                	ld	a0,0(s1)
    80004b70:	c119                	beqz	a0,80004b76 <pipealloc+0xaa>
    80004b72:	6942                	ld	s2,16(sp)
    80004b74:	a029                	j	80004b7e <pipealloc+0xb2>
    80004b76:	6942                	ld	s2,16(sp)
    80004b78:	a039                	j	80004b86 <pipealloc+0xba>
    80004b7a:	6088                	ld	a0,0(s1)
    80004b7c:	c50d                	beqz	a0,80004ba6 <pipealloc+0xda>
    fileclose(*f0);
    80004b7e:	00000097          	auipc	ra,0x0
    80004b82:	b98080e7          	jalr	-1128(ra) # 80004716 <fileclose>
  if(*f1)
    80004b86:	000a3783          	ld	a5,0(s4)
    fileclose(*f1);
  return -1;
    80004b8a:	557d                	li	a0,-1
  if(*f1)
    80004b8c:	c799                	beqz	a5,80004b9a <pipealloc+0xce>
    fileclose(*f1);
    80004b8e:	853e                	mv	a0,a5
    80004b90:	00000097          	auipc	ra,0x0
    80004b94:	b86080e7          	jalr	-1146(ra) # 80004716 <fileclose>
  return -1;
    80004b98:	557d                	li	a0,-1
}
    80004b9a:	70a2                	ld	ra,40(sp)
    80004b9c:	7402                	ld	s0,32(sp)
    80004b9e:	64e2                	ld	s1,24(sp)
    80004ba0:	6a02                	ld	s4,0(sp)
    80004ba2:	6145                	addi	sp,sp,48
    80004ba4:	8082                	ret
  return -1;
    80004ba6:	557d                	li	a0,-1
    80004ba8:	bfcd                	j	80004b9a <pipealloc+0xce>

0000000080004baa <pipeclose>:

void
pipeclose(struct pipe *pi, int writable)
{
    80004baa:	1101                	addi	sp,sp,-32
    80004bac:	ec06                	sd	ra,24(sp)
    80004bae:	e822                	sd	s0,16(sp)
    80004bb0:	e426                	sd	s1,8(sp)
    80004bb2:	e04a                	sd	s2,0(sp)
    80004bb4:	1000                	addi	s0,sp,32
    80004bb6:	84aa                	mv	s1,a0
    80004bb8:	892e                	mv	s2,a1
  acquire(&pi->lock);
    80004bba:	ffffc097          	auipc	ra,0xffffc
    80004bbe:	f4a080e7          	jalr	-182(ra) # 80000b04 <acquire>
  if(writable){
    80004bc2:	02090b63          	beqz	s2,80004bf8 <pipeclose+0x4e>
    pi->writeopen = 0;
    80004bc6:	2204a623          	sw	zero,556(s1)
    wakeup(&pi->nread);
    80004bca:	22048513          	addi	a0,s1,544
    80004bce:	ffffe097          	auipc	ra,0xffffe
    80004bd2:	870080e7          	jalr	-1936(ra) # 8000243e <wakeup>
  } else {
    pi->readopen = 0;
    wakeup(&pi->nwrite);
  }
  if(pi->readopen == 0 && pi->writeopen == 0){
    80004bd6:	2284a783          	lw	a5,552(s1)
    80004bda:	e781                	bnez	a5,80004be2 <pipeclose+0x38>
    80004bdc:	22c4a783          	lw	a5,556(s1)
    80004be0:	c78d                	beqz	a5,80004c0a <pipeclose+0x60>
    release(&pi->lock);
    kfree((char*)pi);
  } else
    release(&pi->lock);
    80004be2:	8526                	mv	a0,s1
    80004be4:	ffffc097          	auipc	ra,0xffffc
    80004be8:	fe4080e7          	jalr	-28(ra) # 80000bc8 <release>
}
    80004bec:	60e2                	ld	ra,24(sp)
    80004bee:	6442                	ld	s0,16(sp)
    80004bf0:	64a2                	ld	s1,8(sp)
    80004bf2:	6902                	ld	s2,0(sp)
    80004bf4:	6105                	addi	sp,sp,32
    80004bf6:	8082                	ret
    pi->readopen = 0;
    80004bf8:	2204a423          	sw	zero,552(s1)
    wakeup(&pi->nwrite);
    80004bfc:	22448513          	addi	a0,s1,548
    80004c00:	ffffe097          	auipc	ra,0xffffe
    80004c04:	83e080e7          	jalr	-1986(ra) # 8000243e <wakeup>
    80004c08:	b7f9                	j	80004bd6 <pipeclose+0x2c>
    release(&pi->lock);
    80004c0a:	8526                	mv	a0,s1
    80004c0c:	ffffc097          	auipc	ra,0xffffc
    80004c10:	fbc080e7          	jalr	-68(ra) # 80000bc8 <release>
    kfree((char*)pi);
    80004c14:	8526                	mv	a0,s1
    80004c16:	ffffc097          	auipc	ra,0xffffc
    80004c1a:	cac080e7          	jalr	-852(ra) # 800008c2 <kfree>
    80004c1e:	b7f9                	j	80004bec <pipeclose+0x42>

0000000080004c20 <pipewrite>:

int
pipewrite(struct pipe *pi, uint64 addr, int n)
{
    80004c20:	711d                	addi	sp,sp,-96
    80004c22:	ec86                	sd	ra,88(sp)
    80004c24:	e8a2                	sd	s0,80(sp)
    80004c26:	e4a6                	sd	s1,72(sp)
    80004c28:	f852                	sd	s4,48(sp)
    80004c2a:	f456                	sd	s5,40(sp)
    80004c2c:	f05a                	sd	s6,32(sp)
    80004c2e:	1080                	addi	s0,sp,96
    80004c30:	84aa                	mv	s1,a0
    80004c32:	8aae                	mv	s5,a1
    80004c34:	8a32                	mv	s4,a2
  int i;
  char ch;
  struct proc *pr = myproc();
    80004c36:	ffffd097          	auipc	ra,0xffffd
    80004c3a:	eca080e7          	jalr	-310(ra) # 80001b00 <myproc>
    80004c3e:	8b2a                	mv	s6,a0

  acquire(&pi->lock);
    80004c40:	8526                	mv	a0,s1
    80004c42:	ffffc097          	auipc	ra,0xffffc
    80004c46:	ec2080e7          	jalr	-318(ra) # 80000b04 <acquire>
  for(i = 0; i < n; i++){
    80004c4a:	0d405563          	blez	s4,80004d14 <pipewrite+0xf4>
    80004c4e:	e0ca                	sd	s2,64(sp)
    80004c50:	fc4e                	sd	s3,56(sp)
    80004c52:	ec5e                	sd	s7,24(sp)
    80004c54:	015a07b3          	add	a5,s4,s5
    80004c58:	8bbe                	mv	s7,a5
    while(pi->nwrite == pi->nread + PIPESIZE){  //DOC: pipewrite-full
      if(pi->readopen == 0 || myproc()->killed){
        release(&pi->lock);
        return -1;
      }
      wakeup(&pi->nread);
    80004c5a:	22048993          	addi	s3,s1,544
      sleep(&pi->nwrite, &pi->lock);
    80004c5e:	22448913          	addi	s2,s1,548
    while(pi->nwrite == pi->nread + PIPESIZE){  //DOC: pipewrite-full
    80004c62:	2204a783          	lw	a5,544(s1)
    80004c66:	2244a703          	lw	a4,548(s1)
    80004c6a:	2007879b          	addiw	a5,a5,512
    80004c6e:	02f71e63          	bne	a4,a5,80004caa <pipewrite+0x8a>
      if(pi->readopen == 0 || myproc()->killed){
    80004c72:	2284a783          	lw	a5,552(s1)
    80004c76:	cbbd                	beqz	a5,80004cec <pipewrite+0xcc>
    80004c78:	ffffd097          	auipc	ra,0xffffd
    80004c7c:	e88080e7          	jalr	-376(ra) # 80001b00 <myproc>
    80004c80:	5d1c                	lw	a5,56(a0)
    80004c82:	e7ad                	bnez	a5,80004cec <pipewrite+0xcc>
      wakeup(&pi->nread);
    80004c84:	854e                	mv	a0,s3
    80004c86:	ffffd097          	auipc	ra,0xffffd
    80004c8a:	7b8080e7          	jalr	1976(ra) # 8000243e <wakeup>
      sleep(&pi->nwrite, &pi->lock);
    80004c8e:	85a6                	mv	a1,s1
    80004c90:	854a                	mv	a0,s2
    80004c92:	ffffd097          	auipc	ra,0xffffd
    80004c96:	632080e7          	jalr	1586(ra) # 800022c4 <sleep>
    while(pi->nwrite == pi->nread + PIPESIZE){  //DOC: pipewrite-full
    80004c9a:	2204a783          	lw	a5,544(s1)
    80004c9e:	2244a703          	lw	a4,548(s1)
    80004ca2:	2007879b          	addiw	a5,a5,512
    80004ca6:	fcf706e3          	beq	a4,a5,80004c72 <pipewrite+0x52>
    }
    if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    80004caa:	4685                	li	a3,1
    80004cac:	8656                	mv	a2,s5
    80004cae:	faf40593          	addi	a1,s0,-81
    80004cb2:	058b3503          	ld	a0,88(s6)
    80004cb6:	ffffd097          	auipc	ra,0xffffd
    80004cba:	b9a080e7          	jalr	-1126(ra) # 80001850 <copyin>
    80004cbe:	57fd                	li	a5,-1
    80004cc0:	04f50763          	beq	a0,a5,80004d0e <pipewrite+0xee>
      break;
    pi->data[pi->nwrite++ % PIPESIZE] = ch;
    80004cc4:	2244a783          	lw	a5,548(s1)
    80004cc8:	0017871b          	addiw	a4,a5,1
    80004ccc:	22e4a223          	sw	a4,548(s1)
    80004cd0:	1ff7f793          	andi	a5,a5,511
    80004cd4:	97a6                	add	a5,a5,s1
    80004cd6:	faf44703          	lbu	a4,-81(s0)
    80004cda:	02e78023          	sb	a4,32(a5)
  for(i = 0; i < n; i++){
    80004cde:	0a85                	addi	s5,s5,1
    80004ce0:	f97a91e3          	bne	s5,s7,80004c62 <pipewrite+0x42>
    80004ce4:	6906                	ld	s2,64(sp)
    80004ce6:	79e2                	ld	s3,56(sp)
    80004ce8:	6be2                	ld	s7,24(sp)
    80004cea:	a02d                	j	80004d14 <pipewrite+0xf4>
        release(&pi->lock);
    80004cec:	8526                	mv	a0,s1
    80004cee:	ffffc097          	auipc	ra,0xffffc
    80004cf2:	eda080e7          	jalr	-294(ra) # 80000bc8 <release>
        return -1;
    80004cf6:	557d                	li	a0,-1
    80004cf8:	6906                	ld	s2,64(sp)
    80004cfa:	79e2                	ld	s3,56(sp)
    80004cfc:	6be2                	ld	s7,24(sp)
  }
  wakeup(&pi->nread);
  release(&pi->lock);
  return n;
}
    80004cfe:	60e6                	ld	ra,88(sp)
    80004d00:	6446                	ld	s0,80(sp)
    80004d02:	64a6                	ld	s1,72(sp)
    80004d04:	7a42                	ld	s4,48(sp)
    80004d06:	7aa2                	ld	s5,40(sp)
    80004d08:	7b02                	ld	s6,32(sp)
    80004d0a:	6125                	addi	sp,sp,96
    80004d0c:	8082                	ret
    80004d0e:	6906                	ld	s2,64(sp)
    80004d10:	79e2                	ld	s3,56(sp)
    80004d12:	6be2                	ld	s7,24(sp)
  wakeup(&pi->nread);
    80004d14:	22048513          	addi	a0,s1,544
    80004d18:	ffffd097          	auipc	ra,0xffffd
    80004d1c:	726080e7          	jalr	1830(ra) # 8000243e <wakeup>
  release(&pi->lock);
    80004d20:	8526                	mv	a0,s1
    80004d22:	ffffc097          	auipc	ra,0xffffc
    80004d26:	ea6080e7          	jalr	-346(ra) # 80000bc8 <release>
  return n;
    80004d2a:	8552                	mv	a0,s4
    80004d2c:	bfc9                	j	80004cfe <pipewrite+0xde>

0000000080004d2e <piperead>:

int
piperead(struct pipe *pi, uint64 addr, int n)
{
    80004d2e:	711d                	addi	sp,sp,-96
    80004d30:	ec86                	sd	ra,88(sp)
    80004d32:	e8a2                	sd	s0,80(sp)
    80004d34:	e4a6                	sd	s1,72(sp)
    80004d36:	e0ca                	sd	s2,64(sp)
    80004d38:	fc4e                	sd	s3,56(sp)
    80004d3a:	f852                	sd	s4,48(sp)
    80004d3c:	f456                	sd	s5,40(sp)
    80004d3e:	1080                	addi	s0,sp,96
    80004d40:	84aa                	mv	s1,a0
    80004d42:	892e                	mv	s2,a1
    80004d44:	8a32                	mv	s4,a2
  int i;
  struct proc *pr = myproc();
    80004d46:	ffffd097          	auipc	ra,0xffffd
    80004d4a:	dba080e7          	jalr	-582(ra) # 80001b00 <myproc>
    80004d4e:	8aaa                	mv	s5,a0
  char ch;

  acquire(&pi->lock);
    80004d50:	8526                	mv	a0,s1
    80004d52:	ffffc097          	auipc	ra,0xffffc
    80004d56:	db2080e7          	jalr	-590(ra) # 80000b04 <acquire>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80004d5a:	2204a703          	lw	a4,544(s1)
    80004d5e:	2244a783          	lw	a5,548(s1)
    if(myproc()->killed){
      release(&pi->lock);
      return -1;
    }
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    80004d62:	22048993          	addi	s3,s1,544
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80004d66:	02f71b63          	bne	a4,a5,80004d9c <piperead+0x6e>
    80004d6a:	22c4a783          	lw	a5,556(s1)
    80004d6e:	c3b1                	beqz	a5,80004db2 <piperead+0x84>
    if(myproc()->killed){
    80004d70:	ffffd097          	auipc	ra,0xffffd
    80004d74:	d90080e7          	jalr	-624(ra) # 80001b00 <myproc>
    80004d78:	5d1c                	lw	a5,56(a0)
    80004d7a:	e78d                	bnez	a5,80004da4 <piperead+0x76>
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    80004d7c:	85a6                	mv	a1,s1
    80004d7e:	854e                	mv	a0,s3
    80004d80:	ffffd097          	auipc	ra,0xffffd
    80004d84:	544080e7          	jalr	1348(ra) # 800022c4 <sleep>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80004d88:	2204a703          	lw	a4,544(s1)
    80004d8c:	2244a783          	lw	a5,548(s1)
    80004d90:	fcf70de3          	beq	a4,a5,80004d6a <piperead+0x3c>
    80004d94:	f05a                	sd	s6,32(sp)
    80004d96:	ec5e                	sd	s7,24(sp)
    80004d98:	e862                	sd	s8,16(sp)
    80004d9a:	a839                	j	80004db8 <piperead+0x8a>
    80004d9c:	f05a                	sd	s6,32(sp)
    80004d9e:	ec5e                	sd	s7,24(sp)
    80004da0:	e862                	sd	s8,16(sp)
    80004da2:	a819                	j	80004db8 <piperead+0x8a>
      release(&pi->lock);
    80004da4:	8526                	mv	a0,s1
    80004da6:	ffffc097          	auipc	ra,0xffffc
    80004daa:	e22080e7          	jalr	-478(ra) # 80000bc8 <release>
      return -1;
    80004dae:	59fd                	li	s3,-1
    80004db0:	a88d                	j	80004e22 <piperead+0xf4>
    80004db2:	f05a                	sd	s6,32(sp)
    80004db4:	ec5e                	sd	s7,24(sp)
    80004db6:	e862                	sd	s8,16(sp)
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80004db8:	4981                	li	s3,0
    if(pi->nread == pi->nwrite)
      break;
    ch = pi->data[pi->nread++ % PIPESIZE];
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    80004dba:	faf40c13          	addi	s8,s0,-81
    80004dbe:	4b85                	li	s7,1
    80004dc0:	5b7d                	li	s6,-1
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80004dc2:	05405263          	blez	s4,80004e06 <piperead+0xd8>
    if(pi->nread == pi->nwrite)
    80004dc6:	2204a783          	lw	a5,544(s1)
    80004dca:	2244a703          	lw	a4,548(s1)
    80004dce:	02f70c63          	beq	a4,a5,80004e06 <piperead+0xd8>
    ch = pi->data[pi->nread++ % PIPESIZE];
    80004dd2:	0017871b          	addiw	a4,a5,1
    80004dd6:	22e4a023          	sw	a4,544(s1)
    80004dda:	1ff7f793          	andi	a5,a5,511
    80004dde:	97a6                	add	a5,a5,s1
    80004de0:	0207c783          	lbu	a5,32(a5)
    80004de4:	faf407a3          	sb	a5,-81(s0)
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    80004de8:	86de                	mv	a3,s7
    80004dea:	8662                	mv	a2,s8
    80004dec:	85ca                	mv	a1,s2
    80004dee:	058ab503          	ld	a0,88(s5)
    80004df2:	ffffd097          	auipc	ra,0xffffd
    80004df6:	9d2080e7          	jalr	-1582(ra) # 800017c4 <copyout>
    80004dfa:	01650663          	beq	a0,s6,80004e06 <piperead+0xd8>
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80004dfe:	2985                	addiw	s3,s3,1
    80004e00:	0905                	addi	s2,s2,1
    80004e02:	fd3a12e3          	bne	s4,s3,80004dc6 <piperead+0x98>
      break;
  }
  wakeup(&pi->nwrite);  //DOC: piperead-wakeup
    80004e06:	22448513          	addi	a0,s1,548
    80004e0a:	ffffd097          	auipc	ra,0xffffd
    80004e0e:	634080e7          	jalr	1588(ra) # 8000243e <wakeup>
  release(&pi->lock);
    80004e12:	8526                	mv	a0,s1
    80004e14:	ffffc097          	auipc	ra,0xffffc
    80004e18:	db4080e7          	jalr	-588(ra) # 80000bc8 <release>
    80004e1c:	7b02                	ld	s6,32(sp)
    80004e1e:	6be2                	ld	s7,24(sp)
    80004e20:	6c42                	ld	s8,16(sp)
  return i;
}
    80004e22:	854e                	mv	a0,s3
    80004e24:	60e6                	ld	ra,88(sp)
    80004e26:	6446                	ld	s0,80(sp)
    80004e28:	64a6                	ld	s1,72(sp)
    80004e2a:	6906                	ld	s2,64(sp)
    80004e2c:	79e2                	ld	s3,56(sp)
    80004e2e:	7a42                	ld	s4,48(sp)
    80004e30:	7aa2                	ld	s5,40(sp)
    80004e32:	6125                	addi	sp,sp,96
    80004e34:	8082                	ret

0000000080004e36 <exec>:

static int loadseg(pde_t *pgdir, uint64 addr, struct inode *ip, uint offset, uint sz);

int
exec(char *path, char **argv)
{
    80004e36:	de010113          	addi	sp,sp,-544
    80004e3a:	20113c23          	sd	ra,536(sp)
    80004e3e:	20813823          	sd	s0,528(sp)
    80004e42:	20913423          	sd	s1,520(sp)
    80004e46:	21213023          	sd	s2,512(sp)
    80004e4a:	1400                	addi	s0,sp,544
    80004e4c:	892a                	mv	s2,a0
    80004e4e:	dea43823          	sd	a0,-528(s0)
    80004e52:	deb43c23          	sd	a1,-520(s0)
  uint64 argc, sz, sp, ustack[MAXARG+1], stackbase;
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pagetable_t pagetable = 0, oldpagetable;
  struct proc *p = myproc();
    80004e56:	ffffd097          	auipc	ra,0xffffd
    80004e5a:	caa080e7          	jalr	-854(ra) # 80001b00 <myproc>
    80004e5e:	84aa                	mv	s1,a0

  begin_op(ROOTDEV);
    80004e60:	4501                	li	a0,0
    80004e62:	fffff097          	auipc	ra,0xfffff
    80004e66:	318080e7          	jalr	792(ra) # 8000417a <begin_op>

  if((ip = namei(path)) == 0){
    80004e6a:	854a                	mv	a0,s2
    80004e6c:	fffff097          	auipc	ra,0xfffff
    80004e70:	0bc080e7          	jalr	188(ra) # 80003f28 <namei>
    80004e74:	c52d                	beqz	a0,80004ede <exec+0xa8>
    80004e76:	fbd2                	sd	s4,496(sp)
    80004e78:	8a2a                	mv	s4,a0
    end_op(ROOTDEV);
    return -1;
  }
  ilock(ip);
    80004e7a:	fffff097          	auipc	ra,0xfffff
    80004e7e:	8f2080e7          	jalr	-1806(ra) # 8000376c <ilock>

  // Check ELF header
  if(readi(ip, 0, (uint64)&elf, 0, sizeof(elf)) != sizeof(elf))
    80004e82:	04000713          	li	a4,64
    80004e86:	4681                	li	a3,0
    80004e88:	e4840613          	addi	a2,s0,-440
    80004e8c:	4581                	li	a1,0
    80004e8e:	8552                	mv	a0,s4
    80004e90:	fffff097          	auipc	ra,0xfffff
    80004e94:	b76080e7          	jalr	-1162(ra) # 80003a06 <readi>
    80004e98:	04000793          	li	a5,64
    80004e9c:	00f51a63          	bne	a0,a5,80004eb0 <exec+0x7a>
    goto bad;
  if(elf.magic != ELF_MAGIC)
    80004ea0:	e4842703          	lw	a4,-440(s0)
    80004ea4:	464c47b7          	lui	a5,0x464c4
    80004ea8:	57f78793          	addi	a5,a5,1407 # 464c457f <_entry-0x39b3ba81>
    80004eac:	04f70063          	beq	a4,a5,80004eec <exec+0xb6>

 bad:
  if(pagetable)
    proc_freepagetable(pagetable, sz);
  if(ip){
    iunlockput(ip);
    80004eb0:	8552                	mv	a0,s4
    80004eb2:	fffff097          	auipc	ra,0xfffff
    80004eb6:	afe080e7          	jalr	-1282(ra) # 800039b0 <iunlockput>
    end_op(ROOTDEV);
    80004eba:	4501                	li	a0,0
    80004ebc:	fffff097          	auipc	ra,0xfffff
    80004ec0:	360080e7          	jalr	864(ra) # 8000421c <end_op>
  }
  return -1;
    80004ec4:	557d                	li	a0,-1
    80004ec6:	7a5e                	ld	s4,496(sp)
}
    80004ec8:	21813083          	ld	ra,536(sp)
    80004ecc:	21013403          	ld	s0,528(sp)
    80004ed0:	20813483          	ld	s1,520(sp)
    80004ed4:	20013903          	ld	s2,512(sp)
    80004ed8:	22010113          	addi	sp,sp,544
    80004edc:	8082                	ret
    end_op(ROOTDEV);
    80004ede:	4501                	li	a0,0
    80004ee0:	fffff097          	auipc	ra,0xfffff
    80004ee4:	33c080e7          	jalr	828(ra) # 8000421c <end_op>
    return -1;
    80004ee8:	557d                	li	a0,-1
    80004eea:	bff9                	j	80004ec8 <exec+0x92>
    80004eec:	f3da                	sd	s6,480(sp)
  if((pagetable = proc_pagetable(p)) == 0)
    80004eee:	8526                	mv	a0,s1
    80004ef0:	ffffd097          	auipc	ra,0xffffd
    80004ef4:	cd6080e7          	jalr	-810(ra) # 80001bc6 <proc_pagetable>
    80004ef8:	8b2a                	mv	s6,a0
    80004efa:	2a050763          	beqz	a0,800051a8 <exec+0x372>
    80004efe:	ffce                	sd	s3,504(sp)
    80004f00:	f7d6                	sd	s5,488(sp)
    80004f02:	efde                	sd	s7,472(sp)
    80004f04:	ebe2                	sd	s8,464(sp)
    80004f06:	e7e6                	sd	s9,456(sp)
    80004f08:	e3ea                	sd	s10,448(sp)
    80004f0a:	ff6e                	sd	s11,440(sp)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80004f0c:	e8045783          	lhu	a5,-384(s0)
    80004f10:	cbf5                	beqz	a5,80005004 <exec+0x1ce>
    80004f12:	e6842683          	lw	a3,-408(s0)
  sz = 0;
    80004f16:	e0043023          	sd	zero,-512(s0)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80004f1a:	4d01                	li	s10,0
    if(readi(ip, 0, (uint64)&ph, off, sizeof(ph)) != sizeof(ph))
    80004f1c:	03800d93          	li	s11,56
    if(ph.vaddr % PGSIZE != 0)
    80004f20:	6c85                	lui	s9,0x1
    80004f22:	fffc8793          	addi	a5,s9,-1 # fff <_entry-0x7ffff001>
    80004f26:	def43423          	sd	a5,-536(s0)

  for(i = 0; i < sz; i += PGSIZE){
    pa = walkaddr(pagetable, va + i);
    if(pa == 0)
      panic("loadseg: address should exist");
    if(sz - i < PGSIZE)
    80004f2a:	6a85                	lui	s5,0x1
    80004f2c:	a0a5                	j	80004f94 <exec+0x15e>
      panic("loadseg: address should exist");
    80004f2e:	00004517          	auipc	a0,0x4
    80004f32:	b5250513          	addi	a0,a0,-1198 # 80008a80 <userret+0x9f0>
    80004f36:	ffffb097          	auipc	ra,0xffffb
    80004f3a:	634080e7          	jalr	1588(ra) # 8000056a <panic>
    if(sz - i < PGSIZE)
    80004f3e:	2901                	sext.w	s2,s2
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, 0, (uint64)pa, offset+i, n) != n)
    80004f40:	874a                	mv	a4,s2
    80004f42:	009c06bb          	addw	a3,s8,s1
    80004f46:	4581                	li	a1,0
    80004f48:	8552                	mv	a0,s4
    80004f4a:	fffff097          	auipc	ra,0xfffff
    80004f4e:	abc080e7          	jalr	-1348(ra) # 80003a06 <readi>
    80004f52:	24a91d63          	bne	s2,a0,800051ac <exec+0x376>
  for(i = 0; i < sz; i += PGSIZE){
    80004f56:	009a84bb          	addw	s1,s5,s1
    80004f5a:	0334f463          	bgeu	s1,s3,80004f82 <exec+0x14c>
    pa = walkaddr(pagetable, va + i);
    80004f5e:	02049593          	slli	a1,s1,0x20
    80004f62:	9181                	srli	a1,a1,0x20
    80004f64:	95de                	add	a1,a1,s7
    80004f66:	855a                	mv	a0,s6
    80004f68:	ffffc097          	auipc	ra,0xffffc
    80004f6c:	270080e7          	jalr	624(ra) # 800011d8 <walkaddr>
    80004f70:	862a                	mv	a2,a0
    if(pa == 0)
    80004f72:	dd55                	beqz	a0,80004f2e <exec+0xf8>
    if(sz - i < PGSIZE)
    80004f74:	409987bb          	subw	a5,s3,s1
    80004f78:	893e                	mv	s2,a5
    80004f7a:	fcfcf2e3          	bgeu	s9,a5,80004f3e <exec+0x108>
    80004f7e:	8956                	mv	s2,s5
    80004f80:	bf7d                	j	80004f3e <exec+0x108>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80004f82:	2d05                	addiw	s10,s10,1
    80004f84:	e0843783          	ld	a5,-504(s0)
    80004f88:	0387869b          	addiw	a3,a5,56
    80004f8c:	e8045783          	lhu	a5,-384(s0)
    80004f90:	06fd5c63          	bge	s10,a5,80005008 <exec+0x1d2>
    if(readi(ip, 0, (uint64)&ph, off, sizeof(ph)) != sizeof(ph))
    80004f94:	e0d43423          	sd	a3,-504(s0)
    80004f98:	876e                	mv	a4,s11
    80004f9a:	e1040613          	addi	a2,s0,-496
    80004f9e:	4581                	li	a1,0
    80004fa0:	8552                	mv	a0,s4
    80004fa2:	fffff097          	auipc	ra,0xfffff
    80004fa6:	a64080e7          	jalr	-1436(ra) # 80003a06 <readi>
    80004faa:	21b51163          	bne	a0,s11,800051ac <exec+0x376>
    if(ph.type != ELF_PROG_LOAD)
    80004fae:	e1042783          	lw	a5,-496(s0)
    80004fb2:	4705                	li	a4,1
    80004fb4:	fce797e3          	bne	a5,a4,80004f82 <exec+0x14c>
    if(ph.memsz < ph.filesz)
    80004fb8:	e3843603          	ld	a2,-456(s0)
    80004fbc:	e3043783          	ld	a5,-464(s0)
    80004fc0:	1ef66663          	bltu	a2,a5,800051ac <exec+0x376>
    if(ph.vaddr + ph.memsz < ph.vaddr)
    80004fc4:	e2043783          	ld	a5,-480(s0)
    80004fc8:	963e                	add	a2,a2,a5
    80004fca:	1ef66163          	bltu	a2,a5,800051ac <exec+0x376>
    if((sz = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz)) == 0)
    80004fce:	e0043583          	ld	a1,-512(s0)
    80004fd2:	855a                	mv	a0,s6
    80004fd4:	ffffc097          	auipc	ra,0xffffc
    80004fd8:	604080e7          	jalr	1540(ra) # 800015d8 <uvmalloc>
    80004fdc:	e0a43023          	sd	a0,-512(s0)
    80004fe0:	1c050663          	beqz	a0,800051ac <exec+0x376>
    if(ph.vaddr % PGSIZE != 0)
    80004fe4:	e2043b83          	ld	s7,-480(s0)
    80004fe8:	de843783          	ld	a5,-536(s0)
    80004fec:	00fbf7b3          	and	a5,s7,a5
    80004ff0:	1a079e63          	bnez	a5,800051ac <exec+0x376>
    if(loadseg(pagetable, ph.vaddr, ip, ph.off, ph.filesz) < 0)
    80004ff4:	e3042983          	lw	s3,-464(s0)
  for(i = 0; i < sz; i += PGSIZE){
    80004ff8:	f80985e3          	beqz	s3,80004f82 <exec+0x14c>
    if(loadseg(pagetable, ph.vaddr, ip, ph.off, ph.filesz) < 0)
    80004ffc:	e1842c03          	lw	s8,-488(s0)
  for(i = 0; i < sz; i += PGSIZE){
    80005000:	4481                	li	s1,0
    80005002:	bfb1                	j	80004f5e <exec+0x128>
  sz = 0;
    80005004:	e0043023          	sd	zero,-512(s0)
  iunlockput(ip);
    80005008:	8552                	mv	a0,s4
    8000500a:	fffff097          	auipc	ra,0xfffff
    8000500e:	9a6080e7          	jalr	-1626(ra) # 800039b0 <iunlockput>
  end_op(ROOTDEV);
    80005012:	4501                	li	a0,0
    80005014:	fffff097          	auipc	ra,0xfffff
    80005018:	208080e7          	jalr	520(ra) # 8000421c <end_op>
  p = myproc();
    8000501c:	ffffd097          	auipc	ra,0xffffd
    80005020:	ae4080e7          	jalr	-1308(ra) # 80001b00 <myproc>
    80005024:	8aaa                	mv	s5,a0
  uint64 oldsz = p->sz;
    80005026:	05053d03          	ld	s10,80(a0)
  sz = PGROUNDUP(sz);
    8000502a:	6585                	lui	a1,0x1
    8000502c:	15fd                	addi	a1,a1,-1 # fff <_entry-0x7ffff001>
    8000502e:	e0043783          	ld	a5,-512(s0)
    80005032:	95be                	add	a1,a1,a5
    80005034:	77fd                	lui	a5,0xfffff
    80005036:	8dfd                	and	a1,a1,a5
  if((sz = uvmalloc(pagetable, sz, sz + 2*PGSIZE)) == 0)
    80005038:	6609                	lui	a2,0x2
    8000503a:	962e                	add	a2,a2,a1
    8000503c:	855a                	mv	a0,s6
    8000503e:	ffffc097          	auipc	ra,0xffffc
    80005042:	59a080e7          	jalr	1434(ra) # 800015d8 <uvmalloc>
    80005046:	8a2a                	mv	s4,a0
    80005048:	e115                	bnez	a0,8000506c <exec+0x236>
    proc_freepagetable(pagetable, sz);
    8000504a:	85d2                	mv	a1,s4
    8000504c:	855a                	mv	a0,s6
    8000504e:	ffffd097          	auipc	ra,0xffffd
    80005052:	c78080e7          	jalr	-904(ra) # 80001cc6 <proc_freepagetable>
  return -1;
    80005056:	557d                	li	a0,-1
    80005058:	79fe                	ld	s3,504(sp)
    8000505a:	7a5e                	ld	s4,496(sp)
    8000505c:	7abe                	ld	s5,488(sp)
    8000505e:	7b1e                	ld	s6,480(sp)
    80005060:	6bfe                	ld	s7,472(sp)
    80005062:	6c5e                	ld	s8,464(sp)
    80005064:	6cbe                	ld	s9,456(sp)
    80005066:	6d1e                	ld	s10,448(sp)
    80005068:	7dfa                	ld	s11,440(sp)
    8000506a:	bdb9                	j	80004ec8 <exec+0x92>
  uvmclear(pagetable, sz-2*PGSIZE);
    8000506c:	75f9                	lui	a1,0xffffe
    8000506e:	95aa                	add	a1,a1,a0
    80005070:	855a                	mv	a0,s6
    80005072:	ffffc097          	auipc	ra,0xffffc
    80005076:	720080e7          	jalr	1824(ra) # 80001792 <uvmclear>
  stackbase = sp - PGSIZE;
    8000507a:	800a0b93          	addi	s7,s4,-2048
    8000507e:	800b8b93          	addi	s7,s7,-2048
  for(argc = 0; argv[argc]; argc++) {
    80005082:	df843783          	ld	a5,-520(s0)
    80005086:	6388                	ld	a0,0(a5)
  sp = sz;
    80005088:	8952                	mv	s2,s4
  for(argc = 0; argv[argc]; argc++) {
    8000508a:	4481                	li	s1,0
    ustack[argc] = sp;
    8000508c:	e8840c93          	addi	s9,s0,-376
    if(argc >= MAXARG)
    80005090:	02000c13          	li	s8,32
  for(argc = 0; argv[argc]; argc++) {
    80005094:	c12d                	beqz	a0,800050f6 <exec+0x2c0>
    sp -= strlen(argv[argc]) + 1;
    80005096:	ffffc097          	auipc	ra,0xffffc
    8000509a:	eb8080e7          	jalr	-328(ra) # 80000f4e <strlen>
    8000509e:	0015079b          	addiw	a5,a0,1
    800050a2:	40f907b3          	sub	a5,s2,a5
    sp -= sp % 16; // riscv sp must be 16-byte aligned
    800050a6:	ff07f913          	andi	s2,a5,-16
    if(sp < stackbase)
    800050aa:	fb7960e3          	bltu	s2,s7,8000504a <exec+0x214>
    if(copyout(pagetable, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
    800050ae:	df843d83          	ld	s11,-520(s0)
    800050b2:	000db983          	ld	s3,0(s11)
    800050b6:	854e                	mv	a0,s3
    800050b8:	ffffc097          	auipc	ra,0xffffc
    800050bc:	e96080e7          	jalr	-362(ra) # 80000f4e <strlen>
    800050c0:	0015069b          	addiw	a3,a0,1
    800050c4:	864e                	mv	a2,s3
    800050c6:	85ca                	mv	a1,s2
    800050c8:	855a                	mv	a0,s6
    800050ca:	ffffc097          	auipc	ra,0xffffc
    800050ce:	6fa080e7          	jalr	1786(ra) # 800017c4 <copyout>
    800050d2:	f6054ce3          	bltz	a0,8000504a <exec+0x214>
    ustack[argc] = sp;
    800050d6:	00349793          	slli	a5,s1,0x3
    800050da:	97e6                	add	a5,a5,s9
    800050dc:	0127b023          	sd	s2,0(a5) # fffffffffffff000 <end+0xffffffff7ffd6fa4>
  for(argc = 0; argv[argc]; argc++) {
    800050e0:	0485                	addi	s1,s1,1
    800050e2:	008d8793          	addi	a5,s11,8
    800050e6:	def43c23          	sd	a5,-520(s0)
    800050ea:	008db503          	ld	a0,8(s11)
    800050ee:	c501                	beqz	a0,800050f6 <exec+0x2c0>
    if(argc >= MAXARG)
    800050f0:	fb8493e3          	bne	s1,s8,80005096 <exec+0x260>
    800050f4:	bf99                	j	8000504a <exec+0x214>
  ustack[argc] = 0;
    800050f6:	00349793          	slli	a5,s1,0x3
    800050fa:	f9078793          	addi	a5,a5,-112
    800050fe:	97a2                	add	a5,a5,s0
    80005100:	ee07bc23          	sd	zero,-264(a5)
  sp -= (argc+1) * sizeof(uint64);
    80005104:	00349693          	slli	a3,s1,0x3
    80005108:	06a1                	addi	a3,a3,8
    8000510a:	40d90933          	sub	s2,s2,a3
  sp -= sp % 16;
    8000510e:	ff097913          	andi	s2,s2,-16
  if(sp < stackbase)
    80005112:	f3796ce3          	bltu	s2,s7,8000504a <exec+0x214>
  if(copyout(pagetable, sp, (char *)ustack, (argc+1)*sizeof(uint64)) < 0)
    80005116:	e8840613          	addi	a2,s0,-376
    8000511a:	85ca                	mv	a1,s2
    8000511c:	855a                	mv	a0,s6
    8000511e:	ffffc097          	auipc	ra,0xffffc
    80005122:	6a6080e7          	jalr	1702(ra) # 800017c4 <copyout>
    80005126:	f20542e3          	bltz	a0,8000504a <exec+0x214>
  p->tf->a1 = sp;
    8000512a:	060ab783          	ld	a5,96(s5) # 1060 <_entry-0x7fffefa0>
    8000512e:	0727bc23          	sd	s2,120(a5)
  for(last=s=path; *s; s++)
    80005132:	df043783          	ld	a5,-528(s0)
    80005136:	0007c703          	lbu	a4,0(a5)
    8000513a:	cf11                	beqz	a4,80005156 <exec+0x320>
    8000513c:	0785                	addi	a5,a5,1
    if(*s == '/')
    8000513e:	02f00693          	li	a3,47
    80005142:	a029                	j	8000514c <exec+0x316>
  for(last=s=path; *s; s++)
    80005144:	0785                	addi	a5,a5,1
    80005146:	fff7c703          	lbu	a4,-1(a5)
    8000514a:	c711                	beqz	a4,80005156 <exec+0x320>
    if(*s == '/')
    8000514c:	fed71ce3          	bne	a4,a3,80005144 <exec+0x30e>
      last = s+1;
    80005150:	def43823          	sd	a5,-528(s0)
    80005154:	bfc5                	j	80005144 <exec+0x30e>
  safestrcpy(p->name, last, sizeof(p->name));
    80005156:	4641                	li	a2,16
    80005158:	df043583          	ld	a1,-528(s0)
    8000515c:	160a8513          	addi	a0,s5,352
    80005160:	ffffc097          	auipc	ra,0xffffc
    80005164:	db8080e7          	jalr	-584(ra) # 80000f18 <safestrcpy>
  oldpagetable = p->pagetable;
    80005168:	058ab503          	ld	a0,88(s5)
  p->pagetable = pagetable;
    8000516c:	056abc23          	sd	s6,88(s5)
  p->sz = sz;
    80005170:	054ab823          	sd	s4,80(s5)
  p->tf->epc = elf.entry;  // initial program counter = main
    80005174:	060ab783          	ld	a5,96(s5)
    80005178:	e6043703          	ld	a4,-416(s0)
    8000517c:	ef98                	sd	a4,24(a5)
  p->tf->sp = sp; // initial stack pointer
    8000517e:	060ab783          	ld	a5,96(s5)
    80005182:	0327b823          	sd	s2,48(a5)
  proc_freepagetable(oldpagetable, oldsz);
    80005186:	85ea                	mv	a1,s10
    80005188:	ffffd097          	auipc	ra,0xffffd
    8000518c:	b3e080e7          	jalr	-1218(ra) # 80001cc6 <proc_freepagetable>
  return argc; // this ends up in a0, the first argument to main(argc, argv)
    80005190:	0004851b          	sext.w	a0,s1
    80005194:	79fe                	ld	s3,504(sp)
    80005196:	7a5e                	ld	s4,496(sp)
    80005198:	7abe                	ld	s5,488(sp)
    8000519a:	7b1e                	ld	s6,480(sp)
    8000519c:	6bfe                	ld	s7,472(sp)
    8000519e:	6c5e                	ld	s8,464(sp)
    800051a0:	6cbe                	ld	s9,456(sp)
    800051a2:	6d1e                	ld	s10,448(sp)
    800051a4:	7dfa                	ld	s11,440(sp)
    800051a6:	b30d                	j	80004ec8 <exec+0x92>
    800051a8:	7b1e                	ld	s6,480(sp)
    800051aa:	b319                	j	80004eb0 <exec+0x7a>
    proc_freepagetable(pagetable, sz);
    800051ac:	e0043583          	ld	a1,-512(s0)
    800051b0:	855a                	mv	a0,s6
    800051b2:	ffffd097          	auipc	ra,0xffffd
    800051b6:	b14080e7          	jalr	-1260(ra) # 80001cc6 <proc_freepagetable>
  if(ip){
    800051ba:	79fe                	ld	s3,504(sp)
    800051bc:	7abe                	ld	s5,488(sp)
    800051be:	7b1e                	ld	s6,480(sp)
    800051c0:	6bfe                	ld	s7,472(sp)
    800051c2:	6c5e                	ld	s8,464(sp)
    800051c4:	6cbe                	ld	s9,456(sp)
    800051c6:	6d1e                	ld	s10,448(sp)
    800051c8:	7dfa                	ld	s11,440(sp)
    800051ca:	b1dd                	j	80004eb0 <exec+0x7a>

00000000800051cc <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
    800051cc:	7179                	addi	sp,sp,-48
    800051ce:	f406                	sd	ra,40(sp)
    800051d0:	f022                	sd	s0,32(sp)
    800051d2:	ec26                	sd	s1,24(sp)
    800051d4:	e84a                	sd	s2,16(sp)
    800051d6:	1800                	addi	s0,sp,48
    800051d8:	892e                	mv	s2,a1
    800051da:	84b2                	mv	s1,a2
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    800051dc:	fdc40593          	addi	a1,s0,-36
    800051e0:	ffffe097          	auipc	ra,0xffffe
    800051e4:	a40080e7          	jalr	-1472(ra) # 80002c20 <argint>
    800051e8:	04054163          	bltz	a0,8000522a <argfd+0x5e>
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
    800051ec:	fdc42703          	lw	a4,-36(s0)
    800051f0:	47bd                	li	a5,15
    800051f2:	02e7ee63          	bltu	a5,a4,8000522e <argfd+0x62>
    800051f6:	ffffd097          	auipc	ra,0xffffd
    800051fa:	90a080e7          	jalr	-1782(ra) # 80001b00 <myproc>
    800051fe:	fdc42703          	lw	a4,-36(s0)
    80005202:	00371793          	slli	a5,a4,0x3
    80005206:	0d078793          	addi	a5,a5,208
    8000520a:	953e                	add	a0,a0,a5
    8000520c:	651c                	ld	a5,8(a0)
    8000520e:	c395                	beqz	a5,80005232 <argfd+0x66>
    return -1;
  if(pfd)
    80005210:	00090463          	beqz	s2,80005218 <argfd+0x4c>
    *pfd = fd;
    80005214:	00e92023          	sw	a4,0(s2)
  if(pf)
    *pf = f;
  return 0;
    80005218:	4501                	li	a0,0
  if(pf)
    8000521a:	c091                	beqz	s1,8000521e <argfd+0x52>
    *pf = f;
    8000521c:	e09c                	sd	a5,0(s1)
}
    8000521e:	70a2                	ld	ra,40(sp)
    80005220:	7402                	ld	s0,32(sp)
    80005222:	64e2                	ld	s1,24(sp)
    80005224:	6942                	ld	s2,16(sp)
    80005226:	6145                	addi	sp,sp,48
    80005228:	8082                	ret
    return -1;
    8000522a:	557d                	li	a0,-1
    8000522c:	bfcd                	j	8000521e <argfd+0x52>
    return -1;
    8000522e:	557d                	li	a0,-1
    80005230:	b7fd                	j	8000521e <argfd+0x52>
    80005232:	557d                	li	a0,-1
    80005234:	b7ed                	j	8000521e <argfd+0x52>

0000000080005236 <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
    80005236:	1101                	addi	sp,sp,-32
    80005238:	ec06                	sd	ra,24(sp)
    8000523a:	e822                	sd	s0,16(sp)
    8000523c:	e426                	sd	s1,8(sp)
    8000523e:	1000                	addi	s0,sp,32
    80005240:	84aa                	mv	s1,a0
  int fd;
  struct proc *p = myproc();
    80005242:	ffffd097          	auipc	ra,0xffffd
    80005246:	8be080e7          	jalr	-1858(ra) # 80001b00 <myproc>
    8000524a:	862a                	mv	a2,a0

  for(fd = 0; fd < NOFILE; fd++){
    8000524c:	0d850793          	addi	a5,a0,216
    80005250:	4501                	li	a0,0
    80005252:	46c1                	li	a3,16
    if(p->ofile[fd] == 0){
    80005254:	6398                	ld	a4,0(a5)
    80005256:	cb19                	beqz	a4,8000526c <fdalloc+0x36>
  for(fd = 0; fd < NOFILE; fd++){
    80005258:	2505                	addiw	a0,a0,1
    8000525a:	07a1                	addi	a5,a5,8
    8000525c:	fed51ce3          	bne	a0,a3,80005254 <fdalloc+0x1e>
      p->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
    80005260:	557d                	li	a0,-1
}
    80005262:	60e2                	ld	ra,24(sp)
    80005264:	6442                	ld	s0,16(sp)
    80005266:	64a2                	ld	s1,8(sp)
    80005268:	6105                	addi	sp,sp,32
    8000526a:	8082                	ret
      p->ofile[fd] = f;
    8000526c:	00351793          	slli	a5,a0,0x3
    80005270:	0d078793          	addi	a5,a5,208
    80005274:	963e                	add	a2,a2,a5
    80005276:	e604                	sd	s1,8(a2)
      return fd;
    80005278:	b7ed                	j	80005262 <fdalloc+0x2c>

000000008000527a <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
    8000527a:	715d                	addi	sp,sp,-80
    8000527c:	e486                	sd	ra,72(sp)
    8000527e:	e0a2                	sd	s0,64(sp)
    80005280:	fc26                	sd	s1,56(sp)
    80005282:	f84a                	sd	s2,48(sp)
    80005284:	f44e                	sd	s3,40(sp)
    80005286:	f052                	sd	s4,32(sp)
    80005288:	ec56                	sd	s5,24(sp)
    8000528a:	0880                	addi	s0,sp,80
    8000528c:	89ae                	mv	s3,a1
    8000528e:	8a32                	mv	s4,a2
    80005290:	8ab6                	mv	s5,a3
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    80005292:	fb040593          	addi	a1,s0,-80
    80005296:	fffff097          	auipc	ra,0xfffff
    8000529a:	cb0080e7          	jalr	-848(ra) # 80003f46 <nameiparent>
    8000529e:	892a                	mv	s2,a0
    800052a0:	12050d63          	beqz	a0,800053da <create+0x160>
    return 0;

  ilock(dp);
    800052a4:	ffffe097          	auipc	ra,0xffffe
    800052a8:	4c8080e7          	jalr	1224(ra) # 8000376c <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
    800052ac:	4601                	li	a2,0
    800052ae:	fb040593          	addi	a1,s0,-80
    800052b2:	854a                	mv	a0,s2
    800052b4:	fffff097          	auipc	ra,0xfffff
    800052b8:	970080e7          	jalr	-1680(ra) # 80003c24 <dirlookup>
    800052bc:	84aa                	mv	s1,a0
    800052be:	c539                	beqz	a0,8000530c <create+0x92>
    iunlockput(dp);
    800052c0:	854a                	mv	a0,s2
    800052c2:	ffffe097          	auipc	ra,0xffffe
    800052c6:	6ee080e7          	jalr	1774(ra) # 800039b0 <iunlockput>
    ilock(ip);
    800052ca:	8526                	mv	a0,s1
    800052cc:	ffffe097          	auipc	ra,0xffffe
    800052d0:	4a0080e7          	jalr	1184(ra) # 8000376c <ilock>
    if(type == T_FILE && (ip->type == T_FILE || ip->type == T_DEVICE))
    800052d4:	4789                	li	a5,2
    800052d6:	02f99463          	bne	s3,a5,800052fe <create+0x84>
    800052da:	04c4d783          	lhu	a5,76(s1)
    800052de:	37f9                	addiw	a5,a5,-2
    800052e0:	17c2                	slli	a5,a5,0x30
    800052e2:	93c1                	srli	a5,a5,0x30
    800052e4:	4705                	li	a4,1
    800052e6:	00f76c63          	bltu	a4,a5,800052fe <create+0x84>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
    800052ea:	8526                	mv	a0,s1
    800052ec:	60a6                	ld	ra,72(sp)
    800052ee:	6406                	ld	s0,64(sp)
    800052f0:	74e2                	ld	s1,56(sp)
    800052f2:	7942                	ld	s2,48(sp)
    800052f4:	79a2                	ld	s3,40(sp)
    800052f6:	7a02                	ld	s4,32(sp)
    800052f8:	6ae2                	ld	s5,24(sp)
    800052fa:	6161                	addi	sp,sp,80
    800052fc:	8082                	ret
    iunlockput(ip);
    800052fe:	8526                	mv	a0,s1
    80005300:	ffffe097          	auipc	ra,0xffffe
    80005304:	6b0080e7          	jalr	1712(ra) # 800039b0 <iunlockput>
    return 0;
    80005308:	4481                	li	s1,0
    8000530a:	b7c5                	j	800052ea <create+0x70>
  if((ip = ialloc(dp->dev, type)) == 0)
    8000530c:	85ce                	mv	a1,s3
    8000530e:	00092503          	lw	a0,0(s2)
    80005312:	ffffe097          	auipc	ra,0xffffe
    80005316:	2c6080e7          	jalr	710(ra) # 800035d8 <ialloc>
    8000531a:	84aa                	mv	s1,a0
    8000531c:	c521                	beqz	a0,80005364 <create+0xea>
  ilock(ip);
    8000531e:	ffffe097          	auipc	ra,0xffffe
    80005322:	44e080e7          	jalr	1102(ra) # 8000376c <ilock>
  ip->major = major;
    80005326:	05449723          	sh	s4,78(s1)
  ip->minor = minor;
    8000532a:	05549823          	sh	s5,80(s1)
  ip->nlink = 1;
    8000532e:	4785                	li	a5,1
    80005330:	04f49923          	sh	a5,82(s1)
  iupdate(ip);
    80005334:	8526                	mv	a0,s1
    80005336:	ffffe097          	auipc	ra,0xffffe
    8000533a:	36a080e7          	jalr	874(ra) # 800036a0 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
    8000533e:	4705                	li	a4,1
    80005340:	02e98a63          	beq	s3,a4,80005374 <create+0xfa>
  if(dirlink(dp, name, ip->inum) < 0)
    80005344:	40d0                	lw	a2,4(s1)
    80005346:	fb040593          	addi	a1,s0,-80
    8000534a:	854a                	mv	a0,s2
    8000534c:	fffff097          	auipc	ra,0xfffff
    80005350:	b06080e7          	jalr	-1274(ra) # 80003e52 <dirlink>
    80005354:	06054b63          	bltz	a0,800053ca <create+0x150>
  iunlockput(dp);
    80005358:	854a                	mv	a0,s2
    8000535a:	ffffe097          	auipc	ra,0xffffe
    8000535e:	656080e7          	jalr	1622(ra) # 800039b0 <iunlockput>
  return ip;
    80005362:	b761                	j	800052ea <create+0x70>
    panic("create: ialloc");
    80005364:	00003517          	auipc	a0,0x3
    80005368:	73c50513          	addi	a0,a0,1852 # 80008aa0 <userret+0xa10>
    8000536c:	ffffb097          	auipc	ra,0xffffb
    80005370:	1fe080e7          	jalr	510(ra) # 8000056a <panic>
    dp->nlink++;  // for ".."
    80005374:	05295783          	lhu	a5,82(s2)
    80005378:	2785                	addiw	a5,a5,1
    8000537a:	04f91923          	sh	a5,82(s2)
    iupdate(dp);
    8000537e:	854a                	mv	a0,s2
    80005380:	ffffe097          	auipc	ra,0xffffe
    80005384:	320080e7          	jalr	800(ra) # 800036a0 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
    80005388:	40d0                	lw	a2,4(s1)
    8000538a:	00003597          	auipc	a1,0x3
    8000538e:	72658593          	addi	a1,a1,1830 # 80008ab0 <userret+0xa20>
    80005392:	8526                	mv	a0,s1
    80005394:	fffff097          	auipc	ra,0xfffff
    80005398:	abe080e7          	jalr	-1346(ra) # 80003e52 <dirlink>
    8000539c:	00054f63          	bltz	a0,800053ba <create+0x140>
    800053a0:	00492603          	lw	a2,4(s2)
    800053a4:	00003597          	auipc	a1,0x3
    800053a8:	71458593          	addi	a1,a1,1812 # 80008ab8 <userret+0xa28>
    800053ac:	8526                	mv	a0,s1
    800053ae:	fffff097          	auipc	ra,0xfffff
    800053b2:	aa4080e7          	jalr	-1372(ra) # 80003e52 <dirlink>
    800053b6:	f80557e3          	bgez	a0,80005344 <create+0xca>
      panic("create dots");
    800053ba:	00003517          	auipc	a0,0x3
    800053be:	70650513          	addi	a0,a0,1798 # 80008ac0 <userret+0xa30>
    800053c2:	ffffb097          	auipc	ra,0xffffb
    800053c6:	1a8080e7          	jalr	424(ra) # 8000056a <panic>
    panic("create: dirlink");
    800053ca:	00003517          	auipc	a0,0x3
    800053ce:	70650513          	addi	a0,a0,1798 # 80008ad0 <userret+0xa40>
    800053d2:	ffffb097          	auipc	ra,0xffffb
    800053d6:	198080e7          	jalr	408(ra) # 8000056a <panic>
    return 0;
    800053da:	84aa                	mv	s1,a0
    800053dc:	b739                	j	800052ea <create+0x70>

00000000800053de <sys_dup>:
{
    800053de:	7179                	addi	sp,sp,-48
    800053e0:	f406                	sd	ra,40(sp)
    800053e2:	f022                	sd	s0,32(sp)
    800053e4:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0)
    800053e6:	fd840613          	addi	a2,s0,-40
    800053ea:	4581                	li	a1,0
    800053ec:	4501                	li	a0,0
    800053ee:	00000097          	auipc	ra,0x0
    800053f2:	dde080e7          	jalr	-546(ra) # 800051cc <argfd>
    return -1;
    800053f6:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0)
    800053f8:	02054763          	bltz	a0,80005426 <sys_dup+0x48>
    800053fc:	ec26                	sd	s1,24(sp)
    800053fe:	e84a                	sd	s2,16(sp)
  if((fd=fdalloc(f)) < 0)
    80005400:	fd843483          	ld	s1,-40(s0)
    80005404:	8526                	mv	a0,s1
    80005406:	00000097          	auipc	ra,0x0
    8000540a:	e30080e7          	jalr	-464(ra) # 80005236 <fdalloc>
    8000540e:	892a                	mv	s2,a0
    return -1;
    80005410:	57fd                	li	a5,-1
  if((fd=fdalloc(f)) < 0)
    80005412:	00054f63          	bltz	a0,80005430 <sys_dup+0x52>
  filedup(f);
    80005416:	8526                	mv	a0,s1
    80005418:	fffff097          	auipc	ra,0xfffff
    8000541c:	2ac080e7          	jalr	684(ra) # 800046c4 <filedup>
  return fd;
    80005420:	87ca                	mv	a5,s2
    80005422:	64e2                	ld	s1,24(sp)
    80005424:	6942                	ld	s2,16(sp)
}
    80005426:	853e                	mv	a0,a5
    80005428:	70a2                	ld	ra,40(sp)
    8000542a:	7402                	ld	s0,32(sp)
    8000542c:	6145                	addi	sp,sp,48
    8000542e:	8082                	ret
    80005430:	64e2                	ld	s1,24(sp)
    80005432:	6942                	ld	s2,16(sp)
    80005434:	bfcd                	j	80005426 <sys_dup+0x48>

0000000080005436 <sys_read>:
{
    80005436:	7179                	addi	sp,sp,-48
    80005438:	f406                	sd	ra,40(sp)
    8000543a:	f022                	sd	s0,32(sp)
    8000543c:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    8000543e:	fe840613          	addi	a2,s0,-24
    80005442:	4581                	li	a1,0
    80005444:	4501                	li	a0,0
    80005446:	00000097          	auipc	ra,0x0
    8000544a:	d86080e7          	jalr	-634(ra) # 800051cc <argfd>
    return -1;
    8000544e:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80005450:	04054163          	bltz	a0,80005492 <sys_read+0x5c>
    80005454:	fe440593          	addi	a1,s0,-28
    80005458:	4509                	li	a0,2
    8000545a:	ffffd097          	auipc	ra,0xffffd
    8000545e:	7c6080e7          	jalr	1990(ra) # 80002c20 <argint>
    return -1;
    80005462:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80005464:	02054763          	bltz	a0,80005492 <sys_read+0x5c>
    80005468:	fd840593          	addi	a1,s0,-40
    8000546c:	4505                	li	a0,1
    8000546e:	ffffd097          	auipc	ra,0xffffd
    80005472:	7d4080e7          	jalr	2004(ra) # 80002c42 <argaddr>
    return -1;
    80005476:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80005478:	00054d63          	bltz	a0,80005492 <sys_read+0x5c>
  return fileread(f, p, n);
    8000547c:	fe442603          	lw	a2,-28(s0)
    80005480:	fd843583          	ld	a1,-40(s0)
    80005484:	fe843503          	ld	a0,-24(s0)
    80005488:	fffff097          	auipc	ra,0xfffff
    8000548c:	3ee080e7          	jalr	1006(ra) # 80004876 <fileread>
    80005490:	87aa                	mv	a5,a0
}
    80005492:	853e                	mv	a0,a5
    80005494:	70a2                	ld	ra,40(sp)
    80005496:	7402                	ld	s0,32(sp)
    80005498:	6145                	addi	sp,sp,48
    8000549a:	8082                	ret

000000008000549c <sys_write>:
{
    8000549c:	7179                	addi	sp,sp,-48
    8000549e:	f406                	sd	ra,40(sp)
    800054a0:	f022                	sd	s0,32(sp)
    800054a2:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    800054a4:	fe840613          	addi	a2,s0,-24
    800054a8:	4581                	li	a1,0
    800054aa:	4501                	li	a0,0
    800054ac:	00000097          	auipc	ra,0x0
    800054b0:	d20080e7          	jalr	-736(ra) # 800051cc <argfd>
    return -1;
    800054b4:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    800054b6:	04054163          	bltz	a0,800054f8 <sys_write+0x5c>
    800054ba:	fe440593          	addi	a1,s0,-28
    800054be:	4509                	li	a0,2
    800054c0:	ffffd097          	auipc	ra,0xffffd
    800054c4:	760080e7          	jalr	1888(ra) # 80002c20 <argint>
    return -1;
    800054c8:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    800054ca:	02054763          	bltz	a0,800054f8 <sys_write+0x5c>
    800054ce:	fd840593          	addi	a1,s0,-40
    800054d2:	4505                	li	a0,1
    800054d4:	ffffd097          	auipc	ra,0xffffd
    800054d8:	76e080e7          	jalr	1902(ra) # 80002c42 <argaddr>
    return -1;
    800054dc:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    800054de:	00054d63          	bltz	a0,800054f8 <sys_write+0x5c>
  return filewrite(f, p, n);
    800054e2:	fe442603          	lw	a2,-28(s0)
    800054e6:	fd843583          	ld	a1,-40(s0)
    800054ea:	fe843503          	ld	a0,-24(s0)
    800054ee:	fffff097          	auipc	ra,0xfffff
    800054f2:	464080e7          	jalr	1124(ra) # 80004952 <filewrite>
    800054f6:	87aa                	mv	a5,a0
}
    800054f8:	853e                	mv	a0,a5
    800054fa:	70a2                	ld	ra,40(sp)
    800054fc:	7402                	ld	s0,32(sp)
    800054fe:	6145                	addi	sp,sp,48
    80005500:	8082                	ret

0000000080005502 <sys_close>:
{
    80005502:	1101                	addi	sp,sp,-32
    80005504:	ec06                	sd	ra,24(sp)
    80005506:	e822                	sd	s0,16(sp)
    80005508:	1000                	addi	s0,sp,32
  if(argfd(0, &fd, &f) < 0)
    8000550a:	fe040613          	addi	a2,s0,-32
    8000550e:	fec40593          	addi	a1,s0,-20
    80005512:	4501                	li	a0,0
    80005514:	00000097          	auipc	ra,0x0
    80005518:	cb8080e7          	jalr	-840(ra) # 800051cc <argfd>
    return -1;
    8000551c:	57fd                	li	a5,-1
  if(argfd(0, &fd, &f) < 0)
    8000551e:	02054563          	bltz	a0,80005548 <sys_close+0x46>
  myproc()->ofile[fd] = 0;
    80005522:	ffffc097          	auipc	ra,0xffffc
    80005526:	5de080e7          	jalr	1502(ra) # 80001b00 <myproc>
    8000552a:	fec42783          	lw	a5,-20(s0)
    8000552e:	078e                	slli	a5,a5,0x3
    80005530:	0d078793          	addi	a5,a5,208
    80005534:	953e                	add	a0,a0,a5
    80005536:	00053423          	sd	zero,8(a0)
  fileclose(f);
    8000553a:	fe043503          	ld	a0,-32(s0)
    8000553e:	fffff097          	auipc	ra,0xfffff
    80005542:	1d8080e7          	jalr	472(ra) # 80004716 <fileclose>
  return 0;
    80005546:	4781                	li	a5,0
}
    80005548:	853e                	mv	a0,a5
    8000554a:	60e2                	ld	ra,24(sp)
    8000554c:	6442                	ld	s0,16(sp)
    8000554e:	6105                	addi	sp,sp,32
    80005550:	8082                	ret

0000000080005552 <sys_fstat>:
{
    80005552:	1101                	addi	sp,sp,-32
    80005554:	ec06                	sd	ra,24(sp)
    80005556:	e822                	sd	s0,16(sp)
    80005558:	1000                	addi	s0,sp,32
  if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    8000555a:	fe840613          	addi	a2,s0,-24
    8000555e:	4581                	li	a1,0
    80005560:	4501                	li	a0,0
    80005562:	00000097          	auipc	ra,0x0
    80005566:	c6a080e7          	jalr	-918(ra) # 800051cc <argfd>
    return -1;
    8000556a:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    8000556c:	02054563          	bltz	a0,80005596 <sys_fstat+0x44>
    80005570:	fe040593          	addi	a1,s0,-32
    80005574:	4505                	li	a0,1
    80005576:	ffffd097          	auipc	ra,0xffffd
    8000557a:	6cc080e7          	jalr	1740(ra) # 80002c42 <argaddr>
    return -1;
    8000557e:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    80005580:	00054b63          	bltz	a0,80005596 <sys_fstat+0x44>
  return filestat(f, st);
    80005584:	fe043583          	ld	a1,-32(s0)
    80005588:	fe843503          	ld	a0,-24(s0)
    8000558c:	fffff097          	auipc	ra,0xfffff
    80005590:	274080e7          	jalr	628(ra) # 80004800 <filestat>
    80005594:	87aa                	mv	a5,a0
}
    80005596:	853e                	mv	a0,a5
    80005598:	60e2                	ld	ra,24(sp)
    8000559a:	6442                	ld	s0,16(sp)
    8000559c:	6105                	addi	sp,sp,32
    8000559e:	8082                	ret

00000000800055a0 <sys_link>:
{
    800055a0:	7169                	addi	sp,sp,-304
    800055a2:	f606                	sd	ra,296(sp)
    800055a4:	f222                	sd	s0,288(sp)
    800055a6:	1a00                	addi	s0,sp,304
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    800055a8:	08000613          	li	a2,128
    800055ac:	ed040593          	addi	a1,s0,-304
    800055b0:	4501                	li	a0,0
    800055b2:	ffffd097          	auipc	ra,0xffffd
    800055b6:	6b2080e7          	jalr	1714(ra) # 80002c64 <argstr>
    return -1;
    800055ba:	57fd                	li	a5,-1
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    800055bc:	12054b63          	bltz	a0,800056f2 <sys_link+0x152>
    800055c0:	08000613          	li	a2,128
    800055c4:	f5040593          	addi	a1,s0,-176
    800055c8:	4505                	li	a0,1
    800055ca:	ffffd097          	auipc	ra,0xffffd
    800055ce:	69a080e7          	jalr	1690(ra) # 80002c64 <argstr>
    return -1;
    800055d2:	57fd                	li	a5,-1
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    800055d4:	10054f63          	bltz	a0,800056f2 <sys_link+0x152>
    800055d8:	ee26                	sd	s1,280(sp)
  begin_op(ROOTDEV);
    800055da:	4501                	li	a0,0
    800055dc:	fffff097          	auipc	ra,0xfffff
    800055e0:	b9e080e7          	jalr	-1122(ra) # 8000417a <begin_op>
  if((ip = namei(old)) == 0){
    800055e4:	ed040513          	addi	a0,s0,-304
    800055e8:	fffff097          	auipc	ra,0xfffff
    800055ec:	940080e7          	jalr	-1728(ra) # 80003f28 <namei>
    800055f0:	84aa                	mv	s1,a0
    800055f2:	c951                	beqz	a0,80005686 <sys_link+0xe6>
  ilock(ip);
    800055f4:	ffffe097          	auipc	ra,0xffffe
    800055f8:	178080e7          	jalr	376(ra) # 8000376c <ilock>
  if(ip->type == T_DIR){
    800055fc:	04c49703          	lh	a4,76(s1)
    80005600:	4785                	li	a5,1
    80005602:	08f70a63          	beq	a4,a5,80005696 <sys_link+0xf6>
    80005606:	ea4a                	sd	s2,272(sp)
  ip->nlink++;
    80005608:	0524d783          	lhu	a5,82(s1)
    8000560c:	2785                	addiw	a5,a5,1
    8000560e:	04f49923          	sh	a5,82(s1)
  iupdate(ip);
    80005612:	8526                	mv	a0,s1
    80005614:	ffffe097          	auipc	ra,0xffffe
    80005618:	08c080e7          	jalr	140(ra) # 800036a0 <iupdate>
  iunlock(ip);
    8000561c:	8526                	mv	a0,s1
    8000561e:	ffffe097          	auipc	ra,0xffffe
    80005622:	214080e7          	jalr	532(ra) # 80003832 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
    80005626:	fd040593          	addi	a1,s0,-48
    8000562a:	f5040513          	addi	a0,s0,-176
    8000562e:	fffff097          	auipc	ra,0xfffff
    80005632:	918080e7          	jalr	-1768(ra) # 80003f46 <nameiparent>
    80005636:	892a                	mv	s2,a0
    80005638:	c149                	beqz	a0,800056ba <sys_link+0x11a>
  ilock(dp);
    8000563a:	ffffe097          	auipc	ra,0xffffe
    8000563e:	132080e7          	jalr	306(ra) # 8000376c <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    80005642:	854a                	mv	a0,s2
    80005644:	00092703          	lw	a4,0(s2)
    80005648:	409c                	lw	a5,0(s1)
    8000564a:	06f71363          	bne	a4,a5,800056b0 <sys_link+0x110>
    8000564e:	40d0                	lw	a2,4(s1)
    80005650:	fd040593          	addi	a1,s0,-48
    80005654:	ffffe097          	auipc	ra,0xffffe
    80005658:	7fe080e7          	jalr	2046(ra) # 80003e52 <dirlink>
    8000565c:	04054a63          	bltz	a0,800056b0 <sys_link+0x110>
  iunlockput(dp);
    80005660:	854a                	mv	a0,s2
    80005662:	ffffe097          	auipc	ra,0xffffe
    80005666:	34e080e7          	jalr	846(ra) # 800039b0 <iunlockput>
  iput(ip);
    8000566a:	8526                	mv	a0,s1
    8000566c:	ffffe097          	auipc	ra,0xffffe
    80005670:	212080e7          	jalr	530(ra) # 8000387e <iput>
  end_op(ROOTDEV);
    80005674:	4501                	li	a0,0
    80005676:	fffff097          	auipc	ra,0xfffff
    8000567a:	ba6080e7          	jalr	-1114(ra) # 8000421c <end_op>
  return 0;
    8000567e:	4781                	li	a5,0
    80005680:	64f2                	ld	s1,280(sp)
    80005682:	6952                	ld	s2,272(sp)
    80005684:	a0bd                	j	800056f2 <sys_link+0x152>
    end_op(ROOTDEV);
    80005686:	4501                	li	a0,0
    80005688:	fffff097          	auipc	ra,0xfffff
    8000568c:	b94080e7          	jalr	-1132(ra) # 8000421c <end_op>
    return -1;
    80005690:	57fd                	li	a5,-1
    80005692:	64f2                	ld	s1,280(sp)
    80005694:	a8b9                	j	800056f2 <sys_link+0x152>
    iunlockput(ip);
    80005696:	8526                	mv	a0,s1
    80005698:	ffffe097          	auipc	ra,0xffffe
    8000569c:	318080e7          	jalr	792(ra) # 800039b0 <iunlockput>
    end_op(ROOTDEV);
    800056a0:	4501                	li	a0,0
    800056a2:	fffff097          	auipc	ra,0xfffff
    800056a6:	b7a080e7          	jalr	-1158(ra) # 8000421c <end_op>
    return -1;
    800056aa:	57fd                	li	a5,-1
    800056ac:	64f2                	ld	s1,280(sp)
    800056ae:	a091                	j	800056f2 <sys_link+0x152>
    iunlockput(dp);
    800056b0:	854a                	mv	a0,s2
    800056b2:	ffffe097          	auipc	ra,0xffffe
    800056b6:	2fe080e7          	jalr	766(ra) # 800039b0 <iunlockput>
  ilock(ip);
    800056ba:	8526                	mv	a0,s1
    800056bc:	ffffe097          	auipc	ra,0xffffe
    800056c0:	0b0080e7          	jalr	176(ra) # 8000376c <ilock>
  ip->nlink--;
    800056c4:	0524d783          	lhu	a5,82(s1)
    800056c8:	37fd                	addiw	a5,a5,-1
    800056ca:	04f49923          	sh	a5,82(s1)
  iupdate(ip);
    800056ce:	8526                	mv	a0,s1
    800056d0:	ffffe097          	auipc	ra,0xffffe
    800056d4:	fd0080e7          	jalr	-48(ra) # 800036a0 <iupdate>
  iunlockput(ip);
    800056d8:	8526                	mv	a0,s1
    800056da:	ffffe097          	auipc	ra,0xffffe
    800056de:	2d6080e7          	jalr	726(ra) # 800039b0 <iunlockput>
  end_op(ROOTDEV);
    800056e2:	4501                	li	a0,0
    800056e4:	fffff097          	auipc	ra,0xfffff
    800056e8:	b38080e7          	jalr	-1224(ra) # 8000421c <end_op>
  return -1;
    800056ec:	57fd                	li	a5,-1
    800056ee:	64f2                	ld	s1,280(sp)
    800056f0:	6952                	ld	s2,272(sp)
}
    800056f2:	853e                	mv	a0,a5
    800056f4:	70b2                	ld	ra,296(sp)
    800056f6:	7412                	ld	s0,288(sp)
    800056f8:	6155                	addi	sp,sp,304
    800056fa:	8082                	ret

00000000800056fc <sys_unlink>:
{
    800056fc:	7151                	addi	sp,sp,-240
    800056fe:	f586                	sd	ra,232(sp)
    80005700:	f1a2                	sd	s0,224(sp)
    80005702:	1980                	addi	s0,sp,240
  if(argstr(0, path, MAXPATH) < 0)
    80005704:	08000613          	li	a2,128
    80005708:	f3040593          	addi	a1,s0,-208
    8000570c:	4501                	li	a0,0
    8000570e:	ffffd097          	auipc	ra,0xffffd
    80005712:	556080e7          	jalr	1366(ra) # 80002c64 <argstr>
    80005716:	1a054b63          	bltz	a0,800058cc <sys_unlink+0x1d0>
    8000571a:	eda6                	sd	s1,216(sp)
  begin_op(ROOTDEV);
    8000571c:	4501                	li	a0,0
    8000571e:	fffff097          	auipc	ra,0xfffff
    80005722:	a5c080e7          	jalr	-1444(ra) # 8000417a <begin_op>
  if((dp = nameiparent(path, name)) == 0){
    80005726:	fb040593          	addi	a1,s0,-80
    8000572a:	f3040513          	addi	a0,s0,-208
    8000572e:	fffff097          	auipc	ra,0xfffff
    80005732:	818080e7          	jalr	-2024(ra) # 80003f46 <nameiparent>
    80005736:	84aa                	mv	s1,a0
    80005738:	c16d                	beqz	a0,8000581a <sys_unlink+0x11e>
  ilock(dp);
    8000573a:	ffffe097          	auipc	ra,0xffffe
    8000573e:	032080e7          	jalr	50(ra) # 8000376c <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
    80005742:	00003597          	auipc	a1,0x3
    80005746:	36e58593          	addi	a1,a1,878 # 80008ab0 <userret+0xa20>
    8000574a:	fb040513          	addi	a0,s0,-80
    8000574e:	ffffe097          	auipc	ra,0xffffe
    80005752:	4bc080e7          	jalr	1212(ra) # 80003c0a <namecmp>
    80005756:	14050b63          	beqz	a0,800058ac <sys_unlink+0x1b0>
    8000575a:	00003597          	auipc	a1,0x3
    8000575e:	35e58593          	addi	a1,a1,862 # 80008ab8 <userret+0xa28>
    80005762:	fb040513          	addi	a0,s0,-80
    80005766:	ffffe097          	auipc	ra,0xffffe
    8000576a:	4a4080e7          	jalr	1188(ra) # 80003c0a <namecmp>
    8000576e:	12050f63          	beqz	a0,800058ac <sys_unlink+0x1b0>
    80005772:	e9ca                	sd	s2,208(sp)
  if((ip = dirlookup(dp, name, &off)) == 0)
    80005774:	f2c40613          	addi	a2,s0,-212
    80005778:	fb040593          	addi	a1,s0,-80
    8000577c:	8526                	mv	a0,s1
    8000577e:	ffffe097          	auipc	ra,0xffffe
    80005782:	4a6080e7          	jalr	1190(ra) # 80003c24 <dirlookup>
    80005786:	892a                	mv	s2,a0
    80005788:	12050163          	beqz	a0,800058aa <sys_unlink+0x1ae>
    8000578c:	e5ce                	sd	s3,200(sp)
  ilock(ip);
    8000578e:	ffffe097          	auipc	ra,0xffffe
    80005792:	fde080e7          	jalr	-34(ra) # 8000376c <ilock>
  if(ip->nlink < 1)
    80005796:	05291783          	lh	a5,82(s2)
    8000579a:	08f05863          	blez	a5,8000582a <sys_unlink+0x12e>
  if(ip->type == T_DIR && !isdirempty(ip)){
    8000579e:	04c91703          	lh	a4,76(s2)
    800057a2:	4785                	li	a5,1
    800057a4:	08f70b63          	beq	a4,a5,8000583a <sys_unlink+0x13e>
  memset(&de, 0, sizeof(de));
    800057a8:	fc040993          	addi	s3,s0,-64
    800057ac:	4641                	li	a2,16
    800057ae:	4581                	li	a1,0
    800057b0:	854e                	mv	a0,s3
    800057b2:	ffffb097          	auipc	ra,0xffffb
    800057b6:	60c080e7          	jalr	1548(ra) # 80000dbe <memset>
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    800057ba:	4741                	li	a4,16
    800057bc:	f2c42683          	lw	a3,-212(s0)
    800057c0:	864e                	mv	a2,s3
    800057c2:	4581                	li	a1,0
    800057c4:	8526                	mv	a0,s1
    800057c6:	ffffe097          	auipc	ra,0xffffe
    800057ca:	338080e7          	jalr	824(ra) # 80003afe <writei>
    800057ce:	47c1                	li	a5,16
    800057d0:	0af51a63          	bne	a0,a5,80005884 <sys_unlink+0x188>
  if(ip->type == T_DIR){
    800057d4:	04c91703          	lh	a4,76(s2)
    800057d8:	4785                	li	a5,1
    800057da:	0af70d63          	beq	a4,a5,80005894 <sys_unlink+0x198>
  iunlockput(dp);
    800057de:	8526                	mv	a0,s1
    800057e0:	ffffe097          	auipc	ra,0xffffe
    800057e4:	1d0080e7          	jalr	464(ra) # 800039b0 <iunlockput>
  ip->nlink--;
    800057e8:	05295783          	lhu	a5,82(s2)
    800057ec:	37fd                	addiw	a5,a5,-1
    800057ee:	04f91923          	sh	a5,82(s2)
  iupdate(ip);
    800057f2:	854a                	mv	a0,s2
    800057f4:	ffffe097          	auipc	ra,0xffffe
    800057f8:	eac080e7          	jalr	-340(ra) # 800036a0 <iupdate>
  iunlockput(ip);
    800057fc:	854a                	mv	a0,s2
    800057fe:	ffffe097          	auipc	ra,0xffffe
    80005802:	1b2080e7          	jalr	434(ra) # 800039b0 <iunlockput>
  end_op(ROOTDEV);
    80005806:	4501                	li	a0,0
    80005808:	fffff097          	auipc	ra,0xfffff
    8000580c:	a14080e7          	jalr	-1516(ra) # 8000421c <end_op>
  return 0;
    80005810:	4501                	li	a0,0
    80005812:	64ee                	ld	s1,216(sp)
    80005814:	694e                	ld	s2,208(sp)
    80005816:	69ae                	ld	s3,200(sp)
    80005818:	a075                	j	800058c4 <sys_unlink+0x1c8>
    end_op(ROOTDEV);
    8000581a:	4501                	li	a0,0
    8000581c:	fffff097          	auipc	ra,0xfffff
    80005820:	a00080e7          	jalr	-1536(ra) # 8000421c <end_op>
    return -1;
    80005824:	557d                	li	a0,-1
    80005826:	64ee                	ld	s1,216(sp)
    80005828:	a871                	j	800058c4 <sys_unlink+0x1c8>
    panic("unlink: nlink < 1");
    8000582a:	00003517          	auipc	a0,0x3
    8000582e:	2b650513          	addi	a0,a0,694 # 80008ae0 <userret+0xa50>
    80005832:	ffffb097          	auipc	ra,0xffffb
    80005836:	d38080e7          	jalr	-712(ra) # 8000056a <panic>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    8000583a:	05492703          	lw	a4,84(s2)
    8000583e:	02000793          	li	a5,32
    80005842:	f6e7f3e3          	bgeu	a5,a4,800057a8 <sys_unlink+0xac>
    80005846:	89be                	mv	s3,a5
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80005848:	4741                	li	a4,16
    8000584a:	86ce                	mv	a3,s3
    8000584c:	f1840613          	addi	a2,s0,-232
    80005850:	4581                	li	a1,0
    80005852:	854a                	mv	a0,s2
    80005854:	ffffe097          	auipc	ra,0xffffe
    80005858:	1b2080e7          	jalr	434(ra) # 80003a06 <readi>
    8000585c:	47c1                	li	a5,16
    8000585e:	00f51b63          	bne	a0,a5,80005874 <sys_unlink+0x178>
    if(de.inum != 0)
    80005862:	f1845783          	lhu	a5,-232(s0)
    80005866:	e7ad                	bnez	a5,800058d0 <sys_unlink+0x1d4>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80005868:	29c1                	addiw	s3,s3,16
    8000586a:	05492783          	lw	a5,84(s2)
    8000586e:	fcf9ede3          	bltu	s3,a5,80005848 <sys_unlink+0x14c>
    80005872:	bf1d                	j	800057a8 <sys_unlink+0xac>
      panic("isdirempty: readi");
    80005874:	00003517          	auipc	a0,0x3
    80005878:	28450513          	addi	a0,a0,644 # 80008af8 <userret+0xa68>
    8000587c:	ffffb097          	auipc	ra,0xffffb
    80005880:	cee080e7          	jalr	-786(ra) # 8000056a <panic>
    panic("unlink: writei");
    80005884:	00003517          	auipc	a0,0x3
    80005888:	28c50513          	addi	a0,a0,652 # 80008b10 <userret+0xa80>
    8000588c:	ffffb097          	auipc	ra,0xffffb
    80005890:	cde080e7          	jalr	-802(ra) # 8000056a <panic>
    dp->nlink--;
    80005894:	0524d783          	lhu	a5,82(s1)
    80005898:	37fd                	addiw	a5,a5,-1
    8000589a:	04f49923          	sh	a5,82(s1)
    iupdate(dp);
    8000589e:	8526                	mv	a0,s1
    800058a0:	ffffe097          	auipc	ra,0xffffe
    800058a4:	e00080e7          	jalr	-512(ra) # 800036a0 <iupdate>
    800058a8:	bf1d                	j	800057de <sys_unlink+0xe2>
    800058aa:	694e                	ld	s2,208(sp)
  iunlockput(dp);
    800058ac:	8526                	mv	a0,s1
    800058ae:	ffffe097          	auipc	ra,0xffffe
    800058b2:	102080e7          	jalr	258(ra) # 800039b0 <iunlockput>
  end_op(ROOTDEV);
    800058b6:	4501                	li	a0,0
    800058b8:	fffff097          	auipc	ra,0xfffff
    800058bc:	964080e7          	jalr	-1692(ra) # 8000421c <end_op>
  return -1;
    800058c0:	557d                	li	a0,-1
    800058c2:	64ee                	ld	s1,216(sp)
}
    800058c4:	70ae                	ld	ra,232(sp)
    800058c6:	740e                	ld	s0,224(sp)
    800058c8:	616d                	addi	sp,sp,240
    800058ca:	8082                	ret
    return -1;
    800058cc:	557d                	li	a0,-1
    800058ce:	bfdd                	j	800058c4 <sys_unlink+0x1c8>
    iunlockput(ip);
    800058d0:	854a                	mv	a0,s2
    800058d2:	ffffe097          	auipc	ra,0xffffe
    800058d6:	0de080e7          	jalr	222(ra) # 800039b0 <iunlockput>
    goto bad;
    800058da:	694e                	ld	s2,208(sp)
    800058dc:	69ae                	ld	s3,200(sp)
    800058de:	b7f9                	j	800058ac <sys_unlink+0x1b0>

00000000800058e0 <sys_open>:

uint64
sys_open(void)
{
    800058e0:	7131                	addi	sp,sp,-192
    800058e2:	fd06                	sd	ra,184(sp)
    800058e4:	f922                	sd	s0,176(sp)
    800058e6:	0180                	addi	s0,sp,192
  int fd, omode;
  struct file *f;
  struct inode *ip;
  int n;

  if((n = argstr(0, path, MAXPATH)) < 0 || argint(1, &omode) < 0)
    800058e8:	08000613          	li	a2,128
    800058ec:	f5040593          	addi	a1,s0,-176
    800058f0:	4501                	li	a0,0
    800058f2:	ffffd097          	auipc	ra,0xffffd
    800058f6:	372080e7          	jalr	882(ra) # 80002c64 <argstr>
    return -1;
    800058fa:	57fd                	li	a5,-1
  if((n = argstr(0, path, MAXPATH)) < 0 || argint(1, &omode) < 0)
    800058fc:	0c054263          	bltz	a0,800059c0 <sys_open+0xe0>
    80005900:	f4c40593          	addi	a1,s0,-180
    80005904:	4505                	li	a0,1
    80005906:	ffffd097          	auipc	ra,0xffffd
    8000590a:	31a080e7          	jalr	794(ra) # 80002c20 <argint>
    return -1;
    8000590e:	57fd                	li	a5,-1
  if((n = argstr(0, path, MAXPATH)) < 0 || argint(1, &omode) < 0)
    80005910:	0a054863          	bltz	a0,800059c0 <sys_open+0xe0>
    80005914:	f526                	sd	s1,168(sp)

  begin_op(ROOTDEV);
    80005916:	4501                	li	a0,0
    80005918:	fffff097          	auipc	ra,0xfffff
    8000591c:	862080e7          	jalr	-1950(ra) # 8000417a <begin_op>

  if(omode & O_CREATE){
    80005920:	f4c42783          	lw	a5,-180(s0)
    80005924:	2007f793          	andi	a5,a5,512
    80005928:	cbcd                	beqz	a5,800059da <sys_open+0xfa>
    ip = create(path, T_FILE, 0, 0);
    8000592a:	4681                	li	a3,0
    8000592c:	4601                	li	a2,0
    8000592e:	4589                	li	a1,2
    80005930:	f5040513          	addi	a0,s0,-176
    80005934:	00000097          	auipc	ra,0x0
    80005938:	946080e7          	jalr	-1722(ra) # 8000527a <create>
    8000593c:	84aa                	mv	s1,a0
    if(ip == 0){
    8000593e:	c551                	beqz	a0,800059ca <sys_open+0xea>
      end_op(ROOTDEV);
      return -1;
    }
  }

  if(ip->type == T_DEVICE && (ip->major < 0 || ip->major >= NDEV)){
    80005940:	04c49703          	lh	a4,76(s1)
    80005944:	478d                	li	a5,3
    80005946:	00f71763          	bne	a4,a5,80005954 <sys_open+0x74>
    8000594a:	04e4d703          	lhu	a4,78(s1)
    8000594e:	47a5                	li	a5,9
    80005950:	0ce7ee63          	bltu	a5,a4,80005a2c <sys_open+0x14c>
    80005954:	f14a                	sd	s2,160(sp)
    iunlockput(ip);
    end_op(ROOTDEV);
    return -1;
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    80005956:	fffff097          	auipc	ra,0xfffff
    8000595a:	d04080e7          	jalr	-764(ra) # 8000465a <filealloc>
    8000595e:	892a                	mv	s2,a0
    80005960:	c96d                	beqz	a0,80005a52 <sys_open+0x172>
    80005962:	ed4e                	sd	s3,152(sp)
    80005964:	00000097          	auipc	ra,0x0
    80005968:	8d2080e7          	jalr	-1838(ra) # 80005236 <fdalloc>
    8000596c:	89aa                	mv	s3,a0
    8000596e:	0c054c63          	bltz	a0,80005a46 <sys_open+0x166>
    iunlockput(ip);
    end_op(ROOTDEV);
    return -1;
  }

  if(ip->type == T_DEVICE){
    80005972:	04c49703          	lh	a4,76(s1)
    80005976:	478d                	li	a5,3
    80005978:	0ef70b63          	beq	a4,a5,80005a6e <sys_open+0x18e>
    f->type = FD_DEVICE;
    f->major = ip->major;
    f->minor = ip->minor;
  } else {
    f->type = FD_INODE;
    8000597c:	4789                	li	a5,2
    8000597e:	00f92023          	sw	a5,0(s2)
  }
  f->ip = ip;
    80005982:	00993c23          	sd	s1,24(s2)
  f->off = 0;
    80005986:	02092023          	sw	zero,32(s2)
  f->readable = !(omode & O_WRONLY);
    8000598a:	f4c42783          	lw	a5,-180(s0)
    8000598e:	0017f713          	andi	a4,a5,1
    80005992:	00174713          	xori	a4,a4,1
    80005996:	00e90423          	sb	a4,8(s2)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
    8000599a:	8b8d                	andi	a5,a5,3
    8000599c:	00f037b3          	snez	a5,a5
    800059a0:	00f904a3          	sb	a5,9(s2)

  iunlock(ip);
    800059a4:	8526                	mv	a0,s1
    800059a6:	ffffe097          	auipc	ra,0xffffe
    800059aa:	e8c080e7          	jalr	-372(ra) # 80003832 <iunlock>
  end_op(ROOTDEV);
    800059ae:	4501                	li	a0,0
    800059b0:	fffff097          	auipc	ra,0xfffff
    800059b4:	86c080e7          	jalr	-1940(ra) # 8000421c <end_op>

  return fd;
    800059b8:	87ce                	mv	a5,s3
    800059ba:	74aa                	ld	s1,168(sp)
    800059bc:	790a                	ld	s2,160(sp)
    800059be:	69ea                	ld	s3,152(sp)
}
    800059c0:	853e                	mv	a0,a5
    800059c2:	70ea                	ld	ra,184(sp)
    800059c4:	744a                	ld	s0,176(sp)
    800059c6:	6129                	addi	sp,sp,192
    800059c8:	8082                	ret
      end_op(ROOTDEV);
    800059ca:	4501                	li	a0,0
    800059cc:	fffff097          	auipc	ra,0xfffff
    800059d0:	850080e7          	jalr	-1968(ra) # 8000421c <end_op>
      return -1;
    800059d4:	57fd                	li	a5,-1
    800059d6:	74aa                	ld	s1,168(sp)
    800059d8:	b7e5                	j	800059c0 <sys_open+0xe0>
    if((ip = namei(path)) == 0){
    800059da:	f5040513          	addi	a0,s0,-176
    800059de:	ffffe097          	auipc	ra,0xffffe
    800059e2:	54a080e7          	jalr	1354(ra) # 80003f28 <namei>
    800059e6:	84aa                	mv	s1,a0
    800059e8:	c915                	beqz	a0,80005a1c <sys_open+0x13c>
    ilock(ip);
    800059ea:	ffffe097          	auipc	ra,0xffffe
    800059ee:	d82080e7          	jalr	-638(ra) # 8000376c <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
    800059f2:	04c49703          	lh	a4,76(s1)
    800059f6:	4785                	li	a5,1
    800059f8:	f4f714e3          	bne	a4,a5,80005940 <sys_open+0x60>
    800059fc:	f4c42783          	lw	a5,-180(s0)
    80005a00:	dbb1                	beqz	a5,80005954 <sys_open+0x74>
      iunlockput(ip);
    80005a02:	8526                	mv	a0,s1
    80005a04:	ffffe097          	auipc	ra,0xffffe
    80005a08:	fac080e7          	jalr	-84(ra) # 800039b0 <iunlockput>
      end_op(ROOTDEV);
    80005a0c:	4501                	li	a0,0
    80005a0e:	fffff097          	auipc	ra,0xfffff
    80005a12:	80e080e7          	jalr	-2034(ra) # 8000421c <end_op>
      return -1;
    80005a16:	57fd                	li	a5,-1
    80005a18:	74aa                	ld	s1,168(sp)
    80005a1a:	b75d                	j	800059c0 <sys_open+0xe0>
      end_op(ROOTDEV);
    80005a1c:	4501                	li	a0,0
    80005a1e:	ffffe097          	auipc	ra,0xffffe
    80005a22:	7fe080e7          	jalr	2046(ra) # 8000421c <end_op>
      return -1;
    80005a26:	57fd                	li	a5,-1
    80005a28:	74aa                	ld	s1,168(sp)
    80005a2a:	bf59                	j	800059c0 <sys_open+0xe0>
    iunlockput(ip);
    80005a2c:	8526                	mv	a0,s1
    80005a2e:	ffffe097          	auipc	ra,0xffffe
    80005a32:	f82080e7          	jalr	-126(ra) # 800039b0 <iunlockput>
    end_op(ROOTDEV);
    80005a36:	4501                	li	a0,0
    80005a38:	ffffe097          	auipc	ra,0xffffe
    80005a3c:	7e4080e7          	jalr	2020(ra) # 8000421c <end_op>
    return -1;
    80005a40:	57fd                	li	a5,-1
    80005a42:	74aa                	ld	s1,168(sp)
    80005a44:	bfb5                	j	800059c0 <sys_open+0xe0>
      fileclose(f);
    80005a46:	854a                	mv	a0,s2
    80005a48:	fffff097          	auipc	ra,0xfffff
    80005a4c:	cce080e7          	jalr	-818(ra) # 80004716 <fileclose>
    80005a50:	69ea                	ld	s3,152(sp)
    iunlockput(ip);
    80005a52:	8526                	mv	a0,s1
    80005a54:	ffffe097          	auipc	ra,0xffffe
    80005a58:	f5c080e7          	jalr	-164(ra) # 800039b0 <iunlockput>
    end_op(ROOTDEV);
    80005a5c:	4501                	li	a0,0
    80005a5e:	ffffe097          	auipc	ra,0xffffe
    80005a62:	7be080e7          	jalr	1982(ra) # 8000421c <end_op>
    return -1;
    80005a66:	57fd                	li	a5,-1
    80005a68:	74aa                	ld	s1,168(sp)
    80005a6a:	790a                	ld	s2,160(sp)
    80005a6c:	bf91                	j	800059c0 <sys_open+0xe0>
    f->type = FD_DEVICE;
    80005a6e:	00e92023          	sw	a4,0(s2)
    f->major = ip->major;
    80005a72:	04e49783          	lh	a5,78(s1)
    80005a76:	02f91223          	sh	a5,36(s2)
    f->minor = ip->minor;
    80005a7a:	05049783          	lh	a5,80(s1)
    80005a7e:	02f91323          	sh	a5,38(s2)
    80005a82:	b701                	j	80005982 <sys_open+0xa2>

0000000080005a84 <sys_mkdir>:

uint64
sys_mkdir(void)
{
    80005a84:	7175                	addi	sp,sp,-144
    80005a86:	e506                	sd	ra,136(sp)
    80005a88:	e122                	sd	s0,128(sp)
    80005a8a:	0900                	addi	s0,sp,144
  char path[MAXPATH];
  struct inode *ip;

  begin_op(ROOTDEV);
    80005a8c:	4501                	li	a0,0
    80005a8e:	ffffe097          	auipc	ra,0xffffe
    80005a92:	6ec080e7          	jalr	1772(ra) # 8000417a <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    80005a96:	08000613          	li	a2,128
    80005a9a:	f7040593          	addi	a1,s0,-144
    80005a9e:	4501                	li	a0,0
    80005aa0:	ffffd097          	auipc	ra,0xffffd
    80005aa4:	1c4080e7          	jalr	452(ra) # 80002c64 <argstr>
    80005aa8:	02054a63          	bltz	a0,80005adc <sys_mkdir+0x58>
    80005aac:	4681                	li	a3,0
    80005aae:	4601                	li	a2,0
    80005ab0:	4585                	li	a1,1
    80005ab2:	f7040513          	addi	a0,s0,-144
    80005ab6:	fffff097          	auipc	ra,0xfffff
    80005aba:	7c4080e7          	jalr	1988(ra) # 8000527a <create>
    80005abe:	cd19                	beqz	a0,80005adc <sys_mkdir+0x58>
    end_op(ROOTDEV);
    return -1;
  }
  iunlockput(ip);
    80005ac0:	ffffe097          	auipc	ra,0xffffe
    80005ac4:	ef0080e7          	jalr	-272(ra) # 800039b0 <iunlockput>
  end_op(ROOTDEV);
    80005ac8:	4501                	li	a0,0
    80005aca:	ffffe097          	auipc	ra,0xffffe
    80005ace:	752080e7          	jalr	1874(ra) # 8000421c <end_op>
  return 0;
    80005ad2:	4501                	li	a0,0
}
    80005ad4:	60aa                	ld	ra,136(sp)
    80005ad6:	640a                	ld	s0,128(sp)
    80005ad8:	6149                	addi	sp,sp,144
    80005ada:	8082                	ret
    end_op(ROOTDEV);
    80005adc:	4501                	li	a0,0
    80005ade:	ffffe097          	auipc	ra,0xffffe
    80005ae2:	73e080e7          	jalr	1854(ra) # 8000421c <end_op>
    return -1;
    80005ae6:	557d                	li	a0,-1
    80005ae8:	b7f5                	j	80005ad4 <sys_mkdir+0x50>

0000000080005aea <sys_mknod>:

uint64
sys_mknod(void)
{
    80005aea:	7135                	addi	sp,sp,-160
    80005aec:	ed06                	sd	ra,152(sp)
    80005aee:	e922                	sd	s0,144(sp)
    80005af0:	1100                	addi	s0,sp,160
  struct inode *ip;
  char path[MAXPATH];
  int major, minor;

  begin_op(ROOTDEV);
    80005af2:	4501                	li	a0,0
    80005af4:	ffffe097          	auipc	ra,0xffffe
    80005af8:	686080e7          	jalr	1670(ra) # 8000417a <begin_op>
  if((argstr(0, path, MAXPATH)) < 0 ||
    80005afc:	08000613          	li	a2,128
    80005b00:	f7040593          	addi	a1,s0,-144
    80005b04:	4501                	li	a0,0
    80005b06:	ffffd097          	auipc	ra,0xffffd
    80005b0a:	15e080e7          	jalr	350(ra) # 80002c64 <argstr>
    80005b0e:	04054b63          	bltz	a0,80005b64 <sys_mknod+0x7a>
     argint(1, &major) < 0 ||
    80005b12:	f6c40593          	addi	a1,s0,-148
    80005b16:	4505                	li	a0,1
    80005b18:	ffffd097          	auipc	ra,0xffffd
    80005b1c:	108080e7          	jalr	264(ra) # 80002c20 <argint>
  if((argstr(0, path, MAXPATH)) < 0 ||
    80005b20:	04054263          	bltz	a0,80005b64 <sys_mknod+0x7a>
     argint(2, &minor) < 0 ||
    80005b24:	f6840593          	addi	a1,s0,-152
    80005b28:	4509                	li	a0,2
    80005b2a:	ffffd097          	auipc	ra,0xffffd
    80005b2e:	0f6080e7          	jalr	246(ra) # 80002c20 <argint>
     argint(1, &major) < 0 ||
    80005b32:	02054963          	bltz	a0,80005b64 <sys_mknod+0x7a>
     (ip = create(path, T_DEVICE, major, minor)) == 0){
    80005b36:	f6841683          	lh	a3,-152(s0)
    80005b3a:	f6c41603          	lh	a2,-148(s0)
    80005b3e:	458d                	li	a1,3
    80005b40:	f7040513          	addi	a0,s0,-144
    80005b44:	fffff097          	auipc	ra,0xfffff
    80005b48:	736080e7          	jalr	1846(ra) # 8000527a <create>
     argint(2, &minor) < 0 ||
    80005b4c:	cd01                	beqz	a0,80005b64 <sys_mknod+0x7a>
    end_op(ROOTDEV);
    return -1;
  }
  iunlockput(ip);
    80005b4e:	ffffe097          	auipc	ra,0xffffe
    80005b52:	e62080e7          	jalr	-414(ra) # 800039b0 <iunlockput>
  end_op(ROOTDEV);
    80005b56:	4501                	li	a0,0
    80005b58:	ffffe097          	auipc	ra,0xffffe
    80005b5c:	6c4080e7          	jalr	1732(ra) # 8000421c <end_op>
  return 0;
    80005b60:	4501                	li	a0,0
    80005b62:	a039                	j	80005b70 <sys_mknod+0x86>
    end_op(ROOTDEV);
    80005b64:	4501                	li	a0,0
    80005b66:	ffffe097          	auipc	ra,0xffffe
    80005b6a:	6b6080e7          	jalr	1718(ra) # 8000421c <end_op>
    return -1;
    80005b6e:	557d                	li	a0,-1
}
    80005b70:	60ea                	ld	ra,152(sp)
    80005b72:	644a                	ld	s0,144(sp)
    80005b74:	610d                	addi	sp,sp,160
    80005b76:	8082                	ret

0000000080005b78 <sys_chdir>:

uint64
sys_chdir(void)
{
    80005b78:	7135                	addi	sp,sp,-160
    80005b7a:	ed06                	sd	ra,152(sp)
    80005b7c:	e922                	sd	s0,144(sp)
    80005b7e:	e14a                	sd	s2,128(sp)
    80005b80:	1100                	addi	s0,sp,160
  char path[MAXPATH];
  struct inode *ip;
  struct proc *p = myproc();
    80005b82:	ffffc097          	auipc	ra,0xffffc
    80005b86:	f7e080e7          	jalr	-130(ra) # 80001b00 <myproc>
    80005b8a:	892a                	mv	s2,a0
  
  begin_op(ROOTDEV);
    80005b8c:	4501                	li	a0,0
    80005b8e:	ffffe097          	auipc	ra,0xffffe
    80005b92:	5ec080e7          	jalr	1516(ra) # 8000417a <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = namei(path)) == 0){
    80005b96:	08000613          	li	a2,128
    80005b9a:	f6040593          	addi	a1,s0,-160
    80005b9e:	4501                	li	a0,0
    80005ba0:	ffffd097          	auipc	ra,0xffffd
    80005ba4:	0c4080e7          	jalr	196(ra) # 80002c64 <argstr>
    80005ba8:	04054e63          	bltz	a0,80005c04 <sys_chdir+0x8c>
    80005bac:	e526                	sd	s1,136(sp)
    80005bae:	f6040513          	addi	a0,s0,-160
    80005bb2:	ffffe097          	auipc	ra,0xffffe
    80005bb6:	376080e7          	jalr	886(ra) # 80003f28 <namei>
    80005bba:	84aa                	mv	s1,a0
    80005bbc:	c139                	beqz	a0,80005c02 <sys_chdir+0x8a>
    end_op(ROOTDEV);
    return -1;
  }
  ilock(ip);
    80005bbe:	ffffe097          	auipc	ra,0xffffe
    80005bc2:	bae080e7          	jalr	-1106(ra) # 8000376c <ilock>
  if(ip->type != T_DIR){
    80005bc6:	04c49703          	lh	a4,76(s1)
    80005bca:	4785                	li	a5,1
    80005bcc:	04f71363          	bne	a4,a5,80005c12 <sys_chdir+0x9a>
    iunlockput(ip);
    end_op(ROOTDEV);
    return -1;
  }
  iunlock(ip);
    80005bd0:	8526                	mv	a0,s1
    80005bd2:	ffffe097          	auipc	ra,0xffffe
    80005bd6:	c60080e7          	jalr	-928(ra) # 80003832 <iunlock>
  iput(p->cwd);
    80005bda:	15893503          	ld	a0,344(s2)
    80005bde:	ffffe097          	auipc	ra,0xffffe
    80005be2:	ca0080e7          	jalr	-864(ra) # 8000387e <iput>
  end_op(ROOTDEV);
    80005be6:	4501                	li	a0,0
    80005be8:	ffffe097          	auipc	ra,0xffffe
    80005bec:	634080e7          	jalr	1588(ra) # 8000421c <end_op>
  p->cwd = ip;
    80005bf0:	14993c23          	sd	s1,344(s2)
  return 0;
    80005bf4:	4501                	li	a0,0
    80005bf6:	64aa                	ld	s1,136(sp)
}
    80005bf8:	60ea                	ld	ra,152(sp)
    80005bfa:	644a                	ld	s0,144(sp)
    80005bfc:	690a                	ld	s2,128(sp)
    80005bfe:	610d                	addi	sp,sp,160
    80005c00:	8082                	ret
    80005c02:	64aa                	ld	s1,136(sp)
    end_op(ROOTDEV);
    80005c04:	4501                	li	a0,0
    80005c06:	ffffe097          	auipc	ra,0xffffe
    80005c0a:	616080e7          	jalr	1558(ra) # 8000421c <end_op>
    return -1;
    80005c0e:	557d                	li	a0,-1
    80005c10:	b7e5                	j	80005bf8 <sys_chdir+0x80>
    iunlockput(ip);
    80005c12:	8526                	mv	a0,s1
    80005c14:	ffffe097          	auipc	ra,0xffffe
    80005c18:	d9c080e7          	jalr	-612(ra) # 800039b0 <iunlockput>
    end_op(ROOTDEV);
    80005c1c:	4501                	li	a0,0
    80005c1e:	ffffe097          	auipc	ra,0xffffe
    80005c22:	5fe080e7          	jalr	1534(ra) # 8000421c <end_op>
    return -1;
    80005c26:	557d                	li	a0,-1
    80005c28:	64aa                	ld	s1,136(sp)
    80005c2a:	b7f9                	j	80005bf8 <sys_chdir+0x80>

0000000080005c2c <sys_exec>:

uint64
sys_exec(void)
{
    80005c2c:	7145                	addi	sp,sp,-464
    80005c2e:	e786                	sd	ra,456(sp)
    80005c30:	e3a2                	sd	s0,448(sp)
    80005c32:	0b80                	addi	s0,sp,464
  char path[MAXPATH], *argv[MAXARG];
  int i;
  uint64 uargv, uarg;

  if(argstr(0, path, MAXPATH) < 0 || argaddr(1, &uargv) < 0){
    80005c34:	08000613          	li	a2,128
    80005c38:	f4040593          	addi	a1,s0,-192
    80005c3c:	4501                	li	a0,0
    80005c3e:	ffffd097          	auipc	ra,0xffffd
    80005c42:	026080e7          	jalr	38(ra) # 80002c64 <argstr>
    80005c46:	10054c63          	bltz	a0,80005d5e <sys_exec+0x132>
    80005c4a:	e3840593          	addi	a1,s0,-456
    80005c4e:	4505                	li	a0,1
    80005c50:	ffffd097          	auipc	ra,0xffffd
    80005c54:	ff2080e7          	jalr	-14(ra) # 80002c42 <argaddr>
    80005c58:	10054863          	bltz	a0,80005d68 <sys_exec+0x13c>
    80005c5c:	ff26                	sd	s1,440(sp)
    80005c5e:	fb4a                	sd	s2,432(sp)
    80005c60:	f74e                	sd	s3,424(sp)
    80005c62:	f352                	sd	s4,416(sp)
    80005c64:	ef56                	sd	s5,408(sp)
    80005c66:	eb5a                	sd	s6,400(sp)
    return -1;
  }
  memset(argv, 0, sizeof(argv));
    80005c68:	10000613          	li	a2,256
    80005c6c:	4581                	li	a1,0
    80005c6e:	e4040513          	addi	a0,s0,-448
    80005c72:	ffffb097          	auipc	ra,0xffffb
    80005c76:	14c080e7          	jalr	332(ra) # 80000dbe <memset>
  for(i=0;; i++){
    if(i >= NELEM(argv)){
    80005c7a:	e4040493          	addi	s1,s0,-448
  memset(argv, 0, sizeof(argv));
    80005c7e:	89a6                	mv	s3,s1
    80005c80:	4901                	li	s2,0
      goto bad;
    }
    if(fetchaddr(uargv+sizeof(uint64)*i, (uint64*)&uarg) < 0){
    80005c82:	e3040a13          	addi	s4,s0,-464
      break;
    }
    argv[i] = kalloc();
    if(argv[i] == 0)
      panic("sys_exec kalloc");
    if(fetchstr(uarg, argv[i], PGSIZE) < 0){
    80005c86:	6a85                	lui	s5,0x1
    if(i >= NELEM(argv)){
    80005c88:	02000b13          	li	s6,32
    if(fetchaddr(uargv+sizeof(uint64)*i, (uint64*)&uarg) < 0){
    80005c8c:	00391513          	slli	a0,s2,0x3
    80005c90:	85d2                	mv	a1,s4
    80005c92:	e3843783          	ld	a5,-456(s0)
    80005c96:	953e                	add	a0,a0,a5
    80005c98:	ffffd097          	auipc	ra,0xffffd
    80005c9c:	eee080e7          	jalr	-274(ra) # 80002b86 <fetchaddr>
    80005ca0:	02054a63          	bltz	a0,80005cd4 <sys_exec+0xa8>
    if(uarg == 0){
    80005ca4:	e3043783          	ld	a5,-464(s0)
    80005ca8:	cba9                	beqz	a5,80005cfa <sys_exec+0xce>
    argv[i] = kalloc();
    80005caa:	ffffb097          	auipc	ra,0xffffb
    80005cae:	d1c080e7          	jalr	-740(ra) # 800009c6 <kalloc>
    80005cb2:	85aa                	mv	a1,a0
    80005cb4:	00a9b023          	sd	a0,0(s3)
    if(argv[i] == 0)
    80005cb8:	c159                	beqz	a0,80005d3e <sys_exec+0x112>
    if(fetchstr(uarg, argv[i], PGSIZE) < 0){
    80005cba:	8656                	mv	a2,s5
    80005cbc:	e3043503          	ld	a0,-464(s0)
    80005cc0:	ffffd097          	auipc	ra,0xffffd
    80005cc4:	f18080e7          	jalr	-232(ra) # 80002bd8 <fetchstr>
    80005cc8:	00054663          	bltz	a0,80005cd4 <sys_exec+0xa8>
    if(i >= NELEM(argv)){
    80005ccc:	0905                	addi	s2,s2,1
    80005cce:	09a1                	addi	s3,s3,8
    80005cd0:	fb691ee3          	bne	s2,s6,80005c8c <sys_exec+0x60>
    kfree(argv[i]);

  return ret;

 bad:
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80005cd4:	f4040913          	addi	s2,s0,-192
    80005cd8:	6088                	ld	a0,0(s1)
    80005cda:	c935                	beqz	a0,80005d4e <sys_exec+0x122>
    kfree(argv[i]);
    80005cdc:	ffffb097          	auipc	ra,0xffffb
    80005ce0:	be6080e7          	jalr	-1050(ra) # 800008c2 <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80005ce4:	04a1                	addi	s1,s1,8
    80005ce6:	ff2499e3          	bne	s1,s2,80005cd8 <sys_exec+0xac>
  return -1;
    80005cea:	557d                	li	a0,-1
    80005cec:	74fa                	ld	s1,440(sp)
    80005cee:	795a                	ld	s2,432(sp)
    80005cf0:	79ba                	ld	s3,424(sp)
    80005cf2:	7a1a                	ld	s4,416(sp)
    80005cf4:	6afa                	ld	s5,408(sp)
    80005cf6:	6b5a                	ld	s6,400(sp)
    80005cf8:	a0a5                	j	80005d60 <sys_exec+0x134>
      argv[i] = 0;
    80005cfa:	0009079b          	sext.w	a5,s2
    80005cfe:	e4040593          	addi	a1,s0,-448
    80005d02:	078e                	slli	a5,a5,0x3
    80005d04:	97ae                	add	a5,a5,a1
    80005d06:	0007b023          	sd	zero,0(a5)
  int ret = exec(path, argv);
    80005d0a:	f4040513          	addi	a0,s0,-192
    80005d0e:	fffff097          	auipc	ra,0xfffff
    80005d12:	128080e7          	jalr	296(ra) # 80004e36 <exec>
    80005d16:	892a                	mv	s2,a0
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80005d18:	f4040993          	addi	s3,s0,-192
    80005d1c:	6088                	ld	a0,0(s1)
    80005d1e:	c901                	beqz	a0,80005d2e <sys_exec+0x102>
    kfree(argv[i]);
    80005d20:	ffffb097          	auipc	ra,0xffffb
    80005d24:	ba2080e7          	jalr	-1118(ra) # 800008c2 <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80005d28:	04a1                	addi	s1,s1,8
    80005d2a:	ff3499e3          	bne	s1,s3,80005d1c <sys_exec+0xf0>
  return ret;
    80005d2e:	854a                	mv	a0,s2
    80005d30:	74fa                	ld	s1,440(sp)
    80005d32:	795a                	ld	s2,432(sp)
    80005d34:	79ba                	ld	s3,424(sp)
    80005d36:	7a1a                	ld	s4,416(sp)
    80005d38:	6afa                	ld	s5,408(sp)
    80005d3a:	6b5a                	ld	s6,400(sp)
    80005d3c:	a015                	j	80005d60 <sys_exec+0x134>
      panic("sys_exec kalloc");
    80005d3e:	00003517          	auipc	a0,0x3
    80005d42:	de250513          	addi	a0,a0,-542 # 80008b20 <userret+0xa90>
    80005d46:	ffffb097          	auipc	ra,0xffffb
    80005d4a:	824080e7          	jalr	-2012(ra) # 8000056a <panic>
  return -1;
    80005d4e:	557d                	li	a0,-1
    80005d50:	74fa                	ld	s1,440(sp)
    80005d52:	795a                	ld	s2,432(sp)
    80005d54:	79ba                	ld	s3,424(sp)
    80005d56:	7a1a                	ld	s4,416(sp)
    80005d58:	6afa                	ld	s5,408(sp)
    80005d5a:	6b5a                	ld	s6,400(sp)
    80005d5c:	a011                	j	80005d60 <sys_exec+0x134>
    return -1;
    80005d5e:	557d                	li	a0,-1
}
    80005d60:	60be                	ld	ra,456(sp)
    80005d62:	641e                	ld	s0,448(sp)
    80005d64:	6179                	addi	sp,sp,464
    80005d66:	8082                	ret
    return -1;
    80005d68:	557d                	li	a0,-1
    80005d6a:	bfdd                	j	80005d60 <sys_exec+0x134>

0000000080005d6c <sys_pipe>:

uint64
sys_pipe(void)
{
    80005d6c:	7139                	addi	sp,sp,-64
    80005d6e:	fc06                	sd	ra,56(sp)
    80005d70:	f822                	sd	s0,48(sp)
    80005d72:	f426                	sd	s1,40(sp)
    80005d74:	0080                	addi	s0,sp,64
  uint64 fdarray; // user pointer to array of two integers
  struct file *rf, *wf;
  int fd0, fd1;
  struct proc *p = myproc();
    80005d76:	ffffc097          	auipc	ra,0xffffc
    80005d7a:	d8a080e7          	jalr	-630(ra) # 80001b00 <myproc>
    80005d7e:	84aa                	mv	s1,a0

  if(argaddr(0, &fdarray) < 0)
    80005d80:	fd840593          	addi	a1,s0,-40
    80005d84:	4501                	li	a0,0
    80005d86:	ffffd097          	auipc	ra,0xffffd
    80005d8a:	ebc080e7          	jalr	-324(ra) # 80002c42 <argaddr>
    return -1;
    80005d8e:	57fd                	li	a5,-1
  if(argaddr(0, &fdarray) < 0)
    80005d90:	0e054363          	bltz	a0,80005e76 <sys_pipe+0x10a>
  if(pipealloc(&rf, &wf) < 0)
    80005d94:	fc840593          	addi	a1,s0,-56
    80005d98:	fd040513          	addi	a0,s0,-48
    80005d9c:	fffff097          	auipc	ra,0xfffff
    80005da0:	d30080e7          	jalr	-720(ra) # 80004acc <pipealloc>
    return -1;
    80005da4:	57fd                	li	a5,-1
  if(pipealloc(&rf, &wf) < 0)
    80005da6:	0c054863          	bltz	a0,80005e76 <sys_pipe+0x10a>
  fd0 = -1;
    80005daa:	fcf42223          	sw	a5,-60(s0)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    80005dae:	fd043503          	ld	a0,-48(s0)
    80005db2:	fffff097          	auipc	ra,0xfffff
    80005db6:	484080e7          	jalr	1156(ra) # 80005236 <fdalloc>
    80005dba:	fca42223          	sw	a0,-60(s0)
    80005dbe:	08054f63          	bltz	a0,80005e5c <sys_pipe+0xf0>
    80005dc2:	fc843503          	ld	a0,-56(s0)
    80005dc6:	fffff097          	auipc	ra,0xfffff
    80005dca:	470080e7          	jalr	1136(ra) # 80005236 <fdalloc>
    80005dce:	fca42023          	sw	a0,-64(s0)
    80005dd2:	06054b63          	bltz	a0,80005e48 <sys_pipe+0xdc>
      p->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    80005dd6:	4691                	li	a3,4
    80005dd8:	fc440613          	addi	a2,s0,-60
    80005ddc:	fd843583          	ld	a1,-40(s0)
    80005de0:	6ca8                	ld	a0,88(s1)
    80005de2:	ffffc097          	auipc	ra,0xffffc
    80005de6:	9e2080e7          	jalr	-1566(ra) # 800017c4 <copyout>
    80005dea:	02054063          	bltz	a0,80005e0a <sys_pipe+0x9e>
     copyout(p->pagetable, fdarray+sizeof(fd0), (char *)&fd1, sizeof(fd1)) < 0){
    80005dee:	4691                	li	a3,4
    80005df0:	fc040613          	addi	a2,s0,-64
    80005df4:	fd843583          	ld	a1,-40(s0)
    80005df8:	95b6                	add	a1,a1,a3
    80005dfa:	6ca8                	ld	a0,88(s1)
    80005dfc:	ffffc097          	auipc	ra,0xffffc
    80005e00:	9c8080e7          	jalr	-1592(ra) # 800017c4 <copyout>
    p->ofile[fd1] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  return 0;
    80005e04:	4781                	li	a5,0
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    80005e06:	06055863          	bgez	a0,80005e76 <sys_pipe+0x10a>
    p->ofile[fd0] = 0;
    80005e0a:	fc442783          	lw	a5,-60(s0)
    80005e0e:	078e                	slli	a5,a5,0x3
    80005e10:	0d078793          	addi	a5,a5,208
    80005e14:	97a6                	add	a5,a5,s1
    80005e16:	0007b423          	sd	zero,8(a5)
    p->ofile[fd1] = 0;
    80005e1a:	fc042783          	lw	a5,-64(s0)
    80005e1e:	078e                	slli	a5,a5,0x3
    80005e20:	0d078793          	addi	a5,a5,208
    80005e24:	00f48533          	add	a0,s1,a5
    80005e28:	00053423          	sd	zero,8(a0)
    fileclose(rf);
    80005e2c:	fd043503          	ld	a0,-48(s0)
    80005e30:	fffff097          	auipc	ra,0xfffff
    80005e34:	8e6080e7          	jalr	-1818(ra) # 80004716 <fileclose>
    fileclose(wf);
    80005e38:	fc843503          	ld	a0,-56(s0)
    80005e3c:	fffff097          	auipc	ra,0xfffff
    80005e40:	8da080e7          	jalr	-1830(ra) # 80004716 <fileclose>
    return -1;
    80005e44:	57fd                	li	a5,-1
    80005e46:	a805                	j	80005e76 <sys_pipe+0x10a>
    if(fd0 >= 0)
    80005e48:	fc442783          	lw	a5,-60(s0)
    80005e4c:	0007c863          	bltz	a5,80005e5c <sys_pipe+0xf0>
      p->ofile[fd0] = 0;
    80005e50:	078e                	slli	a5,a5,0x3
    80005e52:	0d078793          	addi	a5,a5,208
    80005e56:	97a6                	add	a5,a5,s1
    80005e58:	0007b423          	sd	zero,8(a5)
    fileclose(rf);
    80005e5c:	fd043503          	ld	a0,-48(s0)
    80005e60:	fffff097          	auipc	ra,0xfffff
    80005e64:	8b6080e7          	jalr	-1866(ra) # 80004716 <fileclose>
    fileclose(wf);
    80005e68:	fc843503          	ld	a0,-56(s0)
    80005e6c:	fffff097          	auipc	ra,0xfffff
    80005e70:	8aa080e7          	jalr	-1878(ra) # 80004716 <fileclose>
    return -1;
    80005e74:	57fd                	li	a5,-1
}
    80005e76:	853e                	mv	a0,a5
    80005e78:	70e2                	ld	ra,56(sp)
    80005e7a:	7442                	ld	s0,48(sp)
    80005e7c:	74a2                	ld	s1,40(sp)
    80005e7e:	6121                	addi	sp,sp,64
    80005e80:	8082                	ret
	...

0000000080005e90 <kernelvec>:
    80005e90:	7111                	addi	sp,sp,-256
    80005e92:	e006                	sd	ra,0(sp)
    80005e94:	e40a                	sd	sp,8(sp)
    80005e96:	e80e                	sd	gp,16(sp)
    80005e98:	ec12                	sd	tp,24(sp)
    80005e9a:	f016                	sd	t0,32(sp)
    80005e9c:	f41a                	sd	t1,40(sp)
    80005e9e:	f81e                	sd	t2,48(sp)
    80005ea0:	fc22                	sd	s0,56(sp)
    80005ea2:	e0a6                	sd	s1,64(sp)
    80005ea4:	e4aa                	sd	a0,72(sp)
    80005ea6:	e8ae                	sd	a1,80(sp)
    80005ea8:	ecb2                	sd	a2,88(sp)
    80005eaa:	f0b6                	sd	a3,96(sp)
    80005eac:	f4ba                	sd	a4,104(sp)
    80005eae:	f8be                	sd	a5,112(sp)
    80005eb0:	fcc2                	sd	a6,120(sp)
    80005eb2:	e146                	sd	a7,128(sp)
    80005eb4:	e54a                	sd	s2,136(sp)
    80005eb6:	e94e                	sd	s3,144(sp)
    80005eb8:	ed52                	sd	s4,152(sp)
    80005eba:	f156                	sd	s5,160(sp)
    80005ebc:	f55a                	sd	s6,168(sp)
    80005ebe:	f95e                	sd	s7,176(sp)
    80005ec0:	fd62                	sd	s8,184(sp)
    80005ec2:	e1e6                	sd	s9,192(sp)
    80005ec4:	e5ea                	sd	s10,200(sp)
    80005ec6:	e9ee                	sd	s11,208(sp)
    80005ec8:	edf2                	sd	t3,216(sp)
    80005eca:	f1f6                	sd	t4,224(sp)
    80005ecc:	f5fa                	sd	t5,232(sp)
    80005ece:	f9fe                	sd	t6,240(sp)
    80005ed0:	b75fc0ef          	jal	80002a44 <kerneltrap>
    80005ed4:	6082                	ld	ra,0(sp)
    80005ed6:	6122                	ld	sp,8(sp)
    80005ed8:	61c2                	ld	gp,16(sp)
    80005eda:	7282                	ld	t0,32(sp)
    80005edc:	7322                	ld	t1,40(sp)
    80005ede:	73c2                	ld	t2,48(sp)
    80005ee0:	7462                	ld	s0,56(sp)
    80005ee2:	6486                	ld	s1,64(sp)
    80005ee4:	6526                	ld	a0,72(sp)
    80005ee6:	65c6                	ld	a1,80(sp)
    80005ee8:	6666                	ld	a2,88(sp)
    80005eea:	7686                	ld	a3,96(sp)
    80005eec:	7726                	ld	a4,104(sp)
    80005eee:	77c6                	ld	a5,112(sp)
    80005ef0:	7866                	ld	a6,120(sp)
    80005ef2:	688a                	ld	a7,128(sp)
    80005ef4:	692a                	ld	s2,136(sp)
    80005ef6:	69ca                	ld	s3,144(sp)
    80005ef8:	6a6a                	ld	s4,152(sp)
    80005efa:	7a8a                	ld	s5,160(sp)
    80005efc:	7b2a                	ld	s6,168(sp)
    80005efe:	7bca                	ld	s7,176(sp)
    80005f00:	7c6a                	ld	s8,184(sp)
    80005f02:	6c8e                	ld	s9,192(sp)
    80005f04:	6d2e                	ld	s10,200(sp)
    80005f06:	6dce                	ld	s11,208(sp)
    80005f08:	6e6e                	ld	t3,216(sp)
    80005f0a:	7e8e                	ld	t4,224(sp)
    80005f0c:	7f2e                	ld	t5,232(sp)
    80005f0e:	7fce                	ld	t6,240(sp)
    80005f10:	6111                	addi	sp,sp,256
    80005f12:	10200073          	sret
    80005f16:	00000013          	nop
    80005f1a:	00000013          	nop
    80005f1e:	0001                	nop

0000000080005f20 <timervec>:
    80005f20:	34051573          	csrrw	a0,mscratch,a0
    80005f24:	e10c                	sd	a1,0(a0)
    80005f26:	e510                	sd	a2,8(a0)
    80005f28:	e914                	sd	a3,16(a0)
    80005f2a:	710c                	ld	a1,32(a0)
    80005f2c:	7510                	ld	a2,40(a0)
    80005f2e:	6194                	ld	a3,0(a1)
    80005f30:	96b2                	add	a3,a3,a2
    80005f32:	e194                	sd	a3,0(a1)
    80005f34:	4589                	li	a1,2
    80005f36:	14459073          	csrw	sip,a1
    80005f3a:	6914                	ld	a3,16(a0)
    80005f3c:	6510                	ld	a2,8(a0)
    80005f3e:	610c                	ld	a1,0(a0)
    80005f40:	34051573          	csrrw	a0,mscratch,a0
    80005f44:	30200073          	mret
    80005f48:	0001                	nop

0000000080005f4a <plicinit>:
// the riscv Platform Level Interrupt Controller (PLIC).
//

void
plicinit(void)
{
    80005f4a:	1141                	addi	sp,sp,-16
    80005f4c:	e406                	sd	ra,8(sp)
    80005f4e:	e022                	sd	s0,0(sp)
    80005f50:	0800                	addi	s0,sp,16
  // set desired IRQ priorities non-zero (otherwise disabled).
  *(uint32*)(PLIC + UART0_IRQ*4) = 1;
    80005f52:	0c000737          	lui	a4,0xc000
    80005f56:	4785                	li	a5,1
    80005f58:	d71c                	sw	a5,40(a4)
  *(uint32*)(PLIC + VIRTIO0_IRQ*4) = 1;
    80005f5a:	c35c                	sw	a5,4(a4)
}
    80005f5c:	60a2                	ld	ra,8(sp)
    80005f5e:	6402                	ld	s0,0(sp)
    80005f60:	0141                	addi	sp,sp,16
    80005f62:	8082                	ret

0000000080005f64 <plicinithart>:

void
plicinithart(void)
{
    80005f64:	1141                	addi	sp,sp,-16
    80005f66:	e406                	sd	ra,8(sp)
    80005f68:	e022                	sd	s0,0(sp)
    80005f6a:	0800                	addi	s0,sp,16
  int hart = cpuid();
    80005f6c:	ffffc097          	auipc	ra,0xffffc
    80005f70:	b60080e7          	jalr	-1184(ra) # 80001acc <cpuid>
  
  // set uart's enable bit for this hart's S-mode. 
  *(uint32*)PLIC_SENABLE(hart)= (1 << UART0_IRQ) | (1 << VIRTIO0_IRQ);
    80005f74:	0085171b          	slliw	a4,a0,0x8
    80005f78:	0c0027b7          	lui	a5,0xc002
    80005f7c:	97ba                	add	a5,a5,a4
    80005f7e:	40200713          	li	a4,1026
    80005f82:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>

  // set this hart's S-mode priority threshold to 0.
  *(uint32*)PLIC_SPRIORITY(hart) = 0;
    80005f86:	00d5151b          	slliw	a0,a0,0xd
    80005f8a:	0c2017b7          	lui	a5,0xc201
    80005f8e:	97aa                	add	a5,a5,a0
    80005f90:	0007a023          	sw	zero,0(a5) # c201000 <_entry-0x73dff000>
}
    80005f94:	60a2                	ld	ra,8(sp)
    80005f96:	6402                	ld	s0,0(sp)
    80005f98:	0141                	addi	sp,sp,16
    80005f9a:	8082                	ret

0000000080005f9c <plic_claim>:

// ask the PLIC what interrupt we should serve.
int
plic_claim(void)
{
    80005f9c:	1141                	addi	sp,sp,-16
    80005f9e:	e406                	sd	ra,8(sp)
    80005fa0:	e022                	sd	s0,0(sp)
    80005fa2:	0800                	addi	s0,sp,16
  int hart = cpuid();
    80005fa4:	ffffc097          	auipc	ra,0xffffc
    80005fa8:	b28080e7          	jalr	-1240(ra) # 80001acc <cpuid>
  //int irq = *(uint32*)(PLIC + 0x201004);
  int irq = *(uint32*)PLIC_SCLAIM(hart);
    80005fac:	00d5151b          	slliw	a0,a0,0xd
    80005fb0:	0c2017b7          	lui	a5,0xc201
    80005fb4:	97aa                	add	a5,a5,a0
  return irq;
}
    80005fb6:	43c8                	lw	a0,4(a5)
    80005fb8:	60a2                	ld	ra,8(sp)
    80005fba:	6402                	ld	s0,0(sp)
    80005fbc:	0141                	addi	sp,sp,16
    80005fbe:	8082                	ret

0000000080005fc0 <plic_complete>:

// tell the PLIC we've served this IRQ.
void
plic_complete(int irq)
{
    80005fc0:	1101                	addi	sp,sp,-32
    80005fc2:	ec06                	sd	ra,24(sp)
    80005fc4:	e822                	sd	s0,16(sp)
    80005fc6:	e426                	sd	s1,8(sp)
    80005fc8:	1000                	addi	s0,sp,32
    80005fca:	84aa                	mv	s1,a0
  int hart = cpuid();
    80005fcc:	ffffc097          	auipc	ra,0xffffc
    80005fd0:	b00080e7          	jalr	-1280(ra) # 80001acc <cpuid>
  //*(uint32*)(PLIC + 0x201004) = irq;
  *(uint32*)PLIC_SCLAIM(hart) = irq;
    80005fd4:	00d5179b          	slliw	a5,a0,0xd
    80005fd8:	0c201737          	lui	a4,0xc201
    80005fdc:	97ba                	add	a5,a5,a4
    80005fde:	c3c4                	sw	s1,4(a5)
}
    80005fe0:	60e2                	ld	ra,24(sp)
    80005fe2:	6442                	ld	s0,16(sp)
    80005fe4:	64a2                	ld	s1,8(sp)
    80005fe6:	6105                	addi	sp,sp,32
    80005fe8:	8082                	ret

0000000080005fea <free_desc>:
}

// mark a descriptor as free.
static void
free_desc(int n, int i)
{
    80005fea:	1141                	addi	sp,sp,-16
    80005fec:	e406                	sd	ra,8(sp)
    80005fee:	e022                	sd	s0,0(sp)
    80005ff0:	0800                	addi	s0,sp,16
  if(i >= NUM)
    80005ff2:	479d                	li	a5,7
    80005ff4:	06b7c863          	blt	a5,a1,80006064 <free_desc+0x7a>
    panic("virtio_disk_intr 1");
  if(disk[n].free[i])
    80005ff8:	00151713          	slli	a4,a0,0x1
    80005ffc:	972a                	add	a4,a4,a0
    80005ffe:	0732                	slli	a4,a4,0xc
    80006000:	0001c797          	auipc	a5,0x1c
    80006004:	00078793          	mv	a5,a5
    80006008:	97ba                	add	a5,a5,a4
    8000600a:	97ae                	add	a5,a5,a1
    8000600c:	6709                	lui	a4,0x2
    8000600e:	97ba                	add	a5,a5,a4
    80006010:	0187c783          	lbu	a5,24(a5) # 80022018 <disk+0x18>
    80006014:	e3a5                	bnez	a5,80006074 <free_desc+0x8a>
    panic("virtio_disk_intr 2");
  disk[n].desc[i].addr = 0;
    80006016:	0001c817          	auipc	a6,0x1c
    8000601a:	fea80813          	addi	a6,a6,-22 # 80022000 <disk>
    8000601e:	00151793          	slli	a5,a0,0x1
    80006022:	00a78733          	add	a4,a5,a0
    80006026:	0732                	slli	a4,a4,0xc
    80006028:	9742                	add	a4,a4,a6
    8000602a:	6689                	lui	a3,0x2
    8000602c:	00e68633          	add	a2,a3,a4
    80006030:	6210                	ld	a2,0(a2)
    80006032:	00459893          	slli	a7,a1,0x4
    80006036:	9646                	add	a2,a2,a7
    80006038:	00063023          	sd	zero,0(a2) # 2000 <_entry-0x7fffe000>
  disk[n].free[i] = 1;
    8000603c:	972e                	add	a4,a4,a1
    8000603e:	96ba                	add	a3,a3,a4
    80006040:	4705                	li	a4,1
    80006042:	00e68c23          	sb	a4,24(a3) # 2018 <_entry-0x7fffdfe8>
  wakeup(&disk[n].free[0]);
    80006046:	97aa                	add	a5,a5,a0
    80006048:	07b2                	slli	a5,a5,0xc
    8000604a:	6709                	lui	a4,0x2
    8000604c:	0761                	addi	a4,a4,24 # 2018 <_entry-0x7fffdfe8>
    8000604e:	97ba                	add	a5,a5,a4
    80006050:	00f80533          	add	a0,a6,a5
    80006054:	ffffc097          	auipc	ra,0xffffc
    80006058:	3ea080e7          	jalr	1002(ra) # 8000243e <wakeup>
}
    8000605c:	60a2                	ld	ra,8(sp)
    8000605e:	6402                	ld	s0,0(sp)
    80006060:	0141                	addi	sp,sp,16
    80006062:	8082                	ret
    panic("virtio_disk_intr 1");
    80006064:	00003517          	auipc	a0,0x3
    80006068:	acc50513          	addi	a0,a0,-1332 # 80008b30 <userret+0xaa0>
    8000606c:	ffffa097          	auipc	ra,0xffffa
    80006070:	4fe080e7          	jalr	1278(ra) # 8000056a <panic>
    panic("virtio_disk_intr 2");
    80006074:	00003517          	auipc	a0,0x3
    80006078:	ad450513          	addi	a0,a0,-1324 # 80008b48 <userret+0xab8>
    8000607c:	ffffa097          	auipc	ra,0xffffa
    80006080:	4ee080e7          	jalr	1262(ra) # 8000056a <panic>

0000000080006084 <virtio_disk_init>:
  __sync_synchronize();
    80006084:	0330000f          	fence	rw,rw
  if(disk[n].init)
    80006088:	00151793          	slli	a5,a0,0x1
    8000608c:	97aa                	add	a5,a5,a0
    8000608e:	07b2                	slli	a5,a5,0xc
    80006090:	0001c717          	auipc	a4,0x1c
    80006094:	f7070713          	addi	a4,a4,-144 # 80022000 <disk>
    80006098:	973e                	add	a4,a4,a5
    8000609a:	6789                	lui	a5,0x2
    8000609c:	97ba                	add	a5,a5,a4
    8000609e:	0a87a783          	lw	a5,168(a5) # 20a8 <_entry-0x7fffdf58>
    800060a2:	c391                	beqz	a5,800060a6 <virtio_disk_init+0x22>
    800060a4:	8082                	ret
{
    800060a6:	7179                	addi	sp,sp,-48
    800060a8:	f406                	sd	ra,40(sp)
    800060aa:	f022                	sd	s0,32(sp)
    800060ac:	ec26                	sd	s1,24(sp)
    800060ae:	e84a                	sd	s2,16(sp)
    800060b0:	e44e                	sd	s3,8(sp)
    800060b2:	e052                	sd	s4,0(sp)
    800060b4:	1800                	addi	s0,sp,48
    800060b6:	84aa                	mv	s1,a0
  printf("virtio disk init %d\n", n);
    800060b8:	85aa                	mv	a1,a0
    800060ba:	00003517          	auipc	a0,0x3
    800060be:	aa650513          	addi	a0,a0,-1370 # 80008b60 <userret+0xad0>
    800060c2:	ffffa097          	auipc	ra,0xffffa
    800060c6:	502080e7          	jalr	1282(ra) # 800005c4 <printf>
  initlock(&disk[n].vdisk_lock, "virtio_disk");
    800060ca:	00149913          	slli	s2,s1,0x1
    800060ce:	9926                	add	s2,s2,s1
    800060d0:	0932                	slli	s2,s2,0xc
    800060d2:	6789                	lui	a5,0x2
    800060d4:	0b078793          	addi	a5,a5,176 # 20b0 <_entry-0x7fffdf50>
    800060d8:	97ca                	add	a5,a5,s2
    800060da:	00003597          	auipc	a1,0x3
    800060de:	a9e58593          	addi	a1,a1,-1378 # 80008b78 <userret+0xae8>
    800060e2:	0001c517          	auipc	a0,0x1c
    800060e6:	f1e50513          	addi	a0,a0,-226 # 80022000 <disk>
    800060ea:	953e                	add	a0,a0,a5
    800060ec:	ffffb097          	auipc	ra,0xffffb
    800060f0:	944080e7          	jalr	-1724(ra) # 80000a30 <initlock>
  if(*R(n, VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    800060f4:	00c49a13          	slli	s4,s1,0xc
    800060f8:	6785                	lui	a5,0x1
    800060fa:	00fa0a3b          	addw	s4,s4,a5
    800060fe:	100007b7          	lui	a5,0x10000
    80006102:	97d2                	add	a5,a5,s4
    80006104:	4398                	lw	a4,0(a5)
    80006106:	2701                	sext.w	a4,a4
    80006108:	747277b7          	lui	a5,0x74727
    8000610c:	97678793          	addi	a5,a5,-1674 # 74726976 <_entry-0xb8d968a>
    80006110:	12f71e63          	bne	a4,a5,8000624c <virtio_disk_init+0x1c8>
     *R(n, VIRTIO_MMIO_VERSION) != 1 ||
    80006114:	100007b7          	lui	a5,0x10000
    80006118:	0791                	addi	a5,a5,4 # 10000004 <_entry-0x6ffffffc>
    8000611a:	97d2                	add	a5,a5,s4
    8000611c:	439c                	lw	a5,0(a5)
    8000611e:	2781                	sext.w	a5,a5
  if(*R(n, VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    80006120:	4705                	li	a4,1
    80006122:	12e79563          	bne	a5,a4,8000624c <virtio_disk_init+0x1c8>
     *R(n, VIRTIO_MMIO_DEVICE_ID) != 2 ||
    80006126:	100007b7          	lui	a5,0x10000
    8000612a:	07a1                	addi	a5,a5,8 # 10000008 <_entry-0x6ffffff8>
    8000612c:	97d2                	add	a5,a5,s4
    8000612e:	439c                	lw	a5,0(a5)
    80006130:	2781                	sext.w	a5,a5
     *R(n, VIRTIO_MMIO_VERSION) != 1 ||
    80006132:	4709                	li	a4,2
    80006134:	10e79c63          	bne	a5,a4,8000624c <virtio_disk_init+0x1c8>
     *R(n, VIRTIO_MMIO_VENDOR_ID) != 0x554d4551){
    80006138:	100007b7          	lui	a5,0x10000
    8000613c:	07b1                	addi	a5,a5,12 # 1000000c <_entry-0x6ffffff4>
    8000613e:	97d2                	add	a5,a5,s4
    80006140:	4398                	lw	a4,0(a5)
    80006142:	2701                	sext.w	a4,a4
     *R(n, VIRTIO_MMIO_DEVICE_ID) != 2 ||
    80006144:	554d47b7          	lui	a5,0x554d4
    80006148:	55178793          	addi	a5,a5,1361 # 554d4551 <_entry-0x2ab2baaf>
    8000614c:	10f71063          	bne	a4,a5,8000624c <virtio_disk_init+0x1c8>
  *R(n, VIRTIO_MMIO_STATUS) = status;
    80006150:	100007b7          	lui	a5,0x10000
    80006154:	07078793          	addi	a5,a5,112 # 10000070 <_entry-0x6fffff90>
    80006158:	97d2                	add	a5,a5,s4
    8000615a:	4705                	li	a4,1
    8000615c:	c398                	sw	a4,0(a5)
  *R(n, VIRTIO_MMIO_STATUS) = status;
    8000615e:	470d                	li	a4,3
    80006160:	c398                	sw	a4,0(a5)
  uint64 features = *R(n, VIRTIO_MMIO_DEVICE_FEATURES);
    80006162:	10000737          	lui	a4,0x10000
    80006166:	0741                	addi	a4,a4,16 # 10000010 <_entry-0x6ffffff0>
    80006168:	9752                	add	a4,a4,s4
    8000616a:	4314                	lw	a3,0(a4)
  *R(n, VIRTIO_MMIO_DRIVER_FEATURES) = features;
    8000616c:	10000737          	lui	a4,0x10000
    80006170:	02070713          	addi	a4,a4,32 # 10000020 <_entry-0x6fffffe0>
    80006174:	9752                	add	a4,a4,s4
  features &= ~(1 << VIRTIO_RING_F_INDIRECT_DESC);
    80006176:	c7ffe637          	lui	a2,0xc7ffe
    8000617a:	75f60613          	addi	a2,a2,1887 # ffffffffc7ffe75f <end+0xffffffff47fd6703>
  *R(n, VIRTIO_MMIO_DRIVER_FEATURES) = features;
    8000617e:	8ef1                	and	a3,a3,a2
    80006180:	c314                	sw	a3,0(a4)
  *R(n, VIRTIO_MMIO_STATUS) = status;
    80006182:	472d                	li	a4,11
    80006184:	c398                	sw	a4,0(a5)
  *R(n, VIRTIO_MMIO_STATUS) = status;
    80006186:	473d                	li	a4,15
    80006188:	c398                	sw	a4,0(a5)
  *R(n, VIRTIO_MMIO_GUEST_PAGE_SIZE) = PGSIZE;
    8000618a:	100007b7          	lui	a5,0x10000
    8000618e:	02878793          	addi	a5,a5,40 # 10000028 <_entry-0x6fffffd8>
    80006192:	97d2                	add	a5,a5,s4
    80006194:	6705                	lui	a4,0x1
    80006196:	c398                	sw	a4,0(a5)
  *R(n, VIRTIO_MMIO_QUEUE_SEL) = 0;
    80006198:	100007b7          	lui	a5,0x10000
    8000619c:	03078793          	addi	a5,a5,48 # 10000030 <_entry-0x6fffffd0>
    800061a0:	97d2                	add	a5,a5,s4
    800061a2:	0007a023          	sw	zero,0(a5)
  uint32 max = *R(n, VIRTIO_MMIO_QUEUE_NUM_MAX);
    800061a6:	100007b7          	lui	a5,0x10000
    800061aa:	03478793          	addi	a5,a5,52 # 10000034 <_entry-0x6fffffcc>
    800061ae:	97d2                	add	a5,a5,s4
    800061b0:	439c                	lw	a5,0(a5)
    800061b2:	2781                	sext.w	a5,a5
  if(max == 0)
    800061b4:	c7c5                	beqz	a5,8000625c <virtio_disk_init+0x1d8>
  if(max < NUM)
    800061b6:	471d                	li	a4,7
    800061b8:	0af77a63          	bgeu	a4,a5,8000626c <virtio_disk_init+0x1e8>
  *R(n, VIRTIO_MMIO_QUEUE_NUM) = NUM;
    800061bc:	100007b7          	lui	a5,0x10000
    800061c0:	03878793          	addi	a5,a5,56 # 10000038 <_entry-0x6fffffc8>
    800061c4:	97d2                	add	a5,a5,s4
    800061c6:	4721                	li	a4,8
    800061c8:	c398                	sw	a4,0(a5)
  memset(disk[n].pages, 0, sizeof(disk[n].pages));
    800061ca:	0001c997          	auipc	s3,0x1c
    800061ce:	e3698993          	addi	s3,s3,-458 # 80022000 <disk>
    800061d2:	994e                	add	s2,s2,s3
    800061d4:	6609                	lui	a2,0x2
    800061d6:	4581                	li	a1,0
    800061d8:	854a                	mv	a0,s2
    800061da:	ffffb097          	auipc	ra,0xffffb
    800061de:	be4080e7          	jalr	-1052(ra) # 80000dbe <memset>
  *R(n, VIRTIO_MMIO_QUEUE_PFN) = ((uint64)disk[n].pages) >> PGSHIFT;
    800061e2:	100007b7          	lui	a5,0x10000
    800061e6:	04078793          	addi	a5,a5,64 # 10000040 <_entry-0x6fffffc0>
    800061ea:	97d2                	add	a5,a5,s4
    800061ec:	00c95713          	srli	a4,s2,0xc
    800061f0:	2701                	sext.w	a4,a4
    800061f2:	c398                	sw	a4,0(a5)
  disk[n].desc = (struct VRingDesc *) disk[n].pages;
    800061f4:	00149693          	slli	a3,s1,0x1
    800061f8:	009687b3          	add	a5,a3,s1
    800061fc:	07b2                	slli	a5,a5,0xc
    800061fe:	97ce                	add	a5,a5,s3
    80006200:	6609                	lui	a2,0x2
    80006202:	97b2                	add	a5,a5,a2
    80006204:	0127b023          	sd	s2,0(a5)
  disk[n].avail = (uint16*)(((char*)disk[n].desc) + NUM*sizeof(struct VRingDesc));
    80006208:	08090713          	addi	a4,s2,128
    8000620c:	e798                	sd	a4,8(a5)
  disk[n].used = (struct UsedArea *) (disk[n].pages + PGSIZE);
    8000620e:	6705                	lui	a4,0x1
    80006210:	993a                	add	s2,s2,a4
    80006212:	0127b823          	sd	s2,16(a5)
    disk[n].free[i] = 1;
    80006216:	4705                	li	a4,1
    80006218:	00e78c23          	sb	a4,24(a5)
    8000621c:	00e78ca3          	sb	a4,25(a5)
    80006220:	00e78d23          	sb	a4,26(a5)
    80006224:	00e78da3          	sb	a4,27(a5)
    80006228:	00e78e23          	sb	a4,28(a5)
    8000622c:	00e78ea3          	sb	a4,29(a5)
    80006230:	00e78f23          	sb	a4,30(a5)
    80006234:	00e78fa3          	sb	a4,31(a5)
  disk[n].init = 1;
    80006238:	0ae7a423          	sw	a4,168(a5)
}
    8000623c:	70a2                	ld	ra,40(sp)
    8000623e:	7402                	ld	s0,32(sp)
    80006240:	64e2                	ld	s1,24(sp)
    80006242:	6942                	ld	s2,16(sp)
    80006244:	69a2                	ld	s3,8(sp)
    80006246:	6a02                	ld	s4,0(sp)
    80006248:	6145                	addi	sp,sp,48
    8000624a:	8082                	ret
    panic("could not find virtio disk");
    8000624c:	00003517          	auipc	a0,0x3
    80006250:	93c50513          	addi	a0,a0,-1732 # 80008b88 <userret+0xaf8>
    80006254:	ffffa097          	auipc	ra,0xffffa
    80006258:	316080e7          	jalr	790(ra) # 8000056a <panic>
    panic("virtio disk has no queue 0");
    8000625c:	00003517          	auipc	a0,0x3
    80006260:	94c50513          	addi	a0,a0,-1716 # 80008ba8 <userret+0xb18>
    80006264:	ffffa097          	auipc	ra,0xffffa
    80006268:	306080e7          	jalr	774(ra) # 8000056a <panic>
    panic("virtio disk max queue too short");
    8000626c:	00003517          	auipc	a0,0x3
    80006270:	95c50513          	addi	a0,a0,-1700 # 80008bc8 <userret+0xb38>
    80006274:	ffffa097          	auipc	ra,0xffffa
    80006278:	2f6080e7          	jalr	758(ra) # 8000056a <panic>

000000008000627c <virtio_disk_rw>:
  return 0;
}

void
virtio_disk_rw(int n, struct buf *b, int write)
{
    8000627c:	7135                	addi	sp,sp,-160
    8000627e:	ed06                	sd	ra,152(sp)
    80006280:	e922                	sd	s0,144(sp)
    80006282:	e526                	sd	s1,136(sp)
    80006284:	e14a                	sd	s2,128(sp)
    80006286:	fcce                	sd	s3,120(sp)
    80006288:	f8d2                	sd	s4,112(sp)
    8000628a:	f4d6                	sd	s5,104(sp)
    8000628c:	f0da                	sd	s6,96(sp)
    8000628e:	ecde                	sd	s7,88(sp)
    80006290:	e8e2                	sd	s8,80(sp)
    80006292:	e4e6                	sd	s9,72(sp)
    80006294:	fc6e                	sd	s11,56(sp)
    80006296:	1100                	addi	s0,sp,160
    80006298:	89aa                	mv	s3,a0
    8000629a:	8c2e                	mv	s8,a1
    8000629c:	8db2                	mv	s11,a2
  uint64 sector = b->blockno * (BSIZE / 512);
    8000629e:	45dc                	lw	a5,12(a1)
    800062a0:	0017979b          	slliw	a5,a5,0x1
    800062a4:	1782                	slli	a5,a5,0x20
    800062a6:	9381                	srli	a5,a5,0x20
    800062a8:	f6f43423          	sd	a5,-152(s0)

  acquire(&disk[n].vdisk_lock);
    800062ac:	00151493          	slli	s1,a0,0x1
    800062b0:	94aa                	add	s1,s1,a0
    800062b2:	04b2                	slli	s1,s1,0xc
    800062b4:	6b89                	lui	s7,0x2
    800062b6:	0b0b8b93          	addi	s7,s7,176 # 20b0 <_entry-0x7fffdf50>
    800062ba:	9ba6                	add	s7,s7,s1
    800062bc:	0001c917          	auipc	s2,0x1c
    800062c0:	d4490913          	addi	s2,s2,-700 # 80022000 <disk>
    800062c4:	9bca                	add	s7,s7,s2
    800062c6:	855e                	mv	a0,s7
    800062c8:	ffffb097          	auipc	ra,0xffffb
    800062cc:	83c080e7          	jalr	-1988(ra) # 80000b04 <acquire>
  int idx[3];
  while(1){
    if(alloc3_desc(n, idx) == 0) {
      break;
    }
    sleep(&disk[n].free[0], &disk[n].vdisk_lock);
    800062d0:	6c89                	lui	s9,0x2
    800062d2:	0ce1                	addi	s9,s9,24 # 2018 <_entry-0x7fffdfe8>
    800062d4:	9ca6                	add	s9,s9,s1
    800062d6:	9cca                	add	s9,s9,s2
    800062d8:	0001ea17          	auipc	s4,0x1e
    800062dc:	d40a0a13          	addi	s4,s4,-704 # 80024018 <disk+0x2018>
    800062e0:	9a26                	add	s4,s4,s1
  for(int i = 0; i < NUM; i++){
    800062e2:	44a1                	li	s1,8
      disk[n].free[i] = 0;
    800062e4:	00199793          	slli	a5,s3,0x1
    800062e8:	97ce                	add	a5,a5,s3
    800062ea:	07b2                	slli	a5,a5,0xc
    800062ec:	00f90b33          	add	s6,s2,a5
    800062f0:	a8b9                	j	8000634e <virtio_disk_rw+0xd2>
    800062f2:	00fb0733          	add	a4,s6,a5
    800062f6:	9742                	add	a4,a4,a6
    800062f8:	00070c23          	sb	zero,24(a4) # 1018 <_entry-0x7fffefe8>
    idx[i] = alloc_desc(n);
    800062fc:	c19c                	sw	a5,0(a1)
    if(idx[i] < 0){
    800062fe:	0207c263          	bltz	a5,80006322 <virtio_disk_rw+0xa6>
  for(int i = 0; i < 3; i++){
    80006302:	2905                	addiw	s2,s2,1
    80006304:	0611                	addi	a2,a2,4 # 2004 <_entry-0x7fffdffc>
    80006306:	1ca90263          	beq	s2,a0,800064ca <virtio_disk_rw+0x24e>
    idx[i] = alloc_desc(n);
    8000630a:	85b2                	mv	a1,a2
    8000630c:	8752                	mv	a4,s4
  for(int i = 0; i < NUM; i++){
    8000630e:	4781                	li	a5,0
    if(disk[n].free[i]){
    80006310:	00074683          	lbu	a3,0(a4)
    80006314:	fef9                	bnez	a3,800062f2 <virtio_disk_rw+0x76>
  for(int i = 0; i < NUM; i++){
    80006316:	2785                	addiw	a5,a5,1
    80006318:	0705                	addi	a4,a4,1
    8000631a:	fe979be3          	bne	a5,s1,80006310 <virtio_disk_rw+0x94>
    idx[i] = alloc_desc(n);
    8000631e:	57fd                	li	a5,-1
    80006320:	c19c                	sw	a5,0(a1)
      for(int j = 0; j < i; j++)
    80006322:	03205063          	blez	s2,80006342 <virtio_disk_rw+0xc6>
    80006326:	e0ea                	sd	s10,64(sp)
    80006328:	4d01                	li	s10,0
        free_desc(n, idx[j]);
    8000632a:	000aa583          	lw	a1,0(s5) # 1000 <_entry-0x7ffff000>
    8000632e:	854e                	mv	a0,s3
    80006330:	00000097          	auipc	ra,0x0
    80006334:	cba080e7          	jalr	-838(ra) # 80005fea <free_desc>
      for(int j = 0; j < i; j++)
    80006338:	2d05                	addiw	s10,s10,1
    8000633a:	0a91                	addi	s5,s5,4
    8000633c:	ff2d17e3          	bne	s10,s2,8000632a <virtio_disk_rw+0xae>
    80006340:	6d06                	ld	s10,64(sp)
    sleep(&disk[n].free[0], &disk[n].vdisk_lock);
    80006342:	85de                	mv	a1,s7
    80006344:	8566                	mv	a0,s9
    80006346:	ffffc097          	auipc	ra,0xffffc
    8000634a:	f7e080e7          	jalr	-130(ra) # 800022c4 <sleep>
  for(int i = 0; i < 3; i++){
    8000634e:	f8040a93          	addi	s5,s0,-128
{
    80006352:	8656                	mv	a2,s5
  for(int i = 0; i < 3; i++){
    80006354:	4901                	li	s2,0
      disk[n].free[i] = 0;
    80006356:	6809                	lui	a6,0x2
  for(int i = 0; i < 3; i++){
    80006358:	450d                	li	a0,3
    8000635a:	bf45                	j	8000630a <virtio_disk_rw+0x8e>
  disk[n].desc[idx[0]].next = idx[1];

  disk[n].desc[idx[1]].addr = (uint64) b->data;
  disk[n].desc[idx[1]].len = BSIZE;
  if(write)
    disk[n].desc[idx[1]].flags = 0; // device reads b->data
    8000635c:	00199793          	slli	a5,s3,0x1
    80006360:	97ce                	add	a5,a5,s3
    80006362:	07b2                	slli	a5,a5,0xc
    80006364:	0001c697          	auipc	a3,0x1c
    80006368:	c9c68693          	addi	a3,a3,-868 # 80022000 <disk>
    8000636c:	96be                	add	a3,a3,a5
    8000636e:	6789                	lui	a5,0x2
    80006370:	97b6                	add	a5,a5,a3
    80006372:	639c                	ld	a5,0(a5)
    80006374:	97ba                	add	a5,a5,a4
    80006376:	00079623          	sh	zero,12(a5) # 200c <_entry-0x7fffdff4>
  else
    disk[n].desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
  disk[n].desc[idx[1]].flags |= VRING_DESC_F_NEXT;
    8000637a:	0001c597          	auipc	a1,0x1c
    8000637e:	c8658593          	addi	a1,a1,-890 # 80022000 <disk>
    80006382:	00199793          	slli	a5,s3,0x1
    80006386:	01378633          	add	a2,a5,s3
    8000638a:	0632                	slli	a2,a2,0xc
    8000638c:	962e                	add	a2,a2,a1
    8000638e:	6689                	lui	a3,0x2
    80006390:	96b2                	add	a3,a3,a2
    80006392:	6290                	ld	a2,0(a3)
    80006394:	963a                	add	a2,a2,a4
    80006396:	00c65503          	lhu	a0,12(a2)
    8000639a:	00156513          	ori	a0,a0,1
    8000639e:	00a61623          	sh	a0,12(a2)
  disk[n].desc[idx[1]].next = idx[2];
    800063a2:	f8842603          	lw	a2,-120(s0)
    800063a6:	6288                	ld	a0,0(a3)
    800063a8:	972a                	add	a4,a4,a0
    800063aa:	00c71723          	sh	a2,14(a4)

  disk[n].info[idx[0]].status = 0;
    800063ae:	97ce                	add	a5,a5,s3
    800063b0:	07a2                	slli	a5,a5,0x8
    800063b2:	97a6                	add	a5,a5,s1
    800063b4:	20078793          	addi	a5,a5,512
    800063b8:	0792                	slli	a5,a5,0x4
    800063ba:	97ae                	add	a5,a5,a1
    800063bc:	02078823          	sb	zero,48(a5)
  disk[n].desc[idx[2]].addr = (uint64) &disk[n].info[idx[0]].status;
    800063c0:	0612                	slli	a2,a2,0x4
    800063c2:	6288                	ld	a0,0(a3)
    800063c4:	9532                	add	a0,a0,a2
    800063c6:	00199713          	slli	a4,s3,0x1
    800063ca:	974e                	add	a4,a4,s3
    800063cc:	0722                	slli	a4,a4,0x8
    800063ce:	20348813          	addi	a6,s1,515
    800063d2:	9742                	add	a4,a4,a6
    800063d4:	0712                	slli	a4,a4,0x4
    800063d6:	972e                	add	a4,a4,a1
    800063d8:	e118                	sd	a4,0(a0)
  disk[n].desc[idx[2]].len = 1;
    800063da:	6298                	ld	a4,0(a3)
    800063dc:	9732                	add	a4,a4,a2
    800063de:	4585                	li	a1,1
    800063e0:	c70c                	sw	a1,8(a4)
  disk[n].desc[idx[2]].flags = VRING_DESC_F_WRITE; // device writes the status
    800063e2:	6298                	ld	a4,0(a3)
    800063e4:	9732                	add	a4,a4,a2
    800063e6:	4509                	li	a0,2
    800063e8:	00a71623          	sh	a0,12(a4)
  disk[n].desc[idx[2]].next = 0;
    800063ec:	6298                	ld	a4,0(a3)
    800063ee:	9732                	add	a4,a4,a2
    800063f0:	00071723          	sh	zero,14(a4)

  // record struct buf for virtio_disk_intr().
  b->disk = 1;
    800063f4:	00bc2223          	sw	a1,4(s8)
  disk[n].info[idx[0]].b = b;
    800063f8:	0387b423          	sd	s8,40(a5)

  // avail[0] is flags
  // avail[1] tells the device how far to look in avail[2...].
  // avail[2...] are desc[] indices the device should process.
  // we only tell device the first index in our chain of descriptors.
  disk[n].avail[2 + (disk[n].avail[1] % NUM)] = idx[0];
    800063fc:	6698                	ld	a4,8(a3)
    800063fe:	00275783          	lhu	a5,2(a4)
    80006402:	8b9d                	andi	a5,a5,7
    80006404:	0786                	slli	a5,a5,0x1
    80006406:	0791                	addi	a5,a5,4
    80006408:	973e                	add	a4,a4,a5
    8000640a:	00971023          	sh	s1,0(a4)
  __sync_synchronize();
    8000640e:	0330000f          	fence	rw,rw
  disk[n].avail[1] = disk[n].avail[1] + 1;
    80006412:	6698                	ld	a4,8(a3)
    80006414:	00275783          	lhu	a5,2(a4)
    80006418:	2785                	addiw	a5,a5,1
    8000641a:	00f71123          	sh	a5,2(a4)

  *R(n, VIRTIO_MMIO_QUEUE_NOTIFY) = 0; // value is queue number
    8000641e:	00c99793          	slli	a5,s3,0xc
    80006422:	6705                	lui	a4,0x1
    80006424:	9fb9                	addw	a5,a5,a4
    80006426:	10000737          	lui	a4,0x10000
    8000642a:	05070713          	addi	a4,a4,80 # 10000050 <_entry-0x6fffffb0>
    8000642e:	97ba                	add	a5,a5,a4
    80006430:	0007a023          	sw	zero,0(a5)

  // Wait for virtio_disk_intr() to say request has finished.
  while(b->disk == 1) {
    80006434:	004c2783          	lw	a5,4(s8)
    80006438:	00b79d63          	bne	a5,a1,80006452 <virtio_disk_rw+0x1d6>
    8000643c:	84be                	mv	s1,a5
    sleep(b, &disk[n].vdisk_lock);
    8000643e:	85de                	mv	a1,s7
    80006440:	8562                	mv	a0,s8
    80006442:	ffffc097          	auipc	ra,0xffffc
    80006446:	e82080e7          	jalr	-382(ra) # 800022c4 <sleep>
  while(b->disk == 1) {
    8000644a:	004c2783          	lw	a5,4(s8)
    8000644e:	fe9788e3          	beq	a5,s1,8000643e <virtio_disk_rw+0x1c2>
  }

  disk[n].info[idx[0]].b = 0;
    80006452:	f8042483          	lw	s1,-128(s0)
    80006456:	00199793          	slli	a5,s3,0x1
    8000645a:	97ce                	add	a5,a5,s3
    8000645c:	07a2                	slli	a5,a5,0x8
    8000645e:	97a6                	add	a5,a5,s1
    80006460:	20078793          	addi	a5,a5,512
    80006464:	0792                	slli	a5,a5,0x4
    80006466:	0001c717          	auipc	a4,0x1c
    8000646a:	b9a70713          	addi	a4,a4,-1126 # 80022000 <disk>
    8000646e:	97ba                	add	a5,a5,a4
    80006470:	0207b423          	sd	zero,40(a5)
    if(disk[n].desc[i].flags & VRING_DESC_F_NEXT)
    80006474:	00199793          	slli	a5,s3,0x1
    80006478:	97ce                	add	a5,a5,s3
    8000647a:	07b2                	slli	a5,a5,0xc
    8000647c:	97ba                	add	a5,a5,a4
    8000647e:	6909                	lui	s2,0x2
    80006480:	993e                	add	s2,s2,a5
    free_desc(n, i);
    80006482:	85a6                	mv	a1,s1
    80006484:	854e                	mv	a0,s3
    80006486:	00000097          	auipc	ra,0x0
    8000648a:	b64080e7          	jalr	-1180(ra) # 80005fea <free_desc>
    if(disk[n].desc[i].flags & VRING_DESC_F_NEXT)
    8000648e:	0492                	slli	s1,s1,0x4
    80006490:	00093783          	ld	a5,0(s2) # 2000 <_entry-0x7fffe000>
    80006494:	97a6                	add	a5,a5,s1
    80006496:	00c7d703          	lhu	a4,12(a5)
    8000649a:	8b05                	andi	a4,a4,1
    8000649c:	c701                	beqz	a4,800064a4 <virtio_disk_rw+0x228>
      i = disk[n].desc[i].next;
    8000649e:	00e7d483          	lhu	s1,14(a5)
    free_desc(n, i);
    800064a2:	b7c5                	j	80006482 <virtio_disk_rw+0x206>
  free_chain(n, idx[0]);

  release(&disk[n].vdisk_lock);
    800064a4:	855e                	mv	a0,s7
    800064a6:	ffffa097          	auipc	ra,0xffffa
    800064aa:	722080e7          	jalr	1826(ra) # 80000bc8 <release>
}
    800064ae:	60ea                	ld	ra,152(sp)
    800064b0:	644a                	ld	s0,144(sp)
    800064b2:	64aa                	ld	s1,136(sp)
    800064b4:	690a                	ld	s2,128(sp)
    800064b6:	79e6                	ld	s3,120(sp)
    800064b8:	7a46                	ld	s4,112(sp)
    800064ba:	7aa6                	ld	s5,104(sp)
    800064bc:	7b06                	ld	s6,96(sp)
    800064be:	6be6                	ld	s7,88(sp)
    800064c0:	6c46                	ld	s8,80(sp)
    800064c2:	6ca6                	ld	s9,72(sp)
    800064c4:	7de2                	ld	s11,56(sp)
    800064c6:	610d                	addi	sp,sp,160
    800064c8:	8082                	ret
  if(write)
    800064ca:	01b037b3          	snez	a5,s11
    800064ce:	f6f42823          	sw	a5,-144(s0)
  buf0.reserved = 0;
    800064d2:	f6042a23          	sw	zero,-140(s0)
  buf0.sector = sector;
    800064d6:	f6843783          	ld	a5,-152(s0)
    800064da:	f6f43c23          	sd	a5,-136(s0)
  disk[n].desc[idx[0]].addr = (uint64) kvmpa((uint64) &buf0);
    800064de:	f8042483          	lw	s1,-128(s0)
    800064e2:	00449a13          	slli	s4,s1,0x4
    800064e6:	00199793          	slli	a5,s3,0x1
    800064ea:	97ce                	add	a5,a5,s3
    800064ec:	07b2                	slli	a5,a5,0xc
    800064ee:	0001c717          	auipc	a4,0x1c
    800064f2:	b1270713          	addi	a4,a4,-1262 # 80022000 <disk>
    800064f6:	97ba                	add	a5,a5,a4
    800064f8:	6909                	lui	s2,0x2
    800064fa:	993e                	add	s2,s2,a5
    800064fc:	00093a83          	ld	s5,0(s2) # 2000 <_entry-0x7fffe000>
    80006500:	9ad2                	add	s5,s5,s4
    80006502:	f7040513          	addi	a0,s0,-144
    80006506:	ffffb097          	auipc	ra,0xffffb
    8000650a:	d10080e7          	jalr	-752(ra) # 80001216 <kvmpa>
    8000650e:	00aab023          	sd	a0,0(s5)
  disk[n].desc[idx[0]].len = sizeof(buf0);
    80006512:	00093783          	ld	a5,0(s2)
    80006516:	97d2                	add	a5,a5,s4
    80006518:	4741                	li	a4,16
    8000651a:	c798                	sw	a4,8(a5)
  disk[n].desc[idx[0]].flags = VRING_DESC_F_NEXT;
    8000651c:	00093783          	ld	a5,0(s2)
    80006520:	97d2                	add	a5,a5,s4
    80006522:	4705                	li	a4,1
    80006524:	00e79623          	sh	a4,12(a5)
  disk[n].desc[idx[0]].next = idx[1];
    80006528:	f8442703          	lw	a4,-124(s0)
    8000652c:	00093783          	ld	a5,0(s2)
    80006530:	97d2                	add	a5,a5,s4
    80006532:	00e79723          	sh	a4,14(a5)
  disk[n].desc[idx[1]].addr = (uint64) b->data;
    80006536:	0712                	slli	a4,a4,0x4
    80006538:	00093783          	ld	a5,0(s2)
    8000653c:	97ba                	add	a5,a5,a4
    8000653e:	060c0693          	addi	a3,s8,96
    80006542:	e394                	sd	a3,0(a5)
  disk[n].desc[idx[1]].len = BSIZE;
    80006544:	00093783          	ld	a5,0(s2)
    80006548:	97ba                	add	a5,a5,a4
    8000654a:	40000693          	li	a3,1024
    8000654e:	c794                	sw	a3,8(a5)
  if(write)
    80006550:	e00d96e3          	bnez	s11,8000635c <virtio_disk_rw+0xe0>
    disk[n].desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
    80006554:	00199793          	slli	a5,s3,0x1
    80006558:	97ce                	add	a5,a5,s3
    8000655a:	07b2                	slli	a5,a5,0xc
    8000655c:	0001c697          	auipc	a3,0x1c
    80006560:	aa468693          	addi	a3,a3,-1372 # 80022000 <disk>
    80006564:	96be                	add	a3,a3,a5
    80006566:	6789                	lui	a5,0x2
    80006568:	97b6                	add	a5,a5,a3
    8000656a:	639c                	ld	a5,0(a5)
    8000656c:	97ba                	add	a5,a5,a4
    8000656e:	4689                	li	a3,2
    80006570:	00d79623          	sh	a3,12(a5) # 200c <_entry-0x7fffdff4>
    80006574:	b519                	j	8000637a <virtio_disk_rw+0xfe>

0000000080006576 <virtio_disk_intr>:

void
virtio_disk_intr(int n)
{
    80006576:	7179                	addi	sp,sp,-48
    80006578:	f406                	sd	ra,40(sp)
    8000657a:	f022                	sd	s0,32(sp)
    8000657c:	ec26                	sd	s1,24(sp)
    8000657e:	e84a                	sd	s2,16(sp)
    80006580:	e44e                	sd	s3,8(sp)
    80006582:	e052                	sd	s4,0(sp)
    80006584:	1800                	addi	s0,sp,48
    80006586:	84aa                	mv	s1,a0
  acquire(&disk[n].vdisk_lock);
    80006588:	00151913          	slli	s2,a0,0x1
    8000658c:	00a90a33          	add	s4,s2,a0
    80006590:	0a32                	slli	s4,s4,0xc
    80006592:	6789                	lui	a5,0x2
    80006594:	0b078793          	addi	a5,a5,176 # 20b0 <_entry-0x7fffdf50>
    80006598:	9a3e                	add	s4,s4,a5
    8000659a:	0001c997          	auipc	s3,0x1c
    8000659e:	a6698993          	addi	s3,s3,-1434 # 80022000 <disk>
    800065a2:	9a4e                	add	s4,s4,s3
    800065a4:	8552                	mv	a0,s4
    800065a6:	ffffa097          	auipc	ra,0xffffa
    800065aa:	55e080e7          	jalr	1374(ra) # 80000b04 <acquire>

  while((disk[n].used_idx % NUM) != (disk[n].used->id % NUM)){
    800065ae:	9926                	add	s2,s2,s1
    800065b0:	0932                	slli	s2,s2,0xc
    800065b2:	99ca                	add	s3,s3,s2
    800065b4:	6709                	lui	a4,0x2
    800065b6:	974e                	add	a4,a4,s3
    800065b8:	02075783          	lhu	a5,32(a4) # 2020 <_entry-0x7fffdfe0>
    800065bc:	6b18                	ld	a4,16(a4)
    800065be:	00275683          	lhu	a3,2(a4)
    800065c2:	8ebd                	xor	a3,a3,a5
    800065c4:	8a9d                	andi	a3,a3,7
    800065c6:	c6a5                	beqz	a3,8000662e <virtio_disk_intr+0xb8>
    int id = disk[n].used->elems[disk[n].used_idx].id;

    if(disk[n].info[id].status != 0)
    800065c8:	0001c917          	auipc	s2,0x1c
    800065cc:	a3890913          	addi	s2,s2,-1480 # 80022000 <disk>
    800065d0:	00149693          	slli	a3,s1,0x1
    800065d4:	00968533          	add	a0,a3,s1
    800065d8:	00851993          	slli	s3,a0,0x8
      panic("virtio_disk_intr status");
    
    disk[n].info[id].b->disk = 0;   // disk is done with buf
    wakeup(disk[n].info[id].b);

    disk[n].used_idx = (disk[n].used_idx + 1) % NUM;
    800065dc:	0532                	slli	a0,a0,0xc
    800065de:	954a                	add	a0,a0,s2
    800065e0:	6489                	lui	s1,0x2
    800065e2:	94aa                	add	s1,s1,a0
    int id = disk[n].used->elems[disk[n].used_idx].id;
    800065e4:	078e                	slli	a5,a5,0x3
    800065e6:	973e                	add	a4,a4,a5
    800065e8:	435c                	lw	a5,4(a4)
    if(disk[n].info[id].status != 0)
    800065ea:	00f98733          	add	a4,s3,a5
    800065ee:	20070713          	addi	a4,a4,512
    800065f2:	0712                	slli	a4,a4,0x4
    800065f4:	974a                	add	a4,a4,s2
    800065f6:	03074703          	lbu	a4,48(a4)
    800065fa:	e739                	bnez	a4,80006648 <virtio_disk_intr+0xd2>
    disk[n].info[id].b->disk = 0;   // disk is done with buf
    800065fc:	97ce                	add	a5,a5,s3
    800065fe:	20078793          	addi	a5,a5,512
    80006602:	0792                	slli	a5,a5,0x4
    80006604:	97ca                	add	a5,a5,s2
    80006606:	7798                	ld	a4,40(a5)
    80006608:	00072223          	sw	zero,4(a4)
    wakeup(disk[n].info[id].b);
    8000660c:	7788                	ld	a0,40(a5)
    8000660e:	ffffc097          	auipc	ra,0xffffc
    80006612:	e30080e7          	jalr	-464(ra) # 8000243e <wakeup>
    disk[n].used_idx = (disk[n].used_idx + 1) % NUM;
    80006616:	0204d783          	lhu	a5,32(s1) # 2020 <_entry-0x7fffdfe0>
    8000661a:	2785                	addiw	a5,a5,1
    8000661c:	8b9d                	andi	a5,a5,7
    8000661e:	02f49023          	sh	a5,32(s1)
  while((disk[n].used_idx % NUM) != (disk[n].used->id % NUM)){
    80006622:	6898                	ld	a4,16(s1)
    80006624:	00275683          	lhu	a3,2(a4)
    80006628:	8a9d                	andi	a3,a3,7
    8000662a:	faf69de3          	bne	a3,a5,800065e4 <virtio_disk_intr+0x6e>
  }

  release(&disk[n].vdisk_lock);
    8000662e:	8552                	mv	a0,s4
    80006630:	ffffa097          	auipc	ra,0xffffa
    80006634:	598080e7          	jalr	1432(ra) # 80000bc8 <release>
}
    80006638:	70a2                	ld	ra,40(sp)
    8000663a:	7402                	ld	s0,32(sp)
    8000663c:	64e2                	ld	s1,24(sp)
    8000663e:	6942                	ld	s2,16(sp)
    80006640:	69a2                	ld	s3,8(sp)
    80006642:	6a02                	ld	s4,0(sp)
    80006644:	6145                	addi	sp,sp,48
    80006646:	8082                	ret
      panic("virtio_disk_intr status");
    80006648:	00002517          	auipc	a0,0x2
    8000664c:	5a050513          	addi	a0,a0,1440 # 80008be8 <userret+0xb58>
    80006650:	ffffa097          	auipc	ra,0xffffa
    80006654:	f1a080e7          	jalr	-230(ra) # 8000056a <panic>

0000000080006658 <bit_isset>:
static Sz_info *bd_sizes; 
static void *bd_base;   // start address of memory managed by the buddy allocator
static struct spinlock lock;

// Return 1 if bit at position index in array is set to 1
int bit_isset(char *array, int index) {
    80006658:	1141                	addi	sp,sp,-16
    8000665a:	e406                	sd	ra,8(sp)
    8000665c:	e022                	sd	s0,0(sp)
    8000665e:	0800                	addi	s0,sp,16
  char b = array[index/8];
  char m = (1 << (index % 8));
    80006660:	0075f793          	andi	a5,a1,7
    80006664:	4705                	li	a4,1
    80006666:	00f7173b          	sllw	a4,a4,a5
  char b = array[index/8];
    8000666a:	41f5d79b          	sraiw	a5,a1,0x1f
    8000666e:	01d7d79b          	srliw	a5,a5,0x1d
    80006672:	9fad                	addw	a5,a5,a1
    80006674:	4037d79b          	sraiw	a5,a5,0x3
    80006678:	953e                	add	a0,a0,a5
  return (b & m) == m;
    8000667a:	00054503          	lbu	a0,0(a0)
    8000667e:	8d79                	and	a0,a0,a4
    80006680:	0ff77713          	zext.b	a4,a4
    80006684:	8d19                	sub	a0,a0,a4
}
    80006686:	00153513          	seqz	a0,a0
    8000668a:	60a2                	ld	ra,8(sp)
    8000668c:	6402                	ld	s0,0(sp)
    8000668e:	0141                	addi	sp,sp,16
    80006690:	8082                	ret

0000000080006692 <bit_set>:

// Set bit at position index in array to 1
void bit_set(char *array, int index) {
    80006692:	1141                	addi	sp,sp,-16
    80006694:	e406                	sd	ra,8(sp)
    80006696:	e022                	sd	s0,0(sp)
    80006698:	0800                	addi	s0,sp,16
  char b = array[index/8];
    8000669a:	41f5d79b          	sraiw	a5,a1,0x1f
    8000669e:	01d7d79b          	srliw	a5,a5,0x1d
    800066a2:	9fad                	addw	a5,a5,a1
    800066a4:	4037d79b          	sraiw	a5,a5,0x3
    800066a8:	953e                	add	a0,a0,a5
  char m = (1 << (index % 8));
    800066aa:	899d                	andi	a1,a1,7
    800066ac:	4785                	li	a5,1
    800066ae:	00b797bb          	sllw	a5,a5,a1
  array[index/8] = (b | m);
    800066b2:	00054703          	lbu	a4,0(a0)
    800066b6:	8fd9                	or	a5,a5,a4
    800066b8:	00f50023          	sb	a5,0(a0)
}
    800066bc:	60a2                	ld	ra,8(sp)
    800066be:	6402                	ld	s0,0(sp)
    800066c0:	0141                	addi	sp,sp,16
    800066c2:	8082                	ret

00000000800066c4 <bit_clear>:

// Clear bit at position index in array
void bit_clear(char *array, int index) {
    800066c4:	1141                	addi	sp,sp,-16
    800066c6:	e406                	sd	ra,8(sp)
    800066c8:	e022                	sd	s0,0(sp)
    800066ca:	0800                	addi	s0,sp,16
  char b = array[index/8];
    800066cc:	41f5d79b          	sraiw	a5,a1,0x1f
    800066d0:	01d7d79b          	srliw	a5,a5,0x1d
    800066d4:	9fad                	addw	a5,a5,a1
    800066d6:	4037d79b          	sraiw	a5,a5,0x3
    800066da:	953e                	add	a0,a0,a5
  char m = (1 << (index % 8));
    800066dc:	899d                	andi	a1,a1,7
    800066de:	4785                	li	a5,1
    800066e0:	00b797bb          	sllw	a5,a5,a1
  array[index/8] = (b & ~m);
    800066e4:	fff7c793          	not	a5,a5
    800066e8:	00054703          	lbu	a4,0(a0)
    800066ec:	8ff9                	and	a5,a5,a4
    800066ee:	00f50023          	sb	a5,0(a0)
}
    800066f2:	60a2                	ld	ra,8(sp)
    800066f4:	6402                	ld	s0,0(sp)
    800066f6:	0141                	addi	sp,sp,16
    800066f8:	8082                	ret

00000000800066fa <bd_print_vector>:

// Print a bit vector as a list of ranges of 1 bits
void
bd_print_vector(char *vector, int len) {
    800066fa:	7139                	addi	sp,sp,-64
    800066fc:	fc06                	sd	ra,56(sp)
    800066fe:	f822                	sd	s0,48(sp)
    80006700:	e852                	sd	s4,16(sp)
    80006702:	e456                	sd	s5,8(sp)
    80006704:	0080                	addi	s0,sp,64
    80006706:	8a2e                	mv	s4,a1
  int last, lb;
  
  last = 1;
  lb = 0;
  for (int b = 0; b < len; b++) {
    80006708:	0ab05263          	blez	a1,800067ac <bd_print_vector+0xb2>
    8000670c:	f426                	sd	s1,40(sp)
    8000670e:	f04a                	sd	s2,32(sp)
    80006710:	ec4e                	sd	s3,24(sp)
    80006712:	e05a                	sd	s6,0(sp)
    80006714:	89aa                	mv	s3,a0
    80006716:	4481                	li	s1,0
  lb = 0;
    80006718:	4a81                	li	s5,0
  last = 1;
    8000671a:	4905                	li	s2,1
    if (last == bit_isset(vector, b))
      continue;
    if(last == 1)
    8000671c:	8b4a                	mv	s6,s2
    8000671e:	a035                	j	8000674a <bd_print_vector+0x50>
      printf(" [%d, %d)", lb, b);
    80006720:	8626                	mv	a2,s1
    80006722:	85d6                	mv	a1,s5
    80006724:	00002517          	auipc	a0,0x2
    80006728:	4dc50513          	addi	a0,a0,1244 # 80008c00 <userret+0xb70>
    8000672c:	ffffa097          	auipc	ra,0xffffa
    80006730:	e98080e7          	jalr	-360(ra) # 800005c4 <printf>
    lb = b;
    last = bit_isset(vector, b);
    80006734:	85a6                	mv	a1,s1
    80006736:	854e                	mv	a0,s3
    80006738:	00000097          	auipc	ra,0x0
    8000673c:	f20080e7          	jalr	-224(ra) # 80006658 <bit_isset>
    80006740:	892a                	mv	s2,a0
    lb = b;
    80006742:	8aa6                	mv	s5,s1
  for (int b = 0; b < len; b++) {
    80006744:	2485                	addiw	s1,s1,1
    80006746:	009a0d63          	beq	s4,s1,80006760 <bd_print_vector+0x66>
    if (last == bit_isset(vector, b))
    8000674a:	85a6                	mv	a1,s1
    8000674c:	854e                	mv	a0,s3
    8000674e:	00000097          	auipc	ra,0x0
    80006752:	f0a080e7          	jalr	-246(ra) # 80006658 <bit_isset>
    80006756:	ff2507e3          	beq	a0,s2,80006744 <bd_print_vector+0x4a>
    if(last == 1)
    8000675a:	fd691de3          	bne	s2,s6,80006734 <bd_print_vector+0x3a>
    8000675e:	b7c9                	j	80006720 <bd_print_vector+0x26>
  }
  if(lb == 0 || last == 1) {
    80006760:	040a8863          	beqz	s5,800067b0 <bd_print_vector+0xb6>
    80006764:	197d                	addi	s2,s2,-1
    80006766:	02090463          	beqz	s2,8000678e <bd_print_vector+0x94>
    8000676a:	74a2                	ld	s1,40(sp)
    8000676c:	7902                	ld	s2,32(sp)
    8000676e:	69e2                	ld	s3,24(sp)
    80006770:	6b02                	ld	s6,0(sp)
    printf(" [%d, %d)", lb, len);
  }
  printf("\n");
    80006772:	00002517          	auipc	a0,0x2
    80006776:	9b650513          	addi	a0,a0,-1610 # 80008128 <userret+0x98>
    8000677a:	ffffa097          	auipc	ra,0xffffa
    8000677e:	e4a080e7          	jalr	-438(ra) # 800005c4 <printf>
}
    80006782:	70e2                	ld	ra,56(sp)
    80006784:	7442                	ld	s0,48(sp)
    80006786:	6a42                	ld	s4,16(sp)
    80006788:	6aa2                	ld	s5,8(sp)
    8000678a:	6121                	addi	sp,sp,64
    8000678c:	8082                	ret
    8000678e:	74a2                	ld	s1,40(sp)
    80006790:	7902                	ld	s2,32(sp)
    80006792:	69e2                	ld	s3,24(sp)
    80006794:	6b02                	ld	s6,0(sp)
    printf(" [%d, %d)", lb, len);
    80006796:	8652                	mv	a2,s4
    80006798:	85d6                	mv	a1,s5
    8000679a:	00002517          	auipc	a0,0x2
    8000679e:	46650513          	addi	a0,a0,1126 # 80008c00 <userret+0xb70>
    800067a2:	ffffa097          	auipc	ra,0xffffa
    800067a6:	e22080e7          	jalr	-478(ra) # 800005c4 <printf>
    800067aa:	b7e1                	j	80006772 <bd_print_vector+0x78>
  lb = 0;
    800067ac:	4a81                	li	s5,0
    800067ae:	b7e5                	j	80006796 <bd_print_vector+0x9c>
    800067b0:	74a2                	ld	s1,40(sp)
    800067b2:	7902                	ld	s2,32(sp)
    800067b4:	69e2                	ld	s3,24(sp)
    800067b6:	6b02                	ld	s6,0(sp)
    800067b8:	bff9                	j	80006796 <bd_print_vector+0x9c>

00000000800067ba <bd_print>:

// Print buddy's data structures
void
bd_print() {
  for (int k = 0; k < nsizes; k++) {
    800067ba:	00022697          	auipc	a3,0x22
    800067be:	89e6a683          	lw	a3,-1890(a3) # 80028058 <nsizes>
    800067c2:	0ed05f63          	blez	a3,800068c0 <bd_print+0x106>
bd_print() {
    800067c6:	711d                	addi	sp,sp,-96
    800067c8:	ec86                	sd	ra,88(sp)
    800067ca:	e8a2                	sd	s0,80(sp)
    800067cc:	e4a6                	sd	s1,72(sp)
    800067ce:	e0ca                	sd	s2,64(sp)
    800067d0:	fc4e                	sd	s3,56(sp)
    800067d2:	f852                	sd	s4,48(sp)
    800067d4:	f456                	sd	s5,40(sp)
    800067d6:	f05a                	sd	s6,32(sp)
    800067d8:	ec5e                	sd	s7,24(sp)
    800067da:	e862                	sd	s8,16(sp)
    800067dc:	e466                	sd	s9,8(sp)
    800067de:	e06a                	sd	s10,0(sp)
    800067e0:	1080                	addi	s0,sp,96
  for (int k = 0; k < nsizes; k++) {
    800067e2:	4481                	li	s1,0
    printf("size %d (blksz %d nblk %d): free list: ", k, BLK_SIZE(k), NBLK(k));
    800067e4:	4a85                	li	s5,1
    800067e6:	4c41                	li	s8,16
    800067e8:	00002b97          	auipc	s7,0x2
    800067ec:	428b8b93          	addi	s7,s7,1064 # 80008c10 <userret+0xb80>
    lst_print(&bd_sizes[k].free);
    800067f0:	00022a17          	auipc	s4,0x22
    800067f4:	860a0a13          	addi	s4,s4,-1952 # 80028050 <bd_sizes>
    printf("  alloc:");
    800067f8:	00002b17          	auipc	s6,0x2
    800067fc:	440b0b13          	addi	s6,s6,1088 # 80008c38 <userret+0xba8>
    bd_print_vector(bd_sizes[k].alloc, NBLK(k));
    80006800:	00022997          	auipc	s3,0x22
    80006804:	85898993          	addi	s3,s3,-1960 # 80028058 <nsizes>
    if(k > 0) {
      printf("  split:");
    80006808:	00002c97          	auipc	s9,0x2
    8000680c:	440c8c93          	addi	s9,s9,1088 # 80008c48 <userret+0xbb8>
    80006810:	a801                	j	80006820 <bd_print+0x66>
  for (int k = 0; k < nsizes; k++) {
    80006812:	0009a683          	lw	a3,0(s3)
    80006816:	0485                	addi	s1,s1,1
    80006818:	0004879b          	sext.w	a5,s1
    8000681c:	08d7d463          	bge	a5,a3,800068a4 <bd_print+0xea>
    80006820:	0004891b          	sext.w	s2,s1
    printf("size %d (blksz %d nblk %d): free list: ", k, BLK_SIZE(k), NBLK(k));
    80006824:	36fd                	addiw	a3,a3,-1
    80006826:	9e85                	subw	a3,a3,s1
    80006828:	00da96bb          	sllw	a3,s5,a3
    8000682c:	009c1633          	sll	a2,s8,s1
    80006830:	85ca                	mv	a1,s2
    80006832:	855e                	mv	a0,s7
    80006834:	ffffa097          	auipc	ra,0xffffa
    80006838:	d90080e7          	jalr	-624(ra) # 800005c4 <printf>
    lst_print(&bd_sizes[k].free);
    8000683c:	00549d13          	slli	s10,s1,0x5
    80006840:	000a3503          	ld	a0,0(s4)
    80006844:	956a                	add	a0,a0,s10
    80006846:	00001097          	auipc	ra,0x1
    8000684a:	ab6080e7          	jalr	-1354(ra) # 800072fc <lst_print>
    printf("  alloc:");
    8000684e:	855a                	mv	a0,s6
    80006850:	ffffa097          	auipc	ra,0xffffa
    80006854:	d74080e7          	jalr	-652(ra) # 800005c4 <printf>
    bd_print_vector(bd_sizes[k].alloc, NBLK(k));
    80006858:	0009a583          	lw	a1,0(s3)
    8000685c:	35fd                	addiw	a1,a1,-1
    8000685e:	412585bb          	subw	a1,a1,s2
    80006862:	000a3783          	ld	a5,0(s4)
    80006866:	97ea                	add	a5,a5,s10
    80006868:	00ba95bb          	sllw	a1,s5,a1
    8000686c:	6b88                	ld	a0,16(a5)
    8000686e:	00000097          	auipc	ra,0x0
    80006872:	e8c080e7          	jalr	-372(ra) # 800066fa <bd_print_vector>
    if(k > 0) {
    80006876:	f9205ee3          	blez	s2,80006812 <bd_print+0x58>
      printf("  split:");
    8000687a:	8566                	mv	a0,s9
    8000687c:	ffffa097          	auipc	ra,0xffffa
    80006880:	d48080e7          	jalr	-696(ra) # 800005c4 <printf>
      bd_print_vector(bd_sizes[k].split, NBLK(k));
    80006884:	0009a583          	lw	a1,0(s3)
    80006888:	35fd                	addiw	a1,a1,-1
    8000688a:	412585bb          	subw	a1,a1,s2
    8000688e:	000a3783          	ld	a5,0(s4)
    80006892:	97ea                	add	a5,a5,s10
    80006894:	00ba95bb          	sllw	a1,s5,a1
    80006898:	6f88                	ld	a0,24(a5)
    8000689a:	00000097          	auipc	ra,0x0
    8000689e:	e60080e7          	jalr	-416(ra) # 800066fa <bd_print_vector>
    800068a2:	bf85                	j	80006812 <bd_print+0x58>
    }
  }
}
    800068a4:	60e6                	ld	ra,88(sp)
    800068a6:	6446                	ld	s0,80(sp)
    800068a8:	64a6                	ld	s1,72(sp)
    800068aa:	6906                	ld	s2,64(sp)
    800068ac:	79e2                	ld	s3,56(sp)
    800068ae:	7a42                	ld	s4,48(sp)
    800068b0:	7aa2                	ld	s5,40(sp)
    800068b2:	7b02                	ld	s6,32(sp)
    800068b4:	6be2                	ld	s7,24(sp)
    800068b6:	6c42                	ld	s8,16(sp)
    800068b8:	6ca2                	ld	s9,8(sp)
    800068ba:	6d02                	ld	s10,0(sp)
    800068bc:	6125                	addi	sp,sp,96
    800068be:	8082                	ret
    800068c0:	8082                	ret

00000000800068c2 <firstk>:

// What is the first k such that 2^k >= n?
int
firstk(uint64 n) {
    800068c2:	1141                	addi	sp,sp,-16
    800068c4:	e406                	sd	ra,8(sp)
    800068c6:	e022                	sd	s0,0(sp)
    800068c8:	0800                	addi	s0,sp,16
  int k = 0;
  uint64 size = LEAF_SIZE;

  while (size < n) {
    800068ca:	47c1                	li	a5,16
    800068cc:	00a7fc63          	bgeu	a5,a0,800068e4 <firstk+0x22>
    800068d0:	872a                	mv	a4,a0
  int k = 0;
    800068d2:	4501                	li	a0,0
    k++;
    800068d4:	2505                	addiw	a0,a0,1
    size *= 2;
    800068d6:	0786                	slli	a5,a5,0x1
  while (size < n) {
    800068d8:	fee7eee3          	bltu	a5,a4,800068d4 <firstk+0x12>
  }
  return k;
}
    800068dc:	60a2                	ld	ra,8(sp)
    800068de:	6402                	ld	s0,0(sp)
    800068e0:	0141                	addi	sp,sp,16
    800068e2:	8082                	ret
  int k = 0;
    800068e4:	4501                	li	a0,0
    800068e6:	bfdd                	j	800068dc <firstk+0x1a>

00000000800068e8 <blk_index>:

// Compute the block index for address p at size k
int
blk_index(int k, char *p) {
    800068e8:	1141                	addi	sp,sp,-16
    800068ea:	e406                	sd	ra,8(sp)
    800068ec:	e022                	sd	s0,0(sp)
    800068ee:	0800                	addi	s0,sp,16
  int n = p - (char *) bd_base;
  return n / BLK_SIZE(k);
    800068f0:	00021797          	auipc	a5,0x21
    800068f4:	7587b783          	ld	a5,1880(a5) # 80028048 <bd_base>
    800068f8:	9d9d                	subw	a1,a1,a5
    800068fa:	47c1                	li	a5,16
    800068fc:	00a797b3          	sll	a5,a5,a0
    80006900:	02f5c5b3          	div	a1,a1,a5
}
    80006904:	0005851b          	sext.w	a0,a1
    80006908:	60a2                	ld	ra,8(sp)
    8000690a:	6402                	ld	s0,0(sp)
    8000690c:	0141                	addi	sp,sp,16
    8000690e:	8082                	ret

0000000080006910 <addr>:

// Convert a block index at size k back into an address
void *addr(int k, int bi) {
    80006910:	1141                	addi	sp,sp,-16
    80006912:	e406                	sd	ra,8(sp)
    80006914:	e022                	sd	s0,0(sp)
    80006916:	0800                	addi	s0,sp,16
  int n = bi * BLK_SIZE(k);
    80006918:	47c1                	li	a5,16
    8000691a:	00a797b3          	sll	a5,a5,a0
    8000691e:	02b787bb          	mulw	a5,a5,a1
  return (char *) bd_base + n;
}
    80006922:	00021517          	auipc	a0,0x21
    80006926:	72653503          	ld	a0,1830(a0) # 80028048 <bd_base>
    8000692a:	953e                	add	a0,a0,a5
    8000692c:	60a2                	ld	ra,8(sp)
    8000692e:	6402                	ld	s0,0(sp)
    80006930:	0141                	addi	sp,sp,16
    80006932:	8082                	ret

0000000080006934 <bd_malloc>:

// allocate nbytes, but malloc won't return anything smaller than LEAF_SIZE
void *
bd_malloc(uint64 nbytes)
{
    80006934:	7159                	addi	sp,sp,-112
    80006936:	f486                	sd	ra,104(sp)
    80006938:	f0a2                	sd	s0,96(sp)
    8000693a:	eca6                	sd	s1,88(sp)
    8000693c:	f85a                	sd	s6,48(sp)
    8000693e:	1880                	addi	s0,sp,112
    80006940:	84aa                	mv	s1,a0
  int fk, k;

  acquire(&lock);
    80006942:	00021517          	auipc	a0,0x21
    80006946:	6be50513          	addi	a0,a0,1726 # 80028000 <lock>
    8000694a:	ffffa097          	auipc	ra,0xffffa
    8000694e:	1ba080e7          	jalr	442(ra) # 80000b04 <acquire>

  // Find a free block >= nbytes, starting with smallest k possible
  fk = firstk(nbytes);
    80006952:	8526                	mv	a0,s1
    80006954:	00000097          	auipc	ra,0x0
    80006958:	f6e080e7          	jalr	-146(ra) # 800068c2 <firstk>
  for (k = fk; k < nsizes; k++) {
    8000695c:	00021797          	auipc	a5,0x21
    80006960:	6fc7a783          	lw	a5,1788(a5) # 80028058 <nsizes>
    80006964:	04f55563          	bge	a0,a5,800069ae <bd_malloc+0x7a>
    80006968:	e8ca                	sd	s2,80(sp)
    8000696a:	e4ce                	sd	s3,72(sp)
    8000696c:	e0d2                	sd	s4,64(sp)
    8000696e:	f062                	sd	s8,32(sp)
    80006970:	8c2a                	mv	s8,a0
    80006972:	00551913          	slli	s2,a0,0x5
    80006976:	84aa                	mv	s1,a0
    if(!lst_empty(&bd_sizes[k].free))
    80006978:	00021997          	auipc	s3,0x21
    8000697c:	6d898993          	addi	s3,s3,1752 # 80028050 <bd_sizes>
  for (k = fk; k < nsizes; k++) {
    80006980:	00021a17          	auipc	s4,0x21
    80006984:	6d8a0a13          	addi	s4,s4,1752 # 80028058 <nsizes>
    if(!lst_empty(&bd_sizes[k].free))
    80006988:	0009b503          	ld	a0,0(s3)
    8000698c:	954a                	add	a0,a0,s2
    8000698e:	00001097          	auipc	ra,0x1
    80006992:	8e8080e7          	jalr	-1816(ra) # 80007276 <lst_empty>
    80006996:	c515                	beqz	a0,800069c2 <bd_malloc+0x8e>
  for (k = fk; k < nsizes; k++) {
    80006998:	2485                	addiw	s1,s1,1
    8000699a:	02090913          	addi	s2,s2,32
    8000699e:	000a2783          	lw	a5,0(s4)
    800069a2:	fef4c3e3          	blt	s1,a5,80006988 <bd_malloc+0x54>
    800069a6:	6946                	ld	s2,80(sp)
    800069a8:	69a6                	ld	s3,72(sp)
    800069aa:	6a06                	ld	s4,64(sp)
    800069ac:	7c02                	ld	s8,32(sp)
      break;
  }
  if(k >= nsizes) { // No free blocks?
    release(&lock);
    800069ae:	00021517          	auipc	a0,0x21
    800069b2:	65250513          	addi	a0,a0,1618 # 80028000 <lock>
    800069b6:	ffffa097          	auipc	ra,0xffffa
    800069ba:	212080e7          	jalr	530(ra) # 80000bc8 <release>
    return 0;
    800069be:	4b01                	li	s6,0
    800069c0:	a0e5                	j	80006aa8 <bd_malloc+0x174>
  if(k >= nsizes) { // No free blocks?
    800069c2:	00021797          	auipc	a5,0x21
    800069c6:	6967a783          	lw	a5,1686(a5) # 80028058 <nsizes>
    800069ca:	0ef4d663          	bge	s1,a5,80006ab6 <bd_malloc+0x182>
  }

  // Found a block; pop it and potentially split it.
  char *p = lst_pop(&bd_sizes[k].free);
    800069ce:	00549993          	slli	s3,s1,0x5
    800069d2:	00021917          	auipc	s2,0x21
    800069d6:	67e90913          	addi	s2,s2,1662 # 80028050 <bd_sizes>
    800069da:	00093503          	ld	a0,0(s2)
    800069de:	954e                	add	a0,a0,s3
    800069e0:	00001097          	auipc	ra,0x1
    800069e4:	8ca080e7          	jalr	-1846(ra) # 800072aa <lst_pop>
    800069e8:	8b2a                	mv	s6,a0
  return n / BLK_SIZE(k);
    800069ea:	00021597          	auipc	a1,0x21
    800069ee:	65e5b583          	ld	a1,1630(a1) # 80028048 <bd_base>
    800069f2:	40b505bb          	subw	a1,a0,a1
    800069f6:	47c1                	li	a5,16
    800069f8:	009797b3          	sll	a5,a5,s1
    800069fc:	02f5c5b3          	div	a1,a1,a5
  bit_set(bd_sizes[k].alloc, blk_index(k, p));
    80006a00:	00093783          	ld	a5,0(s2)
    80006a04:	97ce                	add	a5,a5,s3
    80006a06:	2581                	sext.w	a1,a1
    80006a08:	6b88                	ld	a0,16(a5)
    80006a0a:	00000097          	auipc	ra,0x0
    80006a0e:	c88080e7          	jalr	-888(ra) # 80006692 <bit_set>
  for(; k > fk; k--) {
    80006a12:	069c5f63          	bge	s8,s1,80006a90 <bd_malloc+0x15c>
    80006a16:	fc56                	sd	s5,56(sp)
    80006a18:	f45e                	sd	s7,40(sp)
    80006a1a:	ec66                	sd	s9,24(sp)
    80006a1c:	e86a                	sd	s10,16(sp)
    80006a1e:	e46e                	sd	s11,8(sp)
    // split a block at size k and mark one half allocated at size k-1
    // and put the buddy on the free list at size k-1
    char *q = p + BLK_SIZE(k-1);   // p's buddy
    80006a20:	4bc1                	li	s7,16
    bit_set(bd_sizes[k].split, blk_index(k, p));
    80006a22:	8dca                	mv	s11,s2
  int n = p - (char *) bd_base;
    80006a24:	00021d17          	auipc	s10,0x21
    80006a28:	624d0d13          	addi	s10,s10,1572 # 80028048 <bd_base>
    char *q = p + BLK_SIZE(k-1);   // p's buddy
    80006a2c:	85a6                	mv	a1,s1
    80006a2e:	fff48a9b          	addiw	s5,s1,-1
    80006a32:	84d6                	mv	s1,s5
    80006a34:	015b9ab3          	sll	s5,s7,s5
    80006a38:	015b0cb3          	add	s9,s6,s5
    bit_set(bd_sizes[k].split, blk_index(k, p));
    80006a3c:	000dba03          	ld	s4,0(s11)
  int n = p - (char *) bd_base;
    80006a40:	000d3903          	ld	s2,0(s10)
  return n / BLK_SIZE(k);
    80006a44:	412b093b          	subw	s2,s6,s2
    80006a48:	00bb95b3          	sll	a1,s7,a1
    80006a4c:	02b945b3          	div	a1,s2,a1
    bit_set(bd_sizes[k].split, blk_index(k, p));
    80006a50:	013a07b3          	add	a5,s4,s3
    80006a54:	2581                	sext.w	a1,a1
    80006a56:	6f88                	ld	a0,24(a5)
    80006a58:	00000097          	auipc	ra,0x0
    80006a5c:	c3a080e7          	jalr	-966(ra) # 80006692 <bit_set>
    bit_set(bd_sizes[k-1].alloc, blk_index(k-1, p));
    80006a60:	1981                	addi	s3,s3,-32
    80006a62:	9a4e                	add	s4,s4,s3
  return n / BLK_SIZE(k);
    80006a64:	035945b3          	div	a1,s2,s5
    bit_set(bd_sizes[k-1].alloc, blk_index(k-1, p));
    80006a68:	2581                	sext.w	a1,a1
    80006a6a:	010a3503          	ld	a0,16(s4)
    80006a6e:	00000097          	auipc	ra,0x0
    80006a72:	c24080e7          	jalr	-988(ra) # 80006692 <bit_set>
    lst_push(&bd_sizes[k-1].free, q);
    80006a76:	85e6                	mv	a1,s9
    80006a78:	8552                	mv	a0,s4
    80006a7a:	00001097          	auipc	ra,0x1
    80006a7e:	866080e7          	jalr	-1946(ra) # 800072e0 <lst_push>
  for(; k > fk; k--) {
    80006a82:	fb8495e3          	bne	s1,s8,80006a2c <bd_malloc+0xf8>
    80006a86:	7ae2                	ld	s5,56(sp)
    80006a88:	7ba2                	ld	s7,40(sp)
    80006a8a:	6ce2                	ld	s9,24(sp)
    80006a8c:	6d42                	ld	s10,16(sp)
    80006a8e:	6da2                	ld	s11,8(sp)
  }
  release(&lock);
    80006a90:	00021517          	auipc	a0,0x21
    80006a94:	57050513          	addi	a0,a0,1392 # 80028000 <lock>
    80006a98:	ffffa097          	auipc	ra,0xffffa
    80006a9c:	130080e7          	jalr	304(ra) # 80000bc8 <release>
    80006aa0:	6946                	ld	s2,80(sp)
    80006aa2:	69a6                	ld	s3,72(sp)
    80006aa4:	6a06                	ld	s4,64(sp)
    80006aa6:	7c02                	ld	s8,32(sp)

  return p;
}
    80006aa8:	855a                	mv	a0,s6
    80006aaa:	70a6                	ld	ra,104(sp)
    80006aac:	7406                	ld	s0,96(sp)
    80006aae:	64e6                	ld	s1,88(sp)
    80006ab0:	7b42                	ld	s6,48(sp)
    80006ab2:	6165                	addi	sp,sp,112
    80006ab4:	8082                	ret
    80006ab6:	6946                	ld	s2,80(sp)
    80006ab8:	69a6                	ld	s3,72(sp)
    80006aba:	6a06                	ld	s4,64(sp)
    80006abc:	7c02                	ld	s8,32(sp)
    80006abe:	bdc5                	j	800069ae <bd_malloc+0x7a>

0000000080006ac0 <size>:

// Find the size of the block that p points to.
int
size(char *p) {
    80006ac0:	7139                	addi	sp,sp,-64
    80006ac2:	fc06                	sd	ra,56(sp)
    80006ac4:	f822                	sd	s0,48(sp)
    80006ac6:	f426                	sd	s1,40(sp)
    80006ac8:	f04a                	sd	s2,32(sp)
    80006aca:	ec4e                	sd	s3,24(sp)
    80006acc:	e852                	sd	s4,16(sp)
    80006ace:	e456                	sd	s5,8(sp)
    80006ad0:	e05a                	sd	s6,0(sp)
    80006ad2:	0080                	addi	s0,sp,64
  for (int k = 0; k < nsizes; k++) {
    80006ad4:	00021a97          	auipc	s5,0x21
    80006ad8:	584aaa83          	lw	s5,1412(s5) # 80028058 <nsizes>
  return n / BLK_SIZE(k);
    80006adc:	00021797          	auipc	a5,0x21
    80006ae0:	56c7b783          	ld	a5,1388(a5) # 80028048 <bd_base>
    80006ae4:	40f50a3b          	subw	s4,a0,a5
    80006ae8:	00021497          	auipc	s1,0x21
    80006aec:	5684b483          	ld	s1,1384(s1) # 80028050 <bd_sizes>
    80006af0:	03848493          	addi	s1,s1,56
  for (int k = 0; k < nsizes; k++) {
    80006af4:	4901                	li	s2,0
  return n / BLK_SIZE(k);
    80006af6:	4b41                	li	s6,16
  for (int k = 0; k < nsizes; k++) {
    80006af8:	03595363          	bge	s2,s5,80006b1e <size+0x5e>
    if(bit_isset(bd_sizes[k+1].split, blk_index(k+1, p))) {
    80006afc:	0019099b          	addiw	s3,s2,1
  return n / BLK_SIZE(k);
    80006b00:	013b15b3          	sll	a1,s6,s3
    80006b04:	02ba45b3          	div	a1,s4,a1
    if(bit_isset(bd_sizes[k+1].split, blk_index(k+1, p))) {
    80006b08:	2581                	sext.w	a1,a1
    80006b0a:	6088                	ld	a0,0(s1)
    80006b0c:	00000097          	auipc	ra,0x0
    80006b10:	b4c080e7          	jalr	-1204(ra) # 80006658 <bit_isset>
    80006b14:	02048493          	addi	s1,s1,32
    80006b18:	e501                	bnez	a0,80006b20 <size+0x60>
  for (int k = 0; k < nsizes; k++) {
    80006b1a:	894e                	mv	s2,s3
    80006b1c:	bff1                	j	80006af8 <size+0x38>
      return k;
    }
  }
  return 0;
    80006b1e:	4901                	li	s2,0
}
    80006b20:	854a                	mv	a0,s2
    80006b22:	70e2                	ld	ra,56(sp)
    80006b24:	7442                	ld	s0,48(sp)
    80006b26:	74a2                	ld	s1,40(sp)
    80006b28:	7902                	ld	s2,32(sp)
    80006b2a:	69e2                	ld	s3,24(sp)
    80006b2c:	6a42                	ld	s4,16(sp)
    80006b2e:	6aa2                	ld	s5,8(sp)
    80006b30:	6b02                	ld	s6,0(sp)
    80006b32:	6121                	addi	sp,sp,64
    80006b34:	8082                	ret

0000000080006b36 <bd_free>:

// Free memory pointed to by p, which was earlier allocated using
// bd_malloc.
void
bd_free(void *p) {
    80006b36:	7159                	addi	sp,sp,-112
    80006b38:	f486                	sd	ra,104(sp)
    80006b3a:	f0a2                	sd	s0,96(sp)
    80006b3c:	e4ce                	sd	s3,72(sp)
    80006b3e:	fc56                	sd	s5,56(sp)
    80006b40:	1880                	addi	s0,sp,112
    80006b42:	8aaa                	mv	s5,a0
  void *q;
  int k;

  acquire(&lock);
    80006b44:	00021517          	auipc	a0,0x21
    80006b48:	4bc50513          	addi	a0,a0,1212 # 80028000 <lock>
    80006b4c:	ffffa097          	auipc	ra,0xffffa
    80006b50:	fb8080e7          	jalr	-72(ra) # 80000b04 <acquire>
  for (k = size(p); k < MAXSIZE; k++) {
    80006b54:	8556                	mv	a0,s5
    80006b56:	00000097          	auipc	ra,0x0
    80006b5a:	f6a080e7          	jalr	-150(ra) # 80006ac0 <size>
    80006b5e:	89aa                	mv	s3,a0
    80006b60:	00021797          	auipc	a5,0x21
    80006b64:	4f87a783          	lw	a5,1272(a5) # 80028058 <nsizes>
    80006b68:	37fd                	addiw	a5,a5,-1
    80006b6a:	0ef55d63          	bge	a0,a5,80006c64 <bd_free+0x12e>
    80006b6e:	eca6                	sd	s1,88(sp)
    80006b70:	e8ca                	sd	s2,80(sp)
    80006b72:	e0d2                	sd	s4,64(sp)
    80006b74:	f85a                	sd	s6,48(sp)
    80006b76:	f45e                	sd	s7,40(sp)
    80006b78:	f062                	sd	s8,32(sp)
    80006b7a:	ec66                	sd	s9,24(sp)
    80006b7c:	e86a                	sd	s10,16(sp)
    80006b7e:	e46e                	sd	s11,8(sp)
    80006b80:	00551a13          	slli	s4,a0,0x5
    80006b84:	020a0a13          	addi	s4,s4,32
  int n = p - (char *) bd_base;
    80006b88:	00021c17          	auipc	s8,0x21
    80006b8c:	4c0c0c13          	addi	s8,s8,1216 # 80028048 <bd_base>
  return n / BLK_SIZE(k);
    80006b90:	4bc1                	li	s7,16
    int bi = blk_index(k, p);
    int buddy = (bi % 2 == 0) ? bi+1 : bi-1;
    bit_clear(bd_sizes[k].alloc, bi);  // free p at size k
    80006b92:	00021b17          	auipc	s6,0x21
    80006b96:	4beb0b13          	addi	s6,s6,1214 # 80028050 <bd_sizes>
  for (k = size(p); k < MAXSIZE; k++) {
    80006b9a:	00021c97          	auipc	s9,0x21
    80006b9e:	4bec8c93          	addi	s9,s9,1214 # 80028058 <nsizes>
    80006ba2:	a83d                	j	80006be0 <bd_free+0xaa>
    int buddy = (bi % 2 == 0) ? bi+1 : bi-1;
    80006ba4:	fff58d1b          	addiw	s10,a1,-1
    80006ba8:	a891                	j	80006bfc <bd_free+0xc6>
    if(buddy % 2 == 0) {
      p = q;
    }
    // at size k+1, mark that the merged buddy pair isn't split
    // anymore
    bit_clear(bd_sizes[k+1].split, blk_index(k+1, p));
    80006baa:	0019879b          	addiw	a5,s3,1
    80006bae:	89be                	mv	s3,a5
  int n = p - (char *) bd_base;
    80006bb0:	000c3583          	ld	a1,0(s8)
  return n / BLK_SIZE(k);
    80006bb4:	40ba85bb          	subw	a1,s5,a1
    80006bb8:	00fb97b3          	sll	a5,s7,a5
    80006bbc:	02f5c5b3          	div	a1,a1,a5
    bit_clear(bd_sizes[k+1].split, blk_index(k+1, p));
    80006bc0:	000b3783          	ld	a5,0(s6)
    80006bc4:	97d2                	add	a5,a5,s4
    80006bc6:	2581                	sext.w	a1,a1
    80006bc8:	6f88                	ld	a0,24(a5)
    80006bca:	00000097          	auipc	ra,0x0
    80006bce:	afa080e7          	jalr	-1286(ra) # 800066c4 <bit_clear>
  for (k = size(p); k < MAXSIZE; k++) {
    80006bd2:	020a0a13          	addi	s4,s4,32
    80006bd6:	000ca783          	lw	a5,0(s9)
    80006bda:	37fd                	addiw	a5,a5,-1
    80006bdc:	06f9d163          	bge	s3,a5,80006c3e <bd_free+0x108>
  int n = p - (char *) bd_base;
    80006be0:	000c3483          	ld	s1,0(s8)
  return n / BLK_SIZE(k);
    80006be4:	013b9933          	sll	s2,s7,s3
    80006be8:	409a87bb          	subw	a5,s5,s1
    80006bec:	0327c7b3          	div	a5,a5,s2
    80006bf0:	0007859b          	sext.w	a1,a5
    int buddy = (bi % 2 == 0) ? bi+1 : bi-1;
    80006bf4:	8b85                	andi	a5,a5,1
    80006bf6:	f7dd                	bnez	a5,80006ba4 <bd_free+0x6e>
    80006bf8:	00158d1b          	addiw	s10,a1,1
    bit_clear(bd_sizes[k].alloc, bi);  // free p at size k
    80006bfc:	fe0a0793          	addi	a5,s4,-32
    80006c00:	000b3d83          	ld	s11,0(s6)
    80006c04:	9dbe                	add	s11,s11,a5
    80006c06:	010db503          	ld	a0,16(s11)
    80006c0a:	00000097          	auipc	ra,0x0
    80006c0e:	aba080e7          	jalr	-1350(ra) # 800066c4 <bit_clear>
    if (bit_isset(bd_sizes[k].alloc, buddy)) {  // is buddy allocated?
    80006c12:	85ea                	mv	a1,s10
    80006c14:	010db503          	ld	a0,16(s11)
    80006c18:	00000097          	auipc	ra,0x0
    80006c1c:	a40080e7          	jalr	-1472(ra) # 80006658 <bit_isset>
    80006c20:	e90d                	bnez	a0,80006c52 <bd_free+0x11c>
  int n = bi * BLK_SIZE(k);
    80006c22:	03a9093b          	mulw	s2,s2,s10
  return (char *) bd_base + n;
    80006c26:	94ca                	add	s1,s1,s2
    lst_remove(q);    // remove buddy from free list
    80006c28:	8526                	mv	a0,s1
    80006c2a:	00000097          	auipc	ra,0x0
    80006c2e:	666080e7          	jalr	1638(ra) # 80007290 <lst_remove>
    if(buddy % 2 == 0) {
    80006c32:	001d7d13          	andi	s10,s10,1
    80006c36:	f60d1ae3          	bnez	s10,80006baa <bd_free+0x74>
      p = q;
    80006c3a:	8aa6                	mv	s5,s1
    80006c3c:	b7bd                	j	80006baa <bd_free+0x74>
    80006c3e:	64e6                	ld	s1,88(sp)
    80006c40:	6946                	ld	s2,80(sp)
    80006c42:	6a06                	ld	s4,64(sp)
    80006c44:	7b42                	ld	s6,48(sp)
    80006c46:	7ba2                	ld	s7,40(sp)
    80006c48:	7c02                	ld	s8,32(sp)
    80006c4a:	6ce2                	ld	s9,24(sp)
    80006c4c:	6d42                	ld	s10,16(sp)
    80006c4e:	6da2                	ld	s11,8(sp)
    80006c50:	a811                	j	80006c64 <bd_free+0x12e>
    80006c52:	64e6                	ld	s1,88(sp)
    80006c54:	6946                	ld	s2,80(sp)
    80006c56:	6a06                	ld	s4,64(sp)
    80006c58:	7b42                	ld	s6,48(sp)
    80006c5a:	7ba2                	ld	s7,40(sp)
    80006c5c:	7c02                	ld	s8,32(sp)
    80006c5e:	6ce2                	ld	s9,24(sp)
    80006c60:	6d42                	ld	s10,16(sp)
    80006c62:	6da2                	ld	s11,8(sp)
  }
  lst_push(&bd_sizes[k].free, p);
    80006c64:	0996                	slli	s3,s3,0x5
    80006c66:	85d6                	mv	a1,s5
    80006c68:	00021517          	auipc	a0,0x21
    80006c6c:	3e853503          	ld	a0,1000(a0) # 80028050 <bd_sizes>
    80006c70:	954e                	add	a0,a0,s3
    80006c72:	00000097          	auipc	ra,0x0
    80006c76:	66e080e7          	jalr	1646(ra) # 800072e0 <lst_push>
  release(&lock);
    80006c7a:	00021517          	auipc	a0,0x21
    80006c7e:	38650513          	addi	a0,a0,902 # 80028000 <lock>
    80006c82:	ffffa097          	auipc	ra,0xffffa
    80006c86:	f46080e7          	jalr	-186(ra) # 80000bc8 <release>
}
    80006c8a:	70a6                	ld	ra,104(sp)
    80006c8c:	7406                	ld	s0,96(sp)
    80006c8e:	69a6                	ld	s3,72(sp)
    80006c90:	7ae2                	ld	s5,56(sp)
    80006c92:	6165                	addi	sp,sp,112
    80006c94:	8082                	ret

0000000080006c96 <blk_index_next>:

// Compute the first block at size k that doesn't contain p
int
blk_index_next(int k, char *p) {
    80006c96:	1141                	addi	sp,sp,-16
    80006c98:	e406                	sd	ra,8(sp)
    80006c9a:	e022                	sd	s0,0(sp)
    80006c9c:	0800                	addi	s0,sp,16
  int n = (p - (char *) bd_base) / BLK_SIZE(k);
    80006c9e:	00021797          	auipc	a5,0x21
    80006ca2:	3aa7b783          	ld	a5,938(a5) # 80028048 <bd_base>
    80006ca6:	8d9d                	sub	a1,a1,a5
    80006ca8:	47c1                	li	a5,16
    80006caa:	00a797b3          	sll	a5,a5,a0
    80006cae:	02f5c533          	div	a0,a1,a5
    80006cb2:	2501                	sext.w	a0,a0
  if((p - (char*) bd_base) % BLK_SIZE(k) != 0)
    80006cb4:	02f5e5b3          	rem	a1,a1,a5
    80006cb8:	c191                	beqz	a1,80006cbc <blk_index_next+0x26>
      n++;
    80006cba:	2505                	addiw	a0,a0,1
  return n ;
}
    80006cbc:	60a2                	ld	ra,8(sp)
    80006cbe:	6402                	ld	s0,0(sp)
    80006cc0:	0141                	addi	sp,sp,16
    80006cc2:	8082                	ret

0000000080006cc4 <log2>:

int
log2(uint64 n) {
    80006cc4:	1141                	addi	sp,sp,-16
    80006cc6:	e406                	sd	ra,8(sp)
    80006cc8:	e022                	sd	s0,0(sp)
    80006cca:	0800                	addi	s0,sp,16
  int k = 0;
  while (n > 1) {
    80006ccc:	4705                	li	a4,1
    80006cce:	00a77c63          	bgeu	a4,a0,80006ce6 <log2+0x22>
    80006cd2:	87aa                	mv	a5,a0
  int k = 0;
    80006cd4:	4501                	li	a0,0
    k++;
    80006cd6:	2505                	addiw	a0,a0,1
    n = n >> 1;
    80006cd8:	8385                	srli	a5,a5,0x1
  while (n > 1) {
    80006cda:	fef76ee3          	bltu	a4,a5,80006cd6 <log2+0x12>
  }
  return k;
}
    80006cde:	60a2                	ld	ra,8(sp)
    80006ce0:	6402                	ld	s0,0(sp)
    80006ce2:	0141                	addi	sp,sp,16
    80006ce4:	8082                	ret
  int k = 0;
    80006ce6:	4501                	li	a0,0
    80006ce8:	bfdd                	j	80006cde <log2+0x1a>

0000000080006cea <bd_mark>:

// Mark memory from [start, stop), starting at size 0, as allocated. 
void
bd_mark(void *start, void *stop)
{
    80006cea:	711d                	addi	sp,sp,-96
    80006cec:	ec86                	sd	ra,88(sp)
    80006cee:	e8a2                	sd	s0,80(sp)
    80006cf0:	e0ca                	sd	s2,64(sp)
    80006cf2:	1080                	addi	s0,sp,96
  int bi, bj;

  if (((uint64) start % LEAF_SIZE != 0) || ((uint64) stop % LEAF_SIZE != 0))
    80006cf4:	00b56933          	or	s2,a0,a1
    80006cf8:	00f97913          	andi	s2,s2,15
    80006cfc:	02091e63          	bnez	s2,80006d38 <bd_mark+0x4e>
    80006d00:	fc4e                	sd	s3,56(sp)
    80006d02:	f456                	sd	s5,40(sp)
    80006d04:	f05a                	sd	s6,32(sp)
    80006d06:	ec5e                	sd	s7,24(sp)
    80006d08:	e862                	sd	s8,16(sp)
    80006d0a:	e466                	sd	s9,8(sp)
    80006d0c:	e06a                	sd	s10,0(sp)
    80006d0e:	8b2a                	mv	s6,a0
    80006d10:	8bae                	mv	s7,a1
    panic("bd_mark");

  for (int k = 0; k < nsizes; k++) {
    80006d12:	00021c17          	auipc	s8,0x21
    80006d16:	346c2c03          	lw	s8,838(s8) # 80028058 <nsizes>
    80006d1a:	4981                	li	s3,0
  int n = p - (char *) bd_base;
    80006d1c:	00021d17          	auipc	s10,0x21
    80006d20:	32cd0d13          	addi	s10,s10,812 # 80028048 <bd_base>
  return n / BLK_SIZE(k);
    80006d24:	4cc1                	li	s9,16
    bi = blk_index(k, start);
    bj = blk_index_next(k, stop);
    for(; bi < bj; bi++) {
      if(k > 0) {
        // if a block is allocated at size k, mark it as split too.
        bit_set(bd_sizes[k].split, bi);
    80006d26:	00021a97          	auipc	s5,0x21
    80006d2a:	32aa8a93          	addi	s5,s5,810 # 80028050 <bd_sizes>
  for (int k = 0; k < nsizes; k++) {
    80006d2e:	09805863          	blez	s8,80006dbe <bd_mark+0xd4>
    80006d32:	e4a6                	sd	s1,72(sp)
    80006d34:	f852                	sd	s4,48(sp)
    80006d36:	a8b9                	j	80006d94 <bd_mark+0xaa>
    80006d38:	e4a6                	sd	s1,72(sp)
    80006d3a:	fc4e                	sd	s3,56(sp)
    80006d3c:	f852                	sd	s4,48(sp)
    80006d3e:	f456                	sd	s5,40(sp)
    80006d40:	f05a                	sd	s6,32(sp)
    80006d42:	ec5e                	sd	s7,24(sp)
    80006d44:	e862                	sd	s8,16(sp)
    80006d46:	e466                	sd	s9,8(sp)
    80006d48:	e06a                	sd	s10,0(sp)
    panic("bd_mark");
    80006d4a:	00002517          	auipc	a0,0x2
    80006d4e:	f0e50513          	addi	a0,a0,-242 # 80008c58 <userret+0xbc8>
    80006d52:	ffffa097          	auipc	ra,0xffffa
    80006d56:	818080e7          	jalr	-2024(ra) # 8000056a <panic>
      }
      bit_set(bd_sizes[k].alloc, bi);
    80006d5a:	000ab783          	ld	a5,0(s5)
    80006d5e:	97ca                	add	a5,a5,s2
    80006d60:	85a6                	mv	a1,s1
    80006d62:	6b88                	ld	a0,16(a5)
    80006d64:	00000097          	auipc	ra,0x0
    80006d68:	92e080e7          	jalr	-1746(ra) # 80006692 <bit_set>
    for(; bi < bj; bi++) {
    80006d6c:	2485                	addiw	s1,s1,1
    80006d6e:	009a0e63          	beq	s4,s1,80006d8a <bd_mark+0xa0>
      if(k > 0) {
    80006d72:	ff3054e3          	blez	s3,80006d5a <bd_mark+0x70>
        bit_set(bd_sizes[k].split, bi);
    80006d76:	000ab783          	ld	a5,0(s5)
    80006d7a:	97ca                	add	a5,a5,s2
    80006d7c:	85a6                	mv	a1,s1
    80006d7e:	6f88                	ld	a0,24(a5)
    80006d80:	00000097          	auipc	ra,0x0
    80006d84:	912080e7          	jalr	-1774(ra) # 80006692 <bit_set>
    80006d88:	bfc9                	j	80006d5a <bd_mark+0x70>
  for (int k = 0; k < nsizes; k++) {
    80006d8a:	2985                	addiw	s3,s3,1
    80006d8c:	02090913          	addi	s2,s2,32
    80006d90:	03898563          	beq	s3,s8,80006dba <bd_mark+0xd0>
  int n = p - (char *) bd_base;
    80006d94:	000d3483          	ld	s1,0(s10)
  return n / BLK_SIZE(k);
    80006d98:	409b04bb          	subw	s1,s6,s1
    80006d9c:	013c97b3          	sll	a5,s9,s3
    80006da0:	02f4c4b3          	div	s1,s1,a5
    80006da4:	2481                	sext.w	s1,s1
    bj = blk_index_next(k, stop);
    80006da6:	85de                	mv	a1,s7
    80006da8:	854e                	mv	a0,s3
    80006daa:	00000097          	auipc	ra,0x0
    80006dae:	eec080e7          	jalr	-276(ra) # 80006c96 <blk_index_next>
    80006db2:	8a2a                	mv	s4,a0
    for(; bi < bj; bi++) {
    80006db4:	faa4cfe3          	blt	s1,a0,80006d72 <bd_mark+0x88>
    80006db8:	bfc9                	j	80006d8a <bd_mark+0xa0>
    80006dba:	64a6                	ld	s1,72(sp)
    80006dbc:	7a42                	ld	s4,48(sp)
    80006dbe:	79e2                	ld	s3,56(sp)
    80006dc0:	7aa2                	ld	s5,40(sp)
    80006dc2:	7b02                	ld	s6,32(sp)
    80006dc4:	6be2                	ld	s7,24(sp)
    80006dc6:	6c42                	ld	s8,16(sp)
    80006dc8:	6ca2                	ld	s9,8(sp)
    80006dca:	6d02                	ld	s10,0(sp)
    }
  }
}
    80006dcc:	60e6                	ld	ra,88(sp)
    80006dce:	6446                	ld	s0,80(sp)
    80006dd0:	6906                	ld	s2,64(sp)
    80006dd2:	6125                	addi	sp,sp,96
    80006dd4:	8082                	ret

0000000080006dd6 <bd_initfree_pair>:

// If a block is marked as allocated and the buddy is free, put the
// buddy on the free list at size k.
int
bd_initfree_pair(int k, int bi) {
    80006dd6:	7139                	addi	sp,sp,-64
    80006dd8:	fc06                	sd	ra,56(sp)
    80006dda:	f822                	sd	s0,48(sp)
    80006ddc:	f426                	sd	s1,40(sp)
    80006dde:	f04a                	sd	s2,32(sp)
    80006de0:	ec4e                	sd	s3,24(sp)
    80006de2:	e852                	sd	s4,16(sp)
    80006de4:	e456                	sd	s5,8(sp)
    80006de6:	e05a                	sd	s6,0(sp)
    80006de8:	0080                	addi	s0,sp,64
    80006dea:	8a2a                	mv	s4,a0
    80006dec:	84ae                	mv	s1,a1
  int buddy = (bi % 2 == 0) ? bi+1 : bi-1;
    80006dee:	0015f793          	andi	a5,a1,1
    80006df2:	ebb5                	bnez	a5,80006e66 <bd_initfree_pair+0x90>
    80006df4:	00158b1b          	addiw	s6,a1,1
  int free = 0;
  if(bit_isset(bd_sizes[k].alloc, bi) !=  bit_isset(bd_sizes[k].alloc, buddy)) {
    80006df8:	005a1793          	slli	a5,s4,0x5
    80006dfc:	00021917          	auipc	s2,0x21
    80006e00:	25493903          	ld	s2,596(s2) # 80028050 <bd_sizes>
    80006e04:	993e                	add	s2,s2,a5
    80006e06:	01093a83          	ld	s5,16(s2)
    80006e0a:	85a6                	mv	a1,s1
    80006e0c:	8556                	mv	a0,s5
    80006e0e:	00000097          	auipc	ra,0x0
    80006e12:	84a080e7          	jalr	-1974(ra) # 80006658 <bit_isset>
    80006e16:	89aa                	mv	s3,a0
    80006e18:	85da                	mv	a1,s6
    80006e1a:	8556                	mv	a0,s5
    80006e1c:	00000097          	auipc	ra,0x0
    80006e20:	83c080e7          	jalr	-1988(ra) # 80006658 <bit_isset>
  int free = 0;
    80006e24:	4a81                	li	s5,0
  if(bit_isset(bd_sizes[k].alloc, bi) !=  bit_isset(bd_sizes[k].alloc, buddy)) {
    80006e26:	02a98563          	beq	s3,a0,80006e50 <bd_initfree_pair+0x7a>
    // one of the pair is free
    free = BLK_SIZE(k);
    80006e2a:	45c1                	li	a1,16
    80006e2c:	014595b3          	sll	a1,a1,s4
    80006e30:	00058a9b          	sext.w	s5,a1
    if(bit_isset(bd_sizes[k].alloc, bi))
    80006e34:	02098c63          	beqz	s3,80006e6c <bd_initfree_pair+0x96>
  int n = bi * BLK_SIZE(k);
    80006e38:	036585bb          	mulw	a1,a1,s6
      lst_push(&bd_sizes[k].free, addr(k, buddy));   // put buddy on free list
    80006e3c:	00021797          	auipc	a5,0x21
    80006e40:	20c7b783          	ld	a5,524(a5) # 80028048 <bd_base>
    80006e44:	95be                	add	a1,a1,a5
    80006e46:	854a                	mv	a0,s2
    80006e48:	00000097          	auipc	ra,0x0
    80006e4c:	498080e7          	jalr	1176(ra) # 800072e0 <lst_push>
    else
      lst_push(&bd_sizes[k].free, addr(k, bi));      // put bi on free list
  }
  return free;
}
    80006e50:	8556                	mv	a0,s5
    80006e52:	70e2                	ld	ra,56(sp)
    80006e54:	7442                	ld	s0,48(sp)
    80006e56:	74a2                	ld	s1,40(sp)
    80006e58:	7902                	ld	s2,32(sp)
    80006e5a:	69e2                	ld	s3,24(sp)
    80006e5c:	6a42                	ld	s4,16(sp)
    80006e5e:	6aa2                	ld	s5,8(sp)
    80006e60:	6b02                	ld	s6,0(sp)
    80006e62:	6121                	addi	sp,sp,64
    80006e64:	8082                	ret
  int buddy = (bi % 2 == 0) ? bi+1 : bi-1;
    80006e66:	fff58b1b          	addiw	s6,a1,-1
    80006e6a:	b779                	j	80006df8 <bd_initfree_pair+0x22>
  int n = bi * BLK_SIZE(k);
    80006e6c:	029585bb          	mulw	a1,a1,s1
      lst_push(&bd_sizes[k].free, addr(k, bi));      // put bi on free list
    80006e70:	00021797          	auipc	a5,0x21
    80006e74:	1d87b783          	ld	a5,472(a5) # 80028048 <bd_base>
    80006e78:	95be                	add	a1,a1,a5
    80006e7a:	854a                	mv	a0,s2
    80006e7c:	00000097          	auipc	ra,0x0
    80006e80:	464080e7          	jalr	1124(ra) # 800072e0 <lst_push>
    80006e84:	b7f1                	j	80006e50 <bd_initfree_pair+0x7a>

0000000080006e86 <bd_initfree>:
  
// Initialize the free lists for each size k.  For each size k, there
// are only two pairs that may have a buddy that should be on free list:
// bd_left and bd_right.
int
bd_initfree(void *bd_left, void *bd_right) {
    80006e86:	711d                	addi	sp,sp,-96
    80006e88:	ec86                	sd	ra,88(sp)
    80006e8a:	e8a2                	sd	s0,80(sp)
    80006e8c:	f852                	sd	s4,48(sp)
    80006e8e:	1080                	addi	s0,sp,96
  int free = 0;

  for (int k = 0; k < MAXSIZE; k++) {   // skip max size
    80006e90:	00021717          	auipc	a4,0x21
    80006e94:	1c872703          	lw	a4,456(a4) # 80028058 <nsizes>
    80006e98:	4785                	li	a5,1
    80006e9a:	0ae7d263          	bge	a5,a4,80006f3e <bd_initfree+0xb8>
    80006e9e:	e4a6                	sd	s1,72(sp)
    80006ea0:	e0ca                	sd	s2,64(sp)
    80006ea2:	fc4e                	sd	s3,56(sp)
    80006ea4:	f456                	sd	s5,40(sp)
    80006ea6:	f05a                	sd	s6,32(sp)
    80006ea8:	ec5e                	sd	s7,24(sp)
    80006eaa:	e862                	sd	s8,16(sp)
    80006eac:	e466                	sd	s9,8(sp)
    80006eae:	e06a                	sd	s10,0(sp)
    80006eb0:	8aaa                	mv	s5,a0
    80006eb2:	8b2e                	mv	s6,a1
    80006eb4:	4901                	li	s2,0
  int free = 0;
    80006eb6:	4a01                	li	s4,0
  int n = p - (char *) bd_base;
    80006eb8:	00021c97          	auipc	s9,0x21
    80006ebc:	190c8c93          	addi	s9,s9,400 # 80028048 <bd_base>
  return n / BLK_SIZE(k);
    80006ec0:	4c41                	li	s8,16
  for (int k = 0; k < MAXSIZE; k++) {   // skip max size
    80006ec2:	00021b97          	auipc	s7,0x21
    80006ec6:	196b8b93          	addi	s7,s7,406 # 80028058 <nsizes>
    80006eca:	a039                	j	80006ed8 <bd_initfree+0x52>
    80006ecc:	2905                	addiw	s2,s2,1
    80006ece:	000ba783          	lw	a5,0(s7)
    80006ed2:	37fd                	addiw	a5,a5,-1
    80006ed4:	04f95663          	bge	s2,a5,80006f20 <bd_initfree+0x9a>
    int left = blk_index_next(k, bd_left);
    80006ed8:	85d6                	mv	a1,s5
    80006eda:	854a                	mv	a0,s2
    80006edc:	00000097          	auipc	ra,0x0
    80006ee0:	dba080e7          	jalr	-582(ra) # 80006c96 <blk_index_next>
    80006ee4:	89aa                	mv	s3,a0
  int n = p - (char *) bd_base;
    80006ee6:	000cb483          	ld	s1,0(s9)
  return n / BLK_SIZE(k);
    80006eea:	409b04bb          	subw	s1,s6,s1
    80006eee:	012c17b3          	sll	a5,s8,s2
    80006ef2:	02f4c4b3          	div	s1,s1,a5
    80006ef6:	2481                	sext.w	s1,s1
    int right = blk_index(k, bd_right);
    free += bd_initfree_pair(k, left);
    80006ef8:	85aa                	mv	a1,a0
    80006efa:	854a                	mv	a0,s2
    80006efc:	00000097          	auipc	ra,0x0
    80006f00:	eda080e7          	jalr	-294(ra) # 80006dd6 <bd_initfree_pair>
    80006f04:	01450d3b          	addw	s10,a0,s4
    80006f08:	8a6a                	mv	s4,s10
    if(right <= left)
    80006f0a:	fc99d1e3          	bge	s3,s1,80006ecc <bd_initfree+0x46>
      continue;
    free += bd_initfree_pair(k, right);
    80006f0e:	85a6                	mv	a1,s1
    80006f10:	854a                	mv	a0,s2
    80006f12:	00000097          	auipc	ra,0x0
    80006f16:	ec4080e7          	jalr	-316(ra) # 80006dd6 <bd_initfree_pair>
    80006f1a:	00ad0a3b          	addw	s4,s10,a0
    80006f1e:	b77d                	j	80006ecc <bd_initfree+0x46>
    80006f20:	64a6                	ld	s1,72(sp)
    80006f22:	6906                	ld	s2,64(sp)
    80006f24:	79e2                	ld	s3,56(sp)
    80006f26:	7aa2                	ld	s5,40(sp)
    80006f28:	7b02                	ld	s6,32(sp)
    80006f2a:	6be2                	ld	s7,24(sp)
    80006f2c:	6c42                	ld	s8,16(sp)
    80006f2e:	6ca2                	ld	s9,8(sp)
    80006f30:	6d02                	ld	s10,0(sp)
  }
  return free;
}
    80006f32:	8552                	mv	a0,s4
    80006f34:	60e6                	ld	ra,88(sp)
    80006f36:	6446                	ld	s0,80(sp)
    80006f38:	7a42                	ld	s4,48(sp)
    80006f3a:	6125                	addi	sp,sp,96
    80006f3c:	8082                	ret
  int free = 0;
    80006f3e:	4a01                	li	s4,0
    80006f40:	bfcd                	j	80006f32 <bd_initfree+0xac>

0000000080006f42 <bd_mark_data_structures>:

// Mark the range [bd_base,p) as allocated
int
bd_mark_data_structures(char *p) {
    80006f42:	7179                	addi	sp,sp,-48
    80006f44:	f406                	sd	ra,40(sp)
    80006f46:	f022                	sd	s0,32(sp)
    80006f48:	ec26                	sd	s1,24(sp)
    80006f4a:	e84a                	sd	s2,16(sp)
    80006f4c:	e44e                	sd	s3,8(sp)
    80006f4e:	1800                	addi	s0,sp,48
    80006f50:	892a                	mv	s2,a0
  int meta = p - (char*)bd_base;
    80006f52:	00021997          	auipc	s3,0x21
    80006f56:	0f698993          	addi	s3,s3,246 # 80028048 <bd_base>
    80006f5a:	0009b483          	ld	s1,0(s3)
    80006f5e:	409504bb          	subw	s1,a0,s1
  printf("bd: %d meta bytes for managing %d bytes of memory\n", meta, BLK_SIZE(MAXSIZE));
    80006f62:	00021797          	auipc	a5,0x21
    80006f66:	0f67a783          	lw	a5,246(a5) # 80028058 <nsizes>
    80006f6a:	37fd                	addiw	a5,a5,-1
    80006f6c:	4641                	li	a2,16
    80006f6e:	00f61633          	sll	a2,a2,a5
    80006f72:	85a6                	mv	a1,s1
    80006f74:	00002517          	auipc	a0,0x2
    80006f78:	cec50513          	addi	a0,a0,-788 # 80008c60 <userret+0xbd0>
    80006f7c:	ffff9097          	auipc	ra,0xffff9
    80006f80:	648080e7          	jalr	1608(ra) # 800005c4 <printf>
  bd_mark(bd_base, p);
    80006f84:	85ca                	mv	a1,s2
    80006f86:	0009b503          	ld	a0,0(s3)
    80006f8a:	00000097          	auipc	ra,0x0
    80006f8e:	d60080e7          	jalr	-672(ra) # 80006cea <bd_mark>
  return meta;
}
    80006f92:	8526                	mv	a0,s1
    80006f94:	70a2                	ld	ra,40(sp)
    80006f96:	7402                	ld	s0,32(sp)
    80006f98:	64e2                	ld	s1,24(sp)
    80006f9a:	6942                	ld	s2,16(sp)
    80006f9c:	69a2                	ld	s3,8(sp)
    80006f9e:	6145                	addi	sp,sp,48
    80006fa0:	8082                	ret

0000000080006fa2 <bd_mark_unavailable>:

// Mark the range [end, HEAPSIZE) as allocated
int
bd_mark_unavailable(void *end, void *left) {
    80006fa2:	1101                	addi	sp,sp,-32
    80006fa4:	ec06                	sd	ra,24(sp)
    80006fa6:	e822                	sd	s0,16(sp)
    80006fa8:	e426                	sd	s1,8(sp)
    80006faa:	1000                	addi	s0,sp,32
  int unavailable = BLK_SIZE(MAXSIZE)-(end-bd_base);
    80006fac:	00021717          	auipc	a4,0x21
    80006fb0:	0ac72703          	lw	a4,172(a4) # 80028058 <nsizes>
    80006fb4:	377d                	addiw	a4,a4,-1
    80006fb6:	47c1                	li	a5,16
    80006fb8:	00e797b3          	sll	a5,a5,a4
    80006fbc:	00021717          	auipc	a4,0x21
    80006fc0:	08c73703          	ld	a4,140(a4) # 80028048 <bd_base>
    80006fc4:	8d19                	sub	a0,a0,a4
    80006fc6:	9f89                	subw	a5,a5,a0
    80006fc8:	84be                	mv	s1,a5
  if(unavailable > 0)
    80006fca:	00f05c63          	blez	a5,80006fe2 <bd_mark_unavailable+0x40>
    unavailable = ROUNDUP(unavailable, LEAF_SIZE);
    80006fce:	37fd                	addiw	a5,a5,-1
    80006fd0:	41f7d49b          	sraiw	s1,a5,0x1f
    80006fd4:	01c4d49b          	srliw	s1,s1,0x1c
    80006fd8:	9cbd                	addw	s1,s1,a5
    80006fda:	4044d49b          	sraiw	s1,s1,0x4
    80006fde:	0492                	slli	s1,s1,0x4
    80006fe0:	24c1                	addiw	s1,s1,16
  printf("bd: 0x%x bytes unavailable\n", unavailable);
    80006fe2:	85a6                	mv	a1,s1
    80006fe4:	00002517          	auipc	a0,0x2
    80006fe8:	cb450513          	addi	a0,a0,-844 # 80008c98 <userret+0xc08>
    80006fec:	ffff9097          	auipc	ra,0xffff9
    80006ff0:	5d8080e7          	jalr	1496(ra) # 800005c4 <printf>

  void *bd_end = bd_base+BLK_SIZE(MAXSIZE)-unavailable;
    80006ff4:	00021717          	auipc	a4,0x21
    80006ff8:	05473703          	ld	a4,84(a4) # 80028048 <bd_base>
    80006ffc:	00021797          	auipc	a5,0x21
    80007000:	05c7a783          	lw	a5,92(a5) # 80028058 <nsizes>
    80007004:	37fd                	addiw	a5,a5,-1
    80007006:	45c1                	li	a1,16
    80007008:	00f595b3          	sll	a1,a1,a5
    8000700c:	40958533          	sub	a0,a1,s1
  bd_mark(bd_end, bd_base+BLK_SIZE(MAXSIZE));
    80007010:	95ba                	add	a1,a1,a4
    80007012:	953a                	add	a0,a0,a4
    80007014:	00000097          	auipc	ra,0x0
    80007018:	cd6080e7          	jalr	-810(ra) # 80006cea <bd_mark>
  return unavailable;
}
    8000701c:	8526                	mv	a0,s1
    8000701e:	60e2                	ld	ra,24(sp)
    80007020:	6442                	ld	s0,16(sp)
    80007022:	64a2                	ld	s1,8(sp)
    80007024:	6105                	addi	sp,sp,32
    80007026:	8082                	ret

0000000080007028 <bd_init>:

// Initialize the buddy allocator: it manages memory from [base, end).
void
bd_init(void *base, void *end) {
    80007028:	715d                	addi	sp,sp,-80
    8000702a:	e486                	sd	ra,72(sp)
    8000702c:	e0a2                	sd	s0,64(sp)
    8000702e:	fc26                	sd	s1,56(sp)
    80007030:	f84a                	sd	s2,48(sp)
    80007032:	f44e                	sd	s3,40(sp)
    80007034:	f052                	sd	s4,32(sp)
    80007036:	ec56                	sd	s5,24(sp)
    80007038:	e45e                	sd	s7,8(sp)
    8000703a:	0880                	addi	s0,sp,80
    8000703c:	8bae                	mv	s7,a1
  char *p = (char *) ROUNDUP((uint64)base, LEAF_SIZE);
    8000703e:	fff50913          	addi	s2,a0,-1
    80007042:	00495913          	srli	s2,s2,0x4
    80007046:	0912                	slli	s2,s2,0x4
    80007048:	0941                	addi	s2,s2,16
  int sz;

  initlock(&lock, "buddy");
    8000704a:	00002597          	auipc	a1,0x2
    8000704e:	c6e58593          	addi	a1,a1,-914 # 80008cb8 <userret+0xc28>
    80007052:	00021517          	auipc	a0,0x21
    80007056:	fae50513          	addi	a0,a0,-82 # 80028000 <lock>
    8000705a:	ffffa097          	auipc	ra,0xffffa
    8000705e:	9d6080e7          	jalr	-1578(ra) # 80000a30 <initlock>
  bd_base = (void *) p;

  // compute the number of sizes we need to manage [base, end)
  nsizes = log2(((char *)end-p)/LEAF_SIZE) + 1;
    80007062:	412b84b3          	sub	s1,s7,s2
    80007066:	43f4d513          	srai	a0,s1,0x3f
    8000706a:	893d                	andi	a0,a0,15
    8000706c:	9526                	add	a0,a0,s1
    8000706e:	8511                	srai	a0,a0,0x4
    80007070:	00000097          	auipc	ra,0x0
    80007074:	c54080e7          	jalr	-940(ra) # 80006cc4 <log2>
  if((char*)end-p > BLK_SIZE(MAXSIZE)) {
    80007078:	47c1                	li	a5,16
    8000707a:	00a797b3          	sll	a5,a5,a0
    8000707e:	1a97c963          	blt	a5,s1,80007230 <bd_init+0x208>
  nsizes = log2(((char *)end-p)/LEAF_SIZE) + 1;
    80007082:	0015061b          	addiw	a2,a0,1
  bd_base = (void *) p;
    80007086:	00021797          	auipc	a5,0x21
    8000708a:	fd27b123          	sd	s2,-62(a5) # 80028048 <bd_base>
  nsizes = log2(((char *)end-p)/LEAF_SIZE) + 1;
    8000708e:	00021997          	auipc	s3,0x21
    80007092:	fca98993          	addi	s3,s3,-54 # 80028058 <nsizes>
    80007096:	00c9a023          	sw	a2,0(s3)
    nsizes++;  // round up to the next power of 2
  }

  printf("bd: memory sz is %d bytes; allocate an size array of length %d\n",
    8000709a:	85a6                	mv	a1,s1
    8000709c:	00002517          	auipc	a0,0x2
    800070a0:	c2450513          	addi	a0,a0,-988 # 80008cc0 <userret+0xc30>
    800070a4:	ffff9097          	auipc	ra,0xffff9
    800070a8:	520080e7          	jalr	1312(ra) # 800005c4 <printf>
         (char*) end - p, nsizes);

  // allocate bd_sizes array
  bd_sizes = (Sz_info *) p;
    800070ac:	00021797          	auipc	a5,0x21
    800070b0:	fb27b223          	sd	s2,-92(a5) # 80028050 <bd_sizes>
  p += sizeof(Sz_info) * nsizes;
    800070b4:	0009a603          	lw	a2,0(s3)
    800070b8:	00561493          	slli	s1,a2,0x5
    800070bc:	94ca                	add	s1,s1,s2
  memset(bd_sizes, 0, sizeof(Sz_info) * nsizes);
    800070be:	0056161b          	slliw	a2,a2,0x5
    800070c2:	4581                	li	a1,0
    800070c4:	854a                	mv	a0,s2
    800070c6:	ffffa097          	auipc	ra,0xffffa
    800070ca:	cf8080e7          	jalr	-776(ra) # 80000dbe <memset>

  // initialize free list and allocate the alloc array for each size k
  for (int k = 0; k < nsizes; k++) {
    800070ce:	0009a783          	lw	a5,0(s3)
    800070d2:	0ef05463          	blez	a5,800071ba <bd_init+0x192>
    800070d6:	e85a                	sd	s6,16(sp)
    800070d8:	e062                	sd	s8,0(sp)
    800070da:	4981                	li	s3,0
    lst_init(&bd_sizes[k].free);
    800070dc:	00021a97          	auipc	s5,0x21
    800070e0:	f74a8a93          	addi	s5,s5,-140 # 80028050 <bd_sizes>
    sz = sizeof(char)* ROUNDUP(NBLK(k), 8)/8;
    800070e4:	00021a17          	auipc	s4,0x21
    800070e8:	f74a0a13          	addi	s4,s4,-140 # 80028058 <nsizes>
    800070ec:	4b05                	li	s6,1
    lst_init(&bd_sizes[k].free);
    800070ee:	00599c13          	slli	s8,s3,0x5
    800070f2:	000ab503          	ld	a0,0(s5)
    800070f6:	9562                	add	a0,a0,s8
    800070f8:	00000097          	auipc	ra,0x0
    800070fc:	16a080e7          	jalr	362(ra) # 80007262 <lst_init>
    sz = sizeof(char)* ROUNDUP(NBLK(k), 8)/8;
    80007100:	000a2783          	lw	a5,0(s4)
    80007104:	37fd                	addiw	a5,a5,-1
    80007106:	413787bb          	subw	a5,a5,s3
    8000710a:	00fb17bb          	sllw	a5,s6,a5
    8000710e:	37fd                	addiw	a5,a5,-1
    80007110:	41f7d91b          	sraiw	s2,a5,0x1f
    80007114:	01d9591b          	srliw	s2,s2,0x1d
    80007118:	00f9093b          	addw	s2,s2,a5
    8000711c:	4039591b          	sraiw	s2,s2,0x3
    80007120:	090e                	slli	s2,s2,0x3
    80007122:	2921                	addiw	s2,s2,8
    bd_sizes[k].alloc = p;
    80007124:	000ab783          	ld	a5,0(s5)
    80007128:	97e2                	add	a5,a5,s8
    8000712a:	eb84                	sd	s1,16(a5)
    memset(bd_sizes[k].alloc, 0, sz);
    8000712c:	40395913          	srai	s2,s2,0x3
    80007130:	864a                	mv	a2,s2
    80007132:	4581                	li	a1,0
    80007134:	8526                	mv	a0,s1
    80007136:	ffffa097          	auipc	ra,0xffffa
    8000713a:	c88080e7          	jalr	-888(ra) # 80000dbe <memset>
    p += sz;
    8000713e:	94ca                	add	s1,s1,s2
  for (int k = 0; k < nsizes; k++) {
    80007140:	000a2783          	lw	a5,0(s4)
    80007144:	0985                	addi	s3,s3,1
    80007146:	0009871b          	sext.w	a4,s3
    8000714a:	faf742e3          	blt	a4,a5,800070ee <bd_init+0xc6>
  }

  // allocate the split array for each size k, except for k = 0, since
  // we will not split blocks of size k = 0, the smallest size.
  for (int k = 1; k < nsizes; k++) {
    8000714e:	4705                	li	a4,1
    80007150:	0ef75363          	bge	a4,a5,80007236 <bd_init+0x20e>
    80007154:	02000993          	li	s3,32
    80007158:	893a                	mv	s2,a4
    sz = sizeof(char)* (ROUNDUP(NBLK(k), 8))/8;
    8000715a:	4b05                	li	s6,1
    bd_sizes[k].split = p;
    8000715c:	00021a97          	auipc	s5,0x21
    80007160:	ef4a8a93          	addi	s5,s5,-268 # 80028050 <bd_sizes>
  for (int k = 1; k < nsizes; k++) {
    80007164:	00021a17          	auipc	s4,0x21
    80007168:	ef4a0a13          	addi	s4,s4,-268 # 80028058 <nsizes>
    sz = sizeof(char)* (ROUNDUP(NBLK(k), 8))/8;
    8000716c:	37fd                	addiw	a5,a5,-1
    8000716e:	412787bb          	subw	a5,a5,s2
    80007172:	00fb17bb          	sllw	a5,s6,a5
    80007176:	37fd                	addiw	a5,a5,-1
    80007178:	41f7dc1b          	sraiw	s8,a5,0x1f
    8000717c:	01dc5c1b          	srliw	s8,s8,0x1d
    80007180:	00fc0c3b          	addw	s8,s8,a5
    80007184:	403c5c1b          	sraiw	s8,s8,0x3
    80007188:	0c0e                	slli	s8,s8,0x3
    8000718a:	2c21                	addiw	s8,s8,8
    bd_sizes[k].split = p;
    8000718c:	000ab783          	ld	a5,0(s5)
    80007190:	97ce                	add	a5,a5,s3
    80007192:	ef84                	sd	s1,24(a5)
    memset(bd_sizes[k].split, 0, sz);
    80007194:	403c5c13          	srai	s8,s8,0x3
    80007198:	8662                	mv	a2,s8
    8000719a:	4581                	li	a1,0
    8000719c:	8526                	mv	a0,s1
    8000719e:	ffffa097          	auipc	ra,0xffffa
    800071a2:	c20080e7          	jalr	-992(ra) # 80000dbe <memset>
    p += sz;
    800071a6:	94e2                	add	s1,s1,s8
  for (int k = 1; k < nsizes; k++) {
    800071a8:	2905                	addiw	s2,s2,1
    800071aa:	000a2783          	lw	a5,0(s4)
    800071ae:	02098993          	addi	s3,s3,32
    800071b2:	faf94de3          	blt	s2,a5,8000716c <bd_init+0x144>
    800071b6:	6b42                	ld	s6,16(sp)
    800071b8:	6c02                	ld	s8,0(sp)
  }
  p = (char *) ROUNDUP((uint64) p, LEAF_SIZE);
    800071ba:	14fd                	addi	s1,s1,-1
    800071bc:	8091                	srli	s1,s1,0x4
    800071be:	0492                	slli	s1,s1,0x4
    800071c0:	04c1                	addi	s1,s1,16

  // done allocating; mark the memory range [base, p) as allocated, so
  // that buddy will not hand out that memory.
  int meta = bd_mark_data_structures(p);
    800071c2:	8526                	mv	a0,s1
    800071c4:	00000097          	auipc	ra,0x0
    800071c8:	d7e080e7          	jalr	-642(ra) # 80006f42 <bd_mark_data_structures>
    800071cc:	8a2a                	mv	s4,a0
  
  // mark the unavailable memory range [end, HEAP_SIZE) as allocated,
  // so that buddy will not hand out that memory.
  int unavailable = bd_mark_unavailable(end, p);
    800071ce:	85a6                	mv	a1,s1
    800071d0:	855e                	mv	a0,s7
    800071d2:	00000097          	auipc	ra,0x0
    800071d6:	dd0080e7          	jalr	-560(ra) # 80006fa2 <bd_mark_unavailable>
    800071da:	89aa                	mv	s3,a0
  void *bd_end = bd_base+BLK_SIZE(MAXSIZE)-unavailable;
    800071dc:	00021a97          	auipc	s5,0x21
    800071e0:	e7ca8a93          	addi	s5,s5,-388 # 80028058 <nsizes>
    800071e4:	000aa783          	lw	a5,0(s5)
    800071e8:	37fd                	addiw	a5,a5,-1
    800071ea:	4941                	li	s2,16
    800071ec:	00f917b3          	sll	a5,s2,a5
    800071f0:	8f89                	sub	a5,a5,a0
  
  // initialize free lists for each size k
  int free = bd_initfree(p, bd_end);
    800071f2:	00021597          	auipc	a1,0x21
    800071f6:	e565b583          	ld	a1,-426(a1) # 80028048 <bd_base>
    800071fa:	95be                	add	a1,a1,a5
    800071fc:	8526                	mv	a0,s1
    800071fe:	00000097          	auipc	ra,0x0
    80007202:	c88080e7          	jalr	-888(ra) # 80006e86 <bd_initfree>

  // check if the amount that is free is what we expect
  if(free != BLK_SIZE(MAXSIZE)-meta-unavailable) {
    80007206:	000aa783          	lw	a5,0(s5)
    8000720a:	37fd                	addiw	a5,a5,-1
    8000720c:	00f91633          	sll	a2,s2,a5
    80007210:	41460633          	sub	a2,a2,s4
    80007214:	41360633          	sub	a2,a2,s3
    80007218:	02c51263          	bne	a0,a2,8000723c <bd_init+0x214>
    printf("free %d %d\n", free, BLK_SIZE(MAXSIZE)-meta-unavailable);
    panic("bd_init: free mem");
  }
}
    8000721c:	60a6                	ld	ra,72(sp)
    8000721e:	6406                	ld	s0,64(sp)
    80007220:	74e2                	ld	s1,56(sp)
    80007222:	7942                	ld	s2,48(sp)
    80007224:	79a2                	ld	s3,40(sp)
    80007226:	7a02                	ld	s4,32(sp)
    80007228:	6ae2                	ld	s5,24(sp)
    8000722a:	6ba2                	ld	s7,8(sp)
    8000722c:	6161                	addi	sp,sp,80
    8000722e:	8082                	ret
    nsizes++;  // round up to the next power of 2
    80007230:	0025061b          	addiw	a2,a0,2
    80007234:	bd89                	j	80007086 <bd_init+0x5e>
    80007236:	6b42                	ld	s6,16(sp)
    80007238:	6c02                	ld	s8,0(sp)
    8000723a:	b741                	j	800071ba <bd_init+0x192>
    8000723c:	e85a                	sd	s6,16(sp)
    8000723e:	e062                	sd	s8,0(sp)
    printf("free %d %d\n", free, BLK_SIZE(MAXSIZE)-meta-unavailable);
    80007240:	85aa                	mv	a1,a0
    80007242:	00002517          	auipc	a0,0x2
    80007246:	abe50513          	addi	a0,a0,-1346 # 80008d00 <userret+0xc70>
    8000724a:	ffff9097          	auipc	ra,0xffff9
    8000724e:	37a080e7          	jalr	890(ra) # 800005c4 <printf>
    panic("bd_init: free mem");
    80007252:	00002517          	auipc	a0,0x2
    80007256:	abe50513          	addi	a0,a0,-1346 # 80008d10 <userret+0xc80>
    8000725a:	ffff9097          	auipc	ra,0xffff9
    8000725e:	310080e7          	jalr	784(ra) # 8000056a <panic>

0000000080007262 <lst_init>:
// fast. circular simplifies code, because don't have to check for
// empty list in insert and remove.

void
lst_init(struct list *lst)
{
    80007262:	1141                	addi	sp,sp,-16
    80007264:	e406                	sd	ra,8(sp)
    80007266:	e022                	sd	s0,0(sp)
    80007268:	0800                	addi	s0,sp,16
  lst->next = lst;
    8000726a:	e108                	sd	a0,0(a0)
  lst->prev = lst;
    8000726c:	e508                	sd	a0,8(a0)
}
    8000726e:	60a2                	ld	ra,8(sp)
    80007270:	6402                	ld	s0,0(sp)
    80007272:	0141                	addi	sp,sp,16
    80007274:	8082                	ret

0000000080007276 <lst_empty>:

int
lst_empty(struct list *lst) {
    80007276:	1141                	addi	sp,sp,-16
    80007278:	e406                	sd	ra,8(sp)
    8000727a:	e022                	sd	s0,0(sp)
    8000727c:	0800                	addi	s0,sp,16
  return lst->next == lst;
    8000727e:	611c                	ld	a5,0(a0)
    80007280:	40a78533          	sub	a0,a5,a0
}
    80007284:	00153513          	seqz	a0,a0
    80007288:	60a2                	ld	ra,8(sp)
    8000728a:	6402                	ld	s0,0(sp)
    8000728c:	0141                	addi	sp,sp,16
    8000728e:	8082                	ret

0000000080007290 <lst_remove>:

void
lst_remove(struct list *e) {
    80007290:	1141                	addi	sp,sp,-16
    80007292:	e406                	sd	ra,8(sp)
    80007294:	e022                	sd	s0,0(sp)
    80007296:	0800                	addi	s0,sp,16
  e->prev->next = e->next;
    80007298:	6518                	ld	a4,8(a0)
    8000729a:	611c                	ld	a5,0(a0)
    8000729c:	e31c                	sd	a5,0(a4)
  e->next->prev = e->prev;
    8000729e:	6518                	ld	a4,8(a0)
    800072a0:	e798                	sd	a4,8(a5)
}
    800072a2:	60a2                	ld	ra,8(sp)
    800072a4:	6402                	ld	s0,0(sp)
    800072a6:	0141                	addi	sp,sp,16
    800072a8:	8082                	ret

00000000800072aa <lst_pop>:

void*
lst_pop(struct list *lst) {
    800072aa:	1101                	addi	sp,sp,-32
    800072ac:	ec06                	sd	ra,24(sp)
    800072ae:	e822                	sd	s0,16(sp)
    800072b0:	e426                	sd	s1,8(sp)
    800072b2:	1000                	addi	s0,sp,32
  if(lst->next == lst)
    800072b4:	6104                	ld	s1,0(a0)
    800072b6:	00a48d63          	beq	s1,a0,800072d0 <lst_pop+0x26>
    panic("lst_pop");
  struct list *p = lst->next;
  lst_remove(p);
    800072ba:	8526                	mv	a0,s1
    800072bc:	00000097          	auipc	ra,0x0
    800072c0:	fd4080e7          	jalr	-44(ra) # 80007290 <lst_remove>
  return (void *)p;
}
    800072c4:	8526                	mv	a0,s1
    800072c6:	60e2                	ld	ra,24(sp)
    800072c8:	6442                	ld	s0,16(sp)
    800072ca:	64a2                	ld	s1,8(sp)
    800072cc:	6105                	addi	sp,sp,32
    800072ce:	8082                	ret
    panic("lst_pop");
    800072d0:	00002517          	auipc	a0,0x2
    800072d4:	a5850513          	addi	a0,a0,-1448 # 80008d28 <userret+0xc98>
    800072d8:	ffff9097          	auipc	ra,0xffff9
    800072dc:	292080e7          	jalr	658(ra) # 8000056a <panic>

00000000800072e0 <lst_push>:

void
lst_push(struct list *lst, void *p)
{
    800072e0:	1141                	addi	sp,sp,-16
    800072e2:	e406                	sd	ra,8(sp)
    800072e4:	e022                	sd	s0,0(sp)
    800072e6:	0800                	addi	s0,sp,16
  struct list *e = (struct list *) p;
  e->next = lst->next;
    800072e8:	611c                	ld	a5,0(a0)
    800072ea:	e19c                	sd	a5,0(a1)
  e->prev = lst;
    800072ec:	e588                	sd	a0,8(a1)
  lst->next->prev = p;
    800072ee:	611c                	ld	a5,0(a0)
    800072f0:	e78c                	sd	a1,8(a5)
  lst->next = e;
    800072f2:	e10c                	sd	a1,0(a0)
}
    800072f4:	60a2                	ld	ra,8(sp)
    800072f6:	6402                	ld	s0,0(sp)
    800072f8:	0141                	addi	sp,sp,16
    800072fa:	8082                	ret

00000000800072fc <lst_print>:

void
lst_print(struct list *lst)
{
    800072fc:	7179                	addi	sp,sp,-48
    800072fe:	f406                	sd	ra,40(sp)
    80007300:	f022                	sd	s0,32(sp)
    80007302:	ec26                	sd	s1,24(sp)
    80007304:	1800                	addi	s0,sp,48
  for (struct list *p = lst->next; p != lst; p = p->next) {
    80007306:	6104                	ld	s1,0(a0)
    80007308:	02950463          	beq	a0,s1,80007330 <lst_print+0x34>
    8000730c:	e84a                	sd	s2,16(sp)
    8000730e:	e44e                	sd	s3,8(sp)
    80007310:	892a                	mv	s2,a0
    printf(" %p", p);
    80007312:	00002997          	auipc	s3,0x2
    80007316:	a1e98993          	addi	s3,s3,-1506 # 80008d30 <userret+0xca0>
    8000731a:	85a6                	mv	a1,s1
    8000731c:	854e                	mv	a0,s3
    8000731e:	ffff9097          	auipc	ra,0xffff9
    80007322:	2a6080e7          	jalr	678(ra) # 800005c4 <printf>
  for (struct list *p = lst->next; p != lst; p = p->next) {
    80007326:	6084                	ld	s1,0(s1)
    80007328:	fe9919e3          	bne	s2,s1,8000731a <lst_print+0x1e>
    8000732c:	6942                	ld	s2,16(sp)
    8000732e:	69a2                	ld	s3,8(sp)
  }
  printf("\n");
    80007330:	00001517          	auipc	a0,0x1
    80007334:	df850513          	addi	a0,a0,-520 # 80008128 <userret+0x98>
    80007338:	ffff9097          	auipc	ra,0xffff9
    8000733c:	28c080e7          	jalr	652(ra) # 800005c4 <printf>
}
    80007340:	70a2                	ld	ra,40(sp)
    80007342:	7402                	ld	s0,32(sp)
    80007344:	64e2                	ld	s1,24(sp)
    80007346:	6145                	addi	sp,sp,48
    80007348:	8082                	ret
	...

0000000080008000 <trampoline>:
    80008000:	14051573          	csrrw	a0,sscratch,a0
    80008004:	02153423          	sd	ra,40(a0)
    80008008:	02253823          	sd	sp,48(a0)
    8000800c:	02353c23          	sd	gp,56(a0)
    80008010:	04453023          	sd	tp,64(a0)
    80008014:	04553423          	sd	t0,72(a0)
    80008018:	04653823          	sd	t1,80(a0)
    8000801c:	04753c23          	sd	t2,88(a0)
    80008020:	f120                	sd	s0,96(a0)
    80008022:	f524                	sd	s1,104(a0)
    80008024:	fd2c                	sd	a1,120(a0)
    80008026:	e150                	sd	a2,128(a0)
    80008028:	e554                	sd	a3,136(a0)
    8000802a:	e958                	sd	a4,144(a0)
    8000802c:	ed5c                	sd	a5,152(a0)
    8000802e:	0b053023          	sd	a6,160(a0)
    80008032:	0b153423          	sd	a7,168(a0)
    80008036:	0b253823          	sd	s2,176(a0)
    8000803a:	0b353c23          	sd	s3,184(a0)
    8000803e:	0d453023          	sd	s4,192(a0)
    80008042:	0d553423          	sd	s5,200(a0)
    80008046:	0d653823          	sd	s6,208(a0)
    8000804a:	0d753c23          	sd	s7,216(a0)
    8000804e:	0f853023          	sd	s8,224(a0)
    80008052:	0f953423          	sd	s9,232(a0)
    80008056:	0fa53823          	sd	s10,240(a0)
    8000805a:	0fb53c23          	sd	s11,248(a0)
    8000805e:	11c53023          	sd	t3,256(a0)
    80008062:	11d53423          	sd	t4,264(a0)
    80008066:	11e53823          	sd	t5,272(a0)
    8000806a:	11f53c23          	sd	t6,280(a0)
    8000806e:	140022f3          	csrr	t0,sscratch
    80008072:	06553823          	sd	t0,112(a0)
    80008076:	00853103          	ld	sp,8(a0)
    8000807a:	02053203          	ld	tp,32(a0)
    8000807e:	01053283          	ld	t0,16(a0)
    80008082:	00053303          	ld	t1,0(a0)
    80008086:	18031073          	csrw	satp,t1
    8000808a:	12000073          	sfence.vma
    8000808e:	8282                	jr	t0

0000000080008090 <userret>:
    80008090:	18059073          	csrw	satp,a1
    80008094:	12000073          	sfence.vma
    80008098:	07053283          	ld	t0,112(a0)
    8000809c:	14029073          	csrw	sscratch,t0
    800080a0:	02853083          	ld	ra,40(a0)
    800080a4:	03053103          	ld	sp,48(a0)
    800080a8:	03853183          	ld	gp,56(a0)
    800080ac:	04053203          	ld	tp,64(a0)
    800080b0:	04853283          	ld	t0,72(a0)
    800080b4:	05053303          	ld	t1,80(a0)
    800080b8:	05853383          	ld	t2,88(a0)
    800080bc:	7120                	ld	s0,96(a0)
    800080be:	7524                	ld	s1,104(a0)
    800080c0:	7d2c                	ld	a1,120(a0)
    800080c2:	6150                	ld	a2,128(a0)
    800080c4:	6554                	ld	a3,136(a0)
    800080c6:	6958                	ld	a4,144(a0)
    800080c8:	6d5c                	ld	a5,152(a0)
    800080ca:	0a053803          	ld	a6,160(a0)
    800080ce:	0a853883          	ld	a7,168(a0)
    800080d2:	0b053903          	ld	s2,176(a0)
    800080d6:	0b853983          	ld	s3,184(a0)
    800080da:	0c053a03          	ld	s4,192(a0)
    800080de:	0c853a83          	ld	s5,200(a0)
    800080e2:	0d053b03          	ld	s6,208(a0)
    800080e6:	0d853b83          	ld	s7,216(a0)
    800080ea:	0e053c03          	ld	s8,224(a0)
    800080ee:	0e853c83          	ld	s9,232(a0)
    800080f2:	0f053d03          	ld	s10,240(a0)
    800080f6:	0f853d83          	ld	s11,248(a0)
    800080fa:	10053e03          	ld	t3,256(a0)
    800080fe:	10853e83          	ld	t4,264(a0)
    80008102:	11053f03          	ld	t5,272(a0)
    80008106:	11853f83          	ld	t6,280(a0)
    8000810a:	14051573          	csrrw	a0,sscratch,a0
    8000810e:	10200073          	sret
