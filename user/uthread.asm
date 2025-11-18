
user/_uthread：     文件格式 elf64-littleriscv


Disassembly of section .text:

0000000000000000 <thread_init>:
struct thread *current_thread;
extern void thread_switch(uint64, uint64);
              
void 
thread_init(void)
{
   0:	1141                	addi	sp,sp,-16
   2:	e406                	sd	ra,8(sp)
   4:	e022                	sd	s0,0(sp)
   6:	0800                	addi	s0,sp,16
  // main() is thread 0, which will make the first invocation to
  // thread_schedule().  it needs a stack so that the first thread_switch() can
  // save thread 0's state.  thread_schedule() won't run the main thread ever
  // again, because its state is set to RUNNING, and thread_schedule() selects
  // a RUNNABLE thread.
  current_thread = &all_thread[0];
   8:	00001797          	auipc	a5,0x1
   c:	d4078793          	addi	a5,a5,-704 # d48 <all_thread>
  10:	00001717          	auipc	a4,0x1
  14:	d2f73423          	sd	a5,-728(a4) # d38 <current_thread>
  current_thread->state = RUNNING;
  18:	4785                	li	a5,1
  1a:	00003717          	auipc	a4,0x3
  1e:	d2f72723          	sw	a5,-722(a4) # 2d48 <__global_pointer$+0x182f>
}
  22:	60a2                	ld	ra,8(sp)
  24:	6402                	ld	s0,0(sp)
  26:	0141                	addi	sp,sp,16
  28:	8082                	ret

000000000000002a <thread_schedule>:
{
  struct thread *t, *next_thread;

  /* Find another runnable thread. */
  next_thread = 0;
  t = current_thread + 1;
  2a:	00001897          	auipc	a7,0x1
  2e:	d0e8b883          	ld	a7,-754(a7) # d38 <current_thread>
  32:	6789                	lui	a5,0x2
  34:	0791                	addi	a5,a5,4 # 2004 <__global_pointer$+0xaeb>
  36:	97c6                	add	a5,a5,a7
  38:	4711                	li	a4,4
  for(int i = 0; i < MAX_THREAD; i++){
    if(t >= all_thread + MAX_THREAD)
  3a:	00009817          	auipc	a6,0x9
  3e:	d1e80813          	addi	a6,a6,-738 # 8d58 <base>
      t = all_thread;
    if(t->state == RUNNABLE) {
  42:	6509                	lui	a0,0x2
  44:	4589                	li	a1,2
      next_thread = t;
      break;
    }
    t = t + 1;
  46:	00e50633          	add	a2,a0,a4
  4a:	a809                	j	5c <thread_schedule+0x32>
    if(t->state == RUNNABLE) {
  4c:	00a786b3          	add	a3,a5,a0
  50:	4294                	lw	a3,0(a3)
  52:	02b68d63          	beq	a3,a1,8c <thread_schedule+0x62>
    t = t + 1;
  56:	97b2                	add	a5,a5,a2
  for(int i = 0; i < MAX_THREAD; i++){
  58:	377d                	addiw	a4,a4,-1
  5a:	cb01                	beqz	a4,6a <thread_schedule+0x40>
    if(t >= all_thread + MAX_THREAD)
  5c:	ff07e8e3          	bltu	a5,a6,4c <thread_schedule+0x22>
      t = all_thread;
  60:	00001797          	auipc	a5,0x1
  64:	ce878793          	addi	a5,a5,-792 # d48 <all_thread>
  68:	b7d5                	j	4c <thread_schedule+0x22>
{
  6a:	1141                	addi	sp,sp,-16
  6c:	e406                	sd	ra,8(sp)
  6e:	e022                	sd	s0,0(sp)
  70:	0800                	addi	s0,sp,16
  }

  if (next_thread == 0) {
    printf("thread_schedule: no runnable threads\n");
  72:	00001517          	auipc	a0,0x1
  76:	b3650513          	addi	a0,a0,-1226 # ba8 <malloc+0xfa>
  7a:	00001097          	auipc	ra,0x1
  7e:	978080e7          	jalr	-1672(ra) # 9f2 <printf>
    exit(-1);
  82:	557d                	li	a0,-1
  84:	00000097          	auipc	ra,0x0
  88:	600080e7          	jalr	1536(ra) # 684 <exit>
  }

  if (current_thread != next_thread) {         /* switch threads?  */
  8c:	00f88b63          	beq	a7,a5,a2 <thread_schedule+0x78>
    next_thread->state = RUNNING;
  90:	6709                	lui	a4,0x2
  92:	973e                	add	a4,a4,a5
  94:	4685                	li	a3,1
  96:	c314                	sw	a3,0(a4)
    t = current_thread;
    current_thread = next_thread;
  98:	00001717          	auipc	a4,0x1
  9c:	caf73023          	sd	a5,-864(a4) # d38 <current_thread>
     * Invoke thread_switch to switch from t to next_thread:
     * thread_switch(??, ??);
     */
  } else
    next_thread = 0;
}
  a0:	8082                	ret
  a2:	8082                	ret

00000000000000a4 <thread_create>:

void 
thread_create(void (*func)())
{
  a4:	1141                	addi	sp,sp,-16
  a6:	e406                	sd	ra,8(sp)
  a8:	e022                	sd	s0,0(sp)
  aa:	0800                	addi	s0,sp,16
  struct thread *t;

  for (t = all_thread; t < all_thread + MAX_THREAD; t++) {
  ac:	00003797          	auipc	a5,0x3
  b0:	ca078793          	addi	a5,a5,-864 # 2d4c <__global_pointer$+0x1833>
  b4:	0000b597          	auipc	a1,0xb
  b8:	ca858593          	addi	a1,a1,-856 # ad5c <__BSS_END__+0x1ff4>
  bc:	6609                	lui	a2,0x2
  be:	0611                	addi	a2,a2,4 # 2004 <__global_pointer$+0xaeb>
    if (t->state == FREE) break;
  c0:	873e                	mv	a4,a5
  c2:	ffc7a683          	lw	a3,-4(a5)
  c6:	ce81                	beqz	a3,de <thread_create+0x3a>
  for (t = all_thread; t < all_thread + MAX_THREAD; t++) {
  c8:	97b2                	add	a5,a5,a2
  ca:	feb79be3          	bne	a5,a1,c0 <thread_create+0x1c>
  }
  t->state = RUNNABLE;
  ce:	6789                	lui	a5,0x2
  d0:	973e                	add	a4,a4,a5
  d2:	4789                	li	a5,2
  d4:	c31c                	sw	a5,0(a4)
  // YOUR CODE HERE
}
  d6:	60a2                	ld	ra,8(sp)
  d8:	6402                	ld	s0,0(sp)
  da:	0141                	addi	sp,sp,16
  dc:	8082                	ret
  de:	7779                	lui	a4,0xffffe
  e0:	1771                	addi	a4,a4,-4 # ffffffffffffdffc <__BSS_END__+0xffffffffffff5294>
  e2:	973e                	add	a4,a4,a5
  e4:	b7ed                	j	ce <thread_create+0x2a>

00000000000000e6 <thread_yield>:

void 
thread_yield(void)
{
  e6:	1141                	addi	sp,sp,-16
  e8:	e406                	sd	ra,8(sp)
  ea:	e022                	sd	s0,0(sp)
  ec:	0800                	addi	s0,sp,16
  current_thread->state = RUNNABLE;
  ee:	00001797          	auipc	a5,0x1
  f2:	c4a7b783          	ld	a5,-950(a5) # d38 <current_thread>
  f6:	6709                	lui	a4,0x2
  f8:	97ba                	add	a5,a5,a4
  fa:	4709                	li	a4,2
  fc:	c398                	sw	a4,0(a5)
  thread_schedule();
  fe:	00000097          	auipc	ra,0x0
 102:	f2c080e7          	jalr	-212(ra) # 2a <thread_schedule>
}
 106:	60a2                	ld	ra,8(sp)
 108:	6402                	ld	s0,0(sp)
 10a:	0141                	addi	sp,sp,16
 10c:	8082                	ret

000000000000010e <thread_a>:
volatile int a_started, b_started, c_started;
volatile int a_n, b_n, c_n;

void 
thread_a(void)
{
 10e:	7179                	addi	sp,sp,-48
 110:	f406                	sd	ra,40(sp)
 112:	f022                	sd	s0,32(sp)
 114:	ec26                	sd	s1,24(sp)
 116:	e84a                	sd	s2,16(sp)
 118:	e44e                	sd	s3,8(sp)
 11a:	e052                	sd	s4,0(sp)
 11c:	1800                	addi	s0,sp,48
  int i;
  printf("thread_a started\n");
 11e:	00001517          	auipc	a0,0x1
 122:	ab250513          	addi	a0,a0,-1358 # bd0 <malloc+0x122>
 126:	00001097          	auipc	ra,0x1
 12a:	8cc080e7          	jalr	-1844(ra) # 9f2 <printf>
  a_started = 1;
 12e:	4785                	li	a5,1
 130:	00001717          	auipc	a4,0x1
 134:	c0f72223          	sw	a5,-1020(a4) # d34 <a_started>
  while(b_started == 0 || c_started == 0)
 138:	00001497          	auipc	s1,0x1
 13c:	bf848493          	addi	s1,s1,-1032 # d30 <b_started>
 140:	00001917          	auipc	s2,0x1
 144:	bec90913          	addi	s2,s2,-1044 # d2c <c_started>
 148:	a029                	j	152 <thread_a+0x44>
    thread_yield();
 14a:	00000097          	auipc	ra,0x0
 14e:	f9c080e7          	jalr	-100(ra) # e6 <thread_yield>
  while(b_started == 0 || c_started == 0)
 152:	409c                	lw	a5,0(s1)
 154:	2781                	sext.w	a5,a5
 156:	dbf5                	beqz	a5,14a <thread_a+0x3c>
 158:	00092783          	lw	a5,0(s2)
 15c:	2781                	sext.w	a5,a5
 15e:	d7f5                	beqz	a5,14a <thread_a+0x3c>
  
  for (i = 0; i < 100; i++) {
 160:	4481                	li	s1,0
    printf("thread_a %d\n", i);
 162:	00001a17          	auipc	s4,0x1
 166:	a86a0a13          	addi	s4,s4,-1402 # be8 <malloc+0x13a>
    a_n += 1;
 16a:	00001917          	auipc	s2,0x1
 16e:	bbe90913          	addi	s2,s2,-1090 # d28 <a_n>
  for (i = 0; i < 100; i++) {
 172:	06400993          	li	s3,100
    printf("thread_a %d\n", i);
 176:	85a6                	mv	a1,s1
 178:	8552                	mv	a0,s4
 17a:	00001097          	auipc	ra,0x1
 17e:	878080e7          	jalr	-1928(ra) # 9f2 <printf>
    a_n += 1;
 182:	00092783          	lw	a5,0(s2)
 186:	2785                	addiw	a5,a5,1
 188:	00f92023          	sw	a5,0(s2)
    thread_yield();
 18c:	00000097          	auipc	ra,0x0
 190:	f5a080e7          	jalr	-166(ra) # e6 <thread_yield>
  for (i = 0; i < 100; i++) {
 194:	2485                	addiw	s1,s1,1
 196:	ff3490e3          	bne	s1,s3,176 <thread_a+0x68>
  }
  printf("thread_a: exit after %d\n", a_n);
 19a:	00001597          	auipc	a1,0x1
 19e:	b8e5a583          	lw	a1,-1138(a1) # d28 <a_n>
 1a2:	00001517          	auipc	a0,0x1
 1a6:	a5650513          	addi	a0,a0,-1450 # bf8 <malloc+0x14a>
 1aa:	00001097          	auipc	ra,0x1
 1ae:	848080e7          	jalr	-1976(ra) # 9f2 <printf>

  current_thread->state = FREE;
 1b2:	00001797          	auipc	a5,0x1
 1b6:	b867b783          	ld	a5,-1146(a5) # d38 <current_thread>
 1ba:	6709                	lui	a4,0x2
 1bc:	97ba                	add	a5,a5,a4
 1be:	0007a023          	sw	zero,0(a5)
  thread_schedule();
 1c2:	00000097          	auipc	ra,0x0
 1c6:	e68080e7          	jalr	-408(ra) # 2a <thread_schedule>
}
 1ca:	70a2                	ld	ra,40(sp)
 1cc:	7402                	ld	s0,32(sp)
 1ce:	64e2                	ld	s1,24(sp)
 1d0:	6942                	ld	s2,16(sp)
 1d2:	69a2                	ld	s3,8(sp)
 1d4:	6a02                	ld	s4,0(sp)
 1d6:	6145                	addi	sp,sp,48
 1d8:	8082                	ret

00000000000001da <thread_b>:

void 
thread_b(void)
{
 1da:	7179                	addi	sp,sp,-48
 1dc:	f406                	sd	ra,40(sp)
 1de:	f022                	sd	s0,32(sp)
 1e0:	ec26                	sd	s1,24(sp)
 1e2:	e84a                	sd	s2,16(sp)
 1e4:	e44e                	sd	s3,8(sp)
 1e6:	e052                	sd	s4,0(sp)
 1e8:	1800                	addi	s0,sp,48
  int i;
  printf("thread_b started\n");
 1ea:	00001517          	auipc	a0,0x1
 1ee:	a2e50513          	addi	a0,a0,-1490 # c18 <malloc+0x16a>
 1f2:	00001097          	auipc	ra,0x1
 1f6:	800080e7          	jalr	-2048(ra) # 9f2 <printf>
  b_started = 1;
 1fa:	4785                	li	a5,1
 1fc:	00001717          	auipc	a4,0x1
 200:	b2f72a23          	sw	a5,-1228(a4) # d30 <b_started>
  while(a_started == 0 || c_started == 0)
 204:	00001497          	auipc	s1,0x1
 208:	b3048493          	addi	s1,s1,-1232 # d34 <a_started>
 20c:	00001917          	auipc	s2,0x1
 210:	b2090913          	addi	s2,s2,-1248 # d2c <c_started>
 214:	a029                	j	21e <thread_b+0x44>
    thread_yield();
 216:	00000097          	auipc	ra,0x0
 21a:	ed0080e7          	jalr	-304(ra) # e6 <thread_yield>
  while(a_started == 0 || c_started == 0)
 21e:	409c                	lw	a5,0(s1)
 220:	2781                	sext.w	a5,a5
 222:	dbf5                	beqz	a5,216 <thread_b+0x3c>
 224:	00092783          	lw	a5,0(s2)
 228:	2781                	sext.w	a5,a5
 22a:	d7f5                	beqz	a5,216 <thread_b+0x3c>
  
  for (i = 0; i < 100; i++) {
 22c:	4481                	li	s1,0
    printf("thread_b %d\n", i);
 22e:	00001a17          	auipc	s4,0x1
 232:	a02a0a13          	addi	s4,s4,-1534 # c30 <malloc+0x182>
    b_n += 1;
 236:	00001917          	auipc	s2,0x1
 23a:	aee90913          	addi	s2,s2,-1298 # d24 <b_n>
  for (i = 0; i < 100; i++) {
 23e:	06400993          	li	s3,100
    printf("thread_b %d\n", i);
 242:	85a6                	mv	a1,s1
 244:	8552                	mv	a0,s4
 246:	00000097          	auipc	ra,0x0
 24a:	7ac080e7          	jalr	1964(ra) # 9f2 <printf>
    b_n += 1;
 24e:	00092783          	lw	a5,0(s2)
 252:	2785                	addiw	a5,a5,1
 254:	00f92023          	sw	a5,0(s2)
    thread_yield();
 258:	00000097          	auipc	ra,0x0
 25c:	e8e080e7          	jalr	-370(ra) # e6 <thread_yield>
  for (i = 0; i < 100; i++) {
 260:	2485                	addiw	s1,s1,1
 262:	ff3490e3          	bne	s1,s3,242 <thread_b+0x68>
  }
  printf("thread_b: exit after %d\n", b_n);
 266:	00001597          	auipc	a1,0x1
 26a:	abe5a583          	lw	a1,-1346(a1) # d24 <b_n>
 26e:	00001517          	auipc	a0,0x1
 272:	9d250513          	addi	a0,a0,-1582 # c40 <malloc+0x192>
 276:	00000097          	auipc	ra,0x0
 27a:	77c080e7          	jalr	1916(ra) # 9f2 <printf>

  current_thread->state = FREE;
 27e:	00001797          	auipc	a5,0x1
 282:	aba7b783          	ld	a5,-1350(a5) # d38 <current_thread>
 286:	6709                	lui	a4,0x2
 288:	97ba                	add	a5,a5,a4
 28a:	0007a023          	sw	zero,0(a5)
  thread_schedule();
 28e:	00000097          	auipc	ra,0x0
 292:	d9c080e7          	jalr	-612(ra) # 2a <thread_schedule>
}
 296:	70a2                	ld	ra,40(sp)
 298:	7402                	ld	s0,32(sp)
 29a:	64e2                	ld	s1,24(sp)
 29c:	6942                	ld	s2,16(sp)
 29e:	69a2                	ld	s3,8(sp)
 2a0:	6a02                	ld	s4,0(sp)
 2a2:	6145                	addi	sp,sp,48
 2a4:	8082                	ret

00000000000002a6 <thread_c>:

void 
thread_c(void)
{
 2a6:	7179                	addi	sp,sp,-48
 2a8:	f406                	sd	ra,40(sp)
 2aa:	f022                	sd	s0,32(sp)
 2ac:	ec26                	sd	s1,24(sp)
 2ae:	e84a                	sd	s2,16(sp)
 2b0:	e44e                	sd	s3,8(sp)
 2b2:	e052                	sd	s4,0(sp)
 2b4:	1800                	addi	s0,sp,48
  int i;
  printf("thread_c started\n");
 2b6:	00001517          	auipc	a0,0x1
 2ba:	9aa50513          	addi	a0,a0,-1622 # c60 <malloc+0x1b2>
 2be:	00000097          	auipc	ra,0x0
 2c2:	734080e7          	jalr	1844(ra) # 9f2 <printf>
  c_started = 1;
 2c6:	4785                	li	a5,1
 2c8:	00001717          	auipc	a4,0x1
 2cc:	a6f72223          	sw	a5,-1436(a4) # d2c <c_started>
  while(a_started == 0 || b_started == 0)
 2d0:	00001497          	auipc	s1,0x1
 2d4:	a6448493          	addi	s1,s1,-1436 # d34 <a_started>
 2d8:	00001917          	auipc	s2,0x1
 2dc:	a5890913          	addi	s2,s2,-1448 # d30 <b_started>
 2e0:	a029                	j	2ea <thread_c+0x44>
    thread_yield();
 2e2:	00000097          	auipc	ra,0x0
 2e6:	e04080e7          	jalr	-508(ra) # e6 <thread_yield>
  while(a_started == 0 || b_started == 0)
 2ea:	409c                	lw	a5,0(s1)
 2ec:	2781                	sext.w	a5,a5
 2ee:	dbf5                	beqz	a5,2e2 <thread_c+0x3c>
 2f0:	00092783          	lw	a5,0(s2)
 2f4:	2781                	sext.w	a5,a5
 2f6:	d7f5                	beqz	a5,2e2 <thread_c+0x3c>
  
  for (i = 0; i < 100; i++) {
 2f8:	4481                	li	s1,0
    printf("thread_c %d\n", i);
 2fa:	00001a17          	auipc	s4,0x1
 2fe:	97ea0a13          	addi	s4,s4,-1666 # c78 <malloc+0x1ca>
    c_n += 1;
 302:	00001917          	auipc	s2,0x1
 306:	a1e90913          	addi	s2,s2,-1506 # d20 <c_n>
  for (i = 0; i < 100; i++) {
 30a:	06400993          	li	s3,100
    printf("thread_c %d\n", i);
 30e:	85a6                	mv	a1,s1
 310:	8552                	mv	a0,s4
 312:	00000097          	auipc	ra,0x0
 316:	6e0080e7          	jalr	1760(ra) # 9f2 <printf>
    c_n += 1;
 31a:	00092783          	lw	a5,0(s2)
 31e:	2785                	addiw	a5,a5,1
 320:	00f92023          	sw	a5,0(s2)
    thread_yield();
 324:	00000097          	auipc	ra,0x0
 328:	dc2080e7          	jalr	-574(ra) # e6 <thread_yield>
  for (i = 0; i < 100; i++) {
 32c:	2485                	addiw	s1,s1,1
 32e:	ff3490e3          	bne	s1,s3,30e <thread_c+0x68>
  }
  printf("thread_c: exit after %d\n", c_n);
 332:	00001597          	auipc	a1,0x1
 336:	9ee5a583          	lw	a1,-1554(a1) # d20 <c_n>
 33a:	00001517          	auipc	a0,0x1
 33e:	94e50513          	addi	a0,a0,-1714 # c88 <malloc+0x1da>
 342:	00000097          	auipc	ra,0x0
 346:	6b0080e7          	jalr	1712(ra) # 9f2 <printf>

  current_thread->state = FREE;
 34a:	00001797          	auipc	a5,0x1
 34e:	9ee7b783          	ld	a5,-1554(a5) # d38 <current_thread>
 352:	6709                	lui	a4,0x2
 354:	97ba                	add	a5,a5,a4
 356:	0007a023          	sw	zero,0(a5)
  thread_schedule();
 35a:	00000097          	auipc	ra,0x0
 35e:	cd0080e7          	jalr	-816(ra) # 2a <thread_schedule>
}
 362:	70a2                	ld	ra,40(sp)
 364:	7402                	ld	s0,32(sp)
 366:	64e2                	ld	s1,24(sp)
 368:	6942                	ld	s2,16(sp)
 36a:	69a2                	ld	s3,8(sp)
 36c:	6a02                	ld	s4,0(sp)
 36e:	6145                	addi	sp,sp,48
 370:	8082                	ret

0000000000000372 <main>:

int 
main(int argc, char *argv[]) 
{
 372:	1141                	addi	sp,sp,-16
 374:	e406                	sd	ra,8(sp)
 376:	e022                	sd	s0,0(sp)
 378:	0800                	addi	s0,sp,16
  a_started = b_started = c_started = 0;
 37a:	00001797          	auipc	a5,0x1
 37e:	9a07a923          	sw	zero,-1614(a5) # d2c <c_started>
 382:	00001797          	auipc	a5,0x1
 386:	9a07a723          	sw	zero,-1618(a5) # d30 <b_started>
 38a:	00001797          	auipc	a5,0x1
 38e:	9a07a523          	sw	zero,-1622(a5) # d34 <a_started>
  a_n = b_n = c_n = 0;
 392:	00001797          	auipc	a5,0x1
 396:	9807a723          	sw	zero,-1650(a5) # d20 <c_n>
 39a:	00001797          	auipc	a5,0x1
 39e:	9807a523          	sw	zero,-1654(a5) # d24 <b_n>
 3a2:	00001797          	auipc	a5,0x1
 3a6:	9807a323          	sw	zero,-1658(a5) # d28 <a_n>
  thread_init();
 3aa:	00000097          	auipc	ra,0x0
 3ae:	c56080e7          	jalr	-938(ra) # 0 <thread_init>
  thread_create(thread_a);
 3b2:	00000517          	auipc	a0,0x0
 3b6:	d5c50513          	addi	a0,a0,-676 # 10e <thread_a>
 3ba:	00000097          	auipc	ra,0x0
 3be:	cea080e7          	jalr	-790(ra) # a4 <thread_create>
  thread_create(thread_b);
 3c2:	00000517          	auipc	a0,0x0
 3c6:	e1850513          	addi	a0,a0,-488 # 1da <thread_b>
 3ca:	00000097          	auipc	ra,0x0
 3ce:	cda080e7          	jalr	-806(ra) # a4 <thread_create>
  thread_create(thread_c);
 3d2:	00000517          	auipc	a0,0x0
 3d6:	ed450513          	addi	a0,a0,-300 # 2a6 <thread_c>
 3da:	00000097          	auipc	ra,0x0
 3de:	cca080e7          	jalr	-822(ra) # a4 <thread_create>
  thread_schedule();
 3e2:	00000097          	auipc	ra,0x0
 3e6:	c48080e7          	jalr	-952(ra) # 2a <thread_schedule>
  exit(0);
 3ea:	4501                	li	a0,0
 3ec:	00000097          	auipc	ra,0x0
 3f0:	298080e7          	jalr	664(ra) # 684 <exit>

00000000000003f4 <thread_switch>:
 3f4:	8082                	ret

00000000000003f6 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 3f6:	1141                	addi	sp,sp,-16
 3f8:	e406                	sd	ra,8(sp)
 3fa:	e022                	sd	s0,0(sp)
 3fc:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 3fe:	87aa                	mv	a5,a0
 400:	0585                	addi	a1,a1,1
 402:	0785                	addi	a5,a5,1
 404:	fff5c703          	lbu	a4,-1(a1)
 408:	fee78fa3          	sb	a4,-1(a5)
 40c:	fb75                	bnez	a4,400 <strcpy+0xa>
    ;
  return os;
}
 40e:	60a2                	ld	ra,8(sp)
 410:	6402                	ld	s0,0(sp)
 412:	0141                	addi	sp,sp,16
 414:	8082                	ret

0000000000000416 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 416:	1141                	addi	sp,sp,-16
 418:	e406                	sd	ra,8(sp)
 41a:	e022                	sd	s0,0(sp)
 41c:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 41e:	00054783          	lbu	a5,0(a0)
 422:	cb91                	beqz	a5,436 <strcmp+0x20>
 424:	0005c703          	lbu	a4,0(a1)
 428:	00f71763          	bne	a4,a5,436 <strcmp+0x20>
    p++, q++;
 42c:	0505                	addi	a0,a0,1
 42e:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 430:	00054783          	lbu	a5,0(a0)
 434:	fbe5                	bnez	a5,424 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 436:	0005c503          	lbu	a0,0(a1)
}
 43a:	40a7853b          	subw	a0,a5,a0
 43e:	60a2                	ld	ra,8(sp)
 440:	6402                	ld	s0,0(sp)
 442:	0141                	addi	sp,sp,16
 444:	8082                	ret

0000000000000446 <strlen>:

uint
strlen(const char *s)
{
 446:	1141                	addi	sp,sp,-16
 448:	e406                	sd	ra,8(sp)
 44a:	e022                	sd	s0,0(sp)
 44c:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 44e:	00054783          	lbu	a5,0(a0)
 452:	cf91                	beqz	a5,46e <strlen+0x28>
 454:	00150793          	addi	a5,a0,1
 458:	86be                	mv	a3,a5
 45a:	0785                	addi	a5,a5,1
 45c:	fff7c703          	lbu	a4,-1(a5)
 460:	ff65                	bnez	a4,458 <strlen+0x12>
 462:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
 466:	60a2                	ld	ra,8(sp)
 468:	6402                	ld	s0,0(sp)
 46a:	0141                	addi	sp,sp,16
 46c:	8082                	ret
  for(n = 0; s[n]; n++)
 46e:	4501                	li	a0,0
 470:	bfdd                	j	466 <strlen+0x20>

0000000000000472 <memset>:

void*
memset(void *dst, int c, uint n)
{
 472:	1141                	addi	sp,sp,-16
 474:	e406                	sd	ra,8(sp)
 476:	e022                	sd	s0,0(sp)
 478:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 47a:	ca19                	beqz	a2,490 <memset+0x1e>
 47c:	87aa                	mv	a5,a0
 47e:	1602                	slli	a2,a2,0x20
 480:	9201                	srli	a2,a2,0x20
 482:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 486:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 48a:	0785                	addi	a5,a5,1
 48c:	fee79de3          	bne	a5,a4,486 <memset+0x14>
  }
  return dst;
}
 490:	60a2                	ld	ra,8(sp)
 492:	6402                	ld	s0,0(sp)
 494:	0141                	addi	sp,sp,16
 496:	8082                	ret

0000000000000498 <strchr>:

char*
strchr(const char *s, char c)
{
 498:	1141                	addi	sp,sp,-16
 49a:	e406                	sd	ra,8(sp)
 49c:	e022                	sd	s0,0(sp)
 49e:	0800                	addi	s0,sp,16
  for(; *s; s++)
 4a0:	00054783          	lbu	a5,0(a0)
 4a4:	cf81                	beqz	a5,4bc <strchr+0x24>
    if(*s == c)
 4a6:	00f58763          	beq	a1,a5,4b4 <strchr+0x1c>
  for(; *s; s++)
 4aa:	0505                	addi	a0,a0,1
 4ac:	00054783          	lbu	a5,0(a0)
 4b0:	fbfd                	bnez	a5,4a6 <strchr+0xe>
      return (char*)s;
  return 0;
 4b2:	4501                	li	a0,0
}
 4b4:	60a2                	ld	ra,8(sp)
 4b6:	6402                	ld	s0,0(sp)
 4b8:	0141                	addi	sp,sp,16
 4ba:	8082                	ret
  return 0;
 4bc:	4501                	li	a0,0
 4be:	bfdd                	j	4b4 <strchr+0x1c>

00000000000004c0 <gets>:

char*
gets(char *buf, int max)
{
 4c0:	711d                	addi	sp,sp,-96
 4c2:	ec86                	sd	ra,88(sp)
 4c4:	e8a2                	sd	s0,80(sp)
 4c6:	e4a6                	sd	s1,72(sp)
 4c8:	e0ca                	sd	s2,64(sp)
 4ca:	fc4e                	sd	s3,56(sp)
 4cc:	f852                	sd	s4,48(sp)
 4ce:	f456                	sd	s5,40(sp)
 4d0:	f05a                	sd	s6,32(sp)
 4d2:	ec5e                	sd	s7,24(sp)
 4d4:	e862                	sd	s8,16(sp)
 4d6:	1080                	addi	s0,sp,96
 4d8:	8baa                	mv	s7,a0
 4da:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 4dc:	892a                	mv	s2,a0
 4de:	4481                	li	s1,0
    cc = read(0, &c, 1);
 4e0:	faf40b13          	addi	s6,s0,-81
 4e4:	4a85                	li	s5,1
  for(i=0; i+1 < max; ){
 4e6:	8c26                	mv	s8,s1
 4e8:	0014899b          	addiw	s3,s1,1
 4ec:	84ce                	mv	s1,s3
 4ee:	0349d663          	bge	s3,s4,51a <gets+0x5a>
    cc = read(0, &c, 1);
 4f2:	8656                	mv	a2,s5
 4f4:	85da                	mv	a1,s6
 4f6:	4501                	li	a0,0
 4f8:	00000097          	auipc	ra,0x0
 4fc:	1a4080e7          	jalr	420(ra) # 69c <read>
    if(cc < 1)
 500:	00a05d63          	blez	a0,51a <gets+0x5a>
      break;
    buf[i++] = c;
 504:	faf44783          	lbu	a5,-81(s0)
 508:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 50c:	0905                	addi	s2,s2,1
 50e:	ff678713          	addi	a4,a5,-10
 512:	c319                	beqz	a4,518 <gets+0x58>
 514:	17cd                	addi	a5,a5,-13
 516:	fbe1                	bnez	a5,4e6 <gets+0x26>
    buf[i++] = c;
 518:	8c4e                	mv	s8,s3
      break;
  }
  buf[i] = '\0';
 51a:	9c5e                	add	s8,s8,s7
 51c:	000c0023          	sb	zero,0(s8)
  return buf;
}
 520:	855e                	mv	a0,s7
 522:	60e6                	ld	ra,88(sp)
 524:	6446                	ld	s0,80(sp)
 526:	64a6                	ld	s1,72(sp)
 528:	6906                	ld	s2,64(sp)
 52a:	79e2                	ld	s3,56(sp)
 52c:	7a42                	ld	s4,48(sp)
 52e:	7aa2                	ld	s5,40(sp)
 530:	7b02                	ld	s6,32(sp)
 532:	6be2                	ld	s7,24(sp)
 534:	6c42                	ld	s8,16(sp)
 536:	6125                	addi	sp,sp,96
 538:	8082                	ret

000000000000053a <stat>:

int
stat(const char *n, struct stat *st)
{
 53a:	1101                	addi	sp,sp,-32
 53c:	ec06                	sd	ra,24(sp)
 53e:	e822                	sd	s0,16(sp)
 540:	e04a                	sd	s2,0(sp)
 542:	1000                	addi	s0,sp,32
 544:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 546:	4581                	li	a1,0
 548:	00000097          	auipc	ra,0x0
 54c:	17c080e7          	jalr	380(ra) # 6c4 <open>
  if(fd < 0)
 550:	02054663          	bltz	a0,57c <stat+0x42>
 554:	e426                	sd	s1,8(sp)
 556:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 558:	85ca                	mv	a1,s2
 55a:	00000097          	auipc	ra,0x0
 55e:	182080e7          	jalr	386(ra) # 6dc <fstat>
 562:	892a                	mv	s2,a0
  close(fd);
 564:	8526                	mv	a0,s1
 566:	00000097          	auipc	ra,0x0
 56a:	146080e7          	jalr	326(ra) # 6ac <close>
  return r;
 56e:	64a2                	ld	s1,8(sp)
}
 570:	854a                	mv	a0,s2
 572:	60e2                	ld	ra,24(sp)
 574:	6442                	ld	s0,16(sp)
 576:	6902                	ld	s2,0(sp)
 578:	6105                	addi	sp,sp,32
 57a:	8082                	ret
    return -1;
 57c:	57fd                	li	a5,-1
 57e:	893e                	mv	s2,a5
 580:	bfc5                	j	570 <stat+0x36>

0000000000000582 <atoi>:

int
atoi(const char *s)
{
 582:	1141                	addi	sp,sp,-16
 584:	e406                	sd	ra,8(sp)
 586:	e022                	sd	s0,0(sp)
 588:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 58a:	00054683          	lbu	a3,0(a0)
 58e:	fd06879b          	addiw	a5,a3,-48
 592:	0ff7f793          	zext.b	a5,a5
 596:	4625                	li	a2,9
 598:	02f66963          	bltu	a2,a5,5ca <atoi+0x48>
 59c:	872a                	mv	a4,a0
  n = 0;
 59e:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 5a0:	0705                	addi	a4,a4,1 # 2001 <__global_pointer$+0xae8>
 5a2:	0025179b          	slliw	a5,a0,0x2
 5a6:	9fa9                	addw	a5,a5,a0
 5a8:	0017979b          	slliw	a5,a5,0x1
 5ac:	9fb5                	addw	a5,a5,a3
 5ae:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 5b2:	00074683          	lbu	a3,0(a4)
 5b6:	fd06879b          	addiw	a5,a3,-48
 5ba:	0ff7f793          	zext.b	a5,a5
 5be:	fef671e3          	bgeu	a2,a5,5a0 <atoi+0x1e>
  return n;
}
 5c2:	60a2                	ld	ra,8(sp)
 5c4:	6402                	ld	s0,0(sp)
 5c6:	0141                	addi	sp,sp,16
 5c8:	8082                	ret
  n = 0;
 5ca:	4501                	li	a0,0
 5cc:	bfdd                	j	5c2 <atoi+0x40>

00000000000005ce <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 5ce:	1141                	addi	sp,sp,-16
 5d0:	e406                	sd	ra,8(sp)
 5d2:	e022                	sd	s0,0(sp)
 5d4:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 5d6:	02b57563          	bgeu	a0,a1,600 <memmove+0x32>
    while(n-- > 0)
 5da:	00c05f63          	blez	a2,5f8 <memmove+0x2a>
 5de:	1602                	slli	a2,a2,0x20
 5e0:	9201                	srli	a2,a2,0x20
 5e2:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 5e6:	872a                	mv	a4,a0
      *dst++ = *src++;
 5e8:	0585                	addi	a1,a1,1
 5ea:	0705                	addi	a4,a4,1
 5ec:	fff5c683          	lbu	a3,-1(a1)
 5f0:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 5f4:	fee79ae3          	bne	a5,a4,5e8 <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 5f8:	60a2                	ld	ra,8(sp)
 5fa:	6402                	ld	s0,0(sp)
 5fc:	0141                	addi	sp,sp,16
 5fe:	8082                	ret
    while(n-- > 0)
 600:	fec05ce3          	blez	a2,5f8 <memmove+0x2a>
    dst += n;
 604:	00c50733          	add	a4,a0,a2
    src += n;
 608:	95b2                	add	a1,a1,a2
 60a:	fff6079b          	addiw	a5,a2,-1
 60e:	1782                	slli	a5,a5,0x20
 610:	9381                	srli	a5,a5,0x20
 612:	fff7c793          	not	a5,a5
 616:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 618:	15fd                	addi	a1,a1,-1
 61a:	177d                	addi	a4,a4,-1
 61c:	0005c683          	lbu	a3,0(a1)
 620:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 624:	fef71ae3          	bne	a4,a5,618 <memmove+0x4a>
 628:	bfc1                	j	5f8 <memmove+0x2a>

000000000000062a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 62a:	1141                	addi	sp,sp,-16
 62c:	e406                	sd	ra,8(sp)
 62e:	e022                	sd	s0,0(sp)
 630:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 632:	c61d                	beqz	a2,660 <memcmp+0x36>
 634:	1602                	slli	a2,a2,0x20
 636:	9201                	srli	a2,a2,0x20
 638:	00c506b3          	add	a3,a0,a2
    if (*p1 != *p2) {
 63c:	00054783          	lbu	a5,0(a0)
 640:	0005c703          	lbu	a4,0(a1)
 644:	00e79863          	bne	a5,a4,654 <memcmp+0x2a>
      return *p1 - *p2;
    }
    p1++;
 648:	0505                	addi	a0,a0,1
    p2++;
 64a:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 64c:	fed518e3          	bne	a0,a3,63c <memcmp+0x12>
  }
  return 0;
 650:	4501                	li	a0,0
 652:	a019                	j	658 <memcmp+0x2e>
      return *p1 - *p2;
 654:	40e7853b          	subw	a0,a5,a4
}
 658:	60a2                	ld	ra,8(sp)
 65a:	6402                	ld	s0,0(sp)
 65c:	0141                	addi	sp,sp,16
 65e:	8082                	ret
  return 0;
 660:	4501                	li	a0,0
 662:	bfdd                	j	658 <memcmp+0x2e>

0000000000000664 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 664:	1141                	addi	sp,sp,-16
 666:	e406                	sd	ra,8(sp)
 668:	e022                	sd	s0,0(sp)
 66a:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 66c:	00000097          	auipc	ra,0x0
 670:	f62080e7          	jalr	-158(ra) # 5ce <memmove>
}
 674:	60a2                	ld	ra,8(sp)
 676:	6402                	ld	s0,0(sp)
 678:	0141                	addi	sp,sp,16
 67a:	8082                	ret

000000000000067c <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 67c:	4885                	li	a7,1
 ecall
 67e:	00000073          	ecall
 ret
 682:	8082                	ret

0000000000000684 <exit>:
.global exit
exit:
 li a7, SYS_exit
 684:	4889                	li	a7,2
 ecall
 686:	00000073          	ecall
 ret
 68a:	8082                	ret

000000000000068c <wait>:
.global wait
wait:
 li a7, SYS_wait
 68c:	488d                	li	a7,3
 ecall
 68e:	00000073          	ecall
 ret
 692:	8082                	ret

0000000000000694 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 694:	4891                	li	a7,4
 ecall
 696:	00000073          	ecall
 ret
 69a:	8082                	ret

000000000000069c <read>:
.global read
read:
 li a7, SYS_read
 69c:	4895                	li	a7,5
 ecall
 69e:	00000073          	ecall
 ret
 6a2:	8082                	ret

00000000000006a4 <write>:
.global write
write:
 li a7, SYS_write
 6a4:	48c1                	li	a7,16
 ecall
 6a6:	00000073          	ecall
 ret
 6aa:	8082                	ret

00000000000006ac <close>:
.global close
close:
 li a7, SYS_close
 6ac:	48d5                	li	a7,21
 ecall
 6ae:	00000073          	ecall
 ret
 6b2:	8082                	ret

00000000000006b4 <kill>:
.global kill
kill:
 li a7, SYS_kill
 6b4:	4899                	li	a7,6
 ecall
 6b6:	00000073          	ecall
 ret
 6ba:	8082                	ret

00000000000006bc <exec>:
.global exec
exec:
 li a7, SYS_exec
 6bc:	489d                	li	a7,7
 ecall
 6be:	00000073          	ecall
 ret
 6c2:	8082                	ret

00000000000006c4 <open>:
.global open
open:
 li a7, SYS_open
 6c4:	48bd                	li	a7,15
 ecall
 6c6:	00000073          	ecall
 ret
 6ca:	8082                	ret

00000000000006cc <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 6cc:	48c5                	li	a7,17
 ecall
 6ce:	00000073          	ecall
 ret
 6d2:	8082                	ret

00000000000006d4 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 6d4:	48c9                	li	a7,18
 ecall
 6d6:	00000073          	ecall
 ret
 6da:	8082                	ret

00000000000006dc <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 6dc:	48a1                	li	a7,8
 ecall
 6de:	00000073          	ecall
 ret
 6e2:	8082                	ret

00000000000006e4 <link>:
.global link
link:
 li a7, SYS_link
 6e4:	48cd                	li	a7,19
 ecall
 6e6:	00000073          	ecall
 ret
 6ea:	8082                	ret

00000000000006ec <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 6ec:	48d1                	li	a7,20
 ecall
 6ee:	00000073          	ecall
 ret
 6f2:	8082                	ret

00000000000006f4 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 6f4:	48a5                	li	a7,9
 ecall
 6f6:	00000073          	ecall
 ret
 6fa:	8082                	ret

00000000000006fc <dup>:
.global dup
dup:
 li a7, SYS_dup
 6fc:	48a9                	li	a7,10
 ecall
 6fe:	00000073          	ecall
 ret
 702:	8082                	ret

0000000000000704 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 704:	48ad                	li	a7,11
 ecall
 706:	00000073          	ecall
 ret
 70a:	8082                	ret

000000000000070c <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 70c:	48b1                	li	a7,12
 ecall
 70e:	00000073          	ecall
 ret
 712:	8082                	ret

0000000000000714 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 714:	48b5                	li	a7,13
 ecall
 716:	00000073          	ecall
 ret
 71a:	8082                	ret

000000000000071c <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 71c:	48b9                	li	a7,14
 ecall
 71e:	00000073          	ecall
 ret
 722:	8082                	ret

0000000000000724 <ntas>:
.global ntas
ntas:
 li a7, SYS_ntas
 724:	48d9                	li	a7,22
 ecall
 726:	00000073          	ecall
 ret
 72a:	8082                	ret

000000000000072c <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 72c:	1101                	addi	sp,sp,-32
 72e:	ec06                	sd	ra,24(sp)
 730:	e822                	sd	s0,16(sp)
 732:	1000                	addi	s0,sp,32
 734:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 738:	4605                	li	a2,1
 73a:	fef40593          	addi	a1,s0,-17
 73e:	00000097          	auipc	ra,0x0
 742:	f66080e7          	jalr	-154(ra) # 6a4 <write>
}
 746:	60e2                	ld	ra,24(sp)
 748:	6442                	ld	s0,16(sp)
 74a:	6105                	addi	sp,sp,32
 74c:	8082                	ret

000000000000074e <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 74e:	7139                	addi	sp,sp,-64
 750:	fc06                	sd	ra,56(sp)
 752:	f822                	sd	s0,48(sp)
 754:	f04a                	sd	s2,32(sp)
 756:	ec4e                	sd	s3,24(sp)
 758:	0080                	addi	s0,sp,64
 75a:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 75c:	cad9                	beqz	a3,7f2 <printint+0xa4>
 75e:	01f5d79b          	srliw	a5,a1,0x1f
 762:	cbc1                	beqz	a5,7f2 <printint+0xa4>
    neg = 1;
    x = -xx;
 764:	40b005bb          	negw	a1,a1
    neg = 1;
 768:	4305                	li	t1,1
  } else {
    x = xx;
  }

  i = 0;
 76a:	fc040993          	addi	s3,s0,-64
  neg = 0;
 76e:	86ce                	mv	a3,s3
  i = 0;
 770:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 772:	00000817          	auipc	a6,0x0
 776:	59680813          	addi	a6,a6,1430 # d08 <digits>
 77a:	88ba                	mv	a7,a4
 77c:	0017051b          	addiw	a0,a4,1
 780:	872a                	mv	a4,a0
 782:	02c5f7bb          	remuw	a5,a1,a2
 786:	1782                	slli	a5,a5,0x20
 788:	9381                	srli	a5,a5,0x20
 78a:	97c2                	add	a5,a5,a6
 78c:	0007c783          	lbu	a5,0(a5)
 790:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 794:	87ae                	mv	a5,a1
 796:	02c5d5bb          	divuw	a1,a1,a2
 79a:	0685                	addi	a3,a3,1
 79c:	fcc7ffe3          	bgeu	a5,a2,77a <printint+0x2c>
  if(neg)
 7a0:	00030c63          	beqz	t1,7b8 <printint+0x6a>
    buf[i++] = '-';
 7a4:	fd050793          	addi	a5,a0,-48
 7a8:	00878533          	add	a0,a5,s0
 7ac:	02d00793          	li	a5,45
 7b0:	fef50823          	sb	a5,-16(a0)
 7b4:	0028871b          	addiw	a4,a7,2

  while(--i >= 0)
 7b8:	02e05763          	blez	a4,7e6 <printint+0x98>
 7bc:	f426                	sd	s1,40(sp)
 7be:	377d                	addiw	a4,a4,-1
 7c0:	00e984b3          	add	s1,s3,a4
 7c4:	19fd                	addi	s3,s3,-1
 7c6:	99ba                	add	s3,s3,a4
 7c8:	1702                	slli	a4,a4,0x20
 7ca:	9301                	srli	a4,a4,0x20
 7cc:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 7d0:	0004c583          	lbu	a1,0(s1)
 7d4:	854a                	mv	a0,s2
 7d6:	00000097          	auipc	ra,0x0
 7da:	f56080e7          	jalr	-170(ra) # 72c <putc>
  while(--i >= 0)
 7de:	14fd                	addi	s1,s1,-1
 7e0:	ff3498e3          	bne	s1,s3,7d0 <printint+0x82>
 7e4:	74a2                	ld	s1,40(sp)
}
 7e6:	70e2                	ld	ra,56(sp)
 7e8:	7442                	ld	s0,48(sp)
 7ea:	7902                	ld	s2,32(sp)
 7ec:	69e2                	ld	s3,24(sp)
 7ee:	6121                	addi	sp,sp,64
 7f0:	8082                	ret
  neg = 0;
 7f2:	4301                	li	t1,0
 7f4:	bf9d                	j	76a <printint+0x1c>

00000000000007f6 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 7f6:	715d                	addi	sp,sp,-80
 7f8:	e486                	sd	ra,72(sp)
 7fa:	e0a2                	sd	s0,64(sp)
 7fc:	f84a                	sd	s2,48(sp)
 7fe:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 800:	0005c903          	lbu	s2,0(a1)
 804:	1a090b63          	beqz	s2,9ba <vprintf+0x1c4>
 808:	fc26                	sd	s1,56(sp)
 80a:	f44e                	sd	s3,40(sp)
 80c:	f052                	sd	s4,32(sp)
 80e:	ec56                	sd	s5,24(sp)
 810:	e85a                	sd	s6,16(sp)
 812:	e45e                	sd	s7,8(sp)
 814:	8aaa                	mv	s5,a0
 816:	8bb2                	mv	s7,a2
 818:	00158493          	addi	s1,a1,1
  state = 0;
 81c:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 81e:	02500a13          	li	s4,37
 822:	4b55                	li	s6,21
 824:	a839                	j	842 <vprintf+0x4c>
        putc(fd, c);
 826:	85ca                	mv	a1,s2
 828:	8556                	mv	a0,s5
 82a:	00000097          	auipc	ra,0x0
 82e:	f02080e7          	jalr	-254(ra) # 72c <putc>
 832:	a019                	j	838 <vprintf+0x42>
    } else if(state == '%'){
 834:	01498d63          	beq	s3,s4,84e <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
 838:	0485                	addi	s1,s1,1
 83a:	fff4c903          	lbu	s2,-1(s1)
 83e:	16090863          	beqz	s2,9ae <vprintf+0x1b8>
    if(state == 0){
 842:	fe0999e3          	bnez	s3,834 <vprintf+0x3e>
      if(c == '%'){
 846:	ff4910e3          	bne	s2,s4,826 <vprintf+0x30>
        state = '%';
 84a:	89d2                	mv	s3,s4
 84c:	b7f5                	j	838 <vprintf+0x42>
      if(c == 'd'){
 84e:	13490563          	beq	s2,s4,978 <vprintf+0x182>
 852:	f9d9079b          	addiw	a5,s2,-99
 856:	0ff7f793          	zext.b	a5,a5
 85a:	12fb6863          	bltu	s6,a5,98a <vprintf+0x194>
 85e:	f9d9079b          	addiw	a5,s2,-99
 862:	0ff7f713          	zext.b	a4,a5
 866:	12eb6263          	bltu	s6,a4,98a <vprintf+0x194>
 86a:	00271793          	slli	a5,a4,0x2
 86e:	00000717          	auipc	a4,0x0
 872:	44270713          	addi	a4,a4,1090 # cb0 <malloc+0x202>
 876:	97ba                	add	a5,a5,a4
 878:	439c                	lw	a5,0(a5)
 87a:	97ba                	add	a5,a5,a4
 87c:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 87e:	008b8913          	addi	s2,s7,8
 882:	4685                	li	a3,1
 884:	4629                	li	a2,10
 886:	000ba583          	lw	a1,0(s7)
 88a:	8556                	mv	a0,s5
 88c:	00000097          	auipc	ra,0x0
 890:	ec2080e7          	jalr	-318(ra) # 74e <printint>
 894:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 896:	4981                	li	s3,0
 898:	b745                	j	838 <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
 89a:	008b8913          	addi	s2,s7,8
 89e:	4681                	li	a3,0
 8a0:	4629                	li	a2,10
 8a2:	000ba583          	lw	a1,0(s7)
 8a6:	8556                	mv	a0,s5
 8a8:	00000097          	auipc	ra,0x0
 8ac:	ea6080e7          	jalr	-346(ra) # 74e <printint>
 8b0:	8bca                	mv	s7,s2
      state = 0;
 8b2:	4981                	li	s3,0
 8b4:	b751                	j	838 <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
 8b6:	008b8913          	addi	s2,s7,8
 8ba:	4681                	li	a3,0
 8bc:	4641                	li	a2,16
 8be:	000ba583          	lw	a1,0(s7)
 8c2:	8556                	mv	a0,s5
 8c4:	00000097          	auipc	ra,0x0
 8c8:	e8a080e7          	jalr	-374(ra) # 74e <printint>
 8cc:	8bca                	mv	s7,s2
      state = 0;
 8ce:	4981                	li	s3,0
 8d0:	b7a5                	j	838 <vprintf+0x42>
 8d2:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
 8d4:	008b8793          	addi	a5,s7,8
 8d8:	8c3e                	mv	s8,a5
 8da:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 8de:	03000593          	li	a1,48
 8e2:	8556                	mv	a0,s5
 8e4:	00000097          	auipc	ra,0x0
 8e8:	e48080e7          	jalr	-440(ra) # 72c <putc>
  putc(fd, 'x');
 8ec:	07800593          	li	a1,120
 8f0:	8556                	mv	a0,s5
 8f2:	00000097          	auipc	ra,0x0
 8f6:	e3a080e7          	jalr	-454(ra) # 72c <putc>
 8fa:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 8fc:	00000b97          	auipc	s7,0x0
 900:	40cb8b93          	addi	s7,s7,1036 # d08 <digits>
 904:	03c9d793          	srli	a5,s3,0x3c
 908:	97de                	add	a5,a5,s7
 90a:	0007c583          	lbu	a1,0(a5)
 90e:	8556                	mv	a0,s5
 910:	00000097          	auipc	ra,0x0
 914:	e1c080e7          	jalr	-484(ra) # 72c <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 918:	0992                	slli	s3,s3,0x4
 91a:	397d                	addiw	s2,s2,-1
 91c:	fe0914e3          	bnez	s2,904 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
 920:	8be2                	mv	s7,s8
      state = 0;
 922:	4981                	li	s3,0
 924:	6c02                	ld	s8,0(sp)
 926:	bf09                	j	838 <vprintf+0x42>
        s = va_arg(ap, char*);
 928:	008b8993          	addi	s3,s7,8
 92c:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 930:	02090163          	beqz	s2,952 <vprintf+0x15c>
        while(*s != 0){
 934:	00094583          	lbu	a1,0(s2)
 938:	c9a5                	beqz	a1,9a8 <vprintf+0x1b2>
          putc(fd, *s);
 93a:	8556                	mv	a0,s5
 93c:	00000097          	auipc	ra,0x0
 940:	df0080e7          	jalr	-528(ra) # 72c <putc>
          s++;
 944:	0905                	addi	s2,s2,1
        while(*s != 0){
 946:	00094583          	lbu	a1,0(s2)
 94a:	f9e5                	bnez	a1,93a <vprintf+0x144>
        s = va_arg(ap, char*);
 94c:	8bce                	mv	s7,s3
      state = 0;
 94e:	4981                	li	s3,0
 950:	b5e5                	j	838 <vprintf+0x42>
          s = "(null)";
 952:	00000917          	auipc	s2,0x0
 956:	35690913          	addi	s2,s2,854 # ca8 <malloc+0x1fa>
        while(*s != 0){
 95a:	02800593          	li	a1,40
 95e:	bff1                	j	93a <vprintf+0x144>
        putc(fd, va_arg(ap, uint));
 960:	008b8913          	addi	s2,s7,8
 964:	000bc583          	lbu	a1,0(s7)
 968:	8556                	mv	a0,s5
 96a:	00000097          	auipc	ra,0x0
 96e:	dc2080e7          	jalr	-574(ra) # 72c <putc>
 972:	8bca                	mv	s7,s2
      state = 0;
 974:	4981                	li	s3,0
 976:	b5c9                	j	838 <vprintf+0x42>
        putc(fd, c);
 978:	02500593          	li	a1,37
 97c:	8556                	mv	a0,s5
 97e:	00000097          	auipc	ra,0x0
 982:	dae080e7          	jalr	-594(ra) # 72c <putc>
      state = 0;
 986:	4981                	li	s3,0
 988:	bd45                	j	838 <vprintf+0x42>
        putc(fd, '%');
 98a:	02500593          	li	a1,37
 98e:	8556                	mv	a0,s5
 990:	00000097          	auipc	ra,0x0
 994:	d9c080e7          	jalr	-612(ra) # 72c <putc>
        putc(fd, c);
 998:	85ca                	mv	a1,s2
 99a:	8556                	mv	a0,s5
 99c:	00000097          	auipc	ra,0x0
 9a0:	d90080e7          	jalr	-624(ra) # 72c <putc>
      state = 0;
 9a4:	4981                	li	s3,0
 9a6:	bd49                	j	838 <vprintf+0x42>
        s = va_arg(ap, char*);
 9a8:	8bce                	mv	s7,s3
      state = 0;
 9aa:	4981                	li	s3,0
 9ac:	b571                	j	838 <vprintf+0x42>
 9ae:	74e2                	ld	s1,56(sp)
 9b0:	79a2                	ld	s3,40(sp)
 9b2:	7a02                	ld	s4,32(sp)
 9b4:	6ae2                	ld	s5,24(sp)
 9b6:	6b42                	ld	s6,16(sp)
 9b8:	6ba2                	ld	s7,8(sp)
    }
  }
}
 9ba:	60a6                	ld	ra,72(sp)
 9bc:	6406                	ld	s0,64(sp)
 9be:	7942                	ld	s2,48(sp)
 9c0:	6161                	addi	sp,sp,80
 9c2:	8082                	ret

00000000000009c4 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 9c4:	715d                	addi	sp,sp,-80
 9c6:	ec06                	sd	ra,24(sp)
 9c8:	e822                	sd	s0,16(sp)
 9ca:	1000                	addi	s0,sp,32
 9cc:	e010                	sd	a2,0(s0)
 9ce:	e414                	sd	a3,8(s0)
 9d0:	e818                	sd	a4,16(s0)
 9d2:	ec1c                	sd	a5,24(s0)
 9d4:	03043023          	sd	a6,32(s0)
 9d8:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 9dc:	8622                	mv	a2,s0
 9de:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 9e2:	00000097          	auipc	ra,0x0
 9e6:	e14080e7          	jalr	-492(ra) # 7f6 <vprintf>
}
 9ea:	60e2                	ld	ra,24(sp)
 9ec:	6442                	ld	s0,16(sp)
 9ee:	6161                	addi	sp,sp,80
 9f0:	8082                	ret

00000000000009f2 <printf>:

void
printf(const char *fmt, ...)
{
 9f2:	711d                	addi	sp,sp,-96
 9f4:	ec06                	sd	ra,24(sp)
 9f6:	e822                	sd	s0,16(sp)
 9f8:	1000                	addi	s0,sp,32
 9fa:	e40c                	sd	a1,8(s0)
 9fc:	e810                	sd	a2,16(s0)
 9fe:	ec14                	sd	a3,24(s0)
 a00:	f018                	sd	a4,32(s0)
 a02:	f41c                	sd	a5,40(s0)
 a04:	03043823          	sd	a6,48(s0)
 a08:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 a0c:	00840613          	addi	a2,s0,8
 a10:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 a14:	85aa                	mv	a1,a0
 a16:	4505                	li	a0,1
 a18:	00000097          	auipc	ra,0x0
 a1c:	dde080e7          	jalr	-546(ra) # 7f6 <vprintf>
}
 a20:	60e2                	ld	ra,24(sp)
 a22:	6442                	ld	s0,16(sp)
 a24:	6125                	addi	sp,sp,96
 a26:	8082                	ret

0000000000000a28 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 a28:	1141                	addi	sp,sp,-16
 a2a:	e406                	sd	ra,8(sp)
 a2c:	e022                	sd	s0,0(sp)
 a2e:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 a30:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a34:	00000797          	auipc	a5,0x0
 a38:	30c7b783          	ld	a5,780(a5) # d40 <freep>
 a3c:	a039                	j	a4a <free+0x22>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a3e:	6398                	ld	a4,0(a5)
 a40:	00e7e463          	bltu	a5,a4,a48 <free+0x20>
 a44:	00e6ea63          	bltu	a3,a4,a58 <free+0x30>
{
 a48:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a4a:	fed7fae3          	bgeu	a5,a3,a3e <free+0x16>
 a4e:	6398                	ld	a4,0(a5)
 a50:	00e6e463          	bltu	a3,a4,a58 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a54:	fee7eae3          	bltu	a5,a4,a48 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 a58:	ff852583          	lw	a1,-8(a0)
 a5c:	6390                	ld	a2,0(a5)
 a5e:	02059813          	slli	a6,a1,0x20
 a62:	01c85713          	srli	a4,a6,0x1c
 a66:	9736                	add	a4,a4,a3
 a68:	02e60563          	beq	a2,a4,a92 <free+0x6a>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 a6c:	fec53823          	sd	a2,-16(a0)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 a70:	4790                	lw	a2,8(a5)
 a72:	02061593          	slli	a1,a2,0x20
 a76:	01c5d713          	srli	a4,a1,0x1c
 a7a:	973e                	add	a4,a4,a5
 a7c:	02e68263          	beq	a3,a4,aa0 <free+0x78>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 a80:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 a82:	00000717          	auipc	a4,0x0
 a86:	2af73f23          	sd	a5,702(a4) # d40 <freep>
}
 a8a:	60a2                	ld	ra,8(sp)
 a8c:	6402                	ld	s0,0(sp)
 a8e:	0141                	addi	sp,sp,16
 a90:	8082                	ret
    bp->s.size += p->s.ptr->s.size;
 a92:	4618                	lw	a4,8(a2)
 a94:	9f2d                	addw	a4,a4,a1
 a96:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 a9a:	6398                	ld	a4,0(a5)
 a9c:	6310                	ld	a2,0(a4)
 a9e:	b7f9                	j	a6c <free+0x44>
    p->s.size += bp->s.size;
 aa0:	ff852703          	lw	a4,-8(a0)
 aa4:	9f31                	addw	a4,a4,a2
 aa6:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 aa8:	ff053683          	ld	a3,-16(a0)
 aac:	bfd1                	j	a80 <free+0x58>

0000000000000aae <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 aae:	7139                	addi	sp,sp,-64
 ab0:	fc06                	sd	ra,56(sp)
 ab2:	f822                	sd	s0,48(sp)
 ab4:	f04a                	sd	s2,32(sp)
 ab6:	ec4e                	sd	s3,24(sp)
 ab8:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 aba:	02051993          	slli	s3,a0,0x20
 abe:	0209d993          	srli	s3,s3,0x20
 ac2:	09bd                	addi	s3,s3,15
 ac4:	0049d993          	srli	s3,s3,0x4
 ac8:	2985                	addiw	s3,s3,1
 aca:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 acc:	00000517          	auipc	a0,0x0
 ad0:	27453503          	ld	a0,628(a0) # d40 <freep>
 ad4:	c905                	beqz	a0,b04 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ad6:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 ad8:	4798                	lw	a4,8(a5)
 ada:	09377a63          	bgeu	a4,s3,b6e <malloc+0xc0>
 ade:	f426                	sd	s1,40(sp)
 ae0:	e852                	sd	s4,16(sp)
 ae2:	e456                	sd	s5,8(sp)
 ae4:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 ae6:	8a4e                	mv	s4,s3
 ae8:	6705                	lui	a4,0x1
 aea:	00e9f363          	bgeu	s3,a4,af0 <malloc+0x42>
 aee:	6a05                	lui	s4,0x1
 af0:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 af4:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 af8:	00000497          	auipc	s1,0x0
 afc:	24848493          	addi	s1,s1,584 # d40 <freep>
  if(p == (char*)-1)
 b00:	5afd                	li	s5,-1
 b02:	a089                	j	b44 <malloc+0x96>
 b04:	f426                	sd	s1,40(sp)
 b06:	e852                	sd	s4,16(sp)
 b08:	e456                	sd	s5,8(sp)
 b0a:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 b0c:	00008797          	auipc	a5,0x8
 b10:	24c78793          	addi	a5,a5,588 # 8d58 <base>
 b14:	00000717          	auipc	a4,0x0
 b18:	22f73623          	sd	a5,556(a4) # d40 <freep>
 b1c:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 b1e:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 b22:	b7d1                	j	ae6 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 b24:	6398                	ld	a4,0(a5)
 b26:	e118                	sd	a4,0(a0)
 b28:	a8b9                	j	b86 <malloc+0xd8>
  hp->s.size = nu;
 b2a:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 b2e:	0541                	addi	a0,a0,16
 b30:	00000097          	auipc	ra,0x0
 b34:	ef8080e7          	jalr	-264(ra) # a28 <free>
  return freep;
 b38:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 b3a:	c135                	beqz	a0,b9e <malloc+0xf0>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b3c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 b3e:	4798                	lw	a4,8(a5)
 b40:	03277363          	bgeu	a4,s2,b66 <malloc+0xb8>
    if(p == freep)
 b44:	6098                	ld	a4,0(s1)
 b46:	853e                	mv	a0,a5
 b48:	fef71ae3          	bne	a4,a5,b3c <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 b4c:	8552                	mv	a0,s4
 b4e:	00000097          	auipc	ra,0x0
 b52:	bbe080e7          	jalr	-1090(ra) # 70c <sbrk>
  if(p == (char*)-1)
 b56:	fd551ae3          	bne	a0,s5,b2a <malloc+0x7c>
        return 0;
 b5a:	4501                	li	a0,0
 b5c:	74a2                	ld	s1,40(sp)
 b5e:	6a42                	ld	s4,16(sp)
 b60:	6aa2                	ld	s5,8(sp)
 b62:	6b02                	ld	s6,0(sp)
 b64:	a03d                	j	b92 <malloc+0xe4>
 b66:	74a2                	ld	s1,40(sp)
 b68:	6a42                	ld	s4,16(sp)
 b6a:	6aa2                	ld	s5,8(sp)
 b6c:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 b6e:	fae90be3          	beq	s2,a4,b24 <malloc+0x76>
        p->s.size -= nunits;
 b72:	4137073b          	subw	a4,a4,s3
 b76:	c798                	sw	a4,8(a5)
        p += p->s.size;
 b78:	02071693          	slli	a3,a4,0x20
 b7c:	01c6d713          	srli	a4,a3,0x1c
 b80:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 b82:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 b86:	00000717          	auipc	a4,0x0
 b8a:	1aa73d23          	sd	a0,442(a4) # d40 <freep>
      return (void*)(p + 1);
 b8e:	01078513          	addi	a0,a5,16
  }
}
 b92:	70e2                	ld	ra,56(sp)
 b94:	7442                	ld	s0,48(sp)
 b96:	7902                	ld	s2,32(sp)
 b98:	69e2                	ld	s3,24(sp)
 b9a:	6121                	addi	sp,sp,64
 b9c:	8082                	ret
 b9e:	74a2                	ld	s1,40(sp)
 ba0:	6a42                	ld	s4,16(sp)
 ba2:	6aa2                	ld	s5,8(sp)
 ba4:	6b02                	ld	s6,0(sp)
 ba6:	b7f5                	j	b92 <malloc+0xe4>
