
user/_cowtest：     文件格式 elf64-littleriscv


Disassembly of section .text:

0000000000000000 <simpletest>:
// allocate more than half of physical memory,
// then fork. this will fail in the default
// kernel, which does not support copy-on-write.
void
simpletest()
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	1800                	addi	s0,sp,48
  uint64 phys_size = PHYSTOP - KERNBASE;
  int sz = (phys_size / 3) * 2;

  printf("simple: ");
   e:	00001517          	auipc	a0,0x1
  12:	c8250513          	addi	a0,a0,-894 # c90 <malloc+0xfc>
  16:	00001097          	auipc	ra,0x1
  1a:	ac2080e7          	jalr	-1342(ra) # ad8 <printf>
  
  char *p = sbrk(sz);
  1e:	05555537          	lui	a0,0x5555
  22:	55450513          	addi	a0,a0,1364 # 5555554 <__BSS_END__+0x55506fc>
  26:	00000097          	auipc	ra,0x0
  2a:	7cc080e7          	jalr	1996(ra) # 7f2 <sbrk>
  if(p == (char*)0xffffffffffffffffL){
  2e:	57fd                	li	a5,-1
  30:	06f50563          	beq	a0,a5,9a <simpletest+0x9a>
  34:	84aa                	mv	s1,a0
    printf("sbrk(%d) failed\n", sz);
    exit(-1);
  }

  for(char *q = p; q < p + sz; q += 4096){
  36:	05556937          	lui	s2,0x5556
  3a:	992a                	add	s2,s2,a0
  3c:	6985                	lui	s3,0x1
    *(int*)q = getpid();
  3e:	00000097          	auipc	ra,0x0
  42:	7ac080e7          	jalr	1964(ra) # 7ea <getpid>
  46:	c088                	sw	a0,0(s1)
  for(char *q = p; q < p + sz; q += 4096){
  48:	94ce                	add	s1,s1,s3
  4a:	fe991ae3          	bne	s2,s1,3e <simpletest+0x3e>
  }

  int pid = fork();
  4e:	00000097          	auipc	ra,0x0
  52:	714080e7          	jalr	1812(ra) # 762 <fork>
  if(pid < 0){
  56:	06054363          	bltz	a0,bc <simpletest+0xbc>
    printf("fork() failed\n");
    exit(-1);
  }

  if(pid == 0)
  5a:	cd35                	beqz	a0,d6 <simpletest+0xd6>
    exit(0);

  wait(0);
  5c:	4501                	li	a0,0
  5e:	00000097          	auipc	ra,0x0
  62:	714080e7          	jalr	1812(ra) # 772 <wait>

  if(sbrk(-sz) == (char*)0xffffffffffffffffL){
  66:	faaab537          	lui	a0,0xfaaab
  6a:	aac50513          	addi	a0,a0,-1364 # fffffffffaaaaaac <__BSS_END__+0xfffffffffaaa5c54>
  6e:	00000097          	auipc	ra,0x0
  72:	784080e7          	jalr	1924(ra) # 7f2 <sbrk>
  76:	57fd                	li	a5,-1
  78:	06f50363          	beq	a0,a5,de <simpletest+0xde>
    printf("sbrk(-%d) failed\n", sz);
    exit(-1);
  }

  printf("ok\n");
  7c:	00001517          	auipc	a0,0x1
  80:	c6450513          	addi	a0,a0,-924 # ce0 <malloc+0x14c>
  84:	00001097          	auipc	ra,0x1
  88:	a54080e7          	jalr	-1452(ra) # ad8 <printf>
}
  8c:	70a2                	ld	ra,40(sp)
  8e:	7402                	ld	s0,32(sp)
  90:	64e2                	ld	s1,24(sp)
  92:	6942                	ld	s2,16(sp)
  94:	69a2                	ld	s3,8(sp)
  96:	6145                	addi	sp,sp,48
  98:	8082                	ret
    printf("sbrk(%d) failed\n", sz);
  9a:	055555b7          	lui	a1,0x5555
  9e:	55458593          	addi	a1,a1,1364 # 5555554 <__BSS_END__+0x55506fc>
  a2:	00001517          	auipc	a0,0x1
  a6:	bfe50513          	addi	a0,a0,-1026 # ca0 <malloc+0x10c>
  aa:	00001097          	auipc	ra,0x1
  ae:	a2e080e7          	jalr	-1490(ra) # ad8 <printf>
    exit(-1);
  b2:	557d                	li	a0,-1
  b4:	00000097          	auipc	ra,0x0
  b8:	6b6080e7          	jalr	1718(ra) # 76a <exit>
    printf("fork() failed\n");
  bc:	00001517          	auipc	a0,0x1
  c0:	bfc50513          	addi	a0,a0,-1028 # cb8 <malloc+0x124>
  c4:	00001097          	auipc	ra,0x1
  c8:	a14080e7          	jalr	-1516(ra) # ad8 <printf>
    exit(-1);
  cc:	557d                	li	a0,-1
  ce:	00000097          	auipc	ra,0x0
  d2:	69c080e7          	jalr	1692(ra) # 76a <exit>
    exit(0);
  d6:	00000097          	auipc	ra,0x0
  da:	694080e7          	jalr	1684(ra) # 76a <exit>
    printf("sbrk(-%d) failed\n", sz);
  de:	055555b7          	lui	a1,0x5555
  e2:	55458593          	addi	a1,a1,1364 # 5555554 <__BSS_END__+0x55506fc>
  e6:	00001517          	auipc	a0,0x1
  ea:	be250513          	addi	a0,a0,-1054 # cc8 <malloc+0x134>
  ee:	00001097          	auipc	ra,0x1
  f2:	9ea080e7          	jalr	-1558(ra) # ad8 <printf>
    exit(-1);
  f6:	557d                	li	a0,-1
  f8:	00000097          	auipc	ra,0x0
  fc:	672080e7          	jalr	1650(ra) # 76a <exit>

0000000000000100 <threetest>:
// this causes more than half of physical memory
// to be allocated, so it also checks whether
// copied pages are freed.
void
threetest()
{
 100:	7179                	addi	sp,sp,-48
 102:	f406                	sd	ra,40(sp)
 104:	f022                	sd	s0,32(sp)
 106:	ec26                	sd	s1,24(sp)
 108:	e84a                	sd	s2,16(sp)
 10a:	e44e                	sd	s3,8(sp)
 10c:	e052                	sd	s4,0(sp)
 10e:	1800                	addi	s0,sp,48
  uint64 phys_size = PHYSTOP - KERNBASE;
  int sz = phys_size / 4;
  int pid1, pid2;

  printf("three: ");
 110:	00001517          	auipc	a0,0x1
 114:	bd850513          	addi	a0,a0,-1064 # ce8 <malloc+0x154>
 118:	00001097          	auipc	ra,0x1
 11c:	9c0080e7          	jalr	-1600(ra) # ad8 <printf>
  
  char *p = sbrk(sz);
 120:	02000537          	lui	a0,0x2000
 124:	00000097          	auipc	ra,0x0
 128:	6ce080e7          	jalr	1742(ra) # 7f2 <sbrk>
 12c:	84aa                	mv	s1,a0
  if(p == (char*)0xffffffffffffffffL){
 12e:	57fd                	li	a5,-1
 130:	08f50663          	beq	a0,a5,1bc <threetest+0xbc>
    printf("sbrk(%d) failed\n", sz);
    exit(-1);
  }

  pid1 = fork();
 134:	00000097          	auipc	ra,0x0
 138:	62e080e7          	jalr	1582(ra) # 762 <fork>
  if(pid1 < 0){
 13c:	08054f63          	bltz	a0,1da <threetest+0xda>
    printf("fork failed\n");
    exit(-1);
  }
  if(pid1 == 0){
 140:	c955                	beqz	a0,1f4 <threetest+0xf4>
      *(int*)q = 9999;
    }
    exit(0);
  }

  for(char *q = p; q < p + sz; q += 4096){
 142:	020009b7          	lui	s3,0x2000
 146:	99a6                	add	s3,s3,s1
 148:	8926                	mv	s2,s1
 14a:	6a05                	lui	s4,0x1
    *(int*)q = getpid();
 14c:	00000097          	auipc	ra,0x0
 150:	69e080e7          	jalr	1694(ra) # 7ea <getpid>
 154:	00a92023          	sw	a0,0(s2) # 5556000 <__BSS_END__+0x55511a8>
  for(char *q = p; q < p + sz; q += 4096){
 158:	9952                	add	s2,s2,s4
 15a:	ff3919e3          	bne	s2,s3,14c <threetest+0x4c>
  }

  wait(0);
 15e:	4501                	li	a0,0
 160:	00000097          	auipc	ra,0x0
 164:	612080e7          	jalr	1554(ra) # 772 <wait>

  sleep(1);
 168:	4505                	li	a0,1
 16a:	00000097          	auipc	ra,0x0
 16e:	690080e7          	jalr	1680(ra) # 7fa <sleep>

  for(char *q = p; q < p + sz; q += 4096){
 172:	6a05                	lui	s4,0x1
    if(*(int*)q != getpid()){
 174:	0004a903          	lw	s2,0(s1)
 178:	00000097          	auipc	ra,0x0
 17c:	672080e7          	jalr	1650(ra) # 7ea <getpid>
 180:	10a91a63          	bne	s2,a0,294 <threetest+0x194>
  for(char *q = p; q < p + sz; q += 4096){
 184:	94d2                	add	s1,s1,s4
 186:	ff3497e3          	bne	s1,s3,174 <threetest+0x74>
      printf("wrong content\n");
      exit(-1);
    }
  }

  if(sbrk(-sz) == (char*)0xffffffffffffffffL){
 18a:	fe000537          	lui	a0,0xfe000
 18e:	00000097          	auipc	ra,0x0
 192:	664080e7          	jalr	1636(ra) # 7f2 <sbrk>
 196:	57fd                	li	a5,-1
 198:	10f50b63          	beq	a0,a5,2ae <threetest+0x1ae>
    printf("sbrk(-%d) failed\n", sz);
    exit(-1);
  }

  printf("ok\n");
 19c:	00001517          	auipc	a0,0x1
 1a0:	b4450513          	addi	a0,a0,-1212 # ce0 <malloc+0x14c>
 1a4:	00001097          	auipc	ra,0x1
 1a8:	934080e7          	jalr	-1740(ra) # ad8 <printf>
}
 1ac:	70a2                	ld	ra,40(sp)
 1ae:	7402                	ld	s0,32(sp)
 1b0:	64e2                	ld	s1,24(sp)
 1b2:	6942                	ld	s2,16(sp)
 1b4:	69a2                	ld	s3,8(sp)
 1b6:	6a02                	ld	s4,0(sp)
 1b8:	6145                	addi	sp,sp,48
 1ba:	8082                	ret
    printf("sbrk(%d) failed\n", sz);
 1bc:	020005b7          	lui	a1,0x2000
 1c0:	00001517          	auipc	a0,0x1
 1c4:	ae050513          	addi	a0,a0,-1312 # ca0 <malloc+0x10c>
 1c8:	00001097          	auipc	ra,0x1
 1cc:	910080e7          	jalr	-1776(ra) # ad8 <printf>
    exit(-1);
 1d0:	8526                	mv	a0,s1
 1d2:	00000097          	auipc	ra,0x0
 1d6:	598080e7          	jalr	1432(ra) # 76a <exit>
    printf("fork failed\n");
 1da:	00001517          	auipc	a0,0x1
 1de:	b1650513          	addi	a0,a0,-1258 # cf0 <malloc+0x15c>
 1e2:	00001097          	auipc	ra,0x1
 1e6:	8f6080e7          	jalr	-1802(ra) # ad8 <printf>
    exit(-1);
 1ea:	557d                	li	a0,-1
 1ec:	00000097          	auipc	ra,0x0
 1f0:	57e080e7          	jalr	1406(ra) # 76a <exit>
    pid2 = fork();
 1f4:	00000097          	auipc	ra,0x0
 1f8:	56e080e7          	jalr	1390(ra) # 762 <fork>
    if(pid2 < 0){
 1fc:	04054263          	bltz	a0,240 <threetest+0x140>
    if(pid2 == 0){
 200:	ed29                	bnez	a0,25a <threetest+0x15a>
      for(char *q = p; q < p + (sz/5)*4; q += 4096){
 202:	0199a9b7          	lui	s3,0x199a
 206:	99a6                	add	s3,s3,s1
 208:	8926                	mv	s2,s1
 20a:	6a05                	lui	s4,0x1
        *(int*)q = getpid();
 20c:	00000097          	auipc	ra,0x0
 210:	5de080e7          	jalr	1502(ra) # 7ea <getpid>
 214:	00a92023          	sw	a0,0(s2)
      for(char *q = p; q < p + (sz/5)*4; q += 4096){
 218:	9952                	add	s2,s2,s4
 21a:	ff3919e3          	bne	s2,s3,20c <threetest+0x10c>
      for(char *q = p; q < p + (sz/5)*4; q += 4096){
 21e:	6a05                	lui	s4,0x1
        if(*(int*)q != getpid()){
 220:	0004a903          	lw	s2,0(s1)
 224:	00000097          	auipc	ra,0x0
 228:	5c6080e7          	jalr	1478(ra) # 7ea <getpid>
 22c:	04a91763          	bne	s2,a0,27a <threetest+0x17a>
      for(char *q = p; q < p + (sz/5)*4; q += 4096){
 230:	94d2                	add	s1,s1,s4
 232:	ff3497e3          	bne	s1,s3,220 <threetest+0x120>
      exit(-1);
 236:	557d                	li	a0,-1
 238:	00000097          	auipc	ra,0x0
 23c:	532080e7          	jalr	1330(ra) # 76a <exit>
      printf("fork failed");
 240:	00001517          	auipc	a0,0x1
 244:	ac050513          	addi	a0,a0,-1344 # d00 <malloc+0x16c>
 248:	00001097          	auipc	ra,0x1
 24c:	890080e7          	jalr	-1904(ra) # ad8 <printf>
      exit(-1);
 250:	557d                	li	a0,-1
 252:	00000097          	auipc	ra,0x0
 256:	518080e7          	jalr	1304(ra) # 76a <exit>
    for(char *q = p; q < p + (sz/2); q += 4096){
 25a:	01000737          	lui	a4,0x1000
 25e:	9726                	add	a4,a4,s1
      *(int*)q = 9999;
 260:	6789                	lui	a5,0x2
 262:	70f78793          	addi	a5,a5,1807 # 270f <buf+0x8c7>
    for(char *q = p; q < p + (sz/2); q += 4096){
 266:	6685                	lui	a3,0x1
      *(int*)q = 9999;
 268:	c09c                	sw	a5,0(s1)
    for(char *q = p; q < p + (sz/2); q += 4096){
 26a:	94b6                	add	s1,s1,a3
 26c:	fee49ee3          	bne	s1,a4,268 <threetest+0x168>
    exit(0);
 270:	4501                	li	a0,0
 272:	00000097          	auipc	ra,0x0
 276:	4f8080e7          	jalr	1272(ra) # 76a <exit>
          printf("wrong content\n");
 27a:	00001517          	auipc	a0,0x1
 27e:	a9650513          	addi	a0,a0,-1386 # d10 <malloc+0x17c>
 282:	00001097          	auipc	ra,0x1
 286:	856080e7          	jalr	-1962(ra) # ad8 <printf>
          exit(-1);
 28a:	557d                	li	a0,-1
 28c:	00000097          	auipc	ra,0x0
 290:	4de080e7          	jalr	1246(ra) # 76a <exit>
      printf("wrong content\n");
 294:	00001517          	auipc	a0,0x1
 298:	a7c50513          	addi	a0,a0,-1412 # d10 <malloc+0x17c>
 29c:	00001097          	auipc	ra,0x1
 2a0:	83c080e7          	jalr	-1988(ra) # ad8 <printf>
      exit(-1);
 2a4:	557d                	li	a0,-1
 2a6:	00000097          	auipc	ra,0x0
 2aa:	4c4080e7          	jalr	1220(ra) # 76a <exit>
    printf("sbrk(-%d) failed\n", sz);
 2ae:	020005b7          	lui	a1,0x2000
 2b2:	00001517          	auipc	a0,0x1
 2b6:	a1650513          	addi	a0,a0,-1514 # cc8 <malloc+0x134>
 2ba:	00001097          	auipc	ra,0x1
 2be:	81e080e7          	jalr	-2018(ra) # ad8 <printf>
    exit(-1);
 2c2:	557d                	li	a0,-1
 2c4:	00000097          	auipc	ra,0x0
 2c8:	4a6080e7          	jalr	1190(ra) # 76a <exit>

00000000000002cc <filetest>:
char junk3[4096];

// test whether copyout() simulates COW faults.
void
filetest()
{
 2cc:	7139                	addi	sp,sp,-64
 2ce:	fc06                	sd	ra,56(sp)
 2d0:	f822                	sd	s0,48(sp)
 2d2:	f426                	sd	s1,40(sp)
 2d4:	f04a                	sd	s2,32(sp)
 2d6:	ec4e                	sd	s3,24(sp)
 2d8:	e852                	sd	s4,16(sp)
 2da:	0080                	addi	s0,sp,64
  printf("file: ");
 2dc:	00001517          	auipc	a0,0x1
 2e0:	a4450513          	addi	a0,a0,-1468 # d20 <malloc+0x18c>
 2e4:	00000097          	auipc	ra,0x0
 2e8:	7f4080e7          	jalr	2036(ra) # ad8 <printf>
  
  buf[0] = 99;
 2ec:	06300793          	li	a5,99
 2f0:	00002717          	auipc	a4,0x2
 2f4:	b4f70c23          	sb	a5,-1192(a4) # 1e48 <buf>

  for(int i = 0; i < 4; i++){
 2f8:	fc042423          	sw	zero,-56(s0)
    if(pipe(fds) != 0){
 2fc:	00001497          	auipc	s1,0x1
 300:	b3c48493          	addi	s1,s1,-1220 # e38 <fds>
        printf("error: read the wrong value\n");
        exit(1);
      }
      exit(0);
    }
    if(write(fds[1], &i, sizeof(i)) != sizeof(i)){
 304:	fc840a13          	addi	s4,s0,-56
 308:	4911                	li	s2,4
  for(int i = 0; i < 4; i++){
 30a:	498d                	li	s3,3
    if(pipe(fds) != 0){
 30c:	8526                	mv	a0,s1
 30e:	00000097          	auipc	ra,0x0
 312:	46c080e7          	jalr	1132(ra) # 77a <pipe>
 316:	e141                	bnez	a0,396 <filetest+0xca>
    int pid = fork();
 318:	00000097          	auipc	ra,0x0
 31c:	44a080e7          	jalr	1098(ra) # 762 <fork>
    if(pid < 0){
 320:	08054863          	bltz	a0,3b0 <filetest+0xe4>
    if(pid == 0){
 324:	c15d                	beqz	a0,3ca <filetest+0xfe>
    if(write(fds[1], &i, sizeof(i)) != sizeof(i)){
 326:	864a                	mv	a2,s2
 328:	85d2                	mv	a1,s4
 32a:	40c8                	lw	a0,4(s1)
 32c:	00000097          	auipc	ra,0x0
 330:	45e080e7          	jalr	1118(ra) # 78a <write>
 334:	11251c63          	bne	a0,s2,44c <filetest+0x180>
  for(int i = 0; i < 4; i++){
 338:	fc842783          	lw	a5,-56(s0)
 33c:	2785                	addiw	a5,a5,1
 33e:	fcf42423          	sw	a5,-56(s0)
 342:	fcf9d5e3          	bge	s3,a5,30c <filetest+0x40>
      printf("error: write failed\n");
      exit(-1);
    }
  }

  int xstatus = 0;
 346:	fc042623          	sw	zero,-52(s0)
 34a:	4491                	li	s1,4
  for(int i = 0; i < 4; i++) {
    wait(&xstatus);
 34c:	fcc40913          	addi	s2,s0,-52
 350:	854a                	mv	a0,s2
 352:	00000097          	auipc	ra,0x0
 356:	420080e7          	jalr	1056(ra) # 772 <wait>
    if(xstatus != 0) {
 35a:	fcc42783          	lw	a5,-52(s0)
 35e:	10079463          	bnez	a5,466 <filetest+0x19a>
  for(int i = 0; i < 4; i++) {
 362:	34fd                	addiw	s1,s1,-1
 364:	f4f5                	bnez	s1,350 <filetest+0x84>
      exit(1);
    }
  }

  if(buf[0] != 99){
 366:	00002717          	auipc	a4,0x2
 36a:	ae274703          	lbu	a4,-1310(a4) # 1e48 <buf>
 36e:	06300793          	li	a5,99
 372:	0ef71f63          	bne	a4,a5,470 <filetest+0x1a4>
    printf("error: child overwrote parent\n");
    exit(1);
  }

  printf("ok\n");
 376:	00001517          	auipc	a0,0x1
 37a:	96a50513          	addi	a0,a0,-1686 # ce0 <malloc+0x14c>
 37e:	00000097          	auipc	ra,0x0
 382:	75a080e7          	jalr	1882(ra) # ad8 <printf>
}
 386:	70e2                	ld	ra,56(sp)
 388:	7442                	ld	s0,48(sp)
 38a:	74a2                	ld	s1,40(sp)
 38c:	7902                	ld	s2,32(sp)
 38e:	69e2                	ld	s3,24(sp)
 390:	6a42                	ld	s4,16(sp)
 392:	6121                	addi	sp,sp,64
 394:	8082                	ret
      printf("pipe() failed\n");
 396:	00001517          	auipc	a0,0x1
 39a:	99250513          	addi	a0,a0,-1646 # d28 <malloc+0x194>
 39e:	00000097          	auipc	ra,0x0
 3a2:	73a080e7          	jalr	1850(ra) # ad8 <printf>
      exit(-1);
 3a6:	557d                	li	a0,-1
 3a8:	00000097          	auipc	ra,0x0
 3ac:	3c2080e7          	jalr	962(ra) # 76a <exit>
      printf("fork failed\n");
 3b0:	00001517          	auipc	a0,0x1
 3b4:	94050513          	addi	a0,a0,-1728 # cf0 <malloc+0x15c>
 3b8:	00000097          	auipc	ra,0x0
 3bc:	720080e7          	jalr	1824(ra) # ad8 <printf>
      exit(-1);
 3c0:	557d                	li	a0,-1
 3c2:	00000097          	auipc	ra,0x0
 3c6:	3a8080e7          	jalr	936(ra) # 76a <exit>
      sleep(1);
 3ca:	4505                	li	a0,1
 3cc:	00000097          	auipc	ra,0x0
 3d0:	42e080e7          	jalr	1070(ra) # 7fa <sleep>
      if(read(fds[0], buf, sizeof(i)) != sizeof(i)){
 3d4:	4611                	li	a2,4
 3d6:	00002597          	auipc	a1,0x2
 3da:	a7258593          	addi	a1,a1,-1422 # 1e48 <buf>
 3de:	00001517          	auipc	a0,0x1
 3e2:	a5a52503          	lw	a0,-1446(a0) # e38 <fds>
 3e6:	00000097          	auipc	ra,0x0
 3ea:	39c080e7          	jalr	924(ra) # 782 <read>
 3ee:	4791                	li	a5,4
 3f0:	02f51c63          	bne	a0,a5,428 <filetest+0x15c>
      sleep(1);
 3f4:	4505                	li	a0,1
 3f6:	00000097          	auipc	ra,0x0
 3fa:	404080e7          	jalr	1028(ra) # 7fa <sleep>
      if(j != i){
 3fe:	fc842703          	lw	a4,-56(s0)
 402:	00002797          	auipc	a5,0x2
 406:	a467a783          	lw	a5,-1466(a5) # 1e48 <buf>
 40a:	02f70c63          	beq	a4,a5,442 <filetest+0x176>
        printf("error: read the wrong value\n");
 40e:	00001517          	auipc	a0,0x1
 412:	94250513          	addi	a0,a0,-1726 # d50 <malloc+0x1bc>
 416:	00000097          	auipc	ra,0x0
 41a:	6c2080e7          	jalr	1730(ra) # ad8 <printf>
        exit(1);
 41e:	4505                	li	a0,1
 420:	00000097          	auipc	ra,0x0
 424:	34a080e7          	jalr	842(ra) # 76a <exit>
        printf("error: read failed\n");
 428:	00001517          	auipc	a0,0x1
 42c:	91050513          	addi	a0,a0,-1776 # d38 <malloc+0x1a4>
 430:	00000097          	auipc	ra,0x0
 434:	6a8080e7          	jalr	1704(ra) # ad8 <printf>
        exit(1);
 438:	4505                	li	a0,1
 43a:	00000097          	auipc	ra,0x0
 43e:	330080e7          	jalr	816(ra) # 76a <exit>
      exit(0);
 442:	4501                	li	a0,0
 444:	00000097          	auipc	ra,0x0
 448:	326080e7          	jalr	806(ra) # 76a <exit>
      printf("error: write failed\n");
 44c:	00001517          	auipc	a0,0x1
 450:	92450513          	addi	a0,a0,-1756 # d70 <malloc+0x1dc>
 454:	00000097          	auipc	ra,0x0
 458:	684080e7          	jalr	1668(ra) # ad8 <printf>
      exit(-1);
 45c:	557d                	li	a0,-1
 45e:	00000097          	auipc	ra,0x0
 462:	30c080e7          	jalr	780(ra) # 76a <exit>
      exit(1);
 466:	4505                	li	a0,1
 468:	00000097          	auipc	ra,0x0
 46c:	302080e7          	jalr	770(ra) # 76a <exit>
    printf("error: child overwrote parent\n");
 470:	00001517          	auipc	a0,0x1
 474:	91850513          	addi	a0,a0,-1768 # d88 <malloc+0x1f4>
 478:	00000097          	auipc	ra,0x0
 47c:	660080e7          	jalr	1632(ra) # ad8 <printf>
    exit(1);
 480:	4505                	li	a0,1
 482:	00000097          	auipc	ra,0x0
 486:	2e8080e7          	jalr	744(ra) # 76a <exit>

000000000000048a <main>:

int
main(int argc, char *argv[])
{
 48a:	1141                	addi	sp,sp,-16
 48c:	e406                	sd	ra,8(sp)
 48e:	e022                	sd	s0,0(sp)
 490:	0800                	addi	s0,sp,16
  simpletest();
 492:	00000097          	auipc	ra,0x0
 496:	b6e080e7          	jalr	-1170(ra) # 0 <simpletest>

  // check that the first simpletest() freed the physical memory.
  simpletest();
 49a:	00000097          	auipc	ra,0x0
 49e:	b66080e7          	jalr	-1178(ra) # 0 <simpletest>

  threetest();
 4a2:	00000097          	auipc	ra,0x0
 4a6:	c5e080e7          	jalr	-930(ra) # 100 <threetest>
  threetest();
 4aa:	00000097          	auipc	ra,0x0
 4ae:	c56080e7          	jalr	-938(ra) # 100 <threetest>
  threetest();
 4b2:	00000097          	auipc	ra,0x0
 4b6:	c4e080e7          	jalr	-946(ra) # 100 <threetest>

  filetest();
 4ba:	00000097          	auipc	ra,0x0
 4be:	e12080e7          	jalr	-494(ra) # 2cc <filetest>

  printf("ALL COW TESTS PASSED\n");
 4c2:	00001517          	auipc	a0,0x1
 4c6:	8e650513          	addi	a0,a0,-1818 # da8 <malloc+0x214>
 4ca:	00000097          	auipc	ra,0x0
 4ce:	60e080e7          	jalr	1550(ra) # ad8 <printf>

  exit(0);
 4d2:	4501                	li	a0,0
 4d4:	00000097          	auipc	ra,0x0
 4d8:	296080e7          	jalr	662(ra) # 76a <exit>

00000000000004dc <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 4dc:	1141                	addi	sp,sp,-16
 4de:	e406                	sd	ra,8(sp)
 4e0:	e022                	sd	s0,0(sp)
 4e2:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 4e4:	87aa                	mv	a5,a0
 4e6:	0585                	addi	a1,a1,1
 4e8:	0785                	addi	a5,a5,1
 4ea:	fff5c703          	lbu	a4,-1(a1)
 4ee:	fee78fa3          	sb	a4,-1(a5)
 4f2:	fb75                	bnez	a4,4e6 <strcpy+0xa>
    ;
  return os;
}
 4f4:	60a2                	ld	ra,8(sp)
 4f6:	6402                	ld	s0,0(sp)
 4f8:	0141                	addi	sp,sp,16
 4fa:	8082                	ret

00000000000004fc <strcmp>:

int
strcmp(const char *p, const char *q)
{
 4fc:	1141                	addi	sp,sp,-16
 4fe:	e406                	sd	ra,8(sp)
 500:	e022                	sd	s0,0(sp)
 502:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 504:	00054783          	lbu	a5,0(a0)
 508:	cb91                	beqz	a5,51c <strcmp+0x20>
 50a:	0005c703          	lbu	a4,0(a1)
 50e:	00f71763          	bne	a4,a5,51c <strcmp+0x20>
    p++, q++;
 512:	0505                	addi	a0,a0,1
 514:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 516:	00054783          	lbu	a5,0(a0)
 51a:	fbe5                	bnez	a5,50a <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 51c:	0005c503          	lbu	a0,0(a1)
}
 520:	40a7853b          	subw	a0,a5,a0
 524:	60a2                	ld	ra,8(sp)
 526:	6402                	ld	s0,0(sp)
 528:	0141                	addi	sp,sp,16
 52a:	8082                	ret

000000000000052c <strlen>:

uint
strlen(const char *s)
{
 52c:	1141                	addi	sp,sp,-16
 52e:	e406                	sd	ra,8(sp)
 530:	e022                	sd	s0,0(sp)
 532:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 534:	00054783          	lbu	a5,0(a0)
 538:	cf91                	beqz	a5,554 <strlen+0x28>
 53a:	00150793          	addi	a5,a0,1
 53e:	86be                	mv	a3,a5
 540:	0785                	addi	a5,a5,1
 542:	fff7c703          	lbu	a4,-1(a5)
 546:	ff65                	bnez	a4,53e <strlen+0x12>
 548:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
 54c:	60a2                	ld	ra,8(sp)
 54e:	6402                	ld	s0,0(sp)
 550:	0141                	addi	sp,sp,16
 552:	8082                	ret
  for(n = 0; s[n]; n++)
 554:	4501                	li	a0,0
 556:	bfdd                	j	54c <strlen+0x20>

0000000000000558 <memset>:

void*
memset(void *dst, int c, uint n)
{
 558:	1141                	addi	sp,sp,-16
 55a:	e406                	sd	ra,8(sp)
 55c:	e022                	sd	s0,0(sp)
 55e:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 560:	ca19                	beqz	a2,576 <memset+0x1e>
 562:	87aa                	mv	a5,a0
 564:	1602                	slli	a2,a2,0x20
 566:	9201                	srli	a2,a2,0x20
 568:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 56c:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 570:	0785                	addi	a5,a5,1
 572:	fee79de3          	bne	a5,a4,56c <memset+0x14>
  }
  return dst;
}
 576:	60a2                	ld	ra,8(sp)
 578:	6402                	ld	s0,0(sp)
 57a:	0141                	addi	sp,sp,16
 57c:	8082                	ret

000000000000057e <strchr>:

char*
strchr(const char *s, char c)
{
 57e:	1141                	addi	sp,sp,-16
 580:	e406                	sd	ra,8(sp)
 582:	e022                	sd	s0,0(sp)
 584:	0800                	addi	s0,sp,16
  for(; *s; s++)
 586:	00054783          	lbu	a5,0(a0)
 58a:	cf81                	beqz	a5,5a2 <strchr+0x24>
    if(*s == c)
 58c:	00f58763          	beq	a1,a5,59a <strchr+0x1c>
  for(; *s; s++)
 590:	0505                	addi	a0,a0,1
 592:	00054783          	lbu	a5,0(a0)
 596:	fbfd                	bnez	a5,58c <strchr+0xe>
      return (char*)s;
  return 0;
 598:	4501                	li	a0,0
}
 59a:	60a2                	ld	ra,8(sp)
 59c:	6402                	ld	s0,0(sp)
 59e:	0141                	addi	sp,sp,16
 5a0:	8082                	ret
  return 0;
 5a2:	4501                	li	a0,0
 5a4:	bfdd                	j	59a <strchr+0x1c>

00000000000005a6 <gets>:

char*
gets(char *buf, int max)
{
 5a6:	711d                	addi	sp,sp,-96
 5a8:	ec86                	sd	ra,88(sp)
 5aa:	e8a2                	sd	s0,80(sp)
 5ac:	e4a6                	sd	s1,72(sp)
 5ae:	e0ca                	sd	s2,64(sp)
 5b0:	fc4e                	sd	s3,56(sp)
 5b2:	f852                	sd	s4,48(sp)
 5b4:	f456                	sd	s5,40(sp)
 5b6:	f05a                	sd	s6,32(sp)
 5b8:	ec5e                	sd	s7,24(sp)
 5ba:	e862                	sd	s8,16(sp)
 5bc:	1080                	addi	s0,sp,96
 5be:	8baa                	mv	s7,a0
 5c0:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 5c2:	892a                	mv	s2,a0
 5c4:	4481                	li	s1,0
    cc = read(0, &c, 1);
 5c6:	faf40b13          	addi	s6,s0,-81
 5ca:	4a85                	li	s5,1
  for(i=0; i+1 < max; ){
 5cc:	8c26                	mv	s8,s1
 5ce:	0014899b          	addiw	s3,s1,1
 5d2:	84ce                	mv	s1,s3
 5d4:	0349d663          	bge	s3,s4,600 <gets+0x5a>
    cc = read(0, &c, 1);
 5d8:	8656                	mv	a2,s5
 5da:	85da                	mv	a1,s6
 5dc:	4501                	li	a0,0
 5de:	00000097          	auipc	ra,0x0
 5e2:	1a4080e7          	jalr	420(ra) # 782 <read>
    if(cc < 1)
 5e6:	00a05d63          	blez	a0,600 <gets+0x5a>
      break;
    buf[i++] = c;
 5ea:	faf44783          	lbu	a5,-81(s0)
 5ee:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 5f2:	0905                	addi	s2,s2,1
 5f4:	ff678713          	addi	a4,a5,-10
 5f8:	c319                	beqz	a4,5fe <gets+0x58>
 5fa:	17cd                	addi	a5,a5,-13
 5fc:	fbe1                	bnez	a5,5cc <gets+0x26>
    buf[i++] = c;
 5fe:	8c4e                	mv	s8,s3
      break;
  }
  buf[i] = '\0';
 600:	9c5e                	add	s8,s8,s7
 602:	000c0023          	sb	zero,0(s8)
  return buf;
}
 606:	855e                	mv	a0,s7
 608:	60e6                	ld	ra,88(sp)
 60a:	6446                	ld	s0,80(sp)
 60c:	64a6                	ld	s1,72(sp)
 60e:	6906                	ld	s2,64(sp)
 610:	79e2                	ld	s3,56(sp)
 612:	7a42                	ld	s4,48(sp)
 614:	7aa2                	ld	s5,40(sp)
 616:	7b02                	ld	s6,32(sp)
 618:	6be2                	ld	s7,24(sp)
 61a:	6c42                	ld	s8,16(sp)
 61c:	6125                	addi	sp,sp,96
 61e:	8082                	ret

0000000000000620 <stat>:

int
stat(const char *n, struct stat *st)
{
 620:	1101                	addi	sp,sp,-32
 622:	ec06                	sd	ra,24(sp)
 624:	e822                	sd	s0,16(sp)
 626:	e04a                	sd	s2,0(sp)
 628:	1000                	addi	s0,sp,32
 62a:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 62c:	4581                	li	a1,0
 62e:	00000097          	auipc	ra,0x0
 632:	17c080e7          	jalr	380(ra) # 7aa <open>
  if(fd < 0)
 636:	02054663          	bltz	a0,662 <stat+0x42>
 63a:	e426                	sd	s1,8(sp)
 63c:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 63e:	85ca                	mv	a1,s2
 640:	00000097          	auipc	ra,0x0
 644:	182080e7          	jalr	386(ra) # 7c2 <fstat>
 648:	892a                	mv	s2,a0
  close(fd);
 64a:	8526                	mv	a0,s1
 64c:	00000097          	auipc	ra,0x0
 650:	146080e7          	jalr	326(ra) # 792 <close>
  return r;
 654:	64a2                	ld	s1,8(sp)
}
 656:	854a                	mv	a0,s2
 658:	60e2                	ld	ra,24(sp)
 65a:	6442                	ld	s0,16(sp)
 65c:	6902                	ld	s2,0(sp)
 65e:	6105                	addi	sp,sp,32
 660:	8082                	ret
    return -1;
 662:	57fd                	li	a5,-1
 664:	893e                	mv	s2,a5
 666:	bfc5                	j	656 <stat+0x36>

0000000000000668 <atoi>:

int
atoi(const char *s)
{
 668:	1141                	addi	sp,sp,-16
 66a:	e406                	sd	ra,8(sp)
 66c:	e022                	sd	s0,0(sp)
 66e:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 670:	00054683          	lbu	a3,0(a0)
 674:	fd06879b          	addiw	a5,a3,-48 # fd0 <junk3+0x188>
 678:	0ff7f793          	zext.b	a5,a5
 67c:	4625                	li	a2,9
 67e:	02f66963          	bltu	a2,a5,6b0 <atoi+0x48>
 682:	872a                	mv	a4,a0
  n = 0;
 684:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 686:	0705                	addi	a4,a4,1
 688:	0025179b          	slliw	a5,a0,0x2
 68c:	9fa9                	addw	a5,a5,a0
 68e:	0017979b          	slliw	a5,a5,0x1
 692:	9fb5                	addw	a5,a5,a3
 694:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 698:	00074683          	lbu	a3,0(a4)
 69c:	fd06879b          	addiw	a5,a3,-48
 6a0:	0ff7f793          	zext.b	a5,a5
 6a4:	fef671e3          	bgeu	a2,a5,686 <atoi+0x1e>
  return n;
}
 6a8:	60a2                	ld	ra,8(sp)
 6aa:	6402                	ld	s0,0(sp)
 6ac:	0141                	addi	sp,sp,16
 6ae:	8082                	ret
  n = 0;
 6b0:	4501                	li	a0,0
 6b2:	bfdd                	j	6a8 <atoi+0x40>

00000000000006b4 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 6b4:	1141                	addi	sp,sp,-16
 6b6:	e406                	sd	ra,8(sp)
 6b8:	e022                	sd	s0,0(sp)
 6ba:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 6bc:	02b57563          	bgeu	a0,a1,6e6 <memmove+0x32>
    while(n-- > 0)
 6c0:	00c05f63          	blez	a2,6de <memmove+0x2a>
 6c4:	1602                	slli	a2,a2,0x20
 6c6:	9201                	srli	a2,a2,0x20
 6c8:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 6cc:	872a                	mv	a4,a0
      *dst++ = *src++;
 6ce:	0585                	addi	a1,a1,1
 6d0:	0705                	addi	a4,a4,1
 6d2:	fff5c683          	lbu	a3,-1(a1)
 6d6:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 6da:	fee79ae3          	bne	a5,a4,6ce <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 6de:	60a2                	ld	ra,8(sp)
 6e0:	6402                	ld	s0,0(sp)
 6e2:	0141                	addi	sp,sp,16
 6e4:	8082                	ret
    while(n-- > 0)
 6e6:	fec05ce3          	blez	a2,6de <memmove+0x2a>
    dst += n;
 6ea:	00c50733          	add	a4,a0,a2
    src += n;
 6ee:	95b2                	add	a1,a1,a2
 6f0:	fff6079b          	addiw	a5,a2,-1
 6f4:	1782                	slli	a5,a5,0x20
 6f6:	9381                	srli	a5,a5,0x20
 6f8:	fff7c793          	not	a5,a5
 6fc:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 6fe:	15fd                	addi	a1,a1,-1
 700:	177d                	addi	a4,a4,-1
 702:	0005c683          	lbu	a3,0(a1)
 706:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 70a:	fef71ae3          	bne	a4,a5,6fe <memmove+0x4a>
 70e:	bfc1                	j	6de <memmove+0x2a>

0000000000000710 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 710:	1141                	addi	sp,sp,-16
 712:	e406                	sd	ra,8(sp)
 714:	e022                	sd	s0,0(sp)
 716:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 718:	c61d                	beqz	a2,746 <memcmp+0x36>
 71a:	1602                	slli	a2,a2,0x20
 71c:	9201                	srli	a2,a2,0x20
 71e:	00c506b3          	add	a3,a0,a2
    if (*p1 != *p2) {
 722:	00054783          	lbu	a5,0(a0)
 726:	0005c703          	lbu	a4,0(a1)
 72a:	00e79863          	bne	a5,a4,73a <memcmp+0x2a>
      return *p1 - *p2;
    }
    p1++;
 72e:	0505                	addi	a0,a0,1
    p2++;
 730:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 732:	fed518e3          	bne	a0,a3,722 <memcmp+0x12>
  }
  return 0;
 736:	4501                	li	a0,0
 738:	a019                	j	73e <memcmp+0x2e>
      return *p1 - *p2;
 73a:	40e7853b          	subw	a0,a5,a4
}
 73e:	60a2                	ld	ra,8(sp)
 740:	6402                	ld	s0,0(sp)
 742:	0141                	addi	sp,sp,16
 744:	8082                	ret
  return 0;
 746:	4501                	li	a0,0
 748:	bfdd                	j	73e <memcmp+0x2e>

000000000000074a <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 74a:	1141                	addi	sp,sp,-16
 74c:	e406                	sd	ra,8(sp)
 74e:	e022                	sd	s0,0(sp)
 750:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 752:	00000097          	auipc	ra,0x0
 756:	f62080e7          	jalr	-158(ra) # 6b4 <memmove>
}
 75a:	60a2                	ld	ra,8(sp)
 75c:	6402                	ld	s0,0(sp)
 75e:	0141                	addi	sp,sp,16
 760:	8082                	ret

0000000000000762 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 762:	4885                	li	a7,1
 ecall
 764:	00000073          	ecall
 ret
 768:	8082                	ret

000000000000076a <exit>:
.global exit
exit:
 li a7, SYS_exit
 76a:	4889                	li	a7,2
 ecall
 76c:	00000073          	ecall
 ret
 770:	8082                	ret

0000000000000772 <wait>:
.global wait
wait:
 li a7, SYS_wait
 772:	488d                	li	a7,3
 ecall
 774:	00000073          	ecall
 ret
 778:	8082                	ret

000000000000077a <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 77a:	4891                	li	a7,4
 ecall
 77c:	00000073          	ecall
 ret
 780:	8082                	ret

0000000000000782 <read>:
.global read
read:
 li a7, SYS_read
 782:	4895                	li	a7,5
 ecall
 784:	00000073          	ecall
 ret
 788:	8082                	ret

000000000000078a <write>:
.global write
write:
 li a7, SYS_write
 78a:	48c1                	li	a7,16
 ecall
 78c:	00000073          	ecall
 ret
 790:	8082                	ret

0000000000000792 <close>:
.global close
close:
 li a7, SYS_close
 792:	48d5                	li	a7,21
 ecall
 794:	00000073          	ecall
 ret
 798:	8082                	ret

000000000000079a <kill>:
.global kill
kill:
 li a7, SYS_kill
 79a:	4899                	li	a7,6
 ecall
 79c:	00000073          	ecall
 ret
 7a0:	8082                	ret

00000000000007a2 <exec>:
.global exec
exec:
 li a7, SYS_exec
 7a2:	489d                	li	a7,7
 ecall
 7a4:	00000073          	ecall
 ret
 7a8:	8082                	ret

00000000000007aa <open>:
.global open
open:
 li a7, SYS_open
 7aa:	48bd                	li	a7,15
 ecall
 7ac:	00000073          	ecall
 ret
 7b0:	8082                	ret

00000000000007b2 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 7b2:	48c5                	li	a7,17
 ecall
 7b4:	00000073          	ecall
 ret
 7b8:	8082                	ret

00000000000007ba <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 7ba:	48c9                	li	a7,18
 ecall
 7bc:	00000073          	ecall
 ret
 7c0:	8082                	ret

00000000000007c2 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 7c2:	48a1                	li	a7,8
 ecall
 7c4:	00000073          	ecall
 ret
 7c8:	8082                	ret

00000000000007ca <link>:
.global link
link:
 li a7, SYS_link
 7ca:	48cd                	li	a7,19
 ecall
 7cc:	00000073          	ecall
 ret
 7d0:	8082                	ret

00000000000007d2 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 7d2:	48d1                	li	a7,20
 ecall
 7d4:	00000073          	ecall
 ret
 7d8:	8082                	ret

00000000000007da <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 7da:	48a5                	li	a7,9
 ecall
 7dc:	00000073          	ecall
 ret
 7e0:	8082                	ret

00000000000007e2 <dup>:
.global dup
dup:
 li a7, SYS_dup
 7e2:	48a9                	li	a7,10
 ecall
 7e4:	00000073          	ecall
 ret
 7e8:	8082                	ret

00000000000007ea <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 7ea:	48ad                	li	a7,11
 ecall
 7ec:	00000073          	ecall
 ret
 7f0:	8082                	ret

00000000000007f2 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 7f2:	48b1                	li	a7,12
 ecall
 7f4:	00000073          	ecall
 ret
 7f8:	8082                	ret

00000000000007fa <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 7fa:	48b5                	li	a7,13
 ecall
 7fc:	00000073          	ecall
 ret
 800:	8082                	ret

0000000000000802 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 802:	48b9                	li	a7,14
 ecall
 804:	00000073          	ecall
 ret
 808:	8082                	ret

000000000000080a <ntas>:
.global ntas
ntas:
 li a7, SYS_ntas
 80a:	48d9                	li	a7,22
 ecall
 80c:	00000073          	ecall
 ret
 810:	8082                	ret

0000000000000812 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 812:	1101                	addi	sp,sp,-32
 814:	ec06                	sd	ra,24(sp)
 816:	e822                	sd	s0,16(sp)
 818:	1000                	addi	s0,sp,32
 81a:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 81e:	4605                	li	a2,1
 820:	fef40593          	addi	a1,s0,-17
 824:	00000097          	auipc	ra,0x0
 828:	f66080e7          	jalr	-154(ra) # 78a <write>
}
 82c:	60e2                	ld	ra,24(sp)
 82e:	6442                	ld	s0,16(sp)
 830:	6105                	addi	sp,sp,32
 832:	8082                	ret

0000000000000834 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 834:	7139                	addi	sp,sp,-64
 836:	fc06                	sd	ra,56(sp)
 838:	f822                	sd	s0,48(sp)
 83a:	f04a                	sd	s2,32(sp)
 83c:	ec4e                	sd	s3,24(sp)
 83e:	0080                	addi	s0,sp,64
 840:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 842:	cad9                	beqz	a3,8d8 <printint+0xa4>
 844:	01f5d79b          	srliw	a5,a1,0x1f
 848:	cbc1                	beqz	a5,8d8 <printint+0xa4>
    neg = 1;
    x = -xx;
 84a:	40b005bb          	negw	a1,a1
    neg = 1;
 84e:	4305                	li	t1,1
  } else {
    x = xx;
  }

  i = 0;
 850:	fc040993          	addi	s3,s0,-64
  neg = 0;
 854:	86ce                	mv	a3,s3
  i = 0;
 856:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 858:	00000817          	auipc	a6,0x0
 85c:	5c880813          	addi	a6,a6,1480 # e20 <digits>
 860:	88ba                	mv	a7,a4
 862:	0017051b          	addiw	a0,a4,1
 866:	872a                	mv	a4,a0
 868:	02c5f7bb          	remuw	a5,a1,a2
 86c:	1782                	slli	a5,a5,0x20
 86e:	9381                	srli	a5,a5,0x20
 870:	97c2                	add	a5,a5,a6
 872:	0007c783          	lbu	a5,0(a5)
 876:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 87a:	87ae                	mv	a5,a1
 87c:	02c5d5bb          	divuw	a1,a1,a2
 880:	0685                	addi	a3,a3,1
 882:	fcc7ffe3          	bgeu	a5,a2,860 <printint+0x2c>
  if(neg)
 886:	00030c63          	beqz	t1,89e <printint+0x6a>
    buf[i++] = '-';
 88a:	fd050793          	addi	a5,a0,-48
 88e:	00878533          	add	a0,a5,s0
 892:	02d00793          	li	a5,45
 896:	fef50823          	sb	a5,-16(a0)
 89a:	0028871b          	addiw	a4,a7,2

  while(--i >= 0)
 89e:	02e05763          	blez	a4,8cc <printint+0x98>
 8a2:	f426                	sd	s1,40(sp)
 8a4:	377d                	addiw	a4,a4,-1
 8a6:	00e984b3          	add	s1,s3,a4
 8aa:	19fd                	addi	s3,s3,-1 # 1999fff <__BSS_END__+0x19951a7>
 8ac:	99ba                	add	s3,s3,a4
 8ae:	1702                	slli	a4,a4,0x20
 8b0:	9301                	srli	a4,a4,0x20
 8b2:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 8b6:	0004c583          	lbu	a1,0(s1)
 8ba:	854a                	mv	a0,s2
 8bc:	00000097          	auipc	ra,0x0
 8c0:	f56080e7          	jalr	-170(ra) # 812 <putc>
  while(--i >= 0)
 8c4:	14fd                	addi	s1,s1,-1
 8c6:	ff3498e3          	bne	s1,s3,8b6 <printint+0x82>
 8ca:	74a2                	ld	s1,40(sp)
}
 8cc:	70e2                	ld	ra,56(sp)
 8ce:	7442                	ld	s0,48(sp)
 8d0:	7902                	ld	s2,32(sp)
 8d2:	69e2                	ld	s3,24(sp)
 8d4:	6121                	addi	sp,sp,64
 8d6:	8082                	ret
  neg = 0;
 8d8:	4301                	li	t1,0
 8da:	bf9d                	j	850 <printint+0x1c>

00000000000008dc <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 8dc:	715d                	addi	sp,sp,-80
 8de:	e486                	sd	ra,72(sp)
 8e0:	e0a2                	sd	s0,64(sp)
 8e2:	f84a                	sd	s2,48(sp)
 8e4:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 8e6:	0005c903          	lbu	s2,0(a1)
 8ea:	1a090b63          	beqz	s2,aa0 <vprintf+0x1c4>
 8ee:	fc26                	sd	s1,56(sp)
 8f0:	f44e                	sd	s3,40(sp)
 8f2:	f052                	sd	s4,32(sp)
 8f4:	ec56                	sd	s5,24(sp)
 8f6:	e85a                	sd	s6,16(sp)
 8f8:	e45e                	sd	s7,8(sp)
 8fa:	8aaa                	mv	s5,a0
 8fc:	8bb2                	mv	s7,a2
 8fe:	00158493          	addi	s1,a1,1
  state = 0;
 902:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 904:	02500a13          	li	s4,37
 908:	4b55                	li	s6,21
 90a:	a839                	j	928 <vprintf+0x4c>
        putc(fd, c);
 90c:	85ca                	mv	a1,s2
 90e:	8556                	mv	a0,s5
 910:	00000097          	auipc	ra,0x0
 914:	f02080e7          	jalr	-254(ra) # 812 <putc>
 918:	a019                	j	91e <vprintf+0x42>
    } else if(state == '%'){
 91a:	01498d63          	beq	s3,s4,934 <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
 91e:	0485                	addi	s1,s1,1
 920:	fff4c903          	lbu	s2,-1(s1)
 924:	16090863          	beqz	s2,a94 <vprintf+0x1b8>
    if(state == 0){
 928:	fe0999e3          	bnez	s3,91a <vprintf+0x3e>
      if(c == '%'){
 92c:	ff4910e3          	bne	s2,s4,90c <vprintf+0x30>
        state = '%';
 930:	89d2                	mv	s3,s4
 932:	b7f5                	j	91e <vprintf+0x42>
      if(c == 'd'){
 934:	13490563          	beq	s2,s4,a5e <vprintf+0x182>
 938:	f9d9079b          	addiw	a5,s2,-99
 93c:	0ff7f793          	zext.b	a5,a5
 940:	12fb6863          	bltu	s6,a5,a70 <vprintf+0x194>
 944:	f9d9079b          	addiw	a5,s2,-99
 948:	0ff7f713          	zext.b	a4,a5
 94c:	12eb6263          	bltu	s6,a4,a70 <vprintf+0x194>
 950:	00271793          	slli	a5,a4,0x2
 954:	00000717          	auipc	a4,0x0
 958:	47470713          	addi	a4,a4,1140 # dc8 <malloc+0x234>
 95c:	97ba                	add	a5,a5,a4
 95e:	439c                	lw	a5,0(a5)
 960:	97ba                	add	a5,a5,a4
 962:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 964:	008b8913          	addi	s2,s7,8
 968:	4685                	li	a3,1
 96a:	4629                	li	a2,10
 96c:	000ba583          	lw	a1,0(s7)
 970:	8556                	mv	a0,s5
 972:	00000097          	auipc	ra,0x0
 976:	ec2080e7          	jalr	-318(ra) # 834 <printint>
 97a:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 97c:	4981                	li	s3,0
 97e:	b745                	j	91e <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
 980:	008b8913          	addi	s2,s7,8
 984:	4681                	li	a3,0
 986:	4629                	li	a2,10
 988:	000ba583          	lw	a1,0(s7)
 98c:	8556                	mv	a0,s5
 98e:	00000097          	auipc	ra,0x0
 992:	ea6080e7          	jalr	-346(ra) # 834 <printint>
 996:	8bca                	mv	s7,s2
      state = 0;
 998:	4981                	li	s3,0
 99a:	b751                	j	91e <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
 99c:	008b8913          	addi	s2,s7,8
 9a0:	4681                	li	a3,0
 9a2:	4641                	li	a2,16
 9a4:	000ba583          	lw	a1,0(s7)
 9a8:	8556                	mv	a0,s5
 9aa:	00000097          	auipc	ra,0x0
 9ae:	e8a080e7          	jalr	-374(ra) # 834 <printint>
 9b2:	8bca                	mv	s7,s2
      state = 0;
 9b4:	4981                	li	s3,0
 9b6:	b7a5                	j	91e <vprintf+0x42>
 9b8:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
 9ba:	008b8793          	addi	a5,s7,8
 9be:	8c3e                	mv	s8,a5
 9c0:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 9c4:	03000593          	li	a1,48
 9c8:	8556                	mv	a0,s5
 9ca:	00000097          	auipc	ra,0x0
 9ce:	e48080e7          	jalr	-440(ra) # 812 <putc>
  putc(fd, 'x');
 9d2:	07800593          	li	a1,120
 9d6:	8556                	mv	a0,s5
 9d8:	00000097          	auipc	ra,0x0
 9dc:	e3a080e7          	jalr	-454(ra) # 812 <putc>
 9e0:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 9e2:	00000b97          	auipc	s7,0x0
 9e6:	43eb8b93          	addi	s7,s7,1086 # e20 <digits>
 9ea:	03c9d793          	srli	a5,s3,0x3c
 9ee:	97de                	add	a5,a5,s7
 9f0:	0007c583          	lbu	a1,0(a5)
 9f4:	8556                	mv	a0,s5
 9f6:	00000097          	auipc	ra,0x0
 9fa:	e1c080e7          	jalr	-484(ra) # 812 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 9fe:	0992                	slli	s3,s3,0x4
 a00:	397d                	addiw	s2,s2,-1
 a02:	fe0914e3          	bnez	s2,9ea <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
 a06:	8be2                	mv	s7,s8
      state = 0;
 a08:	4981                	li	s3,0
 a0a:	6c02                	ld	s8,0(sp)
 a0c:	bf09                	j	91e <vprintf+0x42>
        s = va_arg(ap, char*);
 a0e:	008b8993          	addi	s3,s7,8
 a12:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 a16:	02090163          	beqz	s2,a38 <vprintf+0x15c>
        while(*s != 0){
 a1a:	00094583          	lbu	a1,0(s2)
 a1e:	c9a5                	beqz	a1,a8e <vprintf+0x1b2>
          putc(fd, *s);
 a20:	8556                	mv	a0,s5
 a22:	00000097          	auipc	ra,0x0
 a26:	df0080e7          	jalr	-528(ra) # 812 <putc>
          s++;
 a2a:	0905                	addi	s2,s2,1
        while(*s != 0){
 a2c:	00094583          	lbu	a1,0(s2)
 a30:	f9e5                	bnez	a1,a20 <vprintf+0x144>
        s = va_arg(ap, char*);
 a32:	8bce                	mv	s7,s3
      state = 0;
 a34:	4981                	li	s3,0
 a36:	b5e5                	j	91e <vprintf+0x42>
          s = "(null)";
 a38:	00000917          	auipc	s2,0x0
 a3c:	38890913          	addi	s2,s2,904 # dc0 <malloc+0x22c>
        while(*s != 0){
 a40:	02800593          	li	a1,40
 a44:	bff1                	j	a20 <vprintf+0x144>
        putc(fd, va_arg(ap, uint));
 a46:	008b8913          	addi	s2,s7,8
 a4a:	000bc583          	lbu	a1,0(s7)
 a4e:	8556                	mv	a0,s5
 a50:	00000097          	auipc	ra,0x0
 a54:	dc2080e7          	jalr	-574(ra) # 812 <putc>
 a58:	8bca                	mv	s7,s2
      state = 0;
 a5a:	4981                	li	s3,0
 a5c:	b5c9                	j	91e <vprintf+0x42>
        putc(fd, c);
 a5e:	02500593          	li	a1,37
 a62:	8556                	mv	a0,s5
 a64:	00000097          	auipc	ra,0x0
 a68:	dae080e7          	jalr	-594(ra) # 812 <putc>
      state = 0;
 a6c:	4981                	li	s3,0
 a6e:	bd45                	j	91e <vprintf+0x42>
        putc(fd, '%');
 a70:	02500593          	li	a1,37
 a74:	8556                	mv	a0,s5
 a76:	00000097          	auipc	ra,0x0
 a7a:	d9c080e7          	jalr	-612(ra) # 812 <putc>
        putc(fd, c);
 a7e:	85ca                	mv	a1,s2
 a80:	8556                	mv	a0,s5
 a82:	00000097          	auipc	ra,0x0
 a86:	d90080e7          	jalr	-624(ra) # 812 <putc>
      state = 0;
 a8a:	4981                	li	s3,0
 a8c:	bd49                	j	91e <vprintf+0x42>
        s = va_arg(ap, char*);
 a8e:	8bce                	mv	s7,s3
      state = 0;
 a90:	4981                	li	s3,0
 a92:	b571                	j	91e <vprintf+0x42>
 a94:	74e2                	ld	s1,56(sp)
 a96:	79a2                	ld	s3,40(sp)
 a98:	7a02                	ld	s4,32(sp)
 a9a:	6ae2                	ld	s5,24(sp)
 a9c:	6b42                	ld	s6,16(sp)
 a9e:	6ba2                	ld	s7,8(sp)
    }
  }
}
 aa0:	60a6                	ld	ra,72(sp)
 aa2:	6406                	ld	s0,64(sp)
 aa4:	7942                	ld	s2,48(sp)
 aa6:	6161                	addi	sp,sp,80
 aa8:	8082                	ret

0000000000000aaa <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 aaa:	715d                	addi	sp,sp,-80
 aac:	ec06                	sd	ra,24(sp)
 aae:	e822                	sd	s0,16(sp)
 ab0:	1000                	addi	s0,sp,32
 ab2:	e010                	sd	a2,0(s0)
 ab4:	e414                	sd	a3,8(s0)
 ab6:	e818                	sd	a4,16(s0)
 ab8:	ec1c                	sd	a5,24(s0)
 aba:	03043023          	sd	a6,32(s0)
 abe:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 ac2:	8622                	mv	a2,s0
 ac4:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 ac8:	00000097          	auipc	ra,0x0
 acc:	e14080e7          	jalr	-492(ra) # 8dc <vprintf>
}
 ad0:	60e2                	ld	ra,24(sp)
 ad2:	6442                	ld	s0,16(sp)
 ad4:	6161                	addi	sp,sp,80
 ad6:	8082                	ret

0000000000000ad8 <printf>:

void
printf(const char *fmt, ...)
{
 ad8:	711d                	addi	sp,sp,-96
 ada:	ec06                	sd	ra,24(sp)
 adc:	e822                	sd	s0,16(sp)
 ade:	1000                	addi	s0,sp,32
 ae0:	e40c                	sd	a1,8(s0)
 ae2:	e810                	sd	a2,16(s0)
 ae4:	ec14                	sd	a3,24(s0)
 ae6:	f018                	sd	a4,32(s0)
 ae8:	f41c                	sd	a5,40(s0)
 aea:	03043823          	sd	a6,48(s0)
 aee:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 af2:	00840613          	addi	a2,s0,8
 af6:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 afa:	85aa                	mv	a1,a0
 afc:	4505                	li	a0,1
 afe:	00000097          	auipc	ra,0x0
 b02:	dde080e7          	jalr	-546(ra) # 8dc <vprintf>
}
 b06:	60e2                	ld	ra,24(sp)
 b08:	6442                	ld	s0,16(sp)
 b0a:	6125                	addi	sp,sp,96
 b0c:	8082                	ret

0000000000000b0e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 b0e:	1141                	addi	sp,sp,-16
 b10:	e406                	sd	ra,8(sp)
 b12:	e022                	sd	s0,0(sp)
 b14:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 b16:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b1a:	00000797          	auipc	a5,0x0
 b1e:	3267b783          	ld	a5,806(a5) # e40 <freep>
 b22:	a039                	j	b30 <free+0x22>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b24:	6398                	ld	a4,0(a5)
 b26:	00e7e463          	bltu	a5,a4,b2e <free+0x20>
 b2a:	00e6ea63          	bltu	a3,a4,b3e <free+0x30>
{
 b2e:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b30:	fed7fae3          	bgeu	a5,a3,b24 <free+0x16>
 b34:	6398                	ld	a4,0(a5)
 b36:	00e6e463          	bltu	a3,a4,b3e <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b3a:	fee7eae3          	bltu	a5,a4,b2e <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 b3e:	ff852583          	lw	a1,-8(a0)
 b42:	6390                	ld	a2,0(a5)
 b44:	02059813          	slli	a6,a1,0x20
 b48:	01c85713          	srli	a4,a6,0x1c
 b4c:	9736                	add	a4,a4,a3
 b4e:	02e60563          	beq	a2,a4,b78 <free+0x6a>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 b52:	fec53823          	sd	a2,-16(a0)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 b56:	4790                	lw	a2,8(a5)
 b58:	02061593          	slli	a1,a2,0x20
 b5c:	01c5d713          	srli	a4,a1,0x1c
 b60:	973e                	add	a4,a4,a5
 b62:	02e68263          	beq	a3,a4,b86 <free+0x78>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 b66:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 b68:	00000717          	auipc	a4,0x0
 b6c:	2cf73c23          	sd	a5,728(a4) # e40 <freep>
}
 b70:	60a2                	ld	ra,8(sp)
 b72:	6402                	ld	s0,0(sp)
 b74:	0141                	addi	sp,sp,16
 b76:	8082                	ret
    bp->s.size += p->s.ptr->s.size;
 b78:	4618                	lw	a4,8(a2)
 b7a:	9f2d                	addw	a4,a4,a1
 b7c:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 b80:	6398                	ld	a4,0(a5)
 b82:	6310                	ld	a2,0(a4)
 b84:	b7f9                	j	b52 <free+0x44>
    p->s.size += bp->s.size;
 b86:	ff852703          	lw	a4,-8(a0)
 b8a:	9f31                	addw	a4,a4,a2
 b8c:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 b8e:	ff053683          	ld	a3,-16(a0)
 b92:	bfd1                	j	b66 <free+0x58>

0000000000000b94 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 b94:	7139                	addi	sp,sp,-64
 b96:	fc06                	sd	ra,56(sp)
 b98:	f822                	sd	s0,48(sp)
 b9a:	f04a                	sd	s2,32(sp)
 b9c:	ec4e                	sd	s3,24(sp)
 b9e:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 ba0:	02051993          	slli	s3,a0,0x20
 ba4:	0209d993          	srli	s3,s3,0x20
 ba8:	09bd                	addi	s3,s3,15
 baa:	0049d993          	srli	s3,s3,0x4
 bae:	2985                	addiw	s3,s3,1
 bb0:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 bb2:	00000517          	auipc	a0,0x0
 bb6:	28e53503          	ld	a0,654(a0) # e40 <freep>
 bba:	c905                	beqz	a0,bea <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 bbc:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 bbe:	4798                	lw	a4,8(a5)
 bc0:	09377a63          	bgeu	a4,s3,c54 <malloc+0xc0>
 bc4:	f426                	sd	s1,40(sp)
 bc6:	e852                	sd	s4,16(sp)
 bc8:	e456                	sd	s5,8(sp)
 bca:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 bcc:	8a4e                	mv	s4,s3
 bce:	6705                	lui	a4,0x1
 bd0:	00e9f363          	bgeu	s3,a4,bd6 <malloc+0x42>
 bd4:	6a05                	lui	s4,0x1
 bd6:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 bda:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 bde:	00000497          	auipc	s1,0x0
 be2:	26248493          	addi	s1,s1,610 # e40 <freep>
  if(p == (char*)-1)
 be6:	5afd                	li	s5,-1
 be8:	a089                	j	c2a <malloc+0x96>
 bea:	f426                	sd	s1,40(sp)
 bec:	e852                	sd	s4,16(sp)
 bee:	e456                	sd	s5,8(sp)
 bf0:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 bf2:	00004797          	auipc	a5,0x4
 bf6:	25678793          	addi	a5,a5,598 # 4e48 <base>
 bfa:	00000717          	auipc	a4,0x0
 bfe:	24f73323          	sd	a5,582(a4) # e40 <freep>
 c02:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 c04:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 c08:	b7d1                	j	bcc <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 c0a:	6398                	ld	a4,0(a5)
 c0c:	e118                	sd	a4,0(a0)
 c0e:	a8b9                	j	c6c <malloc+0xd8>
  hp->s.size = nu;
 c10:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 c14:	0541                	addi	a0,a0,16
 c16:	00000097          	auipc	ra,0x0
 c1a:	ef8080e7          	jalr	-264(ra) # b0e <free>
  return freep;
 c1e:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 c20:	c135                	beqz	a0,c84 <malloc+0xf0>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 c22:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 c24:	4798                	lw	a4,8(a5)
 c26:	03277363          	bgeu	a4,s2,c4c <malloc+0xb8>
    if(p == freep)
 c2a:	6098                	ld	a4,0(s1)
 c2c:	853e                	mv	a0,a5
 c2e:	fef71ae3          	bne	a4,a5,c22 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 c32:	8552                	mv	a0,s4
 c34:	00000097          	auipc	ra,0x0
 c38:	bbe080e7          	jalr	-1090(ra) # 7f2 <sbrk>
  if(p == (char*)-1)
 c3c:	fd551ae3          	bne	a0,s5,c10 <malloc+0x7c>
        return 0;
 c40:	4501                	li	a0,0
 c42:	74a2                	ld	s1,40(sp)
 c44:	6a42                	ld	s4,16(sp)
 c46:	6aa2                	ld	s5,8(sp)
 c48:	6b02                	ld	s6,0(sp)
 c4a:	a03d                	j	c78 <malloc+0xe4>
 c4c:	74a2                	ld	s1,40(sp)
 c4e:	6a42                	ld	s4,16(sp)
 c50:	6aa2                	ld	s5,8(sp)
 c52:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 c54:	fae90be3          	beq	s2,a4,c0a <malloc+0x76>
        p->s.size -= nunits;
 c58:	4137073b          	subw	a4,a4,s3
 c5c:	c798                	sw	a4,8(a5)
        p += p->s.size;
 c5e:	02071693          	slli	a3,a4,0x20
 c62:	01c6d713          	srli	a4,a3,0x1c
 c66:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 c68:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 c6c:	00000717          	auipc	a4,0x0
 c70:	1ca73a23          	sd	a0,468(a4) # e40 <freep>
      return (void*)(p + 1);
 c74:	01078513          	addi	a0,a5,16
  }
}
 c78:	70e2                	ld	ra,56(sp)
 c7a:	7442                	ld	s0,48(sp)
 c7c:	7902                	ld	s2,32(sp)
 c7e:	69e2                	ld	s3,24(sp)
 c80:	6121                	addi	sp,sp,64
 c82:	8082                	ret
 c84:	74a2                	ld	s1,40(sp)
 c86:	6a42                	ld	s4,16(sp)
 c88:	6aa2                	ld	s5,8(sp)
 c8a:	6b02                	ld	s6,0(sp)
 c8c:	b7f5                	j	c78 <malloc+0xe4>
