
user/_sleep：     文件格式 elf64-littleriscv


Disassembly of section .text:

0000000000000000 <parse_cmd>:
    }
}

cmd_parse
parse_cmd(int argc, char **argv)
{
   0:	1141                	addi	sp,sp,-16
   2:	e406                	sd	ra,8(sp)
   4:	e022                	sd	s0,0(sp)
   6:	0800                	addi	s0,sp,16
    if (argc > 2)
   8:	4789                	li	a5,2
   a:	02a7c463          	blt	a5,a0,32 <parse_cmd+0x32>
        return toomany_char;
    }
    else
    {
        int i = 0;
        while (argv[duration_pos][i] != '\0')
   e:	6598                	ld	a4,8(a1)
  10:	00074783          	lbu	a5,0(a4)
  14:	c38d                	beqz	a5,36 <parse_cmd+0x36>
  16:	0705                	addi	a4,a4,1
        {
            /* code */
            if (!('0' <= argv[duration_pos][i] && argv[duration_pos][i] <= '9'))
  18:	46a5                	li	a3,9
  1a:	fd07879b          	addiw	a5,a5,-48
  1e:	0ff7f793          	zext.b	a5,a5
  22:	00f6ec63          	bltu	a3,a5,3a <parse_cmd+0x3a>
        while (argv[duration_pos][i] != '\0')
  26:	0705                	addi	a4,a4,1
  28:	fff74783          	lbu	a5,-1(a4)
  2c:	f7fd                	bnez	a5,1a <parse_cmd+0x1a>
                return wrong_char;
            }
            i++;
        }
    }
    return success_parse;
  2e:	4505                	li	a0,1
  30:	a031                	j	3c <parse_cmd+0x3c>
        return toomany_char;
  32:	4509                	li	a0,2
  34:	a021                	j	3c <parse_cmd+0x3c>
    return success_parse;
  36:	4505                	li	a0,1
  38:	a011                	j	3c <parse_cmd+0x3c>
                return wrong_char;
  3a:	4501                	li	a0,0
}
  3c:	60a2                	ld	ra,8(sp)
  3e:	6402                	ld	s0,0(sp)
  40:	0141                	addi	sp,sp,16
  42:	8082                	ret

0000000000000044 <main>:
{
  44:	1101                	addi	sp,sp,-32
  46:	ec06                	sd	ra,24(sp)
  48:	e822                	sd	s0,16(sp)
  4a:	1000                	addi	s0,sp,32
    if (argc == 1)
  4c:	4785                	li	a5,1
  4e:	02f50963          	beq	a0,a5,80 <main+0x3c>
  52:	e426                	sd	s1,8(sp)
  54:	84ae                	mv	s1,a1
        parse_result = parse_cmd(argc, argv);
  56:	00000097          	auipc	ra,0x0
  5a:	faa080e7          	jalr	-86(ra) # 0 <parse_cmd>
        if (parse_result == toomany_char)
  5e:	4789                	li	a5,2
  60:	02f50e63          	beq	a0,a5,9c <main+0x58>
        else if (parse_result == wrong_char)
  64:	e929                	bnez	a0,b6 <main+0x72>
            printf("Cannot input alphabet, number only \n");
  66:	00001517          	auipc	a0,0x1
  6a:	85a50513          	addi	a0,a0,-1958 # 8c0 <malloc+0x136>
  6e:	00000097          	auipc	ra,0x0
  72:	660080e7          	jalr	1632(ra) # 6ce <printf>
            exit(0);
  76:	4501                	li	a0,0
  78:	00000097          	auipc	ra,0x0
  7c:	2e8080e7          	jalr	744(ra) # 360 <exit>
  80:	e426                	sd	s1,8(sp)
        printf("Please enter the parameters!\n");
  82:	00001517          	auipc	a0,0x1
  86:	80650513          	addi	a0,a0,-2042 # 888 <malloc+0xfe>
  8a:	00000097          	auipc	ra,0x0
  8e:	644080e7          	jalr	1604(ra) # 6ce <printf>
        exit(0);
  92:	4501                	li	a0,0
  94:	00000097          	auipc	ra,0x0
  98:	2cc080e7          	jalr	716(ra) # 360 <exit>
            printf("Too many args! \n");
  9c:	00001517          	auipc	a0,0x1
  a0:	80c50513          	addi	a0,a0,-2036 # 8a8 <malloc+0x11e>
  a4:	00000097          	auipc	ra,0x0
  a8:	62a080e7          	jalr	1578(ra) # 6ce <printf>
            exit(0);
  ac:	4501                	li	a0,0
  ae:	00000097          	auipc	ra,0x0
  b2:	2b2080e7          	jalr	690(ra) # 360 <exit>
            int duration = atoi(argv[duration_pos]);
  b6:	6488                	ld	a0,8(s1)
  b8:	00000097          	auipc	ra,0x0
  bc:	1a6080e7          	jalr	422(ra) # 25e <atoi>
            sleep(duration);
  c0:	00000097          	auipc	ra,0x0
  c4:	330080e7          	jalr	816(ra) # 3f0 <sleep>
            exit(0);
  c8:	4501                	li	a0,0
  ca:	00000097          	auipc	ra,0x0
  ce:	296080e7          	jalr	662(ra) # 360 <exit>

00000000000000d2 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
  d2:	1141                	addi	sp,sp,-16
  d4:	e406                	sd	ra,8(sp)
  d6:	e022                	sd	s0,0(sp)
  d8:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  da:	87aa                	mv	a5,a0
  dc:	0585                	addi	a1,a1,1
  de:	0785                	addi	a5,a5,1
  e0:	fff5c703          	lbu	a4,-1(a1)
  e4:	fee78fa3          	sb	a4,-1(a5)
  e8:	fb75                	bnez	a4,dc <strcpy+0xa>
    ;
  return os;
}
  ea:	60a2                	ld	ra,8(sp)
  ec:	6402                	ld	s0,0(sp)
  ee:	0141                	addi	sp,sp,16
  f0:	8082                	ret

00000000000000f2 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  f2:	1141                	addi	sp,sp,-16
  f4:	e406                	sd	ra,8(sp)
  f6:	e022                	sd	s0,0(sp)
  f8:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  fa:	00054783          	lbu	a5,0(a0)
  fe:	cb91                	beqz	a5,112 <strcmp+0x20>
 100:	0005c703          	lbu	a4,0(a1)
 104:	00f71763          	bne	a4,a5,112 <strcmp+0x20>
    p++, q++;
 108:	0505                	addi	a0,a0,1
 10a:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 10c:	00054783          	lbu	a5,0(a0)
 110:	fbe5                	bnez	a5,100 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 112:	0005c503          	lbu	a0,0(a1)
}
 116:	40a7853b          	subw	a0,a5,a0
 11a:	60a2                	ld	ra,8(sp)
 11c:	6402                	ld	s0,0(sp)
 11e:	0141                	addi	sp,sp,16
 120:	8082                	ret

0000000000000122 <strlen>:

uint
strlen(const char *s)
{
 122:	1141                	addi	sp,sp,-16
 124:	e406                	sd	ra,8(sp)
 126:	e022                	sd	s0,0(sp)
 128:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 12a:	00054783          	lbu	a5,0(a0)
 12e:	cf91                	beqz	a5,14a <strlen+0x28>
 130:	00150793          	addi	a5,a0,1
 134:	86be                	mv	a3,a5
 136:	0785                	addi	a5,a5,1
 138:	fff7c703          	lbu	a4,-1(a5)
 13c:	ff65                	bnez	a4,134 <strlen+0x12>
 13e:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
 142:	60a2                	ld	ra,8(sp)
 144:	6402                	ld	s0,0(sp)
 146:	0141                	addi	sp,sp,16
 148:	8082                	ret
  for(n = 0; s[n]; n++)
 14a:	4501                	li	a0,0
 14c:	bfdd                	j	142 <strlen+0x20>

000000000000014e <memset>:

void*
memset(void *dst, int c, uint n)
{
 14e:	1141                	addi	sp,sp,-16
 150:	e406                	sd	ra,8(sp)
 152:	e022                	sd	s0,0(sp)
 154:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 156:	ca19                	beqz	a2,16c <memset+0x1e>
 158:	87aa                	mv	a5,a0
 15a:	1602                	slli	a2,a2,0x20
 15c:	9201                	srli	a2,a2,0x20
 15e:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 162:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 166:	0785                	addi	a5,a5,1
 168:	fee79de3          	bne	a5,a4,162 <memset+0x14>
  }
  return dst;
}
 16c:	60a2                	ld	ra,8(sp)
 16e:	6402                	ld	s0,0(sp)
 170:	0141                	addi	sp,sp,16
 172:	8082                	ret

0000000000000174 <strchr>:

char*
strchr(const char *s, char c)
{
 174:	1141                	addi	sp,sp,-16
 176:	e406                	sd	ra,8(sp)
 178:	e022                	sd	s0,0(sp)
 17a:	0800                	addi	s0,sp,16
  for(; *s; s++)
 17c:	00054783          	lbu	a5,0(a0)
 180:	cf81                	beqz	a5,198 <strchr+0x24>
    if(*s == c)
 182:	00f58763          	beq	a1,a5,190 <strchr+0x1c>
  for(; *s; s++)
 186:	0505                	addi	a0,a0,1
 188:	00054783          	lbu	a5,0(a0)
 18c:	fbfd                	bnez	a5,182 <strchr+0xe>
      return (char*)s;
  return 0;
 18e:	4501                	li	a0,0
}
 190:	60a2                	ld	ra,8(sp)
 192:	6402                	ld	s0,0(sp)
 194:	0141                	addi	sp,sp,16
 196:	8082                	ret
  return 0;
 198:	4501                	li	a0,0
 19a:	bfdd                	j	190 <strchr+0x1c>

000000000000019c <gets>:

char*
gets(char *buf, int max)
{
 19c:	711d                	addi	sp,sp,-96
 19e:	ec86                	sd	ra,88(sp)
 1a0:	e8a2                	sd	s0,80(sp)
 1a2:	e4a6                	sd	s1,72(sp)
 1a4:	e0ca                	sd	s2,64(sp)
 1a6:	fc4e                	sd	s3,56(sp)
 1a8:	f852                	sd	s4,48(sp)
 1aa:	f456                	sd	s5,40(sp)
 1ac:	f05a                	sd	s6,32(sp)
 1ae:	ec5e                	sd	s7,24(sp)
 1b0:	e862                	sd	s8,16(sp)
 1b2:	1080                	addi	s0,sp,96
 1b4:	8baa                	mv	s7,a0
 1b6:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1b8:	892a                	mv	s2,a0
 1ba:	4481                	li	s1,0
    cc = read(0, &c, 1);
 1bc:	faf40b13          	addi	s6,s0,-81
 1c0:	4a85                	li	s5,1
  for(i=0; i+1 < max; ){
 1c2:	8c26                	mv	s8,s1
 1c4:	0014899b          	addiw	s3,s1,1
 1c8:	84ce                	mv	s1,s3
 1ca:	0349d663          	bge	s3,s4,1f6 <gets+0x5a>
    cc = read(0, &c, 1);
 1ce:	8656                	mv	a2,s5
 1d0:	85da                	mv	a1,s6
 1d2:	4501                	li	a0,0
 1d4:	00000097          	auipc	ra,0x0
 1d8:	1a4080e7          	jalr	420(ra) # 378 <read>
    if(cc < 1)
 1dc:	00a05d63          	blez	a0,1f6 <gets+0x5a>
      break;
    buf[i++] = c;
 1e0:	faf44783          	lbu	a5,-81(s0)
 1e4:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 1e8:	0905                	addi	s2,s2,1
 1ea:	ff678713          	addi	a4,a5,-10
 1ee:	c319                	beqz	a4,1f4 <gets+0x58>
 1f0:	17cd                	addi	a5,a5,-13
 1f2:	fbe1                	bnez	a5,1c2 <gets+0x26>
    buf[i++] = c;
 1f4:	8c4e                	mv	s8,s3
      break;
  }
  buf[i] = '\0';
 1f6:	9c5e                	add	s8,s8,s7
 1f8:	000c0023          	sb	zero,0(s8)
  return buf;
}
 1fc:	855e                	mv	a0,s7
 1fe:	60e6                	ld	ra,88(sp)
 200:	6446                	ld	s0,80(sp)
 202:	64a6                	ld	s1,72(sp)
 204:	6906                	ld	s2,64(sp)
 206:	79e2                	ld	s3,56(sp)
 208:	7a42                	ld	s4,48(sp)
 20a:	7aa2                	ld	s5,40(sp)
 20c:	7b02                	ld	s6,32(sp)
 20e:	6be2                	ld	s7,24(sp)
 210:	6c42                	ld	s8,16(sp)
 212:	6125                	addi	sp,sp,96
 214:	8082                	ret

0000000000000216 <stat>:

int
stat(const char *n, struct stat *st)
{
 216:	1101                	addi	sp,sp,-32
 218:	ec06                	sd	ra,24(sp)
 21a:	e822                	sd	s0,16(sp)
 21c:	e04a                	sd	s2,0(sp)
 21e:	1000                	addi	s0,sp,32
 220:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 222:	4581                	li	a1,0
 224:	00000097          	auipc	ra,0x0
 228:	17c080e7          	jalr	380(ra) # 3a0 <open>
  if(fd < 0)
 22c:	02054663          	bltz	a0,258 <stat+0x42>
 230:	e426                	sd	s1,8(sp)
 232:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 234:	85ca                	mv	a1,s2
 236:	00000097          	auipc	ra,0x0
 23a:	182080e7          	jalr	386(ra) # 3b8 <fstat>
 23e:	892a                	mv	s2,a0
  close(fd);
 240:	8526                	mv	a0,s1
 242:	00000097          	auipc	ra,0x0
 246:	146080e7          	jalr	326(ra) # 388 <close>
  return r;
 24a:	64a2                	ld	s1,8(sp)
}
 24c:	854a                	mv	a0,s2
 24e:	60e2                	ld	ra,24(sp)
 250:	6442                	ld	s0,16(sp)
 252:	6902                	ld	s2,0(sp)
 254:	6105                	addi	sp,sp,32
 256:	8082                	ret
    return -1;
 258:	57fd                	li	a5,-1
 25a:	893e                	mv	s2,a5
 25c:	bfc5                	j	24c <stat+0x36>

000000000000025e <atoi>:

int
atoi(const char *s)
{
 25e:	1141                	addi	sp,sp,-16
 260:	e406                	sd	ra,8(sp)
 262:	e022                	sd	s0,0(sp)
 264:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 266:	00054683          	lbu	a3,0(a0)
 26a:	fd06879b          	addiw	a5,a3,-48
 26e:	0ff7f793          	zext.b	a5,a5
 272:	4625                	li	a2,9
 274:	02f66963          	bltu	a2,a5,2a6 <atoi+0x48>
 278:	872a                	mv	a4,a0
  n = 0;
 27a:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 27c:	0705                	addi	a4,a4,1
 27e:	0025179b          	slliw	a5,a0,0x2
 282:	9fa9                	addw	a5,a5,a0
 284:	0017979b          	slliw	a5,a5,0x1
 288:	9fb5                	addw	a5,a5,a3
 28a:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 28e:	00074683          	lbu	a3,0(a4)
 292:	fd06879b          	addiw	a5,a3,-48
 296:	0ff7f793          	zext.b	a5,a5
 29a:	fef671e3          	bgeu	a2,a5,27c <atoi+0x1e>
  return n;
}
 29e:	60a2                	ld	ra,8(sp)
 2a0:	6402                	ld	s0,0(sp)
 2a2:	0141                	addi	sp,sp,16
 2a4:	8082                	ret
  n = 0;
 2a6:	4501                	li	a0,0
 2a8:	bfdd                	j	29e <atoi+0x40>

00000000000002aa <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2aa:	1141                	addi	sp,sp,-16
 2ac:	e406                	sd	ra,8(sp)
 2ae:	e022                	sd	s0,0(sp)
 2b0:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 2b2:	02b57563          	bgeu	a0,a1,2dc <memmove+0x32>
    while(n-- > 0)
 2b6:	00c05f63          	blez	a2,2d4 <memmove+0x2a>
 2ba:	1602                	slli	a2,a2,0x20
 2bc:	9201                	srli	a2,a2,0x20
 2be:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 2c2:	872a                	mv	a4,a0
      *dst++ = *src++;
 2c4:	0585                	addi	a1,a1,1
 2c6:	0705                	addi	a4,a4,1
 2c8:	fff5c683          	lbu	a3,-1(a1)
 2cc:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 2d0:	fee79ae3          	bne	a5,a4,2c4 <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 2d4:	60a2                	ld	ra,8(sp)
 2d6:	6402                	ld	s0,0(sp)
 2d8:	0141                	addi	sp,sp,16
 2da:	8082                	ret
    while(n-- > 0)
 2dc:	fec05ce3          	blez	a2,2d4 <memmove+0x2a>
    dst += n;
 2e0:	00c50733          	add	a4,a0,a2
    src += n;
 2e4:	95b2                	add	a1,a1,a2
 2e6:	fff6079b          	addiw	a5,a2,-1
 2ea:	1782                	slli	a5,a5,0x20
 2ec:	9381                	srli	a5,a5,0x20
 2ee:	fff7c793          	not	a5,a5
 2f2:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2f4:	15fd                	addi	a1,a1,-1
 2f6:	177d                	addi	a4,a4,-1
 2f8:	0005c683          	lbu	a3,0(a1)
 2fc:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 300:	fef71ae3          	bne	a4,a5,2f4 <memmove+0x4a>
 304:	bfc1                	j	2d4 <memmove+0x2a>

0000000000000306 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 306:	1141                	addi	sp,sp,-16
 308:	e406                	sd	ra,8(sp)
 30a:	e022                	sd	s0,0(sp)
 30c:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 30e:	c61d                	beqz	a2,33c <memcmp+0x36>
 310:	1602                	slli	a2,a2,0x20
 312:	9201                	srli	a2,a2,0x20
 314:	00c506b3          	add	a3,a0,a2
    if (*p1 != *p2) {
 318:	00054783          	lbu	a5,0(a0)
 31c:	0005c703          	lbu	a4,0(a1)
 320:	00e79863          	bne	a5,a4,330 <memcmp+0x2a>
      return *p1 - *p2;
    }
    p1++;
 324:	0505                	addi	a0,a0,1
    p2++;
 326:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 328:	fed518e3          	bne	a0,a3,318 <memcmp+0x12>
  }
  return 0;
 32c:	4501                	li	a0,0
 32e:	a019                	j	334 <memcmp+0x2e>
      return *p1 - *p2;
 330:	40e7853b          	subw	a0,a5,a4
}
 334:	60a2                	ld	ra,8(sp)
 336:	6402                	ld	s0,0(sp)
 338:	0141                	addi	sp,sp,16
 33a:	8082                	ret
  return 0;
 33c:	4501                	li	a0,0
 33e:	bfdd                	j	334 <memcmp+0x2e>

0000000000000340 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 340:	1141                	addi	sp,sp,-16
 342:	e406                	sd	ra,8(sp)
 344:	e022                	sd	s0,0(sp)
 346:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 348:	00000097          	auipc	ra,0x0
 34c:	f62080e7          	jalr	-158(ra) # 2aa <memmove>
}
 350:	60a2                	ld	ra,8(sp)
 352:	6402                	ld	s0,0(sp)
 354:	0141                	addi	sp,sp,16
 356:	8082                	ret

0000000000000358 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 358:	4885                	li	a7,1
 ecall
 35a:	00000073          	ecall
 ret
 35e:	8082                	ret

0000000000000360 <exit>:
.global exit
exit:
 li a7, SYS_exit
 360:	4889                	li	a7,2
 ecall
 362:	00000073          	ecall
 ret
 366:	8082                	ret

0000000000000368 <wait>:
.global wait
wait:
 li a7, SYS_wait
 368:	488d                	li	a7,3
 ecall
 36a:	00000073          	ecall
 ret
 36e:	8082                	ret

0000000000000370 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 370:	4891                	li	a7,4
 ecall
 372:	00000073          	ecall
 ret
 376:	8082                	ret

0000000000000378 <read>:
.global read
read:
 li a7, SYS_read
 378:	4895                	li	a7,5
 ecall
 37a:	00000073          	ecall
 ret
 37e:	8082                	ret

0000000000000380 <write>:
.global write
write:
 li a7, SYS_write
 380:	48c1                	li	a7,16
 ecall
 382:	00000073          	ecall
 ret
 386:	8082                	ret

0000000000000388 <close>:
.global close
close:
 li a7, SYS_close
 388:	48d5                	li	a7,21
 ecall
 38a:	00000073          	ecall
 ret
 38e:	8082                	ret

0000000000000390 <kill>:
.global kill
kill:
 li a7, SYS_kill
 390:	4899                	li	a7,6
 ecall
 392:	00000073          	ecall
 ret
 396:	8082                	ret

0000000000000398 <exec>:
.global exec
exec:
 li a7, SYS_exec
 398:	489d                	li	a7,7
 ecall
 39a:	00000073          	ecall
 ret
 39e:	8082                	ret

00000000000003a0 <open>:
.global open
open:
 li a7, SYS_open
 3a0:	48bd                	li	a7,15
 ecall
 3a2:	00000073          	ecall
 ret
 3a6:	8082                	ret

00000000000003a8 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 3a8:	48c5                	li	a7,17
 ecall
 3aa:	00000073          	ecall
 ret
 3ae:	8082                	ret

00000000000003b0 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 3b0:	48c9                	li	a7,18
 ecall
 3b2:	00000073          	ecall
 ret
 3b6:	8082                	ret

00000000000003b8 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 3b8:	48a1                	li	a7,8
 ecall
 3ba:	00000073          	ecall
 ret
 3be:	8082                	ret

00000000000003c0 <link>:
.global link
link:
 li a7, SYS_link
 3c0:	48cd                	li	a7,19
 ecall
 3c2:	00000073          	ecall
 ret
 3c6:	8082                	ret

00000000000003c8 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3c8:	48d1                	li	a7,20
 ecall
 3ca:	00000073          	ecall
 ret
 3ce:	8082                	ret

00000000000003d0 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 3d0:	48a5                	li	a7,9
 ecall
 3d2:	00000073          	ecall
 ret
 3d6:	8082                	ret

00000000000003d8 <dup>:
.global dup
dup:
 li a7, SYS_dup
 3d8:	48a9                	li	a7,10
 ecall
 3da:	00000073          	ecall
 ret
 3de:	8082                	ret

00000000000003e0 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 3e0:	48ad                	li	a7,11
 ecall
 3e2:	00000073          	ecall
 ret
 3e6:	8082                	ret

00000000000003e8 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 3e8:	48b1                	li	a7,12
 ecall
 3ea:	00000073          	ecall
 ret
 3ee:	8082                	ret

00000000000003f0 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 3f0:	48b5                	li	a7,13
 ecall
 3f2:	00000073          	ecall
 ret
 3f6:	8082                	ret

00000000000003f8 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3f8:	48b9                	li	a7,14
 ecall
 3fa:	00000073          	ecall
 ret
 3fe:	8082                	ret

0000000000000400 <ntas>:
.global ntas
ntas:
 li a7, SYS_ntas
 400:	48d9                	li	a7,22
 ecall
 402:	00000073          	ecall
 ret
 406:	8082                	ret

0000000000000408 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 408:	1101                	addi	sp,sp,-32
 40a:	ec06                	sd	ra,24(sp)
 40c:	e822                	sd	s0,16(sp)
 40e:	1000                	addi	s0,sp,32
 410:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 414:	4605                	li	a2,1
 416:	fef40593          	addi	a1,s0,-17
 41a:	00000097          	auipc	ra,0x0
 41e:	f66080e7          	jalr	-154(ra) # 380 <write>
}
 422:	60e2                	ld	ra,24(sp)
 424:	6442                	ld	s0,16(sp)
 426:	6105                	addi	sp,sp,32
 428:	8082                	ret

000000000000042a <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 42a:	7139                	addi	sp,sp,-64
 42c:	fc06                	sd	ra,56(sp)
 42e:	f822                	sd	s0,48(sp)
 430:	f04a                	sd	s2,32(sp)
 432:	ec4e                	sd	s3,24(sp)
 434:	0080                	addi	s0,sp,64
 436:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 438:	cad9                	beqz	a3,4ce <printint+0xa4>
 43a:	01f5d79b          	srliw	a5,a1,0x1f
 43e:	cbc1                	beqz	a5,4ce <printint+0xa4>
    neg = 1;
    x = -xx;
 440:	40b005bb          	negw	a1,a1
    neg = 1;
 444:	4305                	li	t1,1
  } else {
    x = xx;
  }

  i = 0;
 446:	fc040993          	addi	s3,s0,-64
  neg = 0;
 44a:	86ce                	mv	a3,s3
  i = 0;
 44c:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 44e:	00000817          	auipc	a6,0x0
 452:	4fa80813          	addi	a6,a6,1274 # 948 <digits>
 456:	88ba                	mv	a7,a4
 458:	0017051b          	addiw	a0,a4,1
 45c:	872a                	mv	a4,a0
 45e:	02c5f7bb          	remuw	a5,a1,a2
 462:	1782                	slli	a5,a5,0x20
 464:	9381                	srli	a5,a5,0x20
 466:	97c2                	add	a5,a5,a6
 468:	0007c783          	lbu	a5,0(a5)
 46c:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 470:	87ae                	mv	a5,a1
 472:	02c5d5bb          	divuw	a1,a1,a2
 476:	0685                	addi	a3,a3,1
 478:	fcc7ffe3          	bgeu	a5,a2,456 <printint+0x2c>
  if(neg)
 47c:	00030c63          	beqz	t1,494 <printint+0x6a>
    buf[i++] = '-';
 480:	fd050793          	addi	a5,a0,-48
 484:	00878533          	add	a0,a5,s0
 488:	02d00793          	li	a5,45
 48c:	fef50823          	sb	a5,-16(a0)
 490:	0028871b          	addiw	a4,a7,2

  while(--i >= 0)
 494:	02e05763          	blez	a4,4c2 <printint+0x98>
 498:	f426                	sd	s1,40(sp)
 49a:	377d                	addiw	a4,a4,-1
 49c:	00e984b3          	add	s1,s3,a4
 4a0:	19fd                	addi	s3,s3,-1
 4a2:	99ba                	add	s3,s3,a4
 4a4:	1702                	slli	a4,a4,0x20
 4a6:	9301                	srli	a4,a4,0x20
 4a8:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 4ac:	0004c583          	lbu	a1,0(s1)
 4b0:	854a                	mv	a0,s2
 4b2:	00000097          	auipc	ra,0x0
 4b6:	f56080e7          	jalr	-170(ra) # 408 <putc>
  while(--i >= 0)
 4ba:	14fd                	addi	s1,s1,-1
 4bc:	ff3498e3          	bne	s1,s3,4ac <printint+0x82>
 4c0:	74a2                	ld	s1,40(sp)
}
 4c2:	70e2                	ld	ra,56(sp)
 4c4:	7442                	ld	s0,48(sp)
 4c6:	7902                	ld	s2,32(sp)
 4c8:	69e2                	ld	s3,24(sp)
 4ca:	6121                	addi	sp,sp,64
 4cc:	8082                	ret
  neg = 0;
 4ce:	4301                	li	t1,0
 4d0:	bf9d                	j	446 <printint+0x1c>

00000000000004d2 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 4d2:	715d                	addi	sp,sp,-80
 4d4:	e486                	sd	ra,72(sp)
 4d6:	e0a2                	sd	s0,64(sp)
 4d8:	f84a                	sd	s2,48(sp)
 4da:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 4dc:	0005c903          	lbu	s2,0(a1)
 4e0:	1a090b63          	beqz	s2,696 <vprintf+0x1c4>
 4e4:	fc26                	sd	s1,56(sp)
 4e6:	f44e                	sd	s3,40(sp)
 4e8:	f052                	sd	s4,32(sp)
 4ea:	ec56                	sd	s5,24(sp)
 4ec:	e85a                	sd	s6,16(sp)
 4ee:	e45e                	sd	s7,8(sp)
 4f0:	8aaa                	mv	s5,a0
 4f2:	8bb2                	mv	s7,a2
 4f4:	00158493          	addi	s1,a1,1
  state = 0;
 4f8:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 4fa:	02500a13          	li	s4,37
 4fe:	4b55                	li	s6,21
 500:	a839                	j	51e <vprintf+0x4c>
        putc(fd, c);
 502:	85ca                	mv	a1,s2
 504:	8556                	mv	a0,s5
 506:	00000097          	auipc	ra,0x0
 50a:	f02080e7          	jalr	-254(ra) # 408 <putc>
 50e:	a019                	j	514 <vprintf+0x42>
    } else if(state == '%'){
 510:	01498d63          	beq	s3,s4,52a <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
 514:	0485                	addi	s1,s1,1
 516:	fff4c903          	lbu	s2,-1(s1)
 51a:	16090863          	beqz	s2,68a <vprintf+0x1b8>
    if(state == 0){
 51e:	fe0999e3          	bnez	s3,510 <vprintf+0x3e>
      if(c == '%'){
 522:	ff4910e3          	bne	s2,s4,502 <vprintf+0x30>
        state = '%';
 526:	89d2                	mv	s3,s4
 528:	b7f5                	j	514 <vprintf+0x42>
      if(c == 'd'){
 52a:	13490563          	beq	s2,s4,654 <vprintf+0x182>
 52e:	f9d9079b          	addiw	a5,s2,-99
 532:	0ff7f793          	zext.b	a5,a5
 536:	12fb6863          	bltu	s6,a5,666 <vprintf+0x194>
 53a:	f9d9079b          	addiw	a5,s2,-99
 53e:	0ff7f713          	zext.b	a4,a5
 542:	12eb6263          	bltu	s6,a4,666 <vprintf+0x194>
 546:	00271793          	slli	a5,a4,0x2
 54a:	00000717          	auipc	a4,0x0
 54e:	3a670713          	addi	a4,a4,934 # 8f0 <malloc+0x166>
 552:	97ba                	add	a5,a5,a4
 554:	439c                	lw	a5,0(a5)
 556:	97ba                	add	a5,a5,a4
 558:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 55a:	008b8913          	addi	s2,s7,8
 55e:	4685                	li	a3,1
 560:	4629                	li	a2,10
 562:	000ba583          	lw	a1,0(s7)
 566:	8556                	mv	a0,s5
 568:	00000097          	auipc	ra,0x0
 56c:	ec2080e7          	jalr	-318(ra) # 42a <printint>
 570:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 572:	4981                	li	s3,0
 574:	b745                	j	514 <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
 576:	008b8913          	addi	s2,s7,8
 57a:	4681                	li	a3,0
 57c:	4629                	li	a2,10
 57e:	000ba583          	lw	a1,0(s7)
 582:	8556                	mv	a0,s5
 584:	00000097          	auipc	ra,0x0
 588:	ea6080e7          	jalr	-346(ra) # 42a <printint>
 58c:	8bca                	mv	s7,s2
      state = 0;
 58e:	4981                	li	s3,0
 590:	b751                	j	514 <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
 592:	008b8913          	addi	s2,s7,8
 596:	4681                	li	a3,0
 598:	4641                	li	a2,16
 59a:	000ba583          	lw	a1,0(s7)
 59e:	8556                	mv	a0,s5
 5a0:	00000097          	auipc	ra,0x0
 5a4:	e8a080e7          	jalr	-374(ra) # 42a <printint>
 5a8:	8bca                	mv	s7,s2
      state = 0;
 5aa:	4981                	li	s3,0
 5ac:	b7a5                	j	514 <vprintf+0x42>
 5ae:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
 5b0:	008b8793          	addi	a5,s7,8
 5b4:	8c3e                	mv	s8,a5
 5b6:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 5ba:	03000593          	li	a1,48
 5be:	8556                	mv	a0,s5
 5c0:	00000097          	auipc	ra,0x0
 5c4:	e48080e7          	jalr	-440(ra) # 408 <putc>
  putc(fd, 'x');
 5c8:	07800593          	li	a1,120
 5cc:	8556                	mv	a0,s5
 5ce:	00000097          	auipc	ra,0x0
 5d2:	e3a080e7          	jalr	-454(ra) # 408 <putc>
 5d6:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 5d8:	00000b97          	auipc	s7,0x0
 5dc:	370b8b93          	addi	s7,s7,880 # 948 <digits>
 5e0:	03c9d793          	srli	a5,s3,0x3c
 5e4:	97de                	add	a5,a5,s7
 5e6:	0007c583          	lbu	a1,0(a5)
 5ea:	8556                	mv	a0,s5
 5ec:	00000097          	auipc	ra,0x0
 5f0:	e1c080e7          	jalr	-484(ra) # 408 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 5f4:	0992                	slli	s3,s3,0x4
 5f6:	397d                	addiw	s2,s2,-1
 5f8:	fe0914e3          	bnez	s2,5e0 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
 5fc:	8be2                	mv	s7,s8
      state = 0;
 5fe:	4981                	li	s3,0
 600:	6c02                	ld	s8,0(sp)
 602:	bf09                	j	514 <vprintf+0x42>
        s = va_arg(ap, char*);
 604:	008b8993          	addi	s3,s7,8
 608:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 60c:	02090163          	beqz	s2,62e <vprintf+0x15c>
        while(*s != 0){
 610:	00094583          	lbu	a1,0(s2)
 614:	c9a5                	beqz	a1,684 <vprintf+0x1b2>
          putc(fd, *s);
 616:	8556                	mv	a0,s5
 618:	00000097          	auipc	ra,0x0
 61c:	df0080e7          	jalr	-528(ra) # 408 <putc>
          s++;
 620:	0905                	addi	s2,s2,1
        while(*s != 0){
 622:	00094583          	lbu	a1,0(s2)
 626:	f9e5                	bnez	a1,616 <vprintf+0x144>
        s = va_arg(ap, char*);
 628:	8bce                	mv	s7,s3
      state = 0;
 62a:	4981                	li	s3,0
 62c:	b5e5                	j	514 <vprintf+0x42>
          s = "(null)";
 62e:	00000917          	auipc	s2,0x0
 632:	2ba90913          	addi	s2,s2,698 # 8e8 <malloc+0x15e>
        while(*s != 0){
 636:	02800593          	li	a1,40
 63a:	bff1                	j	616 <vprintf+0x144>
        putc(fd, va_arg(ap, uint));
 63c:	008b8913          	addi	s2,s7,8
 640:	000bc583          	lbu	a1,0(s7)
 644:	8556                	mv	a0,s5
 646:	00000097          	auipc	ra,0x0
 64a:	dc2080e7          	jalr	-574(ra) # 408 <putc>
 64e:	8bca                	mv	s7,s2
      state = 0;
 650:	4981                	li	s3,0
 652:	b5c9                	j	514 <vprintf+0x42>
        putc(fd, c);
 654:	02500593          	li	a1,37
 658:	8556                	mv	a0,s5
 65a:	00000097          	auipc	ra,0x0
 65e:	dae080e7          	jalr	-594(ra) # 408 <putc>
      state = 0;
 662:	4981                	li	s3,0
 664:	bd45                	j	514 <vprintf+0x42>
        putc(fd, '%');
 666:	02500593          	li	a1,37
 66a:	8556                	mv	a0,s5
 66c:	00000097          	auipc	ra,0x0
 670:	d9c080e7          	jalr	-612(ra) # 408 <putc>
        putc(fd, c);
 674:	85ca                	mv	a1,s2
 676:	8556                	mv	a0,s5
 678:	00000097          	auipc	ra,0x0
 67c:	d90080e7          	jalr	-624(ra) # 408 <putc>
      state = 0;
 680:	4981                	li	s3,0
 682:	bd49                	j	514 <vprintf+0x42>
        s = va_arg(ap, char*);
 684:	8bce                	mv	s7,s3
      state = 0;
 686:	4981                	li	s3,0
 688:	b571                	j	514 <vprintf+0x42>
 68a:	74e2                	ld	s1,56(sp)
 68c:	79a2                	ld	s3,40(sp)
 68e:	7a02                	ld	s4,32(sp)
 690:	6ae2                	ld	s5,24(sp)
 692:	6b42                	ld	s6,16(sp)
 694:	6ba2                	ld	s7,8(sp)
    }
  }
}
 696:	60a6                	ld	ra,72(sp)
 698:	6406                	ld	s0,64(sp)
 69a:	7942                	ld	s2,48(sp)
 69c:	6161                	addi	sp,sp,80
 69e:	8082                	ret

00000000000006a0 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 6a0:	715d                	addi	sp,sp,-80
 6a2:	ec06                	sd	ra,24(sp)
 6a4:	e822                	sd	s0,16(sp)
 6a6:	1000                	addi	s0,sp,32
 6a8:	e010                	sd	a2,0(s0)
 6aa:	e414                	sd	a3,8(s0)
 6ac:	e818                	sd	a4,16(s0)
 6ae:	ec1c                	sd	a5,24(s0)
 6b0:	03043023          	sd	a6,32(s0)
 6b4:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 6b8:	8622                	mv	a2,s0
 6ba:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 6be:	00000097          	auipc	ra,0x0
 6c2:	e14080e7          	jalr	-492(ra) # 4d2 <vprintf>
}
 6c6:	60e2                	ld	ra,24(sp)
 6c8:	6442                	ld	s0,16(sp)
 6ca:	6161                	addi	sp,sp,80
 6cc:	8082                	ret

00000000000006ce <printf>:

void
printf(const char *fmt, ...)
{
 6ce:	711d                	addi	sp,sp,-96
 6d0:	ec06                	sd	ra,24(sp)
 6d2:	e822                	sd	s0,16(sp)
 6d4:	1000                	addi	s0,sp,32
 6d6:	e40c                	sd	a1,8(s0)
 6d8:	e810                	sd	a2,16(s0)
 6da:	ec14                	sd	a3,24(s0)
 6dc:	f018                	sd	a4,32(s0)
 6de:	f41c                	sd	a5,40(s0)
 6e0:	03043823          	sd	a6,48(s0)
 6e4:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 6e8:	00840613          	addi	a2,s0,8
 6ec:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 6f0:	85aa                	mv	a1,a0
 6f2:	4505                	li	a0,1
 6f4:	00000097          	auipc	ra,0x0
 6f8:	dde080e7          	jalr	-546(ra) # 4d2 <vprintf>
}
 6fc:	60e2                	ld	ra,24(sp)
 6fe:	6442                	ld	s0,16(sp)
 700:	6125                	addi	sp,sp,96
 702:	8082                	ret

0000000000000704 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 704:	1141                	addi	sp,sp,-16
 706:	e406                	sd	ra,8(sp)
 708:	e022                	sd	s0,0(sp)
 70a:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 70c:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 710:	00000797          	auipc	a5,0x0
 714:	2507b783          	ld	a5,592(a5) # 960 <freep>
 718:	a039                	j	726 <free+0x22>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 71a:	6398                	ld	a4,0(a5)
 71c:	00e7e463          	bltu	a5,a4,724 <free+0x20>
 720:	00e6ea63          	bltu	a3,a4,734 <free+0x30>
{
 724:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 726:	fed7fae3          	bgeu	a5,a3,71a <free+0x16>
 72a:	6398                	ld	a4,0(a5)
 72c:	00e6e463          	bltu	a3,a4,734 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 730:	fee7eae3          	bltu	a5,a4,724 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 734:	ff852583          	lw	a1,-8(a0)
 738:	6390                	ld	a2,0(a5)
 73a:	02059813          	slli	a6,a1,0x20
 73e:	01c85713          	srli	a4,a6,0x1c
 742:	9736                	add	a4,a4,a3
 744:	02e60563          	beq	a2,a4,76e <free+0x6a>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 748:	fec53823          	sd	a2,-16(a0)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 74c:	4790                	lw	a2,8(a5)
 74e:	02061593          	slli	a1,a2,0x20
 752:	01c5d713          	srli	a4,a1,0x1c
 756:	973e                	add	a4,a4,a5
 758:	02e68263          	beq	a3,a4,77c <free+0x78>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 75c:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 75e:	00000717          	auipc	a4,0x0
 762:	20f73123          	sd	a5,514(a4) # 960 <freep>
}
 766:	60a2                	ld	ra,8(sp)
 768:	6402                	ld	s0,0(sp)
 76a:	0141                	addi	sp,sp,16
 76c:	8082                	ret
    bp->s.size += p->s.ptr->s.size;
 76e:	4618                	lw	a4,8(a2)
 770:	9f2d                	addw	a4,a4,a1
 772:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 776:	6398                	ld	a4,0(a5)
 778:	6310                	ld	a2,0(a4)
 77a:	b7f9                	j	748 <free+0x44>
    p->s.size += bp->s.size;
 77c:	ff852703          	lw	a4,-8(a0)
 780:	9f31                	addw	a4,a4,a2
 782:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 784:	ff053683          	ld	a3,-16(a0)
 788:	bfd1                	j	75c <free+0x58>

000000000000078a <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 78a:	7139                	addi	sp,sp,-64
 78c:	fc06                	sd	ra,56(sp)
 78e:	f822                	sd	s0,48(sp)
 790:	f04a                	sd	s2,32(sp)
 792:	ec4e                	sd	s3,24(sp)
 794:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 796:	02051993          	slli	s3,a0,0x20
 79a:	0209d993          	srli	s3,s3,0x20
 79e:	09bd                	addi	s3,s3,15
 7a0:	0049d993          	srli	s3,s3,0x4
 7a4:	2985                	addiw	s3,s3,1
 7a6:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 7a8:	00000517          	auipc	a0,0x0
 7ac:	1b853503          	ld	a0,440(a0) # 960 <freep>
 7b0:	c905                	beqz	a0,7e0 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7b2:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 7b4:	4798                	lw	a4,8(a5)
 7b6:	09377a63          	bgeu	a4,s3,84a <malloc+0xc0>
 7ba:	f426                	sd	s1,40(sp)
 7bc:	e852                	sd	s4,16(sp)
 7be:	e456                	sd	s5,8(sp)
 7c0:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 7c2:	8a4e                	mv	s4,s3
 7c4:	6705                	lui	a4,0x1
 7c6:	00e9f363          	bgeu	s3,a4,7cc <malloc+0x42>
 7ca:	6a05                	lui	s4,0x1
 7cc:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 7d0:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7d4:	00000497          	auipc	s1,0x0
 7d8:	18c48493          	addi	s1,s1,396 # 960 <freep>
  if(p == (char*)-1)
 7dc:	5afd                	li	s5,-1
 7de:	a089                	j	820 <malloc+0x96>
 7e0:	f426                	sd	s1,40(sp)
 7e2:	e852                	sd	s4,16(sp)
 7e4:	e456                	sd	s5,8(sp)
 7e6:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 7e8:	00000797          	auipc	a5,0x0
 7ec:	18078793          	addi	a5,a5,384 # 968 <base>
 7f0:	00000717          	auipc	a4,0x0
 7f4:	16f73823          	sd	a5,368(a4) # 960 <freep>
 7f8:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 7fa:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 7fe:	b7d1                	j	7c2 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 800:	6398                	ld	a4,0(a5)
 802:	e118                	sd	a4,0(a0)
 804:	a8b9                	j	862 <malloc+0xd8>
  hp->s.size = nu;
 806:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 80a:	0541                	addi	a0,a0,16
 80c:	00000097          	auipc	ra,0x0
 810:	ef8080e7          	jalr	-264(ra) # 704 <free>
  return freep;
 814:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 816:	c135                	beqz	a0,87a <malloc+0xf0>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 818:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 81a:	4798                	lw	a4,8(a5)
 81c:	03277363          	bgeu	a4,s2,842 <malloc+0xb8>
    if(p == freep)
 820:	6098                	ld	a4,0(s1)
 822:	853e                	mv	a0,a5
 824:	fef71ae3          	bne	a4,a5,818 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 828:	8552                	mv	a0,s4
 82a:	00000097          	auipc	ra,0x0
 82e:	bbe080e7          	jalr	-1090(ra) # 3e8 <sbrk>
  if(p == (char*)-1)
 832:	fd551ae3          	bne	a0,s5,806 <malloc+0x7c>
        return 0;
 836:	4501                	li	a0,0
 838:	74a2                	ld	s1,40(sp)
 83a:	6a42                	ld	s4,16(sp)
 83c:	6aa2                	ld	s5,8(sp)
 83e:	6b02                	ld	s6,0(sp)
 840:	a03d                	j	86e <malloc+0xe4>
 842:	74a2                	ld	s1,40(sp)
 844:	6a42                	ld	s4,16(sp)
 846:	6aa2                	ld	s5,8(sp)
 848:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 84a:	fae90be3          	beq	s2,a4,800 <malloc+0x76>
        p->s.size -= nunits;
 84e:	4137073b          	subw	a4,a4,s3
 852:	c798                	sw	a4,8(a5)
        p += p->s.size;
 854:	02071693          	slli	a3,a4,0x20
 858:	01c6d713          	srli	a4,a3,0x1c
 85c:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 85e:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 862:	00000717          	auipc	a4,0x0
 866:	0ea73f23          	sd	a0,254(a4) # 960 <freep>
      return (void*)(p + 1);
 86a:	01078513          	addi	a0,a5,16
  }
}
 86e:	70e2                	ld	ra,56(sp)
 870:	7442                	ld	s0,48(sp)
 872:	7902                	ld	s2,32(sp)
 874:	69e2                	ld	s3,24(sp)
 876:	6121                	addi	sp,sp,64
 878:	8082                	ret
 87a:	74a2                	ld	s1,40(sp)
 87c:	6a42                	ld	s4,16(sp)
 87e:	6aa2                	ld	s5,8(sp)
 880:	6b02                	ld	s6,0(sp)
 882:	b7f5                	j	86e <malloc+0xe4>
