
user/_testsh：     文件格式 elf64-littleriscv


Disassembly of section .text:

0000000000000000 <rand>:

// return a random integer.
// from Wikipedia, linear congruential generator, glibc's constants.
unsigned int
rand()
{
       0:	1141                	addi	sp,sp,-16
       2:	e406                	sd	ra,8(sp)
       4:	e022                	sd	s0,0(sp)
       6:	0800                	addi	s0,sp,16
  unsigned int a = 1103515245;
  unsigned int c = 12345;
  unsigned int m = (1 << 31);
  seed = (a * seed + c) % m;
       8:	00002717          	auipc	a4,0x2
       c:	90470713          	addi	a4,a4,-1788 # 190c <seed>
      10:	4314                	lw	a3,0(a4)
      12:	41c657b7          	lui	a5,0x41c65
      16:	e6d7879b          	addiw	a5,a5,-403 # 41c64e6d <__global_pointer$+0x41c62d64>
      1a:	02d787bb          	mulw	a5,a5,a3
      1e:	650d                	lui	a0,0x3
      20:	0395051b          	addiw	a0,a0,57 # 3039 <__global_pointer$+0xf30>
      24:	9d3d                	addw	a0,a0,a5
      26:	1506                	slli	a0,a0,0x21
      28:	9105                	srli	a0,a0,0x21
      2a:	c308                	sw	a0,0(a4)
  return seed;
}
      2c:	60a2                	ld	ra,8(sp)
      2e:	6402                	ld	s0,0(sp)
      30:	0141                	addi	sp,sp,16
      32:	8082                	ret

0000000000000034 <randstring>:

// generate a random string of the indicated length.
char *
randstring(char *buf, int n)
{
      34:	715d                	addi	sp,sp,-80
      36:	e486                	sd	ra,72(sp)
      38:	e0a2                	sd	s0,64(sp)
      3a:	e85a                	sd	s6,16(sp)
      3c:	e45e                	sd	s7,8(sp)
      3e:	0880                	addi	s0,sp,80
      40:	8baa                	mv	s7,a0
      42:	8b2e                	mv	s6,a1
  for(int i = 0; i < n-1; i++)
      44:	4785                	li	a5,1
      46:	06b7d563          	bge	a5,a1,b0 <randstring+0x7c>
      4a:	fc26                	sd	s1,56(sp)
      4c:	f84a                	sd	s2,48(sp)
      4e:	f44e                	sd	s3,40(sp)
      50:	f052                	sd	s4,32(sp)
      52:	ec56                	sd	s5,24(sp)
      54:	84aa                	mv	s1,a0
      56:	00f50933          	add	s2,a0,a5
      5a:	ffe5879b          	addiw	a5,a1,-2
      5e:	1782                	slli	a5,a5,0x20
      60:	9381                	srli	a5,a5,0x20
      62:	993e                	add	s2,s2,a5
    buf[i] = "abcdefghijklmnopqrstuvwxyz"[rand() % 26];
      64:	00001a97          	auipc	s5,0x1
      68:	41ca8a93          	addi	s5,s5,1052 # 1480 <malloc+0xfc>
      6c:	4ec4f9b7          	lui	s3,0x4ec4f
      70:	c4f98993          	addi	s3,s3,-945 # 4ec4ec4f <__global_pointer$+0x4ec4cb46>
      74:	4a69                	li	s4,26
      76:	00000097          	auipc	ra,0x0
      7a:	f8a080e7          	jalr	-118(ra) # 0 <rand>
      7e:	02051793          	slli	a5,a0,0x20
      82:	9381                	srli	a5,a5,0x20
      84:	033787b3          	mul	a5,a5,s3
      88:	938d                	srli	a5,a5,0x23
      8a:	02fa07bb          	mulw	a5,s4,a5
      8e:	40f507bb          	subw	a5,a0,a5
      92:	1782                	slli	a5,a5,0x20
      94:	9381                	srli	a5,a5,0x20
      96:	97d6                	add	a5,a5,s5
      98:	0007c783          	lbu	a5,0(a5)
      9c:	00f48023          	sb	a5,0(s1)
  for(int i = 0; i < n-1; i++)
      a0:	0485                	addi	s1,s1,1
      a2:	fd249ae3          	bne	s1,s2,76 <randstring+0x42>
      a6:	74e2                	ld	s1,56(sp)
      a8:	7942                	ld	s2,48(sp)
      aa:	79a2                	ld	s3,40(sp)
      ac:	7a02                	ld	s4,32(sp)
      ae:	6ae2                	ld	s5,24(sp)
  buf[n-1] = '\0';
      b0:	9b5e                	add	s6,s6,s7
      b2:	fe0b0fa3          	sb	zero,-1(s6)
  return buf;
}
      b6:	855e                	mv	a0,s7
      b8:	60a6                	ld	ra,72(sp)
      ba:	6406                	ld	s0,64(sp)
      bc:	6b42                	ld	s6,16(sp)
      be:	6ba2                	ld	s7,8(sp)
      c0:	6161                	addi	sp,sp,80
      c2:	8082                	ret

00000000000000c4 <writefile>:

// create a file with the indicated content.
void
writefile(char *name, char *data)
{
      c4:	7179                	addi	sp,sp,-48
      c6:	f406                	sd	ra,40(sp)
      c8:	f022                	sd	s0,32(sp)
      ca:	ec26                	sd	s1,24(sp)
      cc:	e84a                	sd	s2,16(sp)
      ce:	e44e                	sd	s3,8(sp)
      d0:	1800                	addi	s0,sp,48
      d2:	84aa                	mv	s1,a0
      d4:	892e                	mv	s2,a1
  unlink(name); // since no truncation
      d6:	00001097          	auipc	ra,0x1
      da:	ed4080e7          	jalr	-300(ra) # faa <unlink>
  int fd = open(name, O_CREATE|O_WRONLY);
      de:	20100593          	li	a1,513
      e2:	8526                	mv	a0,s1
      e4:	00001097          	auipc	ra,0x1
      e8:	eb6080e7          	jalr	-330(ra) # f9a <open>
  if(fd < 0){
      ec:	04054363          	bltz	a0,132 <writefile+0x6e>
      f0:	84aa                	mv	s1,a0
    fprintf(2, "testsh: could not write %s\n", name);
    exit(-1);
  }
  if(write(fd, data, strlen(data)) != strlen(data)){
      f2:	854a                	mv	a0,s2
      f4:	00001097          	auipc	ra,0x1
      f8:	c28080e7          	jalr	-984(ra) # d1c <strlen>
      fc:	862a                	mv	a2,a0
      fe:	85ca                	mv	a1,s2
     100:	8526                	mv	a0,s1
     102:	00001097          	auipc	ra,0x1
     106:	e78080e7          	jalr	-392(ra) # f7a <write>
     10a:	89aa                	mv	s3,a0
     10c:	854a                	mv	a0,s2
     10e:	00001097          	auipc	ra,0x1
     112:	c0e080e7          	jalr	-1010(ra) # d1c <strlen>
     116:	02a99d63          	bne	s3,a0,150 <writefile+0x8c>
    fprintf(2, "testsh: write failed\n");
    exit(-1);
  }
  close(fd);
     11a:	8526                	mv	a0,s1
     11c:	00001097          	auipc	ra,0x1
     120:	e66080e7          	jalr	-410(ra) # f82 <close>
}
     124:	70a2                	ld	ra,40(sp)
     126:	7402                	ld	s0,32(sp)
     128:	64e2                	ld	s1,24(sp)
     12a:	6942                	ld	s2,16(sp)
     12c:	69a2                	ld	s3,8(sp)
     12e:	6145                	addi	sp,sp,48
     130:	8082                	ret
    fprintf(2, "testsh: could not write %s\n", name);
     132:	8626                	mv	a2,s1
     134:	00001597          	auipc	a1,0x1
     138:	36c58593          	addi	a1,a1,876 # 14a0 <malloc+0x11c>
     13c:	4509                	li	a0,2
     13e:	00001097          	auipc	ra,0x1
     142:	15c080e7          	jalr	348(ra) # 129a <fprintf>
    exit(-1);
     146:	557d                	li	a0,-1
     148:	00001097          	auipc	ra,0x1
     14c:	e12080e7          	jalr	-494(ra) # f5a <exit>
    fprintf(2, "testsh: write failed\n");
     150:	00001597          	auipc	a1,0x1
     154:	37058593          	addi	a1,a1,880 # 14c0 <malloc+0x13c>
     158:	4509                	li	a0,2
     15a:	00001097          	auipc	ra,0x1
     15e:	140080e7          	jalr	320(ra) # 129a <fprintf>
    exit(-1);
     162:	557d                	li	a0,-1
     164:	00001097          	auipc	ra,0x1
     168:	df6080e7          	jalr	-522(ra) # f5a <exit>

000000000000016c <readfile>:

// return the content of a file.
void
readfile(char *name, char *data, int max)
{
     16c:	7179                	addi	sp,sp,-48
     16e:	f406                	sd	ra,40(sp)
     170:	f022                	sd	s0,32(sp)
     172:	ec26                	sd	s1,24(sp)
     174:	e44e                	sd	s3,8(sp)
     176:	e052                	sd	s4,0(sp)
     178:	1800                	addi	s0,sp,48
     17a:	8a2a                	mv	s4,a0
     17c:	84ae                	mv	s1,a1
     17e:	89b2                	mv	s3,a2
  data[0] = '\0';
     180:	00058023          	sb	zero,0(a1)
  int fd = open(name, 0);
     184:	4581                	li	a1,0
     186:	00001097          	auipc	ra,0x1
     18a:	e14080e7          	jalr	-492(ra) # f9a <open>
  if(fd < 0){
     18e:	02054e63          	bltz	a0,1ca <readfile+0x5e>
     192:	e84a                	sd	s2,16(sp)
     194:	892a                	mv	s2,a0
    fprintf(2, "testsh: open %s failed\n", name);
    return;
  }
  int n = read(fd, data, max-1);
     196:	fff9861b          	addiw	a2,s3,-1
     19a:	85a6                	mv	a1,s1
     19c:	00001097          	auipc	ra,0x1
     1a0:	dd6080e7          	jalr	-554(ra) # f72 <read>
     1a4:	89aa                	mv	s3,a0
  close(fd);
     1a6:	854a                	mv	a0,s2
     1a8:	00001097          	auipc	ra,0x1
     1ac:	dda080e7          	jalr	-550(ra) # f82 <close>
  if(n < 0){
     1b0:	0209c863          	bltz	s3,1e0 <readfile+0x74>
    fprintf(2, "testsh: read %s failed\n", name);
    return;
  }
  data[n] = '\0';
     1b4:	94ce                	add	s1,s1,s3
     1b6:	00048023          	sb	zero,0(s1)
     1ba:	6942                	ld	s2,16(sp)
}
     1bc:	70a2                	ld	ra,40(sp)
     1be:	7402                	ld	s0,32(sp)
     1c0:	64e2                	ld	s1,24(sp)
     1c2:	69a2                	ld	s3,8(sp)
     1c4:	6a02                	ld	s4,0(sp)
     1c6:	6145                	addi	sp,sp,48
     1c8:	8082                	ret
    fprintf(2, "testsh: open %s failed\n", name);
     1ca:	8652                	mv	a2,s4
     1cc:	00001597          	auipc	a1,0x1
     1d0:	30c58593          	addi	a1,a1,780 # 14d8 <malloc+0x154>
     1d4:	4509                	li	a0,2
     1d6:	00001097          	auipc	ra,0x1
     1da:	0c4080e7          	jalr	196(ra) # 129a <fprintf>
    return;
     1de:	bff9                	j	1bc <readfile+0x50>
    fprintf(2, "testsh: read %s failed\n", name);
     1e0:	8652                	mv	a2,s4
     1e2:	00001597          	auipc	a1,0x1
     1e6:	30e58593          	addi	a1,a1,782 # 14f0 <malloc+0x16c>
     1ea:	4509                	li	a0,2
     1ec:	00001097          	auipc	ra,0x1
     1f0:	0ae080e7          	jalr	174(ra) # 129a <fprintf>
    return;
     1f4:	6942                	ld	s2,16(sp)
     1f6:	b7d9                	j	1bc <readfile+0x50>

00000000000001f8 <strstr>:

// look for the small string in the big string;
// return the address in the big string, or 0.
char *
strstr(char *big, char *small)
{
     1f8:	1141                	addi	sp,sp,-16
     1fa:	e406                	sd	ra,8(sp)
     1fc:	e022                	sd	s0,0(sp)
     1fe:	0800                	addi	s0,sp,16
  if(small[0] == '\0')
     200:	0005c883          	lbu	a7,0(a1)
     204:	02088a63          	beqz	a7,238 <strstr+0x40>
    return big;
  for(int i = 0; big[i]; i++){
     208:	00054783          	lbu	a5,0(a0)
     20c:	eb81                	bnez	a5,21c <strstr+0x24>
    }
    if(small[j] == '\0'){
      return big + i;
    }
  }
  return 0;
     20e:	4501                	li	a0,0
     210:	a025                	j	238 <strstr+0x40>
  for(int i = 0; big[i]; i++){
     212:	00180513          	addi	a0,a6,1
     216:	00184783          	lbu	a5,1(a6)
     21a:	c39d                	beqz	a5,240 <strstr+0x48>
    for(j = 0; small[j]; j++){
     21c:	882a                	mv	a6,a0
     21e:	00158693          	addi	a3,a1,1
{
     222:	872a                	mv	a4,a0
    for(j = 0; small[j]; j++){
     224:	87c6                	mv	a5,a7
      if(big[i+j] != small[j]){
     226:	00074603          	lbu	a2,0(a4)
     22a:	fef614e3          	bne	a2,a5,212 <strstr+0x1a>
    for(j = 0; small[j]; j++){
     22e:	0006c783          	lbu	a5,0(a3)
     232:	0705                	addi	a4,a4,1
     234:	0685                	addi	a3,a3,1
     236:	fbe5                	bnez	a5,226 <strstr+0x2e>
}
     238:	60a2                	ld	ra,8(sp)
     23a:	6402                	ld	s0,0(sp)
     23c:	0141                	addi	sp,sp,16
     23e:	8082                	ret
  return 0;
     240:	4501                	li	a0,0
     242:	bfdd                	j	238 <strstr+0x40>

0000000000000244 <one>:
// its input, collect the output, check that the
// output includes the expect argument.
// if tight = 1, don't allow much extraneous output.
int
one(char *cmd, char *expect, int tight)
{
     244:	7149                	addi	sp,sp,-368
     246:	f686                	sd	ra,360(sp)
     248:	f2a2                	sd	s0,352(sp)
     24a:	eea6                	sd	s1,344(sp)
     24c:	eaca                	sd	s2,336(sp)
     24e:	e6ce                	sd	s3,328(sp)
     250:	e2d2                	sd	s4,320(sp)
     252:	fe56                	sd	s5,312(sp)
     254:	1a80                	addi	s0,sp,368
     256:	84aa                	mv	s1,a0
     258:	8a2e                	mv	s4,a1
     25a:	8ab2                	mv	s5,a2
  char infile[12], outfile[12];

  randstring(infile, sizeof(infile));
     25c:	fb040993          	addi	s3,s0,-80
     260:	45b1                	li	a1,12
     262:	854e                	mv	a0,s3
     264:	00000097          	auipc	ra,0x0
     268:	dd0080e7          	jalr	-560(ra) # 34 <randstring>
  randstring(outfile, sizeof(outfile));
     26c:	fa040913          	addi	s2,s0,-96
     270:	45b1                	li	a1,12
     272:	854a                	mv	a0,s2
     274:	00000097          	auipc	ra,0x0
     278:	dc0080e7          	jalr	-576(ra) # 34 <randstring>

  writefile(infile, cmd);
     27c:	85a6                	mv	a1,s1
     27e:	854e                	mv	a0,s3
     280:	00000097          	auipc	ra,0x0
     284:	e44080e7          	jalr	-444(ra) # c4 <writefile>
  unlink(outfile);
     288:	854a                	mv	a0,s2
     28a:	00001097          	auipc	ra,0x1
     28e:	d20080e7          	jalr	-736(ra) # faa <unlink>

  int pid = fork();
     292:	00001097          	auipc	ra,0x1
     296:	cc0080e7          	jalr	-832(ra) # f52 <fork>
  if(pid < 0){
     29a:	04054f63          	bltz	a0,2f8 <one+0xb4>
     29e:	84aa                	mv	s1,a0
    fprintf(2, "testsh: fork() failed\n");
    exit(-1);
  }

  if(pid == 0){
     2a0:	e571                	bnez	a0,36c <one+0x128>
    close(0);
     2a2:	4501                	li	a0,0
     2a4:	00001097          	auipc	ra,0x1
     2a8:	cde080e7          	jalr	-802(ra) # f82 <close>
    if(open(infile, 0) != 0){
     2ac:	4581                	li	a1,0
     2ae:	fb040513          	addi	a0,s0,-80
     2b2:	00001097          	auipc	ra,0x1
     2b6:	ce8080e7          	jalr	-792(ra) # f9a <open>
     2ba:	ed29                	bnez	a0,314 <one+0xd0>
      fprintf(2, "testsh: child open != 0\n");
      exit(-1);
    }
    close(1);
     2bc:	4505                	li	a0,1
     2be:	00001097          	auipc	ra,0x1
     2c2:	cc4080e7          	jalr	-828(ra) # f82 <close>
    if(open(outfile, O_CREATE|O_WRONLY) != 1){
     2c6:	20100593          	li	a1,513
     2ca:	fa040513          	addi	a0,s0,-96
     2ce:	00001097          	auipc	ra,0x1
     2d2:	ccc080e7          	jalr	-820(ra) # f9a <open>
     2d6:	4785                	li	a5,1
     2d8:	04f50c63          	beq	a0,a5,330 <one+0xec>
      fprintf(2, "testsh: child open != 1\n");
     2dc:	00001597          	auipc	a1,0x1
     2e0:	26458593          	addi	a1,a1,612 # 1540 <malloc+0x1bc>
     2e4:	4509                	li	a0,2
     2e6:	00001097          	auipc	ra,0x1
     2ea:	fb4080e7          	jalr	-76(ra) # 129a <fprintf>
      exit(-1);
     2ee:	557d                	li	a0,-1
     2f0:	00001097          	auipc	ra,0x1
     2f4:	c6a080e7          	jalr	-918(ra) # f5a <exit>
    fprintf(2, "testsh: fork() failed\n");
     2f8:	00001597          	auipc	a1,0x1
     2fc:	21058593          	addi	a1,a1,528 # 1508 <malloc+0x184>
     300:	4509                	li	a0,2
     302:	00001097          	auipc	ra,0x1
     306:	f98080e7          	jalr	-104(ra) # 129a <fprintf>
    exit(-1);
     30a:	557d                	li	a0,-1
     30c:	00001097          	auipc	ra,0x1
     310:	c4e080e7          	jalr	-946(ra) # f5a <exit>
      fprintf(2, "testsh: child open != 0\n");
     314:	00001597          	auipc	a1,0x1
     318:	20c58593          	addi	a1,a1,524 # 1520 <malloc+0x19c>
     31c:	4509                	li	a0,2
     31e:	00001097          	auipc	ra,0x1
     322:	f7c080e7          	jalr	-132(ra) # 129a <fprintf>
      exit(-1);
     326:	557d                	li	a0,-1
     328:	00001097          	auipc	ra,0x1
     32c:	c32080e7          	jalr	-974(ra) # f5a <exit>
    }
    char *argv[2];
    argv[0] = shname;
     330:	00001497          	auipc	s1,0x1
     334:	5e048493          	addi	s1,s1,1504 # 1910 <shname>
     338:	6088                	ld	a0,0(s1)
     33a:	e8a43823          	sd	a0,-368(s0)
    argv[1] = 0;
     33e:	e8043c23          	sd	zero,-360(s0)
    exec(shname, argv);
     342:	e9040593          	addi	a1,s0,-368
     346:	00001097          	auipc	ra,0x1
     34a:	c4c080e7          	jalr	-948(ra) # f92 <exec>
    fprintf(2, "testsh: exec %s failed\n", shname);
     34e:	6090                	ld	a2,0(s1)
     350:	00001597          	auipc	a1,0x1
     354:	21058593          	addi	a1,a1,528 # 1560 <malloc+0x1dc>
     358:	4509                	li	a0,2
     35a:	00001097          	auipc	ra,0x1
     35e:	f40080e7          	jalr	-192(ra) # 129a <fprintf>
    exit(-1);
     362:	557d                	li	a0,-1
     364:	00001097          	auipc	ra,0x1
     368:	bf6080e7          	jalr	-1034(ra) # f5a <exit>
  }

  if(wait(0) != pid){
     36c:	4501                	li	a0,0
     36e:	00001097          	auipc	ra,0x1
     372:	bf4080e7          	jalr	-1036(ra) # f62 <wait>
     376:	04951e63          	bne	a0,s1,3d2 <one+0x18e>
    fprintf(2, "testsh: unexpected wait() return\n");
    exit(-1);
  }
  unlink(infile);
     37a:	fb040513          	addi	a0,s0,-80
     37e:	00001097          	auipc	ra,0x1
     382:	c2c080e7          	jalr	-980(ra) # faa <unlink>

  char out[256];
  readfile(outfile, out, sizeof(out));
     386:	ea040493          	addi	s1,s0,-352
     38a:	fa040913          	addi	s2,s0,-96
     38e:	10000613          	li	a2,256
     392:	85a6                	mv	a1,s1
     394:	854a                	mv	a0,s2
     396:	00000097          	auipc	ra,0x0
     39a:	dd6080e7          	jalr	-554(ra) # 16c <readfile>
  unlink(outfile);
     39e:	854a                	mv	a0,s2
     3a0:	00001097          	auipc	ra,0x1
     3a4:	c0a080e7          	jalr	-1014(ra) # faa <unlink>

  if(strstr(out, expect) != 0){
     3a8:	85d2                	mv	a1,s4
     3aa:	8526                	mv	a0,s1
     3ac:	00000097          	auipc	ra,0x0
     3b0:	e4c080e7          	jalr	-436(ra) # 1f8 <strstr>
      fprintf(2, "testsh: saw expected output, but too much else as well\n");
      return 0; // fail
    }
    return 1; // pass
  }
  return 0; // fail
     3b4:	4781                	li	a5,0
  if(strstr(out, expect) != 0){
     3b6:	c501                	beqz	a0,3be <one+0x17a>
    return 1; // pass
     3b8:	4785                	li	a5,1
    if(tight && strlen(out) > strlen(expect) + 10){
     3ba:	020a9a63          	bnez	s5,3ee <one+0x1aa>
}
     3be:	853e                	mv	a0,a5
     3c0:	70b6                	ld	ra,360(sp)
     3c2:	7416                	ld	s0,352(sp)
     3c4:	64f6                	ld	s1,344(sp)
     3c6:	6956                	ld	s2,336(sp)
     3c8:	69b6                	ld	s3,328(sp)
     3ca:	6a16                	ld	s4,320(sp)
     3cc:	7af2                	ld	s5,312(sp)
     3ce:	6175                	addi	sp,sp,368
     3d0:	8082                	ret
    fprintf(2, "testsh: unexpected wait() return\n");
     3d2:	00001597          	auipc	a1,0x1
     3d6:	1a658593          	addi	a1,a1,422 # 1578 <malloc+0x1f4>
     3da:	4509                	li	a0,2
     3dc:	00001097          	auipc	ra,0x1
     3e0:	ebe080e7          	jalr	-322(ra) # 129a <fprintf>
    exit(-1);
     3e4:	557d                	li	a0,-1
     3e6:	00001097          	auipc	ra,0x1
     3ea:	b74080e7          	jalr	-1164(ra) # f5a <exit>
    if(tight && strlen(out) > strlen(expect) + 10){
     3ee:	8526                	mv	a0,s1
     3f0:	00001097          	auipc	ra,0x1
     3f4:	92c080e7          	jalr	-1748(ra) # d1c <strlen>
     3f8:	84aa                	mv	s1,a0
     3fa:	8552                	mv	a0,s4
     3fc:	00001097          	auipc	ra,0x1
     400:	920080e7          	jalr	-1760(ra) # d1c <strlen>
     404:	2529                	addiw	a0,a0,10
    return 1; // pass
     406:	4785                	li	a5,1
    if(tight && strlen(out) > strlen(expect) + 10){
     408:	fa957be3          	bgeu	a0,s1,3be <one+0x17a>
      fprintf(2, "testsh: saw expected output, but too much else as well\n");
     40c:	00001597          	auipc	a1,0x1
     410:	19458593          	addi	a1,a1,404 # 15a0 <malloc+0x21c>
     414:	4509                	li	a0,2
     416:	00001097          	auipc	ra,0x1
     41a:	e84080e7          	jalr	-380(ra) # 129a <fprintf>
      return 0; // fail
     41e:	4781                	li	a5,0
     420:	bf79                	j	3be <one+0x17a>

0000000000000422 <t1>:

// test a command with arguments.
void
t1(int *ok)
{
     422:	1101                	addi	sp,sp,-32
     424:	ec06                	sd	ra,24(sp)
     426:	e822                	sd	s0,16(sp)
     428:	e426                	sd	s1,8(sp)
     42a:	1000                	addi	s0,sp,32
     42c:	84aa                	mv	s1,a0
  printf("simple echo: ");
     42e:	00001517          	auipc	a0,0x1
     432:	1aa50513          	addi	a0,a0,426 # 15d8 <malloc+0x254>
     436:	00001097          	auipc	ra,0x1
     43a:	e92080e7          	jalr	-366(ra) # 12c8 <printf>
  if(one("echo hello goodbye\n", "hello goodbye", 1) == 0){
     43e:	4605                	li	a2,1
     440:	00001597          	auipc	a1,0x1
     444:	1a858593          	addi	a1,a1,424 # 15e8 <malloc+0x264>
     448:	00001517          	auipc	a0,0x1
     44c:	1b050513          	addi	a0,a0,432 # 15f8 <malloc+0x274>
     450:	00000097          	auipc	ra,0x0
     454:	df4080e7          	jalr	-524(ra) # 244 <one>
     458:	e105                	bnez	a0,478 <t1+0x56>
    printf("FAIL\n");
     45a:	00001517          	auipc	a0,0x1
     45e:	1b650513          	addi	a0,a0,438 # 1610 <malloc+0x28c>
     462:	00001097          	auipc	ra,0x1
     466:	e66080e7          	jalr	-410(ra) # 12c8 <printf>
    *ok = 0;
     46a:	0004a023          	sw	zero,0(s1)
  } else {
    printf("PASS\n");
  }
}
     46e:	60e2                	ld	ra,24(sp)
     470:	6442                	ld	s0,16(sp)
     472:	64a2                	ld	s1,8(sp)
     474:	6105                	addi	sp,sp,32
     476:	8082                	ret
    printf("PASS\n");
     478:	00001517          	auipc	a0,0x1
     47c:	1a050513          	addi	a0,a0,416 # 1618 <malloc+0x294>
     480:	00001097          	auipc	ra,0x1
     484:	e48080e7          	jalr	-440(ra) # 12c8 <printf>
}
     488:	b7dd                	j	46e <t1+0x4c>

000000000000048a <t2>:

// test a command with arguments.
void
t2(int *ok)
{
     48a:	1101                	addi	sp,sp,-32
     48c:	ec06                	sd	ra,24(sp)
     48e:	e822                	sd	s0,16(sp)
     490:	e426                	sd	s1,8(sp)
     492:	1000                	addi	s0,sp,32
     494:	84aa                	mv	s1,a0
  printf("simple grep: ");
     496:	00001517          	auipc	a0,0x1
     49a:	18a50513          	addi	a0,a0,394 # 1620 <malloc+0x29c>
     49e:	00001097          	auipc	ra,0x1
     4a2:	e2a080e7          	jalr	-470(ra) # 12c8 <printf>
  if(one("grep constitute README\n", "The code in the files that constitute xv6 is", 1) == 0){
     4a6:	4605                	li	a2,1
     4a8:	00001597          	auipc	a1,0x1
     4ac:	18858593          	addi	a1,a1,392 # 1630 <malloc+0x2ac>
     4b0:	00001517          	auipc	a0,0x1
     4b4:	1b050513          	addi	a0,a0,432 # 1660 <malloc+0x2dc>
     4b8:	00000097          	auipc	ra,0x0
     4bc:	d8c080e7          	jalr	-628(ra) # 244 <one>
     4c0:	e105                	bnez	a0,4e0 <t2+0x56>
    printf("FAIL\n");
     4c2:	00001517          	auipc	a0,0x1
     4c6:	14e50513          	addi	a0,a0,334 # 1610 <malloc+0x28c>
     4ca:	00001097          	auipc	ra,0x1
     4ce:	dfe080e7          	jalr	-514(ra) # 12c8 <printf>
    *ok = 0;
     4d2:	0004a023          	sw	zero,0(s1)
  } else {
    printf("PASS\n");
  }
}
     4d6:	60e2                	ld	ra,24(sp)
     4d8:	6442                	ld	s0,16(sp)
     4da:	64a2                	ld	s1,8(sp)
     4dc:	6105                	addi	sp,sp,32
     4de:	8082                	ret
    printf("PASS\n");
     4e0:	00001517          	auipc	a0,0x1
     4e4:	13850513          	addi	a0,a0,312 # 1618 <malloc+0x294>
     4e8:	00001097          	auipc	ra,0x1
     4ec:	de0080e7          	jalr	-544(ra) # 12c8 <printf>
}
     4f0:	b7dd                	j	4d6 <t2+0x4c>

00000000000004f2 <t3>:

// test a command, then a newline, then another command.
void
t3(int *ok)
{
     4f2:	1101                	addi	sp,sp,-32
     4f4:	ec06                	sd	ra,24(sp)
     4f6:	e822                	sd	s0,16(sp)
     4f8:	e426                	sd	s1,8(sp)
     4fa:	1000                	addi	s0,sp,32
     4fc:	84aa                	mv	s1,a0
  printf("two commands: ");
     4fe:	00001517          	auipc	a0,0x1
     502:	17a50513          	addi	a0,a0,378 # 1678 <malloc+0x2f4>
     506:	00001097          	auipc	ra,0x1
     50a:	dc2080e7          	jalr	-574(ra) # 12c8 <printf>
  if(one("echo x\necho goodbye\n", "goodbye", 1) == 0){
     50e:	4605                	li	a2,1
     510:	00001597          	auipc	a1,0x1
     514:	17858593          	addi	a1,a1,376 # 1688 <malloc+0x304>
     518:	00001517          	auipc	a0,0x1
     51c:	17850513          	addi	a0,a0,376 # 1690 <malloc+0x30c>
     520:	00000097          	auipc	ra,0x0
     524:	d24080e7          	jalr	-732(ra) # 244 <one>
     528:	e105                	bnez	a0,548 <t3+0x56>
    printf("FAIL\n");
     52a:	00001517          	auipc	a0,0x1
     52e:	0e650513          	addi	a0,a0,230 # 1610 <malloc+0x28c>
     532:	00001097          	auipc	ra,0x1
     536:	d96080e7          	jalr	-618(ra) # 12c8 <printf>
    *ok = 0;
     53a:	0004a023          	sw	zero,0(s1)
  } else {
    printf("PASS\n");
  }
}
     53e:	60e2                	ld	ra,24(sp)
     540:	6442                	ld	s0,16(sp)
     542:	64a2                	ld	s1,8(sp)
     544:	6105                	addi	sp,sp,32
     546:	8082                	ret
    printf("PASS\n");
     548:	00001517          	auipc	a0,0x1
     54c:	0d050513          	addi	a0,a0,208 # 1618 <malloc+0x294>
     550:	00001097          	auipc	ra,0x1
     554:	d78080e7          	jalr	-648(ra) # 12c8 <printf>
}
     558:	b7dd                	j	53e <t3+0x4c>

000000000000055a <t4>:

// test output redirection: echo xxx > file
void
t4(int *ok)
{
     55a:	7155                	addi	sp,sp,-208
     55c:	e586                	sd	ra,200(sp)
     55e:	e1a2                	sd	s0,192(sp)
     560:	fd26                	sd	s1,184(sp)
     562:	f94a                	sd	s2,176(sp)
     564:	f54e                	sd	s3,168(sp)
     566:	f152                	sd	s4,160(sp)
     568:	0980                	addi	s0,sp,208
     56a:	8a2a                	mv	s4,a0
  printf("output redirection: ");
     56c:	00001517          	auipc	a0,0x1
     570:	13c50513          	addi	a0,a0,316 # 16a8 <malloc+0x324>
     574:	00001097          	auipc	ra,0x1
     578:	d54080e7          	jalr	-684(ra) # 12c8 <printf>

  char file[16];
  randstring(file, 12);
     57c:	fc040913          	addi	s2,s0,-64
     580:	45b1                	li	a1,12
     582:	854a                	mv	a0,s2
     584:	00000097          	auipc	ra,0x0
     588:	ab0080e7          	jalr	-1360(ra) # 34 <randstring>

  char data[16];
  randstring(data, 12);
     58c:	fb040993          	addi	s3,s0,-80
     590:	45b1                	li	a1,12
     592:	854e                	mv	a0,s3
     594:	00000097          	auipc	ra,0x0
     598:	aa0080e7          	jalr	-1376(ra) # 34 <randstring>

  char cmd[64];
  strcpy(cmd, "echo ");
     59c:	f7040493          	addi	s1,s0,-144
     5a0:	00001597          	auipc	a1,0x1
     5a4:	12058593          	addi	a1,a1,288 # 16c0 <malloc+0x33c>
     5a8:	8526                	mv	a0,s1
     5aa:	00000097          	auipc	ra,0x0
     5ae:	722080e7          	jalr	1826(ra) # ccc <strcpy>
  strcpy(cmd+strlen(cmd), data);
     5b2:	8526                	mv	a0,s1
     5b4:	00000097          	auipc	ra,0x0
     5b8:	768080e7          	jalr	1896(ra) # d1c <strlen>
     5bc:	1502                	slli	a0,a0,0x20
     5be:	9101                	srli	a0,a0,0x20
     5c0:	85ce                	mv	a1,s3
     5c2:	9526                	add	a0,a0,s1
     5c4:	00000097          	auipc	ra,0x0
     5c8:	708080e7          	jalr	1800(ra) # ccc <strcpy>
  strcpy(cmd+strlen(cmd), " > ");
     5cc:	8526                	mv	a0,s1
     5ce:	00000097          	auipc	ra,0x0
     5d2:	74e080e7          	jalr	1870(ra) # d1c <strlen>
     5d6:	1502                	slli	a0,a0,0x20
     5d8:	9101                	srli	a0,a0,0x20
     5da:	00001597          	auipc	a1,0x1
     5de:	0ee58593          	addi	a1,a1,238 # 16c8 <malloc+0x344>
     5e2:	9526                	add	a0,a0,s1
     5e4:	00000097          	auipc	ra,0x0
     5e8:	6e8080e7          	jalr	1768(ra) # ccc <strcpy>
  strcpy(cmd+strlen(cmd), file);
     5ec:	8526                	mv	a0,s1
     5ee:	00000097          	auipc	ra,0x0
     5f2:	72e080e7          	jalr	1838(ra) # d1c <strlen>
     5f6:	1502                	slli	a0,a0,0x20
     5f8:	9101                	srli	a0,a0,0x20
     5fa:	85ca                	mv	a1,s2
     5fc:	9526                	add	a0,a0,s1
     5fe:	00000097          	auipc	ra,0x0
     602:	6ce080e7          	jalr	1742(ra) # ccc <strcpy>
  strcpy(cmd+strlen(cmd), "\n");
     606:	8526                	mv	a0,s1
     608:	00000097          	auipc	ra,0x0
     60c:	714080e7          	jalr	1812(ra) # d1c <strlen>
     610:	1502                	slli	a0,a0,0x20
     612:	9101                	srli	a0,a0,0x20
     614:	00001597          	auipc	a1,0x1
     618:	f8458593          	addi	a1,a1,-124 # 1598 <malloc+0x214>
     61c:	9526                	add	a0,a0,s1
     61e:	00000097          	auipc	ra,0x0
     622:	6ae080e7          	jalr	1710(ra) # ccc <strcpy>

  if(one(cmd, "", 1) == 0){
     626:	4605                	li	a2,1
     628:	00001597          	auipc	a1,0x1
     62c:	f1058593          	addi	a1,a1,-240 # 1538 <malloc+0x1b4>
     630:	8526                	mv	a0,s1
     632:	00000097          	auipc	ra,0x0
     636:	c12080e7          	jalr	-1006(ra) # 244 <one>
     63a:	e90d                	bnez	a0,66c <t4+0x112>
    printf("FAIL\n");
     63c:	00001517          	auipc	a0,0x1
     640:	fd450513          	addi	a0,a0,-44 # 1610 <malloc+0x28c>
     644:	00001097          	auipc	ra,0x1
     648:	c84080e7          	jalr	-892(ra) # 12c8 <printf>
    *ok = 0;
     64c:	000a2023          	sw	zero,0(s4)
    } else {
      printf("PASS\n");
    }
  }

  unlink(file);
     650:	fc040513          	addi	a0,s0,-64
     654:	00001097          	auipc	ra,0x1
     658:	956080e7          	jalr	-1706(ra) # faa <unlink>
}
     65c:	60ae                	ld	ra,200(sp)
     65e:	640e                	ld	s0,192(sp)
     660:	74ea                	ld	s1,184(sp)
     662:	794a                	ld	s2,176(sp)
     664:	79aa                	ld	s3,168(sp)
     666:	7a0a                	ld	s4,160(sp)
     668:	6169                	addi	sp,sp,208
     66a:	8082                	ret
    readfile(file, buf, sizeof(buf));
     66c:	f3040493          	addi	s1,s0,-208
     670:	04000613          	li	a2,64
     674:	85a6                	mv	a1,s1
     676:	fc040513          	addi	a0,s0,-64
     67a:	00000097          	auipc	ra,0x0
     67e:	af2080e7          	jalr	-1294(ra) # 16c <readfile>
    if(strstr(buf, data) == 0){
     682:	fb040593          	addi	a1,s0,-80
     686:	8526                	mv	a0,s1
     688:	00000097          	auipc	ra,0x0
     68c:	b70080e7          	jalr	-1168(ra) # 1f8 <strstr>
     690:	c911                	beqz	a0,6a4 <t4+0x14a>
      printf("PASS\n");
     692:	00001517          	auipc	a0,0x1
     696:	f8650513          	addi	a0,a0,-122 # 1618 <malloc+0x294>
     69a:	00001097          	auipc	ra,0x1
     69e:	c2e080e7          	jalr	-978(ra) # 12c8 <printf>
     6a2:	b77d                	j	650 <t4+0xf6>
      printf("FAIL\n");
     6a4:	00001517          	auipc	a0,0x1
     6a8:	f6c50513          	addi	a0,a0,-148 # 1610 <malloc+0x28c>
     6ac:	00001097          	auipc	ra,0x1
     6b0:	c1c080e7          	jalr	-996(ra) # 12c8 <printf>
      *ok = 0;
     6b4:	000a2023          	sw	zero,0(s4)
     6b8:	bf61                	j	650 <t4+0xf6>

00000000000006ba <t5>:

// test input redirection: cat < file
void
t5(int *ok)
{
     6ba:	7175                	addi	sp,sp,-144
     6bc:	e506                	sd	ra,136(sp)
     6be:	e122                	sd	s0,128(sp)
     6c0:	fca6                	sd	s1,120(sp)
     6c2:	f8ca                	sd	s2,112(sp)
     6c4:	f4ce                	sd	s3,104(sp)
     6c6:	f0d2                	sd	s4,96(sp)
     6c8:	0900                	addi	s0,sp,144
     6ca:	8a2a                	mv	s4,a0
  printf("input redirection: ");
     6cc:	00001517          	auipc	a0,0x1
     6d0:	00450513          	addi	a0,a0,4 # 16d0 <malloc+0x34c>
     6d4:	00001097          	auipc	ra,0x1
     6d8:	bf4080e7          	jalr	-1036(ra) # 12c8 <printf>

  char file[32];
  randstring(file, 12);
     6dc:	fb040993          	addi	s3,s0,-80
     6e0:	45b1                	li	a1,12
     6e2:	854e                	mv	a0,s3
     6e4:	00000097          	auipc	ra,0x0
     6e8:	950080e7          	jalr	-1712(ra) # 34 <randstring>

  char data[32];
  randstring(data, 12);
     6ec:	f9040913          	addi	s2,s0,-112
     6f0:	45b1                	li	a1,12
     6f2:	854a                	mv	a0,s2
     6f4:	00000097          	auipc	ra,0x0
     6f8:	940080e7          	jalr	-1728(ra) # 34 <randstring>
  writefile(file, data);
     6fc:	85ca                	mv	a1,s2
     6fe:	854e                	mv	a0,s3
     700:	00000097          	auipc	ra,0x0
     704:	9c4080e7          	jalr	-1596(ra) # c4 <writefile>

  char cmd[32];
  strcpy(cmd, "cat < ");
     708:	f7040493          	addi	s1,s0,-144
     70c:	00001597          	auipc	a1,0x1
     710:	fdc58593          	addi	a1,a1,-36 # 16e8 <malloc+0x364>
     714:	8526                	mv	a0,s1
     716:	00000097          	auipc	ra,0x0
     71a:	5b6080e7          	jalr	1462(ra) # ccc <strcpy>
  strcpy(cmd+strlen(cmd), file);
     71e:	8526                	mv	a0,s1
     720:	00000097          	auipc	ra,0x0
     724:	5fc080e7          	jalr	1532(ra) # d1c <strlen>
     728:	1502                	slli	a0,a0,0x20
     72a:	9101                	srli	a0,a0,0x20
     72c:	85ce                	mv	a1,s3
     72e:	9526                	add	a0,a0,s1
     730:	00000097          	auipc	ra,0x0
     734:	59c080e7          	jalr	1436(ra) # ccc <strcpy>
  strcpy(cmd+strlen(cmd), "\n");
     738:	8526                	mv	a0,s1
     73a:	00000097          	auipc	ra,0x0
     73e:	5e2080e7          	jalr	1506(ra) # d1c <strlen>
     742:	1502                	slli	a0,a0,0x20
     744:	9101                	srli	a0,a0,0x20
     746:	00001597          	auipc	a1,0x1
     74a:	e5258593          	addi	a1,a1,-430 # 1598 <malloc+0x214>
     74e:	9526                	add	a0,a0,s1
     750:	00000097          	auipc	ra,0x0
     754:	57c080e7          	jalr	1404(ra) # ccc <strcpy>

  if(one(cmd, data, 1) == 0){
     758:	4605                	li	a2,1
     75a:	85ca                	mv	a1,s2
     75c:	8526                	mv	a0,s1
     75e:	00000097          	auipc	ra,0x0
     762:	ae6080e7          	jalr	-1306(ra) # 244 <one>
     766:	e90d                	bnez	a0,798 <t5+0xde>
    printf("FAIL\n");
     768:	00001517          	auipc	a0,0x1
     76c:	ea850513          	addi	a0,a0,-344 # 1610 <malloc+0x28c>
     770:	00001097          	auipc	ra,0x1
     774:	b58080e7          	jalr	-1192(ra) # 12c8 <printf>
    *ok = 0;
     778:	000a2023          	sw	zero,0(s4)
  } else {
    printf("PASS\n");
  }

  unlink(file);
     77c:	fb040513          	addi	a0,s0,-80
     780:	00001097          	auipc	ra,0x1
     784:	82a080e7          	jalr	-2006(ra) # faa <unlink>
}
     788:	60aa                	ld	ra,136(sp)
     78a:	640a                	ld	s0,128(sp)
     78c:	74e6                	ld	s1,120(sp)
     78e:	7946                	ld	s2,112(sp)
     790:	79a6                	ld	s3,104(sp)
     792:	7a06                	ld	s4,96(sp)
     794:	6149                	addi	sp,sp,144
     796:	8082                	ret
    printf("PASS\n");
     798:	00001517          	auipc	a0,0x1
     79c:	e8050513          	addi	a0,a0,-384 # 1618 <malloc+0x294>
     7a0:	00001097          	auipc	ra,0x1
     7a4:	b28080e7          	jalr	-1240(ra) # 12c8 <printf>
     7a8:	bfd1                	j	77c <t5+0xc2>

00000000000007aa <t6>:

// test a command with both input and output redirection.
void
t6(int *ok)
{
     7aa:	711d                	addi	sp,sp,-96
     7ac:	ec86                	sd	ra,88(sp)
     7ae:	e8a2                	sd	s0,80(sp)
     7b0:	e4a6                	sd	s1,72(sp)
     7b2:	1080                	addi	s0,sp,96
     7b4:	84aa                	mv	s1,a0
  printf("both redirections: ");
     7b6:	00001517          	auipc	a0,0x1
     7ba:	f3a50513          	addi	a0,a0,-198 # 16f0 <malloc+0x36c>
     7be:	00001097          	auipc	ra,0x1
     7c2:	b0a080e7          	jalr	-1270(ra) # 12c8 <printf>
  unlink("testsh.out");
     7c6:	00001517          	auipc	a0,0x1
     7ca:	f4250513          	addi	a0,a0,-190 # 1708 <malloc+0x384>
     7ce:	00000097          	auipc	ra,0x0
     7d2:	7dc080e7          	jalr	2012(ra) # faa <unlink>
  if(one("grep pointers < README > testsh.out\n", "", 1) == 0){
     7d6:	4605                	li	a2,1
     7d8:	00001597          	auipc	a1,0x1
     7dc:	d6058593          	addi	a1,a1,-672 # 1538 <malloc+0x1b4>
     7e0:	00001517          	auipc	a0,0x1
     7e4:	f3850513          	addi	a0,a0,-200 # 1718 <malloc+0x394>
     7e8:	00000097          	auipc	ra,0x0
     7ec:	a5c080e7          	jalr	-1444(ra) # 244 <one>
     7f0:	e905                	bnez	a0,820 <t6+0x76>
    printf("FAIL\n");
     7f2:	00001517          	auipc	a0,0x1
     7f6:	e1e50513          	addi	a0,a0,-482 # 1610 <malloc+0x28c>
     7fa:	00001097          	auipc	ra,0x1
     7fe:	ace080e7          	jalr	-1330(ra) # 12c8 <printf>
    *ok = 0;
     802:	0004a023          	sw	zero,0(s1)
      *ok = 0;
    } else {
      printf("PASS\n");
    }
  }
  unlink("testsh.out");
     806:	00001517          	auipc	a0,0x1
     80a:	f0250513          	addi	a0,a0,-254 # 1708 <malloc+0x384>
     80e:	00000097          	auipc	ra,0x0
     812:	79c080e7          	jalr	1948(ra) # faa <unlink>
}
     816:	60e6                	ld	ra,88(sp)
     818:	6446                	ld	s0,80(sp)
     81a:	64a6                	ld	s1,72(sp)
     81c:	6125                	addi	sp,sp,96
     81e:	8082                	ret
    readfile("testsh.out", buf, sizeof(buf));
     820:	04000613          	li	a2,64
     824:	fa040593          	addi	a1,s0,-96
     828:	00001517          	auipc	a0,0x1
     82c:	ee050513          	addi	a0,a0,-288 # 1708 <malloc+0x384>
     830:	00000097          	auipc	ra,0x0
     834:	93c080e7          	jalr	-1732(ra) # 16c <readfile>
    if(strstr(buf, "provides pointers to on-line resources") == 0){
     838:	00001597          	auipc	a1,0x1
     83c:	f0858593          	addi	a1,a1,-248 # 1740 <malloc+0x3bc>
     840:	fa040513          	addi	a0,s0,-96
     844:	00000097          	auipc	ra,0x0
     848:	9b4080e7          	jalr	-1612(ra) # 1f8 <strstr>
     84c:	c911                	beqz	a0,860 <t6+0xb6>
      printf("PASS\n");
     84e:	00001517          	auipc	a0,0x1
     852:	dca50513          	addi	a0,a0,-566 # 1618 <malloc+0x294>
     856:	00001097          	auipc	ra,0x1
     85a:	a72080e7          	jalr	-1422(ra) # 12c8 <printf>
     85e:	b765                	j	806 <t6+0x5c>
      printf("FAIL\n");
     860:	00001517          	auipc	a0,0x1
     864:	db050513          	addi	a0,a0,-592 # 1610 <malloc+0x28c>
     868:	00001097          	auipc	ra,0x1
     86c:	a60080e7          	jalr	-1440(ra) # 12c8 <printf>
      *ok = 0;
     870:	0004a023          	sw	zero,0(s1)
     874:	bf49                	j	806 <t6+0x5c>

0000000000000876 <t7>:

// test a pipe with cat filename | cat.
void
t7(int *ok)
{
     876:	7171                	addi	sp,sp,-176
     878:	f506                	sd	ra,168(sp)
     87a:	f122                	sd	s0,160(sp)
     87c:	ed26                	sd	s1,152(sp)
     87e:	e94a                	sd	s2,144(sp)
     880:	e54e                	sd	s3,136(sp)
     882:	e152                	sd	s4,128(sp)
     884:	1900                	addi	s0,sp,176
     886:	8a2a                	mv	s4,a0
  printf("simple pipe: ");
     888:	00001517          	auipc	a0,0x1
     88c:	ee050513          	addi	a0,a0,-288 # 1768 <malloc+0x3e4>
     890:	00001097          	auipc	ra,0x1
     894:	a38080e7          	jalr	-1480(ra) # 12c8 <printf>

  char name[32], data[32];
  randstring(name, 12);
     898:	fb040993          	addi	s3,s0,-80
     89c:	45b1                	li	a1,12
     89e:	854e                	mv	a0,s3
     8a0:	fffff097          	auipc	ra,0xfffff
     8a4:	794080e7          	jalr	1940(ra) # 34 <randstring>
  randstring(data, 12);
     8a8:	f9040913          	addi	s2,s0,-112
     8ac:	45b1                	li	a1,12
     8ae:	854a                	mv	a0,s2
     8b0:	fffff097          	auipc	ra,0xfffff
     8b4:	784080e7          	jalr	1924(ra) # 34 <randstring>
  writefile(name, data);
     8b8:	85ca                	mv	a1,s2
     8ba:	854e                	mv	a0,s3
     8bc:	00000097          	auipc	ra,0x0
     8c0:	808080e7          	jalr	-2040(ra) # c4 <writefile>

  char cmd[64];
  strcpy(cmd, "cat ");
     8c4:	f5040493          	addi	s1,s0,-176
     8c8:	00001597          	auipc	a1,0x1
     8cc:	eb058593          	addi	a1,a1,-336 # 1778 <malloc+0x3f4>
     8d0:	8526                	mv	a0,s1
     8d2:	00000097          	auipc	ra,0x0
     8d6:	3fa080e7          	jalr	1018(ra) # ccc <strcpy>
  strcpy(cmd + strlen(cmd), name);
     8da:	8526                	mv	a0,s1
     8dc:	00000097          	auipc	ra,0x0
     8e0:	440080e7          	jalr	1088(ra) # d1c <strlen>
     8e4:	1502                	slli	a0,a0,0x20
     8e6:	9101                	srli	a0,a0,0x20
     8e8:	85ce                	mv	a1,s3
     8ea:	9526                	add	a0,a0,s1
     8ec:	00000097          	auipc	ra,0x0
     8f0:	3e0080e7          	jalr	992(ra) # ccc <strcpy>
  strcpy(cmd + strlen(cmd), " | cat\n");
     8f4:	8526                	mv	a0,s1
     8f6:	00000097          	auipc	ra,0x0
     8fa:	426080e7          	jalr	1062(ra) # d1c <strlen>
     8fe:	1502                	slli	a0,a0,0x20
     900:	9101                	srli	a0,a0,0x20
     902:	00001597          	auipc	a1,0x1
     906:	e7e58593          	addi	a1,a1,-386 # 1780 <malloc+0x3fc>
     90a:	9526                	add	a0,a0,s1
     90c:	00000097          	auipc	ra,0x0
     910:	3c0080e7          	jalr	960(ra) # ccc <strcpy>
  
  if(one(cmd, data, 1) == 0){
     914:	4605                	li	a2,1
     916:	85ca                	mv	a1,s2
     918:	8526                	mv	a0,s1
     91a:	00000097          	auipc	ra,0x0
     91e:	92a080e7          	jalr	-1750(ra) # 244 <one>
     922:	e90d                	bnez	a0,954 <t7+0xde>
    printf("FAIL\n");
     924:	00001517          	auipc	a0,0x1
     928:	cec50513          	addi	a0,a0,-788 # 1610 <malloc+0x28c>
     92c:	00001097          	auipc	ra,0x1
     930:	99c080e7          	jalr	-1636(ra) # 12c8 <printf>
    *ok = 0;
     934:	000a2023          	sw	zero,0(s4)
  } else {
    printf("PASS\n");
  }

  unlink(name);
     938:	fb040513          	addi	a0,s0,-80
     93c:	00000097          	auipc	ra,0x0
     940:	66e080e7          	jalr	1646(ra) # faa <unlink>
}
     944:	70aa                	ld	ra,168(sp)
     946:	740a                	ld	s0,160(sp)
     948:	64ea                	ld	s1,152(sp)
     94a:	694a                	ld	s2,144(sp)
     94c:	69aa                	ld	s3,136(sp)
     94e:	6a0a                	ld	s4,128(sp)
     950:	614d                	addi	sp,sp,176
     952:	8082                	ret
    printf("PASS\n");
     954:	00001517          	auipc	a0,0x1
     958:	cc450513          	addi	a0,a0,-828 # 1618 <malloc+0x294>
     95c:	00001097          	auipc	ra,0x1
     960:	96c080e7          	jalr	-1684(ra) # 12c8 <printf>
     964:	bfd1                	j	938 <t7+0xc2>

0000000000000966 <t8>:

// test a pipeline that has both redirection and a pipe.
void
t8(int *ok)
{
     966:	711d                	addi	sp,sp,-96
     968:	ec86                	sd	ra,88(sp)
     96a:	e8a2                	sd	s0,80(sp)
     96c:	e4a6                	sd	s1,72(sp)
     96e:	1080                	addi	s0,sp,96
     970:	84aa                	mv	s1,a0
  printf("pipe and redirects: ");
     972:	00001517          	auipc	a0,0x1
     976:	e1650513          	addi	a0,a0,-490 # 1788 <malloc+0x404>
     97a:	00001097          	auipc	ra,0x1
     97e:	94e080e7          	jalr	-1714(ra) # 12c8 <printf>
  
  if(one("grep suggestions < README | wc > testsh.out\n", "", 1) == 0){
     982:	4605                	li	a2,1
     984:	00001597          	auipc	a1,0x1
     988:	bb458593          	addi	a1,a1,-1100 # 1538 <malloc+0x1b4>
     98c:	00001517          	auipc	a0,0x1
     990:	e1450513          	addi	a0,a0,-492 # 17a0 <malloc+0x41c>
     994:	00000097          	auipc	ra,0x0
     998:	8b0080e7          	jalr	-1872(ra) # 244 <one>
     99c:	e905                	bnez	a0,9cc <t8+0x66>
    printf("FAIL\n");
     99e:	00001517          	auipc	a0,0x1
     9a2:	c7250513          	addi	a0,a0,-910 # 1610 <malloc+0x28c>
     9a6:	00001097          	auipc	ra,0x1
     9aa:	922080e7          	jalr	-1758(ra) # 12c8 <printf>
    *ok = 0;
     9ae:	0004a023          	sw	zero,0(s1)
    } else {
      printf("PASS\n");
    }
  }

  unlink("testsh.out");
     9b2:	00001517          	auipc	a0,0x1
     9b6:	d5650513          	addi	a0,a0,-682 # 1708 <malloc+0x384>
     9ba:	00000097          	auipc	ra,0x0
     9be:	5f0080e7          	jalr	1520(ra) # faa <unlink>
}
     9c2:	60e6                	ld	ra,88(sp)
     9c4:	6446                	ld	s0,80(sp)
     9c6:	64a6                	ld	s1,72(sp)
     9c8:	6125                	addi	sp,sp,96
     9ca:	8082                	ret
    readfile("testsh.out", buf, sizeof(buf));
     9cc:	04000613          	li	a2,64
     9d0:	fa040593          	addi	a1,s0,-96
     9d4:	00001517          	auipc	a0,0x1
     9d8:	d3450513          	addi	a0,a0,-716 # 1708 <malloc+0x384>
     9dc:	fffff097          	auipc	ra,0xfffff
     9e0:	790080e7          	jalr	1936(ra) # 16c <readfile>
    if(strstr(buf, "1 11 71") == 0){
     9e4:	00001597          	auipc	a1,0x1
     9e8:	dec58593          	addi	a1,a1,-532 # 17d0 <malloc+0x44c>
     9ec:	fa040513          	addi	a0,s0,-96
     9f0:	00000097          	auipc	ra,0x0
     9f4:	808080e7          	jalr	-2040(ra) # 1f8 <strstr>
     9f8:	c911                	beqz	a0,a0c <t8+0xa6>
      printf("PASS\n");
     9fa:	00001517          	auipc	a0,0x1
     9fe:	c1e50513          	addi	a0,a0,-994 # 1618 <malloc+0x294>
     a02:	00001097          	auipc	ra,0x1
     a06:	8c6080e7          	jalr	-1850(ra) # 12c8 <printf>
     a0a:	b765                	j	9b2 <t8+0x4c>
      printf("FAIL\n");
     a0c:	00001517          	auipc	a0,0x1
     a10:	c0450513          	addi	a0,a0,-1020 # 1610 <malloc+0x28c>
     a14:	00001097          	auipc	ra,0x1
     a18:	8b4080e7          	jalr	-1868(ra) # 12c8 <printf>
      *ok = 0;
     a1c:	0004a023          	sw	zero,0(s1)
     a20:	bf49                	j	9b2 <t8+0x4c>

0000000000000a22 <t9>:

// ask the shell to execute many commands, to check
// if it leaks file descriptors.
void
t9(int *ok)
{
     a22:	711d                	addi	sp,sp,-96
     a24:	ec86                	sd	ra,88(sp)
     a26:	e8a2                	sd	s0,80(sp)
     a28:	e4a6                	sd	s1,72(sp)
     a2a:	e0ca                	sd	s2,64(sp)
     a2c:	fc4e                	sd	s3,56(sp)
     a2e:	f852                	sd	s4,48(sp)
     a30:	f456                	sd	s5,40(sp)
     a32:	f05a                	sd	s6,32(sp)
     a34:	1080                	addi	s0,sp,96
     a36:	8b2a                	mv	s6,a0
  printf("lots of commands: ");
     a38:	00001517          	auipc	a0,0x1
     a3c:	da050513          	addi	a0,a0,-608 # 17d8 <malloc+0x454>
     a40:	00001097          	auipc	ra,0x1
     a44:	888080e7          	jalr	-1912(ra) # 12c8 <printf>

  char term[32];
  randstring(term, 12);
     a48:	45b1                	li	a1,12
     a4a:	fa040513          	addi	a0,s0,-96
     a4e:	fffff097          	auipc	ra,0xfffff
     a52:	5e6080e7          	jalr	1510(ra) # 34 <randstring>
  
  char *cmd = malloc(25 * 36 + 100);
     a56:	3e800513          	li	a0,1000
     a5a:	00001097          	auipc	ra,0x1
     a5e:	92a080e7          	jalr	-1750(ra) # 1384 <malloc>
  if(cmd == 0){
     a62:	c50d                	beqz	a0,a8c <t9+0x6a>
     a64:	84aa                	mv	s1,a0
    fprintf(2, "testsh: malloc failed\n");
    exit(-1);
  }

  cmd[0] = '\0';
     a66:	00050023          	sb	zero,0(a0)
  for(int i = 0; i < 17+(rand()%6); i++){
     a6a:	4901                	li	s2,0
     a6c:	000ab9b7          	lui	s3,0xab
     a70:	aab98993          	addi	s3,s3,-1365 # aaaab <__global_pointer$+0xa89a2>
     a74:	09b2                	slli	s3,s3,0xc
     a76:	aab98993          	addi	s3,s3,-1365
    strcpy(cmd + strlen(cmd), "echo x < README > tso\n");
     a7a:	00001a97          	auipc	s5,0x1
     a7e:	d8ea8a93          	addi	s5,s5,-626 # 1808 <malloc+0x484>
    strcpy(cmd + strlen(cmd), "echo x | echo\n");
     a82:	00001a17          	auipc	s4,0x1
     a86:	d9ea0a13          	addi	s4,s4,-610 # 1820 <malloc+0x49c>
  for(int i = 0; i < 17+(rand()%6); i++){
     a8a:	a891                	j	ade <t9+0xbc>
    fprintf(2, "testsh: malloc failed\n");
     a8c:	00001597          	auipc	a1,0x1
     a90:	d6458593          	addi	a1,a1,-668 # 17f0 <malloc+0x46c>
     a94:	4509                	li	a0,2
     a96:	00001097          	auipc	ra,0x1
     a9a:	804080e7          	jalr	-2044(ra) # 129a <fprintf>
    exit(-1);
     a9e:	557d                	li	a0,-1
     aa0:	00000097          	auipc	ra,0x0
     aa4:	4ba080e7          	jalr	1210(ra) # f5a <exit>
    strcpy(cmd + strlen(cmd), "echo x < README > tso\n");
     aa8:	8526                	mv	a0,s1
     aaa:	00000097          	auipc	ra,0x0
     aae:	272080e7          	jalr	626(ra) # d1c <strlen>
     ab2:	1502                	slli	a0,a0,0x20
     ab4:	9101                	srli	a0,a0,0x20
     ab6:	85d6                	mv	a1,s5
     ab8:	9526                	add	a0,a0,s1
     aba:	00000097          	auipc	ra,0x0
     abe:	212080e7          	jalr	530(ra) # ccc <strcpy>
    strcpy(cmd + strlen(cmd), "echo x | echo\n");
     ac2:	8526                	mv	a0,s1
     ac4:	00000097          	auipc	ra,0x0
     ac8:	258080e7          	jalr	600(ra) # d1c <strlen>
     acc:	1502                	slli	a0,a0,0x20
     ace:	9101                	srli	a0,a0,0x20
     ad0:	85d2                	mv	a1,s4
     ad2:	9526                	add	a0,a0,s1
     ad4:	00000097          	auipc	ra,0x0
     ad8:	1f8080e7          	jalr	504(ra) # ccc <strcpy>
  for(int i = 0; i < 17+(rand()%6); i++){
     adc:	2905                	addiw	s2,s2,1
     ade:	fffff097          	auipc	ra,0xfffff
     ae2:	522080e7          	jalr	1314(ra) # 0 <rand>
     ae6:	02051793          	slli	a5,a0,0x20
     aea:	9381                	srli	a5,a5,0x20
     aec:	033787b3          	mul	a5,a5,s3
     af0:	9389                	srli	a5,a5,0x22
     af2:	0017971b          	slliw	a4,a5,0x1
     af6:	9fb9                	addw	a5,a5,a4
     af8:	0017979b          	slliw	a5,a5,0x1
     afc:	9d1d                	subw	a0,a0,a5
     afe:	0115079b          	addiw	a5,a0,17
     b02:	faf963e3          	bltu	s2,a5,aa8 <t9+0x86>
  }
  strcpy(cmd + strlen(cmd), "echo ");
     b06:	8526                	mv	a0,s1
     b08:	00000097          	auipc	ra,0x0
     b0c:	214080e7          	jalr	532(ra) # d1c <strlen>
     b10:	1502                	slli	a0,a0,0x20
     b12:	9101                	srli	a0,a0,0x20
     b14:	00001597          	auipc	a1,0x1
     b18:	bac58593          	addi	a1,a1,-1108 # 16c0 <malloc+0x33c>
     b1c:	9526                	add	a0,a0,s1
     b1e:	00000097          	auipc	ra,0x0
     b22:	1ae080e7          	jalr	430(ra) # ccc <strcpy>
  strcpy(cmd + strlen(cmd), term);
     b26:	8526                	mv	a0,s1
     b28:	00000097          	auipc	ra,0x0
     b2c:	1f4080e7          	jalr	500(ra) # d1c <strlen>
     b30:	fa040913          	addi	s2,s0,-96
     b34:	1502                	slli	a0,a0,0x20
     b36:	9101                	srli	a0,a0,0x20
     b38:	85ca                	mv	a1,s2
     b3a:	9526                	add	a0,a0,s1
     b3c:	00000097          	auipc	ra,0x0
     b40:	190080e7          	jalr	400(ra) # ccc <strcpy>
  strcpy(cmd + strlen(cmd), " > tso\n");
     b44:	8526                	mv	a0,s1
     b46:	00000097          	auipc	ra,0x0
     b4a:	1d6080e7          	jalr	470(ra) # d1c <strlen>
     b4e:	1502                	slli	a0,a0,0x20
     b50:	9101                	srli	a0,a0,0x20
     b52:	00001597          	auipc	a1,0x1
     b56:	cde58593          	addi	a1,a1,-802 # 1830 <malloc+0x4ac>
     b5a:	9526                	add	a0,a0,s1
     b5c:	00000097          	auipc	ra,0x0
     b60:	170080e7          	jalr	368(ra) # ccc <strcpy>
  strcpy(cmd + strlen(cmd), "cat < tso\n");
     b64:	8526                	mv	a0,s1
     b66:	00000097          	auipc	ra,0x0
     b6a:	1b6080e7          	jalr	438(ra) # d1c <strlen>
     b6e:	1502                	slli	a0,a0,0x20
     b70:	9101                	srli	a0,a0,0x20
     b72:	00001597          	auipc	a1,0x1
     b76:	cc658593          	addi	a1,a1,-826 # 1838 <malloc+0x4b4>
     b7a:	9526                	add	a0,a0,s1
     b7c:	00000097          	auipc	ra,0x0
     b80:	150080e7          	jalr	336(ra) # ccc <strcpy>

  if(one(cmd, term, 0) == 0){
     b84:	4601                	li	a2,0
     b86:	85ca                	mv	a1,s2
     b88:	8526                	mv	a0,s1
     b8a:	fffff097          	auipc	ra,0xfffff
     b8e:	6ba080e7          	jalr	1722(ra) # 244 <one>
     b92:	e131                	bnez	a0,bd6 <t9+0x1b4>
    printf("FAIL\n");
     b94:	00001517          	auipc	a0,0x1
     b98:	a7c50513          	addi	a0,a0,-1412 # 1610 <malloc+0x28c>
     b9c:	00000097          	auipc	ra,0x0
     ba0:	72c080e7          	jalr	1836(ra) # 12c8 <printf>
    *ok = 0;
     ba4:	000b2023          	sw	zero,0(s6)
  } else {
    printf("PASS\n");
  }

  unlink("tso");
     ba8:	00001517          	auipc	a0,0x1
     bac:	ca050513          	addi	a0,a0,-864 # 1848 <malloc+0x4c4>
     bb0:	00000097          	auipc	ra,0x0
     bb4:	3fa080e7          	jalr	1018(ra) # faa <unlink>
  free(cmd);
     bb8:	8526                	mv	a0,s1
     bba:	00000097          	auipc	ra,0x0
     bbe:	744080e7          	jalr	1860(ra) # 12fe <free>
}
     bc2:	60e6                	ld	ra,88(sp)
     bc4:	6446                	ld	s0,80(sp)
     bc6:	64a6                	ld	s1,72(sp)
     bc8:	6906                	ld	s2,64(sp)
     bca:	79e2                	ld	s3,56(sp)
     bcc:	7a42                	ld	s4,48(sp)
     bce:	7aa2                	ld	s5,40(sp)
     bd0:	7b02                	ld	s6,32(sp)
     bd2:	6125                	addi	sp,sp,96
     bd4:	8082                	ret
    printf("PASS\n");
     bd6:	00001517          	auipc	a0,0x1
     bda:	a4250513          	addi	a0,a0,-1470 # 1618 <malloc+0x294>
     bde:	00000097          	auipc	ra,0x0
     be2:	6ea080e7          	jalr	1770(ra) # 12c8 <printf>
     be6:	b7c9                	j	ba8 <t9+0x186>

0000000000000be8 <main>:

int
main(int argc, char *argv[])
{
     be8:	7179                	addi	sp,sp,-48
     bea:	f406                	sd	ra,40(sp)
     bec:	f022                	sd	s0,32(sp)
     bee:	1800                	addi	s0,sp,48
  if(argc != 2){
     bf0:	4789                	li	a5,2
     bf2:	02f50163          	beq	a0,a5,c14 <main+0x2c>
     bf6:	ec26                	sd	s1,24(sp)
    fprintf(2, "Usage: testsh nsh\n");
     bf8:	00001597          	auipc	a1,0x1
     bfc:	c5858593          	addi	a1,a1,-936 # 1850 <malloc+0x4cc>
     c00:	853e                	mv	a0,a5
     c02:	00000097          	auipc	ra,0x0
     c06:	698080e7          	jalr	1688(ra) # 129a <fprintf>
    exit(-1);
     c0a:	557d                	li	a0,-1
     c0c:	00000097          	auipc	ra,0x0
     c10:	34e080e7          	jalr	846(ra) # f5a <exit>
     c14:	ec26                	sd	s1,24(sp)
  }
  shname = argv[1];
     c16:	659c                	ld	a5,8(a1)
     c18:	00001717          	auipc	a4,0x1
     c1c:	cef73c23          	sd	a5,-776(a4) # 1910 <shname>
  
  seed += getpid();
     c20:	00000097          	auipc	ra,0x0
     c24:	3ba080e7          	jalr	954(ra) # fda <getpid>
     c28:	00001717          	auipc	a4,0x1
     c2c:	ce470713          	addi	a4,a4,-796 # 190c <seed>
     c30:	431c                	lw	a5,0(a4)
     c32:	9fa9                	addw	a5,a5,a0
     c34:	c31c                	sw	a5,0(a4)

  int ok = 1;
     c36:	4785                	li	a5,1
     c38:	fcf42e23          	sw	a5,-36(s0)

  t1(&ok);
     c3c:	fdc40493          	addi	s1,s0,-36
     c40:	8526                	mv	a0,s1
     c42:	fffff097          	auipc	ra,0xfffff
     c46:	7e0080e7          	jalr	2016(ra) # 422 <t1>
  t2(&ok);
     c4a:	8526                	mv	a0,s1
     c4c:	00000097          	auipc	ra,0x0
     c50:	83e080e7          	jalr	-1986(ra) # 48a <t2>
  t3(&ok);
     c54:	8526                	mv	a0,s1
     c56:	00000097          	auipc	ra,0x0
     c5a:	89c080e7          	jalr	-1892(ra) # 4f2 <t3>
  t4(&ok);
     c5e:	8526                	mv	a0,s1
     c60:	00000097          	auipc	ra,0x0
     c64:	8fa080e7          	jalr	-1798(ra) # 55a <t4>
  t5(&ok);
     c68:	8526                	mv	a0,s1
     c6a:	00000097          	auipc	ra,0x0
     c6e:	a50080e7          	jalr	-1456(ra) # 6ba <t5>
  t6(&ok);
     c72:	8526                	mv	a0,s1
     c74:	00000097          	auipc	ra,0x0
     c78:	b36080e7          	jalr	-1226(ra) # 7aa <t6>
  t7(&ok);
     c7c:	8526                	mv	a0,s1
     c7e:	00000097          	auipc	ra,0x0
     c82:	bf8080e7          	jalr	-1032(ra) # 876 <t7>
  t8(&ok);
     c86:	8526                	mv	a0,s1
     c88:	00000097          	auipc	ra,0x0
     c8c:	cde080e7          	jalr	-802(ra) # 966 <t8>
  t9(&ok);
     c90:	8526                	mv	a0,s1
     c92:	00000097          	auipc	ra,0x0
     c96:	d90080e7          	jalr	-624(ra) # a22 <t9>

  if(ok){
     c9a:	fdc42783          	lw	a5,-36(s0)
     c9e:	cf91                	beqz	a5,cba <main+0xd2>
    printf("passed all tests\n");
     ca0:	00001517          	auipc	a0,0x1
     ca4:	bc850513          	addi	a0,a0,-1080 # 1868 <malloc+0x4e4>
     ca8:	00000097          	auipc	ra,0x0
     cac:	620080e7          	jalr	1568(ra) # 12c8 <printf>
  } else {
    printf("failed some tests\n");
  }
  
  exit(0);
     cb0:	4501                	li	a0,0
     cb2:	00000097          	auipc	ra,0x0
     cb6:	2a8080e7          	jalr	680(ra) # f5a <exit>
    printf("failed some tests\n");
     cba:	00001517          	auipc	a0,0x1
     cbe:	bc650513          	addi	a0,a0,-1082 # 1880 <malloc+0x4fc>
     cc2:	00000097          	auipc	ra,0x0
     cc6:	606080e7          	jalr	1542(ra) # 12c8 <printf>
     cca:	b7dd                	j	cb0 <main+0xc8>

0000000000000ccc <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
     ccc:	1141                	addi	sp,sp,-16
     cce:	e406                	sd	ra,8(sp)
     cd0:	e022                	sd	s0,0(sp)
     cd2:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     cd4:	87aa                	mv	a5,a0
     cd6:	0585                	addi	a1,a1,1
     cd8:	0785                	addi	a5,a5,1
     cda:	fff5c703          	lbu	a4,-1(a1)
     cde:	fee78fa3          	sb	a4,-1(a5)
     ce2:	fb75                	bnez	a4,cd6 <strcpy+0xa>
    ;
  return os;
}
     ce4:	60a2                	ld	ra,8(sp)
     ce6:	6402                	ld	s0,0(sp)
     ce8:	0141                	addi	sp,sp,16
     cea:	8082                	ret

0000000000000cec <strcmp>:

int
strcmp(const char *p, const char *q)
{
     cec:	1141                	addi	sp,sp,-16
     cee:	e406                	sd	ra,8(sp)
     cf0:	e022                	sd	s0,0(sp)
     cf2:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
     cf4:	00054783          	lbu	a5,0(a0)
     cf8:	cb91                	beqz	a5,d0c <strcmp+0x20>
     cfa:	0005c703          	lbu	a4,0(a1)
     cfe:	00f71763          	bne	a4,a5,d0c <strcmp+0x20>
    p++, q++;
     d02:	0505                	addi	a0,a0,1
     d04:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
     d06:	00054783          	lbu	a5,0(a0)
     d0a:	fbe5                	bnez	a5,cfa <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
     d0c:	0005c503          	lbu	a0,0(a1)
}
     d10:	40a7853b          	subw	a0,a5,a0
     d14:	60a2                	ld	ra,8(sp)
     d16:	6402                	ld	s0,0(sp)
     d18:	0141                	addi	sp,sp,16
     d1a:	8082                	ret

0000000000000d1c <strlen>:

uint
strlen(const char *s)
{
     d1c:	1141                	addi	sp,sp,-16
     d1e:	e406                	sd	ra,8(sp)
     d20:	e022                	sd	s0,0(sp)
     d22:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
     d24:	00054783          	lbu	a5,0(a0)
     d28:	cf91                	beqz	a5,d44 <strlen+0x28>
     d2a:	00150793          	addi	a5,a0,1
     d2e:	86be                	mv	a3,a5
     d30:	0785                	addi	a5,a5,1
     d32:	fff7c703          	lbu	a4,-1(a5)
     d36:	ff65                	bnez	a4,d2e <strlen+0x12>
     d38:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
     d3c:	60a2                	ld	ra,8(sp)
     d3e:	6402                	ld	s0,0(sp)
     d40:	0141                	addi	sp,sp,16
     d42:	8082                	ret
  for(n = 0; s[n]; n++)
     d44:	4501                	li	a0,0
     d46:	bfdd                	j	d3c <strlen+0x20>

0000000000000d48 <memset>:

void*
memset(void *dst, int c, uint n)
{
     d48:	1141                	addi	sp,sp,-16
     d4a:	e406                	sd	ra,8(sp)
     d4c:	e022                	sd	s0,0(sp)
     d4e:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
     d50:	ca19                	beqz	a2,d66 <memset+0x1e>
     d52:	87aa                	mv	a5,a0
     d54:	1602                	slli	a2,a2,0x20
     d56:	9201                	srli	a2,a2,0x20
     d58:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
     d5c:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
     d60:	0785                	addi	a5,a5,1
     d62:	fee79de3          	bne	a5,a4,d5c <memset+0x14>
  }
  return dst;
}
     d66:	60a2                	ld	ra,8(sp)
     d68:	6402                	ld	s0,0(sp)
     d6a:	0141                	addi	sp,sp,16
     d6c:	8082                	ret

0000000000000d6e <strchr>:

char*
strchr(const char *s, char c)
{
     d6e:	1141                	addi	sp,sp,-16
     d70:	e406                	sd	ra,8(sp)
     d72:	e022                	sd	s0,0(sp)
     d74:	0800                	addi	s0,sp,16
  for(; *s; s++)
     d76:	00054783          	lbu	a5,0(a0)
     d7a:	cf81                	beqz	a5,d92 <strchr+0x24>
    if(*s == c)
     d7c:	00f58763          	beq	a1,a5,d8a <strchr+0x1c>
  for(; *s; s++)
     d80:	0505                	addi	a0,a0,1
     d82:	00054783          	lbu	a5,0(a0)
     d86:	fbfd                	bnez	a5,d7c <strchr+0xe>
      return (char*)s;
  return 0;
     d88:	4501                	li	a0,0
}
     d8a:	60a2                	ld	ra,8(sp)
     d8c:	6402                	ld	s0,0(sp)
     d8e:	0141                	addi	sp,sp,16
     d90:	8082                	ret
  return 0;
     d92:	4501                	li	a0,0
     d94:	bfdd                	j	d8a <strchr+0x1c>

0000000000000d96 <gets>:

char*
gets(char *buf, int max)
{
     d96:	711d                	addi	sp,sp,-96
     d98:	ec86                	sd	ra,88(sp)
     d9a:	e8a2                	sd	s0,80(sp)
     d9c:	e4a6                	sd	s1,72(sp)
     d9e:	e0ca                	sd	s2,64(sp)
     da0:	fc4e                	sd	s3,56(sp)
     da2:	f852                	sd	s4,48(sp)
     da4:	f456                	sd	s5,40(sp)
     da6:	f05a                	sd	s6,32(sp)
     da8:	ec5e                	sd	s7,24(sp)
     daa:	e862                	sd	s8,16(sp)
     dac:	1080                	addi	s0,sp,96
     dae:	8baa                	mv	s7,a0
     db0:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     db2:	892a                	mv	s2,a0
     db4:	4481                	li	s1,0
    cc = read(0, &c, 1);
     db6:	faf40b13          	addi	s6,s0,-81
     dba:	4a85                	li	s5,1
  for(i=0; i+1 < max; ){
     dbc:	8c26                	mv	s8,s1
     dbe:	0014899b          	addiw	s3,s1,1
     dc2:	84ce                	mv	s1,s3
     dc4:	0349d663          	bge	s3,s4,df0 <gets+0x5a>
    cc = read(0, &c, 1);
     dc8:	8656                	mv	a2,s5
     dca:	85da                	mv	a1,s6
     dcc:	4501                	li	a0,0
     dce:	00000097          	auipc	ra,0x0
     dd2:	1a4080e7          	jalr	420(ra) # f72 <read>
    if(cc < 1)
     dd6:	00a05d63          	blez	a0,df0 <gets+0x5a>
      break;
    buf[i++] = c;
     dda:	faf44783          	lbu	a5,-81(s0)
     dde:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
     de2:	0905                	addi	s2,s2,1
     de4:	ff678713          	addi	a4,a5,-10
     de8:	c319                	beqz	a4,dee <gets+0x58>
     dea:	17cd                	addi	a5,a5,-13
     dec:	fbe1                	bnez	a5,dbc <gets+0x26>
    buf[i++] = c;
     dee:	8c4e                	mv	s8,s3
      break;
  }
  buf[i] = '\0';
     df0:	9c5e                	add	s8,s8,s7
     df2:	000c0023          	sb	zero,0(s8)
  return buf;
}
     df6:	855e                	mv	a0,s7
     df8:	60e6                	ld	ra,88(sp)
     dfa:	6446                	ld	s0,80(sp)
     dfc:	64a6                	ld	s1,72(sp)
     dfe:	6906                	ld	s2,64(sp)
     e00:	79e2                	ld	s3,56(sp)
     e02:	7a42                	ld	s4,48(sp)
     e04:	7aa2                	ld	s5,40(sp)
     e06:	7b02                	ld	s6,32(sp)
     e08:	6be2                	ld	s7,24(sp)
     e0a:	6c42                	ld	s8,16(sp)
     e0c:	6125                	addi	sp,sp,96
     e0e:	8082                	ret

0000000000000e10 <stat>:

int
stat(const char *n, struct stat *st)
{
     e10:	1101                	addi	sp,sp,-32
     e12:	ec06                	sd	ra,24(sp)
     e14:	e822                	sd	s0,16(sp)
     e16:	e04a                	sd	s2,0(sp)
     e18:	1000                	addi	s0,sp,32
     e1a:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     e1c:	4581                	li	a1,0
     e1e:	00000097          	auipc	ra,0x0
     e22:	17c080e7          	jalr	380(ra) # f9a <open>
  if(fd < 0)
     e26:	02054663          	bltz	a0,e52 <stat+0x42>
     e2a:	e426                	sd	s1,8(sp)
     e2c:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
     e2e:	85ca                	mv	a1,s2
     e30:	00000097          	auipc	ra,0x0
     e34:	182080e7          	jalr	386(ra) # fb2 <fstat>
     e38:	892a                	mv	s2,a0
  close(fd);
     e3a:	8526                	mv	a0,s1
     e3c:	00000097          	auipc	ra,0x0
     e40:	146080e7          	jalr	326(ra) # f82 <close>
  return r;
     e44:	64a2                	ld	s1,8(sp)
}
     e46:	854a                	mv	a0,s2
     e48:	60e2                	ld	ra,24(sp)
     e4a:	6442                	ld	s0,16(sp)
     e4c:	6902                	ld	s2,0(sp)
     e4e:	6105                	addi	sp,sp,32
     e50:	8082                	ret
    return -1;
     e52:	57fd                	li	a5,-1
     e54:	893e                	mv	s2,a5
     e56:	bfc5                	j	e46 <stat+0x36>

0000000000000e58 <atoi>:

int
atoi(const char *s)
{
     e58:	1141                	addi	sp,sp,-16
     e5a:	e406                	sd	ra,8(sp)
     e5c:	e022                	sd	s0,0(sp)
     e5e:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     e60:	00054683          	lbu	a3,0(a0)
     e64:	fd06879b          	addiw	a5,a3,-48
     e68:	0ff7f793          	zext.b	a5,a5
     e6c:	4625                	li	a2,9
     e6e:	02f66963          	bltu	a2,a5,ea0 <atoi+0x48>
     e72:	872a                	mv	a4,a0
  n = 0;
     e74:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
     e76:	0705                	addi	a4,a4,1
     e78:	0025179b          	slliw	a5,a0,0x2
     e7c:	9fa9                	addw	a5,a5,a0
     e7e:	0017979b          	slliw	a5,a5,0x1
     e82:	9fb5                	addw	a5,a5,a3
     e84:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
     e88:	00074683          	lbu	a3,0(a4)
     e8c:	fd06879b          	addiw	a5,a3,-48
     e90:	0ff7f793          	zext.b	a5,a5
     e94:	fef671e3          	bgeu	a2,a5,e76 <atoi+0x1e>
  return n;
}
     e98:	60a2                	ld	ra,8(sp)
     e9a:	6402                	ld	s0,0(sp)
     e9c:	0141                	addi	sp,sp,16
     e9e:	8082                	ret
  n = 0;
     ea0:	4501                	li	a0,0
     ea2:	bfdd                	j	e98 <atoi+0x40>

0000000000000ea4 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     ea4:	1141                	addi	sp,sp,-16
     ea6:	e406                	sd	ra,8(sp)
     ea8:	e022                	sd	s0,0(sp)
     eaa:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
     eac:	02b57563          	bgeu	a0,a1,ed6 <memmove+0x32>
    while(n-- > 0)
     eb0:	00c05f63          	blez	a2,ece <memmove+0x2a>
     eb4:	1602                	slli	a2,a2,0x20
     eb6:	9201                	srli	a2,a2,0x20
     eb8:	00c507b3          	add	a5,a0,a2
  dst = vdst;
     ebc:	872a                	mv	a4,a0
      *dst++ = *src++;
     ebe:	0585                	addi	a1,a1,1
     ec0:	0705                	addi	a4,a4,1
     ec2:	fff5c683          	lbu	a3,-1(a1)
     ec6:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
     eca:	fee79ae3          	bne	a5,a4,ebe <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
     ece:	60a2                	ld	ra,8(sp)
     ed0:	6402                	ld	s0,0(sp)
     ed2:	0141                	addi	sp,sp,16
     ed4:	8082                	ret
    while(n-- > 0)
     ed6:	fec05ce3          	blez	a2,ece <memmove+0x2a>
    dst += n;
     eda:	00c50733          	add	a4,a0,a2
    src += n;
     ede:	95b2                	add	a1,a1,a2
     ee0:	fff6079b          	addiw	a5,a2,-1
     ee4:	1782                	slli	a5,a5,0x20
     ee6:	9381                	srli	a5,a5,0x20
     ee8:	fff7c793          	not	a5,a5
     eec:	97ba                	add	a5,a5,a4
      *--dst = *--src;
     eee:	15fd                	addi	a1,a1,-1
     ef0:	177d                	addi	a4,a4,-1
     ef2:	0005c683          	lbu	a3,0(a1)
     ef6:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
     efa:	fef71ae3          	bne	a4,a5,eee <memmove+0x4a>
     efe:	bfc1                	j	ece <memmove+0x2a>

0000000000000f00 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     f00:	1141                	addi	sp,sp,-16
     f02:	e406                	sd	ra,8(sp)
     f04:	e022                	sd	s0,0(sp)
     f06:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
     f08:	c61d                	beqz	a2,f36 <memcmp+0x36>
     f0a:	1602                	slli	a2,a2,0x20
     f0c:	9201                	srli	a2,a2,0x20
     f0e:	00c506b3          	add	a3,a0,a2
    if (*p1 != *p2) {
     f12:	00054783          	lbu	a5,0(a0)
     f16:	0005c703          	lbu	a4,0(a1)
     f1a:	00e79863          	bne	a5,a4,f2a <memcmp+0x2a>
      return *p1 - *p2;
    }
    p1++;
     f1e:	0505                	addi	a0,a0,1
    p2++;
     f20:	0585                	addi	a1,a1,1
  while (n-- > 0) {
     f22:	fed518e3          	bne	a0,a3,f12 <memcmp+0x12>
  }
  return 0;
     f26:	4501                	li	a0,0
     f28:	a019                	j	f2e <memcmp+0x2e>
      return *p1 - *p2;
     f2a:	40e7853b          	subw	a0,a5,a4
}
     f2e:	60a2                	ld	ra,8(sp)
     f30:	6402                	ld	s0,0(sp)
     f32:	0141                	addi	sp,sp,16
     f34:	8082                	ret
  return 0;
     f36:	4501                	li	a0,0
     f38:	bfdd                	j	f2e <memcmp+0x2e>

0000000000000f3a <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     f3a:	1141                	addi	sp,sp,-16
     f3c:	e406                	sd	ra,8(sp)
     f3e:	e022                	sd	s0,0(sp)
     f40:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
     f42:	00000097          	auipc	ra,0x0
     f46:	f62080e7          	jalr	-158(ra) # ea4 <memmove>
}
     f4a:	60a2                	ld	ra,8(sp)
     f4c:	6402                	ld	s0,0(sp)
     f4e:	0141                	addi	sp,sp,16
     f50:	8082                	ret

0000000000000f52 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     f52:	4885                	li	a7,1
 ecall
     f54:	00000073          	ecall
 ret
     f58:	8082                	ret

0000000000000f5a <exit>:
.global exit
exit:
 li a7, SYS_exit
     f5a:	4889                	li	a7,2
 ecall
     f5c:	00000073          	ecall
 ret
     f60:	8082                	ret

0000000000000f62 <wait>:
.global wait
wait:
 li a7, SYS_wait
     f62:	488d                	li	a7,3
 ecall
     f64:	00000073          	ecall
 ret
     f68:	8082                	ret

0000000000000f6a <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     f6a:	4891                	li	a7,4
 ecall
     f6c:	00000073          	ecall
 ret
     f70:	8082                	ret

0000000000000f72 <read>:
.global read
read:
 li a7, SYS_read
     f72:	4895                	li	a7,5
 ecall
     f74:	00000073          	ecall
 ret
     f78:	8082                	ret

0000000000000f7a <write>:
.global write
write:
 li a7, SYS_write
     f7a:	48c1                	li	a7,16
 ecall
     f7c:	00000073          	ecall
 ret
     f80:	8082                	ret

0000000000000f82 <close>:
.global close
close:
 li a7, SYS_close
     f82:	48d5                	li	a7,21
 ecall
     f84:	00000073          	ecall
 ret
     f88:	8082                	ret

0000000000000f8a <kill>:
.global kill
kill:
 li a7, SYS_kill
     f8a:	4899                	li	a7,6
 ecall
     f8c:	00000073          	ecall
 ret
     f90:	8082                	ret

0000000000000f92 <exec>:
.global exec
exec:
 li a7, SYS_exec
     f92:	489d                	li	a7,7
 ecall
     f94:	00000073          	ecall
 ret
     f98:	8082                	ret

0000000000000f9a <open>:
.global open
open:
 li a7, SYS_open
     f9a:	48bd                	li	a7,15
 ecall
     f9c:	00000073          	ecall
 ret
     fa0:	8082                	ret

0000000000000fa2 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     fa2:	48c5                	li	a7,17
 ecall
     fa4:	00000073          	ecall
 ret
     fa8:	8082                	ret

0000000000000faa <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     faa:	48c9                	li	a7,18
 ecall
     fac:	00000073          	ecall
 ret
     fb0:	8082                	ret

0000000000000fb2 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     fb2:	48a1                	li	a7,8
 ecall
     fb4:	00000073          	ecall
 ret
     fb8:	8082                	ret

0000000000000fba <link>:
.global link
link:
 li a7, SYS_link
     fba:	48cd                	li	a7,19
 ecall
     fbc:	00000073          	ecall
 ret
     fc0:	8082                	ret

0000000000000fc2 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     fc2:	48d1                	li	a7,20
 ecall
     fc4:	00000073          	ecall
 ret
     fc8:	8082                	ret

0000000000000fca <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     fca:	48a5                	li	a7,9
 ecall
     fcc:	00000073          	ecall
 ret
     fd0:	8082                	ret

0000000000000fd2 <dup>:
.global dup
dup:
 li a7, SYS_dup
     fd2:	48a9                	li	a7,10
 ecall
     fd4:	00000073          	ecall
 ret
     fd8:	8082                	ret

0000000000000fda <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     fda:	48ad                	li	a7,11
 ecall
     fdc:	00000073          	ecall
 ret
     fe0:	8082                	ret

0000000000000fe2 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     fe2:	48b1                	li	a7,12
 ecall
     fe4:	00000073          	ecall
 ret
     fe8:	8082                	ret

0000000000000fea <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     fea:	48b5                	li	a7,13
 ecall
     fec:	00000073          	ecall
 ret
     ff0:	8082                	ret

0000000000000ff2 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     ff2:	48b9                	li	a7,14
 ecall
     ff4:	00000073          	ecall
 ret
     ff8:	8082                	ret

0000000000000ffa <ntas>:
.global ntas
ntas:
 li a7, SYS_ntas
     ffa:	48d9                	li	a7,22
 ecall
     ffc:	00000073          	ecall
 ret
    1000:	8082                	ret

0000000000001002 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    1002:	1101                	addi	sp,sp,-32
    1004:	ec06                	sd	ra,24(sp)
    1006:	e822                	sd	s0,16(sp)
    1008:	1000                	addi	s0,sp,32
    100a:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
    100e:	4605                	li	a2,1
    1010:	fef40593          	addi	a1,s0,-17
    1014:	00000097          	auipc	ra,0x0
    1018:	f66080e7          	jalr	-154(ra) # f7a <write>
}
    101c:	60e2                	ld	ra,24(sp)
    101e:	6442                	ld	s0,16(sp)
    1020:	6105                	addi	sp,sp,32
    1022:	8082                	ret

0000000000001024 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    1024:	7139                	addi	sp,sp,-64
    1026:	fc06                	sd	ra,56(sp)
    1028:	f822                	sd	s0,48(sp)
    102a:	f04a                	sd	s2,32(sp)
    102c:	ec4e                	sd	s3,24(sp)
    102e:	0080                	addi	s0,sp,64
    1030:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    1032:	cad9                	beqz	a3,10c8 <printint+0xa4>
    1034:	01f5d79b          	srliw	a5,a1,0x1f
    1038:	cbc1                	beqz	a5,10c8 <printint+0xa4>
    neg = 1;
    x = -xx;
    103a:	40b005bb          	negw	a1,a1
    neg = 1;
    103e:	4305                	li	t1,1
  } else {
    x = xx;
  }

  i = 0;
    1040:	fc040993          	addi	s3,s0,-64
  neg = 0;
    1044:	86ce                	mv	a3,s3
  i = 0;
    1046:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
    1048:	00001817          	auipc	a6,0x1
    104c:	8b080813          	addi	a6,a6,-1872 # 18f8 <digits>
    1050:	88ba                	mv	a7,a4
    1052:	0017051b          	addiw	a0,a4,1
    1056:	872a                	mv	a4,a0
    1058:	02c5f7bb          	remuw	a5,a1,a2
    105c:	1782                	slli	a5,a5,0x20
    105e:	9381                	srli	a5,a5,0x20
    1060:	97c2                	add	a5,a5,a6
    1062:	0007c783          	lbu	a5,0(a5)
    1066:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
    106a:	87ae                	mv	a5,a1
    106c:	02c5d5bb          	divuw	a1,a1,a2
    1070:	0685                	addi	a3,a3,1
    1072:	fcc7ffe3          	bgeu	a5,a2,1050 <printint+0x2c>
  if(neg)
    1076:	00030c63          	beqz	t1,108e <printint+0x6a>
    buf[i++] = '-';
    107a:	fd050793          	addi	a5,a0,-48
    107e:	00878533          	add	a0,a5,s0
    1082:	02d00793          	li	a5,45
    1086:	fef50823          	sb	a5,-16(a0)
    108a:	0028871b          	addiw	a4,a7,2

  while(--i >= 0)
    108e:	02e05763          	blez	a4,10bc <printint+0x98>
    1092:	f426                	sd	s1,40(sp)
    1094:	377d                	addiw	a4,a4,-1
    1096:	00e984b3          	add	s1,s3,a4
    109a:	19fd                	addi	s3,s3,-1
    109c:	99ba                	add	s3,s3,a4
    109e:	1702                	slli	a4,a4,0x20
    10a0:	9301                	srli	a4,a4,0x20
    10a2:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
    10a6:	0004c583          	lbu	a1,0(s1)
    10aa:	854a                	mv	a0,s2
    10ac:	00000097          	auipc	ra,0x0
    10b0:	f56080e7          	jalr	-170(ra) # 1002 <putc>
  while(--i >= 0)
    10b4:	14fd                	addi	s1,s1,-1
    10b6:	ff3498e3          	bne	s1,s3,10a6 <printint+0x82>
    10ba:	74a2                	ld	s1,40(sp)
}
    10bc:	70e2                	ld	ra,56(sp)
    10be:	7442                	ld	s0,48(sp)
    10c0:	7902                	ld	s2,32(sp)
    10c2:	69e2                	ld	s3,24(sp)
    10c4:	6121                	addi	sp,sp,64
    10c6:	8082                	ret
  neg = 0;
    10c8:	4301                	li	t1,0
    10ca:	bf9d                	j	1040 <printint+0x1c>

00000000000010cc <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    10cc:	715d                	addi	sp,sp,-80
    10ce:	e486                	sd	ra,72(sp)
    10d0:	e0a2                	sd	s0,64(sp)
    10d2:	f84a                	sd	s2,48(sp)
    10d4:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    10d6:	0005c903          	lbu	s2,0(a1)
    10da:	1a090b63          	beqz	s2,1290 <vprintf+0x1c4>
    10de:	fc26                	sd	s1,56(sp)
    10e0:	f44e                	sd	s3,40(sp)
    10e2:	f052                	sd	s4,32(sp)
    10e4:	ec56                	sd	s5,24(sp)
    10e6:	e85a                	sd	s6,16(sp)
    10e8:	e45e                	sd	s7,8(sp)
    10ea:	8aaa                	mv	s5,a0
    10ec:	8bb2                	mv	s7,a2
    10ee:	00158493          	addi	s1,a1,1
  state = 0;
    10f2:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    10f4:	02500a13          	li	s4,37
    10f8:	4b55                	li	s6,21
    10fa:	a839                	j	1118 <vprintf+0x4c>
        putc(fd, c);
    10fc:	85ca                	mv	a1,s2
    10fe:	8556                	mv	a0,s5
    1100:	00000097          	auipc	ra,0x0
    1104:	f02080e7          	jalr	-254(ra) # 1002 <putc>
    1108:	a019                	j	110e <vprintf+0x42>
    } else if(state == '%'){
    110a:	01498d63          	beq	s3,s4,1124 <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
    110e:	0485                	addi	s1,s1,1
    1110:	fff4c903          	lbu	s2,-1(s1)
    1114:	16090863          	beqz	s2,1284 <vprintf+0x1b8>
    if(state == 0){
    1118:	fe0999e3          	bnez	s3,110a <vprintf+0x3e>
      if(c == '%'){
    111c:	ff4910e3          	bne	s2,s4,10fc <vprintf+0x30>
        state = '%';
    1120:	89d2                	mv	s3,s4
    1122:	b7f5                	j	110e <vprintf+0x42>
      if(c == 'd'){
    1124:	13490563          	beq	s2,s4,124e <vprintf+0x182>
    1128:	f9d9079b          	addiw	a5,s2,-99
    112c:	0ff7f793          	zext.b	a5,a5
    1130:	12fb6863          	bltu	s6,a5,1260 <vprintf+0x194>
    1134:	f9d9079b          	addiw	a5,s2,-99
    1138:	0ff7f713          	zext.b	a4,a5
    113c:	12eb6263          	bltu	s6,a4,1260 <vprintf+0x194>
    1140:	00271793          	slli	a5,a4,0x2
    1144:	00000717          	auipc	a4,0x0
    1148:	75c70713          	addi	a4,a4,1884 # 18a0 <malloc+0x51c>
    114c:	97ba                	add	a5,a5,a4
    114e:	439c                	lw	a5,0(a5)
    1150:	97ba                	add	a5,a5,a4
    1152:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
    1154:	008b8913          	addi	s2,s7,8
    1158:	4685                	li	a3,1
    115a:	4629                	li	a2,10
    115c:	000ba583          	lw	a1,0(s7)
    1160:	8556                	mv	a0,s5
    1162:	00000097          	auipc	ra,0x0
    1166:	ec2080e7          	jalr	-318(ra) # 1024 <printint>
    116a:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    116c:	4981                	li	s3,0
    116e:	b745                	j	110e <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
    1170:	008b8913          	addi	s2,s7,8
    1174:	4681                	li	a3,0
    1176:	4629                	li	a2,10
    1178:	000ba583          	lw	a1,0(s7)
    117c:	8556                	mv	a0,s5
    117e:	00000097          	auipc	ra,0x0
    1182:	ea6080e7          	jalr	-346(ra) # 1024 <printint>
    1186:	8bca                	mv	s7,s2
      state = 0;
    1188:	4981                	li	s3,0
    118a:	b751                	j	110e <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
    118c:	008b8913          	addi	s2,s7,8
    1190:	4681                	li	a3,0
    1192:	4641                	li	a2,16
    1194:	000ba583          	lw	a1,0(s7)
    1198:	8556                	mv	a0,s5
    119a:	00000097          	auipc	ra,0x0
    119e:	e8a080e7          	jalr	-374(ra) # 1024 <printint>
    11a2:	8bca                	mv	s7,s2
      state = 0;
    11a4:	4981                	li	s3,0
    11a6:	b7a5                	j	110e <vprintf+0x42>
    11a8:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
    11aa:	008b8793          	addi	a5,s7,8
    11ae:	8c3e                	mv	s8,a5
    11b0:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
    11b4:	03000593          	li	a1,48
    11b8:	8556                	mv	a0,s5
    11ba:	00000097          	auipc	ra,0x0
    11be:	e48080e7          	jalr	-440(ra) # 1002 <putc>
  putc(fd, 'x');
    11c2:	07800593          	li	a1,120
    11c6:	8556                	mv	a0,s5
    11c8:	00000097          	auipc	ra,0x0
    11cc:	e3a080e7          	jalr	-454(ra) # 1002 <putc>
    11d0:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    11d2:	00000b97          	auipc	s7,0x0
    11d6:	726b8b93          	addi	s7,s7,1830 # 18f8 <digits>
    11da:	03c9d793          	srli	a5,s3,0x3c
    11de:	97de                	add	a5,a5,s7
    11e0:	0007c583          	lbu	a1,0(a5)
    11e4:	8556                	mv	a0,s5
    11e6:	00000097          	auipc	ra,0x0
    11ea:	e1c080e7          	jalr	-484(ra) # 1002 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    11ee:	0992                	slli	s3,s3,0x4
    11f0:	397d                	addiw	s2,s2,-1
    11f2:	fe0914e3          	bnez	s2,11da <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
    11f6:	8be2                	mv	s7,s8
      state = 0;
    11f8:	4981                	li	s3,0
    11fa:	6c02                	ld	s8,0(sp)
    11fc:	bf09                	j	110e <vprintf+0x42>
        s = va_arg(ap, char*);
    11fe:	008b8993          	addi	s3,s7,8
    1202:	000bb903          	ld	s2,0(s7)
        if(s == 0)
    1206:	02090163          	beqz	s2,1228 <vprintf+0x15c>
        while(*s != 0){
    120a:	00094583          	lbu	a1,0(s2)
    120e:	c9a5                	beqz	a1,127e <vprintf+0x1b2>
          putc(fd, *s);
    1210:	8556                	mv	a0,s5
    1212:	00000097          	auipc	ra,0x0
    1216:	df0080e7          	jalr	-528(ra) # 1002 <putc>
          s++;
    121a:	0905                	addi	s2,s2,1
        while(*s != 0){
    121c:	00094583          	lbu	a1,0(s2)
    1220:	f9e5                	bnez	a1,1210 <vprintf+0x144>
        s = va_arg(ap, char*);
    1222:	8bce                	mv	s7,s3
      state = 0;
    1224:	4981                	li	s3,0
    1226:	b5e5                	j	110e <vprintf+0x42>
          s = "(null)";
    1228:	00000917          	auipc	s2,0x0
    122c:	67090913          	addi	s2,s2,1648 # 1898 <malloc+0x514>
        while(*s != 0){
    1230:	02800593          	li	a1,40
    1234:	bff1                	j	1210 <vprintf+0x144>
        putc(fd, va_arg(ap, uint));
    1236:	008b8913          	addi	s2,s7,8
    123a:	000bc583          	lbu	a1,0(s7)
    123e:	8556                	mv	a0,s5
    1240:	00000097          	auipc	ra,0x0
    1244:	dc2080e7          	jalr	-574(ra) # 1002 <putc>
    1248:	8bca                	mv	s7,s2
      state = 0;
    124a:	4981                	li	s3,0
    124c:	b5c9                	j	110e <vprintf+0x42>
        putc(fd, c);
    124e:	02500593          	li	a1,37
    1252:	8556                	mv	a0,s5
    1254:	00000097          	auipc	ra,0x0
    1258:	dae080e7          	jalr	-594(ra) # 1002 <putc>
      state = 0;
    125c:	4981                	li	s3,0
    125e:	bd45                	j	110e <vprintf+0x42>
        putc(fd, '%');
    1260:	02500593          	li	a1,37
    1264:	8556                	mv	a0,s5
    1266:	00000097          	auipc	ra,0x0
    126a:	d9c080e7          	jalr	-612(ra) # 1002 <putc>
        putc(fd, c);
    126e:	85ca                	mv	a1,s2
    1270:	8556                	mv	a0,s5
    1272:	00000097          	auipc	ra,0x0
    1276:	d90080e7          	jalr	-624(ra) # 1002 <putc>
      state = 0;
    127a:	4981                	li	s3,0
    127c:	bd49                	j	110e <vprintf+0x42>
        s = va_arg(ap, char*);
    127e:	8bce                	mv	s7,s3
      state = 0;
    1280:	4981                	li	s3,0
    1282:	b571                	j	110e <vprintf+0x42>
    1284:	74e2                	ld	s1,56(sp)
    1286:	79a2                	ld	s3,40(sp)
    1288:	7a02                	ld	s4,32(sp)
    128a:	6ae2                	ld	s5,24(sp)
    128c:	6b42                	ld	s6,16(sp)
    128e:	6ba2                	ld	s7,8(sp)
    }
  }
}
    1290:	60a6                	ld	ra,72(sp)
    1292:	6406                	ld	s0,64(sp)
    1294:	7942                	ld	s2,48(sp)
    1296:	6161                	addi	sp,sp,80
    1298:	8082                	ret

000000000000129a <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    129a:	715d                	addi	sp,sp,-80
    129c:	ec06                	sd	ra,24(sp)
    129e:	e822                	sd	s0,16(sp)
    12a0:	1000                	addi	s0,sp,32
    12a2:	e010                	sd	a2,0(s0)
    12a4:	e414                	sd	a3,8(s0)
    12a6:	e818                	sd	a4,16(s0)
    12a8:	ec1c                	sd	a5,24(s0)
    12aa:	03043023          	sd	a6,32(s0)
    12ae:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    12b2:	8622                	mv	a2,s0
    12b4:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    12b8:	00000097          	auipc	ra,0x0
    12bc:	e14080e7          	jalr	-492(ra) # 10cc <vprintf>
}
    12c0:	60e2                	ld	ra,24(sp)
    12c2:	6442                	ld	s0,16(sp)
    12c4:	6161                	addi	sp,sp,80
    12c6:	8082                	ret

00000000000012c8 <printf>:

void
printf(const char *fmt, ...)
{
    12c8:	711d                	addi	sp,sp,-96
    12ca:	ec06                	sd	ra,24(sp)
    12cc:	e822                	sd	s0,16(sp)
    12ce:	1000                	addi	s0,sp,32
    12d0:	e40c                	sd	a1,8(s0)
    12d2:	e810                	sd	a2,16(s0)
    12d4:	ec14                	sd	a3,24(s0)
    12d6:	f018                	sd	a4,32(s0)
    12d8:	f41c                	sd	a5,40(s0)
    12da:	03043823          	sd	a6,48(s0)
    12de:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    12e2:	00840613          	addi	a2,s0,8
    12e6:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    12ea:	85aa                	mv	a1,a0
    12ec:	4505                	li	a0,1
    12ee:	00000097          	auipc	ra,0x0
    12f2:	dde080e7          	jalr	-546(ra) # 10cc <vprintf>
}
    12f6:	60e2                	ld	ra,24(sp)
    12f8:	6442                	ld	s0,16(sp)
    12fa:	6125                	addi	sp,sp,96
    12fc:	8082                	ret

00000000000012fe <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    12fe:	1141                	addi	sp,sp,-16
    1300:	e406                	sd	ra,8(sp)
    1302:	e022                	sd	s0,0(sp)
    1304:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1306:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    130a:	00000797          	auipc	a5,0x0
    130e:	60e7b783          	ld	a5,1550(a5) # 1918 <freep>
    1312:	a039                	j	1320 <free+0x22>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1314:	6398                	ld	a4,0(a5)
    1316:	00e7e463          	bltu	a5,a4,131e <free+0x20>
    131a:	00e6ea63          	bltu	a3,a4,132e <free+0x30>
{
    131e:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1320:	fed7fae3          	bgeu	a5,a3,1314 <free+0x16>
    1324:	6398                	ld	a4,0(a5)
    1326:	00e6e463          	bltu	a3,a4,132e <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    132a:	fee7eae3          	bltu	a5,a4,131e <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
    132e:	ff852583          	lw	a1,-8(a0)
    1332:	6390                	ld	a2,0(a5)
    1334:	02059813          	slli	a6,a1,0x20
    1338:	01c85713          	srli	a4,a6,0x1c
    133c:	9736                	add	a4,a4,a3
    133e:	02e60563          	beq	a2,a4,1368 <free+0x6a>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
    1342:	fec53823          	sd	a2,-16(a0)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    1346:	4790                	lw	a2,8(a5)
    1348:	02061593          	slli	a1,a2,0x20
    134c:	01c5d713          	srli	a4,a1,0x1c
    1350:	973e                	add	a4,a4,a5
    1352:	02e68263          	beq	a3,a4,1376 <free+0x78>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
    1356:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
    1358:	00000717          	auipc	a4,0x0
    135c:	5cf73023          	sd	a5,1472(a4) # 1918 <freep>
}
    1360:	60a2                	ld	ra,8(sp)
    1362:	6402                	ld	s0,0(sp)
    1364:	0141                	addi	sp,sp,16
    1366:	8082                	ret
    bp->s.size += p->s.ptr->s.size;
    1368:	4618                	lw	a4,8(a2)
    136a:	9f2d                	addw	a4,a4,a1
    136c:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    1370:	6398                	ld	a4,0(a5)
    1372:	6310                	ld	a2,0(a4)
    1374:	b7f9                	j	1342 <free+0x44>
    p->s.size += bp->s.size;
    1376:	ff852703          	lw	a4,-8(a0)
    137a:	9f31                	addw	a4,a4,a2
    137c:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    137e:	ff053683          	ld	a3,-16(a0)
    1382:	bfd1                	j	1356 <free+0x58>

0000000000001384 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1384:	7139                	addi	sp,sp,-64
    1386:	fc06                	sd	ra,56(sp)
    1388:	f822                	sd	s0,48(sp)
    138a:	f04a                	sd	s2,32(sp)
    138c:	ec4e                	sd	s3,24(sp)
    138e:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1390:	02051993          	slli	s3,a0,0x20
    1394:	0209d993          	srli	s3,s3,0x20
    1398:	09bd                	addi	s3,s3,15
    139a:	0049d993          	srli	s3,s3,0x4
    139e:	2985                	addiw	s3,s3,1
    13a0:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
    13a2:	00000517          	auipc	a0,0x0
    13a6:	57653503          	ld	a0,1398(a0) # 1918 <freep>
    13aa:	c905                	beqz	a0,13da <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    13ac:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    13ae:	4798                	lw	a4,8(a5)
    13b0:	09377a63          	bgeu	a4,s3,1444 <malloc+0xc0>
    13b4:	f426                	sd	s1,40(sp)
    13b6:	e852                	sd	s4,16(sp)
    13b8:	e456                	sd	s5,8(sp)
    13ba:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
    13bc:	8a4e                	mv	s4,s3
    13be:	6705                	lui	a4,0x1
    13c0:	00e9f363          	bgeu	s3,a4,13c6 <malloc+0x42>
    13c4:	6a05                	lui	s4,0x1
    13c6:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    13ca:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    13ce:	00000497          	auipc	s1,0x0
    13d2:	54a48493          	addi	s1,s1,1354 # 1918 <freep>
  if(p == (char*)-1)
    13d6:	5afd                	li	s5,-1
    13d8:	a089                	j	141a <malloc+0x96>
    13da:	f426                	sd	s1,40(sp)
    13dc:	e852                	sd	s4,16(sp)
    13de:	e456                	sd	s5,8(sp)
    13e0:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
    13e2:	00000797          	auipc	a5,0x0
    13e6:	53e78793          	addi	a5,a5,1342 # 1920 <base>
    13ea:	00000717          	auipc	a4,0x0
    13ee:	52f73723          	sd	a5,1326(a4) # 1918 <freep>
    13f2:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    13f4:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    13f8:	b7d1                	j	13bc <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
    13fa:	6398                	ld	a4,0(a5)
    13fc:	e118                	sd	a4,0(a0)
    13fe:	a8b9                	j	145c <malloc+0xd8>
  hp->s.size = nu;
    1400:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    1404:	0541                	addi	a0,a0,16
    1406:	00000097          	auipc	ra,0x0
    140a:	ef8080e7          	jalr	-264(ra) # 12fe <free>
  return freep;
    140e:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
    1410:	c135                	beqz	a0,1474 <malloc+0xf0>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1412:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    1414:	4798                	lw	a4,8(a5)
    1416:	03277363          	bgeu	a4,s2,143c <malloc+0xb8>
    if(p == freep)
    141a:	6098                	ld	a4,0(s1)
    141c:	853e                	mv	a0,a5
    141e:	fef71ae3          	bne	a4,a5,1412 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
    1422:	8552                	mv	a0,s4
    1424:	00000097          	auipc	ra,0x0
    1428:	bbe080e7          	jalr	-1090(ra) # fe2 <sbrk>
  if(p == (char*)-1)
    142c:	fd551ae3          	bne	a0,s5,1400 <malloc+0x7c>
        return 0;
    1430:	4501                	li	a0,0
    1432:	74a2                	ld	s1,40(sp)
    1434:	6a42                	ld	s4,16(sp)
    1436:	6aa2                	ld	s5,8(sp)
    1438:	6b02                	ld	s6,0(sp)
    143a:	a03d                	j	1468 <malloc+0xe4>
    143c:	74a2                	ld	s1,40(sp)
    143e:	6a42                	ld	s4,16(sp)
    1440:	6aa2                	ld	s5,8(sp)
    1442:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
    1444:	fae90be3          	beq	s2,a4,13fa <malloc+0x76>
        p->s.size -= nunits;
    1448:	4137073b          	subw	a4,a4,s3
    144c:	c798                	sw	a4,8(a5)
        p += p->s.size;
    144e:	02071693          	slli	a3,a4,0x20
    1452:	01c6d713          	srli	a4,a3,0x1c
    1456:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    1458:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    145c:	00000717          	auipc	a4,0x0
    1460:	4aa73e23          	sd	a0,1212(a4) # 1918 <freep>
      return (void*)(p + 1);
    1464:	01078513          	addi	a0,a5,16
  }
}
    1468:	70e2                	ld	ra,56(sp)
    146a:	7442                	ld	s0,48(sp)
    146c:	7902                	ld	s2,32(sp)
    146e:	69e2                	ld	s3,24(sp)
    1470:	6121                	addi	sp,sp,64
    1472:	8082                	ret
    1474:	74a2                	ld	s1,40(sp)
    1476:	6a42                	ld	s4,16(sp)
    1478:	6aa2                	ld	s5,8(sp)
    147a:	6b02                	ld	s6,0(sp)
    147c:	b7f5                	j	1468 <malloc+0xe4>
