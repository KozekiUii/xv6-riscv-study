
user/_pingpong：     文件格式 elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/types.h"
#include "user/user.h"

int 
main(int argc, char** argv ){
   0:	715d                	addi	sp,sp,-80
   2:	e486                	sd	ra,72(sp)
   4:	e0a2                	sd	s0,64(sp)
   6:	0880                	addi	s0,sp,80
    int pid;
    int parent_fd[2];
    int child_fd[2];
    char buf[20];
    //为父子进程建立管道
    pipe(child_fd); 
   8:	fd040513          	addi	a0,s0,-48
   c:	00000097          	auipc	ra,0x0
  10:	390080e7          	jalr	912(ra) # 39c <pipe>
    pipe(parent_fd);
  14:	fd840513          	addi	a0,s0,-40
  18:	00000097          	auipc	ra,0x0
  1c:	384080e7          	jalr	900(ra) # 39c <pipe>

    // Child Progress
    if((pid = fork()) == 0){
  20:	00000097          	auipc	ra,0x0
  24:	364080e7          	jalr	868(ra) # 384 <fork>
  28:	e535                	bnez	a0,94 <main+0x94>
  2a:	fc26                	sd	s1,56(sp)
        close(parent_fd[1]);
  2c:	fdc42503          	lw	a0,-36(s0)
  30:	00000097          	auipc	ra,0x0
  34:	384080e7          	jalr	900(ra) # 3b4 <close>
        read(parent_fd[0],buf, 4);
  38:	fb840493          	addi	s1,s0,-72
  3c:	4611                	li	a2,4
  3e:	85a6                	mv	a1,s1
  40:	fd842503          	lw	a0,-40(s0)
  44:	00000097          	auipc	ra,0x0
  48:	360080e7          	jalr	864(ra) # 3a4 <read>
        printf("%d: received %s\n",getpid(), buf);
  4c:	00000097          	auipc	ra,0x0
  50:	3c0080e7          	jalr	960(ra) # 40c <getpid>
  54:	85aa                	mv	a1,a0
  56:	8626                	mv	a2,s1
  58:	00001517          	auipc	a0,0x1
  5c:	85850513          	addi	a0,a0,-1960 # 8b0 <malloc+0xfa>
  60:	00000097          	auipc	ra,0x0
  64:	69a080e7          	jalr	1690(ra) # 6fa <printf>
        close(child_fd[0]);
  68:	fd042503          	lw	a0,-48(s0)
  6c:	00000097          	auipc	ra,0x0
  70:	348080e7          	jalr	840(ra) # 3b4 <close>
        write(child_fd[1], "pong", sizeof(buf));
  74:	4651                	li	a2,20
  76:	00001597          	auipc	a1,0x1
  7a:	85258593          	addi	a1,a1,-1966 # 8c8 <malloc+0x112>
  7e:	fd442503          	lw	a0,-44(s0)
  82:	00000097          	auipc	ra,0x0
  86:	32a080e7          	jalr	810(ra) # 3ac <write>
        exit(0);
  8a:	4501                	li	a0,0
  8c:	00000097          	auipc	ra,0x0
  90:	300080e7          	jalr	768(ra) # 38c <exit>
  94:	fc26                	sd	s1,56(sp)
    }
    // Parent Progress
    else{
        close(parent_fd[0]);
  96:	fd842503          	lw	a0,-40(s0)
  9a:	00000097          	auipc	ra,0x0
  9e:	31a080e7          	jalr	794(ra) # 3b4 <close>
        write(parent_fd[1], "ping",4);
  a2:	4611                	li	a2,4
  a4:	00001597          	auipc	a1,0x1
  a8:	82c58593          	addi	a1,a1,-2004 # 8d0 <malloc+0x11a>
  ac:	fdc42503          	lw	a0,-36(s0)
  b0:	00000097          	auipc	ra,0x0
  b4:	2fc080e7          	jalr	764(ra) # 3ac <write>
        close(child_fd[1]);
  b8:	fd442503          	lw	a0,-44(s0)
  bc:	00000097          	auipc	ra,0x0
  c0:	2f8080e7          	jalr	760(ra) # 3b4 <close>
        read(child_fd[0], buf, sizeof(buf));
  c4:	fb840493          	addi	s1,s0,-72
  c8:	4651                	li	a2,20
  ca:	85a6                	mv	a1,s1
  cc:	fd042503          	lw	a0,-48(s0)
  d0:	00000097          	auipc	ra,0x0
  d4:	2d4080e7          	jalr	724(ra) # 3a4 <read>
        printf("%d: received %s\n", getpid(), buf);
  d8:	00000097          	auipc	ra,0x0
  dc:	334080e7          	jalr	820(ra) # 40c <getpid>
  e0:	85aa                	mv	a1,a0
  e2:	8626                	mv	a2,s1
  e4:	00000517          	auipc	a0,0x0
  e8:	7cc50513          	addi	a0,a0,1996 # 8b0 <malloc+0xfa>
  ec:	00000097          	auipc	ra,0x0
  f0:	60e080e7          	jalr	1550(ra) # 6fa <printf>
        exit(0);
  f4:	4501                	li	a0,0
  f6:	00000097          	auipc	ra,0x0
  fa:	296080e7          	jalr	662(ra) # 38c <exit>

00000000000000fe <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
  fe:	1141                	addi	sp,sp,-16
 100:	e406                	sd	ra,8(sp)
 102:	e022                	sd	s0,0(sp)
 104:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 106:	87aa                	mv	a5,a0
 108:	0585                	addi	a1,a1,1
 10a:	0785                	addi	a5,a5,1
 10c:	fff5c703          	lbu	a4,-1(a1)
 110:	fee78fa3          	sb	a4,-1(a5)
 114:	fb75                	bnez	a4,108 <strcpy+0xa>
    ;
  return os;
}
 116:	60a2                	ld	ra,8(sp)
 118:	6402                	ld	s0,0(sp)
 11a:	0141                	addi	sp,sp,16
 11c:	8082                	ret

000000000000011e <strcmp>:

int
strcmp(const char *p, const char *q)
{
 11e:	1141                	addi	sp,sp,-16
 120:	e406                	sd	ra,8(sp)
 122:	e022                	sd	s0,0(sp)
 124:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 126:	00054783          	lbu	a5,0(a0)
 12a:	cb91                	beqz	a5,13e <strcmp+0x20>
 12c:	0005c703          	lbu	a4,0(a1)
 130:	00f71763          	bne	a4,a5,13e <strcmp+0x20>
    p++, q++;
 134:	0505                	addi	a0,a0,1
 136:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 138:	00054783          	lbu	a5,0(a0)
 13c:	fbe5                	bnez	a5,12c <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 13e:	0005c503          	lbu	a0,0(a1)
}
 142:	40a7853b          	subw	a0,a5,a0
 146:	60a2                	ld	ra,8(sp)
 148:	6402                	ld	s0,0(sp)
 14a:	0141                	addi	sp,sp,16
 14c:	8082                	ret

000000000000014e <strlen>:

uint
strlen(const char *s)
{
 14e:	1141                	addi	sp,sp,-16
 150:	e406                	sd	ra,8(sp)
 152:	e022                	sd	s0,0(sp)
 154:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 156:	00054783          	lbu	a5,0(a0)
 15a:	cf91                	beqz	a5,176 <strlen+0x28>
 15c:	00150793          	addi	a5,a0,1
 160:	86be                	mv	a3,a5
 162:	0785                	addi	a5,a5,1
 164:	fff7c703          	lbu	a4,-1(a5)
 168:	ff65                	bnez	a4,160 <strlen+0x12>
 16a:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
 16e:	60a2                	ld	ra,8(sp)
 170:	6402                	ld	s0,0(sp)
 172:	0141                	addi	sp,sp,16
 174:	8082                	ret
  for(n = 0; s[n]; n++)
 176:	4501                	li	a0,0
 178:	bfdd                	j	16e <strlen+0x20>

000000000000017a <memset>:

void*
memset(void *dst, int c, uint n)
{
 17a:	1141                	addi	sp,sp,-16
 17c:	e406                	sd	ra,8(sp)
 17e:	e022                	sd	s0,0(sp)
 180:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 182:	ca19                	beqz	a2,198 <memset+0x1e>
 184:	87aa                	mv	a5,a0
 186:	1602                	slli	a2,a2,0x20
 188:	9201                	srli	a2,a2,0x20
 18a:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 18e:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 192:	0785                	addi	a5,a5,1
 194:	fee79de3          	bne	a5,a4,18e <memset+0x14>
  }
  return dst;
}
 198:	60a2                	ld	ra,8(sp)
 19a:	6402                	ld	s0,0(sp)
 19c:	0141                	addi	sp,sp,16
 19e:	8082                	ret

00000000000001a0 <strchr>:

char*
strchr(const char *s, char c)
{
 1a0:	1141                	addi	sp,sp,-16
 1a2:	e406                	sd	ra,8(sp)
 1a4:	e022                	sd	s0,0(sp)
 1a6:	0800                	addi	s0,sp,16
  for(; *s; s++)
 1a8:	00054783          	lbu	a5,0(a0)
 1ac:	cf81                	beqz	a5,1c4 <strchr+0x24>
    if(*s == c)
 1ae:	00f58763          	beq	a1,a5,1bc <strchr+0x1c>
  for(; *s; s++)
 1b2:	0505                	addi	a0,a0,1
 1b4:	00054783          	lbu	a5,0(a0)
 1b8:	fbfd                	bnez	a5,1ae <strchr+0xe>
      return (char*)s;
  return 0;
 1ba:	4501                	li	a0,0
}
 1bc:	60a2                	ld	ra,8(sp)
 1be:	6402                	ld	s0,0(sp)
 1c0:	0141                	addi	sp,sp,16
 1c2:	8082                	ret
  return 0;
 1c4:	4501                	li	a0,0
 1c6:	bfdd                	j	1bc <strchr+0x1c>

00000000000001c8 <gets>:

char*
gets(char *buf, int max)
{
 1c8:	711d                	addi	sp,sp,-96
 1ca:	ec86                	sd	ra,88(sp)
 1cc:	e8a2                	sd	s0,80(sp)
 1ce:	e4a6                	sd	s1,72(sp)
 1d0:	e0ca                	sd	s2,64(sp)
 1d2:	fc4e                	sd	s3,56(sp)
 1d4:	f852                	sd	s4,48(sp)
 1d6:	f456                	sd	s5,40(sp)
 1d8:	f05a                	sd	s6,32(sp)
 1da:	ec5e                	sd	s7,24(sp)
 1dc:	e862                	sd	s8,16(sp)
 1de:	1080                	addi	s0,sp,96
 1e0:	8baa                	mv	s7,a0
 1e2:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1e4:	892a                	mv	s2,a0
 1e6:	4481                	li	s1,0
    cc = read(0, &c, 1);
 1e8:	faf40b13          	addi	s6,s0,-81
 1ec:	4a85                	li	s5,1
  for(i=0; i+1 < max; ){
 1ee:	8c26                	mv	s8,s1
 1f0:	0014899b          	addiw	s3,s1,1
 1f4:	84ce                	mv	s1,s3
 1f6:	0349d663          	bge	s3,s4,222 <gets+0x5a>
    cc = read(0, &c, 1);
 1fa:	8656                	mv	a2,s5
 1fc:	85da                	mv	a1,s6
 1fe:	4501                	li	a0,0
 200:	00000097          	auipc	ra,0x0
 204:	1a4080e7          	jalr	420(ra) # 3a4 <read>
    if(cc < 1)
 208:	00a05d63          	blez	a0,222 <gets+0x5a>
      break;
    buf[i++] = c;
 20c:	faf44783          	lbu	a5,-81(s0)
 210:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 214:	0905                	addi	s2,s2,1
 216:	ff678713          	addi	a4,a5,-10
 21a:	c319                	beqz	a4,220 <gets+0x58>
 21c:	17cd                	addi	a5,a5,-13
 21e:	fbe1                	bnez	a5,1ee <gets+0x26>
    buf[i++] = c;
 220:	8c4e                	mv	s8,s3
      break;
  }
  buf[i] = '\0';
 222:	9c5e                	add	s8,s8,s7
 224:	000c0023          	sb	zero,0(s8)
  return buf;
}
 228:	855e                	mv	a0,s7
 22a:	60e6                	ld	ra,88(sp)
 22c:	6446                	ld	s0,80(sp)
 22e:	64a6                	ld	s1,72(sp)
 230:	6906                	ld	s2,64(sp)
 232:	79e2                	ld	s3,56(sp)
 234:	7a42                	ld	s4,48(sp)
 236:	7aa2                	ld	s5,40(sp)
 238:	7b02                	ld	s6,32(sp)
 23a:	6be2                	ld	s7,24(sp)
 23c:	6c42                	ld	s8,16(sp)
 23e:	6125                	addi	sp,sp,96
 240:	8082                	ret

0000000000000242 <stat>:

int
stat(const char *n, struct stat *st)
{
 242:	1101                	addi	sp,sp,-32
 244:	ec06                	sd	ra,24(sp)
 246:	e822                	sd	s0,16(sp)
 248:	e04a                	sd	s2,0(sp)
 24a:	1000                	addi	s0,sp,32
 24c:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 24e:	4581                	li	a1,0
 250:	00000097          	auipc	ra,0x0
 254:	17c080e7          	jalr	380(ra) # 3cc <open>
  if(fd < 0)
 258:	02054663          	bltz	a0,284 <stat+0x42>
 25c:	e426                	sd	s1,8(sp)
 25e:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 260:	85ca                	mv	a1,s2
 262:	00000097          	auipc	ra,0x0
 266:	182080e7          	jalr	386(ra) # 3e4 <fstat>
 26a:	892a                	mv	s2,a0
  close(fd);
 26c:	8526                	mv	a0,s1
 26e:	00000097          	auipc	ra,0x0
 272:	146080e7          	jalr	326(ra) # 3b4 <close>
  return r;
 276:	64a2                	ld	s1,8(sp)
}
 278:	854a                	mv	a0,s2
 27a:	60e2                	ld	ra,24(sp)
 27c:	6442                	ld	s0,16(sp)
 27e:	6902                	ld	s2,0(sp)
 280:	6105                	addi	sp,sp,32
 282:	8082                	ret
    return -1;
 284:	57fd                	li	a5,-1
 286:	893e                	mv	s2,a5
 288:	bfc5                	j	278 <stat+0x36>

000000000000028a <atoi>:

int
atoi(const char *s)
{
 28a:	1141                	addi	sp,sp,-16
 28c:	e406                	sd	ra,8(sp)
 28e:	e022                	sd	s0,0(sp)
 290:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 292:	00054683          	lbu	a3,0(a0)
 296:	fd06879b          	addiw	a5,a3,-48
 29a:	0ff7f793          	zext.b	a5,a5
 29e:	4625                	li	a2,9
 2a0:	02f66963          	bltu	a2,a5,2d2 <atoi+0x48>
 2a4:	872a                	mv	a4,a0
  n = 0;
 2a6:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 2a8:	0705                	addi	a4,a4,1
 2aa:	0025179b          	slliw	a5,a0,0x2
 2ae:	9fa9                	addw	a5,a5,a0
 2b0:	0017979b          	slliw	a5,a5,0x1
 2b4:	9fb5                	addw	a5,a5,a3
 2b6:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 2ba:	00074683          	lbu	a3,0(a4)
 2be:	fd06879b          	addiw	a5,a3,-48
 2c2:	0ff7f793          	zext.b	a5,a5
 2c6:	fef671e3          	bgeu	a2,a5,2a8 <atoi+0x1e>
  return n;
}
 2ca:	60a2                	ld	ra,8(sp)
 2cc:	6402                	ld	s0,0(sp)
 2ce:	0141                	addi	sp,sp,16
 2d0:	8082                	ret
  n = 0;
 2d2:	4501                	li	a0,0
 2d4:	bfdd                	j	2ca <atoi+0x40>

00000000000002d6 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2d6:	1141                	addi	sp,sp,-16
 2d8:	e406                	sd	ra,8(sp)
 2da:	e022                	sd	s0,0(sp)
 2dc:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 2de:	02b57563          	bgeu	a0,a1,308 <memmove+0x32>
    while(n-- > 0)
 2e2:	00c05f63          	blez	a2,300 <memmove+0x2a>
 2e6:	1602                	slli	a2,a2,0x20
 2e8:	9201                	srli	a2,a2,0x20
 2ea:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 2ee:	872a                	mv	a4,a0
      *dst++ = *src++;
 2f0:	0585                	addi	a1,a1,1
 2f2:	0705                	addi	a4,a4,1
 2f4:	fff5c683          	lbu	a3,-1(a1)
 2f8:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 2fc:	fee79ae3          	bne	a5,a4,2f0 <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 300:	60a2                	ld	ra,8(sp)
 302:	6402                	ld	s0,0(sp)
 304:	0141                	addi	sp,sp,16
 306:	8082                	ret
    while(n-- > 0)
 308:	fec05ce3          	blez	a2,300 <memmove+0x2a>
    dst += n;
 30c:	00c50733          	add	a4,a0,a2
    src += n;
 310:	95b2                	add	a1,a1,a2
 312:	fff6079b          	addiw	a5,a2,-1
 316:	1782                	slli	a5,a5,0x20
 318:	9381                	srli	a5,a5,0x20
 31a:	fff7c793          	not	a5,a5
 31e:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 320:	15fd                	addi	a1,a1,-1
 322:	177d                	addi	a4,a4,-1
 324:	0005c683          	lbu	a3,0(a1)
 328:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 32c:	fef71ae3          	bne	a4,a5,320 <memmove+0x4a>
 330:	bfc1                	j	300 <memmove+0x2a>

0000000000000332 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 332:	1141                	addi	sp,sp,-16
 334:	e406                	sd	ra,8(sp)
 336:	e022                	sd	s0,0(sp)
 338:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 33a:	c61d                	beqz	a2,368 <memcmp+0x36>
 33c:	1602                	slli	a2,a2,0x20
 33e:	9201                	srli	a2,a2,0x20
 340:	00c506b3          	add	a3,a0,a2
    if (*p1 != *p2) {
 344:	00054783          	lbu	a5,0(a0)
 348:	0005c703          	lbu	a4,0(a1)
 34c:	00e79863          	bne	a5,a4,35c <memcmp+0x2a>
      return *p1 - *p2;
    }
    p1++;
 350:	0505                	addi	a0,a0,1
    p2++;
 352:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 354:	fed518e3          	bne	a0,a3,344 <memcmp+0x12>
  }
  return 0;
 358:	4501                	li	a0,0
 35a:	a019                	j	360 <memcmp+0x2e>
      return *p1 - *p2;
 35c:	40e7853b          	subw	a0,a5,a4
}
 360:	60a2                	ld	ra,8(sp)
 362:	6402                	ld	s0,0(sp)
 364:	0141                	addi	sp,sp,16
 366:	8082                	ret
  return 0;
 368:	4501                	li	a0,0
 36a:	bfdd                	j	360 <memcmp+0x2e>

000000000000036c <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 36c:	1141                	addi	sp,sp,-16
 36e:	e406                	sd	ra,8(sp)
 370:	e022                	sd	s0,0(sp)
 372:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 374:	00000097          	auipc	ra,0x0
 378:	f62080e7          	jalr	-158(ra) # 2d6 <memmove>
}
 37c:	60a2                	ld	ra,8(sp)
 37e:	6402                	ld	s0,0(sp)
 380:	0141                	addi	sp,sp,16
 382:	8082                	ret

0000000000000384 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 384:	4885                	li	a7,1
 ecall
 386:	00000073          	ecall
 ret
 38a:	8082                	ret

000000000000038c <exit>:
.global exit
exit:
 li a7, SYS_exit
 38c:	4889                	li	a7,2
 ecall
 38e:	00000073          	ecall
 ret
 392:	8082                	ret

0000000000000394 <wait>:
.global wait
wait:
 li a7, SYS_wait
 394:	488d                	li	a7,3
 ecall
 396:	00000073          	ecall
 ret
 39a:	8082                	ret

000000000000039c <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 39c:	4891                	li	a7,4
 ecall
 39e:	00000073          	ecall
 ret
 3a2:	8082                	ret

00000000000003a4 <read>:
.global read
read:
 li a7, SYS_read
 3a4:	4895                	li	a7,5
 ecall
 3a6:	00000073          	ecall
 ret
 3aa:	8082                	ret

00000000000003ac <write>:
.global write
write:
 li a7, SYS_write
 3ac:	48c1                	li	a7,16
 ecall
 3ae:	00000073          	ecall
 ret
 3b2:	8082                	ret

00000000000003b4 <close>:
.global close
close:
 li a7, SYS_close
 3b4:	48d5                	li	a7,21
 ecall
 3b6:	00000073          	ecall
 ret
 3ba:	8082                	ret

00000000000003bc <kill>:
.global kill
kill:
 li a7, SYS_kill
 3bc:	4899                	li	a7,6
 ecall
 3be:	00000073          	ecall
 ret
 3c2:	8082                	ret

00000000000003c4 <exec>:
.global exec
exec:
 li a7, SYS_exec
 3c4:	489d                	li	a7,7
 ecall
 3c6:	00000073          	ecall
 ret
 3ca:	8082                	ret

00000000000003cc <open>:
.global open
open:
 li a7, SYS_open
 3cc:	48bd                	li	a7,15
 ecall
 3ce:	00000073          	ecall
 ret
 3d2:	8082                	ret

00000000000003d4 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 3d4:	48c5                	li	a7,17
 ecall
 3d6:	00000073          	ecall
 ret
 3da:	8082                	ret

00000000000003dc <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 3dc:	48c9                	li	a7,18
 ecall
 3de:	00000073          	ecall
 ret
 3e2:	8082                	ret

00000000000003e4 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 3e4:	48a1                	li	a7,8
 ecall
 3e6:	00000073          	ecall
 ret
 3ea:	8082                	ret

00000000000003ec <link>:
.global link
link:
 li a7, SYS_link
 3ec:	48cd                	li	a7,19
 ecall
 3ee:	00000073          	ecall
 ret
 3f2:	8082                	ret

00000000000003f4 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3f4:	48d1                	li	a7,20
 ecall
 3f6:	00000073          	ecall
 ret
 3fa:	8082                	ret

00000000000003fc <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 3fc:	48a5                	li	a7,9
 ecall
 3fe:	00000073          	ecall
 ret
 402:	8082                	ret

0000000000000404 <dup>:
.global dup
dup:
 li a7, SYS_dup
 404:	48a9                	li	a7,10
 ecall
 406:	00000073          	ecall
 ret
 40a:	8082                	ret

000000000000040c <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 40c:	48ad                	li	a7,11
 ecall
 40e:	00000073          	ecall
 ret
 412:	8082                	ret

0000000000000414 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 414:	48b1                	li	a7,12
 ecall
 416:	00000073          	ecall
 ret
 41a:	8082                	ret

000000000000041c <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 41c:	48b5                	li	a7,13
 ecall
 41e:	00000073          	ecall
 ret
 422:	8082                	ret

0000000000000424 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 424:	48b9                	li	a7,14
 ecall
 426:	00000073          	ecall
 ret
 42a:	8082                	ret

000000000000042c <ntas>:
.global ntas
ntas:
 li a7, SYS_ntas
 42c:	48d9                	li	a7,22
 ecall
 42e:	00000073          	ecall
 ret
 432:	8082                	ret

0000000000000434 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 434:	1101                	addi	sp,sp,-32
 436:	ec06                	sd	ra,24(sp)
 438:	e822                	sd	s0,16(sp)
 43a:	1000                	addi	s0,sp,32
 43c:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 440:	4605                	li	a2,1
 442:	fef40593          	addi	a1,s0,-17
 446:	00000097          	auipc	ra,0x0
 44a:	f66080e7          	jalr	-154(ra) # 3ac <write>
}
 44e:	60e2                	ld	ra,24(sp)
 450:	6442                	ld	s0,16(sp)
 452:	6105                	addi	sp,sp,32
 454:	8082                	ret

0000000000000456 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 456:	7139                	addi	sp,sp,-64
 458:	fc06                	sd	ra,56(sp)
 45a:	f822                	sd	s0,48(sp)
 45c:	f04a                	sd	s2,32(sp)
 45e:	ec4e                	sd	s3,24(sp)
 460:	0080                	addi	s0,sp,64
 462:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 464:	cad9                	beqz	a3,4fa <printint+0xa4>
 466:	01f5d79b          	srliw	a5,a1,0x1f
 46a:	cbc1                	beqz	a5,4fa <printint+0xa4>
    neg = 1;
    x = -xx;
 46c:	40b005bb          	negw	a1,a1
    neg = 1;
 470:	4305                	li	t1,1
  } else {
    x = xx;
  }

  i = 0;
 472:	fc040993          	addi	s3,s0,-64
  neg = 0;
 476:	86ce                	mv	a3,s3
  i = 0;
 478:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 47a:	00000817          	auipc	a6,0x0
 47e:	4be80813          	addi	a6,a6,1214 # 938 <digits>
 482:	88ba                	mv	a7,a4
 484:	0017051b          	addiw	a0,a4,1
 488:	872a                	mv	a4,a0
 48a:	02c5f7bb          	remuw	a5,a1,a2
 48e:	1782                	slli	a5,a5,0x20
 490:	9381                	srli	a5,a5,0x20
 492:	97c2                	add	a5,a5,a6
 494:	0007c783          	lbu	a5,0(a5)
 498:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 49c:	87ae                	mv	a5,a1
 49e:	02c5d5bb          	divuw	a1,a1,a2
 4a2:	0685                	addi	a3,a3,1
 4a4:	fcc7ffe3          	bgeu	a5,a2,482 <printint+0x2c>
  if(neg)
 4a8:	00030c63          	beqz	t1,4c0 <printint+0x6a>
    buf[i++] = '-';
 4ac:	fd050793          	addi	a5,a0,-48
 4b0:	00878533          	add	a0,a5,s0
 4b4:	02d00793          	li	a5,45
 4b8:	fef50823          	sb	a5,-16(a0)
 4bc:	0028871b          	addiw	a4,a7,2

  while(--i >= 0)
 4c0:	02e05763          	blez	a4,4ee <printint+0x98>
 4c4:	f426                	sd	s1,40(sp)
 4c6:	377d                	addiw	a4,a4,-1
 4c8:	00e984b3          	add	s1,s3,a4
 4cc:	19fd                	addi	s3,s3,-1
 4ce:	99ba                	add	s3,s3,a4
 4d0:	1702                	slli	a4,a4,0x20
 4d2:	9301                	srli	a4,a4,0x20
 4d4:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 4d8:	0004c583          	lbu	a1,0(s1)
 4dc:	854a                	mv	a0,s2
 4de:	00000097          	auipc	ra,0x0
 4e2:	f56080e7          	jalr	-170(ra) # 434 <putc>
  while(--i >= 0)
 4e6:	14fd                	addi	s1,s1,-1
 4e8:	ff3498e3          	bne	s1,s3,4d8 <printint+0x82>
 4ec:	74a2                	ld	s1,40(sp)
}
 4ee:	70e2                	ld	ra,56(sp)
 4f0:	7442                	ld	s0,48(sp)
 4f2:	7902                	ld	s2,32(sp)
 4f4:	69e2                	ld	s3,24(sp)
 4f6:	6121                	addi	sp,sp,64
 4f8:	8082                	ret
  neg = 0;
 4fa:	4301                	li	t1,0
 4fc:	bf9d                	j	472 <printint+0x1c>

00000000000004fe <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 4fe:	715d                	addi	sp,sp,-80
 500:	e486                	sd	ra,72(sp)
 502:	e0a2                	sd	s0,64(sp)
 504:	f84a                	sd	s2,48(sp)
 506:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 508:	0005c903          	lbu	s2,0(a1)
 50c:	1a090b63          	beqz	s2,6c2 <vprintf+0x1c4>
 510:	fc26                	sd	s1,56(sp)
 512:	f44e                	sd	s3,40(sp)
 514:	f052                	sd	s4,32(sp)
 516:	ec56                	sd	s5,24(sp)
 518:	e85a                	sd	s6,16(sp)
 51a:	e45e                	sd	s7,8(sp)
 51c:	8aaa                	mv	s5,a0
 51e:	8bb2                	mv	s7,a2
 520:	00158493          	addi	s1,a1,1
  state = 0;
 524:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 526:	02500a13          	li	s4,37
 52a:	4b55                	li	s6,21
 52c:	a839                	j	54a <vprintf+0x4c>
        putc(fd, c);
 52e:	85ca                	mv	a1,s2
 530:	8556                	mv	a0,s5
 532:	00000097          	auipc	ra,0x0
 536:	f02080e7          	jalr	-254(ra) # 434 <putc>
 53a:	a019                	j	540 <vprintf+0x42>
    } else if(state == '%'){
 53c:	01498d63          	beq	s3,s4,556 <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
 540:	0485                	addi	s1,s1,1
 542:	fff4c903          	lbu	s2,-1(s1)
 546:	16090863          	beqz	s2,6b6 <vprintf+0x1b8>
    if(state == 0){
 54a:	fe0999e3          	bnez	s3,53c <vprintf+0x3e>
      if(c == '%'){
 54e:	ff4910e3          	bne	s2,s4,52e <vprintf+0x30>
        state = '%';
 552:	89d2                	mv	s3,s4
 554:	b7f5                	j	540 <vprintf+0x42>
      if(c == 'd'){
 556:	13490563          	beq	s2,s4,680 <vprintf+0x182>
 55a:	f9d9079b          	addiw	a5,s2,-99
 55e:	0ff7f793          	zext.b	a5,a5
 562:	12fb6863          	bltu	s6,a5,692 <vprintf+0x194>
 566:	f9d9079b          	addiw	a5,s2,-99
 56a:	0ff7f713          	zext.b	a4,a5
 56e:	12eb6263          	bltu	s6,a4,692 <vprintf+0x194>
 572:	00271793          	slli	a5,a4,0x2
 576:	00000717          	auipc	a4,0x0
 57a:	36a70713          	addi	a4,a4,874 # 8e0 <malloc+0x12a>
 57e:	97ba                	add	a5,a5,a4
 580:	439c                	lw	a5,0(a5)
 582:	97ba                	add	a5,a5,a4
 584:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 586:	008b8913          	addi	s2,s7,8
 58a:	4685                	li	a3,1
 58c:	4629                	li	a2,10
 58e:	000ba583          	lw	a1,0(s7)
 592:	8556                	mv	a0,s5
 594:	00000097          	auipc	ra,0x0
 598:	ec2080e7          	jalr	-318(ra) # 456 <printint>
 59c:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 59e:	4981                	li	s3,0
 5a0:	b745                	j	540 <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
 5a2:	008b8913          	addi	s2,s7,8
 5a6:	4681                	li	a3,0
 5a8:	4629                	li	a2,10
 5aa:	000ba583          	lw	a1,0(s7)
 5ae:	8556                	mv	a0,s5
 5b0:	00000097          	auipc	ra,0x0
 5b4:	ea6080e7          	jalr	-346(ra) # 456 <printint>
 5b8:	8bca                	mv	s7,s2
      state = 0;
 5ba:	4981                	li	s3,0
 5bc:	b751                	j	540 <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
 5be:	008b8913          	addi	s2,s7,8
 5c2:	4681                	li	a3,0
 5c4:	4641                	li	a2,16
 5c6:	000ba583          	lw	a1,0(s7)
 5ca:	8556                	mv	a0,s5
 5cc:	00000097          	auipc	ra,0x0
 5d0:	e8a080e7          	jalr	-374(ra) # 456 <printint>
 5d4:	8bca                	mv	s7,s2
      state = 0;
 5d6:	4981                	li	s3,0
 5d8:	b7a5                	j	540 <vprintf+0x42>
 5da:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
 5dc:	008b8793          	addi	a5,s7,8
 5e0:	8c3e                	mv	s8,a5
 5e2:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 5e6:	03000593          	li	a1,48
 5ea:	8556                	mv	a0,s5
 5ec:	00000097          	auipc	ra,0x0
 5f0:	e48080e7          	jalr	-440(ra) # 434 <putc>
  putc(fd, 'x');
 5f4:	07800593          	li	a1,120
 5f8:	8556                	mv	a0,s5
 5fa:	00000097          	auipc	ra,0x0
 5fe:	e3a080e7          	jalr	-454(ra) # 434 <putc>
 602:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 604:	00000b97          	auipc	s7,0x0
 608:	334b8b93          	addi	s7,s7,820 # 938 <digits>
 60c:	03c9d793          	srli	a5,s3,0x3c
 610:	97de                	add	a5,a5,s7
 612:	0007c583          	lbu	a1,0(a5)
 616:	8556                	mv	a0,s5
 618:	00000097          	auipc	ra,0x0
 61c:	e1c080e7          	jalr	-484(ra) # 434 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 620:	0992                	slli	s3,s3,0x4
 622:	397d                	addiw	s2,s2,-1
 624:	fe0914e3          	bnez	s2,60c <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
 628:	8be2                	mv	s7,s8
      state = 0;
 62a:	4981                	li	s3,0
 62c:	6c02                	ld	s8,0(sp)
 62e:	bf09                	j	540 <vprintf+0x42>
        s = va_arg(ap, char*);
 630:	008b8993          	addi	s3,s7,8
 634:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 638:	02090163          	beqz	s2,65a <vprintf+0x15c>
        while(*s != 0){
 63c:	00094583          	lbu	a1,0(s2)
 640:	c9a5                	beqz	a1,6b0 <vprintf+0x1b2>
          putc(fd, *s);
 642:	8556                	mv	a0,s5
 644:	00000097          	auipc	ra,0x0
 648:	df0080e7          	jalr	-528(ra) # 434 <putc>
          s++;
 64c:	0905                	addi	s2,s2,1
        while(*s != 0){
 64e:	00094583          	lbu	a1,0(s2)
 652:	f9e5                	bnez	a1,642 <vprintf+0x144>
        s = va_arg(ap, char*);
 654:	8bce                	mv	s7,s3
      state = 0;
 656:	4981                	li	s3,0
 658:	b5e5                	j	540 <vprintf+0x42>
          s = "(null)";
 65a:	00000917          	auipc	s2,0x0
 65e:	27e90913          	addi	s2,s2,638 # 8d8 <malloc+0x122>
        while(*s != 0){
 662:	02800593          	li	a1,40
 666:	bff1                	j	642 <vprintf+0x144>
        putc(fd, va_arg(ap, uint));
 668:	008b8913          	addi	s2,s7,8
 66c:	000bc583          	lbu	a1,0(s7)
 670:	8556                	mv	a0,s5
 672:	00000097          	auipc	ra,0x0
 676:	dc2080e7          	jalr	-574(ra) # 434 <putc>
 67a:	8bca                	mv	s7,s2
      state = 0;
 67c:	4981                	li	s3,0
 67e:	b5c9                	j	540 <vprintf+0x42>
        putc(fd, c);
 680:	02500593          	li	a1,37
 684:	8556                	mv	a0,s5
 686:	00000097          	auipc	ra,0x0
 68a:	dae080e7          	jalr	-594(ra) # 434 <putc>
      state = 0;
 68e:	4981                	li	s3,0
 690:	bd45                	j	540 <vprintf+0x42>
        putc(fd, '%');
 692:	02500593          	li	a1,37
 696:	8556                	mv	a0,s5
 698:	00000097          	auipc	ra,0x0
 69c:	d9c080e7          	jalr	-612(ra) # 434 <putc>
        putc(fd, c);
 6a0:	85ca                	mv	a1,s2
 6a2:	8556                	mv	a0,s5
 6a4:	00000097          	auipc	ra,0x0
 6a8:	d90080e7          	jalr	-624(ra) # 434 <putc>
      state = 0;
 6ac:	4981                	li	s3,0
 6ae:	bd49                	j	540 <vprintf+0x42>
        s = va_arg(ap, char*);
 6b0:	8bce                	mv	s7,s3
      state = 0;
 6b2:	4981                	li	s3,0
 6b4:	b571                	j	540 <vprintf+0x42>
 6b6:	74e2                	ld	s1,56(sp)
 6b8:	79a2                	ld	s3,40(sp)
 6ba:	7a02                	ld	s4,32(sp)
 6bc:	6ae2                	ld	s5,24(sp)
 6be:	6b42                	ld	s6,16(sp)
 6c0:	6ba2                	ld	s7,8(sp)
    }
  }
}
 6c2:	60a6                	ld	ra,72(sp)
 6c4:	6406                	ld	s0,64(sp)
 6c6:	7942                	ld	s2,48(sp)
 6c8:	6161                	addi	sp,sp,80
 6ca:	8082                	ret

00000000000006cc <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 6cc:	715d                	addi	sp,sp,-80
 6ce:	ec06                	sd	ra,24(sp)
 6d0:	e822                	sd	s0,16(sp)
 6d2:	1000                	addi	s0,sp,32
 6d4:	e010                	sd	a2,0(s0)
 6d6:	e414                	sd	a3,8(s0)
 6d8:	e818                	sd	a4,16(s0)
 6da:	ec1c                	sd	a5,24(s0)
 6dc:	03043023          	sd	a6,32(s0)
 6e0:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 6e4:	8622                	mv	a2,s0
 6e6:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 6ea:	00000097          	auipc	ra,0x0
 6ee:	e14080e7          	jalr	-492(ra) # 4fe <vprintf>
}
 6f2:	60e2                	ld	ra,24(sp)
 6f4:	6442                	ld	s0,16(sp)
 6f6:	6161                	addi	sp,sp,80
 6f8:	8082                	ret

00000000000006fa <printf>:

void
printf(const char *fmt, ...)
{
 6fa:	711d                	addi	sp,sp,-96
 6fc:	ec06                	sd	ra,24(sp)
 6fe:	e822                	sd	s0,16(sp)
 700:	1000                	addi	s0,sp,32
 702:	e40c                	sd	a1,8(s0)
 704:	e810                	sd	a2,16(s0)
 706:	ec14                	sd	a3,24(s0)
 708:	f018                	sd	a4,32(s0)
 70a:	f41c                	sd	a5,40(s0)
 70c:	03043823          	sd	a6,48(s0)
 710:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 714:	00840613          	addi	a2,s0,8
 718:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 71c:	85aa                	mv	a1,a0
 71e:	4505                	li	a0,1
 720:	00000097          	auipc	ra,0x0
 724:	dde080e7          	jalr	-546(ra) # 4fe <vprintf>
}
 728:	60e2                	ld	ra,24(sp)
 72a:	6442                	ld	s0,16(sp)
 72c:	6125                	addi	sp,sp,96
 72e:	8082                	ret

0000000000000730 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 730:	1141                	addi	sp,sp,-16
 732:	e406                	sd	ra,8(sp)
 734:	e022                	sd	s0,0(sp)
 736:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 738:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 73c:	00000797          	auipc	a5,0x0
 740:	2147b783          	ld	a5,532(a5) # 950 <freep>
 744:	a039                	j	752 <free+0x22>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 746:	6398                	ld	a4,0(a5)
 748:	00e7e463          	bltu	a5,a4,750 <free+0x20>
 74c:	00e6ea63          	bltu	a3,a4,760 <free+0x30>
{
 750:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 752:	fed7fae3          	bgeu	a5,a3,746 <free+0x16>
 756:	6398                	ld	a4,0(a5)
 758:	00e6e463          	bltu	a3,a4,760 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 75c:	fee7eae3          	bltu	a5,a4,750 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 760:	ff852583          	lw	a1,-8(a0)
 764:	6390                	ld	a2,0(a5)
 766:	02059813          	slli	a6,a1,0x20
 76a:	01c85713          	srli	a4,a6,0x1c
 76e:	9736                	add	a4,a4,a3
 770:	02e60563          	beq	a2,a4,79a <free+0x6a>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 774:	fec53823          	sd	a2,-16(a0)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 778:	4790                	lw	a2,8(a5)
 77a:	02061593          	slli	a1,a2,0x20
 77e:	01c5d713          	srli	a4,a1,0x1c
 782:	973e                	add	a4,a4,a5
 784:	02e68263          	beq	a3,a4,7a8 <free+0x78>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 788:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 78a:	00000717          	auipc	a4,0x0
 78e:	1cf73323          	sd	a5,454(a4) # 950 <freep>
}
 792:	60a2                	ld	ra,8(sp)
 794:	6402                	ld	s0,0(sp)
 796:	0141                	addi	sp,sp,16
 798:	8082                	ret
    bp->s.size += p->s.ptr->s.size;
 79a:	4618                	lw	a4,8(a2)
 79c:	9f2d                	addw	a4,a4,a1
 79e:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 7a2:	6398                	ld	a4,0(a5)
 7a4:	6310                	ld	a2,0(a4)
 7a6:	b7f9                	j	774 <free+0x44>
    p->s.size += bp->s.size;
 7a8:	ff852703          	lw	a4,-8(a0)
 7ac:	9f31                	addw	a4,a4,a2
 7ae:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 7b0:	ff053683          	ld	a3,-16(a0)
 7b4:	bfd1                	j	788 <free+0x58>

00000000000007b6 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7b6:	7139                	addi	sp,sp,-64
 7b8:	fc06                	sd	ra,56(sp)
 7ba:	f822                	sd	s0,48(sp)
 7bc:	f04a                	sd	s2,32(sp)
 7be:	ec4e                	sd	s3,24(sp)
 7c0:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7c2:	02051993          	slli	s3,a0,0x20
 7c6:	0209d993          	srli	s3,s3,0x20
 7ca:	09bd                	addi	s3,s3,15
 7cc:	0049d993          	srli	s3,s3,0x4
 7d0:	2985                	addiw	s3,s3,1
 7d2:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 7d4:	00000517          	auipc	a0,0x0
 7d8:	17c53503          	ld	a0,380(a0) # 950 <freep>
 7dc:	c905                	beqz	a0,80c <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7de:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 7e0:	4798                	lw	a4,8(a5)
 7e2:	09377a63          	bgeu	a4,s3,876 <malloc+0xc0>
 7e6:	f426                	sd	s1,40(sp)
 7e8:	e852                	sd	s4,16(sp)
 7ea:	e456                	sd	s5,8(sp)
 7ec:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 7ee:	8a4e                	mv	s4,s3
 7f0:	6705                	lui	a4,0x1
 7f2:	00e9f363          	bgeu	s3,a4,7f8 <malloc+0x42>
 7f6:	6a05                	lui	s4,0x1
 7f8:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 7fc:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 800:	00000497          	auipc	s1,0x0
 804:	15048493          	addi	s1,s1,336 # 950 <freep>
  if(p == (char*)-1)
 808:	5afd                	li	s5,-1
 80a:	a089                	j	84c <malloc+0x96>
 80c:	f426                	sd	s1,40(sp)
 80e:	e852                	sd	s4,16(sp)
 810:	e456                	sd	s5,8(sp)
 812:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 814:	00000797          	auipc	a5,0x0
 818:	14478793          	addi	a5,a5,324 # 958 <base>
 81c:	00000717          	auipc	a4,0x0
 820:	12f73a23          	sd	a5,308(a4) # 950 <freep>
 824:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 826:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 82a:	b7d1                	j	7ee <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 82c:	6398                	ld	a4,0(a5)
 82e:	e118                	sd	a4,0(a0)
 830:	a8b9                	j	88e <malloc+0xd8>
  hp->s.size = nu;
 832:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 836:	0541                	addi	a0,a0,16
 838:	00000097          	auipc	ra,0x0
 83c:	ef8080e7          	jalr	-264(ra) # 730 <free>
  return freep;
 840:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 842:	c135                	beqz	a0,8a6 <malloc+0xf0>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 844:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 846:	4798                	lw	a4,8(a5)
 848:	03277363          	bgeu	a4,s2,86e <malloc+0xb8>
    if(p == freep)
 84c:	6098                	ld	a4,0(s1)
 84e:	853e                	mv	a0,a5
 850:	fef71ae3          	bne	a4,a5,844 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 854:	8552                	mv	a0,s4
 856:	00000097          	auipc	ra,0x0
 85a:	bbe080e7          	jalr	-1090(ra) # 414 <sbrk>
  if(p == (char*)-1)
 85e:	fd551ae3          	bne	a0,s5,832 <malloc+0x7c>
        return 0;
 862:	4501                	li	a0,0
 864:	74a2                	ld	s1,40(sp)
 866:	6a42                	ld	s4,16(sp)
 868:	6aa2                	ld	s5,8(sp)
 86a:	6b02                	ld	s6,0(sp)
 86c:	a03d                	j	89a <malloc+0xe4>
 86e:	74a2                	ld	s1,40(sp)
 870:	6a42                	ld	s4,16(sp)
 872:	6aa2                	ld	s5,8(sp)
 874:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 876:	fae90be3          	beq	s2,a4,82c <malloc+0x76>
        p->s.size -= nunits;
 87a:	4137073b          	subw	a4,a4,s3
 87e:	c798                	sw	a4,8(a5)
        p += p->s.size;
 880:	02071693          	slli	a3,a4,0x20
 884:	01c6d713          	srli	a4,a3,0x1c
 888:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 88a:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 88e:	00000717          	auipc	a4,0x0
 892:	0ca73123          	sd	a0,194(a4) # 950 <freep>
      return (void*)(p + 1);
 896:	01078513          	addi	a0,a5,16
  }
}
 89a:	70e2                	ld	ra,56(sp)
 89c:	7442                	ld	s0,48(sp)
 89e:	7902                	ld	s2,32(sp)
 8a0:	69e2                	ld	s3,24(sp)
 8a2:	6121                	addi	sp,sp,64
 8a4:	8082                	ret
 8a6:	74a2                	ld	s1,40(sp)
 8a8:	6a42                	ld	s4,16(sp)
 8aa:	6aa2                	ld	s5,8(sp)
 8ac:	6b02                	ld	s6,0(sp)
 8ae:	b7f5                	j	89a <malloc+0xe4>
