
user/_call：     文件格式 elf64-littleriscv


Disassembly of section .text:

0000000000000000 <g>:
#include "kernel/param.h"
#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int g(int x) {
   0:	1141                	addi	sp,sp,-16
   2:	e406                	sd	ra,8(sp)
   4:	e022                	sd	s0,0(sp)
   6:	0800                	addi	s0,sp,16
  return x+3;
}
   8:	250d                	addiw	a0,a0,3
   a:	60a2                	ld	ra,8(sp)
   c:	6402                	ld	s0,0(sp)
   e:	0141                	addi	sp,sp,16
  10:	8082                	ret

0000000000000012 <f>:

int f(int x) {
  12:	1141                	addi	sp,sp,-16
  14:	e406                	sd	ra,8(sp)
  16:	e022                	sd	s0,0(sp)
  18:	0800                	addi	s0,sp,16
  return g(x);
}
  1a:	250d                	addiw	a0,a0,3
  1c:	60a2                	ld	ra,8(sp)
  1e:	6402                	ld	s0,0(sp)
  20:	0141                	addi	sp,sp,16
  22:	8082                	ret

0000000000000024 <main>:

void main(void) {
  24:	1141                	addi	sp,sp,-16
  26:	e406                	sd	ra,8(sp)
  28:	e022                	sd	s0,0(sp)
  2a:	0800                	addi	s0,sp,16
  printf("%d %d\n", f(8)+1, 13);
  2c:	4635                	li	a2,13
  2e:	45b1                	li	a1,12
  30:	00000517          	auipc	a0,0x0
  34:	7d050513          	addi	a0,a0,2000 # 800 <malloc+0xfe>
  38:	00000097          	auipc	ra,0x0
  3c:	60e080e7          	jalr	1550(ra) # 646 <printf>
  exit(0);
  40:	4501                	li	a0,0
  42:	00000097          	auipc	ra,0x0
  46:	296080e7          	jalr	662(ra) # 2d8 <exit>

000000000000004a <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
  4a:	1141                	addi	sp,sp,-16
  4c:	e406                	sd	ra,8(sp)
  4e:	e022                	sd	s0,0(sp)
  50:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  52:	87aa                	mv	a5,a0
  54:	0585                	addi	a1,a1,1
  56:	0785                	addi	a5,a5,1
  58:	fff5c703          	lbu	a4,-1(a1)
  5c:	fee78fa3          	sb	a4,-1(a5)
  60:	fb75                	bnez	a4,54 <strcpy+0xa>
    ;
  return os;
}
  62:	60a2                	ld	ra,8(sp)
  64:	6402                	ld	s0,0(sp)
  66:	0141                	addi	sp,sp,16
  68:	8082                	ret

000000000000006a <strcmp>:

int
strcmp(const char *p, const char *q)
{
  6a:	1141                	addi	sp,sp,-16
  6c:	e406                	sd	ra,8(sp)
  6e:	e022                	sd	s0,0(sp)
  70:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  72:	00054783          	lbu	a5,0(a0)
  76:	cb91                	beqz	a5,8a <strcmp+0x20>
  78:	0005c703          	lbu	a4,0(a1)
  7c:	00f71763          	bne	a4,a5,8a <strcmp+0x20>
    p++, q++;
  80:	0505                	addi	a0,a0,1
  82:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  84:	00054783          	lbu	a5,0(a0)
  88:	fbe5                	bnez	a5,78 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
  8a:	0005c503          	lbu	a0,0(a1)
}
  8e:	40a7853b          	subw	a0,a5,a0
  92:	60a2                	ld	ra,8(sp)
  94:	6402                	ld	s0,0(sp)
  96:	0141                	addi	sp,sp,16
  98:	8082                	ret

000000000000009a <strlen>:

uint
strlen(const char *s)
{
  9a:	1141                	addi	sp,sp,-16
  9c:	e406                	sd	ra,8(sp)
  9e:	e022                	sd	s0,0(sp)
  a0:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  a2:	00054783          	lbu	a5,0(a0)
  a6:	cf91                	beqz	a5,c2 <strlen+0x28>
  a8:	00150793          	addi	a5,a0,1
  ac:	86be                	mv	a3,a5
  ae:	0785                	addi	a5,a5,1
  b0:	fff7c703          	lbu	a4,-1(a5)
  b4:	ff65                	bnez	a4,ac <strlen+0x12>
  b6:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
  ba:	60a2                	ld	ra,8(sp)
  bc:	6402                	ld	s0,0(sp)
  be:	0141                	addi	sp,sp,16
  c0:	8082                	ret
  for(n = 0; s[n]; n++)
  c2:	4501                	li	a0,0
  c4:	bfdd                	j	ba <strlen+0x20>

00000000000000c6 <memset>:

void*
memset(void *dst, int c, uint n)
{
  c6:	1141                	addi	sp,sp,-16
  c8:	e406                	sd	ra,8(sp)
  ca:	e022                	sd	s0,0(sp)
  cc:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
  ce:	ca19                	beqz	a2,e4 <memset+0x1e>
  d0:	87aa                	mv	a5,a0
  d2:	1602                	slli	a2,a2,0x20
  d4:	9201                	srli	a2,a2,0x20
  d6:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
  da:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
  de:	0785                	addi	a5,a5,1
  e0:	fee79de3          	bne	a5,a4,da <memset+0x14>
  }
  return dst;
}
  e4:	60a2                	ld	ra,8(sp)
  e6:	6402                	ld	s0,0(sp)
  e8:	0141                	addi	sp,sp,16
  ea:	8082                	ret

00000000000000ec <strchr>:

char*
strchr(const char *s, char c)
{
  ec:	1141                	addi	sp,sp,-16
  ee:	e406                	sd	ra,8(sp)
  f0:	e022                	sd	s0,0(sp)
  f2:	0800                	addi	s0,sp,16
  for(; *s; s++)
  f4:	00054783          	lbu	a5,0(a0)
  f8:	cf81                	beqz	a5,110 <strchr+0x24>
    if(*s == c)
  fa:	00f58763          	beq	a1,a5,108 <strchr+0x1c>
  for(; *s; s++)
  fe:	0505                	addi	a0,a0,1
 100:	00054783          	lbu	a5,0(a0)
 104:	fbfd                	bnez	a5,fa <strchr+0xe>
      return (char*)s;
  return 0;
 106:	4501                	li	a0,0
}
 108:	60a2                	ld	ra,8(sp)
 10a:	6402                	ld	s0,0(sp)
 10c:	0141                	addi	sp,sp,16
 10e:	8082                	ret
  return 0;
 110:	4501                	li	a0,0
 112:	bfdd                	j	108 <strchr+0x1c>

0000000000000114 <gets>:

char*
gets(char *buf, int max)
{
 114:	711d                	addi	sp,sp,-96
 116:	ec86                	sd	ra,88(sp)
 118:	e8a2                	sd	s0,80(sp)
 11a:	e4a6                	sd	s1,72(sp)
 11c:	e0ca                	sd	s2,64(sp)
 11e:	fc4e                	sd	s3,56(sp)
 120:	f852                	sd	s4,48(sp)
 122:	f456                	sd	s5,40(sp)
 124:	f05a                	sd	s6,32(sp)
 126:	ec5e                	sd	s7,24(sp)
 128:	e862                	sd	s8,16(sp)
 12a:	1080                	addi	s0,sp,96
 12c:	8baa                	mv	s7,a0
 12e:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 130:	892a                	mv	s2,a0
 132:	4481                	li	s1,0
    cc = read(0, &c, 1);
 134:	faf40b13          	addi	s6,s0,-81
 138:	4a85                	li	s5,1
  for(i=0; i+1 < max; ){
 13a:	8c26                	mv	s8,s1
 13c:	0014899b          	addiw	s3,s1,1
 140:	84ce                	mv	s1,s3
 142:	0349d663          	bge	s3,s4,16e <gets+0x5a>
    cc = read(0, &c, 1);
 146:	8656                	mv	a2,s5
 148:	85da                	mv	a1,s6
 14a:	4501                	li	a0,0
 14c:	00000097          	auipc	ra,0x0
 150:	1a4080e7          	jalr	420(ra) # 2f0 <read>
    if(cc < 1)
 154:	00a05d63          	blez	a0,16e <gets+0x5a>
      break;
    buf[i++] = c;
 158:	faf44783          	lbu	a5,-81(s0)
 15c:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 160:	0905                	addi	s2,s2,1
 162:	ff678713          	addi	a4,a5,-10
 166:	c319                	beqz	a4,16c <gets+0x58>
 168:	17cd                	addi	a5,a5,-13
 16a:	fbe1                	bnez	a5,13a <gets+0x26>
    buf[i++] = c;
 16c:	8c4e                	mv	s8,s3
      break;
  }
  buf[i] = '\0';
 16e:	9c5e                	add	s8,s8,s7
 170:	000c0023          	sb	zero,0(s8)
  return buf;
}
 174:	855e                	mv	a0,s7
 176:	60e6                	ld	ra,88(sp)
 178:	6446                	ld	s0,80(sp)
 17a:	64a6                	ld	s1,72(sp)
 17c:	6906                	ld	s2,64(sp)
 17e:	79e2                	ld	s3,56(sp)
 180:	7a42                	ld	s4,48(sp)
 182:	7aa2                	ld	s5,40(sp)
 184:	7b02                	ld	s6,32(sp)
 186:	6be2                	ld	s7,24(sp)
 188:	6c42                	ld	s8,16(sp)
 18a:	6125                	addi	sp,sp,96
 18c:	8082                	ret

000000000000018e <stat>:

int
stat(const char *n, struct stat *st)
{
 18e:	1101                	addi	sp,sp,-32
 190:	ec06                	sd	ra,24(sp)
 192:	e822                	sd	s0,16(sp)
 194:	e04a                	sd	s2,0(sp)
 196:	1000                	addi	s0,sp,32
 198:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 19a:	4581                	li	a1,0
 19c:	00000097          	auipc	ra,0x0
 1a0:	17c080e7          	jalr	380(ra) # 318 <open>
  if(fd < 0)
 1a4:	02054663          	bltz	a0,1d0 <stat+0x42>
 1a8:	e426                	sd	s1,8(sp)
 1aa:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1ac:	85ca                	mv	a1,s2
 1ae:	00000097          	auipc	ra,0x0
 1b2:	182080e7          	jalr	386(ra) # 330 <fstat>
 1b6:	892a                	mv	s2,a0
  close(fd);
 1b8:	8526                	mv	a0,s1
 1ba:	00000097          	auipc	ra,0x0
 1be:	146080e7          	jalr	326(ra) # 300 <close>
  return r;
 1c2:	64a2                	ld	s1,8(sp)
}
 1c4:	854a                	mv	a0,s2
 1c6:	60e2                	ld	ra,24(sp)
 1c8:	6442                	ld	s0,16(sp)
 1ca:	6902                	ld	s2,0(sp)
 1cc:	6105                	addi	sp,sp,32
 1ce:	8082                	ret
    return -1;
 1d0:	57fd                	li	a5,-1
 1d2:	893e                	mv	s2,a5
 1d4:	bfc5                	j	1c4 <stat+0x36>

00000000000001d6 <atoi>:

int
atoi(const char *s)
{
 1d6:	1141                	addi	sp,sp,-16
 1d8:	e406                	sd	ra,8(sp)
 1da:	e022                	sd	s0,0(sp)
 1dc:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1de:	00054683          	lbu	a3,0(a0)
 1e2:	fd06879b          	addiw	a5,a3,-48
 1e6:	0ff7f793          	zext.b	a5,a5
 1ea:	4625                	li	a2,9
 1ec:	02f66963          	bltu	a2,a5,21e <atoi+0x48>
 1f0:	872a                	mv	a4,a0
  n = 0;
 1f2:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 1f4:	0705                	addi	a4,a4,1
 1f6:	0025179b          	slliw	a5,a0,0x2
 1fa:	9fa9                	addw	a5,a5,a0
 1fc:	0017979b          	slliw	a5,a5,0x1
 200:	9fb5                	addw	a5,a5,a3
 202:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 206:	00074683          	lbu	a3,0(a4)
 20a:	fd06879b          	addiw	a5,a3,-48
 20e:	0ff7f793          	zext.b	a5,a5
 212:	fef671e3          	bgeu	a2,a5,1f4 <atoi+0x1e>
  return n;
}
 216:	60a2                	ld	ra,8(sp)
 218:	6402                	ld	s0,0(sp)
 21a:	0141                	addi	sp,sp,16
 21c:	8082                	ret
  n = 0;
 21e:	4501                	li	a0,0
 220:	bfdd                	j	216 <atoi+0x40>

0000000000000222 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 222:	1141                	addi	sp,sp,-16
 224:	e406                	sd	ra,8(sp)
 226:	e022                	sd	s0,0(sp)
 228:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 22a:	02b57563          	bgeu	a0,a1,254 <memmove+0x32>
    while(n-- > 0)
 22e:	00c05f63          	blez	a2,24c <memmove+0x2a>
 232:	1602                	slli	a2,a2,0x20
 234:	9201                	srli	a2,a2,0x20
 236:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 23a:	872a                	mv	a4,a0
      *dst++ = *src++;
 23c:	0585                	addi	a1,a1,1
 23e:	0705                	addi	a4,a4,1
 240:	fff5c683          	lbu	a3,-1(a1)
 244:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 248:	fee79ae3          	bne	a5,a4,23c <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 24c:	60a2                	ld	ra,8(sp)
 24e:	6402                	ld	s0,0(sp)
 250:	0141                	addi	sp,sp,16
 252:	8082                	ret
    while(n-- > 0)
 254:	fec05ce3          	blez	a2,24c <memmove+0x2a>
    dst += n;
 258:	00c50733          	add	a4,a0,a2
    src += n;
 25c:	95b2                	add	a1,a1,a2
 25e:	fff6079b          	addiw	a5,a2,-1
 262:	1782                	slli	a5,a5,0x20
 264:	9381                	srli	a5,a5,0x20
 266:	fff7c793          	not	a5,a5
 26a:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 26c:	15fd                	addi	a1,a1,-1
 26e:	177d                	addi	a4,a4,-1
 270:	0005c683          	lbu	a3,0(a1)
 274:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 278:	fef71ae3          	bne	a4,a5,26c <memmove+0x4a>
 27c:	bfc1                	j	24c <memmove+0x2a>

000000000000027e <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 27e:	1141                	addi	sp,sp,-16
 280:	e406                	sd	ra,8(sp)
 282:	e022                	sd	s0,0(sp)
 284:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 286:	c61d                	beqz	a2,2b4 <memcmp+0x36>
 288:	1602                	slli	a2,a2,0x20
 28a:	9201                	srli	a2,a2,0x20
 28c:	00c506b3          	add	a3,a0,a2
    if (*p1 != *p2) {
 290:	00054783          	lbu	a5,0(a0)
 294:	0005c703          	lbu	a4,0(a1)
 298:	00e79863          	bne	a5,a4,2a8 <memcmp+0x2a>
      return *p1 - *p2;
    }
    p1++;
 29c:	0505                	addi	a0,a0,1
    p2++;
 29e:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 2a0:	fed518e3          	bne	a0,a3,290 <memcmp+0x12>
  }
  return 0;
 2a4:	4501                	li	a0,0
 2a6:	a019                	j	2ac <memcmp+0x2e>
      return *p1 - *p2;
 2a8:	40e7853b          	subw	a0,a5,a4
}
 2ac:	60a2                	ld	ra,8(sp)
 2ae:	6402                	ld	s0,0(sp)
 2b0:	0141                	addi	sp,sp,16
 2b2:	8082                	ret
  return 0;
 2b4:	4501                	li	a0,0
 2b6:	bfdd                	j	2ac <memcmp+0x2e>

00000000000002b8 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2b8:	1141                	addi	sp,sp,-16
 2ba:	e406                	sd	ra,8(sp)
 2bc:	e022                	sd	s0,0(sp)
 2be:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 2c0:	00000097          	auipc	ra,0x0
 2c4:	f62080e7          	jalr	-158(ra) # 222 <memmove>
}
 2c8:	60a2                	ld	ra,8(sp)
 2ca:	6402                	ld	s0,0(sp)
 2cc:	0141                	addi	sp,sp,16
 2ce:	8082                	ret

00000000000002d0 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 2d0:	4885                	li	a7,1
 ecall
 2d2:	00000073          	ecall
 ret
 2d6:	8082                	ret

00000000000002d8 <exit>:
.global exit
exit:
 li a7, SYS_exit
 2d8:	4889                	li	a7,2
 ecall
 2da:	00000073          	ecall
 ret
 2de:	8082                	ret

00000000000002e0 <wait>:
.global wait
wait:
 li a7, SYS_wait
 2e0:	488d                	li	a7,3
 ecall
 2e2:	00000073          	ecall
 ret
 2e6:	8082                	ret

00000000000002e8 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 2e8:	4891                	li	a7,4
 ecall
 2ea:	00000073          	ecall
 ret
 2ee:	8082                	ret

00000000000002f0 <read>:
.global read
read:
 li a7, SYS_read
 2f0:	4895                	li	a7,5
 ecall
 2f2:	00000073          	ecall
 ret
 2f6:	8082                	ret

00000000000002f8 <write>:
.global write
write:
 li a7, SYS_write
 2f8:	48c1                	li	a7,16
 ecall
 2fa:	00000073          	ecall
 ret
 2fe:	8082                	ret

0000000000000300 <close>:
.global close
close:
 li a7, SYS_close
 300:	48d5                	li	a7,21
 ecall
 302:	00000073          	ecall
 ret
 306:	8082                	ret

0000000000000308 <kill>:
.global kill
kill:
 li a7, SYS_kill
 308:	4899                	li	a7,6
 ecall
 30a:	00000073          	ecall
 ret
 30e:	8082                	ret

0000000000000310 <exec>:
.global exec
exec:
 li a7, SYS_exec
 310:	489d                	li	a7,7
 ecall
 312:	00000073          	ecall
 ret
 316:	8082                	ret

0000000000000318 <open>:
.global open
open:
 li a7, SYS_open
 318:	48bd                	li	a7,15
 ecall
 31a:	00000073          	ecall
 ret
 31e:	8082                	ret

0000000000000320 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 320:	48c5                	li	a7,17
 ecall
 322:	00000073          	ecall
 ret
 326:	8082                	ret

0000000000000328 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 328:	48c9                	li	a7,18
 ecall
 32a:	00000073          	ecall
 ret
 32e:	8082                	ret

0000000000000330 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 330:	48a1                	li	a7,8
 ecall
 332:	00000073          	ecall
 ret
 336:	8082                	ret

0000000000000338 <link>:
.global link
link:
 li a7, SYS_link
 338:	48cd                	li	a7,19
 ecall
 33a:	00000073          	ecall
 ret
 33e:	8082                	ret

0000000000000340 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 340:	48d1                	li	a7,20
 ecall
 342:	00000073          	ecall
 ret
 346:	8082                	ret

0000000000000348 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 348:	48a5                	li	a7,9
 ecall
 34a:	00000073          	ecall
 ret
 34e:	8082                	ret

0000000000000350 <dup>:
.global dup
dup:
 li a7, SYS_dup
 350:	48a9                	li	a7,10
 ecall
 352:	00000073          	ecall
 ret
 356:	8082                	ret

0000000000000358 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 358:	48ad                	li	a7,11
 ecall
 35a:	00000073          	ecall
 ret
 35e:	8082                	ret

0000000000000360 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 360:	48b1                	li	a7,12
 ecall
 362:	00000073          	ecall
 ret
 366:	8082                	ret

0000000000000368 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 368:	48b5                	li	a7,13
 ecall
 36a:	00000073          	ecall
 ret
 36e:	8082                	ret

0000000000000370 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 370:	48b9                	li	a7,14
 ecall
 372:	00000073          	ecall
 ret
 376:	8082                	ret

0000000000000378 <ntas>:
.global ntas
ntas:
 li a7, SYS_ntas
 378:	48d9                	li	a7,22
 ecall
 37a:	00000073          	ecall
 ret
 37e:	8082                	ret

0000000000000380 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 380:	1101                	addi	sp,sp,-32
 382:	ec06                	sd	ra,24(sp)
 384:	e822                	sd	s0,16(sp)
 386:	1000                	addi	s0,sp,32
 388:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 38c:	4605                	li	a2,1
 38e:	fef40593          	addi	a1,s0,-17
 392:	00000097          	auipc	ra,0x0
 396:	f66080e7          	jalr	-154(ra) # 2f8 <write>
}
 39a:	60e2                	ld	ra,24(sp)
 39c:	6442                	ld	s0,16(sp)
 39e:	6105                	addi	sp,sp,32
 3a0:	8082                	ret

00000000000003a2 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3a2:	7139                	addi	sp,sp,-64
 3a4:	fc06                	sd	ra,56(sp)
 3a6:	f822                	sd	s0,48(sp)
 3a8:	f04a                	sd	s2,32(sp)
 3aa:	ec4e                	sd	s3,24(sp)
 3ac:	0080                	addi	s0,sp,64
 3ae:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3b0:	cad9                	beqz	a3,446 <printint+0xa4>
 3b2:	01f5d79b          	srliw	a5,a1,0x1f
 3b6:	cbc1                	beqz	a5,446 <printint+0xa4>
    neg = 1;
    x = -xx;
 3b8:	40b005bb          	negw	a1,a1
    neg = 1;
 3bc:	4305                	li	t1,1
  } else {
    x = xx;
  }

  i = 0;
 3be:	fc040993          	addi	s3,s0,-64
  neg = 0;
 3c2:	86ce                	mv	a3,s3
  i = 0;
 3c4:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 3c6:	00000817          	auipc	a6,0x0
 3ca:	4a280813          	addi	a6,a6,1186 # 868 <digits>
 3ce:	88ba                	mv	a7,a4
 3d0:	0017051b          	addiw	a0,a4,1
 3d4:	872a                	mv	a4,a0
 3d6:	02c5f7bb          	remuw	a5,a1,a2
 3da:	1782                	slli	a5,a5,0x20
 3dc:	9381                	srli	a5,a5,0x20
 3de:	97c2                	add	a5,a5,a6
 3e0:	0007c783          	lbu	a5,0(a5)
 3e4:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 3e8:	87ae                	mv	a5,a1
 3ea:	02c5d5bb          	divuw	a1,a1,a2
 3ee:	0685                	addi	a3,a3,1
 3f0:	fcc7ffe3          	bgeu	a5,a2,3ce <printint+0x2c>
  if(neg)
 3f4:	00030c63          	beqz	t1,40c <printint+0x6a>
    buf[i++] = '-';
 3f8:	fd050793          	addi	a5,a0,-48
 3fc:	00878533          	add	a0,a5,s0
 400:	02d00793          	li	a5,45
 404:	fef50823          	sb	a5,-16(a0)
 408:	0028871b          	addiw	a4,a7,2

  while(--i >= 0)
 40c:	02e05763          	blez	a4,43a <printint+0x98>
 410:	f426                	sd	s1,40(sp)
 412:	377d                	addiw	a4,a4,-1
 414:	00e984b3          	add	s1,s3,a4
 418:	19fd                	addi	s3,s3,-1
 41a:	99ba                	add	s3,s3,a4
 41c:	1702                	slli	a4,a4,0x20
 41e:	9301                	srli	a4,a4,0x20
 420:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 424:	0004c583          	lbu	a1,0(s1)
 428:	854a                	mv	a0,s2
 42a:	00000097          	auipc	ra,0x0
 42e:	f56080e7          	jalr	-170(ra) # 380 <putc>
  while(--i >= 0)
 432:	14fd                	addi	s1,s1,-1
 434:	ff3498e3          	bne	s1,s3,424 <printint+0x82>
 438:	74a2                	ld	s1,40(sp)
}
 43a:	70e2                	ld	ra,56(sp)
 43c:	7442                	ld	s0,48(sp)
 43e:	7902                	ld	s2,32(sp)
 440:	69e2                	ld	s3,24(sp)
 442:	6121                	addi	sp,sp,64
 444:	8082                	ret
  neg = 0;
 446:	4301                	li	t1,0
 448:	bf9d                	j	3be <printint+0x1c>

000000000000044a <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 44a:	715d                	addi	sp,sp,-80
 44c:	e486                	sd	ra,72(sp)
 44e:	e0a2                	sd	s0,64(sp)
 450:	f84a                	sd	s2,48(sp)
 452:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 454:	0005c903          	lbu	s2,0(a1)
 458:	1a090b63          	beqz	s2,60e <vprintf+0x1c4>
 45c:	fc26                	sd	s1,56(sp)
 45e:	f44e                	sd	s3,40(sp)
 460:	f052                	sd	s4,32(sp)
 462:	ec56                	sd	s5,24(sp)
 464:	e85a                	sd	s6,16(sp)
 466:	e45e                	sd	s7,8(sp)
 468:	8aaa                	mv	s5,a0
 46a:	8bb2                	mv	s7,a2
 46c:	00158493          	addi	s1,a1,1
  state = 0;
 470:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 472:	02500a13          	li	s4,37
 476:	4b55                	li	s6,21
 478:	a839                	j	496 <vprintf+0x4c>
        putc(fd, c);
 47a:	85ca                	mv	a1,s2
 47c:	8556                	mv	a0,s5
 47e:	00000097          	auipc	ra,0x0
 482:	f02080e7          	jalr	-254(ra) # 380 <putc>
 486:	a019                	j	48c <vprintf+0x42>
    } else if(state == '%'){
 488:	01498d63          	beq	s3,s4,4a2 <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
 48c:	0485                	addi	s1,s1,1
 48e:	fff4c903          	lbu	s2,-1(s1)
 492:	16090863          	beqz	s2,602 <vprintf+0x1b8>
    if(state == 0){
 496:	fe0999e3          	bnez	s3,488 <vprintf+0x3e>
      if(c == '%'){
 49a:	ff4910e3          	bne	s2,s4,47a <vprintf+0x30>
        state = '%';
 49e:	89d2                	mv	s3,s4
 4a0:	b7f5                	j	48c <vprintf+0x42>
      if(c == 'd'){
 4a2:	13490563          	beq	s2,s4,5cc <vprintf+0x182>
 4a6:	f9d9079b          	addiw	a5,s2,-99
 4aa:	0ff7f793          	zext.b	a5,a5
 4ae:	12fb6863          	bltu	s6,a5,5de <vprintf+0x194>
 4b2:	f9d9079b          	addiw	a5,s2,-99
 4b6:	0ff7f713          	zext.b	a4,a5
 4ba:	12eb6263          	bltu	s6,a4,5de <vprintf+0x194>
 4be:	00271793          	slli	a5,a4,0x2
 4c2:	00000717          	auipc	a4,0x0
 4c6:	34e70713          	addi	a4,a4,846 # 810 <malloc+0x10e>
 4ca:	97ba                	add	a5,a5,a4
 4cc:	439c                	lw	a5,0(a5)
 4ce:	97ba                	add	a5,a5,a4
 4d0:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 4d2:	008b8913          	addi	s2,s7,8
 4d6:	4685                	li	a3,1
 4d8:	4629                	li	a2,10
 4da:	000ba583          	lw	a1,0(s7)
 4de:	8556                	mv	a0,s5
 4e0:	00000097          	auipc	ra,0x0
 4e4:	ec2080e7          	jalr	-318(ra) # 3a2 <printint>
 4e8:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4ea:	4981                	li	s3,0
 4ec:	b745                	j	48c <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
 4ee:	008b8913          	addi	s2,s7,8
 4f2:	4681                	li	a3,0
 4f4:	4629                	li	a2,10
 4f6:	000ba583          	lw	a1,0(s7)
 4fa:	8556                	mv	a0,s5
 4fc:	00000097          	auipc	ra,0x0
 500:	ea6080e7          	jalr	-346(ra) # 3a2 <printint>
 504:	8bca                	mv	s7,s2
      state = 0;
 506:	4981                	li	s3,0
 508:	b751                	j	48c <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
 50a:	008b8913          	addi	s2,s7,8
 50e:	4681                	li	a3,0
 510:	4641                	li	a2,16
 512:	000ba583          	lw	a1,0(s7)
 516:	8556                	mv	a0,s5
 518:	00000097          	auipc	ra,0x0
 51c:	e8a080e7          	jalr	-374(ra) # 3a2 <printint>
 520:	8bca                	mv	s7,s2
      state = 0;
 522:	4981                	li	s3,0
 524:	b7a5                	j	48c <vprintf+0x42>
 526:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
 528:	008b8793          	addi	a5,s7,8
 52c:	8c3e                	mv	s8,a5
 52e:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 532:	03000593          	li	a1,48
 536:	8556                	mv	a0,s5
 538:	00000097          	auipc	ra,0x0
 53c:	e48080e7          	jalr	-440(ra) # 380 <putc>
  putc(fd, 'x');
 540:	07800593          	li	a1,120
 544:	8556                	mv	a0,s5
 546:	00000097          	auipc	ra,0x0
 54a:	e3a080e7          	jalr	-454(ra) # 380 <putc>
 54e:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 550:	00000b97          	auipc	s7,0x0
 554:	318b8b93          	addi	s7,s7,792 # 868 <digits>
 558:	03c9d793          	srli	a5,s3,0x3c
 55c:	97de                	add	a5,a5,s7
 55e:	0007c583          	lbu	a1,0(a5)
 562:	8556                	mv	a0,s5
 564:	00000097          	auipc	ra,0x0
 568:	e1c080e7          	jalr	-484(ra) # 380 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 56c:	0992                	slli	s3,s3,0x4
 56e:	397d                	addiw	s2,s2,-1
 570:	fe0914e3          	bnez	s2,558 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
 574:	8be2                	mv	s7,s8
      state = 0;
 576:	4981                	li	s3,0
 578:	6c02                	ld	s8,0(sp)
 57a:	bf09                	j	48c <vprintf+0x42>
        s = va_arg(ap, char*);
 57c:	008b8993          	addi	s3,s7,8
 580:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 584:	02090163          	beqz	s2,5a6 <vprintf+0x15c>
        while(*s != 0){
 588:	00094583          	lbu	a1,0(s2)
 58c:	c9a5                	beqz	a1,5fc <vprintf+0x1b2>
          putc(fd, *s);
 58e:	8556                	mv	a0,s5
 590:	00000097          	auipc	ra,0x0
 594:	df0080e7          	jalr	-528(ra) # 380 <putc>
          s++;
 598:	0905                	addi	s2,s2,1
        while(*s != 0){
 59a:	00094583          	lbu	a1,0(s2)
 59e:	f9e5                	bnez	a1,58e <vprintf+0x144>
        s = va_arg(ap, char*);
 5a0:	8bce                	mv	s7,s3
      state = 0;
 5a2:	4981                	li	s3,0
 5a4:	b5e5                	j	48c <vprintf+0x42>
          s = "(null)";
 5a6:	00000917          	auipc	s2,0x0
 5aa:	26290913          	addi	s2,s2,610 # 808 <malloc+0x106>
        while(*s != 0){
 5ae:	02800593          	li	a1,40
 5b2:	bff1                	j	58e <vprintf+0x144>
        putc(fd, va_arg(ap, uint));
 5b4:	008b8913          	addi	s2,s7,8
 5b8:	000bc583          	lbu	a1,0(s7)
 5bc:	8556                	mv	a0,s5
 5be:	00000097          	auipc	ra,0x0
 5c2:	dc2080e7          	jalr	-574(ra) # 380 <putc>
 5c6:	8bca                	mv	s7,s2
      state = 0;
 5c8:	4981                	li	s3,0
 5ca:	b5c9                	j	48c <vprintf+0x42>
        putc(fd, c);
 5cc:	02500593          	li	a1,37
 5d0:	8556                	mv	a0,s5
 5d2:	00000097          	auipc	ra,0x0
 5d6:	dae080e7          	jalr	-594(ra) # 380 <putc>
      state = 0;
 5da:	4981                	li	s3,0
 5dc:	bd45                	j	48c <vprintf+0x42>
        putc(fd, '%');
 5de:	02500593          	li	a1,37
 5e2:	8556                	mv	a0,s5
 5e4:	00000097          	auipc	ra,0x0
 5e8:	d9c080e7          	jalr	-612(ra) # 380 <putc>
        putc(fd, c);
 5ec:	85ca                	mv	a1,s2
 5ee:	8556                	mv	a0,s5
 5f0:	00000097          	auipc	ra,0x0
 5f4:	d90080e7          	jalr	-624(ra) # 380 <putc>
      state = 0;
 5f8:	4981                	li	s3,0
 5fa:	bd49                	j	48c <vprintf+0x42>
        s = va_arg(ap, char*);
 5fc:	8bce                	mv	s7,s3
      state = 0;
 5fe:	4981                	li	s3,0
 600:	b571                	j	48c <vprintf+0x42>
 602:	74e2                	ld	s1,56(sp)
 604:	79a2                	ld	s3,40(sp)
 606:	7a02                	ld	s4,32(sp)
 608:	6ae2                	ld	s5,24(sp)
 60a:	6b42                	ld	s6,16(sp)
 60c:	6ba2                	ld	s7,8(sp)
    }
  }
}
 60e:	60a6                	ld	ra,72(sp)
 610:	6406                	ld	s0,64(sp)
 612:	7942                	ld	s2,48(sp)
 614:	6161                	addi	sp,sp,80
 616:	8082                	ret

0000000000000618 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 618:	715d                	addi	sp,sp,-80
 61a:	ec06                	sd	ra,24(sp)
 61c:	e822                	sd	s0,16(sp)
 61e:	1000                	addi	s0,sp,32
 620:	e010                	sd	a2,0(s0)
 622:	e414                	sd	a3,8(s0)
 624:	e818                	sd	a4,16(s0)
 626:	ec1c                	sd	a5,24(s0)
 628:	03043023          	sd	a6,32(s0)
 62c:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 630:	8622                	mv	a2,s0
 632:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 636:	00000097          	auipc	ra,0x0
 63a:	e14080e7          	jalr	-492(ra) # 44a <vprintf>
}
 63e:	60e2                	ld	ra,24(sp)
 640:	6442                	ld	s0,16(sp)
 642:	6161                	addi	sp,sp,80
 644:	8082                	ret

0000000000000646 <printf>:

void
printf(const char *fmt, ...)
{
 646:	711d                	addi	sp,sp,-96
 648:	ec06                	sd	ra,24(sp)
 64a:	e822                	sd	s0,16(sp)
 64c:	1000                	addi	s0,sp,32
 64e:	e40c                	sd	a1,8(s0)
 650:	e810                	sd	a2,16(s0)
 652:	ec14                	sd	a3,24(s0)
 654:	f018                	sd	a4,32(s0)
 656:	f41c                	sd	a5,40(s0)
 658:	03043823          	sd	a6,48(s0)
 65c:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 660:	00840613          	addi	a2,s0,8
 664:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 668:	85aa                	mv	a1,a0
 66a:	4505                	li	a0,1
 66c:	00000097          	auipc	ra,0x0
 670:	dde080e7          	jalr	-546(ra) # 44a <vprintf>
}
 674:	60e2                	ld	ra,24(sp)
 676:	6442                	ld	s0,16(sp)
 678:	6125                	addi	sp,sp,96
 67a:	8082                	ret

000000000000067c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 67c:	1141                	addi	sp,sp,-16
 67e:	e406                	sd	ra,8(sp)
 680:	e022                	sd	s0,0(sp)
 682:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 684:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 688:	00000797          	auipc	a5,0x0
 68c:	1f87b783          	ld	a5,504(a5) # 880 <freep>
 690:	a039                	j	69e <free+0x22>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 692:	6398                	ld	a4,0(a5)
 694:	00e7e463          	bltu	a5,a4,69c <free+0x20>
 698:	00e6ea63          	bltu	a3,a4,6ac <free+0x30>
{
 69c:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 69e:	fed7fae3          	bgeu	a5,a3,692 <free+0x16>
 6a2:	6398                	ld	a4,0(a5)
 6a4:	00e6e463          	bltu	a3,a4,6ac <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6a8:	fee7eae3          	bltu	a5,a4,69c <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 6ac:	ff852583          	lw	a1,-8(a0)
 6b0:	6390                	ld	a2,0(a5)
 6b2:	02059813          	slli	a6,a1,0x20
 6b6:	01c85713          	srli	a4,a6,0x1c
 6ba:	9736                	add	a4,a4,a3
 6bc:	02e60563          	beq	a2,a4,6e6 <free+0x6a>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 6c0:	fec53823          	sd	a2,-16(a0)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 6c4:	4790                	lw	a2,8(a5)
 6c6:	02061593          	slli	a1,a2,0x20
 6ca:	01c5d713          	srli	a4,a1,0x1c
 6ce:	973e                	add	a4,a4,a5
 6d0:	02e68263          	beq	a3,a4,6f4 <free+0x78>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 6d4:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 6d6:	00000717          	auipc	a4,0x0
 6da:	1af73523          	sd	a5,426(a4) # 880 <freep>
}
 6de:	60a2                	ld	ra,8(sp)
 6e0:	6402                	ld	s0,0(sp)
 6e2:	0141                	addi	sp,sp,16
 6e4:	8082                	ret
    bp->s.size += p->s.ptr->s.size;
 6e6:	4618                	lw	a4,8(a2)
 6e8:	9f2d                	addw	a4,a4,a1
 6ea:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 6ee:	6398                	ld	a4,0(a5)
 6f0:	6310                	ld	a2,0(a4)
 6f2:	b7f9                	j	6c0 <free+0x44>
    p->s.size += bp->s.size;
 6f4:	ff852703          	lw	a4,-8(a0)
 6f8:	9f31                	addw	a4,a4,a2
 6fa:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 6fc:	ff053683          	ld	a3,-16(a0)
 700:	bfd1                	j	6d4 <free+0x58>

0000000000000702 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 702:	7139                	addi	sp,sp,-64
 704:	fc06                	sd	ra,56(sp)
 706:	f822                	sd	s0,48(sp)
 708:	f04a                	sd	s2,32(sp)
 70a:	ec4e                	sd	s3,24(sp)
 70c:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 70e:	02051993          	slli	s3,a0,0x20
 712:	0209d993          	srli	s3,s3,0x20
 716:	09bd                	addi	s3,s3,15
 718:	0049d993          	srli	s3,s3,0x4
 71c:	2985                	addiw	s3,s3,1
 71e:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 720:	00000517          	auipc	a0,0x0
 724:	16053503          	ld	a0,352(a0) # 880 <freep>
 728:	c905                	beqz	a0,758 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 72a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 72c:	4798                	lw	a4,8(a5)
 72e:	09377a63          	bgeu	a4,s3,7c2 <malloc+0xc0>
 732:	f426                	sd	s1,40(sp)
 734:	e852                	sd	s4,16(sp)
 736:	e456                	sd	s5,8(sp)
 738:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 73a:	8a4e                	mv	s4,s3
 73c:	6705                	lui	a4,0x1
 73e:	00e9f363          	bgeu	s3,a4,744 <malloc+0x42>
 742:	6a05                	lui	s4,0x1
 744:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 748:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 74c:	00000497          	auipc	s1,0x0
 750:	13448493          	addi	s1,s1,308 # 880 <freep>
  if(p == (char*)-1)
 754:	5afd                	li	s5,-1
 756:	a089                	j	798 <malloc+0x96>
 758:	f426                	sd	s1,40(sp)
 75a:	e852                	sd	s4,16(sp)
 75c:	e456                	sd	s5,8(sp)
 75e:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 760:	00000797          	auipc	a5,0x0
 764:	12878793          	addi	a5,a5,296 # 888 <base>
 768:	00000717          	auipc	a4,0x0
 76c:	10f73c23          	sd	a5,280(a4) # 880 <freep>
 770:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 772:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 776:	b7d1                	j	73a <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 778:	6398                	ld	a4,0(a5)
 77a:	e118                	sd	a4,0(a0)
 77c:	a8b9                	j	7da <malloc+0xd8>
  hp->s.size = nu;
 77e:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 782:	0541                	addi	a0,a0,16
 784:	00000097          	auipc	ra,0x0
 788:	ef8080e7          	jalr	-264(ra) # 67c <free>
  return freep;
 78c:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 78e:	c135                	beqz	a0,7f2 <malloc+0xf0>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 790:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 792:	4798                	lw	a4,8(a5)
 794:	03277363          	bgeu	a4,s2,7ba <malloc+0xb8>
    if(p == freep)
 798:	6098                	ld	a4,0(s1)
 79a:	853e                	mv	a0,a5
 79c:	fef71ae3          	bne	a4,a5,790 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 7a0:	8552                	mv	a0,s4
 7a2:	00000097          	auipc	ra,0x0
 7a6:	bbe080e7          	jalr	-1090(ra) # 360 <sbrk>
  if(p == (char*)-1)
 7aa:	fd551ae3          	bne	a0,s5,77e <malloc+0x7c>
        return 0;
 7ae:	4501                	li	a0,0
 7b0:	74a2                	ld	s1,40(sp)
 7b2:	6a42                	ld	s4,16(sp)
 7b4:	6aa2                	ld	s5,8(sp)
 7b6:	6b02                	ld	s6,0(sp)
 7b8:	a03d                	j	7e6 <malloc+0xe4>
 7ba:	74a2                	ld	s1,40(sp)
 7bc:	6a42                	ld	s4,16(sp)
 7be:	6aa2                	ld	s5,8(sp)
 7c0:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 7c2:	fae90be3          	beq	s2,a4,778 <malloc+0x76>
        p->s.size -= nunits;
 7c6:	4137073b          	subw	a4,a4,s3
 7ca:	c798                	sw	a4,8(a5)
        p += p->s.size;
 7cc:	02071693          	slli	a3,a4,0x20
 7d0:	01c6d713          	srli	a4,a3,0x1c
 7d4:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 7d6:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 7da:	00000717          	auipc	a4,0x0
 7de:	0aa73323          	sd	a0,166(a4) # 880 <freep>
      return (void*)(p + 1);
 7e2:	01078513          	addi	a0,a5,16
  }
}
 7e6:	70e2                	ld	ra,56(sp)
 7e8:	7442                	ld	s0,48(sp)
 7ea:	7902                	ld	s2,32(sp)
 7ec:	69e2                	ld	s3,24(sp)
 7ee:	6121                	addi	sp,sp,64
 7f0:	8082                	ret
 7f2:	74a2                	ld	s1,40(sp)
 7f4:	6a42                	ld	s4,16(sp)
 7f6:	6aa2                	ld	s5,8(sp)
 7f8:	6b02                	ld	s6,0(sp)
 7fa:	b7f5                	j	7e6 <malloc+0xe4>
