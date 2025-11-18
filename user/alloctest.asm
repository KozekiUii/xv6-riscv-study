
user/_alloctest：     文件格式 elf64-littleriscv


Disassembly of section .text:

0000000000000000 <test0>:
#include "kernel/fcntl.h"
#include "kernel/memlayout.h"
#include "user/user.h"

void
test0() {
   0:	715d                	addi	sp,sp,-80
   2:	e486                	sd	ra,72(sp)
   4:	e0a2                	sd	s0,64(sp)
   6:	fc26                	sd	s1,56(sp)
   8:	f84a                	sd	s2,48(sp)
   a:	f44e                	sd	s3,40(sp)
   c:	f052                	sd	s4,32(sp)
   e:	ec56                	sd	s5,24(sp)
  10:	0880                	addi	s0,sp,80
  enum { NCHILD = 50, NFD = 10};
  int i, j;
  int fd;

  printf("filetest: start\n");
  12:	00001517          	auipc	a0,0x1
  16:	a1650513          	addi	a0,a0,-1514 # a28 <malloc+0x100>
  1a:	00001097          	auipc	ra,0x1
  1e:	852080e7          	jalr	-1966(ra) # 86c <printf>
  22:	03200493          	li	s1,50
    printf("test setup is wrong\n");
    exit(1);
  }

  for (i = 0; i < NCHILD; i++) {
    int pid = fork();
  26:	00000097          	auipc	ra,0x0
  2a:	4d0080e7          	jalr	1232(ra) # 4f6 <fork>
    if(pid < 0){
  2e:	02054063          	bltz	a0,4e <test0+0x4e>
      printf("fork failed");
      exit(1);
    }
    if(pid == 0){
  32:	c91d                	beqz	a0,68 <test0+0x68>
  for (i = 0; i < NCHILD; i++) {
  34:	34fd                	addiw	s1,s1,-1
  36:	f8e5                	bnez	s1,26 <test0+0x26>
  38:	03200493          	li	s1,50
      sleep(10);
      exit(0);  // no errors; exit with 0.
    }
  }

  int all_ok = 1;
  3c:	4985                	li	s3,1
  for(int i = 0; i < NCHILD; i++){
    int xstatus;
    wait(&xstatus);
  3e:	fbc40913          	addi	s2,s0,-68
    if(xstatus != 0) {
      if(all_ok == 1)
  42:	8a4e                	mv	s4,s3
        printf("filetest: FAILED\n");
  44:	00001a97          	auipc	s5,0x1
  48:	a14a8a93          	addi	s5,s5,-1516 # a58 <malloc+0x130>
  4c:	a8b1                	j	a8 <test0+0xa8>
      printf("fork failed");
  4e:	00001517          	auipc	a0,0x1
  52:	9f250513          	addi	a0,a0,-1550 # a40 <malloc+0x118>
  56:	00001097          	auipc	ra,0x1
  5a:	816080e7          	jalr	-2026(ra) # 86c <printf>
      exit(1);
  5e:	4505                	li	a0,1
  60:	00000097          	auipc	ra,0x0
  64:	49e080e7          	jalr	1182(ra) # 4fe <exit>
  68:	44a9                	li	s1,10
        if ((fd = open("README", O_RDONLY)) < 0) {
  6a:	00001917          	auipc	s2,0x1
  6e:	9e690913          	addi	s2,s2,-1562 # a50 <malloc+0x128>
  72:	4581                	li	a1,0
  74:	854a                	mv	a0,s2
  76:	00000097          	auipc	ra,0x0
  7a:	4c8080e7          	jalr	1224(ra) # 53e <open>
  7e:	00054e63          	bltz	a0,9a <test0+0x9a>
      for(j = 0; j < NFD; j++) {
  82:	34fd                	addiw	s1,s1,-1
  84:	f4fd                	bnez	s1,72 <test0+0x72>
      sleep(10);
  86:	4529                	li	a0,10
  88:	00000097          	auipc	ra,0x0
  8c:	506080e7          	jalr	1286(ra) # 58e <sleep>
      exit(0);  // no errors; exit with 0.
  90:	4501                	li	a0,0
  92:	00000097          	auipc	ra,0x0
  96:	46c080e7          	jalr	1132(ra) # 4fe <exit>
          exit(1);
  9a:	4505                	li	a0,1
  9c:	00000097          	auipc	ra,0x0
  a0:	462080e7          	jalr	1122(ra) # 4fe <exit>
  for(int i = 0; i < NCHILD; i++){
  a4:	34fd                	addiw	s1,s1,-1
  a6:	c095                	beqz	s1,ca <test0+0xca>
    wait(&xstatus);
  a8:	854a                	mv	a0,s2
  aa:	00000097          	auipc	ra,0x0
  ae:	45c080e7          	jalr	1116(ra) # 506 <wait>
    if(xstatus != 0) {
  b2:	fbc42783          	lw	a5,-68(s0)
  b6:	d7fd                	beqz	a5,a4 <test0+0xa4>
      if(all_ok == 1)
  b8:	ff4996e3          	bne	s3,s4,a4 <test0+0xa4>
        printf("filetest: FAILED\n");
  bc:	8556                	mv	a0,s5
  be:	00000097          	auipc	ra,0x0
  c2:	7ae080e7          	jalr	1966(ra) # 86c <printf>
      all_ok = 0;
  c6:	4981                	li	s3,0
  c8:	bff1                	j	a4 <test0+0xa4>
    }
  }

  if(all_ok)
  ca:	00099b63          	bnez	s3,e0 <test0+0xe0>
    printf("filetest: OK\n");
}
  ce:	60a6                	ld	ra,72(sp)
  d0:	6406                	ld	s0,64(sp)
  d2:	74e2                	ld	s1,56(sp)
  d4:	7942                	ld	s2,48(sp)
  d6:	79a2                	ld	s3,40(sp)
  d8:	7a02                	ld	s4,32(sp)
  da:	6ae2                	ld	s5,24(sp)
  dc:	6161                	addi	sp,sp,80
  de:	8082                	ret
    printf("filetest: OK\n");
  e0:	00001517          	auipc	a0,0x1
  e4:	99050513          	addi	a0,a0,-1648 # a70 <malloc+0x148>
  e8:	00000097          	auipc	ra,0x0
  ec:	784080e7          	jalr	1924(ra) # 86c <printf>
}
  f0:	bff9                	j	ce <test0+0xce>

00000000000000f2 <test1>:

// Allocate all free memory and count how it is
void test1()
{
  f2:	7139                	addi	sp,sp,-64
  f4:	fc06                	sd	ra,56(sp)
  f6:	f822                	sd	s0,48(sp)
  f8:	0080                	addi	s0,sp,64
  void *a;
  int tot = 0;
  char buf[1];
  int fds[2];
  
  printf("memtest: start\n");  
  fa:	00001517          	auipc	a0,0x1
  fe:	98650513          	addi	a0,a0,-1658 # a80 <malloc+0x158>
 102:	00000097          	auipc	ra,0x0
 106:	76a080e7          	jalr	1898(ra) # 86c <printf>
  if(pipe(fds) != 0){
 10a:	fc040513          	addi	a0,s0,-64
 10e:	00000097          	auipc	ra,0x0
 112:	400080e7          	jalr	1024(ra) # 50e <pipe>
 116:	e92d                	bnez	a0,188 <test1+0x96>
 118:	f426                	sd	s1,40(sp)
 11a:	84aa                	mv	s1,a0
    printf("pipe() failed\n");
    exit(1);
  }
  int pid = fork();
 11c:	00000097          	auipc	ra,0x0
 120:	3da080e7          	jalr	986(ra) # 4f6 <fork>
  if(pid < 0){
 124:	08054363          	bltz	a0,1aa <test1+0xb8>
    printf("fork failed");
    exit(1);
  }
  if(pid == 0){
 128:	e555                	bnez	a0,1d4 <test1+0xe2>
 12a:	f04a                	sd	s2,32(sp)
 12c:	ec4e                	sd	s3,24(sp)
 12e:	e852                	sd	s4,16(sp)
      close(fds[0]);
 130:	fc042503          	lw	a0,-64(s0)
 134:	00000097          	auipc	ra,0x0
 138:	3f2080e7          	jalr	1010(ra) # 526 <close>
      while(1) {
        a = sbrk(PGSIZE);
 13c:	6985                	lui	s3,0x1
        if (a == (char*)0xffffffffffffffffL)
 13e:	597d                	li	s2,-1
          exit(0);
        *(int *)(a+4) = 1;
 140:	4485                	li	s1,1
        if (write(fds[1], "x", 1) != 1) {
 142:	00001a17          	auipc	s4,0x1
 146:	95ea0a13          	addi	s4,s4,-1698 # aa0 <malloc+0x178>
        a = sbrk(PGSIZE);
 14a:	854e                	mv	a0,s3
 14c:	00000097          	auipc	ra,0x0
 150:	43a080e7          	jalr	1082(ra) # 586 <sbrk>
        if (a == (char*)0xffffffffffffffffL)
 154:	07250b63          	beq	a0,s2,1ca <test1+0xd8>
        *(int *)(a+4) = 1;
 158:	c144                	sw	s1,4(a0)
        if (write(fds[1], "x", 1) != 1) {
 15a:	8626                	mv	a2,s1
 15c:	85d2                	mv	a1,s4
 15e:	fc442503          	lw	a0,-60(s0)
 162:	00000097          	auipc	ra,0x0
 166:	3bc080e7          	jalr	956(ra) # 51e <write>
 16a:	fe9500e3          	beq	a0,s1,14a <test1+0x58>
          printf("write failed");
 16e:	00001517          	auipc	a0,0x1
 172:	93a50513          	addi	a0,a0,-1734 # aa8 <malloc+0x180>
 176:	00000097          	auipc	ra,0x0
 17a:	6f6080e7          	jalr	1782(ra) # 86c <printf>
          exit(1);
 17e:	4505                	li	a0,1
 180:	00000097          	auipc	ra,0x0
 184:	37e080e7          	jalr	894(ra) # 4fe <exit>
 188:	f426                	sd	s1,40(sp)
 18a:	f04a                	sd	s2,32(sp)
 18c:	ec4e                	sd	s3,24(sp)
 18e:	e852                	sd	s4,16(sp)
    printf("pipe() failed\n");
 190:	00001517          	auipc	a0,0x1
 194:	90050513          	addi	a0,a0,-1792 # a90 <malloc+0x168>
 198:	00000097          	auipc	ra,0x0
 19c:	6d4080e7          	jalr	1748(ra) # 86c <printf>
    exit(1);
 1a0:	4505                	li	a0,1
 1a2:	00000097          	auipc	ra,0x0
 1a6:	35c080e7          	jalr	860(ra) # 4fe <exit>
 1aa:	f04a                	sd	s2,32(sp)
 1ac:	ec4e                	sd	s3,24(sp)
 1ae:	e852                	sd	s4,16(sp)
    printf("fork failed");
 1b0:	00001517          	auipc	a0,0x1
 1b4:	89050513          	addi	a0,a0,-1904 # a40 <malloc+0x118>
 1b8:	00000097          	auipc	ra,0x0
 1bc:	6b4080e7          	jalr	1716(ra) # 86c <printf>
    exit(1);
 1c0:	4505                	li	a0,1
 1c2:	00000097          	auipc	ra,0x0
 1c6:	33c080e7          	jalr	828(ra) # 4fe <exit>
          exit(0);
 1ca:	4501                	li	a0,0
 1cc:	00000097          	auipc	ra,0x0
 1d0:	332080e7          	jalr	818(ra) # 4fe <exit>
 1d4:	f04a                	sd	s2,32(sp)
 1d6:	ec4e                	sd	s3,24(sp)
        }
      }
      exit(0);
  }
  close(fds[1]);
 1d8:	fc442503          	lw	a0,-60(s0)
 1dc:	00000097          	auipc	ra,0x0
 1e0:	34a080e7          	jalr	842(ra) # 526 <close>
  while(1) {
      if (read(fds[0], buf, 1) != 1) {
 1e4:	fc840993          	addi	s3,s0,-56
 1e8:	4905                	li	s2,1
 1ea:	864a                	mv	a2,s2
 1ec:	85ce                	mv	a1,s3
 1ee:	fc042503          	lw	a0,-64(s0)
 1f2:	00000097          	auipc	ra,0x0
 1f6:	324080e7          	jalr	804(ra) # 516 <read>
 1fa:	01251463          	bne	a0,s2,202 <test1+0x110>
        break;
      } else {
        tot += 1;
 1fe:	2485                	addiw	s1,s1,1
      if (read(fds[0], buf, 1) != 1) {
 200:	b7ed                	j	1ea <test1+0xf8>
      }
  }
  //int n = (PHYSTOP-KERNBASE)/PGSIZE;
  //printf("allocated %d out of %d pages\n", tot, n);
  if(tot < 31950) {
 202:	67a1                	lui	a5,0x8
 204:	ccd78793          	addi	a5,a5,-819 # 7ccd <__global_pointer$+0x6944>
 208:	0297ca63          	blt	a5,s1,23c <test1+0x14a>
    printf("expected to allocate at least 31950, only got %d\n", tot);
 20c:	85a6                	mv	a1,s1
 20e:	00001517          	auipc	a0,0x1
 212:	8aa50513          	addi	a0,a0,-1878 # ab8 <malloc+0x190>
 216:	00000097          	auipc	ra,0x0
 21a:	656080e7          	jalr	1622(ra) # 86c <printf>
    printf("memtest: FAILED\n");  
 21e:	00001517          	auipc	a0,0x1
 222:	8d250513          	addi	a0,a0,-1838 # af0 <malloc+0x1c8>
 226:	00000097          	auipc	ra,0x0
 22a:	646080e7          	jalr	1606(ra) # 86c <printf>
 22e:	74a2                	ld	s1,40(sp)
 230:	7902                	ld	s2,32(sp)
 232:	69e2                	ld	s3,24(sp)
  } else {
    printf("memtest: OK\n");  
  }
}
 234:	70e2                	ld	ra,56(sp)
 236:	7442                	ld	s0,48(sp)
 238:	6121                	addi	sp,sp,64
 23a:	8082                	ret
    printf("memtest: OK\n");  
 23c:	00001517          	auipc	a0,0x1
 240:	8cc50513          	addi	a0,a0,-1844 # b08 <malloc+0x1e0>
 244:	00000097          	auipc	ra,0x0
 248:	628080e7          	jalr	1576(ra) # 86c <printf>
}
 24c:	b7cd                	j	22e <test1+0x13c>

000000000000024e <main>:

int
main(int argc, char *argv[])
{
 24e:	1141                	addi	sp,sp,-16
 250:	e406                	sd	ra,8(sp)
 252:	e022                	sd	s0,0(sp)
 254:	0800                	addi	s0,sp,16
  test0();
 256:	00000097          	auipc	ra,0x0
 25a:	daa080e7          	jalr	-598(ra) # 0 <test0>
  test1();
 25e:	00000097          	auipc	ra,0x0
 262:	e94080e7          	jalr	-364(ra) # f2 <test1>
  exit(0);
 266:	4501                	li	a0,0
 268:	00000097          	auipc	ra,0x0
 26c:	296080e7          	jalr	662(ra) # 4fe <exit>

0000000000000270 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 270:	1141                	addi	sp,sp,-16
 272:	e406                	sd	ra,8(sp)
 274:	e022                	sd	s0,0(sp)
 276:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 278:	87aa                	mv	a5,a0
 27a:	0585                	addi	a1,a1,1
 27c:	0785                	addi	a5,a5,1
 27e:	fff5c703          	lbu	a4,-1(a1)
 282:	fee78fa3          	sb	a4,-1(a5)
 286:	fb75                	bnez	a4,27a <strcpy+0xa>
    ;
  return os;
}
 288:	60a2                	ld	ra,8(sp)
 28a:	6402                	ld	s0,0(sp)
 28c:	0141                	addi	sp,sp,16
 28e:	8082                	ret

0000000000000290 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 290:	1141                	addi	sp,sp,-16
 292:	e406                	sd	ra,8(sp)
 294:	e022                	sd	s0,0(sp)
 296:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 298:	00054783          	lbu	a5,0(a0)
 29c:	cb91                	beqz	a5,2b0 <strcmp+0x20>
 29e:	0005c703          	lbu	a4,0(a1)
 2a2:	00f71763          	bne	a4,a5,2b0 <strcmp+0x20>
    p++, q++;
 2a6:	0505                	addi	a0,a0,1
 2a8:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 2aa:	00054783          	lbu	a5,0(a0)
 2ae:	fbe5                	bnez	a5,29e <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 2b0:	0005c503          	lbu	a0,0(a1)
}
 2b4:	40a7853b          	subw	a0,a5,a0
 2b8:	60a2                	ld	ra,8(sp)
 2ba:	6402                	ld	s0,0(sp)
 2bc:	0141                	addi	sp,sp,16
 2be:	8082                	ret

00000000000002c0 <strlen>:

uint
strlen(const char *s)
{
 2c0:	1141                	addi	sp,sp,-16
 2c2:	e406                	sd	ra,8(sp)
 2c4:	e022                	sd	s0,0(sp)
 2c6:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 2c8:	00054783          	lbu	a5,0(a0)
 2cc:	cf91                	beqz	a5,2e8 <strlen+0x28>
 2ce:	00150793          	addi	a5,a0,1
 2d2:	86be                	mv	a3,a5
 2d4:	0785                	addi	a5,a5,1
 2d6:	fff7c703          	lbu	a4,-1(a5)
 2da:	ff65                	bnez	a4,2d2 <strlen+0x12>
 2dc:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
 2e0:	60a2                	ld	ra,8(sp)
 2e2:	6402                	ld	s0,0(sp)
 2e4:	0141                	addi	sp,sp,16
 2e6:	8082                	ret
  for(n = 0; s[n]; n++)
 2e8:	4501                	li	a0,0
 2ea:	bfdd                	j	2e0 <strlen+0x20>

00000000000002ec <memset>:

void*
memset(void *dst, int c, uint n)
{
 2ec:	1141                	addi	sp,sp,-16
 2ee:	e406                	sd	ra,8(sp)
 2f0:	e022                	sd	s0,0(sp)
 2f2:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 2f4:	ca19                	beqz	a2,30a <memset+0x1e>
 2f6:	87aa                	mv	a5,a0
 2f8:	1602                	slli	a2,a2,0x20
 2fa:	9201                	srli	a2,a2,0x20
 2fc:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 300:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 304:	0785                	addi	a5,a5,1
 306:	fee79de3          	bne	a5,a4,300 <memset+0x14>
  }
  return dst;
}
 30a:	60a2                	ld	ra,8(sp)
 30c:	6402                	ld	s0,0(sp)
 30e:	0141                	addi	sp,sp,16
 310:	8082                	ret

0000000000000312 <strchr>:

char*
strchr(const char *s, char c)
{
 312:	1141                	addi	sp,sp,-16
 314:	e406                	sd	ra,8(sp)
 316:	e022                	sd	s0,0(sp)
 318:	0800                	addi	s0,sp,16
  for(; *s; s++)
 31a:	00054783          	lbu	a5,0(a0)
 31e:	cf81                	beqz	a5,336 <strchr+0x24>
    if(*s == c)
 320:	00f58763          	beq	a1,a5,32e <strchr+0x1c>
  for(; *s; s++)
 324:	0505                	addi	a0,a0,1
 326:	00054783          	lbu	a5,0(a0)
 32a:	fbfd                	bnez	a5,320 <strchr+0xe>
      return (char*)s;
  return 0;
 32c:	4501                	li	a0,0
}
 32e:	60a2                	ld	ra,8(sp)
 330:	6402                	ld	s0,0(sp)
 332:	0141                	addi	sp,sp,16
 334:	8082                	ret
  return 0;
 336:	4501                	li	a0,0
 338:	bfdd                	j	32e <strchr+0x1c>

000000000000033a <gets>:

char*
gets(char *buf, int max)
{
 33a:	711d                	addi	sp,sp,-96
 33c:	ec86                	sd	ra,88(sp)
 33e:	e8a2                	sd	s0,80(sp)
 340:	e4a6                	sd	s1,72(sp)
 342:	e0ca                	sd	s2,64(sp)
 344:	fc4e                	sd	s3,56(sp)
 346:	f852                	sd	s4,48(sp)
 348:	f456                	sd	s5,40(sp)
 34a:	f05a                	sd	s6,32(sp)
 34c:	ec5e                	sd	s7,24(sp)
 34e:	e862                	sd	s8,16(sp)
 350:	1080                	addi	s0,sp,96
 352:	8baa                	mv	s7,a0
 354:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 356:	892a                	mv	s2,a0
 358:	4481                	li	s1,0
    cc = read(0, &c, 1);
 35a:	faf40b13          	addi	s6,s0,-81
 35e:	4a85                	li	s5,1
  for(i=0; i+1 < max; ){
 360:	8c26                	mv	s8,s1
 362:	0014899b          	addiw	s3,s1,1
 366:	84ce                	mv	s1,s3
 368:	0349d663          	bge	s3,s4,394 <gets+0x5a>
    cc = read(0, &c, 1);
 36c:	8656                	mv	a2,s5
 36e:	85da                	mv	a1,s6
 370:	4501                	li	a0,0
 372:	00000097          	auipc	ra,0x0
 376:	1a4080e7          	jalr	420(ra) # 516 <read>
    if(cc < 1)
 37a:	00a05d63          	blez	a0,394 <gets+0x5a>
      break;
    buf[i++] = c;
 37e:	faf44783          	lbu	a5,-81(s0)
 382:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 386:	0905                	addi	s2,s2,1
 388:	ff678713          	addi	a4,a5,-10
 38c:	c319                	beqz	a4,392 <gets+0x58>
 38e:	17cd                	addi	a5,a5,-13
 390:	fbe1                	bnez	a5,360 <gets+0x26>
    buf[i++] = c;
 392:	8c4e                	mv	s8,s3
      break;
  }
  buf[i] = '\0';
 394:	9c5e                	add	s8,s8,s7
 396:	000c0023          	sb	zero,0(s8)
  return buf;
}
 39a:	855e                	mv	a0,s7
 39c:	60e6                	ld	ra,88(sp)
 39e:	6446                	ld	s0,80(sp)
 3a0:	64a6                	ld	s1,72(sp)
 3a2:	6906                	ld	s2,64(sp)
 3a4:	79e2                	ld	s3,56(sp)
 3a6:	7a42                	ld	s4,48(sp)
 3a8:	7aa2                	ld	s5,40(sp)
 3aa:	7b02                	ld	s6,32(sp)
 3ac:	6be2                	ld	s7,24(sp)
 3ae:	6c42                	ld	s8,16(sp)
 3b0:	6125                	addi	sp,sp,96
 3b2:	8082                	ret

00000000000003b4 <stat>:

int
stat(const char *n, struct stat *st)
{
 3b4:	1101                	addi	sp,sp,-32
 3b6:	ec06                	sd	ra,24(sp)
 3b8:	e822                	sd	s0,16(sp)
 3ba:	e04a                	sd	s2,0(sp)
 3bc:	1000                	addi	s0,sp,32
 3be:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3c0:	4581                	li	a1,0
 3c2:	00000097          	auipc	ra,0x0
 3c6:	17c080e7          	jalr	380(ra) # 53e <open>
  if(fd < 0)
 3ca:	02054663          	bltz	a0,3f6 <stat+0x42>
 3ce:	e426                	sd	s1,8(sp)
 3d0:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 3d2:	85ca                	mv	a1,s2
 3d4:	00000097          	auipc	ra,0x0
 3d8:	182080e7          	jalr	386(ra) # 556 <fstat>
 3dc:	892a                	mv	s2,a0
  close(fd);
 3de:	8526                	mv	a0,s1
 3e0:	00000097          	auipc	ra,0x0
 3e4:	146080e7          	jalr	326(ra) # 526 <close>
  return r;
 3e8:	64a2                	ld	s1,8(sp)
}
 3ea:	854a                	mv	a0,s2
 3ec:	60e2                	ld	ra,24(sp)
 3ee:	6442                	ld	s0,16(sp)
 3f0:	6902                	ld	s2,0(sp)
 3f2:	6105                	addi	sp,sp,32
 3f4:	8082                	ret
    return -1;
 3f6:	57fd                	li	a5,-1
 3f8:	893e                	mv	s2,a5
 3fa:	bfc5                	j	3ea <stat+0x36>

00000000000003fc <atoi>:

int
atoi(const char *s)
{
 3fc:	1141                	addi	sp,sp,-16
 3fe:	e406                	sd	ra,8(sp)
 400:	e022                	sd	s0,0(sp)
 402:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 404:	00054683          	lbu	a3,0(a0)
 408:	fd06879b          	addiw	a5,a3,-48
 40c:	0ff7f793          	zext.b	a5,a5
 410:	4625                	li	a2,9
 412:	02f66963          	bltu	a2,a5,444 <atoi+0x48>
 416:	872a                	mv	a4,a0
  n = 0;
 418:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 41a:	0705                	addi	a4,a4,1
 41c:	0025179b          	slliw	a5,a0,0x2
 420:	9fa9                	addw	a5,a5,a0
 422:	0017979b          	slliw	a5,a5,0x1
 426:	9fb5                	addw	a5,a5,a3
 428:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 42c:	00074683          	lbu	a3,0(a4)
 430:	fd06879b          	addiw	a5,a3,-48
 434:	0ff7f793          	zext.b	a5,a5
 438:	fef671e3          	bgeu	a2,a5,41a <atoi+0x1e>
  return n;
}
 43c:	60a2                	ld	ra,8(sp)
 43e:	6402                	ld	s0,0(sp)
 440:	0141                	addi	sp,sp,16
 442:	8082                	ret
  n = 0;
 444:	4501                	li	a0,0
 446:	bfdd                	j	43c <atoi+0x40>

0000000000000448 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 448:	1141                	addi	sp,sp,-16
 44a:	e406                	sd	ra,8(sp)
 44c:	e022                	sd	s0,0(sp)
 44e:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 450:	02b57563          	bgeu	a0,a1,47a <memmove+0x32>
    while(n-- > 0)
 454:	00c05f63          	blez	a2,472 <memmove+0x2a>
 458:	1602                	slli	a2,a2,0x20
 45a:	9201                	srli	a2,a2,0x20
 45c:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 460:	872a                	mv	a4,a0
      *dst++ = *src++;
 462:	0585                	addi	a1,a1,1
 464:	0705                	addi	a4,a4,1
 466:	fff5c683          	lbu	a3,-1(a1)
 46a:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 46e:	fee79ae3          	bne	a5,a4,462 <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 472:	60a2                	ld	ra,8(sp)
 474:	6402                	ld	s0,0(sp)
 476:	0141                	addi	sp,sp,16
 478:	8082                	ret
    while(n-- > 0)
 47a:	fec05ce3          	blez	a2,472 <memmove+0x2a>
    dst += n;
 47e:	00c50733          	add	a4,a0,a2
    src += n;
 482:	95b2                	add	a1,a1,a2
 484:	fff6079b          	addiw	a5,a2,-1
 488:	1782                	slli	a5,a5,0x20
 48a:	9381                	srli	a5,a5,0x20
 48c:	fff7c793          	not	a5,a5
 490:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 492:	15fd                	addi	a1,a1,-1
 494:	177d                	addi	a4,a4,-1
 496:	0005c683          	lbu	a3,0(a1)
 49a:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 49e:	fef71ae3          	bne	a4,a5,492 <memmove+0x4a>
 4a2:	bfc1                	j	472 <memmove+0x2a>

00000000000004a4 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 4a4:	1141                	addi	sp,sp,-16
 4a6:	e406                	sd	ra,8(sp)
 4a8:	e022                	sd	s0,0(sp)
 4aa:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 4ac:	c61d                	beqz	a2,4da <memcmp+0x36>
 4ae:	1602                	slli	a2,a2,0x20
 4b0:	9201                	srli	a2,a2,0x20
 4b2:	00c506b3          	add	a3,a0,a2
    if (*p1 != *p2) {
 4b6:	00054783          	lbu	a5,0(a0)
 4ba:	0005c703          	lbu	a4,0(a1)
 4be:	00e79863          	bne	a5,a4,4ce <memcmp+0x2a>
      return *p1 - *p2;
    }
    p1++;
 4c2:	0505                	addi	a0,a0,1
    p2++;
 4c4:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 4c6:	fed518e3          	bne	a0,a3,4b6 <memcmp+0x12>
  }
  return 0;
 4ca:	4501                	li	a0,0
 4cc:	a019                	j	4d2 <memcmp+0x2e>
      return *p1 - *p2;
 4ce:	40e7853b          	subw	a0,a5,a4
}
 4d2:	60a2                	ld	ra,8(sp)
 4d4:	6402                	ld	s0,0(sp)
 4d6:	0141                	addi	sp,sp,16
 4d8:	8082                	ret
  return 0;
 4da:	4501                	li	a0,0
 4dc:	bfdd                	j	4d2 <memcmp+0x2e>

00000000000004de <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 4de:	1141                	addi	sp,sp,-16
 4e0:	e406                	sd	ra,8(sp)
 4e2:	e022                	sd	s0,0(sp)
 4e4:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 4e6:	00000097          	auipc	ra,0x0
 4ea:	f62080e7          	jalr	-158(ra) # 448 <memmove>
}
 4ee:	60a2                	ld	ra,8(sp)
 4f0:	6402                	ld	s0,0(sp)
 4f2:	0141                	addi	sp,sp,16
 4f4:	8082                	ret

00000000000004f6 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 4f6:	4885                	li	a7,1
 ecall
 4f8:	00000073          	ecall
 ret
 4fc:	8082                	ret

00000000000004fe <exit>:
.global exit
exit:
 li a7, SYS_exit
 4fe:	4889                	li	a7,2
 ecall
 500:	00000073          	ecall
 ret
 504:	8082                	ret

0000000000000506 <wait>:
.global wait
wait:
 li a7, SYS_wait
 506:	488d                	li	a7,3
 ecall
 508:	00000073          	ecall
 ret
 50c:	8082                	ret

000000000000050e <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 50e:	4891                	li	a7,4
 ecall
 510:	00000073          	ecall
 ret
 514:	8082                	ret

0000000000000516 <read>:
.global read
read:
 li a7, SYS_read
 516:	4895                	li	a7,5
 ecall
 518:	00000073          	ecall
 ret
 51c:	8082                	ret

000000000000051e <write>:
.global write
write:
 li a7, SYS_write
 51e:	48c1                	li	a7,16
 ecall
 520:	00000073          	ecall
 ret
 524:	8082                	ret

0000000000000526 <close>:
.global close
close:
 li a7, SYS_close
 526:	48d5                	li	a7,21
 ecall
 528:	00000073          	ecall
 ret
 52c:	8082                	ret

000000000000052e <kill>:
.global kill
kill:
 li a7, SYS_kill
 52e:	4899                	li	a7,6
 ecall
 530:	00000073          	ecall
 ret
 534:	8082                	ret

0000000000000536 <exec>:
.global exec
exec:
 li a7, SYS_exec
 536:	489d                	li	a7,7
 ecall
 538:	00000073          	ecall
 ret
 53c:	8082                	ret

000000000000053e <open>:
.global open
open:
 li a7, SYS_open
 53e:	48bd                	li	a7,15
 ecall
 540:	00000073          	ecall
 ret
 544:	8082                	ret

0000000000000546 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 546:	48c5                	li	a7,17
 ecall
 548:	00000073          	ecall
 ret
 54c:	8082                	ret

000000000000054e <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 54e:	48c9                	li	a7,18
 ecall
 550:	00000073          	ecall
 ret
 554:	8082                	ret

0000000000000556 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 556:	48a1                	li	a7,8
 ecall
 558:	00000073          	ecall
 ret
 55c:	8082                	ret

000000000000055e <link>:
.global link
link:
 li a7, SYS_link
 55e:	48cd                	li	a7,19
 ecall
 560:	00000073          	ecall
 ret
 564:	8082                	ret

0000000000000566 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 566:	48d1                	li	a7,20
 ecall
 568:	00000073          	ecall
 ret
 56c:	8082                	ret

000000000000056e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 56e:	48a5                	li	a7,9
 ecall
 570:	00000073          	ecall
 ret
 574:	8082                	ret

0000000000000576 <dup>:
.global dup
dup:
 li a7, SYS_dup
 576:	48a9                	li	a7,10
 ecall
 578:	00000073          	ecall
 ret
 57c:	8082                	ret

000000000000057e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 57e:	48ad                	li	a7,11
 ecall
 580:	00000073          	ecall
 ret
 584:	8082                	ret

0000000000000586 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 586:	48b1                	li	a7,12
 ecall
 588:	00000073          	ecall
 ret
 58c:	8082                	ret

000000000000058e <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 58e:	48b5                	li	a7,13
 ecall
 590:	00000073          	ecall
 ret
 594:	8082                	ret

0000000000000596 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 596:	48b9                	li	a7,14
 ecall
 598:	00000073          	ecall
 ret
 59c:	8082                	ret

000000000000059e <ntas>:
.global ntas
ntas:
 li a7, SYS_ntas
 59e:	48d9                	li	a7,22
 ecall
 5a0:	00000073          	ecall
 ret
 5a4:	8082                	ret

00000000000005a6 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 5a6:	1101                	addi	sp,sp,-32
 5a8:	ec06                	sd	ra,24(sp)
 5aa:	e822                	sd	s0,16(sp)
 5ac:	1000                	addi	s0,sp,32
 5ae:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 5b2:	4605                	li	a2,1
 5b4:	fef40593          	addi	a1,s0,-17
 5b8:	00000097          	auipc	ra,0x0
 5bc:	f66080e7          	jalr	-154(ra) # 51e <write>
}
 5c0:	60e2                	ld	ra,24(sp)
 5c2:	6442                	ld	s0,16(sp)
 5c4:	6105                	addi	sp,sp,32
 5c6:	8082                	ret

00000000000005c8 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 5c8:	7139                	addi	sp,sp,-64
 5ca:	fc06                	sd	ra,56(sp)
 5cc:	f822                	sd	s0,48(sp)
 5ce:	f04a                	sd	s2,32(sp)
 5d0:	ec4e                	sd	s3,24(sp)
 5d2:	0080                	addi	s0,sp,64
 5d4:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 5d6:	cad9                	beqz	a3,66c <printint+0xa4>
 5d8:	01f5d79b          	srliw	a5,a1,0x1f
 5dc:	cbc1                	beqz	a5,66c <printint+0xa4>
    neg = 1;
    x = -xx;
 5de:	40b005bb          	negw	a1,a1
    neg = 1;
 5e2:	4305                	li	t1,1
  } else {
    x = xx;
  }

  i = 0;
 5e4:	fc040993          	addi	s3,s0,-64
  neg = 0;
 5e8:	86ce                	mv	a3,s3
  i = 0;
 5ea:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 5ec:	00000817          	auipc	a6,0x0
 5f0:	58c80813          	addi	a6,a6,1420 # b78 <digits>
 5f4:	88ba                	mv	a7,a4
 5f6:	0017051b          	addiw	a0,a4,1
 5fa:	872a                	mv	a4,a0
 5fc:	02c5f7bb          	remuw	a5,a1,a2
 600:	1782                	slli	a5,a5,0x20
 602:	9381                	srli	a5,a5,0x20
 604:	97c2                	add	a5,a5,a6
 606:	0007c783          	lbu	a5,0(a5)
 60a:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 60e:	87ae                	mv	a5,a1
 610:	02c5d5bb          	divuw	a1,a1,a2
 614:	0685                	addi	a3,a3,1
 616:	fcc7ffe3          	bgeu	a5,a2,5f4 <printint+0x2c>
  if(neg)
 61a:	00030c63          	beqz	t1,632 <printint+0x6a>
    buf[i++] = '-';
 61e:	fd050793          	addi	a5,a0,-48
 622:	00878533          	add	a0,a5,s0
 626:	02d00793          	li	a5,45
 62a:	fef50823          	sb	a5,-16(a0)
 62e:	0028871b          	addiw	a4,a7,2

  while(--i >= 0)
 632:	02e05763          	blez	a4,660 <printint+0x98>
 636:	f426                	sd	s1,40(sp)
 638:	377d                	addiw	a4,a4,-1
 63a:	00e984b3          	add	s1,s3,a4
 63e:	19fd                	addi	s3,s3,-1 # fff <__BSS_END__+0x457>
 640:	99ba                	add	s3,s3,a4
 642:	1702                	slli	a4,a4,0x20
 644:	9301                	srli	a4,a4,0x20
 646:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 64a:	0004c583          	lbu	a1,0(s1)
 64e:	854a                	mv	a0,s2
 650:	00000097          	auipc	ra,0x0
 654:	f56080e7          	jalr	-170(ra) # 5a6 <putc>
  while(--i >= 0)
 658:	14fd                	addi	s1,s1,-1
 65a:	ff3498e3          	bne	s1,s3,64a <printint+0x82>
 65e:	74a2                	ld	s1,40(sp)
}
 660:	70e2                	ld	ra,56(sp)
 662:	7442                	ld	s0,48(sp)
 664:	7902                	ld	s2,32(sp)
 666:	69e2                	ld	s3,24(sp)
 668:	6121                	addi	sp,sp,64
 66a:	8082                	ret
  neg = 0;
 66c:	4301                	li	t1,0
 66e:	bf9d                	j	5e4 <printint+0x1c>

0000000000000670 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 670:	715d                	addi	sp,sp,-80
 672:	e486                	sd	ra,72(sp)
 674:	e0a2                	sd	s0,64(sp)
 676:	f84a                	sd	s2,48(sp)
 678:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 67a:	0005c903          	lbu	s2,0(a1)
 67e:	1a090b63          	beqz	s2,834 <vprintf+0x1c4>
 682:	fc26                	sd	s1,56(sp)
 684:	f44e                	sd	s3,40(sp)
 686:	f052                	sd	s4,32(sp)
 688:	ec56                	sd	s5,24(sp)
 68a:	e85a                	sd	s6,16(sp)
 68c:	e45e                	sd	s7,8(sp)
 68e:	8aaa                	mv	s5,a0
 690:	8bb2                	mv	s7,a2
 692:	00158493          	addi	s1,a1,1
  state = 0;
 696:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 698:	02500a13          	li	s4,37
 69c:	4b55                	li	s6,21
 69e:	a839                	j	6bc <vprintf+0x4c>
        putc(fd, c);
 6a0:	85ca                	mv	a1,s2
 6a2:	8556                	mv	a0,s5
 6a4:	00000097          	auipc	ra,0x0
 6a8:	f02080e7          	jalr	-254(ra) # 5a6 <putc>
 6ac:	a019                	j	6b2 <vprintf+0x42>
    } else if(state == '%'){
 6ae:	01498d63          	beq	s3,s4,6c8 <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
 6b2:	0485                	addi	s1,s1,1
 6b4:	fff4c903          	lbu	s2,-1(s1)
 6b8:	16090863          	beqz	s2,828 <vprintf+0x1b8>
    if(state == 0){
 6bc:	fe0999e3          	bnez	s3,6ae <vprintf+0x3e>
      if(c == '%'){
 6c0:	ff4910e3          	bne	s2,s4,6a0 <vprintf+0x30>
        state = '%';
 6c4:	89d2                	mv	s3,s4
 6c6:	b7f5                	j	6b2 <vprintf+0x42>
      if(c == 'd'){
 6c8:	13490563          	beq	s2,s4,7f2 <vprintf+0x182>
 6cc:	f9d9079b          	addiw	a5,s2,-99
 6d0:	0ff7f793          	zext.b	a5,a5
 6d4:	12fb6863          	bltu	s6,a5,804 <vprintf+0x194>
 6d8:	f9d9079b          	addiw	a5,s2,-99
 6dc:	0ff7f713          	zext.b	a4,a5
 6e0:	12eb6263          	bltu	s6,a4,804 <vprintf+0x194>
 6e4:	00271793          	slli	a5,a4,0x2
 6e8:	00000717          	auipc	a4,0x0
 6ec:	43870713          	addi	a4,a4,1080 # b20 <malloc+0x1f8>
 6f0:	97ba                	add	a5,a5,a4
 6f2:	439c                	lw	a5,0(a5)
 6f4:	97ba                	add	a5,a5,a4
 6f6:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 6f8:	008b8913          	addi	s2,s7,8
 6fc:	4685                	li	a3,1
 6fe:	4629                	li	a2,10
 700:	000ba583          	lw	a1,0(s7)
 704:	8556                	mv	a0,s5
 706:	00000097          	auipc	ra,0x0
 70a:	ec2080e7          	jalr	-318(ra) # 5c8 <printint>
 70e:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 710:	4981                	li	s3,0
 712:	b745                	j	6b2 <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
 714:	008b8913          	addi	s2,s7,8
 718:	4681                	li	a3,0
 71a:	4629                	li	a2,10
 71c:	000ba583          	lw	a1,0(s7)
 720:	8556                	mv	a0,s5
 722:	00000097          	auipc	ra,0x0
 726:	ea6080e7          	jalr	-346(ra) # 5c8 <printint>
 72a:	8bca                	mv	s7,s2
      state = 0;
 72c:	4981                	li	s3,0
 72e:	b751                	j	6b2 <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
 730:	008b8913          	addi	s2,s7,8
 734:	4681                	li	a3,0
 736:	4641                	li	a2,16
 738:	000ba583          	lw	a1,0(s7)
 73c:	8556                	mv	a0,s5
 73e:	00000097          	auipc	ra,0x0
 742:	e8a080e7          	jalr	-374(ra) # 5c8 <printint>
 746:	8bca                	mv	s7,s2
      state = 0;
 748:	4981                	li	s3,0
 74a:	b7a5                	j	6b2 <vprintf+0x42>
 74c:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
 74e:	008b8793          	addi	a5,s7,8
 752:	8c3e                	mv	s8,a5
 754:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 758:	03000593          	li	a1,48
 75c:	8556                	mv	a0,s5
 75e:	00000097          	auipc	ra,0x0
 762:	e48080e7          	jalr	-440(ra) # 5a6 <putc>
  putc(fd, 'x');
 766:	07800593          	li	a1,120
 76a:	8556                	mv	a0,s5
 76c:	00000097          	auipc	ra,0x0
 770:	e3a080e7          	jalr	-454(ra) # 5a6 <putc>
 774:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 776:	00000b97          	auipc	s7,0x0
 77a:	402b8b93          	addi	s7,s7,1026 # b78 <digits>
 77e:	03c9d793          	srli	a5,s3,0x3c
 782:	97de                	add	a5,a5,s7
 784:	0007c583          	lbu	a1,0(a5)
 788:	8556                	mv	a0,s5
 78a:	00000097          	auipc	ra,0x0
 78e:	e1c080e7          	jalr	-484(ra) # 5a6 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 792:	0992                	slli	s3,s3,0x4
 794:	397d                	addiw	s2,s2,-1
 796:	fe0914e3          	bnez	s2,77e <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
 79a:	8be2                	mv	s7,s8
      state = 0;
 79c:	4981                	li	s3,0
 79e:	6c02                	ld	s8,0(sp)
 7a0:	bf09                	j	6b2 <vprintf+0x42>
        s = va_arg(ap, char*);
 7a2:	008b8993          	addi	s3,s7,8
 7a6:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 7aa:	02090163          	beqz	s2,7cc <vprintf+0x15c>
        while(*s != 0){
 7ae:	00094583          	lbu	a1,0(s2)
 7b2:	c9a5                	beqz	a1,822 <vprintf+0x1b2>
          putc(fd, *s);
 7b4:	8556                	mv	a0,s5
 7b6:	00000097          	auipc	ra,0x0
 7ba:	df0080e7          	jalr	-528(ra) # 5a6 <putc>
          s++;
 7be:	0905                	addi	s2,s2,1
        while(*s != 0){
 7c0:	00094583          	lbu	a1,0(s2)
 7c4:	f9e5                	bnez	a1,7b4 <vprintf+0x144>
        s = va_arg(ap, char*);
 7c6:	8bce                	mv	s7,s3
      state = 0;
 7c8:	4981                	li	s3,0
 7ca:	b5e5                	j	6b2 <vprintf+0x42>
          s = "(null)";
 7cc:	00000917          	auipc	s2,0x0
 7d0:	34c90913          	addi	s2,s2,844 # b18 <malloc+0x1f0>
        while(*s != 0){
 7d4:	02800593          	li	a1,40
 7d8:	bff1                	j	7b4 <vprintf+0x144>
        putc(fd, va_arg(ap, uint));
 7da:	008b8913          	addi	s2,s7,8
 7de:	000bc583          	lbu	a1,0(s7)
 7e2:	8556                	mv	a0,s5
 7e4:	00000097          	auipc	ra,0x0
 7e8:	dc2080e7          	jalr	-574(ra) # 5a6 <putc>
 7ec:	8bca                	mv	s7,s2
      state = 0;
 7ee:	4981                	li	s3,0
 7f0:	b5c9                	j	6b2 <vprintf+0x42>
        putc(fd, c);
 7f2:	02500593          	li	a1,37
 7f6:	8556                	mv	a0,s5
 7f8:	00000097          	auipc	ra,0x0
 7fc:	dae080e7          	jalr	-594(ra) # 5a6 <putc>
      state = 0;
 800:	4981                	li	s3,0
 802:	bd45                	j	6b2 <vprintf+0x42>
        putc(fd, '%');
 804:	02500593          	li	a1,37
 808:	8556                	mv	a0,s5
 80a:	00000097          	auipc	ra,0x0
 80e:	d9c080e7          	jalr	-612(ra) # 5a6 <putc>
        putc(fd, c);
 812:	85ca                	mv	a1,s2
 814:	8556                	mv	a0,s5
 816:	00000097          	auipc	ra,0x0
 81a:	d90080e7          	jalr	-624(ra) # 5a6 <putc>
      state = 0;
 81e:	4981                	li	s3,0
 820:	bd49                	j	6b2 <vprintf+0x42>
        s = va_arg(ap, char*);
 822:	8bce                	mv	s7,s3
      state = 0;
 824:	4981                	li	s3,0
 826:	b571                	j	6b2 <vprintf+0x42>
 828:	74e2                	ld	s1,56(sp)
 82a:	79a2                	ld	s3,40(sp)
 82c:	7a02                	ld	s4,32(sp)
 82e:	6ae2                	ld	s5,24(sp)
 830:	6b42                	ld	s6,16(sp)
 832:	6ba2                	ld	s7,8(sp)
    }
  }
}
 834:	60a6                	ld	ra,72(sp)
 836:	6406                	ld	s0,64(sp)
 838:	7942                	ld	s2,48(sp)
 83a:	6161                	addi	sp,sp,80
 83c:	8082                	ret

000000000000083e <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 83e:	715d                	addi	sp,sp,-80
 840:	ec06                	sd	ra,24(sp)
 842:	e822                	sd	s0,16(sp)
 844:	1000                	addi	s0,sp,32
 846:	e010                	sd	a2,0(s0)
 848:	e414                	sd	a3,8(s0)
 84a:	e818                	sd	a4,16(s0)
 84c:	ec1c                	sd	a5,24(s0)
 84e:	03043023          	sd	a6,32(s0)
 852:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 856:	8622                	mv	a2,s0
 858:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 85c:	00000097          	auipc	ra,0x0
 860:	e14080e7          	jalr	-492(ra) # 670 <vprintf>
}
 864:	60e2                	ld	ra,24(sp)
 866:	6442                	ld	s0,16(sp)
 868:	6161                	addi	sp,sp,80
 86a:	8082                	ret

000000000000086c <printf>:

void
printf(const char *fmt, ...)
{
 86c:	711d                	addi	sp,sp,-96
 86e:	ec06                	sd	ra,24(sp)
 870:	e822                	sd	s0,16(sp)
 872:	1000                	addi	s0,sp,32
 874:	e40c                	sd	a1,8(s0)
 876:	e810                	sd	a2,16(s0)
 878:	ec14                	sd	a3,24(s0)
 87a:	f018                	sd	a4,32(s0)
 87c:	f41c                	sd	a5,40(s0)
 87e:	03043823          	sd	a6,48(s0)
 882:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 886:	00840613          	addi	a2,s0,8
 88a:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 88e:	85aa                	mv	a1,a0
 890:	4505                	li	a0,1
 892:	00000097          	auipc	ra,0x0
 896:	dde080e7          	jalr	-546(ra) # 670 <vprintf>
}
 89a:	60e2                	ld	ra,24(sp)
 89c:	6442                	ld	s0,16(sp)
 89e:	6125                	addi	sp,sp,96
 8a0:	8082                	ret

00000000000008a2 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8a2:	1141                	addi	sp,sp,-16
 8a4:	e406                	sd	ra,8(sp)
 8a6:	e022                	sd	s0,0(sp)
 8a8:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 8aa:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8ae:	00000797          	auipc	a5,0x0
 8b2:	2e27b783          	ld	a5,738(a5) # b90 <freep>
 8b6:	a039                	j	8c4 <free+0x22>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8b8:	6398                	ld	a4,0(a5)
 8ba:	00e7e463          	bltu	a5,a4,8c2 <free+0x20>
 8be:	00e6ea63          	bltu	a3,a4,8d2 <free+0x30>
{
 8c2:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8c4:	fed7fae3          	bgeu	a5,a3,8b8 <free+0x16>
 8c8:	6398                	ld	a4,0(a5)
 8ca:	00e6e463          	bltu	a3,a4,8d2 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8ce:	fee7eae3          	bltu	a5,a4,8c2 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 8d2:	ff852583          	lw	a1,-8(a0)
 8d6:	6390                	ld	a2,0(a5)
 8d8:	02059813          	slli	a6,a1,0x20
 8dc:	01c85713          	srli	a4,a6,0x1c
 8e0:	9736                	add	a4,a4,a3
 8e2:	02e60563          	beq	a2,a4,90c <free+0x6a>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 8e6:	fec53823          	sd	a2,-16(a0)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 8ea:	4790                	lw	a2,8(a5)
 8ec:	02061593          	slli	a1,a2,0x20
 8f0:	01c5d713          	srli	a4,a1,0x1c
 8f4:	973e                	add	a4,a4,a5
 8f6:	02e68263          	beq	a3,a4,91a <free+0x78>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 8fa:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 8fc:	00000717          	auipc	a4,0x0
 900:	28f73a23          	sd	a5,660(a4) # b90 <freep>
}
 904:	60a2                	ld	ra,8(sp)
 906:	6402                	ld	s0,0(sp)
 908:	0141                	addi	sp,sp,16
 90a:	8082                	ret
    bp->s.size += p->s.ptr->s.size;
 90c:	4618                	lw	a4,8(a2)
 90e:	9f2d                	addw	a4,a4,a1
 910:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 914:	6398                	ld	a4,0(a5)
 916:	6310                	ld	a2,0(a4)
 918:	b7f9                	j	8e6 <free+0x44>
    p->s.size += bp->s.size;
 91a:	ff852703          	lw	a4,-8(a0)
 91e:	9f31                	addw	a4,a4,a2
 920:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 922:	ff053683          	ld	a3,-16(a0)
 926:	bfd1                	j	8fa <free+0x58>

0000000000000928 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 928:	7139                	addi	sp,sp,-64
 92a:	fc06                	sd	ra,56(sp)
 92c:	f822                	sd	s0,48(sp)
 92e:	f04a                	sd	s2,32(sp)
 930:	ec4e                	sd	s3,24(sp)
 932:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 934:	02051993          	slli	s3,a0,0x20
 938:	0209d993          	srli	s3,s3,0x20
 93c:	09bd                	addi	s3,s3,15
 93e:	0049d993          	srli	s3,s3,0x4
 942:	2985                	addiw	s3,s3,1
 944:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 946:	00000517          	auipc	a0,0x0
 94a:	24a53503          	ld	a0,586(a0) # b90 <freep>
 94e:	c905                	beqz	a0,97e <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 950:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 952:	4798                	lw	a4,8(a5)
 954:	09377a63          	bgeu	a4,s3,9e8 <malloc+0xc0>
 958:	f426                	sd	s1,40(sp)
 95a:	e852                	sd	s4,16(sp)
 95c:	e456                	sd	s5,8(sp)
 95e:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 960:	8a4e                	mv	s4,s3
 962:	6705                	lui	a4,0x1
 964:	00e9f363          	bgeu	s3,a4,96a <malloc+0x42>
 968:	6a05                	lui	s4,0x1
 96a:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 96e:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 972:	00000497          	auipc	s1,0x0
 976:	21e48493          	addi	s1,s1,542 # b90 <freep>
  if(p == (char*)-1)
 97a:	5afd                	li	s5,-1
 97c:	a089                	j	9be <malloc+0x96>
 97e:	f426                	sd	s1,40(sp)
 980:	e852                	sd	s4,16(sp)
 982:	e456                	sd	s5,8(sp)
 984:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 986:	00000797          	auipc	a5,0x0
 98a:	21278793          	addi	a5,a5,530 # b98 <base>
 98e:	00000717          	auipc	a4,0x0
 992:	20f73123          	sd	a5,514(a4) # b90 <freep>
 996:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 998:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 99c:	b7d1                	j	960 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 99e:	6398                	ld	a4,0(a5)
 9a0:	e118                	sd	a4,0(a0)
 9a2:	a8b9                	j	a00 <malloc+0xd8>
  hp->s.size = nu;
 9a4:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 9a8:	0541                	addi	a0,a0,16
 9aa:	00000097          	auipc	ra,0x0
 9ae:	ef8080e7          	jalr	-264(ra) # 8a2 <free>
  return freep;
 9b2:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 9b4:	c135                	beqz	a0,a18 <malloc+0xf0>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9b6:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9b8:	4798                	lw	a4,8(a5)
 9ba:	03277363          	bgeu	a4,s2,9e0 <malloc+0xb8>
    if(p == freep)
 9be:	6098                	ld	a4,0(s1)
 9c0:	853e                	mv	a0,a5
 9c2:	fef71ae3          	bne	a4,a5,9b6 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 9c6:	8552                	mv	a0,s4
 9c8:	00000097          	auipc	ra,0x0
 9cc:	bbe080e7          	jalr	-1090(ra) # 586 <sbrk>
  if(p == (char*)-1)
 9d0:	fd551ae3          	bne	a0,s5,9a4 <malloc+0x7c>
        return 0;
 9d4:	4501                	li	a0,0
 9d6:	74a2                	ld	s1,40(sp)
 9d8:	6a42                	ld	s4,16(sp)
 9da:	6aa2                	ld	s5,8(sp)
 9dc:	6b02                	ld	s6,0(sp)
 9de:	a03d                	j	a0c <malloc+0xe4>
 9e0:	74a2                	ld	s1,40(sp)
 9e2:	6a42                	ld	s4,16(sp)
 9e4:	6aa2                	ld	s5,8(sp)
 9e6:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 9e8:	fae90be3          	beq	s2,a4,99e <malloc+0x76>
        p->s.size -= nunits;
 9ec:	4137073b          	subw	a4,a4,s3
 9f0:	c798                	sw	a4,8(a5)
        p += p->s.size;
 9f2:	02071693          	slli	a3,a4,0x20
 9f6:	01c6d713          	srli	a4,a3,0x1c
 9fa:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 9fc:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 a00:	00000717          	auipc	a4,0x0
 a04:	18a73823          	sd	a0,400(a4) # b90 <freep>
      return (void*)(p + 1);
 a08:	01078513          	addi	a0,a5,16
  }
}
 a0c:	70e2                	ld	ra,56(sp)
 a0e:	7442                	ld	s0,48(sp)
 a10:	7902                	ld	s2,32(sp)
 a12:	69e2                	ld	s3,24(sp)
 a14:	6121                	addi	sp,sp,64
 a16:	8082                	ret
 a18:	74a2                	ld	s1,40(sp)
 a1a:	6a42                	ld	s4,16(sp)
 a1c:	6aa2                	ld	s5,8(sp)
 a1e:	6b02                	ld	s6,0(sp)
 a20:	b7f5                	j	a0c <malloc+0xe4>
