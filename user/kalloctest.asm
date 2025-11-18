
user/_kalloctest：     文件格式 elf64-littleriscv


Disassembly of section .text:

0000000000000000 <test0>:
  test1();
  exit(0);
}

void test0()
{
   0:	7139                	addi	sp,sp,-64
   2:	fc06                	sd	ra,56(sp)
   4:	f822                	sd	s0,48(sp)
   6:	0080                	addi	s0,sp,64
  void *a, *a1;
  int n = 0;
  printf("start test0\n");  
   8:	00001517          	auipc	a0,0x1
   c:	a8050513          	addi	a0,a0,-1408 # a88 <malloc+0xfa>
  10:	00001097          	auipc	ra,0x1
  14:	8c2080e7          	jalr	-1854(ra) # 8d2 <printf>
  ntas(0);
  18:	4501                	li	a0,0
  1a:	00000097          	auipc	ra,0x0
  1e:	5ea080e7          	jalr	1514(ra) # 604 <ntas>
  for(int i = 0; i < NCHILD; i++){
    int pid = fork();
  22:	00000097          	auipc	ra,0x0
  26:	53a080e7          	jalr	1338(ra) # 55c <fork>
    if(pid < 0){
  2a:	06054063          	bltz	a0,8a <test0+0x8a>
      printf("fork failed");
      exit(-1);
    }
    if(pid == 0){
  2e:	c141                	beqz	a0,ae <test0+0xae>
    int pid = fork();
  30:	00000097          	auipc	ra,0x0
  34:	52c080e7          	jalr	1324(ra) # 55c <fork>
    if(pid < 0){
  38:	04054963          	bltz	a0,8a <test0+0x8a>
    if(pid == 0){
  3c:	c92d                	beqz	a0,ae <test0+0xae>
      exit(-1);
    }
  }

  for(int i = 0; i < NCHILD; i++){
    wait(0);
  3e:	4501                	li	a0,0
  40:	00000097          	auipc	ra,0x0
  44:	52c080e7          	jalr	1324(ra) # 56c <wait>
  48:	4501                	li	a0,0
  4a:	00000097          	auipc	ra,0x0
  4e:	522080e7          	jalr	1314(ra) # 56c <wait>
  }
  printf("test0 results:\n");
  52:	00001517          	auipc	a0,0x1
  56:	a6650513          	addi	a0,a0,-1434 # ab8 <malloc+0x12a>
  5a:	00001097          	auipc	ra,0x1
  5e:	878080e7          	jalr	-1928(ra) # 8d2 <printf>
  n = ntas(1);
  62:	4505                	li	a0,1
  64:	00000097          	auipc	ra,0x0
  68:	5a0080e7          	jalr	1440(ra) # 604 <ntas>
  if(n < 10) 
  6c:	47a5                	li	a5,9
  6e:	0aa7c063          	blt	a5,a0,10e <test0+0x10e>
    printf("test0 OK\n");
  72:	00001517          	auipc	a0,0x1
  76:	a5650513          	addi	a0,a0,-1450 # ac8 <malloc+0x13a>
  7a:	00001097          	auipc	ra,0x1
  7e:	858080e7          	jalr	-1960(ra) # 8d2 <printf>
  else
    printf("test0 FAIL\n");
}
  82:	70e2                	ld	ra,56(sp)
  84:	7442                	ld	s0,48(sp)
  86:	6121                	addi	sp,sp,64
  88:	8082                	ret
  8a:	f426                	sd	s1,40(sp)
  8c:	f04a                	sd	s2,32(sp)
  8e:	ec4e                	sd	s3,24(sp)
  90:	e852                	sd	s4,16(sp)
  92:	e456                	sd	s5,8(sp)
      printf("fork failed");
  94:	00001517          	auipc	a0,0x1
  98:	a0450513          	addi	a0,a0,-1532 # a98 <malloc+0x10a>
  9c:	00001097          	auipc	ra,0x1
  a0:	836080e7          	jalr	-1994(ra) # 8d2 <printf>
      exit(-1);
  a4:	557d                	li	a0,-1
  a6:	00000097          	auipc	ra,0x0
  aa:	4be080e7          	jalr	1214(ra) # 564 <exit>
  ae:	f426                	sd	s1,40(sp)
  b0:	f04a                	sd	s2,32(sp)
  b2:	ec4e                	sd	s3,24(sp)
  b4:	e852                	sd	s4,16(sp)
  b6:	e456                	sd	s5,8(sp)
{
  b8:	6961                	lui	s2,0x18
  ba:	6a090913          	addi	s2,s2,1696 # 186a0 <__global_pointer$+0x17297>
        a = sbrk(4096);
  be:	6985                	lui	s3,0x1
        *(int *)(a+4) = 1;
  c0:	4a85                	li	s5,1
        a1 = sbrk(-4096);
  c2:	7a7d                	lui	s4,0xfffff
        a = sbrk(4096);
  c4:	854e                	mv	a0,s3
  c6:	00000097          	auipc	ra,0x0
  ca:	526080e7          	jalr	1318(ra) # 5ec <sbrk>
  ce:	84aa                	mv	s1,a0
        *(int *)(a+4) = 1;
  d0:	01552223          	sw	s5,4(a0)
        a1 = sbrk(-4096);
  d4:	8552                	mv	a0,s4
  d6:	00000097          	auipc	ra,0x0
  da:	516080e7          	jalr	1302(ra) # 5ec <sbrk>
        if (a1 != a + 4096) {
  de:	94ce                	add	s1,s1,s3
  e0:	00951a63          	bne	a0,s1,f4 <test0+0xf4>
      for(i = 0; i < N; i++) {
  e4:	397d                	addiw	s2,s2,-1
  e6:	fc091fe3          	bnez	s2,c4 <test0+0xc4>
      exit(-1);
  ea:	557d                	li	a0,-1
  ec:	00000097          	auipc	ra,0x0
  f0:	478080e7          	jalr	1144(ra) # 564 <exit>
          printf("wrong sbrk\n");
  f4:	00001517          	auipc	a0,0x1
  f8:	9b450513          	addi	a0,a0,-1612 # aa8 <malloc+0x11a>
  fc:	00000097          	auipc	ra,0x0
 100:	7d6080e7          	jalr	2006(ra) # 8d2 <printf>
          exit(-1);
 104:	557d                	li	a0,-1
 106:	00000097          	auipc	ra,0x0
 10a:	45e080e7          	jalr	1118(ra) # 564 <exit>
    printf("test0 FAIL\n");
 10e:	00001517          	auipc	a0,0x1
 112:	9ca50513          	addi	a0,a0,-1590 # ad8 <malloc+0x14a>
 116:	00000097          	auipc	ra,0x0
 11a:	7bc080e7          	jalr	1980(ra) # 8d2 <printf>
}
 11e:	b795                	j	82 <test0+0x82>

0000000000000120 <test1>:

// Run system out of memory and count tot memory allocated
void test1()
{
 120:	7159                	addi	sp,sp,-112
 122:	f486                	sd	ra,104(sp)
 124:	f0a2                	sd	s0,96(sp)
 126:	eca6                	sd	s1,88(sp)
 128:	e8ca                	sd	s2,80(sp)
 12a:	e4ce                	sd	s3,72(sp)
 12c:	e0d2                	sd	s4,64(sp)
 12e:	fc56                	sd	s5,56(sp)
 130:	f85a                	sd	s6,48(sp)
 132:	f45e                	sd	s7,40(sp)
 134:	f062                	sd	s8,32(sp)
 136:	1880                	addi	s0,sp,112
  void *a;
  int pipes[NCHILD];
  int tot = 0;
  char buf[1];
  
  printf("start test1\n");  
 138:	00001517          	auipc	a0,0x1
 13c:	9b050513          	addi	a0,a0,-1616 # ae8 <malloc+0x15a>
 140:	00000097          	auipc	ra,0x0
 144:	792080e7          	jalr	1938(ra) # 8d2 <printf>
  for(int i = 0; i < NCHILD; i++){
 148:	fa840c13          	addi	s8,s0,-88
 14c:	fb040a13          	addi	s4,s0,-80
  printf("start test1\n");  
 150:	84e2                	mv	s1,s8
    int fds[2];
    if(pipe(fds) != 0){
 152:	f9840913          	addi	s2,s0,-104
 156:	854a                	mv	a0,s2
 158:	00000097          	auipc	ra,0x0
 15c:	41c080e7          	jalr	1052(ra) # 574 <pipe>
 160:	8b2a                	mv	s6,a0
 162:	e959                	bnez	a0,1f8 <test1+0xd8>
      printf("pipe() failed\n");
      exit(-1);
    }
    int pid = fork();
 164:	00000097          	auipc	ra,0x0
 168:	3f8080e7          	jalr	1016(ra) # 55c <fork>
    if(pid < 0){
 16c:	0a054363          	bltz	a0,212 <test1+0xf2>
      printf("fork failed");
      exit(-1);
    }
    if(pid == 0){
 170:	cd55                	beqz	a0,22c <test1+0x10c>
          exit(-1);
        }
      }
      exit(0);
    } else {
      close(fds[1]);
 172:	f9c42503          	lw	a0,-100(s0)
 176:	00000097          	auipc	ra,0x0
 17a:	416080e7          	jalr	1046(ra) # 58c <close>
      pipes[i] = fds[0];
 17e:	f9842783          	lw	a5,-104(s0)
 182:	c09c                	sw	a5,0(s1)
  for(int i = 0; i < NCHILD; i++){
 184:	0491                	addi	s1,s1,4
 186:	fc9a18e3          	bne	s4,s1,156 <test1+0x36>
  int tot = 0;
 18a:	8bda                	mv	s7,s6
    }
  }
  int stop = 0;
  while (!stop) {
    stop = 1;
 18c:	4905                	li	s2,1
    for(int i = 0; i < NCHILD; i++){
      if (read(pipes[i], buf, 1) == 1) {
 18e:	fa040a93          	addi	s5,s0,-96
      close(fds[0]);
 192:	84e2                	mv	s1,s8
    stop = 1;
 194:	89ca                	mv	s3,s2
      if (read(pipes[i], buf, 1) == 1) {
 196:	864a                	mv	a2,s2
 198:	85d6                	mv	a1,s5
 19a:	4088                	lw	a0,0(s1)
 19c:	00000097          	auipc	ra,0x0
 1a0:	3e0080e7          	jalr	992(ra) # 57c <read>
 1a4:	0f250863          	beq	a0,s2,294 <test1+0x174>
    for(int i = 0; i < NCHILD; i++){
 1a8:	0491                	addi	s1,s1,4
 1aa:	ff4496e3          	bne	s1,s4,196 <test1+0x76>
  while (!stop) {
 1ae:	fe0982e3          	beqz	s3,192 <test1+0x72>
        stop = 0;
      }
    }
  }
  int n = (PHYSTOP-KERNBASE)/PGSIZE;
  printf("total allocated number of pages: %d (out of %d)\n", tot, n);
 1b2:	6621                	lui	a2,0x8
 1b4:	85de                	mv	a1,s7
 1b6:	00001517          	auipc	a0,0x1
 1ba:	96a50513          	addi	a0,a0,-1686 # b20 <malloc+0x192>
 1be:	00000097          	auipc	ra,0x0
 1c2:	714080e7          	jalr	1812(ra) # 8d2 <printf>
  if(n - tot > 1000) {
 1c6:	67a1                	lui	a5,0x8
 1c8:	c1778793          	addi	a5,a5,-1001 # 7c17 <__global_pointer$+0x680e>
 1cc:	0d77d763          	bge	a5,s7,29a <test1+0x17a>
    printf("test1 FAILED: cannot allocate enough memory");
    exit(-1);
  }
  printf("test1 OK\n");  
 1d0:	00001517          	auipc	a0,0x1
 1d4:	9b850513          	addi	a0,a0,-1608 # b88 <malloc+0x1fa>
 1d8:	00000097          	auipc	ra,0x0
 1dc:	6fa080e7          	jalr	1786(ra) # 8d2 <printf>
}
 1e0:	70a6                	ld	ra,104(sp)
 1e2:	7406                	ld	s0,96(sp)
 1e4:	64e6                	ld	s1,88(sp)
 1e6:	6946                	ld	s2,80(sp)
 1e8:	69a6                	ld	s3,72(sp)
 1ea:	6a06                	ld	s4,64(sp)
 1ec:	7ae2                	ld	s5,56(sp)
 1ee:	7b42                	ld	s6,48(sp)
 1f0:	7ba2                	ld	s7,40(sp)
 1f2:	7c02                	ld	s8,32(sp)
 1f4:	6165                	addi	sp,sp,112
 1f6:	8082                	ret
      printf("pipe() failed\n");
 1f8:	00001517          	auipc	a0,0x1
 1fc:	90050513          	addi	a0,a0,-1792 # af8 <malloc+0x16a>
 200:	00000097          	auipc	ra,0x0
 204:	6d2080e7          	jalr	1746(ra) # 8d2 <printf>
      exit(-1);
 208:	557d                	li	a0,-1
 20a:	00000097          	auipc	ra,0x0
 20e:	35a080e7          	jalr	858(ra) # 564 <exit>
      printf("fork failed");
 212:	00001517          	auipc	a0,0x1
 216:	88650513          	addi	a0,a0,-1914 # a98 <malloc+0x10a>
 21a:	00000097          	auipc	ra,0x0
 21e:	6b8080e7          	jalr	1720(ra) # 8d2 <printf>
      exit(-1);
 222:	557d                	li	a0,-1
 224:	00000097          	auipc	ra,0x0
 228:	340080e7          	jalr	832(ra) # 564 <exit>
      close(fds[0]);
 22c:	f9842503          	lw	a0,-104(s0)
 230:	00000097          	auipc	ra,0x0
 234:	35c080e7          	jalr	860(ra) # 58c <close>
 238:	64e1                	lui	s1,0x18
 23a:	6a048493          	addi	s1,s1,1696 # 186a0 <__global_pointer$+0x17297>
        a = sbrk(PGSIZE);
 23e:	6a05                	lui	s4,0x1
        *(int *)(a+4) = 1;
 240:	4905                	li	s2,1
        if (write(fds[1], "x", 1) != 1) {
 242:	00001997          	auipc	s3,0x1
 246:	8c698993          	addi	s3,s3,-1850 # b08 <malloc+0x17a>
        a = sbrk(PGSIZE);
 24a:	8552                	mv	a0,s4
 24c:	00000097          	auipc	ra,0x0
 250:	3a0080e7          	jalr	928(ra) # 5ec <sbrk>
        *(int *)(a+4) = 1;
 254:	01252223          	sw	s2,4(a0)
        if (write(fds[1], "x", 1) != 1) {
 258:	864a                	mv	a2,s2
 25a:	85ce                	mv	a1,s3
 25c:	f9c42503          	lw	a0,-100(s0)
 260:	00000097          	auipc	ra,0x0
 264:	324080e7          	jalr	804(ra) # 584 <write>
 268:	01251963          	bne	a0,s2,27a <test1+0x15a>
      for(i = 0; i < N; i++) {
 26c:	34fd                	addiw	s1,s1,-1
 26e:	fcf1                	bnez	s1,24a <test1+0x12a>
      exit(0);
 270:	4501                	li	a0,0
 272:	00000097          	auipc	ra,0x0
 276:	2f2080e7          	jalr	754(ra) # 564 <exit>
          printf("write failed");
 27a:	00001517          	auipc	a0,0x1
 27e:	89650513          	addi	a0,a0,-1898 # b10 <malloc+0x182>
 282:	00000097          	auipc	ra,0x0
 286:	650080e7          	jalr	1616(ra) # 8d2 <printf>
          exit(-1);
 28a:	557d                	li	a0,-1
 28c:	00000097          	auipc	ra,0x0
 290:	2d8080e7          	jalr	728(ra) # 564 <exit>
        tot += 1;
 294:	2b85                	addiw	s7,s7,1
        stop = 0;
 296:	89da                	mv	s3,s6
 298:	bf01                	j	1a8 <test1+0x88>
    printf("test1 FAILED: cannot allocate enough memory");
 29a:	00001517          	auipc	a0,0x1
 29e:	8be50513          	addi	a0,a0,-1858 # b58 <malloc+0x1ca>
 2a2:	00000097          	auipc	ra,0x0
 2a6:	630080e7          	jalr	1584(ra) # 8d2 <printf>
    exit(-1);
 2aa:	557d                	li	a0,-1
 2ac:	00000097          	auipc	ra,0x0
 2b0:	2b8080e7          	jalr	696(ra) # 564 <exit>

00000000000002b4 <main>:
{
 2b4:	1141                	addi	sp,sp,-16
 2b6:	e406                	sd	ra,8(sp)
 2b8:	e022                	sd	s0,0(sp)
 2ba:	0800                	addi	s0,sp,16
  test0();
 2bc:	00000097          	auipc	ra,0x0
 2c0:	d44080e7          	jalr	-700(ra) # 0 <test0>
  test1();
 2c4:	00000097          	auipc	ra,0x0
 2c8:	e5c080e7          	jalr	-420(ra) # 120 <test1>
  exit(0);
 2cc:	4501                	li	a0,0
 2ce:	00000097          	auipc	ra,0x0
 2d2:	296080e7          	jalr	662(ra) # 564 <exit>

00000000000002d6 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 2d6:	1141                	addi	sp,sp,-16
 2d8:	e406                	sd	ra,8(sp)
 2da:	e022                	sd	s0,0(sp)
 2dc:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 2de:	87aa                	mv	a5,a0
 2e0:	0585                	addi	a1,a1,1
 2e2:	0785                	addi	a5,a5,1
 2e4:	fff5c703          	lbu	a4,-1(a1)
 2e8:	fee78fa3          	sb	a4,-1(a5)
 2ec:	fb75                	bnez	a4,2e0 <strcpy+0xa>
    ;
  return os;
}
 2ee:	60a2                	ld	ra,8(sp)
 2f0:	6402                	ld	s0,0(sp)
 2f2:	0141                	addi	sp,sp,16
 2f4:	8082                	ret

00000000000002f6 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 2f6:	1141                	addi	sp,sp,-16
 2f8:	e406                	sd	ra,8(sp)
 2fa:	e022                	sd	s0,0(sp)
 2fc:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 2fe:	00054783          	lbu	a5,0(a0)
 302:	cb91                	beqz	a5,316 <strcmp+0x20>
 304:	0005c703          	lbu	a4,0(a1)
 308:	00f71763          	bne	a4,a5,316 <strcmp+0x20>
    p++, q++;
 30c:	0505                	addi	a0,a0,1
 30e:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 310:	00054783          	lbu	a5,0(a0)
 314:	fbe5                	bnez	a5,304 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 316:	0005c503          	lbu	a0,0(a1)
}
 31a:	40a7853b          	subw	a0,a5,a0
 31e:	60a2                	ld	ra,8(sp)
 320:	6402                	ld	s0,0(sp)
 322:	0141                	addi	sp,sp,16
 324:	8082                	ret

0000000000000326 <strlen>:

uint
strlen(const char *s)
{
 326:	1141                	addi	sp,sp,-16
 328:	e406                	sd	ra,8(sp)
 32a:	e022                	sd	s0,0(sp)
 32c:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 32e:	00054783          	lbu	a5,0(a0)
 332:	cf91                	beqz	a5,34e <strlen+0x28>
 334:	00150793          	addi	a5,a0,1
 338:	86be                	mv	a3,a5
 33a:	0785                	addi	a5,a5,1
 33c:	fff7c703          	lbu	a4,-1(a5)
 340:	ff65                	bnez	a4,338 <strlen+0x12>
 342:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
 346:	60a2                	ld	ra,8(sp)
 348:	6402                	ld	s0,0(sp)
 34a:	0141                	addi	sp,sp,16
 34c:	8082                	ret
  for(n = 0; s[n]; n++)
 34e:	4501                	li	a0,0
 350:	bfdd                	j	346 <strlen+0x20>

0000000000000352 <memset>:

void*
memset(void *dst, int c, uint n)
{
 352:	1141                	addi	sp,sp,-16
 354:	e406                	sd	ra,8(sp)
 356:	e022                	sd	s0,0(sp)
 358:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 35a:	ca19                	beqz	a2,370 <memset+0x1e>
 35c:	87aa                	mv	a5,a0
 35e:	1602                	slli	a2,a2,0x20
 360:	9201                	srli	a2,a2,0x20
 362:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 366:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 36a:	0785                	addi	a5,a5,1
 36c:	fee79de3          	bne	a5,a4,366 <memset+0x14>
  }
  return dst;
}
 370:	60a2                	ld	ra,8(sp)
 372:	6402                	ld	s0,0(sp)
 374:	0141                	addi	sp,sp,16
 376:	8082                	ret

0000000000000378 <strchr>:

char*
strchr(const char *s, char c)
{
 378:	1141                	addi	sp,sp,-16
 37a:	e406                	sd	ra,8(sp)
 37c:	e022                	sd	s0,0(sp)
 37e:	0800                	addi	s0,sp,16
  for(; *s; s++)
 380:	00054783          	lbu	a5,0(a0)
 384:	cf81                	beqz	a5,39c <strchr+0x24>
    if(*s == c)
 386:	00f58763          	beq	a1,a5,394 <strchr+0x1c>
  for(; *s; s++)
 38a:	0505                	addi	a0,a0,1
 38c:	00054783          	lbu	a5,0(a0)
 390:	fbfd                	bnez	a5,386 <strchr+0xe>
      return (char*)s;
  return 0;
 392:	4501                	li	a0,0
}
 394:	60a2                	ld	ra,8(sp)
 396:	6402                	ld	s0,0(sp)
 398:	0141                	addi	sp,sp,16
 39a:	8082                	ret
  return 0;
 39c:	4501                	li	a0,0
 39e:	bfdd                	j	394 <strchr+0x1c>

00000000000003a0 <gets>:

char*
gets(char *buf, int max)
{
 3a0:	711d                	addi	sp,sp,-96
 3a2:	ec86                	sd	ra,88(sp)
 3a4:	e8a2                	sd	s0,80(sp)
 3a6:	e4a6                	sd	s1,72(sp)
 3a8:	e0ca                	sd	s2,64(sp)
 3aa:	fc4e                	sd	s3,56(sp)
 3ac:	f852                	sd	s4,48(sp)
 3ae:	f456                	sd	s5,40(sp)
 3b0:	f05a                	sd	s6,32(sp)
 3b2:	ec5e                	sd	s7,24(sp)
 3b4:	e862                	sd	s8,16(sp)
 3b6:	1080                	addi	s0,sp,96
 3b8:	8baa                	mv	s7,a0
 3ba:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3bc:	892a                	mv	s2,a0
 3be:	4481                	li	s1,0
    cc = read(0, &c, 1);
 3c0:	faf40b13          	addi	s6,s0,-81
 3c4:	4a85                	li	s5,1
  for(i=0; i+1 < max; ){
 3c6:	8c26                	mv	s8,s1
 3c8:	0014899b          	addiw	s3,s1,1
 3cc:	84ce                	mv	s1,s3
 3ce:	0349d663          	bge	s3,s4,3fa <gets+0x5a>
    cc = read(0, &c, 1);
 3d2:	8656                	mv	a2,s5
 3d4:	85da                	mv	a1,s6
 3d6:	4501                	li	a0,0
 3d8:	00000097          	auipc	ra,0x0
 3dc:	1a4080e7          	jalr	420(ra) # 57c <read>
    if(cc < 1)
 3e0:	00a05d63          	blez	a0,3fa <gets+0x5a>
      break;
    buf[i++] = c;
 3e4:	faf44783          	lbu	a5,-81(s0)
 3e8:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 3ec:	0905                	addi	s2,s2,1
 3ee:	ff678713          	addi	a4,a5,-10
 3f2:	c319                	beqz	a4,3f8 <gets+0x58>
 3f4:	17cd                	addi	a5,a5,-13
 3f6:	fbe1                	bnez	a5,3c6 <gets+0x26>
    buf[i++] = c;
 3f8:	8c4e                	mv	s8,s3
      break;
  }
  buf[i] = '\0';
 3fa:	9c5e                	add	s8,s8,s7
 3fc:	000c0023          	sb	zero,0(s8)
  return buf;
}
 400:	855e                	mv	a0,s7
 402:	60e6                	ld	ra,88(sp)
 404:	6446                	ld	s0,80(sp)
 406:	64a6                	ld	s1,72(sp)
 408:	6906                	ld	s2,64(sp)
 40a:	79e2                	ld	s3,56(sp)
 40c:	7a42                	ld	s4,48(sp)
 40e:	7aa2                	ld	s5,40(sp)
 410:	7b02                	ld	s6,32(sp)
 412:	6be2                	ld	s7,24(sp)
 414:	6c42                	ld	s8,16(sp)
 416:	6125                	addi	sp,sp,96
 418:	8082                	ret

000000000000041a <stat>:

int
stat(const char *n, struct stat *st)
{
 41a:	1101                	addi	sp,sp,-32
 41c:	ec06                	sd	ra,24(sp)
 41e:	e822                	sd	s0,16(sp)
 420:	e04a                	sd	s2,0(sp)
 422:	1000                	addi	s0,sp,32
 424:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 426:	4581                	li	a1,0
 428:	00000097          	auipc	ra,0x0
 42c:	17c080e7          	jalr	380(ra) # 5a4 <open>
  if(fd < 0)
 430:	02054663          	bltz	a0,45c <stat+0x42>
 434:	e426                	sd	s1,8(sp)
 436:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 438:	85ca                	mv	a1,s2
 43a:	00000097          	auipc	ra,0x0
 43e:	182080e7          	jalr	386(ra) # 5bc <fstat>
 442:	892a                	mv	s2,a0
  close(fd);
 444:	8526                	mv	a0,s1
 446:	00000097          	auipc	ra,0x0
 44a:	146080e7          	jalr	326(ra) # 58c <close>
  return r;
 44e:	64a2                	ld	s1,8(sp)
}
 450:	854a                	mv	a0,s2
 452:	60e2                	ld	ra,24(sp)
 454:	6442                	ld	s0,16(sp)
 456:	6902                	ld	s2,0(sp)
 458:	6105                	addi	sp,sp,32
 45a:	8082                	ret
    return -1;
 45c:	57fd                	li	a5,-1
 45e:	893e                	mv	s2,a5
 460:	bfc5                	j	450 <stat+0x36>

0000000000000462 <atoi>:

int
atoi(const char *s)
{
 462:	1141                	addi	sp,sp,-16
 464:	e406                	sd	ra,8(sp)
 466:	e022                	sd	s0,0(sp)
 468:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 46a:	00054683          	lbu	a3,0(a0)
 46e:	fd06879b          	addiw	a5,a3,-48
 472:	0ff7f793          	zext.b	a5,a5
 476:	4625                	li	a2,9
 478:	02f66963          	bltu	a2,a5,4aa <atoi+0x48>
 47c:	872a                	mv	a4,a0
  n = 0;
 47e:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 480:	0705                	addi	a4,a4,1
 482:	0025179b          	slliw	a5,a0,0x2
 486:	9fa9                	addw	a5,a5,a0
 488:	0017979b          	slliw	a5,a5,0x1
 48c:	9fb5                	addw	a5,a5,a3
 48e:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 492:	00074683          	lbu	a3,0(a4)
 496:	fd06879b          	addiw	a5,a3,-48
 49a:	0ff7f793          	zext.b	a5,a5
 49e:	fef671e3          	bgeu	a2,a5,480 <atoi+0x1e>
  return n;
}
 4a2:	60a2                	ld	ra,8(sp)
 4a4:	6402                	ld	s0,0(sp)
 4a6:	0141                	addi	sp,sp,16
 4a8:	8082                	ret
  n = 0;
 4aa:	4501                	li	a0,0
 4ac:	bfdd                	j	4a2 <atoi+0x40>

00000000000004ae <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 4ae:	1141                	addi	sp,sp,-16
 4b0:	e406                	sd	ra,8(sp)
 4b2:	e022                	sd	s0,0(sp)
 4b4:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 4b6:	02b57563          	bgeu	a0,a1,4e0 <memmove+0x32>
    while(n-- > 0)
 4ba:	00c05f63          	blez	a2,4d8 <memmove+0x2a>
 4be:	1602                	slli	a2,a2,0x20
 4c0:	9201                	srli	a2,a2,0x20
 4c2:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 4c6:	872a                	mv	a4,a0
      *dst++ = *src++;
 4c8:	0585                	addi	a1,a1,1
 4ca:	0705                	addi	a4,a4,1
 4cc:	fff5c683          	lbu	a3,-1(a1)
 4d0:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 4d4:	fee79ae3          	bne	a5,a4,4c8 <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 4d8:	60a2                	ld	ra,8(sp)
 4da:	6402                	ld	s0,0(sp)
 4dc:	0141                	addi	sp,sp,16
 4de:	8082                	ret
    while(n-- > 0)
 4e0:	fec05ce3          	blez	a2,4d8 <memmove+0x2a>
    dst += n;
 4e4:	00c50733          	add	a4,a0,a2
    src += n;
 4e8:	95b2                	add	a1,a1,a2
 4ea:	fff6079b          	addiw	a5,a2,-1 # 7fff <__global_pointer$+0x6bf6>
 4ee:	1782                	slli	a5,a5,0x20
 4f0:	9381                	srli	a5,a5,0x20
 4f2:	fff7c793          	not	a5,a5
 4f6:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 4f8:	15fd                	addi	a1,a1,-1
 4fa:	177d                	addi	a4,a4,-1
 4fc:	0005c683          	lbu	a3,0(a1)
 500:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 504:	fef71ae3          	bne	a4,a5,4f8 <memmove+0x4a>
 508:	bfc1                	j	4d8 <memmove+0x2a>

000000000000050a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 50a:	1141                	addi	sp,sp,-16
 50c:	e406                	sd	ra,8(sp)
 50e:	e022                	sd	s0,0(sp)
 510:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 512:	c61d                	beqz	a2,540 <memcmp+0x36>
 514:	1602                	slli	a2,a2,0x20
 516:	9201                	srli	a2,a2,0x20
 518:	00c506b3          	add	a3,a0,a2
    if (*p1 != *p2) {
 51c:	00054783          	lbu	a5,0(a0)
 520:	0005c703          	lbu	a4,0(a1)
 524:	00e79863          	bne	a5,a4,534 <memcmp+0x2a>
      return *p1 - *p2;
    }
    p1++;
 528:	0505                	addi	a0,a0,1
    p2++;
 52a:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 52c:	fed518e3          	bne	a0,a3,51c <memcmp+0x12>
  }
  return 0;
 530:	4501                	li	a0,0
 532:	a019                	j	538 <memcmp+0x2e>
      return *p1 - *p2;
 534:	40e7853b          	subw	a0,a5,a4
}
 538:	60a2                	ld	ra,8(sp)
 53a:	6402                	ld	s0,0(sp)
 53c:	0141                	addi	sp,sp,16
 53e:	8082                	ret
  return 0;
 540:	4501                	li	a0,0
 542:	bfdd                	j	538 <memcmp+0x2e>

0000000000000544 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 544:	1141                	addi	sp,sp,-16
 546:	e406                	sd	ra,8(sp)
 548:	e022                	sd	s0,0(sp)
 54a:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 54c:	00000097          	auipc	ra,0x0
 550:	f62080e7          	jalr	-158(ra) # 4ae <memmove>
}
 554:	60a2                	ld	ra,8(sp)
 556:	6402                	ld	s0,0(sp)
 558:	0141                	addi	sp,sp,16
 55a:	8082                	ret

000000000000055c <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 55c:	4885                	li	a7,1
 ecall
 55e:	00000073          	ecall
 ret
 562:	8082                	ret

0000000000000564 <exit>:
.global exit
exit:
 li a7, SYS_exit
 564:	4889                	li	a7,2
 ecall
 566:	00000073          	ecall
 ret
 56a:	8082                	ret

000000000000056c <wait>:
.global wait
wait:
 li a7, SYS_wait
 56c:	488d                	li	a7,3
 ecall
 56e:	00000073          	ecall
 ret
 572:	8082                	ret

0000000000000574 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 574:	4891                	li	a7,4
 ecall
 576:	00000073          	ecall
 ret
 57a:	8082                	ret

000000000000057c <read>:
.global read
read:
 li a7, SYS_read
 57c:	4895                	li	a7,5
 ecall
 57e:	00000073          	ecall
 ret
 582:	8082                	ret

0000000000000584 <write>:
.global write
write:
 li a7, SYS_write
 584:	48c1                	li	a7,16
 ecall
 586:	00000073          	ecall
 ret
 58a:	8082                	ret

000000000000058c <close>:
.global close
close:
 li a7, SYS_close
 58c:	48d5                	li	a7,21
 ecall
 58e:	00000073          	ecall
 ret
 592:	8082                	ret

0000000000000594 <kill>:
.global kill
kill:
 li a7, SYS_kill
 594:	4899                	li	a7,6
 ecall
 596:	00000073          	ecall
 ret
 59a:	8082                	ret

000000000000059c <exec>:
.global exec
exec:
 li a7, SYS_exec
 59c:	489d                	li	a7,7
 ecall
 59e:	00000073          	ecall
 ret
 5a2:	8082                	ret

00000000000005a4 <open>:
.global open
open:
 li a7, SYS_open
 5a4:	48bd                	li	a7,15
 ecall
 5a6:	00000073          	ecall
 ret
 5aa:	8082                	ret

00000000000005ac <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 5ac:	48c5                	li	a7,17
 ecall
 5ae:	00000073          	ecall
 ret
 5b2:	8082                	ret

00000000000005b4 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 5b4:	48c9                	li	a7,18
 ecall
 5b6:	00000073          	ecall
 ret
 5ba:	8082                	ret

00000000000005bc <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 5bc:	48a1                	li	a7,8
 ecall
 5be:	00000073          	ecall
 ret
 5c2:	8082                	ret

00000000000005c4 <link>:
.global link
link:
 li a7, SYS_link
 5c4:	48cd                	li	a7,19
 ecall
 5c6:	00000073          	ecall
 ret
 5ca:	8082                	ret

00000000000005cc <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 5cc:	48d1                	li	a7,20
 ecall
 5ce:	00000073          	ecall
 ret
 5d2:	8082                	ret

00000000000005d4 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 5d4:	48a5                	li	a7,9
 ecall
 5d6:	00000073          	ecall
 ret
 5da:	8082                	ret

00000000000005dc <dup>:
.global dup
dup:
 li a7, SYS_dup
 5dc:	48a9                	li	a7,10
 ecall
 5de:	00000073          	ecall
 ret
 5e2:	8082                	ret

00000000000005e4 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 5e4:	48ad                	li	a7,11
 ecall
 5e6:	00000073          	ecall
 ret
 5ea:	8082                	ret

00000000000005ec <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 5ec:	48b1                	li	a7,12
 ecall
 5ee:	00000073          	ecall
 ret
 5f2:	8082                	ret

00000000000005f4 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 5f4:	48b5                	li	a7,13
 ecall
 5f6:	00000073          	ecall
 ret
 5fa:	8082                	ret

00000000000005fc <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 5fc:	48b9                	li	a7,14
 ecall
 5fe:	00000073          	ecall
 ret
 602:	8082                	ret

0000000000000604 <ntas>:
.global ntas
ntas:
 li a7, SYS_ntas
 604:	48d9                	li	a7,22
 ecall
 606:	00000073          	ecall
 ret
 60a:	8082                	ret

000000000000060c <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 60c:	1101                	addi	sp,sp,-32
 60e:	ec06                	sd	ra,24(sp)
 610:	e822                	sd	s0,16(sp)
 612:	1000                	addi	s0,sp,32
 614:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 618:	4605                	li	a2,1
 61a:	fef40593          	addi	a1,s0,-17
 61e:	00000097          	auipc	ra,0x0
 622:	f66080e7          	jalr	-154(ra) # 584 <write>
}
 626:	60e2                	ld	ra,24(sp)
 628:	6442                	ld	s0,16(sp)
 62a:	6105                	addi	sp,sp,32
 62c:	8082                	ret

000000000000062e <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 62e:	7139                	addi	sp,sp,-64
 630:	fc06                	sd	ra,56(sp)
 632:	f822                	sd	s0,48(sp)
 634:	f04a                	sd	s2,32(sp)
 636:	ec4e                	sd	s3,24(sp)
 638:	0080                	addi	s0,sp,64
 63a:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 63c:	cad9                	beqz	a3,6d2 <printint+0xa4>
 63e:	01f5d79b          	srliw	a5,a1,0x1f
 642:	cbc1                	beqz	a5,6d2 <printint+0xa4>
    neg = 1;
    x = -xx;
 644:	40b005bb          	negw	a1,a1
    neg = 1;
 648:	4305                	li	t1,1
  } else {
    x = xx;
  }

  i = 0;
 64a:	fc040993          	addi	s3,s0,-64
  neg = 0;
 64e:	86ce                	mv	a3,s3
  i = 0;
 650:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 652:	00000817          	auipc	a6,0x0
 656:	5a680813          	addi	a6,a6,1446 # bf8 <digits>
 65a:	88ba                	mv	a7,a4
 65c:	0017051b          	addiw	a0,a4,1
 660:	872a                	mv	a4,a0
 662:	02c5f7bb          	remuw	a5,a1,a2
 666:	1782                	slli	a5,a5,0x20
 668:	9381                	srli	a5,a5,0x20
 66a:	97c2                	add	a5,a5,a6
 66c:	0007c783          	lbu	a5,0(a5)
 670:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 674:	87ae                	mv	a5,a1
 676:	02c5d5bb          	divuw	a1,a1,a2
 67a:	0685                	addi	a3,a3,1
 67c:	fcc7ffe3          	bgeu	a5,a2,65a <printint+0x2c>
  if(neg)
 680:	00030c63          	beqz	t1,698 <printint+0x6a>
    buf[i++] = '-';
 684:	fd050793          	addi	a5,a0,-48
 688:	00878533          	add	a0,a5,s0
 68c:	02d00793          	li	a5,45
 690:	fef50823          	sb	a5,-16(a0)
 694:	0028871b          	addiw	a4,a7,2

  while(--i >= 0)
 698:	02e05763          	blez	a4,6c6 <printint+0x98>
 69c:	f426                	sd	s1,40(sp)
 69e:	377d                	addiw	a4,a4,-1
 6a0:	00e984b3          	add	s1,s3,a4
 6a4:	19fd                	addi	s3,s3,-1
 6a6:	99ba                	add	s3,s3,a4
 6a8:	1702                	slli	a4,a4,0x20
 6aa:	9301                	srli	a4,a4,0x20
 6ac:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 6b0:	0004c583          	lbu	a1,0(s1)
 6b4:	854a                	mv	a0,s2
 6b6:	00000097          	auipc	ra,0x0
 6ba:	f56080e7          	jalr	-170(ra) # 60c <putc>
  while(--i >= 0)
 6be:	14fd                	addi	s1,s1,-1
 6c0:	ff3498e3          	bne	s1,s3,6b0 <printint+0x82>
 6c4:	74a2                	ld	s1,40(sp)
}
 6c6:	70e2                	ld	ra,56(sp)
 6c8:	7442                	ld	s0,48(sp)
 6ca:	7902                	ld	s2,32(sp)
 6cc:	69e2                	ld	s3,24(sp)
 6ce:	6121                	addi	sp,sp,64
 6d0:	8082                	ret
  neg = 0;
 6d2:	4301                	li	t1,0
 6d4:	bf9d                	j	64a <printint+0x1c>

00000000000006d6 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 6d6:	715d                	addi	sp,sp,-80
 6d8:	e486                	sd	ra,72(sp)
 6da:	e0a2                	sd	s0,64(sp)
 6dc:	f84a                	sd	s2,48(sp)
 6de:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 6e0:	0005c903          	lbu	s2,0(a1)
 6e4:	1a090b63          	beqz	s2,89a <vprintf+0x1c4>
 6e8:	fc26                	sd	s1,56(sp)
 6ea:	f44e                	sd	s3,40(sp)
 6ec:	f052                	sd	s4,32(sp)
 6ee:	ec56                	sd	s5,24(sp)
 6f0:	e85a                	sd	s6,16(sp)
 6f2:	e45e                	sd	s7,8(sp)
 6f4:	8aaa                	mv	s5,a0
 6f6:	8bb2                	mv	s7,a2
 6f8:	00158493          	addi	s1,a1,1
  state = 0;
 6fc:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 6fe:	02500a13          	li	s4,37
 702:	4b55                	li	s6,21
 704:	a839                	j	722 <vprintf+0x4c>
        putc(fd, c);
 706:	85ca                	mv	a1,s2
 708:	8556                	mv	a0,s5
 70a:	00000097          	auipc	ra,0x0
 70e:	f02080e7          	jalr	-254(ra) # 60c <putc>
 712:	a019                	j	718 <vprintf+0x42>
    } else if(state == '%'){
 714:	01498d63          	beq	s3,s4,72e <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
 718:	0485                	addi	s1,s1,1
 71a:	fff4c903          	lbu	s2,-1(s1)
 71e:	16090863          	beqz	s2,88e <vprintf+0x1b8>
    if(state == 0){
 722:	fe0999e3          	bnez	s3,714 <vprintf+0x3e>
      if(c == '%'){
 726:	ff4910e3          	bne	s2,s4,706 <vprintf+0x30>
        state = '%';
 72a:	89d2                	mv	s3,s4
 72c:	b7f5                	j	718 <vprintf+0x42>
      if(c == 'd'){
 72e:	13490563          	beq	s2,s4,858 <vprintf+0x182>
 732:	f9d9079b          	addiw	a5,s2,-99
 736:	0ff7f793          	zext.b	a5,a5
 73a:	12fb6863          	bltu	s6,a5,86a <vprintf+0x194>
 73e:	f9d9079b          	addiw	a5,s2,-99
 742:	0ff7f713          	zext.b	a4,a5
 746:	12eb6263          	bltu	s6,a4,86a <vprintf+0x194>
 74a:	00271793          	slli	a5,a4,0x2
 74e:	00000717          	auipc	a4,0x0
 752:	45270713          	addi	a4,a4,1106 # ba0 <malloc+0x212>
 756:	97ba                	add	a5,a5,a4
 758:	439c                	lw	a5,0(a5)
 75a:	97ba                	add	a5,a5,a4
 75c:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 75e:	008b8913          	addi	s2,s7,8
 762:	4685                	li	a3,1
 764:	4629                	li	a2,10
 766:	000ba583          	lw	a1,0(s7)
 76a:	8556                	mv	a0,s5
 76c:	00000097          	auipc	ra,0x0
 770:	ec2080e7          	jalr	-318(ra) # 62e <printint>
 774:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 776:	4981                	li	s3,0
 778:	b745                	j	718 <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
 77a:	008b8913          	addi	s2,s7,8
 77e:	4681                	li	a3,0
 780:	4629                	li	a2,10
 782:	000ba583          	lw	a1,0(s7)
 786:	8556                	mv	a0,s5
 788:	00000097          	auipc	ra,0x0
 78c:	ea6080e7          	jalr	-346(ra) # 62e <printint>
 790:	8bca                	mv	s7,s2
      state = 0;
 792:	4981                	li	s3,0
 794:	b751                	j	718 <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
 796:	008b8913          	addi	s2,s7,8
 79a:	4681                	li	a3,0
 79c:	4641                	li	a2,16
 79e:	000ba583          	lw	a1,0(s7)
 7a2:	8556                	mv	a0,s5
 7a4:	00000097          	auipc	ra,0x0
 7a8:	e8a080e7          	jalr	-374(ra) # 62e <printint>
 7ac:	8bca                	mv	s7,s2
      state = 0;
 7ae:	4981                	li	s3,0
 7b0:	b7a5                	j	718 <vprintf+0x42>
 7b2:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
 7b4:	008b8793          	addi	a5,s7,8
 7b8:	8c3e                	mv	s8,a5
 7ba:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 7be:	03000593          	li	a1,48
 7c2:	8556                	mv	a0,s5
 7c4:	00000097          	auipc	ra,0x0
 7c8:	e48080e7          	jalr	-440(ra) # 60c <putc>
  putc(fd, 'x');
 7cc:	07800593          	li	a1,120
 7d0:	8556                	mv	a0,s5
 7d2:	00000097          	auipc	ra,0x0
 7d6:	e3a080e7          	jalr	-454(ra) # 60c <putc>
 7da:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7dc:	00000b97          	auipc	s7,0x0
 7e0:	41cb8b93          	addi	s7,s7,1052 # bf8 <digits>
 7e4:	03c9d793          	srli	a5,s3,0x3c
 7e8:	97de                	add	a5,a5,s7
 7ea:	0007c583          	lbu	a1,0(a5)
 7ee:	8556                	mv	a0,s5
 7f0:	00000097          	auipc	ra,0x0
 7f4:	e1c080e7          	jalr	-484(ra) # 60c <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7f8:	0992                	slli	s3,s3,0x4
 7fa:	397d                	addiw	s2,s2,-1
 7fc:	fe0914e3          	bnez	s2,7e4 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
 800:	8be2                	mv	s7,s8
      state = 0;
 802:	4981                	li	s3,0
 804:	6c02                	ld	s8,0(sp)
 806:	bf09                	j	718 <vprintf+0x42>
        s = va_arg(ap, char*);
 808:	008b8993          	addi	s3,s7,8
 80c:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 810:	02090163          	beqz	s2,832 <vprintf+0x15c>
        while(*s != 0){
 814:	00094583          	lbu	a1,0(s2)
 818:	c9a5                	beqz	a1,888 <vprintf+0x1b2>
          putc(fd, *s);
 81a:	8556                	mv	a0,s5
 81c:	00000097          	auipc	ra,0x0
 820:	df0080e7          	jalr	-528(ra) # 60c <putc>
          s++;
 824:	0905                	addi	s2,s2,1
        while(*s != 0){
 826:	00094583          	lbu	a1,0(s2)
 82a:	f9e5                	bnez	a1,81a <vprintf+0x144>
        s = va_arg(ap, char*);
 82c:	8bce                	mv	s7,s3
      state = 0;
 82e:	4981                	li	s3,0
 830:	b5e5                	j	718 <vprintf+0x42>
          s = "(null)";
 832:	00000917          	auipc	s2,0x0
 836:	36690913          	addi	s2,s2,870 # b98 <malloc+0x20a>
        while(*s != 0){
 83a:	02800593          	li	a1,40
 83e:	bff1                	j	81a <vprintf+0x144>
        putc(fd, va_arg(ap, uint));
 840:	008b8913          	addi	s2,s7,8
 844:	000bc583          	lbu	a1,0(s7)
 848:	8556                	mv	a0,s5
 84a:	00000097          	auipc	ra,0x0
 84e:	dc2080e7          	jalr	-574(ra) # 60c <putc>
 852:	8bca                	mv	s7,s2
      state = 0;
 854:	4981                	li	s3,0
 856:	b5c9                	j	718 <vprintf+0x42>
        putc(fd, c);
 858:	02500593          	li	a1,37
 85c:	8556                	mv	a0,s5
 85e:	00000097          	auipc	ra,0x0
 862:	dae080e7          	jalr	-594(ra) # 60c <putc>
      state = 0;
 866:	4981                	li	s3,0
 868:	bd45                	j	718 <vprintf+0x42>
        putc(fd, '%');
 86a:	02500593          	li	a1,37
 86e:	8556                	mv	a0,s5
 870:	00000097          	auipc	ra,0x0
 874:	d9c080e7          	jalr	-612(ra) # 60c <putc>
        putc(fd, c);
 878:	85ca                	mv	a1,s2
 87a:	8556                	mv	a0,s5
 87c:	00000097          	auipc	ra,0x0
 880:	d90080e7          	jalr	-624(ra) # 60c <putc>
      state = 0;
 884:	4981                	li	s3,0
 886:	bd49                	j	718 <vprintf+0x42>
        s = va_arg(ap, char*);
 888:	8bce                	mv	s7,s3
      state = 0;
 88a:	4981                	li	s3,0
 88c:	b571                	j	718 <vprintf+0x42>
 88e:	74e2                	ld	s1,56(sp)
 890:	79a2                	ld	s3,40(sp)
 892:	7a02                	ld	s4,32(sp)
 894:	6ae2                	ld	s5,24(sp)
 896:	6b42                	ld	s6,16(sp)
 898:	6ba2                	ld	s7,8(sp)
    }
  }
}
 89a:	60a6                	ld	ra,72(sp)
 89c:	6406                	ld	s0,64(sp)
 89e:	7942                	ld	s2,48(sp)
 8a0:	6161                	addi	sp,sp,80
 8a2:	8082                	ret

00000000000008a4 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 8a4:	715d                	addi	sp,sp,-80
 8a6:	ec06                	sd	ra,24(sp)
 8a8:	e822                	sd	s0,16(sp)
 8aa:	1000                	addi	s0,sp,32
 8ac:	e010                	sd	a2,0(s0)
 8ae:	e414                	sd	a3,8(s0)
 8b0:	e818                	sd	a4,16(s0)
 8b2:	ec1c                	sd	a5,24(s0)
 8b4:	03043023          	sd	a6,32(s0)
 8b8:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 8bc:	8622                	mv	a2,s0
 8be:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 8c2:	00000097          	auipc	ra,0x0
 8c6:	e14080e7          	jalr	-492(ra) # 6d6 <vprintf>
}
 8ca:	60e2                	ld	ra,24(sp)
 8cc:	6442                	ld	s0,16(sp)
 8ce:	6161                	addi	sp,sp,80
 8d0:	8082                	ret

00000000000008d2 <printf>:

void
printf(const char *fmt, ...)
{
 8d2:	711d                	addi	sp,sp,-96
 8d4:	ec06                	sd	ra,24(sp)
 8d6:	e822                	sd	s0,16(sp)
 8d8:	1000                	addi	s0,sp,32
 8da:	e40c                	sd	a1,8(s0)
 8dc:	e810                	sd	a2,16(s0)
 8de:	ec14                	sd	a3,24(s0)
 8e0:	f018                	sd	a4,32(s0)
 8e2:	f41c                	sd	a5,40(s0)
 8e4:	03043823          	sd	a6,48(s0)
 8e8:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 8ec:	00840613          	addi	a2,s0,8
 8f0:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 8f4:	85aa                	mv	a1,a0
 8f6:	4505                	li	a0,1
 8f8:	00000097          	auipc	ra,0x0
 8fc:	dde080e7          	jalr	-546(ra) # 6d6 <vprintf>
}
 900:	60e2                	ld	ra,24(sp)
 902:	6442                	ld	s0,16(sp)
 904:	6125                	addi	sp,sp,96
 906:	8082                	ret

0000000000000908 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 908:	1141                	addi	sp,sp,-16
 90a:	e406                	sd	ra,8(sp)
 90c:	e022                	sd	s0,0(sp)
 90e:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 910:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 914:	00000797          	auipc	a5,0x0
 918:	2fc7b783          	ld	a5,764(a5) # c10 <freep>
 91c:	a039                	j	92a <free+0x22>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 91e:	6398                	ld	a4,0(a5)
 920:	00e7e463          	bltu	a5,a4,928 <free+0x20>
 924:	00e6ea63          	bltu	a3,a4,938 <free+0x30>
{
 928:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 92a:	fed7fae3          	bgeu	a5,a3,91e <free+0x16>
 92e:	6398                	ld	a4,0(a5)
 930:	00e6e463          	bltu	a3,a4,938 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 934:	fee7eae3          	bltu	a5,a4,928 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 938:	ff852583          	lw	a1,-8(a0)
 93c:	6390                	ld	a2,0(a5)
 93e:	02059813          	slli	a6,a1,0x20
 942:	01c85713          	srli	a4,a6,0x1c
 946:	9736                	add	a4,a4,a3
 948:	02e60563          	beq	a2,a4,972 <free+0x6a>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 94c:	fec53823          	sd	a2,-16(a0)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 950:	4790                	lw	a2,8(a5)
 952:	02061593          	slli	a1,a2,0x20
 956:	01c5d713          	srli	a4,a1,0x1c
 95a:	973e                	add	a4,a4,a5
 95c:	02e68263          	beq	a3,a4,980 <free+0x78>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 960:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 962:	00000717          	auipc	a4,0x0
 966:	2af73723          	sd	a5,686(a4) # c10 <freep>
}
 96a:	60a2                	ld	ra,8(sp)
 96c:	6402                	ld	s0,0(sp)
 96e:	0141                	addi	sp,sp,16
 970:	8082                	ret
    bp->s.size += p->s.ptr->s.size;
 972:	4618                	lw	a4,8(a2)
 974:	9f2d                	addw	a4,a4,a1
 976:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 97a:	6398                	ld	a4,0(a5)
 97c:	6310                	ld	a2,0(a4)
 97e:	b7f9                	j	94c <free+0x44>
    p->s.size += bp->s.size;
 980:	ff852703          	lw	a4,-8(a0)
 984:	9f31                	addw	a4,a4,a2
 986:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 988:	ff053683          	ld	a3,-16(a0)
 98c:	bfd1                	j	960 <free+0x58>

000000000000098e <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 98e:	7139                	addi	sp,sp,-64
 990:	fc06                	sd	ra,56(sp)
 992:	f822                	sd	s0,48(sp)
 994:	f04a                	sd	s2,32(sp)
 996:	ec4e                	sd	s3,24(sp)
 998:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 99a:	02051993          	slli	s3,a0,0x20
 99e:	0209d993          	srli	s3,s3,0x20
 9a2:	09bd                	addi	s3,s3,15
 9a4:	0049d993          	srli	s3,s3,0x4
 9a8:	2985                	addiw	s3,s3,1
 9aa:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 9ac:	00000517          	auipc	a0,0x0
 9b0:	26453503          	ld	a0,612(a0) # c10 <freep>
 9b4:	c905                	beqz	a0,9e4 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9b6:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9b8:	4798                	lw	a4,8(a5)
 9ba:	09377a63          	bgeu	a4,s3,a4e <malloc+0xc0>
 9be:	f426                	sd	s1,40(sp)
 9c0:	e852                	sd	s4,16(sp)
 9c2:	e456                	sd	s5,8(sp)
 9c4:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 9c6:	8a4e                	mv	s4,s3
 9c8:	6705                	lui	a4,0x1
 9ca:	00e9f363          	bgeu	s3,a4,9d0 <malloc+0x42>
 9ce:	6a05                	lui	s4,0x1
 9d0:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 9d4:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 9d8:	00000497          	auipc	s1,0x0
 9dc:	23848493          	addi	s1,s1,568 # c10 <freep>
  if(p == (char*)-1)
 9e0:	5afd                	li	s5,-1
 9e2:	a089                	j	a24 <malloc+0x96>
 9e4:	f426                	sd	s1,40(sp)
 9e6:	e852                	sd	s4,16(sp)
 9e8:	e456                	sd	s5,8(sp)
 9ea:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 9ec:	00000797          	auipc	a5,0x0
 9f0:	22c78793          	addi	a5,a5,556 # c18 <base>
 9f4:	00000717          	auipc	a4,0x0
 9f8:	20f73e23          	sd	a5,540(a4) # c10 <freep>
 9fc:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 9fe:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 a02:	b7d1                	j	9c6 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 a04:	6398                	ld	a4,0(a5)
 a06:	e118                	sd	a4,0(a0)
 a08:	a8b9                	j	a66 <malloc+0xd8>
  hp->s.size = nu;
 a0a:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 a0e:	0541                	addi	a0,a0,16
 a10:	00000097          	auipc	ra,0x0
 a14:	ef8080e7          	jalr	-264(ra) # 908 <free>
  return freep;
 a18:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 a1a:	c135                	beqz	a0,a7e <malloc+0xf0>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a1c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a1e:	4798                	lw	a4,8(a5)
 a20:	03277363          	bgeu	a4,s2,a46 <malloc+0xb8>
    if(p == freep)
 a24:	6098                	ld	a4,0(s1)
 a26:	853e                	mv	a0,a5
 a28:	fef71ae3          	bne	a4,a5,a1c <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 a2c:	8552                	mv	a0,s4
 a2e:	00000097          	auipc	ra,0x0
 a32:	bbe080e7          	jalr	-1090(ra) # 5ec <sbrk>
  if(p == (char*)-1)
 a36:	fd551ae3          	bne	a0,s5,a0a <malloc+0x7c>
        return 0;
 a3a:	4501                	li	a0,0
 a3c:	74a2                	ld	s1,40(sp)
 a3e:	6a42                	ld	s4,16(sp)
 a40:	6aa2                	ld	s5,8(sp)
 a42:	6b02                	ld	s6,0(sp)
 a44:	a03d                	j	a72 <malloc+0xe4>
 a46:	74a2                	ld	s1,40(sp)
 a48:	6a42                	ld	s4,16(sp)
 a4a:	6aa2                	ld	s5,8(sp)
 a4c:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 a4e:	fae90be3          	beq	s2,a4,a04 <malloc+0x76>
        p->s.size -= nunits;
 a52:	4137073b          	subw	a4,a4,s3
 a56:	c798                	sw	a4,8(a5)
        p += p->s.size;
 a58:	02071693          	slli	a3,a4,0x20
 a5c:	01c6d713          	srli	a4,a3,0x1c
 a60:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 a62:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 a66:	00000717          	auipc	a4,0x0
 a6a:	1aa73523          	sd	a0,426(a4) # c10 <freep>
      return (void*)(p + 1);
 a6e:	01078513          	addi	a0,a5,16
  }
}
 a72:	70e2                	ld	ra,56(sp)
 a74:	7442                	ld	s0,48(sp)
 a76:	7902                	ld	s2,32(sp)
 a78:	69e2                	ld	s3,24(sp)
 a7a:	6121                	addi	sp,sp,64
 a7c:	8082                	ret
 a7e:	74a2                	ld	s1,40(sp)
 a80:	6a42                	ld	s4,16(sp)
 a82:	6aa2                	ld	s5,8(sp)
 a84:	6b02                	ld	s6,0(sp)
 a86:	b7f5                	j	a72 <malloc+0xe4>
