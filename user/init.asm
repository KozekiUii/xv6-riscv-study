
user/_init：     文件格式 elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/fcntl.h"

char *argv[] = {"sh", 0};

int main(void)
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	e04a                	sd	s2,0(sp)
   a:	1000                	addi	s0,sp,32
  int pid, wpid;

  if (open("console", O_RDWR) < 0)
   c:	4589                	li	a1,2
   e:	00001517          	auipc	a0,0x1
  12:	88a50513          	addi	a0,a0,-1910 # 898 <malloc+0xfa>
  16:	00000097          	auipc	ra,0x0
  1a:	39e080e7          	jalr	926(ra) # 3b4 <open>
  1e:	04054a63          	bltz	a0,72 <main+0x72>
  {
    mknod("console", 1, 1);
    open("console", O_RDWR);
  }
  dup(0); // stdout
  22:	4501                	li	a0,0
  24:	00000097          	auipc	ra,0x0
  28:	3c8080e7          	jalr	968(ra) # 3ec <dup>
  dup(0); // stderr
  2c:	4501                	li	a0,0
  2e:	00000097          	auipc	ra,0x0
  32:	3be080e7          	jalr	958(ra) # 3ec <dup>

  for (;;)
  {
    printf("init: starting sh\n");
  36:	00001917          	auipc	s2,0x1
  3a:	86a90913          	addi	s2,s2,-1942 # 8a0 <malloc+0x102>
  3e:	854a                	mv	a0,s2
  40:	00000097          	auipc	ra,0x0
  44:	6a2080e7          	jalr	1698(ra) # 6e2 <printf>
    pid = fork();
  48:	00000097          	auipc	ra,0x0
  4c:	324080e7          	jalr	804(ra) # 36c <fork>
  50:	84aa                	mv	s1,a0
    if (pid < 0)
  52:	04054463          	bltz	a0,9a <main+0x9a>
    {
      printf("init: fork failed\n");
      exit(1);
    }
    if (pid == 0)
  56:	cd39                	beqz	a0,b4 <main+0xb4>
    {
      exec("sh", argv);
      printf("init: exec sh failed\n");
      exit(1);
    }
    while ((wpid = wait(0)) >= 0 && wpid != pid)
  58:	4501                	li	a0,0
  5a:	00000097          	auipc	ra,0x0
  5e:	322080e7          	jalr	802(ra) # 37c <wait>
  62:	fca48ee3          	beq	s1,a0,3e <main+0x3e>
  66:	fff54513          	not	a0,a0
  6a:	01f5551b          	srliw	a0,a0,0x1f
  6e:	f56d                	bnez	a0,58 <main+0x58>
  70:	b7f9                	j	3e <main+0x3e>
    mknod("console", 1, 1);
  72:	4605                	li	a2,1
  74:	85b2                	mv	a1,a2
  76:	00001517          	auipc	a0,0x1
  7a:	82250513          	addi	a0,a0,-2014 # 898 <malloc+0xfa>
  7e:	00000097          	auipc	ra,0x0
  82:	33e080e7          	jalr	830(ra) # 3bc <mknod>
    open("console", O_RDWR);
  86:	4589                	li	a1,2
  88:	00001517          	auipc	a0,0x1
  8c:	81050513          	addi	a0,a0,-2032 # 898 <malloc+0xfa>
  90:	00000097          	auipc	ra,0x0
  94:	324080e7          	jalr	804(ra) # 3b4 <open>
  98:	b769                	j	22 <main+0x22>
      printf("init: fork failed\n");
  9a:	00001517          	auipc	a0,0x1
  9e:	81e50513          	addi	a0,a0,-2018 # 8b8 <malloc+0x11a>
  a2:	00000097          	auipc	ra,0x0
  a6:	640080e7          	jalr	1600(ra) # 6e2 <printf>
      exit(1);
  aa:	4505                	li	a0,1
  ac:	00000097          	auipc	ra,0x0
  b0:	2c8080e7          	jalr	712(ra) # 374 <exit>
      exec("sh", argv);
  b4:	00001597          	auipc	a1,0x1
  b8:	8b458593          	addi	a1,a1,-1868 # 968 <argv>
  bc:	00001517          	auipc	a0,0x1
  c0:	81450513          	addi	a0,a0,-2028 # 8d0 <malloc+0x132>
  c4:	00000097          	auipc	ra,0x0
  c8:	2e8080e7          	jalr	744(ra) # 3ac <exec>
      printf("init: exec sh failed\n");
  cc:	00001517          	auipc	a0,0x1
  d0:	80c50513          	addi	a0,a0,-2036 # 8d8 <malloc+0x13a>
  d4:	00000097          	auipc	ra,0x0
  d8:	60e080e7          	jalr	1550(ra) # 6e2 <printf>
      exit(1);
  dc:	4505                	li	a0,1
  de:	00000097          	auipc	ra,0x0
  e2:	296080e7          	jalr	662(ra) # 374 <exit>

00000000000000e6 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
  e6:	1141                	addi	sp,sp,-16
  e8:	e406                	sd	ra,8(sp)
  ea:	e022                	sd	s0,0(sp)
  ec:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  ee:	87aa                	mv	a5,a0
  f0:	0585                	addi	a1,a1,1
  f2:	0785                	addi	a5,a5,1
  f4:	fff5c703          	lbu	a4,-1(a1)
  f8:	fee78fa3          	sb	a4,-1(a5)
  fc:	fb75                	bnez	a4,f0 <strcpy+0xa>
    ;
  return os;
}
  fe:	60a2                	ld	ra,8(sp)
 100:	6402                	ld	s0,0(sp)
 102:	0141                	addi	sp,sp,16
 104:	8082                	ret

0000000000000106 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 106:	1141                	addi	sp,sp,-16
 108:	e406                	sd	ra,8(sp)
 10a:	e022                	sd	s0,0(sp)
 10c:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 10e:	00054783          	lbu	a5,0(a0)
 112:	cb91                	beqz	a5,126 <strcmp+0x20>
 114:	0005c703          	lbu	a4,0(a1)
 118:	00f71763          	bne	a4,a5,126 <strcmp+0x20>
    p++, q++;
 11c:	0505                	addi	a0,a0,1
 11e:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 120:	00054783          	lbu	a5,0(a0)
 124:	fbe5                	bnez	a5,114 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 126:	0005c503          	lbu	a0,0(a1)
}
 12a:	40a7853b          	subw	a0,a5,a0
 12e:	60a2                	ld	ra,8(sp)
 130:	6402                	ld	s0,0(sp)
 132:	0141                	addi	sp,sp,16
 134:	8082                	ret

0000000000000136 <strlen>:

uint
strlen(const char *s)
{
 136:	1141                	addi	sp,sp,-16
 138:	e406                	sd	ra,8(sp)
 13a:	e022                	sd	s0,0(sp)
 13c:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 13e:	00054783          	lbu	a5,0(a0)
 142:	cf91                	beqz	a5,15e <strlen+0x28>
 144:	00150793          	addi	a5,a0,1
 148:	86be                	mv	a3,a5
 14a:	0785                	addi	a5,a5,1
 14c:	fff7c703          	lbu	a4,-1(a5)
 150:	ff65                	bnez	a4,148 <strlen+0x12>
 152:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
 156:	60a2                	ld	ra,8(sp)
 158:	6402                	ld	s0,0(sp)
 15a:	0141                	addi	sp,sp,16
 15c:	8082                	ret
  for(n = 0; s[n]; n++)
 15e:	4501                	li	a0,0
 160:	bfdd                	j	156 <strlen+0x20>

0000000000000162 <memset>:

void*
memset(void *dst, int c, uint n)
{
 162:	1141                	addi	sp,sp,-16
 164:	e406                	sd	ra,8(sp)
 166:	e022                	sd	s0,0(sp)
 168:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 16a:	ca19                	beqz	a2,180 <memset+0x1e>
 16c:	87aa                	mv	a5,a0
 16e:	1602                	slli	a2,a2,0x20
 170:	9201                	srli	a2,a2,0x20
 172:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 176:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 17a:	0785                	addi	a5,a5,1
 17c:	fee79de3          	bne	a5,a4,176 <memset+0x14>
  }
  return dst;
}
 180:	60a2                	ld	ra,8(sp)
 182:	6402                	ld	s0,0(sp)
 184:	0141                	addi	sp,sp,16
 186:	8082                	ret

0000000000000188 <strchr>:

char*
strchr(const char *s, char c)
{
 188:	1141                	addi	sp,sp,-16
 18a:	e406                	sd	ra,8(sp)
 18c:	e022                	sd	s0,0(sp)
 18e:	0800                	addi	s0,sp,16
  for(; *s; s++)
 190:	00054783          	lbu	a5,0(a0)
 194:	cf81                	beqz	a5,1ac <strchr+0x24>
    if(*s == c)
 196:	00f58763          	beq	a1,a5,1a4 <strchr+0x1c>
  for(; *s; s++)
 19a:	0505                	addi	a0,a0,1
 19c:	00054783          	lbu	a5,0(a0)
 1a0:	fbfd                	bnez	a5,196 <strchr+0xe>
      return (char*)s;
  return 0;
 1a2:	4501                	li	a0,0
}
 1a4:	60a2                	ld	ra,8(sp)
 1a6:	6402                	ld	s0,0(sp)
 1a8:	0141                	addi	sp,sp,16
 1aa:	8082                	ret
  return 0;
 1ac:	4501                	li	a0,0
 1ae:	bfdd                	j	1a4 <strchr+0x1c>

00000000000001b0 <gets>:

char*
gets(char *buf, int max)
{
 1b0:	711d                	addi	sp,sp,-96
 1b2:	ec86                	sd	ra,88(sp)
 1b4:	e8a2                	sd	s0,80(sp)
 1b6:	e4a6                	sd	s1,72(sp)
 1b8:	e0ca                	sd	s2,64(sp)
 1ba:	fc4e                	sd	s3,56(sp)
 1bc:	f852                	sd	s4,48(sp)
 1be:	f456                	sd	s5,40(sp)
 1c0:	f05a                	sd	s6,32(sp)
 1c2:	ec5e                	sd	s7,24(sp)
 1c4:	e862                	sd	s8,16(sp)
 1c6:	1080                	addi	s0,sp,96
 1c8:	8baa                	mv	s7,a0
 1ca:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1cc:	892a                	mv	s2,a0
 1ce:	4481                	li	s1,0
    cc = read(0, &c, 1);
 1d0:	faf40b13          	addi	s6,s0,-81
 1d4:	4a85                	li	s5,1
  for(i=0; i+1 < max; ){
 1d6:	8c26                	mv	s8,s1
 1d8:	0014899b          	addiw	s3,s1,1
 1dc:	84ce                	mv	s1,s3
 1de:	0349d663          	bge	s3,s4,20a <gets+0x5a>
    cc = read(0, &c, 1);
 1e2:	8656                	mv	a2,s5
 1e4:	85da                	mv	a1,s6
 1e6:	4501                	li	a0,0
 1e8:	00000097          	auipc	ra,0x0
 1ec:	1a4080e7          	jalr	420(ra) # 38c <read>
    if(cc < 1)
 1f0:	00a05d63          	blez	a0,20a <gets+0x5a>
      break;
    buf[i++] = c;
 1f4:	faf44783          	lbu	a5,-81(s0)
 1f8:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 1fc:	0905                	addi	s2,s2,1
 1fe:	ff678713          	addi	a4,a5,-10
 202:	c319                	beqz	a4,208 <gets+0x58>
 204:	17cd                	addi	a5,a5,-13
 206:	fbe1                	bnez	a5,1d6 <gets+0x26>
    buf[i++] = c;
 208:	8c4e                	mv	s8,s3
      break;
  }
  buf[i] = '\0';
 20a:	9c5e                	add	s8,s8,s7
 20c:	000c0023          	sb	zero,0(s8)
  return buf;
}
 210:	855e                	mv	a0,s7
 212:	60e6                	ld	ra,88(sp)
 214:	6446                	ld	s0,80(sp)
 216:	64a6                	ld	s1,72(sp)
 218:	6906                	ld	s2,64(sp)
 21a:	79e2                	ld	s3,56(sp)
 21c:	7a42                	ld	s4,48(sp)
 21e:	7aa2                	ld	s5,40(sp)
 220:	7b02                	ld	s6,32(sp)
 222:	6be2                	ld	s7,24(sp)
 224:	6c42                	ld	s8,16(sp)
 226:	6125                	addi	sp,sp,96
 228:	8082                	ret

000000000000022a <stat>:

int
stat(const char *n, struct stat *st)
{
 22a:	1101                	addi	sp,sp,-32
 22c:	ec06                	sd	ra,24(sp)
 22e:	e822                	sd	s0,16(sp)
 230:	e04a                	sd	s2,0(sp)
 232:	1000                	addi	s0,sp,32
 234:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 236:	4581                	li	a1,0
 238:	00000097          	auipc	ra,0x0
 23c:	17c080e7          	jalr	380(ra) # 3b4 <open>
  if(fd < 0)
 240:	02054663          	bltz	a0,26c <stat+0x42>
 244:	e426                	sd	s1,8(sp)
 246:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 248:	85ca                	mv	a1,s2
 24a:	00000097          	auipc	ra,0x0
 24e:	182080e7          	jalr	386(ra) # 3cc <fstat>
 252:	892a                	mv	s2,a0
  close(fd);
 254:	8526                	mv	a0,s1
 256:	00000097          	auipc	ra,0x0
 25a:	146080e7          	jalr	326(ra) # 39c <close>
  return r;
 25e:	64a2                	ld	s1,8(sp)
}
 260:	854a                	mv	a0,s2
 262:	60e2                	ld	ra,24(sp)
 264:	6442                	ld	s0,16(sp)
 266:	6902                	ld	s2,0(sp)
 268:	6105                	addi	sp,sp,32
 26a:	8082                	ret
    return -1;
 26c:	57fd                	li	a5,-1
 26e:	893e                	mv	s2,a5
 270:	bfc5                	j	260 <stat+0x36>

0000000000000272 <atoi>:

int
atoi(const char *s)
{
 272:	1141                	addi	sp,sp,-16
 274:	e406                	sd	ra,8(sp)
 276:	e022                	sd	s0,0(sp)
 278:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 27a:	00054683          	lbu	a3,0(a0)
 27e:	fd06879b          	addiw	a5,a3,-48
 282:	0ff7f793          	zext.b	a5,a5
 286:	4625                	li	a2,9
 288:	02f66963          	bltu	a2,a5,2ba <atoi+0x48>
 28c:	872a                	mv	a4,a0
  n = 0;
 28e:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 290:	0705                	addi	a4,a4,1
 292:	0025179b          	slliw	a5,a0,0x2
 296:	9fa9                	addw	a5,a5,a0
 298:	0017979b          	slliw	a5,a5,0x1
 29c:	9fb5                	addw	a5,a5,a3
 29e:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 2a2:	00074683          	lbu	a3,0(a4)
 2a6:	fd06879b          	addiw	a5,a3,-48
 2aa:	0ff7f793          	zext.b	a5,a5
 2ae:	fef671e3          	bgeu	a2,a5,290 <atoi+0x1e>
  return n;
}
 2b2:	60a2                	ld	ra,8(sp)
 2b4:	6402                	ld	s0,0(sp)
 2b6:	0141                	addi	sp,sp,16
 2b8:	8082                	ret
  n = 0;
 2ba:	4501                	li	a0,0
 2bc:	bfdd                	j	2b2 <atoi+0x40>

00000000000002be <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2be:	1141                	addi	sp,sp,-16
 2c0:	e406                	sd	ra,8(sp)
 2c2:	e022                	sd	s0,0(sp)
 2c4:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 2c6:	02b57563          	bgeu	a0,a1,2f0 <memmove+0x32>
    while(n-- > 0)
 2ca:	00c05f63          	blez	a2,2e8 <memmove+0x2a>
 2ce:	1602                	slli	a2,a2,0x20
 2d0:	9201                	srli	a2,a2,0x20
 2d2:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 2d6:	872a                	mv	a4,a0
      *dst++ = *src++;
 2d8:	0585                	addi	a1,a1,1
 2da:	0705                	addi	a4,a4,1
 2dc:	fff5c683          	lbu	a3,-1(a1)
 2e0:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 2e4:	fee79ae3          	bne	a5,a4,2d8 <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 2e8:	60a2                	ld	ra,8(sp)
 2ea:	6402                	ld	s0,0(sp)
 2ec:	0141                	addi	sp,sp,16
 2ee:	8082                	ret
    while(n-- > 0)
 2f0:	fec05ce3          	blez	a2,2e8 <memmove+0x2a>
    dst += n;
 2f4:	00c50733          	add	a4,a0,a2
    src += n;
 2f8:	95b2                	add	a1,a1,a2
 2fa:	fff6079b          	addiw	a5,a2,-1
 2fe:	1782                	slli	a5,a5,0x20
 300:	9381                	srli	a5,a5,0x20
 302:	fff7c793          	not	a5,a5
 306:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 308:	15fd                	addi	a1,a1,-1
 30a:	177d                	addi	a4,a4,-1
 30c:	0005c683          	lbu	a3,0(a1)
 310:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 314:	fef71ae3          	bne	a4,a5,308 <memmove+0x4a>
 318:	bfc1                	j	2e8 <memmove+0x2a>

000000000000031a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 31a:	1141                	addi	sp,sp,-16
 31c:	e406                	sd	ra,8(sp)
 31e:	e022                	sd	s0,0(sp)
 320:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 322:	c61d                	beqz	a2,350 <memcmp+0x36>
 324:	1602                	slli	a2,a2,0x20
 326:	9201                	srli	a2,a2,0x20
 328:	00c506b3          	add	a3,a0,a2
    if (*p1 != *p2) {
 32c:	00054783          	lbu	a5,0(a0)
 330:	0005c703          	lbu	a4,0(a1)
 334:	00e79863          	bne	a5,a4,344 <memcmp+0x2a>
      return *p1 - *p2;
    }
    p1++;
 338:	0505                	addi	a0,a0,1
    p2++;
 33a:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 33c:	fed518e3          	bne	a0,a3,32c <memcmp+0x12>
  }
  return 0;
 340:	4501                	li	a0,0
 342:	a019                	j	348 <memcmp+0x2e>
      return *p1 - *p2;
 344:	40e7853b          	subw	a0,a5,a4
}
 348:	60a2                	ld	ra,8(sp)
 34a:	6402                	ld	s0,0(sp)
 34c:	0141                	addi	sp,sp,16
 34e:	8082                	ret
  return 0;
 350:	4501                	li	a0,0
 352:	bfdd                	j	348 <memcmp+0x2e>

0000000000000354 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 354:	1141                	addi	sp,sp,-16
 356:	e406                	sd	ra,8(sp)
 358:	e022                	sd	s0,0(sp)
 35a:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 35c:	00000097          	auipc	ra,0x0
 360:	f62080e7          	jalr	-158(ra) # 2be <memmove>
}
 364:	60a2                	ld	ra,8(sp)
 366:	6402                	ld	s0,0(sp)
 368:	0141                	addi	sp,sp,16
 36a:	8082                	ret

000000000000036c <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 36c:	4885                	li	a7,1
 ecall
 36e:	00000073          	ecall
 ret
 372:	8082                	ret

0000000000000374 <exit>:
.global exit
exit:
 li a7, SYS_exit
 374:	4889                	li	a7,2
 ecall
 376:	00000073          	ecall
 ret
 37a:	8082                	ret

000000000000037c <wait>:
.global wait
wait:
 li a7, SYS_wait
 37c:	488d                	li	a7,3
 ecall
 37e:	00000073          	ecall
 ret
 382:	8082                	ret

0000000000000384 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 384:	4891                	li	a7,4
 ecall
 386:	00000073          	ecall
 ret
 38a:	8082                	ret

000000000000038c <read>:
.global read
read:
 li a7, SYS_read
 38c:	4895                	li	a7,5
 ecall
 38e:	00000073          	ecall
 ret
 392:	8082                	ret

0000000000000394 <write>:
.global write
write:
 li a7, SYS_write
 394:	48c1                	li	a7,16
 ecall
 396:	00000073          	ecall
 ret
 39a:	8082                	ret

000000000000039c <close>:
.global close
close:
 li a7, SYS_close
 39c:	48d5                	li	a7,21
 ecall
 39e:	00000073          	ecall
 ret
 3a2:	8082                	ret

00000000000003a4 <kill>:
.global kill
kill:
 li a7, SYS_kill
 3a4:	4899                	li	a7,6
 ecall
 3a6:	00000073          	ecall
 ret
 3aa:	8082                	ret

00000000000003ac <exec>:
.global exec
exec:
 li a7, SYS_exec
 3ac:	489d                	li	a7,7
 ecall
 3ae:	00000073          	ecall
 ret
 3b2:	8082                	ret

00000000000003b4 <open>:
.global open
open:
 li a7, SYS_open
 3b4:	48bd                	li	a7,15
 ecall
 3b6:	00000073          	ecall
 ret
 3ba:	8082                	ret

00000000000003bc <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 3bc:	48c5                	li	a7,17
 ecall
 3be:	00000073          	ecall
 ret
 3c2:	8082                	ret

00000000000003c4 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 3c4:	48c9                	li	a7,18
 ecall
 3c6:	00000073          	ecall
 ret
 3ca:	8082                	ret

00000000000003cc <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 3cc:	48a1                	li	a7,8
 ecall
 3ce:	00000073          	ecall
 ret
 3d2:	8082                	ret

00000000000003d4 <link>:
.global link
link:
 li a7, SYS_link
 3d4:	48cd                	li	a7,19
 ecall
 3d6:	00000073          	ecall
 ret
 3da:	8082                	ret

00000000000003dc <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3dc:	48d1                	li	a7,20
 ecall
 3de:	00000073          	ecall
 ret
 3e2:	8082                	ret

00000000000003e4 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 3e4:	48a5                	li	a7,9
 ecall
 3e6:	00000073          	ecall
 ret
 3ea:	8082                	ret

00000000000003ec <dup>:
.global dup
dup:
 li a7, SYS_dup
 3ec:	48a9                	li	a7,10
 ecall
 3ee:	00000073          	ecall
 ret
 3f2:	8082                	ret

00000000000003f4 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 3f4:	48ad                	li	a7,11
 ecall
 3f6:	00000073          	ecall
 ret
 3fa:	8082                	ret

00000000000003fc <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 3fc:	48b1                	li	a7,12
 ecall
 3fe:	00000073          	ecall
 ret
 402:	8082                	ret

0000000000000404 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 404:	48b5                	li	a7,13
 ecall
 406:	00000073          	ecall
 ret
 40a:	8082                	ret

000000000000040c <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 40c:	48b9                	li	a7,14
 ecall
 40e:	00000073          	ecall
 ret
 412:	8082                	ret

0000000000000414 <ntas>:
.global ntas
ntas:
 li a7, SYS_ntas
 414:	48d9                	li	a7,22
 ecall
 416:	00000073          	ecall
 ret
 41a:	8082                	ret

000000000000041c <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 41c:	1101                	addi	sp,sp,-32
 41e:	ec06                	sd	ra,24(sp)
 420:	e822                	sd	s0,16(sp)
 422:	1000                	addi	s0,sp,32
 424:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 428:	4605                	li	a2,1
 42a:	fef40593          	addi	a1,s0,-17
 42e:	00000097          	auipc	ra,0x0
 432:	f66080e7          	jalr	-154(ra) # 394 <write>
}
 436:	60e2                	ld	ra,24(sp)
 438:	6442                	ld	s0,16(sp)
 43a:	6105                	addi	sp,sp,32
 43c:	8082                	ret

000000000000043e <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 43e:	7139                	addi	sp,sp,-64
 440:	fc06                	sd	ra,56(sp)
 442:	f822                	sd	s0,48(sp)
 444:	f04a                	sd	s2,32(sp)
 446:	ec4e                	sd	s3,24(sp)
 448:	0080                	addi	s0,sp,64
 44a:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 44c:	cad9                	beqz	a3,4e2 <printint+0xa4>
 44e:	01f5d79b          	srliw	a5,a1,0x1f
 452:	cbc1                	beqz	a5,4e2 <printint+0xa4>
    neg = 1;
    x = -xx;
 454:	40b005bb          	negw	a1,a1
    neg = 1;
 458:	4305                	li	t1,1
  } else {
    x = xx;
  }

  i = 0;
 45a:	fc040993          	addi	s3,s0,-64
  neg = 0;
 45e:	86ce                	mv	a3,s3
  i = 0;
 460:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 462:	00000817          	auipc	a6,0x0
 466:	4ee80813          	addi	a6,a6,1262 # 950 <digits>
 46a:	88ba                	mv	a7,a4
 46c:	0017051b          	addiw	a0,a4,1
 470:	872a                	mv	a4,a0
 472:	02c5f7bb          	remuw	a5,a1,a2
 476:	1782                	slli	a5,a5,0x20
 478:	9381                	srli	a5,a5,0x20
 47a:	97c2                	add	a5,a5,a6
 47c:	0007c783          	lbu	a5,0(a5)
 480:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 484:	87ae                	mv	a5,a1
 486:	02c5d5bb          	divuw	a1,a1,a2
 48a:	0685                	addi	a3,a3,1
 48c:	fcc7ffe3          	bgeu	a5,a2,46a <printint+0x2c>
  if(neg)
 490:	00030c63          	beqz	t1,4a8 <printint+0x6a>
    buf[i++] = '-';
 494:	fd050793          	addi	a5,a0,-48
 498:	00878533          	add	a0,a5,s0
 49c:	02d00793          	li	a5,45
 4a0:	fef50823          	sb	a5,-16(a0)
 4a4:	0028871b          	addiw	a4,a7,2

  while(--i >= 0)
 4a8:	02e05763          	blez	a4,4d6 <printint+0x98>
 4ac:	f426                	sd	s1,40(sp)
 4ae:	377d                	addiw	a4,a4,-1
 4b0:	00e984b3          	add	s1,s3,a4
 4b4:	19fd                	addi	s3,s3,-1
 4b6:	99ba                	add	s3,s3,a4
 4b8:	1702                	slli	a4,a4,0x20
 4ba:	9301                	srli	a4,a4,0x20
 4bc:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 4c0:	0004c583          	lbu	a1,0(s1)
 4c4:	854a                	mv	a0,s2
 4c6:	00000097          	auipc	ra,0x0
 4ca:	f56080e7          	jalr	-170(ra) # 41c <putc>
  while(--i >= 0)
 4ce:	14fd                	addi	s1,s1,-1
 4d0:	ff3498e3          	bne	s1,s3,4c0 <printint+0x82>
 4d4:	74a2                	ld	s1,40(sp)
}
 4d6:	70e2                	ld	ra,56(sp)
 4d8:	7442                	ld	s0,48(sp)
 4da:	7902                	ld	s2,32(sp)
 4dc:	69e2                	ld	s3,24(sp)
 4de:	6121                	addi	sp,sp,64
 4e0:	8082                	ret
  neg = 0;
 4e2:	4301                	li	t1,0
 4e4:	bf9d                	j	45a <printint+0x1c>

00000000000004e6 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 4e6:	715d                	addi	sp,sp,-80
 4e8:	e486                	sd	ra,72(sp)
 4ea:	e0a2                	sd	s0,64(sp)
 4ec:	f84a                	sd	s2,48(sp)
 4ee:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 4f0:	0005c903          	lbu	s2,0(a1)
 4f4:	1a090b63          	beqz	s2,6aa <vprintf+0x1c4>
 4f8:	fc26                	sd	s1,56(sp)
 4fa:	f44e                	sd	s3,40(sp)
 4fc:	f052                	sd	s4,32(sp)
 4fe:	ec56                	sd	s5,24(sp)
 500:	e85a                	sd	s6,16(sp)
 502:	e45e                	sd	s7,8(sp)
 504:	8aaa                	mv	s5,a0
 506:	8bb2                	mv	s7,a2
 508:	00158493          	addi	s1,a1,1
  state = 0;
 50c:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 50e:	02500a13          	li	s4,37
 512:	4b55                	li	s6,21
 514:	a839                	j	532 <vprintf+0x4c>
        putc(fd, c);
 516:	85ca                	mv	a1,s2
 518:	8556                	mv	a0,s5
 51a:	00000097          	auipc	ra,0x0
 51e:	f02080e7          	jalr	-254(ra) # 41c <putc>
 522:	a019                	j	528 <vprintf+0x42>
    } else if(state == '%'){
 524:	01498d63          	beq	s3,s4,53e <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
 528:	0485                	addi	s1,s1,1
 52a:	fff4c903          	lbu	s2,-1(s1)
 52e:	16090863          	beqz	s2,69e <vprintf+0x1b8>
    if(state == 0){
 532:	fe0999e3          	bnez	s3,524 <vprintf+0x3e>
      if(c == '%'){
 536:	ff4910e3          	bne	s2,s4,516 <vprintf+0x30>
        state = '%';
 53a:	89d2                	mv	s3,s4
 53c:	b7f5                	j	528 <vprintf+0x42>
      if(c == 'd'){
 53e:	13490563          	beq	s2,s4,668 <vprintf+0x182>
 542:	f9d9079b          	addiw	a5,s2,-99
 546:	0ff7f793          	zext.b	a5,a5
 54a:	12fb6863          	bltu	s6,a5,67a <vprintf+0x194>
 54e:	f9d9079b          	addiw	a5,s2,-99
 552:	0ff7f713          	zext.b	a4,a5
 556:	12eb6263          	bltu	s6,a4,67a <vprintf+0x194>
 55a:	00271793          	slli	a5,a4,0x2
 55e:	00000717          	auipc	a4,0x0
 562:	39a70713          	addi	a4,a4,922 # 8f8 <malloc+0x15a>
 566:	97ba                	add	a5,a5,a4
 568:	439c                	lw	a5,0(a5)
 56a:	97ba                	add	a5,a5,a4
 56c:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 56e:	008b8913          	addi	s2,s7,8
 572:	4685                	li	a3,1
 574:	4629                	li	a2,10
 576:	000ba583          	lw	a1,0(s7)
 57a:	8556                	mv	a0,s5
 57c:	00000097          	auipc	ra,0x0
 580:	ec2080e7          	jalr	-318(ra) # 43e <printint>
 584:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 586:	4981                	li	s3,0
 588:	b745                	j	528 <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
 58a:	008b8913          	addi	s2,s7,8
 58e:	4681                	li	a3,0
 590:	4629                	li	a2,10
 592:	000ba583          	lw	a1,0(s7)
 596:	8556                	mv	a0,s5
 598:	00000097          	auipc	ra,0x0
 59c:	ea6080e7          	jalr	-346(ra) # 43e <printint>
 5a0:	8bca                	mv	s7,s2
      state = 0;
 5a2:	4981                	li	s3,0
 5a4:	b751                	j	528 <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
 5a6:	008b8913          	addi	s2,s7,8
 5aa:	4681                	li	a3,0
 5ac:	4641                	li	a2,16
 5ae:	000ba583          	lw	a1,0(s7)
 5b2:	8556                	mv	a0,s5
 5b4:	00000097          	auipc	ra,0x0
 5b8:	e8a080e7          	jalr	-374(ra) # 43e <printint>
 5bc:	8bca                	mv	s7,s2
      state = 0;
 5be:	4981                	li	s3,0
 5c0:	b7a5                	j	528 <vprintf+0x42>
 5c2:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
 5c4:	008b8793          	addi	a5,s7,8
 5c8:	8c3e                	mv	s8,a5
 5ca:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 5ce:	03000593          	li	a1,48
 5d2:	8556                	mv	a0,s5
 5d4:	00000097          	auipc	ra,0x0
 5d8:	e48080e7          	jalr	-440(ra) # 41c <putc>
  putc(fd, 'x');
 5dc:	07800593          	li	a1,120
 5e0:	8556                	mv	a0,s5
 5e2:	00000097          	auipc	ra,0x0
 5e6:	e3a080e7          	jalr	-454(ra) # 41c <putc>
 5ea:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 5ec:	00000b97          	auipc	s7,0x0
 5f0:	364b8b93          	addi	s7,s7,868 # 950 <digits>
 5f4:	03c9d793          	srli	a5,s3,0x3c
 5f8:	97de                	add	a5,a5,s7
 5fa:	0007c583          	lbu	a1,0(a5)
 5fe:	8556                	mv	a0,s5
 600:	00000097          	auipc	ra,0x0
 604:	e1c080e7          	jalr	-484(ra) # 41c <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 608:	0992                	slli	s3,s3,0x4
 60a:	397d                	addiw	s2,s2,-1
 60c:	fe0914e3          	bnez	s2,5f4 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
 610:	8be2                	mv	s7,s8
      state = 0;
 612:	4981                	li	s3,0
 614:	6c02                	ld	s8,0(sp)
 616:	bf09                	j	528 <vprintf+0x42>
        s = va_arg(ap, char*);
 618:	008b8993          	addi	s3,s7,8
 61c:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 620:	02090163          	beqz	s2,642 <vprintf+0x15c>
        while(*s != 0){
 624:	00094583          	lbu	a1,0(s2)
 628:	c9a5                	beqz	a1,698 <vprintf+0x1b2>
          putc(fd, *s);
 62a:	8556                	mv	a0,s5
 62c:	00000097          	auipc	ra,0x0
 630:	df0080e7          	jalr	-528(ra) # 41c <putc>
          s++;
 634:	0905                	addi	s2,s2,1
        while(*s != 0){
 636:	00094583          	lbu	a1,0(s2)
 63a:	f9e5                	bnez	a1,62a <vprintf+0x144>
        s = va_arg(ap, char*);
 63c:	8bce                	mv	s7,s3
      state = 0;
 63e:	4981                	li	s3,0
 640:	b5e5                	j	528 <vprintf+0x42>
          s = "(null)";
 642:	00000917          	auipc	s2,0x0
 646:	2ae90913          	addi	s2,s2,686 # 8f0 <malloc+0x152>
        while(*s != 0){
 64a:	02800593          	li	a1,40
 64e:	bff1                	j	62a <vprintf+0x144>
        putc(fd, va_arg(ap, uint));
 650:	008b8913          	addi	s2,s7,8
 654:	000bc583          	lbu	a1,0(s7)
 658:	8556                	mv	a0,s5
 65a:	00000097          	auipc	ra,0x0
 65e:	dc2080e7          	jalr	-574(ra) # 41c <putc>
 662:	8bca                	mv	s7,s2
      state = 0;
 664:	4981                	li	s3,0
 666:	b5c9                	j	528 <vprintf+0x42>
        putc(fd, c);
 668:	02500593          	li	a1,37
 66c:	8556                	mv	a0,s5
 66e:	00000097          	auipc	ra,0x0
 672:	dae080e7          	jalr	-594(ra) # 41c <putc>
      state = 0;
 676:	4981                	li	s3,0
 678:	bd45                	j	528 <vprintf+0x42>
        putc(fd, '%');
 67a:	02500593          	li	a1,37
 67e:	8556                	mv	a0,s5
 680:	00000097          	auipc	ra,0x0
 684:	d9c080e7          	jalr	-612(ra) # 41c <putc>
        putc(fd, c);
 688:	85ca                	mv	a1,s2
 68a:	8556                	mv	a0,s5
 68c:	00000097          	auipc	ra,0x0
 690:	d90080e7          	jalr	-624(ra) # 41c <putc>
      state = 0;
 694:	4981                	li	s3,0
 696:	bd49                	j	528 <vprintf+0x42>
        s = va_arg(ap, char*);
 698:	8bce                	mv	s7,s3
      state = 0;
 69a:	4981                	li	s3,0
 69c:	b571                	j	528 <vprintf+0x42>
 69e:	74e2                	ld	s1,56(sp)
 6a0:	79a2                	ld	s3,40(sp)
 6a2:	7a02                	ld	s4,32(sp)
 6a4:	6ae2                	ld	s5,24(sp)
 6a6:	6b42                	ld	s6,16(sp)
 6a8:	6ba2                	ld	s7,8(sp)
    }
  }
}
 6aa:	60a6                	ld	ra,72(sp)
 6ac:	6406                	ld	s0,64(sp)
 6ae:	7942                	ld	s2,48(sp)
 6b0:	6161                	addi	sp,sp,80
 6b2:	8082                	ret

00000000000006b4 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 6b4:	715d                	addi	sp,sp,-80
 6b6:	ec06                	sd	ra,24(sp)
 6b8:	e822                	sd	s0,16(sp)
 6ba:	1000                	addi	s0,sp,32
 6bc:	e010                	sd	a2,0(s0)
 6be:	e414                	sd	a3,8(s0)
 6c0:	e818                	sd	a4,16(s0)
 6c2:	ec1c                	sd	a5,24(s0)
 6c4:	03043023          	sd	a6,32(s0)
 6c8:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 6cc:	8622                	mv	a2,s0
 6ce:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 6d2:	00000097          	auipc	ra,0x0
 6d6:	e14080e7          	jalr	-492(ra) # 4e6 <vprintf>
}
 6da:	60e2                	ld	ra,24(sp)
 6dc:	6442                	ld	s0,16(sp)
 6de:	6161                	addi	sp,sp,80
 6e0:	8082                	ret

00000000000006e2 <printf>:

void
printf(const char *fmt, ...)
{
 6e2:	711d                	addi	sp,sp,-96
 6e4:	ec06                	sd	ra,24(sp)
 6e6:	e822                	sd	s0,16(sp)
 6e8:	1000                	addi	s0,sp,32
 6ea:	e40c                	sd	a1,8(s0)
 6ec:	e810                	sd	a2,16(s0)
 6ee:	ec14                	sd	a3,24(s0)
 6f0:	f018                	sd	a4,32(s0)
 6f2:	f41c                	sd	a5,40(s0)
 6f4:	03043823          	sd	a6,48(s0)
 6f8:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 6fc:	00840613          	addi	a2,s0,8
 700:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 704:	85aa                	mv	a1,a0
 706:	4505                	li	a0,1
 708:	00000097          	auipc	ra,0x0
 70c:	dde080e7          	jalr	-546(ra) # 4e6 <vprintf>
}
 710:	60e2                	ld	ra,24(sp)
 712:	6442                	ld	s0,16(sp)
 714:	6125                	addi	sp,sp,96
 716:	8082                	ret

0000000000000718 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 718:	1141                	addi	sp,sp,-16
 71a:	e406                	sd	ra,8(sp)
 71c:	e022                	sd	s0,0(sp)
 71e:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 720:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 724:	00000797          	auipc	a5,0x0
 728:	2547b783          	ld	a5,596(a5) # 978 <freep>
 72c:	a039                	j	73a <free+0x22>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 72e:	6398                	ld	a4,0(a5)
 730:	00e7e463          	bltu	a5,a4,738 <free+0x20>
 734:	00e6ea63          	bltu	a3,a4,748 <free+0x30>
{
 738:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 73a:	fed7fae3          	bgeu	a5,a3,72e <free+0x16>
 73e:	6398                	ld	a4,0(a5)
 740:	00e6e463          	bltu	a3,a4,748 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 744:	fee7eae3          	bltu	a5,a4,738 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 748:	ff852583          	lw	a1,-8(a0)
 74c:	6390                	ld	a2,0(a5)
 74e:	02059813          	slli	a6,a1,0x20
 752:	01c85713          	srli	a4,a6,0x1c
 756:	9736                	add	a4,a4,a3
 758:	02e60563          	beq	a2,a4,782 <free+0x6a>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 75c:	fec53823          	sd	a2,-16(a0)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 760:	4790                	lw	a2,8(a5)
 762:	02061593          	slli	a1,a2,0x20
 766:	01c5d713          	srli	a4,a1,0x1c
 76a:	973e                	add	a4,a4,a5
 76c:	02e68263          	beq	a3,a4,790 <free+0x78>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 770:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 772:	00000717          	auipc	a4,0x0
 776:	20f73323          	sd	a5,518(a4) # 978 <freep>
}
 77a:	60a2                	ld	ra,8(sp)
 77c:	6402                	ld	s0,0(sp)
 77e:	0141                	addi	sp,sp,16
 780:	8082                	ret
    bp->s.size += p->s.ptr->s.size;
 782:	4618                	lw	a4,8(a2)
 784:	9f2d                	addw	a4,a4,a1
 786:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 78a:	6398                	ld	a4,0(a5)
 78c:	6310                	ld	a2,0(a4)
 78e:	b7f9                	j	75c <free+0x44>
    p->s.size += bp->s.size;
 790:	ff852703          	lw	a4,-8(a0)
 794:	9f31                	addw	a4,a4,a2
 796:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 798:	ff053683          	ld	a3,-16(a0)
 79c:	bfd1                	j	770 <free+0x58>

000000000000079e <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 79e:	7139                	addi	sp,sp,-64
 7a0:	fc06                	sd	ra,56(sp)
 7a2:	f822                	sd	s0,48(sp)
 7a4:	f04a                	sd	s2,32(sp)
 7a6:	ec4e                	sd	s3,24(sp)
 7a8:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7aa:	02051993          	slli	s3,a0,0x20
 7ae:	0209d993          	srli	s3,s3,0x20
 7b2:	09bd                	addi	s3,s3,15
 7b4:	0049d993          	srli	s3,s3,0x4
 7b8:	2985                	addiw	s3,s3,1
 7ba:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 7bc:	00000517          	auipc	a0,0x0
 7c0:	1bc53503          	ld	a0,444(a0) # 978 <freep>
 7c4:	c905                	beqz	a0,7f4 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7c6:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 7c8:	4798                	lw	a4,8(a5)
 7ca:	09377a63          	bgeu	a4,s3,85e <malloc+0xc0>
 7ce:	f426                	sd	s1,40(sp)
 7d0:	e852                	sd	s4,16(sp)
 7d2:	e456                	sd	s5,8(sp)
 7d4:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 7d6:	8a4e                	mv	s4,s3
 7d8:	6705                	lui	a4,0x1
 7da:	00e9f363          	bgeu	s3,a4,7e0 <malloc+0x42>
 7de:	6a05                	lui	s4,0x1
 7e0:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 7e4:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7e8:	00000497          	auipc	s1,0x0
 7ec:	19048493          	addi	s1,s1,400 # 978 <freep>
  if(p == (char*)-1)
 7f0:	5afd                	li	s5,-1
 7f2:	a089                	j	834 <malloc+0x96>
 7f4:	f426                	sd	s1,40(sp)
 7f6:	e852                	sd	s4,16(sp)
 7f8:	e456                	sd	s5,8(sp)
 7fa:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 7fc:	00000797          	auipc	a5,0x0
 800:	18478793          	addi	a5,a5,388 # 980 <base>
 804:	00000717          	auipc	a4,0x0
 808:	16f73a23          	sd	a5,372(a4) # 978 <freep>
 80c:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 80e:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 812:	b7d1                	j	7d6 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 814:	6398                	ld	a4,0(a5)
 816:	e118                	sd	a4,0(a0)
 818:	a8b9                	j	876 <malloc+0xd8>
  hp->s.size = nu;
 81a:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 81e:	0541                	addi	a0,a0,16
 820:	00000097          	auipc	ra,0x0
 824:	ef8080e7          	jalr	-264(ra) # 718 <free>
  return freep;
 828:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 82a:	c135                	beqz	a0,88e <malloc+0xf0>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 82c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 82e:	4798                	lw	a4,8(a5)
 830:	03277363          	bgeu	a4,s2,856 <malloc+0xb8>
    if(p == freep)
 834:	6098                	ld	a4,0(s1)
 836:	853e                	mv	a0,a5
 838:	fef71ae3          	bne	a4,a5,82c <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 83c:	8552                	mv	a0,s4
 83e:	00000097          	auipc	ra,0x0
 842:	bbe080e7          	jalr	-1090(ra) # 3fc <sbrk>
  if(p == (char*)-1)
 846:	fd551ae3          	bne	a0,s5,81a <malloc+0x7c>
        return 0;
 84a:	4501                	li	a0,0
 84c:	74a2                	ld	s1,40(sp)
 84e:	6a42                	ld	s4,16(sp)
 850:	6aa2                	ld	s5,8(sp)
 852:	6b02                	ld	s6,0(sp)
 854:	a03d                	j	882 <malloc+0xe4>
 856:	74a2                	ld	s1,40(sp)
 858:	6a42                	ld	s4,16(sp)
 85a:	6aa2                	ld	s5,8(sp)
 85c:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 85e:	fae90be3          	beq	s2,a4,814 <malloc+0x76>
        p->s.size -= nunits;
 862:	4137073b          	subw	a4,a4,s3
 866:	c798                	sw	a4,8(a5)
        p += p->s.size;
 868:	02071693          	slli	a3,a4,0x20
 86c:	01c6d713          	srli	a4,a3,0x1c
 870:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 872:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 876:	00000717          	auipc	a4,0x0
 87a:	10a73123          	sd	a0,258(a4) # 978 <freep>
      return (void*)(p + 1);
 87e:	01078513          	addi	a0,a5,16
  }
}
 882:	70e2                	ld	ra,56(sp)
 884:	7442                	ld	s0,48(sp)
 886:	7902                	ld	s2,32(sp)
 888:	69e2                	ld	s3,24(sp)
 88a:	6121                	addi	sp,sp,64
 88c:	8082                	ret
 88e:	74a2                	ld	s1,40(sp)
 890:	6a42                	ld	s4,16(sp)
 892:	6aa2                	ld	s5,8(sp)
 894:	6b02                	ld	s6,0(sp)
 896:	b7f5                	j	882 <malloc+0xe4>
