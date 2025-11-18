
user/_bigfile：     文件格式 elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/fcntl.h"
#include "kernel/fs.h"

int
main()
{
   0:	bb010113          	addi	sp,sp,-1104
   4:	44113423          	sd	ra,1096(sp)
   8:	44813023          	sd	s0,1088(sp)
   c:	45010413          	addi	s0,sp,1104
  char buf[BSIZE];
  int fd, i, blocks;

  fd = open("big.file", O_CREATE | O_WRONLY);
  10:	20100593          	li	a1,513
  14:	00001517          	auipc	a0,0x1
  18:	96c50513          	addi	a0,a0,-1684 # 980 <malloc+0xfe>
  1c:	00000097          	auipc	ra,0x0
  20:	47c080e7          	jalr	1148(ra) # 498 <open>
  if(fd < 0){
  24:	06054e63          	bltz	a0,a0 <main+0xa0>
  28:	42913c23          	sd	s1,1080(sp)
  2c:	43213823          	sd	s2,1072(sp)
  30:	43313423          	sd	s3,1064(sp)
  34:	43413023          	sd	s4,1056(sp)
  38:	41513c23          	sd	s5,1048(sp)
  3c:	41613823          	sd	s6,1040(sp)
  40:	41713423          	sd	s7,1032(sp)
  44:	892a                	mv	s2,a0
  46:	4481                	li	s1,0
  }

  blocks = 0;
  while(1){
    *(int*)buf = blocks;
    int cc = write(fd, buf, sizeof(buf));
  48:	bb040a93          	addi	s5,s0,-1104
  4c:	40000a13          	li	s4,1024
    if(cc <= 0)
      break;
    blocks++;
    if (blocks % 100 == 0)
  50:	51eb89b7          	lui	s3,0x51eb8
  54:	51f98993          	addi	s3,s3,1311 # 51eb851f <__global_pointer$+0x51eb720e>
  58:	06400b13          	li	s6,100
      printf(".");
  5c:	00001b97          	auipc	s7,0x1
  60:	964b8b93          	addi	s7,s7,-1692 # 9c0 <malloc+0x13e>
    *(int*)buf = blocks;
  64:	ba942823          	sw	s1,-1104(s0)
    int cc = write(fd, buf, sizeof(buf));
  68:	8652                	mv	a2,s4
  6a:	85d6                	mv	a1,s5
  6c:	854a                	mv	a0,s2
  6e:	00000097          	auipc	ra,0x0
  72:	40a080e7          	jalr	1034(ra) # 478 <write>
    if(cc <= 0)
  76:	06a05063          	blez	a0,d6 <main+0xd6>
    blocks++;
  7a:	0014871b          	addiw	a4,s1,1
  7e:	84ba                	mv	s1,a4
    if (blocks % 100 == 0)
  80:	033707b3          	mul	a5,a4,s3
  84:	9795                	srai	a5,a5,0x25
  86:	41f7569b          	sraiw	a3,a4,0x1f
  8a:	9f95                	subw	a5,a5,a3
  8c:	02fb07bb          	mulw	a5,s6,a5
  90:	9f1d                	subw	a4,a4,a5
  92:	fb69                	bnez	a4,64 <main+0x64>
      printf(".");
  94:	855e                	mv	a0,s7
  96:	00000097          	auipc	ra,0x0
  9a:	730080e7          	jalr	1840(ra) # 7c6 <printf>
  9e:	b7d9                	j	64 <main+0x64>
  a0:	42913c23          	sd	s1,1080(sp)
  a4:	43213823          	sd	s2,1072(sp)
  a8:	43313423          	sd	s3,1064(sp)
  ac:	43413023          	sd	s4,1056(sp)
  b0:	41513c23          	sd	s5,1048(sp)
  b4:	41613823          	sd	s6,1040(sp)
  b8:	41713423          	sd	s7,1032(sp)
    printf("bigfile: cannot open big.file for writing\n");
  bc:	00001517          	auipc	a0,0x1
  c0:	8d450513          	addi	a0,a0,-1836 # 990 <malloc+0x10e>
  c4:	00000097          	auipc	ra,0x0
  c8:	702080e7          	jalr	1794(ra) # 7c6 <printf>
    exit(-1);
  cc:	557d                	li	a0,-1
  ce:	00000097          	auipc	ra,0x0
  d2:	38a080e7          	jalr	906(ra) # 458 <exit>
  }

  printf("\nwrote %d blocks\n", blocks);
  d6:	85a6                	mv	a1,s1
  d8:	00001517          	auipc	a0,0x1
  dc:	8f050513          	addi	a0,a0,-1808 # 9c8 <malloc+0x146>
  e0:	00000097          	auipc	ra,0x0
  e4:	6e6080e7          	jalr	1766(ra) # 7c6 <printf>
  if(blocks != 65803) {
  e8:	67c1                	lui	a5,0x10
  ea:	10b78793          	addi	a5,a5,267 # 1010b <__global_pointer$+0xedfa>
  ee:	00f48f63          	beq	s1,a5,10c <main+0x10c>
    printf("bigfile: file is too small\n");
  f2:	00001517          	auipc	a0,0x1
  f6:	8ee50513          	addi	a0,a0,-1810 # 9e0 <malloc+0x15e>
  fa:	00000097          	auipc	ra,0x0
  fe:	6cc080e7          	jalr	1740(ra) # 7c6 <printf>
    exit(-1);
 102:	557d                	li	a0,-1
 104:	00000097          	auipc	ra,0x0
 108:	354080e7          	jalr	852(ra) # 458 <exit>
  }
  
  close(fd);
 10c:	854a                	mv	a0,s2
 10e:	00000097          	auipc	ra,0x0
 112:	372080e7          	jalr	882(ra) # 480 <close>
  fd = open("big.file", O_RDONLY);
 116:	4581                	li	a1,0
 118:	00001517          	auipc	a0,0x1
 11c:	86850513          	addi	a0,a0,-1944 # 980 <malloc+0xfe>
 120:	00000097          	auipc	ra,0x0
 124:	378080e7          	jalr	888(ra) # 498 <open>
 128:	892a                	mv	s2,a0
  if(fd < 0){
    printf("bigfile: cannot re-open big.file for reading\n");
    exit(-1);
  }
  for(i = 0; i < blocks; i++){
 12a:	4481                	li	s1,0
  if(fd < 0){
 12c:	04054663          	bltz	a0,178 <main+0x178>
    int cc = read(fd, buf, sizeof(buf));
 130:	bb040a93          	addi	s5,s0,-1104
 134:	40000a13          	li	s4,1024
  for(i = 0; i < blocks; i++){
 138:	69c1                	lui	s3,0x10
 13a:	10b98993          	addi	s3,s3,267 # 1010b <__global_pointer$+0xedfa>
    int cc = read(fd, buf, sizeof(buf));
 13e:	8652                	mv	a2,s4
 140:	85d6                	mv	a1,s5
 142:	854a                	mv	a0,s2
 144:	00000097          	auipc	ra,0x0
 148:	32c080e7          	jalr	812(ra) # 470 <read>
    if(cc <= 0){
 14c:	04a05363          	blez	a0,192 <main+0x192>
      printf("bigfile: read error at block %d\n", i);
      exit(-1);
    }
    if(*(int*)buf != i){
 150:	bb042583          	lw	a1,-1104(s0)
 154:	04959d63          	bne	a1,s1,1ae <main+0x1ae>
  for(i = 0; i < blocks; i++){
 158:	2485                	addiw	s1,s1,1
 15a:	ff3492e3          	bne	s1,s3,13e <main+0x13e>
             *(int*)buf, i);
      exit(-1);
    }
  }

  printf("bigfile done; ok\n"); 
 15e:	00001517          	auipc	a0,0x1
 162:	92a50513          	addi	a0,a0,-1750 # a88 <malloc+0x206>
 166:	00000097          	auipc	ra,0x0
 16a:	660080e7          	jalr	1632(ra) # 7c6 <printf>

  exit(0);
 16e:	4501                	li	a0,0
 170:	00000097          	auipc	ra,0x0
 174:	2e8080e7          	jalr	744(ra) # 458 <exit>
    printf("bigfile: cannot re-open big.file for reading\n");
 178:	00001517          	auipc	a0,0x1
 17c:	88850513          	addi	a0,a0,-1912 # a00 <malloc+0x17e>
 180:	00000097          	auipc	ra,0x0
 184:	646080e7          	jalr	1606(ra) # 7c6 <printf>
    exit(-1);
 188:	557d                	li	a0,-1
 18a:	00000097          	auipc	ra,0x0
 18e:	2ce080e7          	jalr	718(ra) # 458 <exit>
      printf("bigfile: read error at block %d\n", i);
 192:	85a6                	mv	a1,s1
 194:	00001517          	auipc	a0,0x1
 198:	89c50513          	addi	a0,a0,-1892 # a30 <malloc+0x1ae>
 19c:	00000097          	auipc	ra,0x0
 1a0:	62a080e7          	jalr	1578(ra) # 7c6 <printf>
      exit(-1);
 1a4:	557d                	li	a0,-1
 1a6:	00000097          	auipc	ra,0x0
 1aa:	2b2080e7          	jalr	690(ra) # 458 <exit>
      printf("bigfile: read the wrong data (%d) for block %d\n",
 1ae:	8626                	mv	a2,s1
 1b0:	00001517          	auipc	a0,0x1
 1b4:	8a850513          	addi	a0,a0,-1880 # a58 <malloc+0x1d6>
 1b8:	00000097          	auipc	ra,0x0
 1bc:	60e080e7          	jalr	1550(ra) # 7c6 <printf>
      exit(-1);
 1c0:	557d                	li	a0,-1
 1c2:	00000097          	auipc	ra,0x0
 1c6:	296080e7          	jalr	662(ra) # 458 <exit>

00000000000001ca <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 1ca:	1141                	addi	sp,sp,-16
 1cc:	e406                	sd	ra,8(sp)
 1ce:	e022                	sd	s0,0(sp)
 1d0:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1d2:	87aa                	mv	a5,a0
 1d4:	0585                	addi	a1,a1,1
 1d6:	0785                	addi	a5,a5,1
 1d8:	fff5c703          	lbu	a4,-1(a1)
 1dc:	fee78fa3          	sb	a4,-1(a5)
 1e0:	fb75                	bnez	a4,1d4 <strcpy+0xa>
    ;
  return os;
}
 1e2:	60a2                	ld	ra,8(sp)
 1e4:	6402                	ld	s0,0(sp)
 1e6:	0141                	addi	sp,sp,16
 1e8:	8082                	ret

00000000000001ea <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1ea:	1141                	addi	sp,sp,-16
 1ec:	e406                	sd	ra,8(sp)
 1ee:	e022                	sd	s0,0(sp)
 1f0:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 1f2:	00054783          	lbu	a5,0(a0)
 1f6:	cb91                	beqz	a5,20a <strcmp+0x20>
 1f8:	0005c703          	lbu	a4,0(a1)
 1fc:	00f71763          	bne	a4,a5,20a <strcmp+0x20>
    p++, q++;
 200:	0505                	addi	a0,a0,1
 202:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 204:	00054783          	lbu	a5,0(a0)
 208:	fbe5                	bnez	a5,1f8 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 20a:	0005c503          	lbu	a0,0(a1)
}
 20e:	40a7853b          	subw	a0,a5,a0
 212:	60a2                	ld	ra,8(sp)
 214:	6402                	ld	s0,0(sp)
 216:	0141                	addi	sp,sp,16
 218:	8082                	ret

000000000000021a <strlen>:

uint
strlen(const char *s)
{
 21a:	1141                	addi	sp,sp,-16
 21c:	e406                	sd	ra,8(sp)
 21e:	e022                	sd	s0,0(sp)
 220:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 222:	00054783          	lbu	a5,0(a0)
 226:	cf91                	beqz	a5,242 <strlen+0x28>
 228:	00150793          	addi	a5,a0,1
 22c:	86be                	mv	a3,a5
 22e:	0785                	addi	a5,a5,1
 230:	fff7c703          	lbu	a4,-1(a5)
 234:	ff65                	bnez	a4,22c <strlen+0x12>
 236:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
 23a:	60a2                	ld	ra,8(sp)
 23c:	6402                	ld	s0,0(sp)
 23e:	0141                	addi	sp,sp,16
 240:	8082                	ret
  for(n = 0; s[n]; n++)
 242:	4501                	li	a0,0
 244:	bfdd                	j	23a <strlen+0x20>

0000000000000246 <memset>:

void*
memset(void *dst, int c, uint n)
{
 246:	1141                	addi	sp,sp,-16
 248:	e406                	sd	ra,8(sp)
 24a:	e022                	sd	s0,0(sp)
 24c:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 24e:	ca19                	beqz	a2,264 <memset+0x1e>
 250:	87aa                	mv	a5,a0
 252:	1602                	slli	a2,a2,0x20
 254:	9201                	srli	a2,a2,0x20
 256:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 25a:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 25e:	0785                	addi	a5,a5,1
 260:	fee79de3          	bne	a5,a4,25a <memset+0x14>
  }
  return dst;
}
 264:	60a2                	ld	ra,8(sp)
 266:	6402                	ld	s0,0(sp)
 268:	0141                	addi	sp,sp,16
 26a:	8082                	ret

000000000000026c <strchr>:

char*
strchr(const char *s, char c)
{
 26c:	1141                	addi	sp,sp,-16
 26e:	e406                	sd	ra,8(sp)
 270:	e022                	sd	s0,0(sp)
 272:	0800                	addi	s0,sp,16
  for(; *s; s++)
 274:	00054783          	lbu	a5,0(a0)
 278:	cf81                	beqz	a5,290 <strchr+0x24>
    if(*s == c)
 27a:	00f58763          	beq	a1,a5,288 <strchr+0x1c>
  for(; *s; s++)
 27e:	0505                	addi	a0,a0,1
 280:	00054783          	lbu	a5,0(a0)
 284:	fbfd                	bnez	a5,27a <strchr+0xe>
      return (char*)s;
  return 0;
 286:	4501                	li	a0,0
}
 288:	60a2                	ld	ra,8(sp)
 28a:	6402                	ld	s0,0(sp)
 28c:	0141                	addi	sp,sp,16
 28e:	8082                	ret
  return 0;
 290:	4501                	li	a0,0
 292:	bfdd                	j	288 <strchr+0x1c>

0000000000000294 <gets>:

char*
gets(char *buf, int max)
{
 294:	711d                	addi	sp,sp,-96
 296:	ec86                	sd	ra,88(sp)
 298:	e8a2                	sd	s0,80(sp)
 29a:	e4a6                	sd	s1,72(sp)
 29c:	e0ca                	sd	s2,64(sp)
 29e:	fc4e                	sd	s3,56(sp)
 2a0:	f852                	sd	s4,48(sp)
 2a2:	f456                	sd	s5,40(sp)
 2a4:	f05a                	sd	s6,32(sp)
 2a6:	ec5e                	sd	s7,24(sp)
 2a8:	e862                	sd	s8,16(sp)
 2aa:	1080                	addi	s0,sp,96
 2ac:	8baa                	mv	s7,a0
 2ae:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2b0:	892a                	mv	s2,a0
 2b2:	4481                	li	s1,0
    cc = read(0, &c, 1);
 2b4:	faf40b13          	addi	s6,s0,-81
 2b8:	4a85                	li	s5,1
  for(i=0; i+1 < max; ){
 2ba:	8c26                	mv	s8,s1
 2bc:	0014899b          	addiw	s3,s1,1
 2c0:	84ce                	mv	s1,s3
 2c2:	0349d663          	bge	s3,s4,2ee <gets+0x5a>
    cc = read(0, &c, 1);
 2c6:	8656                	mv	a2,s5
 2c8:	85da                	mv	a1,s6
 2ca:	4501                	li	a0,0
 2cc:	00000097          	auipc	ra,0x0
 2d0:	1a4080e7          	jalr	420(ra) # 470 <read>
    if(cc < 1)
 2d4:	00a05d63          	blez	a0,2ee <gets+0x5a>
      break;
    buf[i++] = c;
 2d8:	faf44783          	lbu	a5,-81(s0)
 2dc:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 2e0:	0905                	addi	s2,s2,1
 2e2:	ff678713          	addi	a4,a5,-10
 2e6:	c319                	beqz	a4,2ec <gets+0x58>
 2e8:	17cd                	addi	a5,a5,-13
 2ea:	fbe1                	bnez	a5,2ba <gets+0x26>
    buf[i++] = c;
 2ec:	8c4e                	mv	s8,s3
      break;
  }
  buf[i] = '\0';
 2ee:	9c5e                	add	s8,s8,s7
 2f0:	000c0023          	sb	zero,0(s8)
  return buf;
}
 2f4:	855e                	mv	a0,s7
 2f6:	60e6                	ld	ra,88(sp)
 2f8:	6446                	ld	s0,80(sp)
 2fa:	64a6                	ld	s1,72(sp)
 2fc:	6906                	ld	s2,64(sp)
 2fe:	79e2                	ld	s3,56(sp)
 300:	7a42                	ld	s4,48(sp)
 302:	7aa2                	ld	s5,40(sp)
 304:	7b02                	ld	s6,32(sp)
 306:	6be2                	ld	s7,24(sp)
 308:	6c42                	ld	s8,16(sp)
 30a:	6125                	addi	sp,sp,96
 30c:	8082                	ret

000000000000030e <stat>:

int
stat(const char *n, struct stat *st)
{
 30e:	1101                	addi	sp,sp,-32
 310:	ec06                	sd	ra,24(sp)
 312:	e822                	sd	s0,16(sp)
 314:	e04a                	sd	s2,0(sp)
 316:	1000                	addi	s0,sp,32
 318:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 31a:	4581                	li	a1,0
 31c:	00000097          	auipc	ra,0x0
 320:	17c080e7          	jalr	380(ra) # 498 <open>
  if(fd < 0)
 324:	02054663          	bltz	a0,350 <stat+0x42>
 328:	e426                	sd	s1,8(sp)
 32a:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 32c:	85ca                	mv	a1,s2
 32e:	00000097          	auipc	ra,0x0
 332:	182080e7          	jalr	386(ra) # 4b0 <fstat>
 336:	892a                	mv	s2,a0
  close(fd);
 338:	8526                	mv	a0,s1
 33a:	00000097          	auipc	ra,0x0
 33e:	146080e7          	jalr	326(ra) # 480 <close>
  return r;
 342:	64a2                	ld	s1,8(sp)
}
 344:	854a                	mv	a0,s2
 346:	60e2                	ld	ra,24(sp)
 348:	6442                	ld	s0,16(sp)
 34a:	6902                	ld	s2,0(sp)
 34c:	6105                	addi	sp,sp,32
 34e:	8082                	ret
    return -1;
 350:	57fd                	li	a5,-1
 352:	893e                	mv	s2,a5
 354:	bfc5                	j	344 <stat+0x36>

0000000000000356 <atoi>:

int
atoi(const char *s)
{
 356:	1141                	addi	sp,sp,-16
 358:	e406                	sd	ra,8(sp)
 35a:	e022                	sd	s0,0(sp)
 35c:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 35e:	00054683          	lbu	a3,0(a0)
 362:	fd06879b          	addiw	a5,a3,-48
 366:	0ff7f793          	zext.b	a5,a5
 36a:	4625                	li	a2,9
 36c:	02f66963          	bltu	a2,a5,39e <atoi+0x48>
 370:	872a                	mv	a4,a0
  n = 0;
 372:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 374:	0705                	addi	a4,a4,1
 376:	0025179b          	slliw	a5,a0,0x2
 37a:	9fa9                	addw	a5,a5,a0
 37c:	0017979b          	slliw	a5,a5,0x1
 380:	9fb5                	addw	a5,a5,a3
 382:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 386:	00074683          	lbu	a3,0(a4)
 38a:	fd06879b          	addiw	a5,a3,-48
 38e:	0ff7f793          	zext.b	a5,a5
 392:	fef671e3          	bgeu	a2,a5,374 <atoi+0x1e>
  return n;
}
 396:	60a2                	ld	ra,8(sp)
 398:	6402                	ld	s0,0(sp)
 39a:	0141                	addi	sp,sp,16
 39c:	8082                	ret
  n = 0;
 39e:	4501                	li	a0,0
 3a0:	bfdd                	j	396 <atoi+0x40>

00000000000003a2 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3a2:	1141                	addi	sp,sp,-16
 3a4:	e406                	sd	ra,8(sp)
 3a6:	e022                	sd	s0,0(sp)
 3a8:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 3aa:	02b57563          	bgeu	a0,a1,3d4 <memmove+0x32>
    while(n-- > 0)
 3ae:	00c05f63          	blez	a2,3cc <memmove+0x2a>
 3b2:	1602                	slli	a2,a2,0x20
 3b4:	9201                	srli	a2,a2,0x20
 3b6:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 3ba:	872a                	mv	a4,a0
      *dst++ = *src++;
 3bc:	0585                	addi	a1,a1,1
 3be:	0705                	addi	a4,a4,1
 3c0:	fff5c683          	lbu	a3,-1(a1)
 3c4:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 3c8:	fee79ae3          	bne	a5,a4,3bc <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 3cc:	60a2                	ld	ra,8(sp)
 3ce:	6402                	ld	s0,0(sp)
 3d0:	0141                	addi	sp,sp,16
 3d2:	8082                	ret
    while(n-- > 0)
 3d4:	fec05ce3          	blez	a2,3cc <memmove+0x2a>
    dst += n;
 3d8:	00c50733          	add	a4,a0,a2
    src += n;
 3dc:	95b2                	add	a1,a1,a2
 3de:	fff6079b          	addiw	a5,a2,-1
 3e2:	1782                	slli	a5,a5,0x20
 3e4:	9381                	srli	a5,a5,0x20
 3e6:	fff7c793          	not	a5,a5
 3ea:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 3ec:	15fd                	addi	a1,a1,-1
 3ee:	177d                	addi	a4,a4,-1
 3f0:	0005c683          	lbu	a3,0(a1)
 3f4:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 3f8:	fef71ae3          	bne	a4,a5,3ec <memmove+0x4a>
 3fc:	bfc1                	j	3cc <memmove+0x2a>

00000000000003fe <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 3fe:	1141                	addi	sp,sp,-16
 400:	e406                	sd	ra,8(sp)
 402:	e022                	sd	s0,0(sp)
 404:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 406:	c61d                	beqz	a2,434 <memcmp+0x36>
 408:	1602                	slli	a2,a2,0x20
 40a:	9201                	srli	a2,a2,0x20
 40c:	00c506b3          	add	a3,a0,a2
    if (*p1 != *p2) {
 410:	00054783          	lbu	a5,0(a0)
 414:	0005c703          	lbu	a4,0(a1)
 418:	00e79863          	bne	a5,a4,428 <memcmp+0x2a>
      return *p1 - *p2;
    }
    p1++;
 41c:	0505                	addi	a0,a0,1
    p2++;
 41e:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 420:	fed518e3          	bne	a0,a3,410 <memcmp+0x12>
  }
  return 0;
 424:	4501                	li	a0,0
 426:	a019                	j	42c <memcmp+0x2e>
      return *p1 - *p2;
 428:	40e7853b          	subw	a0,a5,a4
}
 42c:	60a2                	ld	ra,8(sp)
 42e:	6402                	ld	s0,0(sp)
 430:	0141                	addi	sp,sp,16
 432:	8082                	ret
  return 0;
 434:	4501                	li	a0,0
 436:	bfdd                	j	42c <memcmp+0x2e>

0000000000000438 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 438:	1141                	addi	sp,sp,-16
 43a:	e406                	sd	ra,8(sp)
 43c:	e022                	sd	s0,0(sp)
 43e:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 440:	00000097          	auipc	ra,0x0
 444:	f62080e7          	jalr	-158(ra) # 3a2 <memmove>
}
 448:	60a2                	ld	ra,8(sp)
 44a:	6402                	ld	s0,0(sp)
 44c:	0141                	addi	sp,sp,16
 44e:	8082                	ret

0000000000000450 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 450:	4885                	li	a7,1
 ecall
 452:	00000073          	ecall
 ret
 456:	8082                	ret

0000000000000458 <exit>:
.global exit
exit:
 li a7, SYS_exit
 458:	4889                	li	a7,2
 ecall
 45a:	00000073          	ecall
 ret
 45e:	8082                	ret

0000000000000460 <wait>:
.global wait
wait:
 li a7, SYS_wait
 460:	488d                	li	a7,3
 ecall
 462:	00000073          	ecall
 ret
 466:	8082                	ret

0000000000000468 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 468:	4891                	li	a7,4
 ecall
 46a:	00000073          	ecall
 ret
 46e:	8082                	ret

0000000000000470 <read>:
.global read
read:
 li a7, SYS_read
 470:	4895                	li	a7,5
 ecall
 472:	00000073          	ecall
 ret
 476:	8082                	ret

0000000000000478 <write>:
.global write
write:
 li a7, SYS_write
 478:	48c1                	li	a7,16
 ecall
 47a:	00000073          	ecall
 ret
 47e:	8082                	ret

0000000000000480 <close>:
.global close
close:
 li a7, SYS_close
 480:	48d5                	li	a7,21
 ecall
 482:	00000073          	ecall
 ret
 486:	8082                	ret

0000000000000488 <kill>:
.global kill
kill:
 li a7, SYS_kill
 488:	4899                	li	a7,6
 ecall
 48a:	00000073          	ecall
 ret
 48e:	8082                	ret

0000000000000490 <exec>:
.global exec
exec:
 li a7, SYS_exec
 490:	489d                	li	a7,7
 ecall
 492:	00000073          	ecall
 ret
 496:	8082                	ret

0000000000000498 <open>:
.global open
open:
 li a7, SYS_open
 498:	48bd                	li	a7,15
 ecall
 49a:	00000073          	ecall
 ret
 49e:	8082                	ret

00000000000004a0 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 4a0:	48c5                	li	a7,17
 ecall
 4a2:	00000073          	ecall
 ret
 4a6:	8082                	ret

00000000000004a8 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 4a8:	48c9                	li	a7,18
 ecall
 4aa:	00000073          	ecall
 ret
 4ae:	8082                	ret

00000000000004b0 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 4b0:	48a1                	li	a7,8
 ecall
 4b2:	00000073          	ecall
 ret
 4b6:	8082                	ret

00000000000004b8 <link>:
.global link
link:
 li a7, SYS_link
 4b8:	48cd                	li	a7,19
 ecall
 4ba:	00000073          	ecall
 ret
 4be:	8082                	ret

00000000000004c0 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 4c0:	48d1                	li	a7,20
 ecall
 4c2:	00000073          	ecall
 ret
 4c6:	8082                	ret

00000000000004c8 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 4c8:	48a5                	li	a7,9
 ecall
 4ca:	00000073          	ecall
 ret
 4ce:	8082                	ret

00000000000004d0 <dup>:
.global dup
dup:
 li a7, SYS_dup
 4d0:	48a9                	li	a7,10
 ecall
 4d2:	00000073          	ecall
 ret
 4d6:	8082                	ret

00000000000004d8 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 4d8:	48ad                	li	a7,11
 ecall
 4da:	00000073          	ecall
 ret
 4de:	8082                	ret

00000000000004e0 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 4e0:	48b1                	li	a7,12
 ecall
 4e2:	00000073          	ecall
 ret
 4e6:	8082                	ret

00000000000004e8 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 4e8:	48b5                	li	a7,13
 ecall
 4ea:	00000073          	ecall
 ret
 4ee:	8082                	ret

00000000000004f0 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 4f0:	48b9                	li	a7,14
 ecall
 4f2:	00000073          	ecall
 ret
 4f6:	8082                	ret

00000000000004f8 <ntas>:
.global ntas
ntas:
 li a7, SYS_ntas
 4f8:	48d9                	li	a7,22
 ecall
 4fa:	00000073          	ecall
 ret
 4fe:	8082                	ret

0000000000000500 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 500:	1101                	addi	sp,sp,-32
 502:	ec06                	sd	ra,24(sp)
 504:	e822                	sd	s0,16(sp)
 506:	1000                	addi	s0,sp,32
 508:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 50c:	4605                	li	a2,1
 50e:	fef40593          	addi	a1,s0,-17
 512:	00000097          	auipc	ra,0x0
 516:	f66080e7          	jalr	-154(ra) # 478 <write>
}
 51a:	60e2                	ld	ra,24(sp)
 51c:	6442                	ld	s0,16(sp)
 51e:	6105                	addi	sp,sp,32
 520:	8082                	ret

0000000000000522 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 522:	7139                	addi	sp,sp,-64
 524:	fc06                	sd	ra,56(sp)
 526:	f822                	sd	s0,48(sp)
 528:	f04a                	sd	s2,32(sp)
 52a:	ec4e                	sd	s3,24(sp)
 52c:	0080                	addi	s0,sp,64
 52e:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 530:	cad9                	beqz	a3,5c6 <printint+0xa4>
 532:	01f5d79b          	srliw	a5,a1,0x1f
 536:	cbc1                	beqz	a5,5c6 <printint+0xa4>
    neg = 1;
    x = -xx;
 538:	40b005bb          	negw	a1,a1
    neg = 1;
 53c:	4305                	li	t1,1
  } else {
    x = xx;
  }

  i = 0;
 53e:	fc040993          	addi	s3,s0,-64
  neg = 0;
 542:	86ce                	mv	a3,s3
  i = 0;
 544:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 546:	00000817          	auipc	a6,0x0
 54a:	5ba80813          	addi	a6,a6,1466 # b00 <digits>
 54e:	88ba                	mv	a7,a4
 550:	0017051b          	addiw	a0,a4,1
 554:	872a                	mv	a4,a0
 556:	02c5f7bb          	remuw	a5,a1,a2
 55a:	1782                	slli	a5,a5,0x20
 55c:	9381                	srli	a5,a5,0x20
 55e:	97c2                	add	a5,a5,a6
 560:	0007c783          	lbu	a5,0(a5)
 564:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 568:	87ae                	mv	a5,a1
 56a:	02c5d5bb          	divuw	a1,a1,a2
 56e:	0685                	addi	a3,a3,1
 570:	fcc7ffe3          	bgeu	a5,a2,54e <printint+0x2c>
  if(neg)
 574:	00030c63          	beqz	t1,58c <printint+0x6a>
    buf[i++] = '-';
 578:	fd050793          	addi	a5,a0,-48
 57c:	00878533          	add	a0,a5,s0
 580:	02d00793          	li	a5,45
 584:	fef50823          	sb	a5,-16(a0)
 588:	0028871b          	addiw	a4,a7,2

  while(--i >= 0)
 58c:	02e05763          	blez	a4,5ba <printint+0x98>
 590:	f426                	sd	s1,40(sp)
 592:	377d                	addiw	a4,a4,-1
 594:	00e984b3          	add	s1,s3,a4
 598:	19fd                	addi	s3,s3,-1
 59a:	99ba                	add	s3,s3,a4
 59c:	1702                	slli	a4,a4,0x20
 59e:	9301                	srli	a4,a4,0x20
 5a0:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 5a4:	0004c583          	lbu	a1,0(s1)
 5a8:	854a                	mv	a0,s2
 5aa:	00000097          	auipc	ra,0x0
 5ae:	f56080e7          	jalr	-170(ra) # 500 <putc>
  while(--i >= 0)
 5b2:	14fd                	addi	s1,s1,-1
 5b4:	ff3498e3          	bne	s1,s3,5a4 <printint+0x82>
 5b8:	74a2                	ld	s1,40(sp)
}
 5ba:	70e2                	ld	ra,56(sp)
 5bc:	7442                	ld	s0,48(sp)
 5be:	7902                	ld	s2,32(sp)
 5c0:	69e2                	ld	s3,24(sp)
 5c2:	6121                	addi	sp,sp,64
 5c4:	8082                	ret
  neg = 0;
 5c6:	4301                	li	t1,0
 5c8:	bf9d                	j	53e <printint+0x1c>

00000000000005ca <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 5ca:	715d                	addi	sp,sp,-80
 5cc:	e486                	sd	ra,72(sp)
 5ce:	e0a2                	sd	s0,64(sp)
 5d0:	f84a                	sd	s2,48(sp)
 5d2:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 5d4:	0005c903          	lbu	s2,0(a1)
 5d8:	1a090b63          	beqz	s2,78e <vprintf+0x1c4>
 5dc:	fc26                	sd	s1,56(sp)
 5de:	f44e                	sd	s3,40(sp)
 5e0:	f052                	sd	s4,32(sp)
 5e2:	ec56                	sd	s5,24(sp)
 5e4:	e85a                	sd	s6,16(sp)
 5e6:	e45e                	sd	s7,8(sp)
 5e8:	8aaa                	mv	s5,a0
 5ea:	8bb2                	mv	s7,a2
 5ec:	00158493          	addi	s1,a1,1
  state = 0;
 5f0:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 5f2:	02500a13          	li	s4,37
 5f6:	4b55                	li	s6,21
 5f8:	a839                	j	616 <vprintf+0x4c>
        putc(fd, c);
 5fa:	85ca                	mv	a1,s2
 5fc:	8556                	mv	a0,s5
 5fe:	00000097          	auipc	ra,0x0
 602:	f02080e7          	jalr	-254(ra) # 500 <putc>
 606:	a019                	j	60c <vprintf+0x42>
    } else if(state == '%'){
 608:	01498d63          	beq	s3,s4,622 <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
 60c:	0485                	addi	s1,s1,1
 60e:	fff4c903          	lbu	s2,-1(s1)
 612:	16090863          	beqz	s2,782 <vprintf+0x1b8>
    if(state == 0){
 616:	fe0999e3          	bnez	s3,608 <vprintf+0x3e>
      if(c == '%'){
 61a:	ff4910e3          	bne	s2,s4,5fa <vprintf+0x30>
        state = '%';
 61e:	89d2                	mv	s3,s4
 620:	b7f5                	j	60c <vprintf+0x42>
      if(c == 'd'){
 622:	13490563          	beq	s2,s4,74c <vprintf+0x182>
 626:	f9d9079b          	addiw	a5,s2,-99
 62a:	0ff7f793          	zext.b	a5,a5
 62e:	12fb6863          	bltu	s6,a5,75e <vprintf+0x194>
 632:	f9d9079b          	addiw	a5,s2,-99
 636:	0ff7f713          	zext.b	a4,a5
 63a:	12eb6263          	bltu	s6,a4,75e <vprintf+0x194>
 63e:	00271793          	slli	a5,a4,0x2
 642:	00000717          	auipc	a4,0x0
 646:	46670713          	addi	a4,a4,1126 # aa8 <malloc+0x226>
 64a:	97ba                	add	a5,a5,a4
 64c:	439c                	lw	a5,0(a5)
 64e:	97ba                	add	a5,a5,a4
 650:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 652:	008b8913          	addi	s2,s7,8
 656:	4685                	li	a3,1
 658:	4629                	li	a2,10
 65a:	000ba583          	lw	a1,0(s7)
 65e:	8556                	mv	a0,s5
 660:	00000097          	auipc	ra,0x0
 664:	ec2080e7          	jalr	-318(ra) # 522 <printint>
 668:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 66a:	4981                	li	s3,0
 66c:	b745                	j	60c <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
 66e:	008b8913          	addi	s2,s7,8
 672:	4681                	li	a3,0
 674:	4629                	li	a2,10
 676:	000ba583          	lw	a1,0(s7)
 67a:	8556                	mv	a0,s5
 67c:	00000097          	auipc	ra,0x0
 680:	ea6080e7          	jalr	-346(ra) # 522 <printint>
 684:	8bca                	mv	s7,s2
      state = 0;
 686:	4981                	li	s3,0
 688:	b751                	j	60c <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
 68a:	008b8913          	addi	s2,s7,8
 68e:	4681                	li	a3,0
 690:	4641                	li	a2,16
 692:	000ba583          	lw	a1,0(s7)
 696:	8556                	mv	a0,s5
 698:	00000097          	auipc	ra,0x0
 69c:	e8a080e7          	jalr	-374(ra) # 522 <printint>
 6a0:	8bca                	mv	s7,s2
      state = 0;
 6a2:	4981                	li	s3,0
 6a4:	b7a5                	j	60c <vprintf+0x42>
 6a6:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
 6a8:	008b8793          	addi	a5,s7,8
 6ac:	8c3e                	mv	s8,a5
 6ae:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 6b2:	03000593          	li	a1,48
 6b6:	8556                	mv	a0,s5
 6b8:	00000097          	auipc	ra,0x0
 6bc:	e48080e7          	jalr	-440(ra) # 500 <putc>
  putc(fd, 'x');
 6c0:	07800593          	li	a1,120
 6c4:	8556                	mv	a0,s5
 6c6:	00000097          	auipc	ra,0x0
 6ca:	e3a080e7          	jalr	-454(ra) # 500 <putc>
 6ce:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6d0:	00000b97          	auipc	s7,0x0
 6d4:	430b8b93          	addi	s7,s7,1072 # b00 <digits>
 6d8:	03c9d793          	srli	a5,s3,0x3c
 6dc:	97de                	add	a5,a5,s7
 6de:	0007c583          	lbu	a1,0(a5)
 6e2:	8556                	mv	a0,s5
 6e4:	00000097          	auipc	ra,0x0
 6e8:	e1c080e7          	jalr	-484(ra) # 500 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 6ec:	0992                	slli	s3,s3,0x4
 6ee:	397d                	addiw	s2,s2,-1
 6f0:	fe0914e3          	bnez	s2,6d8 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
 6f4:	8be2                	mv	s7,s8
      state = 0;
 6f6:	4981                	li	s3,0
 6f8:	6c02                	ld	s8,0(sp)
 6fa:	bf09                	j	60c <vprintf+0x42>
        s = va_arg(ap, char*);
 6fc:	008b8993          	addi	s3,s7,8
 700:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 704:	02090163          	beqz	s2,726 <vprintf+0x15c>
        while(*s != 0){
 708:	00094583          	lbu	a1,0(s2)
 70c:	c9a5                	beqz	a1,77c <vprintf+0x1b2>
          putc(fd, *s);
 70e:	8556                	mv	a0,s5
 710:	00000097          	auipc	ra,0x0
 714:	df0080e7          	jalr	-528(ra) # 500 <putc>
          s++;
 718:	0905                	addi	s2,s2,1
        while(*s != 0){
 71a:	00094583          	lbu	a1,0(s2)
 71e:	f9e5                	bnez	a1,70e <vprintf+0x144>
        s = va_arg(ap, char*);
 720:	8bce                	mv	s7,s3
      state = 0;
 722:	4981                	li	s3,0
 724:	b5e5                	j	60c <vprintf+0x42>
          s = "(null)";
 726:	00000917          	auipc	s2,0x0
 72a:	37a90913          	addi	s2,s2,890 # aa0 <malloc+0x21e>
        while(*s != 0){
 72e:	02800593          	li	a1,40
 732:	bff1                	j	70e <vprintf+0x144>
        putc(fd, va_arg(ap, uint));
 734:	008b8913          	addi	s2,s7,8
 738:	000bc583          	lbu	a1,0(s7)
 73c:	8556                	mv	a0,s5
 73e:	00000097          	auipc	ra,0x0
 742:	dc2080e7          	jalr	-574(ra) # 500 <putc>
 746:	8bca                	mv	s7,s2
      state = 0;
 748:	4981                	li	s3,0
 74a:	b5c9                	j	60c <vprintf+0x42>
        putc(fd, c);
 74c:	02500593          	li	a1,37
 750:	8556                	mv	a0,s5
 752:	00000097          	auipc	ra,0x0
 756:	dae080e7          	jalr	-594(ra) # 500 <putc>
      state = 0;
 75a:	4981                	li	s3,0
 75c:	bd45                	j	60c <vprintf+0x42>
        putc(fd, '%');
 75e:	02500593          	li	a1,37
 762:	8556                	mv	a0,s5
 764:	00000097          	auipc	ra,0x0
 768:	d9c080e7          	jalr	-612(ra) # 500 <putc>
        putc(fd, c);
 76c:	85ca                	mv	a1,s2
 76e:	8556                	mv	a0,s5
 770:	00000097          	auipc	ra,0x0
 774:	d90080e7          	jalr	-624(ra) # 500 <putc>
      state = 0;
 778:	4981                	li	s3,0
 77a:	bd49                	j	60c <vprintf+0x42>
        s = va_arg(ap, char*);
 77c:	8bce                	mv	s7,s3
      state = 0;
 77e:	4981                	li	s3,0
 780:	b571                	j	60c <vprintf+0x42>
 782:	74e2                	ld	s1,56(sp)
 784:	79a2                	ld	s3,40(sp)
 786:	7a02                	ld	s4,32(sp)
 788:	6ae2                	ld	s5,24(sp)
 78a:	6b42                	ld	s6,16(sp)
 78c:	6ba2                	ld	s7,8(sp)
    }
  }
}
 78e:	60a6                	ld	ra,72(sp)
 790:	6406                	ld	s0,64(sp)
 792:	7942                	ld	s2,48(sp)
 794:	6161                	addi	sp,sp,80
 796:	8082                	ret

0000000000000798 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 798:	715d                	addi	sp,sp,-80
 79a:	ec06                	sd	ra,24(sp)
 79c:	e822                	sd	s0,16(sp)
 79e:	1000                	addi	s0,sp,32
 7a0:	e010                	sd	a2,0(s0)
 7a2:	e414                	sd	a3,8(s0)
 7a4:	e818                	sd	a4,16(s0)
 7a6:	ec1c                	sd	a5,24(s0)
 7a8:	03043023          	sd	a6,32(s0)
 7ac:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 7b0:	8622                	mv	a2,s0
 7b2:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 7b6:	00000097          	auipc	ra,0x0
 7ba:	e14080e7          	jalr	-492(ra) # 5ca <vprintf>
}
 7be:	60e2                	ld	ra,24(sp)
 7c0:	6442                	ld	s0,16(sp)
 7c2:	6161                	addi	sp,sp,80
 7c4:	8082                	ret

00000000000007c6 <printf>:

void
printf(const char *fmt, ...)
{
 7c6:	711d                	addi	sp,sp,-96
 7c8:	ec06                	sd	ra,24(sp)
 7ca:	e822                	sd	s0,16(sp)
 7cc:	1000                	addi	s0,sp,32
 7ce:	e40c                	sd	a1,8(s0)
 7d0:	e810                	sd	a2,16(s0)
 7d2:	ec14                	sd	a3,24(s0)
 7d4:	f018                	sd	a4,32(s0)
 7d6:	f41c                	sd	a5,40(s0)
 7d8:	03043823          	sd	a6,48(s0)
 7dc:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 7e0:	00840613          	addi	a2,s0,8
 7e4:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 7e8:	85aa                	mv	a1,a0
 7ea:	4505                	li	a0,1
 7ec:	00000097          	auipc	ra,0x0
 7f0:	dde080e7          	jalr	-546(ra) # 5ca <vprintf>
}
 7f4:	60e2                	ld	ra,24(sp)
 7f6:	6442                	ld	s0,16(sp)
 7f8:	6125                	addi	sp,sp,96
 7fa:	8082                	ret

00000000000007fc <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7fc:	1141                	addi	sp,sp,-16
 7fe:	e406                	sd	ra,8(sp)
 800:	e022                	sd	s0,0(sp)
 802:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 804:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 808:	00000797          	auipc	a5,0x0
 80c:	3107b783          	ld	a5,784(a5) # b18 <freep>
 810:	a039                	j	81e <free+0x22>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 812:	6398                	ld	a4,0(a5)
 814:	00e7e463          	bltu	a5,a4,81c <free+0x20>
 818:	00e6ea63          	bltu	a3,a4,82c <free+0x30>
{
 81c:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 81e:	fed7fae3          	bgeu	a5,a3,812 <free+0x16>
 822:	6398                	ld	a4,0(a5)
 824:	00e6e463          	bltu	a3,a4,82c <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 828:	fee7eae3          	bltu	a5,a4,81c <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 82c:	ff852583          	lw	a1,-8(a0)
 830:	6390                	ld	a2,0(a5)
 832:	02059813          	slli	a6,a1,0x20
 836:	01c85713          	srli	a4,a6,0x1c
 83a:	9736                	add	a4,a4,a3
 83c:	02e60563          	beq	a2,a4,866 <free+0x6a>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 840:	fec53823          	sd	a2,-16(a0)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 844:	4790                	lw	a2,8(a5)
 846:	02061593          	slli	a1,a2,0x20
 84a:	01c5d713          	srli	a4,a1,0x1c
 84e:	973e                	add	a4,a4,a5
 850:	02e68263          	beq	a3,a4,874 <free+0x78>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 854:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 856:	00000717          	auipc	a4,0x0
 85a:	2cf73123          	sd	a5,706(a4) # b18 <freep>
}
 85e:	60a2                	ld	ra,8(sp)
 860:	6402                	ld	s0,0(sp)
 862:	0141                	addi	sp,sp,16
 864:	8082                	ret
    bp->s.size += p->s.ptr->s.size;
 866:	4618                	lw	a4,8(a2)
 868:	9f2d                	addw	a4,a4,a1
 86a:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 86e:	6398                	ld	a4,0(a5)
 870:	6310                	ld	a2,0(a4)
 872:	b7f9                	j	840 <free+0x44>
    p->s.size += bp->s.size;
 874:	ff852703          	lw	a4,-8(a0)
 878:	9f31                	addw	a4,a4,a2
 87a:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 87c:	ff053683          	ld	a3,-16(a0)
 880:	bfd1                	j	854 <free+0x58>

0000000000000882 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 882:	7139                	addi	sp,sp,-64
 884:	fc06                	sd	ra,56(sp)
 886:	f822                	sd	s0,48(sp)
 888:	f04a                	sd	s2,32(sp)
 88a:	ec4e                	sd	s3,24(sp)
 88c:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 88e:	02051993          	slli	s3,a0,0x20
 892:	0209d993          	srli	s3,s3,0x20
 896:	09bd                	addi	s3,s3,15
 898:	0049d993          	srli	s3,s3,0x4
 89c:	2985                	addiw	s3,s3,1
 89e:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 8a0:	00000517          	auipc	a0,0x0
 8a4:	27853503          	ld	a0,632(a0) # b18 <freep>
 8a8:	c905                	beqz	a0,8d8 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8aa:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8ac:	4798                	lw	a4,8(a5)
 8ae:	09377a63          	bgeu	a4,s3,942 <malloc+0xc0>
 8b2:	f426                	sd	s1,40(sp)
 8b4:	e852                	sd	s4,16(sp)
 8b6:	e456                	sd	s5,8(sp)
 8b8:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 8ba:	8a4e                	mv	s4,s3
 8bc:	6705                	lui	a4,0x1
 8be:	00e9f363          	bgeu	s3,a4,8c4 <malloc+0x42>
 8c2:	6a05                	lui	s4,0x1
 8c4:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 8c8:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 8cc:	00000497          	auipc	s1,0x0
 8d0:	24c48493          	addi	s1,s1,588 # b18 <freep>
  if(p == (char*)-1)
 8d4:	5afd                	li	s5,-1
 8d6:	a089                	j	918 <malloc+0x96>
 8d8:	f426                	sd	s1,40(sp)
 8da:	e852                	sd	s4,16(sp)
 8dc:	e456                	sd	s5,8(sp)
 8de:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 8e0:	00000797          	auipc	a5,0x0
 8e4:	24078793          	addi	a5,a5,576 # b20 <base>
 8e8:	00000717          	auipc	a4,0x0
 8ec:	22f73823          	sd	a5,560(a4) # b18 <freep>
 8f0:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 8f2:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 8f6:	b7d1                	j	8ba <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 8f8:	6398                	ld	a4,0(a5)
 8fa:	e118                	sd	a4,0(a0)
 8fc:	a8b9                	j	95a <malloc+0xd8>
  hp->s.size = nu;
 8fe:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 902:	0541                	addi	a0,a0,16
 904:	00000097          	auipc	ra,0x0
 908:	ef8080e7          	jalr	-264(ra) # 7fc <free>
  return freep;
 90c:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 90e:	c135                	beqz	a0,972 <malloc+0xf0>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 910:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 912:	4798                	lw	a4,8(a5)
 914:	03277363          	bgeu	a4,s2,93a <malloc+0xb8>
    if(p == freep)
 918:	6098                	ld	a4,0(s1)
 91a:	853e                	mv	a0,a5
 91c:	fef71ae3          	bne	a4,a5,910 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 920:	8552                	mv	a0,s4
 922:	00000097          	auipc	ra,0x0
 926:	bbe080e7          	jalr	-1090(ra) # 4e0 <sbrk>
  if(p == (char*)-1)
 92a:	fd551ae3          	bne	a0,s5,8fe <malloc+0x7c>
        return 0;
 92e:	4501                	li	a0,0
 930:	74a2                	ld	s1,40(sp)
 932:	6a42                	ld	s4,16(sp)
 934:	6aa2                	ld	s5,8(sp)
 936:	6b02                	ld	s6,0(sp)
 938:	a03d                	j	966 <malloc+0xe4>
 93a:	74a2                	ld	s1,40(sp)
 93c:	6a42                	ld	s4,16(sp)
 93e:	6aa2                	ld	s5,8(sp)
 940:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 942:	fae90be3          	beq	s2,a4,8f8 <malloc+0x76>
        p->s.size -= nunits;
 946:	4137073b          	subw	a4,a4,s3
 94a:	c798                	sw	a4,8(a5)
        p += p->s.size;
 94c:	02071693          	slli	a3,a4,0x20
 950:	01c6d713          	srli	a4,a3,0x1c
 954:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 956:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 95a:	00000717          	auipc	a4,0x0
 95e:	1aa73f23          	sd	a0,446(a4) # b18 <freep>
      return (void*)(p + 1);
 962:	01078513          	addi	a0,a5,16
  }
}
 966:	70e2                	ld	ra,56(sp)
 968:	7442                	ld	s0,48(sp)
 96a:	7902                	ld	s2,32(sp)
 96c:	69e2                	ld	s3,24(sp)
 96e:	6121                	addi	sp,sp,64
 970:	8082                	ret
 972:	74a2                	ld	s1,40(sp)
 974:	6a42                	ld	s4,16(sp)
 976:	6aa2                	ld	s5,8(sp)
 978:	6b02                	ld	s6,0(sp)
 97a:	b7f5                	j	966 <malloc+0xe4>
