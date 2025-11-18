
user/_primes：     文件格式 elf64-littleriscv


Disassembly of section .text:

0000000000000000 <generate_nums>:
        exit(SUCCESS);
    }
}

void generate_nums(int nums[34])
{
   0:	1141                	addi	sp,sp,-16
   2:	e406                	sd	ra,8(sp)
   4:	e022                	sd	s0,0(sp)
   6:	0800                	addi	s0,sp,16
    int i = 0;
    for (int count = 2; count <= 35; count++)
   8:	4789                	li	a5,2
   a:	02400713          	li	a4,36
    {
        nums[i] = count;
   e:	c11c                	sw	a5,0(a0)
    for (int count = 2; count <= 35; count++)
  10:	2785                	addiw	a5,a5,1
  12:	0511                	addi	a0,a0,4
  14:	fee79de3          	bne	a5,a4,e <generate_nums+0xe>
        i++;
    }
}
  18:	60a2                	ld	ra,8(sp)
  1a:	6402                	ld	s0,0(sp)
  1c:	0141                	addi	sp,sp,16
  1e:	8082                	ret

0000000000000020 <check_pd>:

void check_pd(int pd[], int len)
{
  20:	7179                	addi	sp,sp,-48
  22:	f406                	sd	ra,40(sp)
  24:	f022                	sd	s0,32(sp)
  26:	e84a                	sd	s2,16(sp)
  28:	e44e                	sd	s3,8(sp)
  2a:	1800                	addi	s0,sp,48
  2c:	892a                	mv	s2,a0
  2e:	89ae                	mv	s3,a1
    printf("pd:\n");
  30:	00001517          	auipc	a0,0x1
  34:	99850513          	addi	a0,a0,-1640 # 9c8 <malloc+0xfe>
  38:	00000097          	auipc	ra,0x0
  3c:	7d6080e7          	jalr	2006(ra) # 80e <printf>
    for (int i = 0; i < len; i++)
  40:	03305463          	blez	s3,68 <check_pd+0x48>
  44:	ec26                	sd	s1,24(sp)
  46:	84ca                	mv	s1,s2
  48:	098a                	slli	s3,s3,0x2
  4a:	994e                	add	s2,s2,s3
    {
        printf("%d \n", pd[i]);
  4c:	00001997          	auipc	s3,0x1
  50:	98498993          	addi	s3,s3,-1660 # 9d0 <malloc+0x106>
  54:	408c                	lw	a1,0(s1)
  56:	854e                	mv	a0,s3
  58:	00000097          	auipc	ra,0x0
  5c:	7b6080e7          	jalr	1974(ra) # 80e <printf>
    for (int i = 0; i < len; i++)
  60:	0491                	addi	s1,s1,4
  62:	ff2499e3          	bne	s1,s2,54 <check_pd+0x34>
  66:	64e2                	ld	s1,24(sp)
    }
}
  68:	70a2                	ld	ra,40(sp)
  6a:	7402                	ld	s0,32(sp)
  6c:	6942                	ld	s2,16(sp)
  6e:	69a2                	ld	s3,8(sp)
  70:	6145                	addi	sp,sp,48
  72:	8082                	ret

0000000000000074 <send_primes>:

void send_primes(int pd[], int infos[], int infoslen)
{
  74:	715d                	addi	sp,sp,-80
  76:	e486                	sd	ra,72(sp)
  78:	e0a2                	sd	s0,64(sp)
  7a:	f84a                	sd	s2,48(sp)
  7c:	f44e                	sd	s3,40(sp)
  7e:	f052                	sd	s4,32(sp)
  80:	0880                	addi	s0,sp,80
  82:	89aa                	mv	s3,a0
  84:	892e                	mv	s2,a1
  86:	8a32                	mv	s4,a2
    int info;
    close(pd[0]);
  88:	4108                	lw	a0,0(a0)
  8a:	00000097          	auipc	ra,0x0
  8e:	43e080e7          	jalr	1086(ra) # 4c8 <close>
    for (int i = 0; i < infoslen; i++)
  92:	03405a63          	blez	s4,c6 <send_primes+0x52>
  96:	fc26                	sd	s1,56(sp)
  98:	ec56                	sd	s5,24(sp)
  9a:	84ca                	mv	s1,s2
  9c:	0a0a                	slli	s4,s4,0x2
  9e:	9952                	add	s2,s2,s4
    {
        info = infos[i];
        write(pd[1], &info, sizeof(info));
  a0:	fbc40a93          	addi	s5,s0,-68
  a4:	4a11                	li	s4,4
        info = infos[i];
  a6:	409c                	lw	a5,0(s1)
  a8:	faf42e23          	sw	a5,-68(s0)
        write(pd[1], &info, sizeof(info));
  ac:	8652                	mv	a2,s4
  ae:	85d6                	mv	a1,s5
  b0:	0049a503          	lw	a0,4(s3)
  b4:	00000097          	auipc	ra,0x0
  b8:	40c080e7          	jalr	1036(ra) # 4c0 <write>
    for (int i = 0; i < infoslen; i++)
  bc:	0491                	addi	s1,s1,4
  be:	ff2494e3          	bne	s1,s2,a6 <send_primes+0x32>
  c2:	74e2                	ld	s1,56(sp)
  c4:	6ae2                	ld	s5,24(sp)
    }
}
  c6:	60a6                	ld	ra,72(sp)
  c8:	6406                	ld	s0,64(sp)
  ca:	7942                	ld	s2,48(sp)
  cc:	79a2                	ld	s3,40(sp)
  ce:	7a02                	ld	s4,32(sp)
  d0:	6161                	addi	sp,sp,80
  d2:	8082                	ret

00000000000000d4 <process>:
{
  d4:	7115                	addi	sp,sp,-224
  d6:	ed86                	sd	ra,216(sp)
  d8:	e9a2                	sd	s0,208(sp)
  da:	e5a6                	sd	s1,200(sp)
  dc:	e1ca                	sd	s2,192(sp)
  de:	fd4e                	sd	s3,184(sp)
  e0:	f952                	sd	s4,176(sp)
  e2:	f556                	sd	s5,168(sp)
  e4:	1180                	addi	s0,sp,224
  e6:	892a                	mv	s2,a0
    pipe(pd_child);
  e8:	fb040513          	addi	a0,s0,-80
  ec:	00000097          	auipc	ra,0x0
  f0:	3c4080e7          	jalr	964(ra) # 4b0 <pipe>
    close(pd[1]);
  f4:	00492503          	lw	a0,4(s2)
  f8:	00000097          	auipc	ra,0x0
  fc:	3d0080e7          	jalr	976(ra) # 4c8 <close>
    len = read(pd[0], &p, sizeof(p));
 100:	4611                	li	a2,4
 102:	fbc40593          	addi	a1,s0,-68
 106:	00092503          	lw	a0,0(s2)
 10a:	00000097          	auipc	ra,0x0
 10e:	3ae080e7          	jalr	942(ra) # 4b8 <read>
 112:	84aa                	mv	s1,a0
    printf("prime %d\n", p);
 114:	fbc42583          	lw	a1,-68(s0)
 118:	00001517          	auipc	a0,0x1
 11c:	8c050513          	addi	a0,a0,-1856 # 9d8 <malloc+0x10e>
 120:	00000097          	auipc	ra,0x0
 124:	6ee080e7          	jalr	1774(ra) # 80e <printf>
    while (len != 0)
 128:	ccb5                	beqz	s1,1a4 <process+0xd0>
    int infos_i = 0;
 12a:	4481                	li	s1,0
        len = read(pd[0], &n, sizeof(n));
 12c:	fb840a13          	addi	s4,s0,-72
 130:	4991                	li	s3,4
            *(infos + infos_i) = n;
 132:	f2840a93          	addi	s5,s0,-216
 136:	a011                	j	13a <process+0x66>
    while (len != 0)
 138:	c515                	beqz	a0,164 <process+0x90>
        len = read(pd[0], &n, sizeof(n));
 13a:	864e                	mv	a2,s3
 13c:	85d2                	mv	a1,s4
 13e:	00092503          	lw	a0,0(s2)
 142:	00000097          	auipc	ra,0x0
 146:	376080e7          	jalr	886(ra) # 4b8 <read>
        if (n % p != 0)
 14a:	fb842703          	lw	a4,-72(s0)
 14e:	fbc42783          	lw	a5,-68(s0)
 152:	02f767bb          	remw	a5,a4,a5
 156:	d3ed                	beqz	a5,138 <process+0x64>
            *(infos + infos_i) = n;
 158:	00249793          	slli	a5,s1,0x2
 15c:	97d6                	add	a5,a5,s5
 15e:	c398                	sw	a4,0(a5)
            infos_i++;
 160:	2485                	addiw	s1,s1,1
 162:	bfd9                	j	138 <process+0x64>
    close(pd[0]);
 164:	00092503          	lw	a0,0(s2)
 168:	00000097          	auipc	ra,0x0
 16c:	360080e7          	jalr	864(ra) # 4c8 <close>
    if (infos_i == 0)
 170:	c0a1                	beqz	s1,1b0 <process+0xdc>
    if ((pid = fork()) == 0)
 172:	00000097          	auipc	ra,0x0
 176:	326080e7          	jalr	806(ra) # 498 <fork>
 17a:	e519                	bnez	a0,188 <process+0xb4>
        process(pd_child);
 17c:	fb040513          	addi	a0,s0,-80
 180:	00000097          	auipc	ra,0x0
 184:	f54080e7          	jalr	-172(ra) # d4 <process>
        send_primes(pd_child, infos, infos_i);
 188:	8626                	mv	a2,s1
 18a:	f2840593          	addi	a1,s0,-216
 18e:	fb040513          	addi	a0,s0,-80
 192:	00000097          	auipc	ra,0x0
 196:	ee2080e7          	jalr	-286(ra) # 74 <send_primes>
        exit(SUCCESS);
 19a:	4501                	li	a0,0
 19c:	00000097          	auipc	ra,0x0
 1a0:	304080e7          	jalr	772(ra) # 4a0 <exit>
    close(pd[0]);
 1a4:	00092503          	lw	a0,0(s2)
 1a8:	00000097          	auipc	ra,0x0
 1ac:	320080e7          	jalr	800(ra) # 4c8 <close>
        exit(SUCCESS);
 1b0:	4501                	li	a0,0
 1b2:	00000097          	auipc	ra,0x0
 1b6:	2ee080e7          	jalr	750(ra) # 4a0 <exit>

00000000000001ba <main>:
{
 1ba:	7171                	addi	sp,sp,-176
 1bc:	f506                	sd	ra,168(sp)
 1be:	f122                	sd	s0,160(sp)
 1c0:	1900                	addi	s0,sp,176
    pipe(pd);
 1c2:	fd840513          	addi	a0,s0,-40
 1c6:	00000097          	auipc	ra,0x0
 1ca:	2ea080e7          	jalr	746(ra) # 4b0 <pipe>
    if ((pid = fork()) == 0)
 1ce:	00000097          	auipc	ra,0x0
 1d2:	2ca080e7          	jalr	714(ra) # 498 <fork>
 1d6:	e901                	bnez	a0,1e6 <main+0x2c>
 1d8:	ed26                	sd	s1,152(sp)
        process(pd);
 1da:	fd840513          	addi	a0,s0,-40
 1de:	00000097          	auipc	ra,0x0
 1e2:	ef6080e7          	jalr	-266(ra) # d4 <process>
 1e6:	ed26                	sd	s1,152(sp)
        generate_nums(nums);
 1e8:	f5040493          	addi	s1,s0,-176
 1ec:	8526                	mv	a0,s1
 1ee:	00000097          	auipc	ra,0x0
 1f2:	e12080e7          	jalr	-494(ra) # 0 <generate_nums>
        send_primes(pd, nums, 34);
 1f6:	02200613          	li	a2,34
 1fa:	85a6                	mv	a1,s1
 1fc:	fd840513          	addi	a0,s0,-40
 200:	00000097          	auipc	ra,0x0
 204:	e74080e7          	jalr	-396(ra) # 74 <send_primes>
        exit(SUCCESS);
 208:	4501                	li	a0,0
 20a:	00000097          	auipc	ra,0x0
 20e:	296080e7          	jalr	662(ra) # 4a0 <exit>

0000000000000212 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 212:	1141                	addi	sp,sp,-16
 214:	e406                	sd	ra,8(sp)
 216:	e022                	sd	s0,0(sp)
 218:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 21a:	87aa                	mv	a5,a0
 21c:	0585                	addi	a1,a1,1
 21e:	0785                	addi	a5,a5,1
 220:	fff5c703          	lbu	a4,-1(a1)
 224:	fee78fa3          	sb	a4,-1(a5)
 228:	fb75                	bnez	a4,21c <strcpy+0xa>
    ;
  return os;
}
 22a:	60a2                	ld	ra,8(sp)
 22c:	6402                	ld	s0,0(sp)
 22e:	0141                	addi	sp,sp,16
 230:	8082                	ret

0000000000000232 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 232:	1141                	addi	sp,sp,-16
 234:	e406                	sd	ra,8(sp)
 236:	e022                	sd	s0,0(sp)
 238:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 23a:	00054783          	lbu	a5,0(a0)
 23e:	cb91                	beqz	a5,252 <strcmp+0x20>
 240:	0005c703          	lbu	a4,0(a1)
 244:	00f71763          	bne	a4,a5,252 <strcmp+0x20>
    p++, q++;
 248:	0505                	addi	a0,a0,1
 24a:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 24c:	00054783          	lbu	a5,0(a0)
 250:	fbe5                	bnez	a5,240 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 252:	0005c503          	lbu	a0,0(a1)
}
 256:	40a7853b          	subw	a0,a5,a0
 25a:	60a2                	ld	ra,8(sp)
 25c:	6402                	ld	s0,0(sp)
 25e:	0141                	addi	sp,sp,16
 260:	8082                	ret

0000000000000262 <strlen>:

uint
strlen(const char *s)
{
 262:	1141                	addi	sp,sp,-16
 264:	e406                	sd	ra,8(sp)
 266:	e022                	sd	s0,0(sp)
 268:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 26a:	00054783          	lbu	a5,0(a0)
 26e:	cf91                	beqz	a5,28a <strlen+0x28>
 270:	00150793          	addi	a5,a0,1
 274:	86be                	mv	a3,a5
 276:	0785                	addi	a5,a5,1
 278:	fff7c703          	lbu	a4,-1(a5)
 27c:	ff65                	bnez	a4,274 <strlen+0x12>
 27e:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
 282:	60a2                	ld	ra,8(sp)
 284:	6402                	ld	s0,0(sp)
 286:	0141                	addi	sp,sp,16
 288:	8082                	ret
  for(n = 0; s[n]; n++)
 28a:	4501                	li	a0,0
 28c:	bfdd                	j	282 <strlen+0x20>

000000000000028e <memset>:

void*
memset(void *dst, int c, uint n)
{
 28e:	1141                	addi	sp,sp,-16
 290:	e406                	sd	ra,8(sp)
 292:	e022                	sd	s0,0(sp)
 294:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 296:	ca19                	beqz	a2,2ac <memset+0x1e>
 298:	87aa                	mv	a5,a0
 29a:	1602                	slli	a2,a2,0x20
 29c:	9201                	srli	a2,a2,0x20
 29e:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 2a2:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 2a6:	0785                	addi	a5,a5,1
 2a8:	fee79de3          	bne	a5,a4,2a2 <memset+0x14>
  }
  return dst;
}
 2ac:	60a2                	ld	ra,8(sp)
 2ae:	6402                	ld	s0,0(sp)
 2b0:	0141                	addi	sp,sp,16
 2b2:	8082                	ret

00000000000002b4 <strchr>:

char*
strchr(const char *s, char c)
{
 2b4:	1141                	addi	sp,sp,-16
 2b6:	e406                	sd	ra,8(sp)
 2b8:	e022                	sd	s0,0(sp)
 2ba:	0800                	addi	s0,sp,16
  for(; *s; s++)
 2bc:	00054783          	lbu	a5,0(a0)
 2c0:	cf81                	beqz	a5,2d8 <strchr+0x24>
    if(*s == c)
 2c2:	00f58763          	beq	a1,a5,2d0 <strchr+0x1c>
  for(; *s; s++)
 2c6:	0505                	addi	a0,a0,1
 2c8:	00054783          	lbu	a5,0(a0)
 2cc:	fbfd                	bnez	a5,2c2 <strchr+0xe>
      return (char*)s;
  return 0;
 2ce:	4501                	li	a0,0
}
 2d0:	60a2                	ld	ra,8(sp)
 2d2:	6402                	ld	s0,0(sp)
 2d4:	0141                	addi	sp,sp,16
 2d6:	8082                	ret
  return 0;
 2d8:	4501                	li	a0,0
 2da:	bfdd                	j	2d0 <strchr+0x1c>

00000000000002dc <gets>:

char*
gets(char *buf, int max)
{
 2dc:	711d                	addi	sp,sp,-96
 2de:	ec86                	sd	ra,88(sp)
 2e0:	e8a2                	sd	s0,80(sp)
 2e2:	e4a6                	sd	s1,72(sp)
 2e4:	e0ca                	sd	s2,64(sp)
 2e6:	fc4e                	sd	s3,56(sp)
 2e8:	f852                	sd	s4,48(sp)
 2ea:	f456                	sd	s5,40(sp)
 2ec:	f05a                	sd	s6,32(sp)
 2ee:	ec5e                	sd	s7,24(sp)
 2f0:	e862                	sd	s8,16(sp)
 2f2:	1080                	addi	s0,sp,96
 2f4:	8baa                	mv	s7,a0
 2f6:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2f8:	892a                	mv	s2,a0
 2fa:	4481                	li	s1,0
    cc = read(0, &c, 1);
 2fc:	faf40b13          	addi	s6,s0,-81
 300:	4a85                	li	s5,1
  for(i=0; i+1 < max; ){
 302:	8c26                	mv	s8,s1
 304:	0014899b          	addiw	s3,s1,1
 308:	84ce                	mv	s1,s3
 30a:	0349d663          	bge	s3,s4,336 <gets+0x5a>
    cc = read(0, &c, 1);
 30e:	8656                	mv	a2,s5
 310:	85da                	mv	a1,s6
 312:	4501                	li	a0,0
 314:	00000097          	auipc	ra,0x0
 318:	1a4080e7          	jalr	420(ra) # 4b8 <read>
    if(cc < 1)
 31c:	00a05d63          	blez	a0,336 <gets+0x5a>
      break;
    buf[i++] = c;
 320:	faf44783          	lbu	a5,-81(s0)
 324:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 328:	0905                	addi	s2,s2,1
 32a:	ff678713          	addi	a4,a5,-10
 32e:	c319                	beqz	a4,334 <gets+0x58>
 330:	17cd                	addi	a5,a5,-13
 332:	fbe1                	bnez	a5,302 <gets+0x26>
    buf[i++] = c;
 334:	8c4e                	mv	s8,s3
      break;
  }
  buf[i] = '\0';
 336:	9c5e                	add	s8,s8,s7
 338:	000c0023          	sb	zero,0(s8)
  return buf;
}
 33c:	855e                	mv	a0,s7
 33e:	60e6                	ld	ra,88(sp)
 340:	6446                	ld	s0,80(sp)
 342:	64a6                	ld	s1,72(sp)
 344:	6906                	ld	s2,64(sp)
 346:	79e2                	ld	s3,56(sp)
 348:	7a42                	ld	s4,48(sp)
 34a:	7aa2                	ld	s5,40(sp)
 34c:	7b02                	ld	s6,32(sp)
 34e:	6be2                	ld	s7,24(sp)
 350:	6c42                	ld	s8,16(sp)
 352:	6125                	addi	sp,sp,96
 354:	8082                	ret

0000000000000356 <stat>:

int
stat(const char *n, struct stat *st)
{
 356:	1101                	addi	sp,sp,-32
 358:	ec06                	sd	ra,24(sp)
 35a:	e822                	sd	s0,16(sp)
 35c:	e04a                	sd	s2,0(sp)
 35e:	1000                	addi	s0,sp,32
 360:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 362:	4581                	li	a1,0
 364:	00000097          	auipc	ra,0x0
 368:	17c080e7          	jalr	380(ra) # 4e0 <open>
  if(fd < 0)
 36c:	02054663          	bltz	a0,398 <stat+0x42>
 370:	e426                	sd	s1,8(sp)
 372:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 374:	85ca                	mv	a1,s2
 376:	00000097          	auipc	ra,0x0
 37a:	182080e7          	jalr	386(ra) # 4f8 <fstat>
 37e:	892a                	mv	s2,a0
  close(fd);
 380:	8526                	mv	a0,s1
 382:	00000097          	auipc	ra,0x0
 386:	146080e7          	jalr	326(ra) # 4c8 <close>
  return r;
 38a:	64a2                	ld	s1,8(sp)
}
 38c:	854a                	mv	a0,s2
 38e:	60e2                	ld	ra,24(sp)
 390:	6442                	ld	s0,16(sp)
 392:	6902                	ld	s2,0(sp)
 394:	6105                	addi	sp,sp,32
 396:	8082                	ret
    return -1;
 398:	57fd                	li	a5,-1
 39a:	893e                	mv	s2,a5
 39c:	bfc5                	j	38c <stat+0x36>

000000000000039e <atoi>:

int
atoi(const char *s)
{
 39e:	1141                	addi	sp,sp,-16
 3a0:	e406                	sd	ra,8(sp)
 3a2:	e022                	sd	s0,0(sp)
 3a4:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3a6:	00054683          	lbu	a3,0(a0)
 3aa:	fd06879b          	addiw	a5,a3,-48
 3ae:	0ff7f793          	zext.b	a5,a5
 3b2:	4625                	li	a2,9
 3b4:	02f66963          	bltu	a2,a5,3e6 <atoi+0x48>
 3b8:	872a                	mv	a4,a0
  n = 0;
 3ba:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 3bc:	0705                	addi	a4,a4,1
 3be:	0025179b          	slliw	a5,a0,0x2
 3c2:	9fa9                	addw	a5,a5,a0
 3c4:	0017979b          	slliw	a5,a5,0x1
 3c8:	9fb5                	addw	a5,a5,a3
 3ca:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 3ce:	00074683          	lbu	a3,0(a4)
 3d2:	fd06879b          	addiw	a5,a3,-48
 3d6:	0ff7f793          	zext.b	a5,a5
 3da:	fef671e3          	bgeu	a2,a5,3bc <atoi+0x1e>
  return n;
}
 3de:	60a2                	ld	ra,8(sp)
 3e0:	6402                	ld	s0,0(sp)
 3e2:	0141                	addi	sp,sp,16
 3e4:	8082                	ret
  n = 0;
 3e6:	4501                	li	a0,0
 3e8:	bfdd                	j	3de <atoi+0x40>

00000000000003ea <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3ea:	1141                	addi	sp,sp,-16
 3ec:	e406                	sd	ra,8(sp)
 3ee:	e022                	sd	s0,0(sp)
 3f0:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 3f2:	02b57563          	bgeu	a0,a1,41c <memmove+0x32>
    while(n-- > 0)
 3f6:	00c05f63          	blez	a2,414 <memmove+0x2a>
 3fa:	1602                	slli	a2,a2,0x20
 3fc:	9201                	srli	a2,a2,0x20
 3fe:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 402:	872a                	mv	a4,a0
      *dst++ = *src++;
 404:	0585                	addi	a1,a1,1
 406:	0705                	addi	a4,a4,1
 408:	fff5c683          	lbu	a3,-1(a1)
 40c:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 410:	fee79ae3          	bne	a5,a4,404 <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 414:	60a2                	ld	ra,8(sp)
 416:	6402                	ld	s0,0(sp)
 418:	0141                	addi	sp,sp,16
 41a:	8082                	ret
    while(n-- > 0)
 41c:	fec05ce3          	blez	a2,414 <memmove+0x2a>
    dst += n;
 420:	00c50733          	add	a4,a0,a2
    src += n;
 424:	95b2                	add	a1,a1,a2
 426:	fff6079b          	addiw	a5,a2,-1
 42a:	1782                	slli	a5,a5,0x20
 42c:	9381                	srli	a5,a5,0x20
 42e:	fff7c793          	not	a5,a5
 432:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 434:	15fd                	addi	a1,a1,-1
 436:	177d                	addi	a4,a4,-1
 438:	0005c683          	lbu	a3,0(a1)
 43c:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 440:	fef71ae3          	bne	a4,a5,434 <memmove+0x4a>
 444:	bfc1                	j	414 <memmove+0x2a>

0000000000000446 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 446:	1141                	addi	sp,sp,-16
 448:	e406                	sd	ra,8(sp)
 44a:	e022                	sd	s0,0(sp)
 44c:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 44e:	c61d                	beqz	a2,47c <memcmp+0x36>
 450:	1602                	slli	a2,a2,0x20
 452:	9201                	srli	a2,a2,0x20
 454:	00c506b3          	add	a3,a0,a2
    if (*p1 != *p2) {
 458:	00054783          	lbu	a5,0(a0)
 45c:	0005c703          	lbu	a4,0(a1)
 460:	00e79863          	bne	a5,a4,470 <memcmp+0x2a>
      return *p1 - *p2;
    }
    p1++;
 464:	0505                	addi	a0,a0,1
    p2++;
 466:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 468:	fed518e3          	bne	a0,a3,458 <memcmp+0x12>
  }
  return 0;
 46c:	4501                	li	a0,0
 46e:	a019                	j	474 <memcmp+0x2e>
      return *p1 - *p2;
 470:	40e7853b          	subw	a0,a5,a4
}
 474:	60a2                	ld	ra,8(sp)
 476:	6402                	ld	s0,0(sp)
 478:	0141                	addi	sp,sp,16
 47a:	8082                	ret
  return 0;
 47c:	4501                	li	a0,0
 47e:	bfdd                	j	474 <memcmp+0x2e>

0000000000000480 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 480:	1141                	addi	sp,sp,-16
 482:	e406                	sd	ra,8(sp)
 484:	e022                	sd	s0,0(sp)
 486:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 488:	00000097          	auipc	ra,0x0
 48c:	f62080e7          	jalr	-158(ra) # 3ea <memmove>
}
 490:	60a2                	ld	ra,8(sp)
 492:	6402                	ld	s0,0(sp)
 494:	0141                	addi	sp,sp,16
 496:	8082                	ret

0000000000000498 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 498:	4885                	li	a7,1
 ecall
 49a:	00000073          	ecall
 ret
 49e:	8082                	ret

00000000000004a0 <exit>:
.global exit
exit:
 li a7, SYS_exit
 4a0:	4889                	li	a7,2
 ecall
 4a2:	00000073          	ecall
 ret
 4a6:	8082                	ret

00000000000004a8 <wait>:
.global wait
wait:
 li a7, SYS_wait
 4a8:	488d                	li	a7,3
 ecall
 4aa:	00000073          	ecall
 ret
 4ae:	8082                	ret

00000000000004b0 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 4b0:	4891                	li	a7,4
 ecall
 4b2:	00000073          	ecall
 ret
 4b6:	8082                	ret

00000000000004b8 <read>:
.global read
read:
 li a7, SYS_read
 4b8:	4895                	li	a7,5
 ecall
 4ba:	00000073          	ecall
 ret
 4be:	8082                	ret

00000000000004c0 <write>:
.global write
write:
 li a7, SYS_write
 4c0:	48c1                	li	a7,16
 ecall
 4c2:	00000073          	ecall
 ret
 4c6:	8082                	ret

00000000000004c8 <close>:
.global close
close:
 li a7, SYS_close
 4c8:	48d5                	li	a7,21
 ecall
 4ca:	00000073          	ecall
 ret
 4ce:	8082                	ret

00000000000004d0 <kill>:
.global kill
kill:
 li a7, SYS_kill
 4d0:	4899                	li	a7,6
 ecall
 4d2:	00000073          	ecall
 ret
 4d6:	8082                	ret

00000000000004d8 <exec>:
.global exec
exec:
 li a7, SYS_exec
 4d8:	489d                	li	a7,7
 ecall
 4da:	00000073          	ecall
 ret
 4de:	8082                	ret

00000000000004e0 <open>:
.global open
open:
 li a7, SYS_open
 4e0:	48bd                	li	a7,15
 ecall
 4e2:	00000073          	ecall
 ret
 4e6:	8082                	ret

00000000000004e8 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 4e8:	48c5                	li	a7,17
 ecall
 4ea:	00000073          	ecall
 ret
 4ee:	8082                	ret

00000000000004f0 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 4f0:	48c9                	li	a7,18
 ecall
 4f2:	00000073          	ecall
 ret
 4f6:	8082                	ret

00000000000004f8 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 4f8:	48a1                	li	a7,8
 ecall
 4fa:	00000073          	ecall
 ret
 4fe:	8082                	ret

0000000000000500 <link>:
.global link
link:
 li a7, SYS_link
 500:	48cd                	li	a7,19
 ecall
 502:	00000073          	ecall
 ret
 506:	8082                	ret

0000000000000508 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 508:	48d1                	li	a7,20
 ecall
 50a:	00000073          	ecall
 ret
 50e:	8082                	ret

0000000000000510 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 510:	48a5                	li	a7,9
 ecall
 512:	00000073          	ecall
 ret
 516:	8082                	ret

0000000000000518 <dup>:
.global dup
dup:
 li a7, SYS_dup
 518:	48a9                	li	a7,10
 ecall
 51a:	00000073          	ecall
 ret
 51e:	8082                	ret

0000000000000520 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 520:	48ad                	li	a7,11
 ecall
 522:	00000073          	ecall
 ret
 526:	8082                	ret

0000000000000528 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 528:	48b1                	li	a7,12
 ecall
 52a:	00000073          	ecall
 ret
 52e:	8082                	ret

0000000000000530 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 530:	48b5                	li	a7,13
 ecall
 532:	00000073          	ecall
 ret
 536:	8082                	ret

0000000000000538 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 538:	48b9                	li	a7,14
 ecall
 53a:	00000073          	ecall
 ret
 53e:	8082                	ret

0000000000000540 <ntas>:
.global ntas
ntas:
 li a7, SYS_ntas
 540:	48d9                	li	a7,22
 ecall
 542:	00000073          	ecall
 ret
 546:	8082                	ret

0000000000000548 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 548:	1101                	addi	sp,sp,-32
 54a:	ec06                	sd	ra,24(sp)
 54c:	e822                	sd	s0,16(sp)
 54e:	1000                	addi	s0,sp,32
 550:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 554:	4605                	li	a2,1
 556:	fef40593          	addi	a1,s0,-17
 55a:	00000097          	auipc	ra,0x0
 55e:	f66080e7          	jalr	-154(ra) # 4c0 <write>
}
 562:	60e2                	ld	ra,24(sp)
 564:	6442                	ld	s0,16(sp)
 566:	6105                	addi	sp,sp,32
 568:	8082                	ret

000000000000056a <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 56a:	7139                	addi	sp,sp,-64
 56c:	fc06                	sd	ra,56(sp)
 56e:	f822                	sd	s0,48(sp)
 570:	f04a                	sd	s2,32(sp)
 572:	ec4e                	sd	s3,24(sp)
 574:	0080                	addi	s0,sp,64
 576:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 578:	cad9                	beqz	a3,60e <printint+0xa4>
 57a:	01f5d79b          	srliw	a5,a1,0x1f
 57e:	cbc1                	beqz	a5,60e <printint+0xa4>
    neg = 1;
    x = -xx;
 580:	40b005bb          	negw	a1,a1
    neg = 1;
 584:	4305                	li	t1,1
  } else {
    x = xx;
  }

  i = 0;
 586:	fc040993          	addi	s3,s0,-64
  neg = 0;
 58a:	86ce                	mv	a3,s3
  i = 0;
 58c:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 58e:	00000817          	auipc	a6,0x0
 592:	4ba80813          	addi	a6,a6,1210 # a48 <digits>
 596:	88ba                	mv	a7,a4
 598:	0017051b          	addiw	a0,a4,1
 59c:	872a                	mv	a4,a0
 59e:	02c5f7bb          	remuw	a5,a1,a2
 5a2:	1782                	slli	a5,a5,0x20
 5a4:	9381                	srli	a5,a5,0x20
 5a6:	97c2                	add	a5,a5,a6
 5a8:	0007c783          	lbu	a5,0(a5)
 5ac:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 5b0:	87ae                	mv	a5,a1
 5b2:	02c5d5bb          	divuw	a1,a1,a2
 5b6:	0685                	addi	a3,a3,1
 5b8:	fcc7ffe3          	bgeu	a5,a2,596 <printint+0x2c>
  if(neg)
 5bc:	00030c63          	beqz	t1,5d4 <printint+0x6a>
    buf[i++] = '-';
 5c0:	fd050793          	addi	a5,a0,-48
 5c4:	00878533          	add	a0,a5,s0
 5c8:	02d00793          	li	a5,45
 5cc:	fef50823          	sb	a5,-16(a0)
 5d0:	0028871b          	addiw	a4,a7,2

  while(--i >= 0)
 5d4:	02e05763          	blez	a4,602 <printint+0x98>
 5d8:	f426                	sd	s1,40(sp)
 5da:	377d                	addiw	a4,a4,-1
 5dc:	00e984b3          	add	s1,s3,a4
 5e0:	19fd                	addi	s3,s3,-1
 5e2:	99ba                	add	s3,s3,a4
 5e4:	1702                	slli	a4,a4,0x20
 5e6:	9301                	srli	a4,a4,0x20
 5e8:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 5ec:	0004c583          	lbu	a1,0(s1)
 5f0:	854a                	mv	a0,s2
 5f2:	00000097          	auipc	ra,0x0
 5f6:	f56080e7          	jalr	-170(ra) # 548 <putc>
  while(--i >= 0)
 5fa:	14fd                	addi	s1,s1,-1
 5fc:	ff3498e3          	bne	s1,s3,5ec <printint+0x82>
 600:	74a2                	ld	s1,40(sp)
}
 602:	70e2                	ld	ra,56(sp)
 604:	7442                	ld	s0,48(sp)
 606:	7902                	ld	s2,32(sp)
 608:	69e2                	ld	s3,24(sp)
 60a:	6121                	addi	sp,sp,64
 60c:	8082                	ret
  neg = 0;
 60e:	4301                	li	t1,0
 610:	bf9d                	j	586 <printint+0x1c>

0000000000000612 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 612:	715d                	addi	sp,sp,-80
 614:	e486                	sd	ra,72(sp)
 616:	e0a2                	sd	s0,64(sp)
 618:	f84a                	sd	s2,48(sp)
 61a:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 61c:	0005c903          	lbu	s2,0(a1)
 620:	1a090b63          	beqz	s2,7d6 <vprintf+0x1c4>
 624:	fc26                	sd	s1,56(sp)
 626:	f44e                	sd	s3,40(sp)
 628:	f052                	sd	s4,32(sp)
 62a:	ec56                	sd	s5,24(sp)
 62c:	e85a                	sd	s6,16(sp)
 62e:	e45e                	sd	s7,8(sp)
 630:	8aaa                	mv	s5,a0
 632:	8bb2                	mv	s7,a2
 634:	00158493          	addi	s1,a1,1
  state = 0;
 638:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 63a:	02500a13          	li	s4,37
 63e:	4b55                	li	s6,21
 640:	a839                	j	65e <vprintf+0x4c>
        putc(fd, c);
 642:	85ca                	mv	a1,s2
 644:	8556                	mv	a0,s5
 646:	00000097          	auipc	ra,0x0
 64a:	f02080e7          	jalr	-254(ra) # 548 <putc>
 64e:	a019                	j	654 <vprintf+0x42>
    } else if(state == '%'){
 650:	01498d63          	beq	s3,s4,66a <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
 654:	0485                	addi	s1,s1,1
 656:	fff4c903          	lbu	s2,-1(s1)
 65a:	16090863          	beqz	s2,7ca <vprintf+0x1b8>
    if(state == 0){
 65e:	fe0999e3          	bnez	s3,650 <vprintf+0x3e>
      if(c == '%'){
 662:	ff4910e3          	bne	s2,s4,642 <vprintf+0x30>
        state = '%';
 666:	89d2                	mv	s3,s4
 668:	b7f5                	j	654 <vprintf+0x42>
      if(c == 'd'){
 66a:	13490563          	beq	s2,s4,794 <vprintf+0x182>
 66e:	f9d9079b          	addiw	a5,s2,-99
 672:	0ff7f793          	zext.b	a5,a5
 676:	12fb6863          	bltu	s6,a5,7a6 <vprintf+0x194>
 67a:	f9d9079b          	addiw	a5,s2,-99
 67e:	0ff7f713          	zext.b	a4,a5
 682:	12eb6263          	bltu	s6,a4,7a6 <vprintf+0x194>
 686:	00271793          	slli	a5,a4,0x2
 68a:	00000717          	auipc	a4,0x0
 68e:	36670713          	addi	a4,a4,870 # 9f0 <malloc+0x126>
 692:	97ba                	add	a5,a5,a4
 694:	439c                	lw	a5,0(a5)
 696:	97ba                	add	a5,a5,a4
 698:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 69a:	008b8913          	addi	s2,s7,8
 69e:	4685                	li	a3,1
 6a0:	4629                	li	a2,10
 6a2:	000ba583          	lw	a1,0(s7)
 6a6:	8556                	mv	a0,s5
 6a8:	00000097          	auipc	ra,0x0
 6ac:	ec2080e7          	jalr	-318(ra) # 56a <printint>
 6b0:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 6b2:	4981                	li	s3,0
 6b4:	b745                	j	654 <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6b6:	008b8913          	addi	s2,s7,8
 6ba:	4681                	li	a3,0
 6bc:	4629                	li	a2,10
 6be:	000ba583          	lw	a1,0(s7)
 6c2:	8556                	mv	a0,s5
 6c4:	00000097          	auipc	ra,0x0
 6c8:	ea6080e7          	jalr	-346(ra) # 56a <printint>
 6cc:	8bca                	mv	s7,s2
      state = 0;
 6ce:	4981                	li	s3,0
 6d0:	b751                	j	654 <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
 6d2:	008b8913          	addi	s2,s7,8
 6d6:	4681                	li	a3,0
 6d8:	4641                	li	a2,16
 6da:	000ba583          	lw	a1,0(s7)
 6de:	8556                	mv	a0,s5
 6e0:	00000097          	auipc	ra,0x0
 6e4:	e8a080e7          	jalr	-374(ra) # 56a <printint>
 6e8:	8bca                	mv	s7,s2
      state = 0;
 6ea:	4981                	li	s3,0
 6ec:	b7a5                	j	654 <vprintf+0x42>
 6ee:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
 6f0:	008b8793          	addi	a5,s7,8
 6f4:	8c3e                	mv	s8,a5
 6f6:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 6fa:	03000593          	li	a1,48
 6fe:	8556                	mv	a0,s5
 700:	00000097          	auipc	ra,0x0
 704:	e48080e7          	jalr	-440(ra) # 548 <putc>
  putc(fd, 'x');
 708:	07800593          	li	a1,120
 70c:	8556                	mv	a0,s5
 70e:	00000097          	auipc	ra,0x0
 712:	e3a080e7          	jalr	-454(ra) # 548 <putc>
 716:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 718:	00000b97          	auipc	s7,0x0
 71c:	330b8b93          	addi	s7,s7,816 # a48 <digits>
 720:	03c9d793          	srli	a5,s3,0x3c
 724:	97de                	add	a5,a5,s7
 726:	0007c583          	lbu	a1,0(a5)
 72a:	8556                	mv	a0,s5
 72c:	00000097          	auipc	ra,0x0
 730:	e1c080e7          	jalr	-484(ra) # 548 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 734:	0992                	slli	s3,s3,0x4
 736:	397d                	addiw	s2,s2,-1
 738:	fe0914e3          	bnez	s2,720 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
 73c:	8be2                	mv	s7,s8
      state = 0;
 73e:	4981                	li	s3,0
 740:	6c02                	ld	s8,0(sp)
 742:	bf09                	j	654 <vprintf+0x42>
        s = va_arg(ap, char*);
 744:	008b8993          	addi	s3,s7,8
 748:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 74c:	02090163          	beqz	s2,76e <vprintf+0x15c>
        while(*s != 0){
 750:	00094583          	lbu	a1,0(s2)
 754:	c9a5                	beqz	a1,7c4 <vprintf+0x1b2>
          putc(fd, *s);
 756:	8556                	mv	a0,s5
 758:	00000097          	auipc	ra,0x0
 75c:	df0080e7          	jalr	-528(ra) # 548 <putc>
          s++;
 760:	0905                	addi	s2,s2,1
        while(*s != 0){
 762:	00094583          	lbu	a1,0(s2)
 766:	f9e5                	bnez	a1,756 <vprintf+0x144>
        s = va_arg(ap, char*);
 768:	8bce                	mv	s7,s3
      state = 0;
 76a:	4981                	li	s3,0
 76c:	b5e5                	j	654 <vprintf+0x42>
          s = "(null)";
 76e:	00000917          	auipc	s2,0x0
 772:	27a90913          	addi	s2,s2,634 # 9e8 <malloc+0x11e>
        while(*s != 0){
 776:	02800593          	li	a1,40
 77a:	bff1                	j	756 <vprintf+0x144>
        putc(fd, va_arg(ap, uint));
 77c:	008b8913          	addi	s2,s7,8
 780:	000bc583          	lbu	a1,0(s7)
 784:	8556                	mv	a0,s5
 786:	00000097          	auipc	ra,0x0
 78a:	dc2080e7          	jalr	-574(ra) # 548 <putc>
 78e:	8bca                	mv	s7,s2
      state = 0;
 790:	4981                	li	s3,0
 792:	b5c9                	j	654 <vprintf+0x42>
        putc(fd, c);
 794:	02500593          	li	a1,37
 798:	8556                	mv	a0,s5
 79a:	00000097          	auipc	ra,0x0
 79e:	dae080e7          	jalr	-594(ra) # 548 <putc>
      state = 0;
 7a2:	4981                	li	s3,0
 7a4:	bd45                	j	654 <vprintf+0x42>
        putc(fd, '%');
 7a6:	02500593          	li	a1,37
 7aa:	8556                	mv	a0,s5
 7ac:	00000097          	auipc	ra,0x0
 7b0:	d9c080e7          	jalr	-612(ra) # 548 <putc>
        putc(fd, c);
 7b4:	85ca                	mv	a1,s2
 7b6:	8556                	mv	a0,s5
 7b8:	00000097          	auipc	ra,0x0
 7bc:	d90080e7          	jalr	-624(ra) # 548 <putc>
      state = 0;
 7c0:	4981                	li	s3,0
 7c2:	bd49                	j	654 <vprintf+0x42>
        s = va_arg(ap, char*);
 7c4:	8bce                	mv	s7,s3
      state = 0;
 7c6:	4981                	li	s3,0
 7c8:	b571                	j	654 <vprintf+0x42>
 7ca:	74e2                	ld	s1,56(sp)
 7cc:	79a2                	ld	s3,40(sp)
 7ce:	7a02                	ld	s4,32(sp)
 7d0:	6ae2                	ld	s5,24(sp)
 7d2:	6b42                	ld	s6,16(sp)
 7d4:	6ba2                	ld	s7,8(sp)
    }
  }
}
 7d6:	60a6                	ld	ra,72(sp)
 7d8:	6406                	ld	s0,64(sp)
 7da:	7942                	ld	s2,48(sp)
 7dc:	6161                	addi	sp,sp,80
 7de:	8082                	ret

00000000000007e0 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 7e0:	715d                	addi	sp,sp,-80
 7e2:	ec06                	sd	ra,24(sp)
 7e4:	e822                	sd	s0,16(sp)
 7e6:	1000                	addi	s0,sp,32
 7e8:	e010                	sd	a2,0(s0)
 7ea:	e414                	sd	a3,8(s0)
 7ec:	e818                	sd	a4,16(s0)
 7ee:	ec1c                	sd	a5,24(s0)
 7f0:	03043023          	sd	a6,32(s0)
 7f4:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 7f8:	8622                	mv	a2,s0
 7fa:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 7fe:	00000097          	auipc	ra,0x0
 802:	e14080e7          	jalr	-492(ra) # 612 <vprintf>
}
 806:	60e2                	ld	ra,24(sp)
 808:	6442                	ld	s0,16(sp)
 80a:	6161                	addi	sp,sp,80
 80c:	8082                	ret

000000000000080e <printf>:

void
printf(const char *fmt, ...)
{
 80e:	711d                	addi	sp,sp,-96
 810:	ec06                	sd	ra,24(sp)
 812:	e822                	sd	s0,16(sp)
 814:	1000                	addi	s0,sp,32
 816:	e40c                	sd	a1,8(s0)
 818:	e810                	sd	a2,16(s0)
 81a:	ec14                	sd	a3,24(s0)
 81c:	f018                	sd	a4,32(s0)
 81e:	f41c                	sd	a5,40(s0)
 820:	03043823          	sd	a6,48(s0)
 824:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 828:	00840613          	addi	a2,s0,8
 82c:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 830:	85aa                	mv	a1,a0
 832:	4505                	li	a0,1
 834:	00000097          	auipc	ra,0x0
 838:	dde080e7          	jalr	-546(ra) # 612 <vprintf>
}
 83c:	60e2                	ld	ra,24(sp)
 83e:	6442                	ld	s0,16(sp)
 840:	6125                	addi	sp,sp,96
 842:	8082                	ret

0000000000000844 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 844:	1141                	addi	sp,sp,-16
 846:	e406                	sd	ra,8(sp)
 848:	e022                	sd	s0,0(sp)
 84a:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 84c:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 850:	00000797          	auipc	a5,0x0
 854:	2107b783          	ld	a5,528(a5) # a60 <freep>
 858:	a039                	j	866 <free+0x22>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 85a:	6398                	ld	a4,0(a5)
 85c:	00e7e463          	bltu	a5,a4,864 <free+0x20>
 860:	00e6ea63          	bltu	a3,a4,874 <free+0x30>
{
 864:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 866:	fed7fae3          	bgeu	a5,a3,85a <free+0x16>
 86a:	6398                	ld	a4,0(a5)
 86c:	00e6e463          	bltu	a3,a4,874 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 870:	fee7eae3          	bltu	a5,a4,864 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 874:	ff852583          	lw	a1,-8(a0)
 878:	6390                	ld	a2,0(a5)
 87a:	02059813          	slli	a6,a1,0x20
 87e:	01c85713          	srli	a4,a6,0x1c
 882:	9736                	add	a4,a4,a3
 884:	02e60563          	beq	a2,a4,8ae <free+0x6a>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 888:	fec53823          	sd	a2,-16(a0)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 88c:	4790                	lw	a2,8(a5)
 88e:	02061593          	slli	a1,a2,0x20
 892:	01c5d713          	srli	a4,a1,0x1c
 896:	973e                	add	a4,a4,a5
 898:	02e68263          	beq	a3,a4,8bc <free+0x78>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 89c:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 89e:	00000717          	auipc	a4,0x0
 8a2:	1cf73123          	sd	a5,450(a4) # a60 <freep>
}
 8a6:	60a2                	ld	ra,8(sp)
 8a8:	6402                	ld	s0,0(sp)
 8aa:	0141                	addi	sp,sp,16
 8ac:	8082                	ret
    bp->s.size += p->s.ptr->s.size;
 8ae:	4618                	lw	a4,8(a2)
 8b0:	9f2d                	addw	a4,a4,a1
 8b2:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 8b6:	6398                	ld	a4,0(a5)
 8b8:	6310                	ld	a2,0(a4)
 8ba:	b7f9                	j	888 <free+0x44>
    p->s.size += bp->s.size;
 8bc:	ff852703          	lw	a4,-8(a0)
 8c0:	9f31                	addw	a4,a4,a2
 8c2:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 8c4:	ff053683          	ld	a3,-16(a0)
 8c8:	bfd1                	j	89c <free+0x58>

00000000000008ca <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8ca:	7139                	addi	sp,sp,-64
 8cc:	fc06                	sd	ra,56(sp)
 8ce:	f822                	sd	s0,48(sp)
 8d0:	f04a                	sd	s2,32(sp)
 8d2:	ec4e                	sd	s3,24(sp)
 8d4:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8d6:	02051993          	slli	s3,a0,0x20
 8da:	0209d993          	srli	s3,s3,0x20
 8de:	09bd                	addi	s3,s3,15
 8e0:	0049d993          	srli	s3,s3,0x4
 8e4:	2985                	addiw	s3,s3,1
 8e6:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 8e8:	00000517          	auipc	a0,0x0
 8ec:	17853503          	ld	a0,376(a0) # a60 <freep>
 8f0:	c905                	beqz	a0,920 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8f2:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8f4:	4798                	lw	a4,8(a5)
 8f6:	09377a63          	bgeu	a4,s3,98a <malloc+0xc0>
 8fa:	f426                	sd	s1,40(sp)
 8fc:	e852                	sd	s4,16(sp)
 8fe:	e456                	sd	s5,8(sp)
 900:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 902:	8a4e                	mv	s4,s3
 904:	6705                	lui	a4,0x1
 906:	00e9f363          	bgeu	s3,a4,90c <malloc+0x42>
 90a:	6a05                	lui	s4,0x1
 90c:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 910:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 914:	00000497          	auipc	s1,0x0
 918:	14c48493          	addi	s1,s1,332 # a60 <freep>
  if(p == (char*)-1)
 91c:	5afd                	li	s5,-1
 91e:	a089                	j	960 <malloc+0x96>
 920:	f426                	sd	s1,40(sp)
 922:	e852                	sd	s4,16(sp)
 924:	e456                	sd	s5,8(sp)
 926:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 928:	00000797          	auipc	a5,0x0
 92c:	14078793          	addi	a5,a5,320 # a68 <base>
 930:	00000717          	auipc	a4,0x0
 934:	12f73823          	sd	a5,304(a4) # a60 <freep>
 938:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 93a:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 93e:	b7d1                	j	902 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 940:	6398                	ld	a4,0(a5)
 942:	e118                	sd	a4,0(a0)
 944:	a8b9                	j	9a2 <malloc+0xd8>
  hp->s.size = nu;
 946:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 94a:	0541                	addi	a0,a0,16
 94c:	00000097          	auipc	ra,0x0
 950:	ef8080e7          	jalr	-264(ra) # 844 <free>
  return freep;
 954:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 956:	c135                	beqz	a0,9ba <malloc+0xf0>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 958:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 95a:	4798                	lw	a4,8(a5)
 95c:	03277363          	bgeu	a4,s2,982 <malloc+0xb8>
    if(p == freep)
 960:	6098                	ld	a4,0(s1)
 962:	853e                	mv	a0,a5
 964:	fef71ae3          	bne	a4,a5,958 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 968:	8552                	mv	a0,s4
 96a:	00000097          	auipc	ra,0x0
 96e:	bbe080e7          	jalr	-1090(ra) # 528 <sbrk>
  if(p == (char*)-1)
 972:	fd551ae3          	bne	a0,s5,946 <malloc+0x7c>
        return 0;
 976:	4501                	li	a0,0
 978:	74a2                	ld	s1,40(sp)
 97a:	6a42                	ld	s4,16(sp)
 97c:	6aa2                	ld	s5,8(sp)
 97e:	6b02                	ld	s6,0(sp)
 980:	a03d                	j	9ae <malloc+0xe4>
 982:	74a2                	ld	s1,40(sp)
 984:	6a42                	ld	s4,16(sp)
 986:	6aa2                	ld	s5,8(sp)
 988:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 98a:	fae90be3          	beq	s2,a4,940 <malloc+0x76>
        p->s.size -= nunits;
 98e:	4137073b          	subw	a4,a4,s3
 992:	c798                	sw	a4,8(a5)
        p += p->s.size;
 994:	02071693          	slli	a3,a4,0x20
 998:	01c6d713          	srli	a4,a3,0x1c
 99c:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 99e:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 9a2:	00000717          	auipc	a4,0x0
 9a6:	0aa73f23          	sd	a0,190(a4) # a60 <freep>
      return (void*)(p + 1);
 9aa:	01078513          	addi	a0,a5,16
  }
}
 9ae:	70e2                	ld	ra,56(sp)
 9b0:	7442                	ld	s0,48(sp)
 9b2:	7902                	ld	s2,32(sp)
 9b4:	69e2                	ld	s3,24(sp)
 9b6:	6121                	addi	sp,sp,64
 9b8:	8082                	ret
 9ba:	74a2                	ld	s1,40(sp)
 9bc:	6a42                	ld	s4,16(sp)
 9be:	6aa2                	ld	s5,8(sp)
 9c0:	6b02                	ld	s6,0(sp)
 9c2:	b7f5                	j	9ae <malloc+0xe4>
