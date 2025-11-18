
user/_bcachetest：     文件格式 elf64-littleriscv


Disassembly of section .text:

0000000000000000 <createfile>:
  exit(0);
}

void
createfile(char *file, int nblock)
{
   0:	bc010113          	addi	sp,sp,-1088
   4:	42113c23          	sd	ra,1080(sp)
   8:	42813823          	sd	s0,1072(sp)
   c:	42913423          	sd	s1,1064(sp)
  10:	43213023          	sd	s2,1056(sp)
  14:	41313c23          	sd	s3,1048(sp)
  18:	41413823          	sd	s4,1040(sp)
  1c:	41513423          	sd	s5,1032(sp)
  20:	41613023          	sd	s6,1024(sp)
  24:	44010413          	addi	s0,sp,1088
  28:	8b2a                	mv	s6,a0
  2a:	8a2e                	mv	s4,a1
  int fd;
  char buf[BSIZE];
  int i;
  
  fd = open(file, O_CREATE | O_RDWR);
  2c:	20200593          	li	a1,514
  30:	00000097          	auipc	ra,0x0
  34:	7ac080e7          	jalr	1964(ra) # 7dc <open>
  if(fd < 0){
  38:	04054e63          	bltz	a0,94 <createfile+0x94>
  3c:	89aa                	mv	s3,a0
    printf("test0 create %s failed\n", file);
    exit(-1);
  }
  for(i = 0; i < nblock; i++) {
  3e:	4481                	li	s1,0
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)) {
  40:	bc040a93          	addi	s5,s0,-1088
  44:	40000913          	li	s2,1024
  for(i = 0; i < nblock; i++) {
  48:	01405e63          	blez	s4,64 <createfile+0x64>
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)) {
  4c:	864a                	mv	a2,s2
  4e:	85d6                	mv	a1,s5
  50:	854e                	mv	a0,s3
  52:	00000097          	auipc	ra,0x0
  56:	76a080e7          	jalr	1898(ra) # 7bc <write>
  5a:	05251b63          	bne	a0,s2,b0 <createfile+0xb0>
  for(i = 0; i < nblock; i++) {
  5e:	2485                	addiw	s1,s1,1
  60:	fe9a16e3          	bne	s4,s1,4c <createfile+0x4c>
      printf("write %s failed\n", file);
      exit(-1);
    }
  }
  close(fd);
  64:	854e                	mv	a0,s3
  66:	00000097          	auipc	ra,0x0
  6a:	75e080e7          	jalr	1886(ra) # 7c4 <close>
}
  6e:	43813083          	ld	ra,1080(sp)
  72:	43013403          	ld	s0,1072(sp)
  76:	42813483          	ld	s1,1064(sp)
  7a:	42013903          	ld	s2,1056(sp)
  7e:	41813983          	ld	s3,1048(sp)
  82:	41013a03          	ld	s4,1040(sp)
  86:	40813a83          	ld	s5,1032(sp)
  8a:	40013b03          	ld	s6,1024(sp)
  8e:	44010113          	addi	sp,sp,1088
  92:	8082                	ret
    printf("test0 create %s failed\n", file);
  94:	85da                	mv	a1,s6
  96:	00001517          	auipc	a0,0x1
  9a:	c2a50513          	addi	a0,a0,-982 # cc0 <malloc+0xfa>
  9e:	00001097          	auipc	ra,0x1
  a2:	a6c080e7          	jalr	-1428(ra) # b0a <printf>
    exit(-1);
  a6:	557d                	li	a0,-1
  a8:	00000097          	auipc	ra,0x0
  ac:	6f4080e7          	jalr	1780(ra) # 79c <exit>
      printf("write %s failed\n", file);
  b0:	85da                	mv	a1,s6
  b2:	00001517          	auipc	a0,0x1
  b6:	c2650513          	addi	a0,a0,-986 # cd8 <malloc+0x112>
  ba:	00001097          	auipc	ra,0x1
  be:	a50080e7          	jalr	-1456(ra) # b0a <printf>
      exit(-1);
  c2:	557d                	li	a0,-1
  c4:	00000097          	auipc	ra,0x0
  c8:	6d8080e7          	jalr	1752(ra) # 79c <exit>

00000000000000cc <readfile>:

void
readfile(char *file, int nbytes, int inc)
{
  cc:	bc010113          	addi	sp,sp,-1088
  d0:	42113c23          	sd	ra,1080(sp)
  d4:	42813823          	sd	s0,1072(sp)
  d8:	42913423          	sd	s1,1064(sp)
  dc:	43213023          	sd	s2,1056(sp)
  e0:	41313c23          	sd	s3,1048(sp)
  e4:	41413823          	sd	s4,1040(sp)
  e8:	41513423          	sd	s5,1032(sp)
  ec:	41613023          	sd	s6,1024(sp)
  f0:	44010413          	addi	s0,sp,1088
  char buf[BSIZE];
  int fd;
  int i;

  if(inc > BSIZE) {
  f4:	40000793          	li	a5,1024
  f8:	06c7c763          	blt	a5,a2,166 <readfile+0x9a>
  fc:	8b2a                	mv	s6,a0
  fe:	8a2e                	mv	s4,a1
 100:	84b2                	mv	s1,a2
    printf("test0: inc too large\n");
    exit(-1);
  }
  if ((fd = open(file, O_RDONLY)) < 0) {
 102:	4581                	li	a1,0
 104:	00000097          	auipc	ra,0x0
 108:	6d8080e7          	jalr	1752(ra) # 7dc <open>
 10c:	89aa                	mv	s3,a0
 10e:	06054963          	bltz	a0,180 <readfile+0xb4>
    printf("test0 open %s failed\n", file);
    exit(-1);
  }
  for (i = 0; i < nbytes; i += inc) {
 112:	4901                	li	s2,0
    if(read(fd, buf, inc) != inc) {
 114:	bc040a93          	addi	s5,s0,-1088
  for (i = 0; i < nbytes; i += inc) {
 118:	01405f63          	blez	s4,136 <readfile+0x6a>
    if(read(fd, buf, inc) != inc) {
 11c:	8626                	mv	a2,s1
 11e:	85d6                	mv	a1,s5
 120:	854e                	mv	a0,s3
 122:	00000097          	auipc	ra,0x0
 126:	692080e7          	jalr	1682(ra) # 7b4 <read>
 12a:	06951963          	bne	a0,s1,19c <readfile+0xd0>
  for (i = 0; i < nbytes; i += inc) {
 12e:	0124893b          	addw	s2,s1,s2
 132:	ff4945e3          	blt	s2,s4,11c <readfile+0x50>
      printf("read %s failed for block %d (%d)\n", file, i, nbytes);
      exit(-1);
    }
  }
  close(fd);
 136:	854e                	mv	a0,s3
 138:	00000097          	auipc	ra,0x0
 13c:	68c080e7          	jalr	1676(ra) # 7c4 <close>
}
 140:	43813083          	ld	ra,1080(sp)
 144:	43013403          	ld	s0,1072(sp)
 148:	42813483          	ld	s1,1064(sp)
 14c:	42013903          	ld	s2,1056(sp)
 150:	41813983          	ld	s3,1048(sp)
 154:	41013a03          	ld	s4,1040(sp)
 158:	40813a83          	ld	s5,1032(sp)
 15c:	40013b03          	ld	s6,1024(sp)
 160:	44010113          	addi	sp,sp,1088
 164:	8082                	ret
    printf("test0: inc too large\n");
 166:	00001517          	auipc	a0,0x1
 16a:	b8a50513          	addi	a0,a0,-1142 # cf0 <malloc+0x12a>
 16e:	00001097          	auipc	ra,0x1
 172:	99c080e7          	jalr	-1636(ra) # b0a <printf>
    exit(-1);
 176:	557d                	li	a0,-1
 178:	00000097          	auipc	ra,0x0
 17c:	624080e7          	jalr	1572(ra) # 79c <exit>
    printf("test0 open %s failed\n", file);
 180:	85da                	mv	a1,s6
 182:	00001517          	auipc	a0,0x1
 186:	b8650513          	addi	a0,a0,-1146 # d08 <malloc+0x142>
 18a:	00001097          	auipc	ra,0x1
 18e:	980080e7          	jalr	-1664(ra) # b0a <printf>
    exit(-1);
 192:	557d                	li	a0,-1
 194:	00000097          	auipc	ra,0x0
 198:	608080e7          	jalr	1544(ra) # 79c <exit>
      printf("read %s failed for block %d (%d)\n", file, i, nbytes);
 19c:	86d2                	mv	a3,s4
 19e:	864a                	mv	a2,s2
 1a0:	85da                	mv	a1,s6
 1a2:	00001517          	auipc	a0,0x1
 1a6:	b7e50513          	addi	a0,a0,-1154 # d20 <malloc+0x15a>
 1aa:	00001097          	auipc	ra,0x1
 1ae:	960080e7          	jalr	-1696(ra) # b0a <printf>
      exit(-1);
 1b2:	557d                	li	a0,-1
 1b4:	00000097          	auipc	ra,0x0
 1b8:	5e8080e7          	jalr	1512(ra) # 79c <exit>

00000000000001bc <test0>:

void
test0()
{
 1bc:	715d                	addi	sp,sp,-80
 1be:	e486                	sd	ra,72(sp)
 1c0:	e0a2                	sd	s0,64(sp)
 1c2:	fc26                	sd	s1,56(sp)
 1c4:	f84a                	sd	s2,48(sp)
 1c6:	f44e                	sd	s3,40(sp)
 1c8:	f052                	sd	s4,32(sp)
 1ca:	ec56                	sd	s5,24(sp)
 1cc:	e85a                	sd	s6,16(sp)
 1ce:	0880                	addi	s0,sp,80
  char file[2];
  char dir[2];
  enum { N = 10, NCHILD = 3 };
  int n;

  dir[0] = '0';
 1d0:	03000793          	li	a5,48
 1d4:	faf40823          	sb	a5,-80(s0)
  dir[1] = '\0';
 1d8:	fa0408a3          	sb	zero,-79(s0)
  file[0] = 'F';
 1dc:	04600793          	li	a5,70
 1e0:	faf40c23          	sb	a5,-72(s0)
  file[1] = '\0';
 1e4:	fa040ca3          	sb	zero,-71(s0)

  printf("start test0\n");
 1e8:	00001517          	auipc	a0,0x1
 1ec:	b6050513          	addi	a0,a0,-1184 # d48 <malloc+0x182>
 1f0:	00001097          	auipc	ra,0x1
 1f4:	91a080e7          	jalr	-1766(ra) # b0a <printf>
 1f8:	03000493          	li	s1,48
  for(int i = 0; i < NCHILD; i++){
    dir[0] = '0' + i;
    mkdir(dir);
 1fc:	fb040913          	addi	s2,s0,-80
    if (chdir(dir) < 0) {
      printf("chdir failed\n");
      exit(1);
    }
    unlink(file);
 200:	fb840993          	addi	s3,s0,-72
    createfile(file, N);
 204:	4b29                	li	s6,10
    if (chdir("..") < 0) {
 206:	00001a97          	auipc	s5,0x1
 20a:	b62a8a93          	addi	s5,s5,-1182 # d68 <malloc+0x1a2>
  for(int i = 0; i < NCHILD; i++){
 20e:	03300a13          	li	s4,51
    dir[0] = '0' + i;
 212:	fa940823          	sb	s1,-80(s0)
    mkdir(dir);
 216:	854a                	mv	a0,s2
 218:	00000097          	auipc	ra,0x0
 21c:	5ec080e7          	jalr	1516(ra) # 804 <mkdir>
    if (chdir(dir) < 0) {
 220:	854a                	mv	a0,s2
 222:	00000097          	auipc	ra,0x0
 226:	5ea080e7          	jalr	1514(ra) # 80c <chdir>
 22a:	0c054263          	bltz	a0,2ee <test0+0x132>
    unlink(file);
 22e:	854e                	mv	a0,s3
 230:	00000097          	auipc	ra,0x0
 234:	5bc080e7          	jalr	1468(ra) # 7ec <unlink>
    createfile(file, N);
 238:	85da                	mv	a1,s6
 23a:	854e                	mv	a0,s3
 23c:	00000097          	auipc	ra,0x0
 240:	dc4080e7          	jalr	-572(ra) # 0 <createfile>
    if (chdir("..") < 0) {
 244:	8556                	mv	a0,s5
 246:	00000097          	auipc	ra,0x0
 24a:	5c6080e7          	jalr	1478(ra) # 80c <chdir>
 24e:	0a054d63          	bltz	a0,308 <test0+0x14c>
  for(int i = 0; i < NCHILD; i++){
 252:	2485                	addiw	s1,s1,1
 254:	0ff4f493          	zext.b	s1,s1
 258:	fb449de3          	bne	s1,s4,212 <test0+0x56>
      printf("chdir failed\n");
      exit(1);
    }
  }
  ntas(0);
 25c:	4501                	li	a0,0
 25e:	00000097          	auipc	ra,0x0
 262:	5de080e7          	jalr	1502(ra) # 83c <ntas>
 266:	03000493          	li	s1,48
  for(int i = 0; i < NCHILD; i++){
 26a:	03300913          	li	s2,51
    dir[0] = '0' + i;
 26e:	fa940823          	sb	s1,-80(s0)
    int pid = fork();
 272:	00000097          	auipc	ra,0x0
 276:	522080e7          	jalr	1314(ra) # 794 <fork>
    if(pid < 0){
 27a:	0a054463          	bltz	a0,322 <test0+0x166>
      printf("fork failed");
      exit(-1);
    }
    if(pid == 0){
 27e:	cd5d                	beqz	a0,33c <test0+0x180>
  for(int i = 0; i < NCHILD; i++){
 280:	2485                	addiw	s1,s1,1
 282:	0ff4f493          	zext.b	s1,s1
 286:	ff2494e3          	bne	s1,s2,26e <test0+0xb2>
      exit(0);
    }
  }

  for(int i = 0; i < NCHILD; i++){
    wait(0);
 28a:	4501                	li	a0,0
 28c:	00000097          	auipc	ra,0x0
 290:	518080e7          	jalr	1304(ra) # 7a4 <wait>
 294:	4501                	li	a0,0
 296:	00000097          	auipc	ra,0x0
 29a:	50e080e7          	jalr	1294(ra) # 7a4 <wait>
 29e:	4501                	li	a0,0
 2a0:	00000097          	auipc	ra,0x0
 2a4:	504080e7          	jalr	1284(ra) # 7a4 <wait>
  }
  printf("test0 results:\n");
 2a8:	00001517          	auipc	a0,0x1
 2ac:	ad850513          	addi	a0,a0,-1320 # d80 <malloc+0x1ba>
 2b0:	00001097          	auipc	ra,0x1
 2b4:	85a080e7          	jalr	-1958(ra) # b0a <printf>
  n = ntas(1);
 2b8:	4505                	li	a0,1
 2ba:	00000097          	auipc	ra,0x0
 2be:	582080e7          	jalr	1410(ra) # 83c <ntas>
  if (n < 500)
 2c2:	1f300793          	li	a5,499
 2c6:	0aa7cf63          	blt	a5,a0,384 <test0+0x1c8>
    printf("test0: OK\n");
 2ca:	00001517          	auipc	a0,0x1
 2ce:	ac650513          	addi	a0,a0,-1338 # d90 <malloc+0x1ca>
 2d2:	00001097          	auipc	ra,0x1
 2d6:	838080e7          	jalr	-1992(ra) # b0a <printf>
  else
    printf("test0: FAIL\n");
}
 2da:	60a6                	ld	ra,72(sp)
 2dc:	6406                	ld	s0,64(sp)
 2de:	74e2                	ld	s1,56(sp)
 2e0:	7942                	ld	s2,48(sp)
 2e2:	79a2                	ld	s3,40(sp)
 2e4:	7a02                	ld	s4,32(sp)
 2e6:	6ae2                	ld	s5,24(sp)
 2e8:	6b42                	ld	s6,16(sp)
 2ea:	6161                	addi	sp,sp,80
 2ec:	8082                	ret
      printf("chdir failed\n");
 2ee:	00001517          	auipc	a0,0x1
 2f2:	a6a50513          	addi	a0,a0,-1430 # d58 <malloc+0x192>
 2f6:	00001097          	auipc	ra,0x1
 2fa:	814080e7          	jalr	-2028(ra) # b0a <printf>
      exit(1);
 2fe:	4505                	li	a0,1
 300:	00000097          	auipc	ra,0x0
 304:	49c080e7          	jalr	1180(ra) # 79c <exit>
      printf("chdir failed\n");
 308:	00001517          	auipc	a0,0x1
 30c:	a5050513          	addi	a0,a0,-1456 # d58 <malloc+0x192>
 310:	00000097          	auipc	ra,0x0
 314:	7fa080e7          	jalr	2042(ra) # b0a <printf>
      exit(1);
 318:	4505                	li	a0,1
 31a:	00000097          	auipc	ra,0x0
 31e:	482080e7          	jalr	1154(ra) # 79c <exit>
      printf("fork failed");
 322:	00001517          	auipc	a0,0x1
 326:	a4e50513          	addi	a0,a0,-1458 # d70 <malloc+0x1aa>
 32a:	00000097          	auipc	ra,0x0
 32e:	7e0080e7          	jalr	2016(ra) # b0a <printf>
      exit(-1);
 332:	557d                	li	a0,-1
 334:	00000097          	auipc	ra,0x0
 338:	468080e7          	jalr	1128(ra) # 79c <exit>
      if (chdir(dir) < 0) {
 33c:	fb040513          	addi	a0,s0,-80
 340:	00000097          	auipc	ra,0x0
 344:	4cc080e7          	jalr	1228(ra) # 80c <chdir>
 348:	02054163          	bltz	a0,36a <test0+0x1ae>
      readfile(file, N*BSIZE, 1);
 34c:	4605                	li	a2,1
 34e:	658d                	lui	a1,0x3
 350:	80058593          	addi	a1,a1,-2048 # 2800 <__global_pointer$+0x11bf>
 354:	fb840513          	addi	a0,s0,-72
 358:	00000097          	auipc	ra,0x0
 35c:	d74080e7          	jalr	-652(ra) # cc <readfile>
      exit(0);
 360:	4501                	li	a0,0
 362:	00000097          	auipc	ra,0x0
 366:	43a080e7          	jalr	1082(ra) # 79c <exit>
        printf("chdir failed\n");
 36a:	00001517          	auipc	a0,0x1
 36e:	9ee50513          	addi	a0,a0,-1554 # d58 <malloc+0x192>
 372:	00000097          	auipc	ra,0x0
 376:	798080e7          	jalr	1944(ra) # b0a <printf>
        exit(1);
 37a:	4505                	li	a0,1
 37c:	00000097          	auipc	ra,0x0
 380:	420080e7          	jalr	1056(ra) # 79c <exit>
    printf("test0: FAIL\n");
 384:	00001517          	auipc	a0,0x1
 388:	a1c50513          	addi	a0,a0,-1508 # da0 <malloc+0x1da>
 38c:	00000097          	auipc	ra,0x0
 390:	77e080e7          	jalr	1918(ra) # b0a <printf>
}
 394:	b799                	j	2da <test0+0x11e>

0000000000000396 <test1>:

void test1()
{
 396:	7139                	addi	sp,sp,-64
 398:	fc06                	sd	ra,56(sp)
 39a:	f822                	sd	s0,48(sp)
 39c:	f426                	sd	s1,40(sp)
 39e:	f04a                	sd	s2,32(sp)
 3a0:	ec4e                	sd	s3,24(sp)
 3a2:	e852                	sd	s4,16(sp)
 3a4:	0080                	addi	s0,sp,64
  char file[3];
  enum { N = 100, BIG=100, NCHILD=2 };
  
  printf("start test1\n");
 3a6:	00001517          	auipc	a0,0x1
 3aa:	a0a50513          	addi	a0,a0,-1526 # db0 <malloc+0x1ea>
 3ae:	00000097          	auipc	ra,0x0
 3b2:	75c080e7          	jalr	1884(ra) # b0a <printf>
  file[0] = 'B';
 3b6:	04200793          	li	a5,66
 3ba:	fcf40423          	sb	a5,-56(s0)
  file[2] = '\0';
 3be:	fc040523          	sb	zero,-54(s0)
  for(int i = 0; i < NCHILD; i++){
 3c2:	4481                	li	s1,0
    file[1] = '0' + i;
    unlink(file);
 3c4:	fc840913          	addi	s2,s0,-56
    if (i == 0) {
      createfile(file, BIG);
    } else {
      createfile(file, 1);
 3c8:	4a05                	li	s4,1
  for(int i = 0; i < NCHILD; i++){
 3ca:	4989                	li	s3,2
    file[1] = '0' + i;
 3cc:	0304879b          	addiw	a5,s1,48
 3d0:	fcf404a3          	sb	a5,-55(s0)
    unlink(file);
 3d4:	854a                	mv	a0,s2
 3d6:	00000097          	auipc	ra,0x0
 3da:	416080e7          	jalr	1046(ra) # 7ec <unlink>
    if (i == 0) {
 3de:	c8b5                	beqz	s1,452 <test1+0xbc>
      createfile(file, 1);
 3e0:	85d2                	mv	a1,s4
 3e2:	854a                	mv	a0,s2
 3e4:	00000097          	auipc	ra,0x0
 3e8:	c1c080e7          	jalr	-996(ra) # 0 <createfile>
  for(int i = 0; i < NCHILD; i++){
 3ec:	2485                	addiw	s1,s1,1
 3ee:	fd349fe3          	bne	s1,s3,3cc <test1+0x36>
    }
  }
  for(int i = 0; i < NCHILD; i++){
    file[1] = '0' + i;
 3f2:	03000793          	li	a5,48
 3f6:	fcf404a3          	sb	a5,-55(s0)
    int pid = fork();
 3fa:	00000097          	auipc	ra,0x0
 3fe:	39a080e7          	jalr	922(ra) # 794 <fork>
    if(pid < 0){
 402:	06054263          	bltz	a0,466 <test1+0xd0>
      printf("fork failed");
      exit(-1);
    }
    if(pid == 0){
 406:	cd2d                	beqz	a0,480 <test1+0xea>
    file[1] = '0' + i;
 408:	03100793          	li	a5,49
 40c:	fcf404a3          	sb	a5,-55(s0)
    int pid = fork();
 410:	00000097          	auipc	ra,0x0
 414:	384080e7          	jalr	900(ra) # 794 <fork>
    if(pid < 0){
 418:	04054763          	bltz	a0,466 <test1+0xd0>
    if(pid == 0){
 41c:	cd49                	beqz	a0,4b6 <test1+0x120>
      exit(0);
    }
  }

  for(int i = 0; i < NCHILD; i++){
    wait(0);
 41e:	4501                	li	a0,0
 420:	00000097          	auipc	ra,0x0
 424:	384080e7          	jalr	900(ra) # 7a4 <wait>
 428:	4501                	li	a0,0
 42a:	00000097          	auipc	ra,0x0
 42e:	37a080e7          	jalr	890(ra) # 7a4 <wait>
  }
  printf("test1 OK\n");
 432:	00001517          	auipc	a0,0x1
 436:	98e50513          	addi	a0,a0,-1650 # dc0 <malloc+0x1fa>
 43a:	00000097          	auipc	ra,0x0
 43e:	6d0080e7          	jalr	1744(ra) # b0a <printf>
}
 442:	70e2                	ld	ra,56(sp)
 444:	7442                	ld	s0,48(sp)
 446:	74a2                	ld	s1,40(sp)
 448:	7902                	ld	s2,32(sp)
 44a:	69e2                	ld	s3,24(sp)
 44c:	6a42                	ld	s4,16(sp)
 44e:	6121                	addi	sp,sp,64
 450:	8082                	ret
      createfile(file, BIG);
 452:	06400593          	li	a1,100
 456:	fc840513          	addi	a0,s0,-56
 45a:	00000097          	auipc	ra,0x0
 45e:	ba6080e7          	jalr	-1114(ra) # 0 <createfile>
  for(int i = 0; i < NCHILD; i++){
 462:	2485                	addiw	s1,s1,1
 464:	b7a5                	j	3cc <test1+0x36>
      printf("fork failed");
 466:	00001517          	auipc	a0,0x1
 46a:	90a50513          	addi	a0,a0,-1782 # d70 <malloc+0x1aa>
 46e:	00000097          	auipc	ra,0x0
 472:	69c080e7          	jalr	1692(ra) # b0a <printf>
      exit(-1);
 476:	557d                	li	a0,-1
 478:	00000097          	auipc	ra,0x0
 47c:	324080e7          	jalr	804(ra) # 79c <exit>
    if(pid == 0){
 480:	06400493          	li	s1,100
          readfile(file, BIG*BSIZE, BSIZE);
 484:	fc840a13          	addi	s4,s0,-56
 488:	40000993          	li	s3,1024
 48c:	6965                	lui	s2,0x19
 48e:	864e                	mv	a2,s3
 490:	85ca                	mv	a1,s2
 492:	8552                	mv	a0,s4
 494:	00000097          	auipc	ra,0x0
 498:	c38080e7          	jalr	-968(ra) # cc <readfile>
        for (i = 0; i < N; i++) {
 49c:	34fd                	addiw	s1,s1,-1
 49e:	f8e5                	bnez	s1,48e <test1+0xf8>
        unlink(file);
 4a0:	fc840513          	addi	a0,s0,-56
 4a4:	00000097          	auipc	ra,0x0
 4a8:	348080e7          	jalr	840(ra) # 7ec <unlink>
        exit(0);
 4ac:	4501                	li	a0,0
 4ae:	00000097          	auipc	ra,0x0
 4b2:	2ee080e7          	jalr	750(ra) # 79c <exit>
 4b6:	06400493          	li	s1,100
          readfile(file, 1, BSIZE);
 4ba:	fc840a13          	addi	s4,s0,-56
 4be:	40000993          	li	s3,1024
 4c2:	4905                	li	s2,1
 4c4:	864e                	mv	a2,s3
 4c6:	85ca                	mv	a1,s2
 4c8:	8552                	mv	a0,s4
 4ca:	00000097          	auipc	ra,0x0
 4ce:	c02080e7          	jalr	-1022(ra) # cc <readfile>
        for (i = 0; i < N; i++) {
 4d2:	34fd                	addiw	s1,s1,-1
 4d4:	f8e5                	bnez	s1,4c4 <test1+0x12e>
        unlink(file);
 4d6:	fc840513          	addi	a0,s0,-56
 4da:	00000097          	auipc	ra,0x0
 4de:	312080e7          	jalr	786(ra) # 7ec <unlink>
      exit(0);
 4e2:	4501                	li	a0,0
 4e4:	00000097          	auipc	ra,0x0
 4e8:	2b8080e7          	jalr	696(ra) # 79c <exit>

00000000000004ec <main>:
{
 4ec:	1141                	addi	sp,sp,-16
 4ee:	e406                	sd	ra,8(sp)
 4f0:	e022                	sd	s0,0(sp)
 4f2:	0800                	addi	s0,sp,16
  test0();
 4f4:	00000097          	auipc	ra,0x0
 4f8:	cc8080e7          	jalr	-824(ra) # 1bc <test0>
  test1();
 4fc:	00000097          	auipc	ra,0x0
 500:	e9a080e7          	jalr	-358(ra) # 396 <test1>
  exit(0);
 504:	4501                	li	a0,0
 506:	00000097          	auipc	ra,0x0
 50a:	296080e7          	jalr	662(ra) # 79c <exit>

000000000000050e <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 50e:	1141                	addi	sp,sp,-16
 510:	e406                	sd	ra,8(sp)
 512:	e022                	sd	s0,0(sp)
 514:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 516:	87aa                	mv	a5,a0
 518:	0585                	addi	a1,a1,1
 51a:	0785                	addi	a5,a5,1
 51c:	fff5c703          	lbu	a4,-1(a1)
 520:	fee78fa3          	sb	a4,-1(a5)
 524:	fb75                	bnez	a4,518 <strcpy+0xa>
    ;
  return os;
}
 526:	60a2                	ld	ra,8(sp)
 528:	6402                	ld	s0,0(sp)
 52a:	0141                	addi	sp,sp,16
 52c:	8082                	ret

000000000000052e <strcmp>:

int
strcmp(const char *p, const char *q)
{
 52e:	1141                	addi	sp,sp,-16
 530:	e406                	sd	ra,8(sp)
 532:	e022                	sd	s0,0(sp)
 534:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 536:	00054783          	lbu	a5,0(a0)
 53a:	cb91                	beqz	a5,54e <strcmp+0x20>
 53c:	0005c703          	lbu	a4,0(a1)
 540:	00f71763          	bne	a4,a5,54e <strcmp+0x20>
    p++, q++;
 544:	0505                	addi	a0,a0,1
 546:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 548:	00054783          	lbu	a5,0(a0)
 54c:	fbe5                	bnez	a5,53c <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 54e:	0005c503          	lbu	a0,0(a1)
}
 552:	40a7853b          	subw	a0,a5,a0
 556:	60a2                	ld	ra,8(sp)
 558:	6402                	ld	s0,0(sp)
 55a:	0141                	addi	sp,sp,16
 55c:	8082                	ret

000000000000055e <strlen>:

uint
strlen(const char *s)
{
 55e:	1141                	addi	sp,sp,-16
 560:	e406                	sd	ra,8(sp)
 562:	e022                	sd	s0,0(sp)
 564:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 566:	00054783          	lbu	a5,0(a0)
 56a:	cf91                	beqz	a5,586 <strlen+0x28>
 56c:	00150793          	addi	a5,a0,1
 570:	86be                	mv	a3,a5
 572:	0785                	addi	a5,a5,1
 574:	fff7c703          	lbu	a4,-1(a5)
 578:	ff65                	bnez	a4,570 <strlen+0x12>
 57a:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
 57e:	60a2                	ld	ra,8(sp)
 580:	6402                	ld	s0,0(sp)
 582:	0141                	addi	sp,sp,16
 584:	8082                	ret
  for(n = 0; s[n]; n++)
 586:	4501                	li	a0,0
 588:	bfdd                	j	57e <strlen+0x20>

000000000000058a <memset>:

void*
memset(void *dst, int c, uint n)
{
 58a:	1141                	addi	sp,sp,-16
 58c:	e406                	sd	ra,8(sp)
 58e:	e022                	sd	s0,0(sp)
 590:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 592:	ca19                	beqz	a2,5a8 <memset+0x1e>
 594:	87aa                	mv	a5,a0
 596:	1602                	slli	a2,a2,0x20
 598:	9201                	srli	a2,a2,0x20
 59a:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 59e:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 5a2:	0785                	addi	a5,a5,1
 5a4:	fee79de3          	bne	a5,a4,59e <memset+0x14>
  }
  return dst;
}
 5a8:	60a2                	ld	ra,8(sp)
 5aa:	6402                	ld	s0,0(sp)
 5ac:	0141                	addi	sp,sp,16
 5ae:	8082                	ret

00000000000005b0 <strchr>:

char*
strchr(const char *s, char c)
{
 5b0:	1141                	addi	sp,sp,-16
 5b2:	e406                	sd	ra,8(sp)
 5b4:	e022                	sd	s0,0(sp)
 5b6:	0800                	addi	s0,sp,16
  for(; *s; s++)
 5b8:	00054783          	lbu	a5,0(a0)
 5bc:	cf81                	beqz	a5,5d4 <strchr+0x24>
    if(*s == c)
 5be:	00f58763          	beq	a1,a5,5cc <strchr+0x1c>
  for(; *s; s++)
 5c2:	0505                	addi	a0,a0,1
 5c4:	00054783          	lbu	a5,0(a0)
 5c8:	fbfd                	bnez	a5,5be <strchr+0xe>
      return (char*)s;
  return 0;
 5ca:	4501                	li	a0,0
}
 5cc:	60a2                	ld	ra,8(sp)
 5ce:	6402                	ld	s0,0(sp)
 5d0:	0141                	addi	sp,sp,16
 5d2:	8082                	ret
  return 0;
 5d4:	4501                	li	a0,0
 5d6:	bfdd                	j	5cc <strchr+0x1c>

00000000000005d8 <gets>:

char*
gets(char *buf, int max)
{
 5d8:	711d                	addi	sp,sp,-96
 5da:	ec86                	sd	ra,88(sp)
 5dc:	e8a2                	sd	s0,80(sp)
 5de:	e4a6                	sd	s1,72(sp)
 5e0:	e0ca                	sd	s2,64(sp)
 5e2:	fc4e                	sd	s3,56(sp)
 5e4:	f852                	sd	s4,48(sp)
 5e6:	f456                	sd	s5,40(sp)
 5e8:	f05a                	sd	s6,32(sp)
 5ea:	ec5e                	sd	s7,24(sp)
 5ec:	e862                	sd	s8,16(sp)
 5ee:	1080                	addi	s0,sp,96
 5f0:	8baa                	mv	s7,a0
 5f2:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 5f4:	892a                	mv	s2,a0
 5f6:	4481                	li	s1,0
    cc = read(0, &c, 1);
 5f8:	faf40b13          	addi	s6,s0,-81
 5fc:	4a85                	li	s5,1
  for(i=0; i+1 < max; ){
 5fe:	8c26                	mv	s8,s1
 600:	0014899b          	addiw	s3,s1,1
 604:	84ce                	mv	s1,s3
 606:	0349d663          	bge	s3,s4,632 <gets+0x5a>
    cc = read(0, &c, 1);
 60a:	8656                	mv	a2,s5
 60c:	85da                	mv	a1,s6
 60e:	4501                	li	a0,0
 610:	00000097          	auipc	ra,0x0
 614:	1a4080e7          	jalr	420(ra) # 7b4 <read>
    if(cc < 1)
 618:	00a05d63          	blez	a0,632 <gets+0x5a>
      break;
    buf[i++] = c;
 61c:	faf44783          	lbu	a5,-81(s0)
 620:	00f90023          	sb	a5,0(s2) # 19000 <__global_pointer$+0x179bf>
    if(c == '\n' || c == '\r')
 624:	0905                	addi	s2,s2,1
 626:	ff678713          	addi	a4,a5,-10
 62a:	c319                	beqz	a4,630 <gets+0x58>
 62c:	17cd                	addi	a5,a5,-13
 62e:	fbe1                	bnez	a5,5fe <gets+0x26>
    buf[i++] = c;
 630:	8c4e                	mv	s8,s3
      break;
  }
  buf[i] = '\0';
 632:	9c5e                	add	s8,s8,s7
 634:	000c0023          	sb	zero,0(s8)
  return buf;
}
 638:	855e                	mv	a0,s7
 63a:	60e6                	ld	ra,88(sp)
 63c:	6446                	ld	s0,80(sp)
 63e:	64a6                	ld	s1,72(sp)
 640:	6906                	ld	s2,64(sp)
 642:	79e2                	ld	s3,56(sp)
 644:	7a42                	ld	s4,48(sp)
 646:	7aa2                	ld	s5,40(sp)
 648:	7b02                	ld	s6,32(sp)
 64a:	6be2                	ld	s7,24(sp)
 64c:	6c42                	ld	s8,16(sp)
 64e:	6125                	addi	sp,sp,96
 650:	8082                	ret

0000000000000652 <stat>:

int
stat(const char *n, struct stat *st)
{
 652:	1101                	addi	sp,sp,-32
 654:	ec06                	sd	ra,24(sp)
 656:	e822                	sd	s0,16(sp)
 658:	e04a                	sd	s2,0(sp)
 65a:	1000                	addi	s0,sp,32
 65c:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 65e:	4581                	li	a1,0
 660:	00000097          	auipc	ra,0x0
 664:	17c080e7          	jalr	380(ra) # 7dc <open>
  if(fd < 0)
 668:	02054663          	bltz	a0,694 <stat+0x42>
 66c:	e426                	sd	s1,8(sp)
 66e:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 670:	85ca                	mv	a1,s2
 672:	00000097          	auipc	ra,0x0
 676:	182080e7          	jalr	386(ra) # 7f4 <fstat>
 67a:	892a                	mv	s2,a0
  close(fd);
 67c:	8526                	mv	a0,s1
 67e:	00000097          	auipc	ra,0x0
 682:	146080e7          	jalr	326(ra) # 7c4 <close>
  return r;
 686:	64a2                	ld	s1,8(sp)
}
 688:	854a                	mv	a0,s2
 68a:	60e2                	ld	ra,24(sp)
 68c:	6442                	ld	s0,16(sp)
 68e:	6902                	ld	s2,0(sp)
 690:	6105                	addi	sp,sp,32
 692:	8082                	ret
    return -1;
 694:	57fd                	li	a5,-1
 696:	893e                	mv	s2,a5
 698:	bfc5                	j	688 <stat+0x36>

000000000000069a <atoi>:

int
atoi(const char *s)
{
 69a:	1141                	addi	sp,sp,-16
 69c:	e406                	sd	ra,8(sp)
 69e:	e022                	sd	s0,0(sp)
 6a0:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 6a2:	00054683          	lbu	a3,0(a0)
 6a6:	fd06879b          	addiw	a5,a3,-48
 6aa:	0ff7f793          	zext.b	a5,a5
 6ae:	4625                	li	a2,9
 6b0:	02f66963          	bltu	a2,a5,6e2 <atoi+0x48>
 6b4:	872a                	mv	a4,a0
  n = 0;
 6b6:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 6b8:	0705                	addi	a4,a4,1
 6ba:	0025179b          	slliw	a5,a0,0x2
 6be:	9fa9                	addw	a5,a5,a0
 6c0:	0017979b          	slliw	a5,a5,0x1
 6c4:	9fb5                	addw	a5,a5,a3
 6c6:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 6ca:	00074683          	lbu	a3,0(a4)
 6ce:	fd06879b          	addiw	a5,a3,-48
 6d2:	0ff7f793          	zext.b	a5,a5
 6d6:	fef671e3          	bgeu	a2,a5,6b8 <atoi+0x1e>
  return n;
}
 6da:	60a2                	ld	ra,8(sp)
 6dc:	6402                	ld	s0,0(sp)
 6de:	0141                	addi	sp,sp,16
 6e0:	8082                	ret
  n = 0;
 6e2:	4501                	li	a0,0
 6e4:	bfdd                	j	6da <atoi+0x40>

00000000000006e6 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 6e6:	1141                	addi	sp,sp,-16
 6e8:	e406                	sd	ra,8(sp)
 6ea:	e022                	sd	s0,0(sp)
 6ec:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 6ee:	02b57563          	bgeu	a0,a1,718 <memmove+0x32>
    while(n-- > 0)
 6f2:	00c05f63          	blez	a2,710 <memmove+0x2a>
 6f6:	1602                	slli	a2,a2,0x20
 6f8:	9201                	srli	a2,a2,0x20
 6fa:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 6fe:	872a                	mv	a4,a0
      *dst++ = *src++;
 700:	0585                	addi	a1,a1,1
 702:	0705                	addi	a4,a4,1
 704:	fff5c683          	lbu	a3,-1(a1)
 708:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 70c:	fee79ae3          	bne	a5,a4,700 <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 710:	60a2                	ld	ra,8(sp)
 712:	6402                	ld	s0,0(sp)
 714:	0141                	addi	sp,sp,16
 716:	8082                	ret
    while(n-- > 0)
 718:	fec05ce3          	blez	a2,710 <memmove+0x2a>
    dst += n;
 71c:	00c50733          	add	a4,a0,a2
    src += n;
 720:	95b2                	add	a1,a1,a2
 722:	fff6079b          	addiw	a5,a2,-1
 726:	1782                	slli	a5,a5,0x20
 728:	9381                	srli	a5,a5,0x20
 72a:	fff7c793          	not	a5,a5
 72e:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 730:	15fd                	addi	a1,a1,-1
 732:	177d                	addi	a4,a4,-1
 734:	0005c683          	lbu	a3,0(a1)
 738:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 73c:	fef71ae3          	bne	a4,a5,730 <memmove+0x4a>
 740:	bfc1                	j	710 <memmove+0x2a>

0000000000000742 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 742:	1141                	addi	sp,sp,-16
 744:	e406                	sd	ra,8(sp)
 746:	e022                	sd	s0,0(sp)
 748:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 74a:	c61d                	beqz	a2,778 <memcmp+0x36>
 74c:	1602                	slli	a2,a2,0x20
 74e:	9201                	srli	a2,a2,0x20
 750:	00c506b3          	add	a3,a0,a2
    if (*p1 != *p2) {
 754:	00054783          	lbu	a5,0(a0)
 758:	0005c703          	lbu	a4,0(a1)
 75c:	00e79863          	bne	a5,a4,76c <memcmp+0x2a>
      return *p1 - *p2;
    }
    p1++;
 760:	0505                	addi	a0,a0,1
    p2++;
 762:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 764:	fed518e3          	bne	a0,a3,754 <memcmp+0x12>
  }
  return 0;
 768:	4501                	li	a0,0
 76a:	a019                	j	770 <memcmp+0x2e>
      return *p1 - *p2;
 76c:	40e7853b          	subw	a0,a5,a4
}
 770:	60a2                	ld	ra,8(sp)
 772:	6402                	ld	s0,0(sp)
 774:	0141                	addi	sp,sp,16
 776:	8082                	ret
  return 0;
 778:	4501                	li	a0,0
 77a:	bfdd                	j	770 <memcmp+0x2e>

000000000000077c <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 77c:	1141                	addi	sp,sp,-16
 77e:	e406                	sd	ra,8(sp)
 780:	e022                	sd	s0,0(sp)
 782:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 784:	00000097          	auipc	ra,0x0
 788:	f62080e7          	jalr	-158(ra) # 6e6 <memmove>
}
 78c:	60a2                	ld	ra,8(sp)
 78e:	6402                	ld	s0,0(sp)
 790:	0141                	addi	sp,sp,16
 792:	8082                	ret

0000000000000794 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 794:	4885                	li	a7,1
 ecall
 796:	00000073          	ecall
 ret
 79a:	8082                	ret

000000000000079c <exit>:
.global exit
exit:
 li a7, SYS_exit
 79c:	4889                	li	a7,2
 ecall
 79e:	00000073          	ecall
 ret
 7a2:	8082                	ret

00000000000007a4 <wait>:
.global wait
wait:
 li a7, SYS_wait
 7a4:	488d                	li	a7,3
 ecall
 7a6:	00000073          	ecall
 ret
 7aa:	8082                	ret

00000000000007ac <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 7ac:	4891                	li	a7,4
 ecall
 7ae:	00000073          	ecall
 ret
 7b2:	8082                	ret

00000000000007b4 <read>:
.global read
read:
 li a7, SYS_read
 7b4:	4895                	li	a7,5
 ecall
 7b6:	00000073          	ecall
 ret
 7ba:	8082                	ret

00000000000007bc <write>:
.global write
write:
 li a7, SYS_write
 7bc:	48c1                	li	a7,16
 ecall
 7be:	00000073          	ecall
 ret
 7c2:	8082                	ret

00000000000007c4 <close>:
.global close
close:
 li a7, SYS_close
 7c4:	48d5                	li	a7,21
 ecall
 7c6:	00000073          	ecall
 ret
 7ca:	8082                	ret

00000000000007cc <kill>:
.global kill
kill:
 li a7, SYS_kill
 7cc:	4899                	li	a7,6
 ecall
 7ce:	00000073          	ecall
 ret
 7d2:	8082                	ret

00000000000007d4 <exec>:
.global exec
exec:
 li a7, SYS_exec
 7d4:	489d                	li	a7,7
 ecall
 7d6:	00000073          	ecall
 ret
 7da:	8082                	ret

00000000000007dc <open>:
.global open
open:
 li a7, SYS_open
 7dc:	48bd                	li	a7,15
 ecall
 7de:	00000073          	ecall
 ret
 7e2:	8082                	ret

00000000000007e4 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 7e4:	48c5                	li	a7,17
 ecall
 7e6:	00000073          	ecall
 ret
 7ea:	8082                	ret

00000000000007ec <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 7ec:	48c9                	li	a7,18
 ecall
 7ee:	00000073          	ecall
 ret
 7f2:	8082                	ret

00000000000007f4 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 7f4:	48a1                	li	a7,8
 ecall
 7f6:	00000073          	ecall
 ret
 7fa:	8082                	ret

00000000000007fc <link>:
.global link
link:
 li a7, SYS_link
 7fc:	48cd                	li	a7,19
 ecall
 7fe:	00000073          	ecall
 ret
 802:	8082                	ret

0000000000000804 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 804:	48d1                	li	a7,20
 ecall
 806:	00000073          	ecall
 ret
 80a:	8082                	ret

000000000000080c <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 80c:	48a5                	li	a7,9
 ecall
 80e:	00000073          	ecall
 ret
 812:	8082                	ret

0000000000000814 <dup>:
.global dup
dup:
 li a7, SYS_dup
 814:	48a9                	li	a7,10
 ecall
 816:	00000073          	ecall
 ret
 81a:	8082                	ret

000000000000081c <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 81c:	48ad                	li	a7,11
 ecall
 81e:	00000073          	ecall
 ret
 822:	8082                	ret

0000000000000824 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 824:	48b1                	li	a7,12
 ecall
 826:	00000073          	ecall
 ret
 82a:	8082                	ret

000000000000082c <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 82c:	48b5                	li	a7,13
 ecall
 82e:	00000073          	ecall
 ret
 832:	8082                	ret

0000000000000834 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 834:	48b9                	li	a7,14
 ecall
 836:	00000073          	ecall
 ret
 83a:	8082                	ret

000000000000083c <ntas>:
.global ntas
ntas:
 li a7, SYS_ntas
 83c:	48d9                	li	a7,22
 ecall
 83e:	00000073          	ecall
 ret
 842:	8082                	ret

0000000000000844 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 844:	1101                	addi	sp,sp,-32
 846:	ec06                	sd	ra,24(sp)
 848:	e822                	sd	s0,16(sp)
 84a:	1000                	addi	s0,sp,32
 84c:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 850:	4605                	li	a2,1
 852:	fef40593          	addi	a1,s0,-17
 856:	00000097          	auipc	ra,0x0
 85a:	f66080e7          	jalr	-154(ra) # 7bc <write>
}
 85e:	60e2                	ld	ra,24(sp)
 860:	6442                	ld	s0,16(sp)
 862:	6105                	addi	sp,sp,32
 864:	8082                	ret

0000000000000866 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 866:	7139                	addi	sp,sp,-64
 868:	fc06                	sd	ra,56(sp)
 86a:	f822                	sd	s0,48(sp)
 86c:	f04a                	sd	s2,32(sp)
 86e:	ec4e                	sd	s3,24(sp)
 870:	0080                	addi	s0,sp,64
 872:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 874:	cad9                	beqz	a3,90a <printint+0xa4>
 876:	01f5d79b          	srliw	a5,a1,0x1f
 87a:	cbc1                	beqz	a5,90a <printint+0xa4>
    neg = 1;
    x = -xx;
 87c:	40b005bb          	negw	a1,a1
    neg = 1;
 880:	4305                	li	t1,1
  } else {
    x = xx;
  }

  i = 0;
 882:	fc040993          	addi	s3,s0,-64
  neg = 0;
 886:	86ce                	mv	a3,s3
  i = 0;
 888:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 88a:	00000817          	auipc	a6,0x0
 88e:	5a680813          	addi	a6,a6,1446 # e30 <digits>
 892:	88ba                	mv	a7,a4
 894:	0017051b          	addiw	a0,a4,1
 898:	872a                	mv	a4,a0
 89a:	02c5f7bb          	remuw	a5,a1,a2
 89e:	1782                	slli	a5,a5,0x20
 8a0:	9381                	srli	a5,a5,0x20
 8a2:	97c2                	add	a5,a5,a6
 8a4:	0007c783          	lbu	a5,0(a5)
 8a8:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 8ac:	87ae                	mv	a5,a1
 8ae:	02c5d5bb          	divuw	a1,a1,a2
 8b2:	0685                	addi	a3,a3,1
 8b4:	fcc7ffe3          	bgeu	a5,a2,892 <printint+0x2c>
  if(neg)
 8b8:	00030c63          	beqz	t1,8d0 <printint+0x6a>
    buf[i++] = '-';
 8bc:	fd050793          	addi	a5,a0,-48
 8c0:	00878533          	add	a0,a5,s0
 8c4:	02d00793          	li	a5,45
 8c8:	fef50823          	sb	a5,-16(a0)
 8cc:	0028871b          	addiw	a4,a7,2

  while(--i >= 0)
 8d0:	02e05763          	blez	a4,8fe <printint+0x98>
 8d4:	f426                	sd	s1,40(sp)
 8d6:	377d                	addiw	a4,a4,-1
 8d8:	00e984b3          	add	s1,s3,a4
 8dc:	19fd                	addi	s3,s3,-1
 8de:	99ba                	add	s3,s3,a4
 8e0:	1702                	slli	a4,a4,0x20
 8e2:	9301                	srli	a4,a4,0x20
 8e4:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 8e8:	0004c583          	lbu	a1,0(s1)
 8ec:	854a                	mv	a0,s2
 8ee:	00000097          	auipc	ra,0x0
 8f2:	f56080e7          	jalr	-170(ra) # 844 <putc>
  while(--i >= 0)
 8f6:	14fd                	addi	s1,s1,-1
 8f8:	ff3498e3          	bne	s1,s3,8e8 <printint+0x82>
 8fc:	74a2                	ld	s1,40(sp)
}
 8fe:	70e2                	ld	ra,56(sp)
 900:	7442                	ld	s0,48(sp)
 902:	7902                	ld	s2,32(sp)
 904:	69e2                	ld	s3,24(sp)
 906:	6121                	addi	sp,sp,64
 908:	8082                	ret
  neg = 0;
 90a:	4301                	li	t1,0
 90c:	bf9d                	j	882 <printint+0x1c>

000000000000090e <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 90e:	715d                	addi	sp,sp,-80
 910:	e486                	sd	ra,72(sp)
 912:	e0a2                	sd	s0,64(sp)
 914:	f84a                	sd	s2,48(sp)
 916:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 918:	0005c903          	lbu	s2,0(a1)
 91c:	1a090b63          	beqz	s2,ad2 <vprintf+0x1c4>
 920:	fc26                	sd	s1,56(sp)
 922:	f44e                	sd	s3,40(sp)
 924:	f052                	sd	s4,32(sp)
 926:	ec56                	sd	s5,24(sp)
 928:	e85a                	sd	s6,16(sp)
 92a:	e45e                	sd	s7,8(sp)
 92c:	8aaa                	mv	s5,a0
 92e:	8bb2                	mv	s7,a2
 930:	00158493          	addi	s1,a1,1
  state = 0;
 934:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 936:	02500a13          	li	s4,37
 93a:	4b55                	li	s6,21
 93c:	a839                	j	95a <vprintf+0x4c>
        putc(fd, c);
 93e:	85ca                	mv	a1,s2
 940:	8556                	mv	a0,s5
 942:	00000097          	auipc	ra,0x0
 946:	f02080e7          	jalr	-254(ra) # 844 <putc>
 94a:	a019                	j	950 <vprintf+0x42>
    } else if(state == '%'){
 94c:	01498d63          	beq	s3,s4,966 <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
 950:	0485                	addi	s1,s1,1
 952:	fff4c903          	lbu	s2,-1(s1)
 956:	16090863          	beqz	s2,ac6 <vprintf+0x1b8>
    if(state == 0){
 95a:	fe0999e3          	bnez	s3,94c <vprintf+0x3e>
      if(c == '%'){
 95e:	ff4910e3          	bne	s2,s4,93e <vprintf+0x30>
        state = '%';
 962:	89d2                	mv	s3,s4
 964:	b7f5                	j	950 <vprintf+0x42>
      if(c == 'd'){
 966:	13490563          	beq	s2,s4,a90 <vprintf+0x182>
 96a:	f9d9079b          	addiw	a5,s2,-99
 96e:	0ff7f793          	zext.b	a5,a5
 972:	12fb6863          	bltu	s6,a5,aa2 <vprintf+0x194>
 976:	f9d9079b          	addiw	a5,s2,-99
 97a:	0ff7f713          	zext.b	a4,a5
 97e:	12eb6263          	bltu	s6,a4,aa2 <vprintf+0x194>
 982:	00271793          	slli	a5,a4,0x2
 986:	00000717          	auipc	a4,0x0
 98a:	45270713          	addi	a4,a4,1106 # dd8 <malloc+0x212>
 98e:	97ba                	add	a5,a5,a4
 990:	439c                	lw	a5,0(a5)
 992:	97ba                	add	a5,a5,a4
 994:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 996:	008b8913          	addi	s2,s7,8
 99a:	4685                	li	a3,1
 99c:	4629                	li	a2,10
 99e:	000ba583          	lw	a1,0(s7)
 9a2:	8556                	mv	a0,s5
 9a4:	00000097          	auipc	ra,0x0
 9a8:	ec2080e7          	jalr	-318(ra) # 866 <printint>
 9ac:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 9ae:	4981                	li	s3,0
 9b0:	b745                	j	950 <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
 9b2:	008b8913          	addi	s2,s7,8
 9b6:	4681                	li	a3,0
 9b8:	4629                	li	a2,10
 9ba:	000ba583          	lw	a1,0(s7)
 9be:	8556                	mv	a0,s5
 9c0:	00000097          	auipc	ra,0x0
 9c4:	ea6080e7          	jalr	-346(ra) # 866 <printint>
 9c8:	8bca                	mv	s7,s2
      state = 0;
 9ca:	4981                	li	s3,0
 9cc:	b751                	j	950 <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
 9ce:	008b8913          	addi	s2,s7,8
 9d2:	4681                	li	a3,0
 9d4:	4641                	li	a2,16
 9d6:	000ba583          	lw	a1,0(s7)
 9da:	8556                	mv	a0,s5
 9dc:	00000097          	auipc	ra,0x0
 9e0:	e8a080e7          	jalr	-374(ra) # 866 <printint>
 9e4:	8bca                	mv	s7,s2
      state = 0;
 9e6:	4981                	li	s3,0
 9e8:	b7a5                	j	950 <vprintf+0x42>
 9ea:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
 9ec:	008b8793          	addi	a5,s7,8
 9f0:	8c3e                	mv	s8,a5
 9f2:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 9f6:	03000593          	li	a1,48
 9fa:	8556                	mv	a0,s5
 9fc:	00000097          	auipc	ra,0x0
 a00:	e48080e7          	jalr	-440(ra) # 844 <putc>
  putc(fd, 'x');
 a04:	07800593          	li	a1,120
 a08:	8556                	mv	a0,s5
 a0a:	00000097          	auipc	ra,0x0
 a0e:	e3a080e7          	jalr	-454(ra) # 844 <putc>
 a12:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 a14:	00000b97          	auipc	s7,0x0
 a18:	41cb8b93          	addi	s7,s7,1052 # e30 <digits>
 a1c:	03c9d793          	srli	a5,s3,0x3c
 a20:	97de                	add	a5,a5,s7
 a22:	0007c583          	lbu	a1,0(a5)
 a26:	8556                	mv	a0,s5
 a28:	00000097          	auipc	ra,0x0
 a2c:	e1c080e7          	jalr	-484(ra) # 844 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 a30:	0992                	slli	s3,s3,0x4
 a32:	397d                	addiw	s2,s2,-1
 a34:	fe0914e3          	bnez	s2,a1c <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
 a38:	8be2                	mv	s7,s8
      state = 0;
 a3a:	4981                	li	s3,0
 a3c:	6c02                	ld	s8,0(sp)
 a3e:	bf09                	j	950 <vprintf+0x42>
        s = va_arg(ap, char*);
 a40:	008b8993          	addi	s3,s7,8
 a44:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 a48:	02090163          	beqz	s2,a6a <vprintf+0x15c>
        while(*s != 0){
 a4c:	00094583          	lbu	a1,0(s2)
 a50:	c9a5                	beqz	a1,ac0 <vprintf+0x1b2>
          putc(fd, *s);
 a52:	8556                	mv	a0,s5
 a54:	00000097          	auipc	ra,0x0
 a58:	df0080e7          	jalr	-528(ra) # 844 <putc>
          s++;
 a5c:	0905                	addi	s2,s2,1
        while(*s != 0){
 a5e:	00094583          	lbu	a1,0(s2)
 a62:	f9e5                	bnez	a1,a52 <vprintf+0x144>
        s = va_arg(ap, char*);
 a64:	8bce                	mv	s7,s3
      state = 0;
 a66:	4981                	li	s3,0
 a68:	b5e5                	j	950 <vprintf+0x42>
          s = "(null)";
 a6a:	00000917          	auipc	s2,0x0
 a6e:	36690913          	addi	s2,s2,870 # dd0 <malloc+0x20a>
        while(*s != 0){
 a72:	02800593          	li	a1,40
 a76:	bff1                	j	a52 <vprintf+0x144>
        putc(fd, va_arg(ap, uint));
 a78:	008b8913          	addi	s2,s7,8
 a7c:	000bc583          	lbu	a1,0(s7)
 a80:	8556                	mv	a0,s5
 a82:	00000097          	auipc	ra,0x0
 a86:	dc2080e7          	jalr	-574(ra) # 844 <putc>
 a8a:	8bca                	mv	s7,s2
      state = 0;
 a8c:	4981                	li	s3,0
 a8e:	b5c9                	j	950 <vprintf+0x42>
        putc(fd, c);
 a90:	02500593          	li	a1,37
 a94:	8556                	mv	a0,s5
 a96:	00000097          	auipc	ra,0x0
 a9a:	dae080e7          	jalr	-594(ra) # 844 <putc>
      state = 0;
 a9e:	4981                	li	s3,0
 aa0:	bd45                	j	950 <vprintf+0x42>
        putc(fd, '%');
 aa2:	02500593          	li	a1,37
 aa6:	8556                	mv	a0,s5
 aa8:	00000097          	auipc	ra,0x0
 aac:	d9c080e7          	jalr	-612(ra) # 844 <putc>
        putc(fd, c);
 ab0:	85ca                	mv	a1,s2
 ab2:	8556                	mv	a0,s5
 ab4:	00000097          	auipc	ra,0x0
 ab8:	d90080e7          	jalr	-624(ra) # 844 <putc>
      state = 0;
 abc:	4981                	li	s3,0
 abe:	bd49                	j	950 <vprintf+0x42>
        s = va_arg(ap, char*);
 ac0:	8bce                	mv	s7,s3
      state = 0;
 ac2:	4981                	li	s3,0
 ac4:	b571                	j	950 <vprintf+0x42>
 ac6:	74e2                	ld	s1,56(sp)
 ac8:	79a2                	ld	s3,40(sp)
 aca:	7a02                	ld	s4,32(sp)
 acc:	6ae2                	ld	s5,24(sp)
 ace:	6b42                	ld	s6,16(sp)
 ad0:	6ba2                	ld	s7,8(sp)
    }
  }
}
 ad2:	60a6                	ld	ra,72(sp)
 ad4:	6406                	ld	s0,64(sp)
 ad6:	7942                	ld	s2,48(sp)
 ad8:	6161                	addi	sp,sp,80
 ada:	8082                	ret

0000000000000adc <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 adc:	715d                	addi	sp,sp,-80
 ade:	ec06                	sd	ra,24(sp)
 ae0:	e822                	sd	s0,16(sp)
 ae2:	1000                	addi	s0,sp,32
 ae4:	e010                	sd	a2,0(s0)
 ae6:	e414                	sd	a3,8(s0)
 ae8:	e818                	sd	a4,16(s0)
 aea:	ec1c                	sd	a5,24(s0)
 aec:	03043023          	sd	a6,32(s0)
 af0:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 af4:	8622                	mv	a2,s0
 af6:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 afa:	00000097          	auipc	ra,0x0
 afe:	e14080e7          	jalr	-492(ra) # 90e <vprintf>
}
 b02:	60e2                	ld	ra,24(sp)
 b04:	6442                	ld	s0,16(sp)
 b06:	6161                	addi	sp,sp,80
 b08:	8082                	ret

0000000000000b0a <printf>:

void
printf(const char *fmt, ...)
{
 b0a:	711d                	addi	sp,sp,-96
 b0c:	ec06                	sd	ra,24(sp)
 b0e:	e822                	sd	s0,16(sp)
 b10:	1000                	addi	s0,sp,32
 b12:	e40c                	sd	a1,8(s0)
 b14:	e810                	sd	a2,16(s0)
 b16:	ec14                	sd	a3,24(s0)
 b18:	f018                	sd	a4,32(s0)
 b1a:	f41c                	sd	a5,40(s0)
 b1c:	03043823          	sd	a6,48(s0)
 b20:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 b24:	00840613          	addi	a2,s0,8
 b28:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 b2c:	85aa                	mv	a1,a0
 b2e:	4505                	li	a0,1
 b30:	00000097          	auipc	ra,0x0
 b34:	dde080e7          	jalr	-546(ra) # 90e <vprintf>
}
 b38:	60e2                	ld	ra,24(sp)
 b3a:	6442                	ld	s0,16(sp)
 b3c:	6125                	addi	sp,sp,96
 b3e:	8082                	ret

0000000000000b40 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 b40:	1141                	addi	sp,sp,-16
 b42:	e406                	sd	ra,8(sp)
 b44:	e022                	sd	s0,0(sp)
 b46:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 b48:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b4c:	00000797          	auipc	a5,0x0
 b50:	2fc7b783          	ld	a5,764(a5) # e48 <freep>
 b54:	a039                	j	b62 <free+0x22>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b56:	6398                	ld	a4,0(a5)
 b58:	00e7e463          	bltu	a5,a4,b60 <free+0x20>
 b5c:	00e6ea63          	bltu	a3,a4,b70 <free+0x30>
{
 b60:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b62:	fed7fae3          	bgeu	a5,a3,b56 <free+0x16>
 b66:	6398                	ld	a4,0(a5)
 b68:	00e6e463          	bltu	a3,a4,b70 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b6c:	fee7eae3          	bltu	a5,a4,b60 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 b70:	ff852583          	lw	a1,-8(a0)
 b74:	6390                	ld	a2,0(a5)
 b76:	02059813          	slli	a6,a1,0x20
 b7a:	01c85713          	srli	a4,a6,0x1c
 b7e:	9736                	add	a4,a4,a3
 b80:	02e60563          	beq	a2,a4,baa <free+0x6a>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 b84:	fec53823          	sd	a2,-16(a0)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 b88:	4790                	lw	a2,8(a5)
 b8a:	02061593          	slli	a1,a2,0x20
 b8e:	01c5d713          	srli	a4,a1,0x1c
 b92:	973e                	add	a4,a4,a5
 b94:	02e68263          	beq	a3,a4,bb8 <free+0x78>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 b98:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 b9a:	00000717          	auipc	a4,0x0
 b9e:	2af73723          	sd	a5,686(a4) # e48 <freep>
}
 ba2:	60a2                	ld	ra,8(sp)
 ba4:	6402                	ld	s0,0(sp)
 ba6:	0141                	addi	sp,sp,16
 ba8:	8082                	ret
    bp->s.size += p->s.ptr->s.size;
 baa:	4618                	lw	a4,8(a2)
 bac:	9f2d                	addw	a4,a4,a1
 bae:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 bb2:	6398                	ld	a4,0(a5)
 bb4:	6310                	ld	a2,0(a4)
 bb6:	b7f9                	j	b84 <free+0x44>
    p->s.size += bp->s.size;
 bb8:	ff852703          	lw	a4,-8(a0)
 bbc:	9f31                	addw	a4,a4,a2
 bbe:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 bc0:	ff053683          	ld	a3,-16(a0)
 bc4:	bfd1                	j	b98 <free+0x58>

0000000000000bc6 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 bc6:	7139                	addi	sp,sp,-64
 bc8:	fc06                	sd	ra,56(sp)
 bca:	f822                	sd	s0,48(sp)
 bcc:	f04a                	sd	s2,32(sp)
 bce:	ec4e                	sd	s3,24(sp)
 bd0:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 bd2:	02051993          	slli	s3,a0,0x20
 bd6:	0209d993          	srli	s3,s3,0x20
 bda:	09bd                	addi	s3,s3,15
 bdc:	0049d993          	srli	s3,s3,0x4
 be0:	2985                	addiw	s3,s3,1
 be2:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 be4:	00000517          	auipc	a0,0x0
 be8:	26453503          	ld	a0,612(a0) # e48 <freep>
 bec:	c905                	beqz	a0,c1c <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 bee:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 bf0:	4798                	lw	a4,8(a5)
 bf2:	09377a63          	bgeu	a4,s3,c86 <malloc+0xc0>
 bf6:	f426                	sd	s1,40(sp)
 bf8:	e852                	sd	s4,16(sp)
 bfa:	e456                	sd	s5,8(sp)
 bfc:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 bfe:	8a4e                	mv	s4,s3
 c00:	6705                	lui	a4,0x1
 c02:	00e9f363          	bgeu	s3,a4,c08 <malloc+0x42>
 c06:	6a05                	lui	s4,0x1
 c08:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 c0c:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 c10:	00000497          	auipc	s1,0x0
 c14:	23848493          	addi	s1,s1,568 # e48 <freep>
  if(p == (char*)-1)
 c18:	5afd                	li	s5,-1
 c1a:	a089                	j	c5c <malloc+0x96>
 c1c:	f426                	sd	s1,40(sp)
 c1e:	e852                	sd	s4,16(sp)
 c20:	e456                	sd	s5,8(sp)
 c22:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 c24:	00000797          	auipc	a5,0x0
 c28:	22c78793          	addi	a5,a5,556 # e50 <base>
 c2c:	00000717          	auipc	a4,0x0
 c30:	20f73e23          	sd	a5,540(a4) # e48 <freep>
 c34:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 c36:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 c3a:	b7d1                	j	bfe <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 c3c:	6398                	ld	a4,0(a5)
 c3e:	e118                	sd	a4,0(a0)
 c40:	a8b9                	j	c9e <malloc+0xd8>
  hp->s.size = nu;
 c42:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 c46:	0541                	addi	a0,a0,16
 c48:	00000097          	auipc	ra,0x0
 c4c:	ef8080e7          	jalr	-264(ra) # b40 <free>
  return freep;
 c50:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 c52:	c135                	beqz	a0,cb6 <malloc+0xf0>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 c54:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 c56:	4798                	lw	a4,8(a5)
 c58:	03277363          	bgeu	a4,s2,c7e <malloc+0xb8>
    if(p == freep)
 c5c:	6098                	ld	a4,0(s1)
 c5e:	853e                	mv	a0,a5
 c60:	fef71ae3          	bne	a4,a5,c54 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 c64:	8552                	mv	a0,s4
 c66:	00000097          	auipc	ra,0x0
 c6a:	bbe080e7          	jalr	-1090(ra) # 824 <sbrk>
  if(p == (char*)-1)
 c6e:	fd551ae3          	bne	a0,s5,c42 <malloc+0x7c>
        return 0;
 c72:	4501                	li	a0,0
 c74:	74a2                	ld	s1,40(sp)
 c76:	6a42                	ld	s4,16(sp)
 c78:	6aa2                	ld	s5,8(sp)
 c7a:	6b02                	ld	s6,0(sp)
 c7c:	a03d                	j	caa <malloc+0xe4>
 c7e:	74a2                	ld	s1,40(sp)
 c80:	6a42                	ld	s4,16(sp)
 c82:	6aa2                	ld	s5,8(sp)
 c84:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 c86:	fae90be3          	beq	s2,a4,c3c <malloc+0x76>
        p->s.size -= nunits;
 c8a:	4137073b          	subw	a4,a4,s3
 c8e:	c798                	sw	a4,8(a5)
        p += p->s.size;
 c90:	02071693          	slli	a3,a4,0x20
 c94:	01c6d713          	srli	a4,a3,0x1c
 c98:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 c9a:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 c9e:	00000717          	auipc	a4,0x0
 ca2:	1aa73523          	sd	a0,426(a4) # e48 <freep>
      return (void*)(p + 1);
 ca6:	01078513          	addi	a0,a5,16
  }
}
 caa:	70e2                	ld	ra,56(sp)
 cac:	7442                	ld	s0,48(sp)
 cae:	7902                	ld	s2,32(sp)
 cb0:	69e2                	ld	s3,24(sp)
 cb2:	6121                	addi	sp,sp,64
 cb4:	8082                	ret
 cb6:	74a2                	ld	s1,40(sp)
 cb8:	6a42                	ld	s4,16(sp)
 cba:	6aa2                	ld	s5,8(sp)
 cbc:	6b02                	ld	s6,0(sp)
 cbe:	b7f5                	j	caa <malloc+0xe4>
