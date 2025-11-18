
user/_cat：     文件格式 elf64-littleriscv


Disassembly of section .text:

0000000000000000 <cat>:

char buf[512];

void
cat(int fd)
{
   0:	7139                	addi	sp,sp,-64
   2:	fc06                	sd	ra,56(sp)
   4:	f822                	sd	s0,48(sp)
   6:	f426                	sd	s1,40(sp)
   8:	f04a                	sd	s2,32(sp)
   a:	ec4e                	sd	s3,24(sp)
   c:	e852                	sd	s4,16(sp)
   e:	e456                	sd	s5,8(sp)
  10:	0080                	addi	s0,sp,64
  12:	89aa                	mv	s3,a0
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0) {
  14:	20000a13          	li	s4,512
  18:	00001917          	auipc	s2,0x1
  1c:	99090913          	addi	s2,s2,-1648 # 9a8 <buf>
    if (write(1, buf, n) != n) {
  20:	4a85                	li	s5,1
  while((n = read(fd, buf, sizeof(buf))) > 0) {
  22:	8652                	mv	a2,s4
  24:	85ca                	mv	a1,s2
  26:	854e                	mv	a0,s3
  28:	00000097          	auipc	ra,0x0
  2c:	3a6080e7          	jalr	934(ra) # 3ce <read>
  30:	84aa                	mv	s1,a0
  32:	02a05863          	blez	a0,62 <cat+0x62>
    if (write(1, buf, n) != n) {
  36:	8626                	mv	a2,s1
  38:	85ca                	mv	a1,s2
  3a:	8556                	mv	a0,s5
  3c:	00000097          	auipc	ra,0x0
  40:	39a080e7          	jalr	922(ra) # 3d6 <write>
  44:	fc950fe3          	beq	a0,s1,22 <cat+0x22>
      printf("cat: write error\n");
  48:	00001517          	auipc	a0,0x1
  4c:	89850513          	addi	a0,a0,-1896 # 8e0 <malloc+0x100>
  50:	00000097          	auipc	ra,0x0
  54:	6d4080e7          	jalr	1748(ra) # 724 <printf>
      exit(1);
  58:	4505                	li	a0,1
  5a:	00000097          	auipc	ra,0x0
  5e:	35c080e7          	jalr	860(ra) # 3b6 <exit>
    }
  }
  if(n < 0){
  62:	00054b63          	bltz	a0,78 <cat+0x78>
    printf("cat: read error\n");
    exit(1);
  }
}
  66:	70e2                	ld	ra,56(sp)
  68:	7442                	ld	s0,48(sp)
  6a:	74a2                	ld	s1,40(sp)
  6c:	7902                	ld	s2,32(sp)
  6e:	69e2                	ld	s3,24(sp)
  70:	6a42                	ld	s4,16(sp)
  72:	6aa2                	ld	s5,8(sp)
  74:	6121                	addi	sp,sp,64
  76:	8082                	ret
    printf("cat: read error\n");
  78:	00001517          	auipc	a0,0x1
  7c:	88050513          	addi	a0,a0,-1920 # 8f8 <malloc+0x118>
  80:	00000097          	auipc	ra,0x0
  84:	6a4080e7          	jalr	1700(ra) # 724 <printf>
    exit(1);
  88:	4505                	li	a0,1
  8a:	00000097          	auipc	ra,0x0
  8e:	32c080e7          	jalr	812(ra) # 3b6 <exit>

0000000000000092 <main>:

int
main(int argc, char *argv[])
{
  92:	7179                	addi	sp,sp,-48
  94:	f406                	sd	ra,40(sp)
  96:	f022                	sd	s0,32(sp)
  98:	1800                	addi	s0,sp,48
  int fd, i;

  if(argc <= 1){
  9a:	4785                	li	a5,1
  9c:	04a7da63          	bge	a5,a0,f0 <main+0x5e>
  a0:	ec26                	sd	s1,24(sp)
  a2:	e84a                	sd	s2,16(sp)
  a4:	e44e                	sd	s3,8(sp)
  a6:	00858913          	addi	s2,a1,8
  aa:	ffe5099b          	addiw	s3,a0,-2
  ae:	02099793          	slli	a5,s3,0x20
  b2:	01d7d993          	srli	s3,a5,0x1d
  b6:	05c1                	addi	a1,a1,16
  b8:	99ae                	add	s3,s3,a1
    cat(0);
    exit(1);
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
  ba:	4581                	li	a1,0
  bc:	00093503          	ld	a0,0(s2)
  c0:	00000097          	auipc	ra,0x0
  c4:	336080e7          	jalr	822(ra) # 3f6 <open>
  c8:	84aa                	mv	s1,a0
  ca:	04054063          	bltz	a0,10a <main+0x78>
      printf("cat: cannot open %s\n", argv[i]);
      exit(1);
    }
    cat(fd);
  ce:	00000097          	auipc	ra,0x0
  d2:	f32080e7          	jalr	-206(ra) # 0 <cat>
    close(fd);
  d6:	8526                	mv	a0,s1
  d8:	00000097          	auipc	ra,0x0
  dc:	306080e7          	jalr	774(ra) # 3de <close>
  for(i = 1; i < argc; i++){
  e0:	0921                	addi	s2,s2,8
  e2:	fd391ce3          	bne	s2,s3,ba <main+0x28>
  }
  exit(0);
  e6:	4501                	li	a0,0
  e8:	00000097          	auipc	ra,0x0
  ec:	2ce080e7          	jalr	718(ra) # 3b6 <exit>
  f0:	ec26                	sd	s1,24(sp)
  f2:	e84a                	sd	s2,16(sp)
  f4:	e44e                	sd	s3,8(sp)
    cat(0);
  f6:	4501                	li	a0,0
  f8:	00000097          	auipc	ra,0x0
  fc:	f08080e7          	jalr	-248(ra) # 0 <cat>
    exit(1);
 100:	4505                	li	a0,1
 102:	00000097          	auipc	ra,0x0
 106:	2b4080e7          	jalr	692(ra) # 3b6 <exit>
      printf("cat: cannot open %s\n", argv[i]);
 10a:	00093583          	ld	a1,0(s2)
 10e:	00001517          	auipc	a0,0x1
 112:	80250513          	addi	a0,a0,-2046 # 910 <malloc+0x130>
 116:	00000097          	auipc	ra,0x0
 11a:	60e080e7          	jalr	1550(ra) # 724 <printf>
      exit(1);
 11e:	4505                	li	a0,1
 120:	00000097          	auipc	ra,0x0
 124:	296080e7          	jalr	662(ra) # 3b6 <exit>

0000000000000128 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 128:	1141                	addi	sp,sp,-16
 12a:	e406                	sd	ra,8(sp)
 12c:	e022                	sd	s0,0(sp)
 12e:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 130:	87aa                	mv	a5,a0
 132:	0585                	addi	a1,a1,1
 134:	0785                	addi	a5,a5,1
 136:	fff5c703          	lbu	a4,-1(a1)
 13a:	fee78fa3          	sb	a4,-1(a5)
 13e:	fb75                	bnez	a4,132 <strcpy+0xa>
    ;
  return os;
}
 140:	60a2                	ld	ra,8(sp)
 142:	6402                	ld	s0,0(sp)
 144:	0141                	addi	sp,sp,16
 146:	8082                	ret

0000000000000148 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 148:	1141                	addi	sp,sp,-16
 14a:	e406                	sd	ra,8(sp)
 14c:	e022                	sd	s0,0(sp)
 14e:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 150:	00054783          	lbu	a5,0(a0)
 154:	cb91                	beqz	a5,168 <strcmp+0x20>
 156:	0005c703          	lbu	a4,0(a1)
 15a:	00f71763          	bne	a4,a5,168 <strcmp+0x20>
    p++, q++;
 15e:	0505                	addi	a0,a0,1
 160:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 162:	00054783          	lbu	a5,0(a0)
 166:	fbe5                	bnez	a5,156 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 168:	0005c503          	lbu	a0,0(a1)
}
 16c:	40a7853b          	subw	a0,a5,a0
 170:	60a2                	ld	ra,8(sp)
 172:	6402                	ld	s0,0(sp)
 174:	0141                	addi	sp,sp,16
 176:	8082                	ret

0000000000000178 <strlen>:

uint
strlen(const char *s)
{
 178:	1141                	addi	sp,sp,-16
 17a:	e406                	sd	ra,8(sp)
 17c:	e022                	sd	s0,0(sp)
 17e:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 180:	00054783          	lbu	a5,0(a0)
 184:	cf91                	beqz	a5,1a0 <strlen+0x28>
 186:	00150793          	addi	a5,a0,1
 18a:	86be                	mv	a3,a5
 18c:	0785                	addi	a5,a5,1
 18e:	fff7c703          	lbu	a4,-1(a5)
 192:	ff65                	bnez	a4,18a <strlen+0x12>
 194:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
 198:	60a2                	ld	ra,8(sp)
 19a:	6402                	ld	s0,0(sp)
 19c:	0141                	addi	sp,sp,16
 19e:	8082                	ret
  for(n = 0; s[n]; n++)
 1a0:	4501                	li	a0,0
 1a2:	bfdd                	j	198 <strlen+0x20>

00000000000001a4 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1a4:	1141                	addi	sp,sp,-16
 1a6:	e406                	sd	ra,8(sp)
 1a8:	e022                	sd	s0,0(sp)
 1aa:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 1ac:	ca19                	beqz	a2,1c2 <memset+0x1e>
 1ae:	87aa                	mv	a5,a0
 1b0:	1602                	slli	a2,a2,0x20
 1b2:	9201                	srli	a2,a2,0x20
 1b4:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 1b8:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 1bc:	0785                	addi	a5,a5,1
 1be:	fee79de3          	bne	a5,a4,1b8 <memset+0x14>
  }
  return dst;
}
 1c2:	60a2                	ld	ra,8(sp)
 1c4:	6402                	ld	s0,0(sp)
 1c6:	0141                	addi	sp,sp,16
 1c8:	8082                	ret

00000000000001ca <strchr>:

char*
strchr(const char *s, char c)
{
 1ca:	1141                	addi	sp,sp,-16
 1cc:	e406                	sd	ra,8(sp)
 1ce:	e022                	sd	s0,0(sp)
 1d0:	0800                	addi	s0,sp,16
  for(; *s; s++)
 1d2:	00054783          	lbu	a5,0(a0)
 1d6:	cf81                	beqz	a5,1ee <strchr+0x24>
    if(*s == c)
 1d8:	00f58763          	beq	a1,a5,1e6 <strchr+0x1c>
  for(; *s; s++)
 1dc:	0505                	addi	a0,a0,1
 1de:	00054783          	lbu	a5,0(a0)
 1e2:	fbfd                	bnez	a5,1d8 <strchr+0xe>
      return (char*)s;
  return 0;
 1e4:	4501                	li	a0,0
}
 1e6:	60a2                	ld	ra,8(sp)
 1e8:	6402                	ld	s0,0(sp)
 1ea:	0141                	addi	sp,sp,16
 1ec:	8082                	ret
  return 0;
 1ee:	4501                	li	a0,0
 1f0:	bfdd                	j	1e6 <strchr+0x1c>

00000000000001f2 <gets>:

char*
gets(char *buf, int max)
{
 1f2:	711d                	addi	sp,sp,-96
 1f4:	ec86                	sd	ra,88(sp)
 1f6:	e8a2                	sd	s0,80(sp)
 1f8:	e4a6                	sd	s1,72(sp)
 1fa:	e0ca                	sd	s2,64(sp)
 1fc:	fc4e                	sd	s3,56(sp)
 1fe:	f852                	sd	s4,48(sp)
 200:	f456                	sd	s5,40(sp)
 202:	f05a                	sd	s6,32(sp)
 204:	ec5e                	sd	s7,24(sp)
 206:	e862                	sd	s8,16(sp)
 208:	1080                	addi	s0,sp,96
 20a:	8baa                	mv	s7,a0
 20c:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 20e:	892a                	mv	s2,a0
 210:	4481                	li	s1,0
    cc = read(0, &c, 1);
 212:	faf40b13          	addi	s6,s0,-81
 216:	4a85                	li	s5,1
  for(i=0; i+1 < max; ){
 218:	8c26                	mv	s8,s1
 21a:	0014899b          	addiw	s3,s1,1
 21e:	84ce                	mv	s1,s3
 220:	0349d663          	bge	s3,s4,24c <gets+0x5a>
    cc = read(0, &c, 1);
 224:	8656                	mv	a2,s5
 226:	85da                	mv	a1,s6
 228:	4501                	li	a0,0
 22a:	00000097          	auipc	ra,0x0
 22e:	1a4080e7          	jalr	420(ra) # 3ce <read>
    if(cc < 1)
 232:	00a05d63          	blez	a0,24c <gets+0x5a>
      break;
    buf[i++] = c;
 236:	faf44783          	lbu	a5,-81(s0)
 23a:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 23e:	0905                	addi	s2,s2,1
 240:	ff678713          	addi	a4,a5,-10
 244:	c319                	beqz	a4,24a <gets+0x58>
 246:	17cd                	addi	a5,a5,-13
 248:	fbe1                	bnez	a5,218 <gets+0x26>
    buf[i++] = c;
 24a:	8c4e                	mv	s8,s3
      break;
  }
  buf[i] = '\0';
 24c:	9c5e                	add	s8,s8,s7
 24e:	000c0023          	sb	zero,0(s8)
  return buf;
}
 252:	855e                	mv	a0,s7
 254:	60e6                	ld	ra,88(sp)
 256:	6446                	ld	s0,80(sp)
 258:	64a6                	ld	s1,72(sp)
 25a:	6906                	ld	s2,64(sp)
 25c:	79e2                	ld	s3,56(sp)
 25e:	7a42                	ld	s4,48(sp)
 260:	7aa2                	ld	s5,40(sp)
 262:	7b02                	ld	s6,32(sp)
 264:	6be2                	ld	s7,24(sp)
 266:	6c42                	ld	s8,16(sp)
 268:	6125                	addi	sp,sp,96
 26a:	8082                	ret

000000000000026c <stat>:

int
stat(const char *n, struct stat *st)
{
 26c:	1101                	addi	sp,sp,-32
 26e:	ec06                	sd	ra,24(sp)
 270:	e822                	sd	s0,16(sp)
 272:	e04a                	sd	s2,0(sp)
 274:	1000                	addi	s0,sp,32
 276:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 278:	4581                	li	a1,0
 27a:	00000097          	auipc	ra,0x0
 27e:	17c080e7          	jalr	380(ra) # 3f6 <open>
  if(fd < 0)
 282:	02054663          	bltz	a0,2ae <stat+0x42>
 286:	e426                	sd	s1,8(sp)
 288:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 28a:	85ca                	mv	a1,s2
 28c:	00000097          	auipc	ra,0x0
 290:	182080e7          	jalr	386(ra) # 40e <fstat>
 294:	892a                	mv	s2,a0
  close(fd);
 296:	8526                	mv	a0,s1
 298:	00000097          	auipc	ra,0x0
 29c:	146080e7          	jalr	326(ra) # 3de <close>
  return r;
 2a0:	64a2                	ld	s1,8(sp)
}
 2a2:	854a                	mv	a0,s2
 2a4:	60e2                	ld	ra,24(sp)
 2a6:	6442                	ld	s0,16(sp)
 2a8:	6902                	ld	s2,0(sp)
 2aa:	6105                	addi	sp,sp,32
 2ac:	8082                	ret
    return -1;
 2ae:	57fd                	li	a5,-1
 2b0:	893e                	mv	s2,a5
 2b2:	bfc5                	j	2a2 <stat+0x36>

00000000000002b4 <atoi>:

int
atoi(const char *s)
{
 2b4:	1141                	addi	sp,sp,-16
 2b6:	e406                	sd	ra,8(sp)
 2b8:	e022                	sd	s0,0(sp)
 2ba:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2bc:	00054683          	lbu	a3,0(a0)
 2c0:	fd06879b          	addiw	a5,a3,-48
 2c4:	0ff7f793          	zext.b	a5,a5
 2c8:	4625                	li	a2,9
 2ca:	02f66963          	bltu	a2,a5,2fc <atoi+0x48>
 2ce:	872a                	mv	a4,a0
  n = 0;
 2d0:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 2d2:	0705                	addi	a4,a4,1
 2d4:	0025179b          	slliw	a5,a0,0x2
 2d8:	9fa9                	addw	a5,a5,a0
 2da:	0017979b          	slliw	a5,a5,0x1
 2de:	9fb5                	addw	a5,a5,a3
 2e0:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 2e4:	00074683          	lbu	a3,0(a4)
 2e8:	fd06879b          	addiw	a5,a3,-48
 2ec:	0ff7f793          	zext.b	a5,a5
 2f0:	fef671e3          	bgeu	a2,a5,2d2 <atoi+0x1e>
  return n;
}
 2f4:	60a2                	ld	ra,8(sp)
 2f6:	6402                	ld	s0,0(sp)
 2f8:	0141                	addi	sp,sp,16
 2fa:	8082                	ret
  n = 0;
 2fc:	4501                	li	a0,0
 2fe:	bfdd                	j	2f4 <atoi+0x40>

0000000000000300 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 300:	1141                	addi	sp,sp,-16
 302:	e406                	sd	ra,8(sp)
 304:	e022                	sd	s0,0(sp)
 306:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 308:	02b57563          	bgeu	a0,a1,332 <memmove+0x32>
    while(n-- > 0)
 30c:	00c05f63          	blez	a2,32a <memmove+0x2a>
 310:	1602                	slli	a2,a2,0x20
 312:	9201                	srli	a2,a2,0x20
 314:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 318:	872a                	mv	a4,a0
      *dst++ = *src++;
 31a:	0585                	addi	a1,a1,1
 31c:	0705                	addi	a4,a4,1
 31e:	fff5c683          	lbu	a3,-1(a1)
 322:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 326:	fee79ae3          	bne	a5,a4,31a <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 32a:	60a2                	ld	ra,8(sp)
 32c:	6402                	ld	s0,0(sp)
 32e:	0141                	addi	sp,sp,16
 330:	8082                	ret
    while(n-- > 0)
 332:	fec05ce3          	blez	a2,32a <memmove+0x2a>
    dst += n;
 336:	00c50733          	add	a4,a0,a2
    src += n;
 33a:	95b2                	add	a1,a1,a2
 33c:	fff6079b          	addiw	a5,a2,-1
 340:	1782                	slli	a5,a5,0x20
 342:	9381                	srli	a5,a5,0x20
 344:	fff7c793          	not	a5,a5
 348:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 34a:	15fd                	addi	a1,a1,-1
 34c:	177d                	addi	a4,a4,-1
 34e:	0005c683          	lbu	a3,0(a1)
 352:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 356:	fef71ae3          	bne	a4,a5,34a <memmove+0x4a>
 35a:	bfc1                	j	32a <memmove+0x2a>

000000000000035c <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 35c:	1141                	addi	sp,sp,-16
 35e:	e406                	sd	ra,8(sp)
 360:	e022                	sd	s0,0(sp)
 362:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 364:	c61d                	beqz	a2,392 <memcmp+0x36>
 366:	1602                	slli	a2,a2,0x20
 368:	9201                	srli	a2,a2,0x20
 36a:	00c506b3          	add	a3,a0,a2
    if (*p1 != *p2) {
 36e:	00054783          	lbu	a5,0(a0)
 372:	0005c703          	lbu	a4,0(a1)
 376:	00e79863          	bne	a5,a4,386 <memcmp+0x2a>
      return *p1 - *p2;
    }
    p1++;
 37a:	0505                	addi	a0,a0,1
    p2++;
 37c:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 37e:	fed518e3          	bne	a0,a3,36e <memcmp+0x12>
  }
  return 0;
 382:	4501                	li	a0,0
 384:	a019                	j	38a <memcmp+0x2e>
      return *p1 - *p2;
 386:	40e7853b          	subw	a0,a5,a4
}
 38a:	60a2                	ld	ra,8(sp)
 38c:	6402                	ld	s0,0(sp)
 38e:	0141                	addi	sp,sp,16
 390:	8082                	ret
  return 0;
 392:	4501                	li	a0,0
 394:	bfdd                	j	38a <memcmp+0x2e>

0000000000000396 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 396:	1141                	addi	sp,sp,-16
 398:	e406                	sd	ra,8(sp)
 39a:	e022                	sd	s0,0(sp)
 39c:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 39e:	00000097          	auipc	ra,0x0
 3a2:	f62080e7          	jalr	-158(ra) # 300 <memmove>
}
 3a6:	60a2                	ld	ra,8(sp)
 3a8:	6402                	ld	s0,0(sp)
 3aa:	0141                	addi	sp,sp,16
 3ac:	8082                	ret

00000000000003ae <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 3ae:	4885                	li	a7,1
 ecall
 3b0:	00000073          	ecall
 ret
 3b4:	8082                	ret

00000000000003b6 <exit>:
.global exit
exit:
 li a7, SYS_exit
 3b6:	4889                	li	a7,2
 ecall
 3b8:	00000073          	ecall
 ret
 3bc:	8082                	ret

00000000000003be <wait>:
.global wait
wait:
 li a7, SYS_wait
 3be:	488d                	li	a7,3
 ecall
 3c0:	00000073          	ecall
 ret
 3c4:	8082                	ret

00000000000003c6 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3c6:	4891                	li	a7,4
 ecall
 3c8:	00000073          	ecall
 ret
 3cc:	8082                	ret

00000000000003ce <read>:
.global read
read:
 li a7, SYS_read
 3ce:	4895                	li	a7,5
 ecall
 3d0:	00000073          	ecall
 ret
 3d4:	8082                	ret

00000000000003d6 <write>:
.global write
write:
 li a7, SYS_write
 3d6:	48c1                	li	a7,16
 ecall
 3d8:	00000073          	ecall
 ret
 3dc:	8082                	ret

00000000000003de <close>:
.global close
close:
 li a7, SYS_close
 3de:	48d5                	li	a7,21
 ecall
 3e0:	00000073          	ecall
 ret
 3e4:	8082                	ret

00000000000003e6 <kill>:
.global kill
kill:
 li a7, SYS_kill
 3e6:	4899                	li	a7,6
 ecall
 3e8:	00000073          	ecall
 ret
 3ec:	8082                	ret

00000000000003ee <exec>:
.global exec
exec:
 li a7, SYS_exec
 3ee:	489d                	li	a7,7
 ecall
 3f0:	00000073          	ecall
 ret
 3f4:	8082                	ret

00000000000003f6 <open>:
.global open
open:
 li a7, SYS_open
 3f6:	48bd                	li	a7,15
 ecall
 3f8:	00000073          	ecall
 ret
 3fc:	8082                	ret

00000000000003fe <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 3fe:	48c5                	li	a7,17
 ecall
 400:	00000073          	ecall
 ret
 404:	8082                	ret

0000000000000406 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 406:	48c9                	li	a7,18
 ecall
 408:	00000073          	ecall
 ret
 40c:	8082                	ret

000000000000040e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 40e:	48a1                	li	a7,8
 ecall
 410:	00000073          	ecall
 ret
 414:	8082                	ret

0000000000000416 <link>:
.global link
link:
 li a7, SYS_link
 416:	48cd                	li	a7,19
 ecall
 418:	00000073          	ecall
 ret
 41c:	8082                	ret

000000000000041e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 41e:	48d1                	li	a7,20
 ecall
 420:	00000073          	ecall
 ret
 424:	8082                	ret

0000000000000426 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 426:	48a5                	li	a7,9
 ecall
 428:	00000073          	ecall
 ret
 42c:	8082                	ret

000000000000042e <dup>:
.global dup
dup:
 li a7, SYS_dup
 42e:	48a9                	li	a7,10
 ecall
 430:	00000073          	ecall
 ret
 434:	8082                	ret

0000000000000436 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 436:	48ad                	li	a7,11
 ecall
 438:	00000073          	ecall
 ret
 43c:	8082                	ret

000000000000043e <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 43e:	48b1                	li	a7,12
 ecall
 440:	00000073          	ecall
 ret
 444:	8082                	ret

0000000000000446 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 446:	48b5                	li	a7,13
 ecall
 448:	00000073          	ecall
 ret
 44c:	8082                	ret

000000000000044e <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 44e:	48b9                	li	a7,14
 ecall
 450:	00000073          	ecall
 ret
 454:	8082                	ret

0000000000000456 <ntas>:
.global ntas
ntas:
 li a7, SYS_ntas
 456:	48d9                	li	a7,22
 ecall
 458:	00000073          	ecall
 ret
 45c:	8082                	ret

000000000000045e <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 45e:	1101                	addi	sp,sp,-32
 460:	ec06                	sd	ra,24(sp)
 462:	e822                	sd	s0,16(sp)
 464:	1000                	addi	s0,sp,32
 466:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 46a:	4605                	li	a2,1
 46c:	fef40593          	addi	a1,s0,-17
 470:	00000097          	auipc	ra,0x0
 474:	f66080e7          	jalr	-154(ra) # 3d6 <write>
}
 478:	60e2                	ld	ra,24(sp)
 47a:	6442                	ld	s0,16(sp)
 47c:	6105                	addi	sp,sp,32
 47e:	8082                	ret

0000000000000480 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 480:	7139                	addi	sp,sp,-64
 482:	fc06                	sd	ra,56(sp)
 484:	f822                	sd	s0,48(sp)
 486:	f04a                	sd	s2,32(sp)
 488:	ec4e                	sd	s3,24(sp)
 48a:	0080                	addi	s0,sp,64
 48c:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 48e:	cad9                	beqz	a3,524 <printint+0xa4>
 490:	01f5d79b          	srliw	a5,a1,0x1f
 494:	cbc1                	beqz	a5,524 <printint+0xa4>
    neg = 1;
    x = -xx;
 496:	40b005bb          	negw	a1,a1
    neg = 1;
 49a:	4305                	li	t1,1
  } else {
    x = xx;
  }

  i = 0;
 49c:	fc040993          	addi	s3,s0,-64
  neg = 0;
 4a0:	86ce                	mv	a3,s3
  i = 0;
 4a2:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 4a4:	00000817          	auipc	a6,0x0
 4a8:	4e480813          	addi	a6,a6,1252 # 988 <digits>
 4ac:	88ba                	mv	a7,a4
 4ae:	0017051b          	addiw	a0,a4,1
 4b2:	872a                	mv	a4,a0
 4b4:	02c5f7bb          	remuw	a5,a1,a2
 4b8:	1782                	slli	a5,a5,0x20
 4ba:	9381                	srli	a5,a5,0x20
 4bc:	97c2                	add	a5,a5,a6
 4be:	0007c783          	lbu	a5,0(a5)
 4c2:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 4c6:	87ae                	mv	a5,a1
 4c8:	02c5d5bb          	divuw	a1,a1,a2
 4cc:	0685                	addi	a3,a3,1
 4ce:	fcc7ffe3          	bgeu	a5,a2,4ac <printint+0x2c>
  if(neg)
 4d2:	00030c63          	beqz	t1,4ea <printint+0x6a>
    buf[i++] = '-';
 4d6:	fd050793          	addi	a5,a0,-48
 4da:	00878533          	add	a0,a5,s0
 4de:	02d00793          	li	a5,45
 4e2:	fef50823          	sb	a5,-16(a0)
 4e6:	0028871b          	addiw	a4,a7,2

  while(--i >= 0)
 4ea:	02e05763          	blez	a4,518 <printint+0x98>
 4ee:	f426                	sd	s1,40(sp)
 4f0:	377d                	addiw	a4,a4,-1
 4f2:	00e984b3          	add	s1,s3,a4
 4f6:	19fd                	addi	s3,s3,-1
 4f8:	99ba                	add	s3,s3,a4
 4fa:	1702                	slli	a4,a4,0x20
 4fc:	9301                	srli	a4,a4,0x20
 4fe:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 502:	0004c583          	lbu	a1,0(s1)
 506:	854a                	mv	a0,s2
 508:	00000097          	auipc	ra,0x0
 50c:	f56080e7          	jalr	-170(ra) # 45e <putc>
  while(--i >= 0)
 510:	14fd                	addi	s1,s1,-1
 512:	ff3498e3          	bne	s1,s3,502 <printint+0x82>
 516:	74a2                	ld	s1,40(sp)
}
 518:	70e2                	ld	ra,56(sp)
 51a:	7442                	ld	s0,48(sp)
 51c:	7902                	ld	s2,32(sp)
 51e:	69e2                	ld	s3,24(sp)
 520:	6121                	addi	sp,sp,64
 522:	8082                	ret
  neg = 0;
 524:	4301                	li	t1,0
 526:	bf9d                	j	49c <printint+0x1c>

0000000000000528 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 528:	715d                	addi	sp,sp,-80
 52a:	e486                	sd	ra,72(sp)
 52c:	e0a2                	sd	s0,64(sp)
 52e:	f84a                	sd	s2,48(sp)
 530:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 532:	0005c903          	lbu	s2,0(a1)
 536:	1a090b63          	beqz	s2,6ec <vprintf+0x1c4>
 53a:	fc26                	sd	s1,56(sp)
 53c:	f44e                	sd	s3,40(sp)
 53e:	f052                	sd	s4,32(sp)
 540:	ec56                	sd	s5,24(sp)
 542:	e85a                	sd	s6,16(sp)
 544:	e45e                	sd	s7,8(sp)
 546:	8aaa                	mv	s5,a0
 548:	8bb2                	mv	s7,a2
 54a:	00158493          	addi	s1,a1,1
  state = 0;
 54e:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 550:	02500a13          	li	s4,37
 554:	4b55                	li	s6,21
 556:	a839                	j	574 <vprintf+0x4c>
        putc(fd, c);
 558:	85ca                	mv	a1,s2
 55a:	8556                	mv	a0,s5
 55c:	00000097          	auipc	ra,0x0
 560:	f02080e7          	jalr	-254(ra) # 45e <putc>
 564:	a019                	j	56a <vprintf+0x42>
    } else if(state == '%'){
 566:	01498d63          	beq	s3,s4,580 <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
 56a:	0485                	addi	s1,s1,1
 56c:	fff4c903          	lbu	s2,-1(s1)
 570:	16090863          	beqz	s2,6e0 <vprintf+0x1b8>
    if(state == 0){
 574:	fe0999e3          	bnez	s3,566 <vprintf+0x3e>
      if(c == '%'){
 578:	ff4910e3          	bne	s2,s4,558 <vprintf+0x30>
        state = '%';
 57c:	89d2                	mv	s3,s4
 57e:	b7f5                	j	56a <vprintf+0x42>
      if(c == 'd'){
 580:	13490563          	beq	s2,s4,6aa <vprintf+0x182>
 584:	f9d9079b          	addiw	a5,s2,-99
 588:	0ff7f793          	zext.b	a5,a5
 58c:	12fb6863          	bltu	s6,a5,6bc <vprintf+0x194>
 590:	f9d9079b          	addiw	a5,s2,-99
 594:	0ff7f713          	zext.b	a4,a5
 598:	12eb6263          	bltu	s6,a4,6bc <vprintf+0x194>
 59c:	00271793          	slli	a5,a4,0x2
 5a0:	00000717          	auipc	a4,0x0
 5a4:	39070713          	addi	a4,a4,912 # 930 <malloc+0x150>
 5a8:	97ba                	add	a5,a5,a4
 5aa:	439c                	lw	a5,0(a5)
 5ac:	97ba                	add	a5,a5,a4
 5ae:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 5b0:	008b8913          	addi	s2,s7,8
 5b4:	4685                	li	a3,1
 5b6:	4629                	li	a2,10
 5b8:	000ba583          	lw	a1,0(s7)
 5bc:	8556                	mv	a0,s5
 5be:	00000097          	auipc	ra,0x0
 5c2:	ec2080e7          	jalr	-318(ra) # 480 <printint>
 5c6:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 5c8:	4981                	li	s3,0
 5ca:	b745                	j	56a <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
 5cc:	008b8913          	addi	s2,s7,8
 5d0:	4681                	li	a3,0
 5d2:	4629                	li	a2,10
 5d4:	000ba583          	lw	a1,0(s7)
 5d8:	8556                	mv	a0,s5
 5da:	00000097          	auipc	ra,0x0
 5de:	ea6080e7          	jalr	-346(ra) # 480 <printint>
 5e2:	8bca                	mv	s7,s2
      state = 0;
 5e4:	4981                	li	s3,0
 5e6:	b751                	j	56a <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
 5e8:	008b8913          	addi	s2,s7,8
 5ec:	4681                	li	a3,0
 5ee:	4641                	li	a2,16
 5f0:	000ba583          	lw	a1,0(s7)
 5f4:	8556                	mv	a0,s5
 5f6:	00000097          	auipc	ra,0x0
 5fa:	e8a080e7          	jalr	-374(ra) # 480 <printint>
 5fe:	8bca                	mv	s7,s2
      state = 0;
 600:	4981                	li	s3,0
 602:	b7a5                	j	56a <vprintf+0x42>
 604:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
 606:	008b8793          	addi	a5,s7,8
 60a:	8c3e                	mv	s8,a5
 60c:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 610:	03000593          	li	a1,48
 614:	8556                	mv	a0,s5
 616:	00000097          	auipc	ra,0x0
 61a:	e48080e7          	jalr	-440(ra) # 45e <putc>
  putc(fd, 'x');
 61e:	07800593          	li	a1,120
 622:	8556                	mv	a0,s5
 624:	00000097          	auipc	ra,0x0
 628:	e3a080e7          	jalr	-454(ra) # 45e <putc>
 62c:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 62e:	00000b97          	auipc	s7,0x0
 632:	35ab8b93          	addi	s7,s7,858 # 988 <digits>
 636:	03c9d793          	srli	a5,s3,0x3c
 63a:	97de                	add	a5,a5,s7
 63c:	0007c583          	lbu	a1,0(a5)
 640:	8556                	mv	a0,s5
 642:	00000097          	auipc	ra,0x0
 646:	e1c080e7          	jalr	-484(ra) # 45e <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 64a:	0992                	slli	s3,s3,0x4
 64c:	397d                	addiw	s2,s2,-1
 64e:	fe0914e3          	bnez	s2,636 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
 652:	8be2                	mv	s7,s8
      state = 0;
 654:	4981                	li	s3,0
 656:	6c02                	ld	s8,0(sp)
 658:	bf09                	j	56a <vprintf+0x42>
        s = va_arg(ap, char*);
 65a:	008b8993          	addi	s3,s7,8
 65e:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 662:	02090163          	beqz	s2,684 <vprintf+0x15c>
        while(*s != 0){
 666:	00094583          	lbu	a1,0(s2)
 66a:	c9a5                	beqz	a1,6da <vprintf+0x1b2>
          putc(fd, *s);
 66c:	8556                	mv	a0,s5
 66e:	00000097          	auipc	ra,0x0
 672:	df0080e7          	jalr	-528(ra) # 45e <putc>
          s++;
 676:	0905                	addi	s2,s2,1
        while(*s != 0){
 678:	00094583          	lbu	a1,0(s2)
 67c:	f9e5                	bnez	a1,66c <vprintf+0x144>
        s = va_arg(ap, char*);
 67e:	8bce                	mv	s7,s3
      state = 0;
 680:	4981                	li	s3,0
 682:	b5e5                	j	56a <vprintf+0x42>
          s = "(null)";
 684:	00000917          	auipc	s2,0x0
 688:	2a490913          	addi	s2,s2,676 # 928 <malloc+0x148>
        while(*s != 0){
 68c:	02800593          	li	a1,40
 690:	bff1                	j	66c <vprintf+0x144>
        putc(fd, va_arg(ap, uint));
 692:	008b8913          	addi	s2,s7,8
 696:	000bc583          	lbu	a1,0(s7)
 69a:	8556                	mv	a0,s5
 69c:	00000097          	auipc	ra,0x0
 6a0:	dc2080e7          	jalr	-574(ra) # 45e <putc>
 6a4:	8bca                	mv	s7,s2
      state = 0;
 6a6:	4981                	li	s3,0
 6a8:	b5c9                	j	56a <vprintf+0x42>
        putc(fd, c);
 6aa:	02500593          	li	a1,37
 6ae:	8556                	mv	a0,s5
 6b0:	00000097          	auipc	ra,0x0
 6b4:	dae080e7          	jalr	-594(ra) # 45e <putc>
      state = 0;
 6b8:	4981                	li	s3,0
 6ba:	bd45                	j	56a <vprintf+0x42>
        putc(fd, '%');
 6bc:	02500593          	li	a1,37
 6c0:	8556                	mv	a0,s5
 6c2:	00000097          	auipc	ra,0x0
 6c6:	d9c080e7          	jalr	-612(ra) # 45e <putc>
        putc(fd, c);
 6ca:	85ca                	mv	a1,s2
 6cc:	8556                	mv	a0,s5
 6ce:	00000097          	auipc	ra,0x0
 6d2:	d90080e7          	jalr	-624(ra) # 45e <putc>
      state = 0;
 6d6:	4981                	li	s3,0
 6d8:	bd49                	j	56a <vprintf+0x42>
        s = va_arg(ap, char*);
 6da:	8bce                	mv	s7,s3
      state = 0;
 6dc:	4981                	li	s3,0
 6de:	b571                	j	56a <vprintf+0x42>
 6e0:	74e2                	ld	s1,56(sp)
 6e2:	79a2                	ld	s3,40(sp)
 6e4:	7a02                	ld	s4,32(sp)
 6e6:	6ae2                	ld	s5,24(sp)
 6e8:	6b42                	ld	s6,16(sp)
 6ea:	6ba2                	ld	s7,8(sp)
    }
  }
}
 6ec:	60a6                	ld	ra,72(sp)
 6ee:	6406                	ld	s0,64(sp)
 6f0:	7942                	ld	s2,48(sp)
 6f2:	6161                	addi	sp,sp,80
 6f4:	8082                	ret

00000000000006f6 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 6f6:	715d                	addi	sp,sp,-80
 6f8:	ec06                	sd	ra,24(sp)
 6fa:	e822                	sd	s0,16(sp)
 6fc:	1000                	addi	s0,sp,32
 6fe:	e010                	sd	a2,0(s0)
 700:	e414                	sd	a3,8(s0)
 702:	e818                	sd	a4,16(s0)
 704:	ec1c                	sd	a5,24(s0)
 706:	03043023          	sd	a6,32(s0)
 70a:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 70e:	8622                	mv	a2,s0
 710:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 714:	00000097          	auipc	ra,0x0
 718:	e14080e7          	jalr	-492(ra) # 528 <vprintf>
}
 71c:	60e2                	ld	ra,24(sp)
 71e:	6442                	ld	s0,16(sp)
 720:	6161                	addi	sp,sp,80
 722:	8082                	ret

0000000000000724 <printf>:

void
printf(const char *fmt, ...)
{
 724:	711d                	addi	sp,sp,-96
 726:	ec06                	sd	ra,24(sp)
 728:	e822                	sd	s0,16(sp)
 72a:	1000                	addi	s0,sp,32
 72c:	e40c                	sd	a1,8(s0)
 72e:	e810                	sd	a2,16(s0)
 730:	ec14                	sd	a3,24(s0)
 732:	f018                	sd	a4,32(s0)
 734:	f41c                	sd	a5,40(s0)
 736:	03043823          	sd	a6,48(s0)
 73a:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 73e:	00840613          	addi	a2,s0,8
 742:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 746:	85aa                	mv	a1,a0
 748:	4505                	li	a0,1
 74a:	00000097          	auipc	ra,0x0
 74e:	dde080e7          	jalr	-546(ra) # 528 <vprintf>
}
 752:	60e2                	ld	ra,24(sp)
 754:	6442                	ld	s0,16(sp)
 756:	6125                	addi	sp,sp,96
 758:	8082                	ret

000000000000075a <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 75a:	1141                	addi	sp,sp,-16
 75c:	e406                	sd	ra,8(sp)
 75e:	e022                	sd	s0,0(sp)
 760:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 762:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 766:	00000797          	auipc	a5,0x0
 76a:	23a7b783          	ld	a5,570(a5) # 9a0 <freep>
 76e:	a039                	j	77c <free+0x22>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 770:	6398                	ld	a4,0(a5)
 772:	00e7e463          	bltu	a5,a4,77a <free+0x20>
 776:	00e6ea63          	bltu	a3,a4,78a <free+0x30>
{
 77a:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 77c:	fed7fae3          	bgeu	a5,a3,770 <free+0x16>
 780:	6398                	ld	a4,0(a5)
 782:	00e6e463          	bltu	a3,a4,78a <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 786:	fee7eae3          	bltu	a5,a4,77a <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 78a:	ff852583          	lw	a1,-8(a0)
 78e:	6390                	ld	a2,0(a5)
 790:	02059813          	slli	a6,a1,0x20
 794:	01c85713          	srli	a4,a6,0x1c
 798:	9736                	add	a4,a4,a3
 79a:	02e60563          	beq	a2,a4,7c4 <free+0x6a>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 79e:	fec53823          	sd	a2,-16(a0)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 7a2:	4790                	lw	a2,8(a5)
 7a4:	02061593          	slli	a1,a2,0x20
 7a8:	01c5d713          	srli	a4,a1,0x1c
 7ac:	973e                	add	a4,a4,a5
 7ae:	02e68263          	beq	a3,a4,7d2 <free+0x78>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 7b2:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 7b4:	00000717          	auipc	a4,0x0
 7b8:	1ef73623          	sd	a5,492(a4) # 9a0 <freep>
}
 7bc:	60a2                	ld	ra,8(sp)
 7be:	6402                	ld	s0,0(sp)
 7c0:	0141                	addi	sp,sp,16
 7c2:	8082                	ret
    bp->s.size += p->s.ptr->s.size;
 7c4:	4618                	lw	a4,8(a2)
 7c6:	9f2d                	addw	a4,a4,a1
 7c8:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 7cc:	6398                	ld	a4,0(a5)
 7ce:	6310                	ld	a2,0(a4)
 7d0:	b7f9                	j	79e <free+0x44>
    p->s.size += bp->s.size;
 7d2:	ff852703          	lw	a4,-8(a0)
 7d6:	9f31                	addw	a4,a4,a2
 7d8:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 7da:	ff053683          	ld	a3,-16(a0)
 7de:	bfd1                	j	7b2 <free+0x58>

00000000000007e0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7e0:	7139                	addi	sp,sp,-64
 7e2:	fc06                	sd	ra,56(sp)
 7e4:	f822                	sd	s0,48(sp)
 7e6:	f04a                	sd	s2,32(sp)
 7e8:	ec4e                	sd	s3,24(sp)
 7ea:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7ec:	02051993          	slli	s3,a0,0x20
 7f0:	0209d993          	srli	s3,s3,0x20
 7f4:	09bd                	addi	s3,s3,15
 7f6:	0049d993          	srli	s3,s3,0x4
 7fa:	2985                	addiw	s3,s3,1
 7fc:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 7fe:	00000517          	auipc	a0,0x0
 802:	1a253503          	ld	a0,418(a0) # 9a0 <freep>
 806:	c905                	beqz	a0,836 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 808:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 80a:	4798                	lw	a4,8(a5)
 80c:	09377a63          	bgeu	a4,s3,8a0 <malloc+0xc0>
 810:	f426                	sd	s1,40(sp)
 812:	e852                	sd	s4,16(sp)
 814:	e456                	sd	s5,8(sp)
 816:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 818:	8a4e                	mv	s4,s3
 81a:	6705                	lui	a4,0x1
 81c:	00e9f363          	bgeu	s3,a4,822 <malloc+0x42>
 820:	6a05                	lui	s4,0x1
 822:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 826:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 82a:	00000497          	auipc	s1,0x0
 82e:	17648493          	addi	s1,s1,374 # 9a0 <freep>
  if(p == (char*)-1)
 832:	5afd                	li	s5,-1
 834:	a089                	j	876 <malloc+0x96>
 836:	f426                	sd	s1,40(sp)
 838:	e852                	sd	s4,16(sp)
 83a:	e456                	sd	s5,8(sp)
 83c:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 83e:	00000797          	auipc	a5,0x0
 842:	36a78793          	addi	a5,a5,874 # ba8 <base>
 846:	00000717          	auipc	a4,0x0
 84a:	14f73d23          	sd	a5,346(a4) # 9a0 <freep>
 84e:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 850:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 854:	b7d1                	j	818 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 856:	6398                	ld	a4,0(a5)
 858:	e118                	sd	a4,0(a0)
 85a:	a8b9                	j	8b8 <malloc+0xd8>
  hp->s.size = nu;
 85c:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 860:	0541                	addi	a0,a0,16
 862:	00000097          	auipc	ra,0x0
 866:	ef8080e7          	jalr	-264(ra) # 75a <free>
  return freep;
 86a:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 86c:	c135                	beqz	a0,8d0 <malloc+0xf0>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 86e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 870:	4798                	lw	a4,8(a5)
 872:	03277363          	bgeu	a4,s2,898 <malloc+0xb8>
    if(p == freep)
 876:	6098                	ld	a4,0(s1)
 878:	853e                	mv	a0,a5
 87a:	fef71ae3          	bne	a4,a5,86e <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 87e:	8552                	mv	a0,s4
 880:	00000097          	auipc	ra,0x0
 884:	bbe080e7          	jalr	-1090(ra) # 43e <sbrk>
  if(p == (char*)-1)
 888:	fd551ae3          	bne	a0,s5,85c <malloc+0x7c>
        return 0;
 88c:	4501                	li	a0,0
 88e:	74a2                	ld	s1,40(sp)
 890:	6a42                	ld	s4,16(sp)
 892:	6aa2                	ld	s5,8(sp)
 894:	6b02                	ld	s6,0(sp)
 896:	a03d                	j	8c4 <malloc+0xe4>
 898:	74a2                	ld	s1,40(sp)
 89a:	6a42                	ld	s4,16(sp)
 89c:	6aa2                	ld	s5,8(sp)
 89e:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 8a0:	fae90be3          	beq	s2,a4,856 <malloc+0x76>
        p->s.size -= nunits;
 8a4:	4137073b          	subw	a4,a4,s3
 8a8:	c798                	sw	a4,8(a5)
        p += p->s.size;
 8aa:	02071693          	slli	a3,a4,0x20
 8ae:	01c6d713          	srli	a4,a3,0x1c
 8b2:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 8b4:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 8b8:	00000717          	auipc	a4,0x0
 8bc:	0ea73423          	sd	a0,232(a4) # 9a0 <freep>
      return (void*)(p + 1);
 8c0:	01078513          	addi	a0,a5,16
  }
}
 8c4:	70e2                	ld	ra,56(sp)
 8c6:	7442                	ld	s0,48(sp)
 8c8:	7902                	ld	s2,32(sp)
 8ca:	69e2                	ld	s3,24(sp)
 8cc:	6121                	addi	sp,sp,64
 8ce:	8082                	ret
 8d0:	74a2                	ld	s1,40(sp)
 8d2:	6a42                	ld	s4,16(sp)
 8d4:	6aa2                	ld	s5,8(sp)
 8d6:	6b02                	ld	s6,0(sp)
 8d8:	b7f5                	j	8c4 <malloc+0xe4>
