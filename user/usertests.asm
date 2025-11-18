
user/_usertests：     文件格式 elf64-littleriscv


Disassembly of section .text:

0000000000000000 <bsstest>:
void
bsstest(char *s)
{
  int i;

  for(i = 0; i < sizeof(uninit); i++){
       0:	00007797          	auipc	a5,0x7
       4:	d2078793          	addi	a5,a5,-736 # 6d20 <uninit>
       8:	00009697          	auipc	a3,0x9
       c:	42868693          	addi	a3,a3,1064 # 9430 <buf>
    if(uninit[i] != '\0'){
      10:	0007c703          	lbu	a4,0(a5)
      14:	e709                	bnez	a4,1e <bsstest+0x1e>
  for(i = 0; i < sizeof(uninit); i++){
      16:	0785                	addi	a5,a5,1
      18:	fed79ce3          	bne	a5,a3,10 <bsstest+0x10>
      1c:	8082                	ret
{
      1e:	1141                	addi	sp,sp,-16
      20:	e406                	sd	ra,8(sp)
      22:	e022                	sd	s0,0(sp)
      24:	0800                	addi	s0,sp,16
      printf("%s: bss test failed\n", s);
      26:	85aa                	mv	a1,a0
      28:	00005517          	auipc	a0,0x5
      2c:	ad050513          	addi	a0,a0,-1328 # 4af8 <malloc+0xfa>
      30:	00005097          	auipc	ra,0x5
      34:	912080e7          	jalr	-1774(ra) # 4942 <printf>
      exit(1);
      38:	4505                	li	a0,1
      3a:	00004097          	auipc	ra,0x4
      3e:	59a080e7          	jalr	1434(ra) # 45d4 <exit>

0000000000000042 <iputtest>:
{
      42:	1101                	addi	sp,sp,-32
      44:	ec06                	sd	ra,24(sp)
      46:	e822                	sd	s0,16(sp)
      48:	e426                	sd	s1,8(sp)
      4a:	1000                	addi	s0,sp,32
      4c:	84aa                	mv	s1,a0
  if(mkdir("iputdir") < 0){
      4e:	00005517          	auipc	a0,0x5
      52:	ac250513          	addi	a0,a0,-1342 # 4b10 <malloc+0x112>
      56:	00004097          	auipc	ra,0x4
      5a:	5e6080e7          	jalr	1510(ra) # 463c <mkdir>
      5e:	04054563          	bltz	a0,a8 <iputtest+0x66>
  if(chdir("iputdir") < 0){
      62:	00005517          	auipc	a0,0x5
      66:	aae50513          	addi	a0,a0,-1362 # 4b10 <malloc+0x112>
      6a:	00004097          	auipc	ra,0x4
      6e:	5da080e7          	jalr	1498(ra) # 4644 <chdir>
      72:	04054963          	bltz	a0,c4 <iputtest+0x82>
  if(unlink("../iputdir") < 0){
      76:	00005517          	auipc	a0,0x5
      7a:	ada50513          	addi	a0,a0,-1318 # 4b50 <malloc+0x152>
      7e:	00004097          	auipc	ra,0x4
      82:	5a6080e7          	jalr	1446(ra) # 4624 <unlink>
      86:	04054d63          	bltz	a0,e0 <iputtest+0x9e>
  if(chdir("/") < 0){
      8a:	00005517          	auipc	a0,0x5
      8e:	af650513          	addi	a0,a0,-1290 # 4b80 <malloc+0x182>
      92:	00004097          	auipc	ra,0x4
      96:	5b2080e7          	jalr	1458(ra) # 4644 <chdir>
      9a:	06054163          	bltz	a0,fc <iputtest+0xba>
}
      9e:	60e2                	ld	ra,24(sp)
      a0:	6442                	ld	s0,16(sp)
      a2:	64a2                	ld	s1,8(sp)
      a4:	6105                	addi	sp,sp,32
      a6:	8082                	ret
    printf("%s: mkdir failed\n", s);
      a8:	85a6                	mv	a1,s1
      aa:	00005517          	auipc	a0,0x5
      ae:	a6e50513          	addi	a0,a0,-1426 # 4b18 <malloc+0x11a>
      b2:	00005097          	auipc	ra,0x5
      b6:	890080e7          	jalr	-1904(ra) # 4942 <printf>
    exit(1);
      ba:	4505                	li	a0,1
      bc:	00004097          	auipc	ra,0x4
      c0:	518080e7          	jalr	1304(ra) # 45d4 <exit>
    printf("%s: chdir iputdir failed\n", s);
      c4:	85a6                	mv	a1,s1
      c6:	00005517          	auipc	a0,0x5
      ca:	a6a50513          	addi	a0,a0,-1430 # 4b30 <malloc+0x132>
      ce:	00005097          	auipc	ra,0x5
      d2:	874080e7          	jalr	-1932(ra) # 4942 <printf>
    exit(1);
      d6:	4505                	li	a0,1
      d8:	00004097          	auipc	ra,0x4
      dc:	4fc080e7          	jalr	1276(ra) # 45d4 <exit>
    printf("%s: unlink ../iputdir failed\n", s);
      e0:	85a6                	mv	a1,s1
      e2:	00005517          	auipc	a0,0x5
      e6:	a7e50513          	addi	a0,a0,-1410 # 4b60 <malloc+0x162>
      ea:	00005097          	auipc	ra,0x5
      ee:	858080e7          	jalr	-1960(ra) # 4942 <printf>
    exit(1);
      f2:	4505                	li	a0,1
      f4:	00004097          	auipc	ra,0x4
      f8:	4e0080e7          	jalr	1248(ra) # 45d4 <exit>
    printf("%s: chdir / failed\n", s);
      fc:	85a6                	mv	a1,s1
      fe:	00005517          	auipc	a0,0x5
     102:	a8a50513          	addi	a0,a0,-1398 # 4b88 <malloc+0x18a>
     106:	00005097          	auipc	ra,0x5
     10a:	83c080e7          	jalr	-1988(ra) # 4942 <printf>
    exit(1);
     10e:	4505                	li	a0,1
     110:	00004097          	auipc	ra,0x4
     114:	4c4080e7          	jalr	1220(ra) # 45d4 <exit>

0000000000000118 <rmdot>:
{
     118:	1101                	addi	sp,sp,-32
     11a:	ec06                	sd	ra,24(sp)
     11c:	e822                	sd	s0,16(sp)
     11e:	e426                	sd	s1,8(sp)
     120:	1000                	addi	s0,sp,32
     122:	84aa                	mv	s1,a0
  if(mkdir("dots") != 0){
     124:	00005517          	auipc	a0,0x5
     128:	a7c50513          	addi	a0,a0,-1412 # 4ba0 <malloc+0x1a2>
     12c:	00004097          	auipc	ra,0x4
     130:	510080e7          	jalr	1296(ra) # 463c <mkdir>
     134:	e549                	bnez	a0,1be <rmdot+0xa6>
  if(chdir("dots") != 0){
     136:	00005517          	auipc	a0,0x5
     13a:	a6a50513          	addi	a0,a0,-1430 # 4ba0 <malloc+0x1a2>
     13e:	00004097          	auipc	ra,0x4
     142:	506080e7          	jalr	1286(ra) # 4644 <chdir>
     146:	e951                	bnez	a0,1da <rmdot+0xc2>
  if(unlink(".") == 0){
     148:	00005517          	auipc	a0,0x5
     14c:	a9050513          	addi	a0,a0,-1392 # 4bd8 <malloc+0x1da>
     150:	00004097          	auipc	ra,0x4
     154:	4d4080e7          	jalr	1236(ra) # 4624 <unlink>
     158:	cd59                	beqz	a0,1f6 <rmdot+0xde>
  if(unlink("..") == 0){
     15a:	00005517          	auipc	a0,0x5
     15e:	a9e50513          	addi	a0,a0,-1378 # 4bf8 <malloc+0x1fa>
     162:	00004097          	auipc	ra,0x4
     166:	4c2080e7          	jalr	1218(ra) # 4624 <unlink>
     16a:	c545                	beqz	a0,212 <rmdot+0xfa>
  if(chdir("/") != 0){
     16c:	00005517          	auipc	a0,0x5
     170:	a1450513          	addi	a0,a0,-1516 # 4b80 <malloc+0x182>
     174:	00004097          	auipc	ra,0x4
     178:	4d0080e7          	jalr	1232(ra) # 4644 <chdir>
     17c:	e94d                	bnez	a0,22e <rmdot+0x116>
  if(unlink("dots/.") == 0){
     17e:	00005517          	auipc	a0,0x5
     182:	a9a50513          	addi	a0,a0,-1382 # 4c18 <malloc+0x21a>
     186:	00004097          	auipc	ra,0x4
     18a:	49e080e7          	jalr	1182(ra) # 4624 <unlink>
     18e:	cd55                	beqz	a0,24a <rmdot+0x132>
  if(unlink("dots/..") == 0){
     190:	00005517          	auipc	a0,0x5
     194:	ab050513          	addi	a0,a0,-1360 # 4c40 <malloc+0x242>
     198:	00004097          	auipc	ra,0x4
     19c:	48c080e7          	jalr	1164(ra) # 4624 <unlink>
     1a0:	c179                	beqz	a0,266 <rmdot+0x14e>
  if(unlink("dots") != 0){
     1a2:	00005517          	auipc	a0,0x5
     1a6:	9fe50513          	addi	a0,a0,-1538 # 4ba0 <malloc+0x1a2>
     1aa:	00004097          	auipc	ra,0x4
     1ae:	47a080e7          	jalr	1146(ra) # 4624 <unlink>
     1b2:	e961                	bnez	a0,282 <rmdot+0x16a>
}
     1b4:	60e2                	ld	ra,24(sp)
     1b6:	6442                	ld	s0,16(sp)
     1b8:	64a2                	ld	s1,8(sp)
     1ba:	6105                	addi	sp,sp,32
     1bc:	8082                	ret
    printf("%s: mkdir dots failed\n", s);
     1be:	85a6                	mv	a1,s1
     1c0:	00005517          	auipc	a0,0x5
     1c4:	9e850513          	addi	a0,a0,-1560 # 4ba8 <malloc+0x1aa>
     1c8:	00004097          	auipc	ra,0x4
     1cc:	77a080e7          	jalr	1914(ra) # 4942 <printf>
    exit(1);
     1d0:	4505                	li	a0,1
     1d2:	00004097          	auipc	ra,0x4
     1d6:	402080e7          	jalr	1026(ra) # 45d4 <exit>
    printf("%s: chdir dots failed\n", s);
     1da:	85a6                	mv	a1,s1
     1dc:	00005517          	auipc	a0,0x5
     1e0:	9e450513          	addi	a0,a0,-1564 # 4bc0 <malloc+0x1c2>
     1e4:	00004097          	auipc	ra,0x4
     1e8:	75e080e7          	jalr	1886(ra) # 4942 <printf>
    exit(1);
     1ec:	4505                	li	a0,1
     1ee:	00004097          	auipc	ra,0x4
     1f2:	3e6080e7          	jalr	998(ra) # 45d4 <exit>
    printf("%s: rm . worked!\n", s);
     1f6:	85a6                	mv	a1,s1
     1f8:	00005517          	auipc	a0,0x5
     1fc:	9e850513          	addi	a0,a0,-1560 # 4be0 <malloc+0x1e2>
     200:	00004097          	auipc	ra,0x4
     204:	742080e7          	jalr	1858(ra) # 4942 <printf>
    exit(1);
     208:	4505                	li	a0,1
     20a:	00004097          	auipc	ra,0x4
     20e:	3ca080e7          	jalr	970(ra) # 45d4 <exit>
    printf("%s: rm .. worked!\n", s);
     212:	85a6                	mv	a1,s1
     214:	00005517          	auipc	a0,0x5
     218:	9ec50513          	addi	a0,a0,-1556 # 4c00 <malloc+0x202>
     21c:	00004097          	auipc	ra,0x4
     220:	726080e7          	jalr	1830(ra) # 4942 <printf>
    exit(1);
     224:	4505                	li	a0,1
     226:	00004097          	auipc	ra,0x4
     22a:	3ae080e7          	jalr	942(ra) # 45d4 <exit>
    printf("%s: chdir / failed\n", s);
     22e:	85a6                	mv	a1,s1
     230:	00005517          	auipc	a0,0x5
     234:	95850513          	addi	a0,a0,-1704 # 4b88 <malloc+0x18a>
     238:	00004097          	auipc	ra,0x4
     23c:	70a080e7          	jalr	1802(ra) # 4942 <printf>
    exit(1);
     240:	4505                	li	a0,1
     242:	00004097          	auipc	ra,0x4
     246:	392080e7          	jalr	914(ra) # 45d4 <exit>
    printf("%s: unlink dots/. worked!\n", s);
     24a:	85a6                	mv	a1,s1
     24c:	00005517          	auipc	a0,0x5
     250:	9d450513          	addi	a0,a0,-1580 # 4c20 <malloc+0x222>
     254:	00004097          	auipc	ra,0x4
     258:	6ee080e7          	jalr	1774(ra) # 4942 <printf>
    exit(1);
     25c:	4505                	li	a0,1
     25e:	00004097          	auipc	ra,0x4
     262:	376080e7          	jalr	886(ra) # 45d4 <exit>
    printf("%s: unlink dots/.. worked!\n", s);
     266:	85a6                	mv	a1,s1
     268:	00005517          	auipc	a0,0x5
     26c:	9e050513          	addi	a0,a0,-1568 # 4c48 <malloc+0x24a>
     270:	00004097          	auipc	ra,0x4
     274:	6d2080e7          	jalr	1746(ra) # 4942 <printf>
    exit(1);
     278:	4505                	li	a0,1
     27a:	00004097          	auipc	ra,0x4
     27e:	35a080e7          	jalr	858(ra) # 45d4 <exit>
    printf("%s: unlink dots failed!\n", s);
     282:	85a6                	mv	a1,s1
     284:	00005517          	auipc	a0,0x5
     288:	9e450513          	addi	a0,a0,-1564 # 4c68 <malloc+0x26a>
     28c:	00004097          	auipc	ra,0x4
     290:	6b6080e7          	jalr	1718(ra) # 4942 <printf>
    exit(1);
     294:	4505                	li	a0,1
     296:	00004097          	auipc	ra,0x4
     29a:	33e080e7          	jalr	830(ra) # 45d4 <exit>

000000000000029e <exitiputtest>:
{
     29e:	7179                	addi	sp,sp,-48
     2a0:	f406                	sd	ra,40(sp)
     2a2:	f022                	sd	s0,32(sp)
     2a4:	ec26                	sd	s1,24(sp)
     2a6:	1800                	addi	s0,sp,48
     2a8:	84aa                	mv	s1,a0
  pid = fork();
     2aa:	00004097          	auipc	ra,0x4
     2ae:	322080e7          	jalr	802(ra) # 45cc <fork>
  if(pid < 0){
     2b2:	04054663          	bltz	a0,2fe <exitiputtest+0x60>
  if(pid == 0){
     2b6:	ed45                	bnez	a0,36e <exitiputtest+0xd0>
    if(mkdir("iputdir") < 0){
     2b8:	00005517          	auipc	a0,0x5
     2bc:	85850513          	addi	a0,a0,-1960 # 4b10 <malloc+0x112>
     2c0:	00004097          	auipc	ra,0x4
     2c4:	37c080e7          	jalr	892(ra) # 463c <mkdir>
     2c8:	04054963          	bltz	a0,31a <exitiputtest+0x7c>
    if(chdir("iputdir") < 0){
     2cc:	00005517          	auipc	a0,0x5
     2d0:	84450513          	addi	a0,a0,-1980 # 4b10 <malloc+0x112>
     2d4:	00004097          	auipc	ra,0x4
     2d8:	370080e7          	jalr	880(ra) # 4644 <chdir>
     2dc:	04054d63          	bltz	a0,336 <exitiputtest+0x98>
    if(unlink("../iputdir") < 0){
     2e0:	00005517          	auipc	a0,0x5
     2e4:	87050513          	addi	a0,a0,-1936 # 4b50 <malloc+0x152>
     2e8:	00004097          	auipc	ra,0x4
     2ec:	33c080e7          	jalr	828(ra) # 4624 <unlink>
     2f0:	06054163          	bltz	a0,352 <exitiputtest+0xb4>
    exit(0);
     2f4:	4501                	li	a0,0
     2f6:	00004097          	auipc	ra,0x4
     2fa:	2de080e7          	jalr	734(ra) # 45d4 <exit>
    printf("%s: fork failed\n", s);
     2fe:	85a6                	mv	a1,s1
     300:	00005517          	auipc	a0,0x5
     304:	98850513          	addi	a0,a0,-1656 # 4c88 <malloc+0x28a>
     308:	00004097          	auipc	ra,0x4
     30c:	63a080e7          	jalr	1594(ra) # 4942 <printf>
    exit(1);
     310:	4505                	li	a0,1
     312:	00004097          	auipc	ra,0x4
     316:	2c2080e7          	jalr	706(ra) # 45d4 <exit>
      printf("%s: mkdir failed\n", s);
     31a:	85a6                	mv	a1,s1
     31c:	00004517          	auipc	a0,0x4
     320:	7fc50513          	addi	a0,a0,2044 # 4b18 <malloc+0x11a>
     324:	00004097          	auipc	ra,0x4
     328:	61e080e7          	jalr	1566(ra) # 4942 <printf>
      exit(1);
     32c:	4505                	li	a0,1
     32e:	00004097          	auipc	ra,0x4
     332:	2a6080e7          	jalr	678(ra) # 45d4 <exit>
      printf("%s: child chdir failed\n", s);
     336:	85a6                	mv	a1,s1
     338:	00005517          	auipc	a0,0x5
     33c:	96850513          	addi	a0,a0,-1688 # 4ca0 <malloc+0x2a2>
     340:	00004097          	auipc	ra,0x4
     344:	602080e7          	jalr	1538(ra) # 4942 <printf>
      exit(1);
     348:	4505                	li	a0,1
     34a:	00004097          	auipc	ra,0x4
     34e:	28a080e7          	jalr	650(ra) # 45d4 <exit>
      printf("%s: unlink ../iputdir failed\n", s);
     352:	85a6                	mv	a1,s1
     354:	00005517          	auipc	a0,0x5
     358:	80c50513          	addi	a0,a0,-2036 # 4b60 <malloc+0x162>
     35c:	00004097          	auipc	ra,0x4
     360:	5e6080e7          	jalr	1510(ra) # 4942 <printf>
      exit(1);
     364:	4505                	li	a0,1
     366:	00004097          	auipc	ra,0x4
     36a:	26e080e7          	jalr	622(ra) # 45d4 <exit>
  wait(&xstatus);
     36e:	fdc40513          	addi	a0,s0,-36
     372:	00004097          	auipc	ra,0x4
     376:	26a080e7          	jalr	618(ra) # 45dc <wait>
  exit(xstatus);
     37a:	fdc42503          	lw	a0,-36(s0)
     37e:	00004097          	auipc	ra,0x4
     382:	256080e7          	jalr	598(ra) # 45d4 <exit>

0000000000000386 <exitwait>:
{
     386:	715d                	addi	sp,sp,-80
     388:	e486                	sd	ra,72(sp)
     38a:	e0a2                	sd	s0,64(sp)
     38c:	fc26                	sd	s1,56(sp)
     38e:	f84a                	sd	s2,48(sp)
     390:	f44e                	sd	s3,40(sp)
     392:	f052                	sd	s4,32(sp)
     394:	ec56                	sd	s5,24(sp)
     396:	0880                	addi	s0,sp,80
     398:	8aaa                	mv	s5,a0
  for(i = 0; i < 100; i++){
     39a:	4901                	li	s2,0
      if(wait(&xstate) != pid){
     39c:	fbc40993          	addi	s3,s0,-68
  for(i = 0; i < 100; i++){
     3a0:	06400a13          	li	s4,100
    pid = fork();
     3a4:	00004097          	auipc	ra,0x4
     3a8:	228080e7          	jalr	552(ra) # 45cc <fork>
     3ac:	84aa                	mv	s1,a0
    if(pid < 0){
     3ae:	02054a63          	bltz	a0,3e2 <exitwait+0x5c>
    if(pid){
     3b2:	c151                	beqz	a0,436 <exitwait+0xb0>
      if(wait(&xstate) != pid){
     3b4:	854e                	mv	a0,s3
     3b6:	00004097          	auipc	ra,0x4
     3ba:	226080e7          	jalr	550(ra) # 45dc <wait>
     3be:	04951063          	bne	a0,s1,3fe <exitwait+0x78>
      if(i != xstate) {
     3c2:	fbc42783          	lw	a5,-68(s0)
     3c6:	05279a63          	bne	a5,s2,41a <exitwait+0x94>
  for(i = 0; i < 100; i++){
     3ca:	2905                	addiw	s2,s2,1
     3cc:	fd491ce3          	bne	s2,s4,3a4 <exitwait+0x1e>
}
     3d0:	60a6                	ld	ra,72(sp)
     3d2:	6406                	ld	s0,64(sp)
     3d4:	74e2                	ld	s1,56(sp)
     3d6:	7942                	ld	s2,48(sp)
     3d8:	79a2                	ld	s3,40(sp)
     3da:	7a02                	ld	s4,32(sp)
     3dc:	6ae2                	ld	s5,24(sp)
     3de:	6161                	addi	sp,sp,80
     3e0:	8082                	ret
      printf("%s: fork failed\n", s);
     3e2:	85d6                	mv	a1,s5
     3e4:	00005517          	auipc	a0,0x5
     3e8:	8a450513          	addi	a0,a0,-1884 # 4c88 <malloc+0x28a>
     3ec:	00004097          	auipc	ra,0x4
     3f0:	556080e7          	jalr	1366(ra) # 4942 <printf>
      exit(1);
     3f4:	4505                	li	a0,1
     3f6:	00004097          	auipc	ra,0x4
     3fa:	1de080e7          	jalr	478(ra) # 45d4 <exit>
        printf("%s: wait wrong pid\n", s);
     3fe:	85d6                	mv	a1,s5
     400:	00005517          	auipc	a0,0x5
     404:	8b850513          	addi	a0,a0,-1864 # 4cb8 <malloc+0x2ba>
     408:	00004097          	auipc	ra,0x4
     40c:	53a080e7          	jalr	1338(ra) # 4942 <printf>
        exit(1);
     410:	4505                	li	a0,1
     412:	00004097          	auipc	ra,0x4
     416:	1c2080e7          	jalr	450(ra) # 45d4 <exit>
        printf("%s: wait wrong exit status\n", s);
     41a:	85d6                	mv	a1,s5
     41c:	00005517          	auipc	a0,0x5
     420:	8b450513          	addi	a0,a0,-1868 # 4cd0 <malloc+0x2d2>
     424:	00004097          	auipc	ra,0x4
     428:	51e080e7          	jalr	1310(ra) # 4942 <printf>
        exit(1);
     42c:	4505                	li	a0,1
     42e:	00004097          	auipc	ra,0x4
     432:	1a6080e7          	jalr	422(ra) # 45d4 <exit>
      exit(i);
     436:	854a                	mv	a0,s2
     438:	00004097          	auipc	ra,0x4
     43c:	19c080e7          	jalr	412(ra) # 45d4 <exit>

0000000000000440 <twochildren>:
{
     440:	1101                	addi	sp,sp,-32
     442:	ec06                	sd	ra,24(sp)
     444:	e822                	sd	s0,16(sp)
     446:	e426                	sd	s1,8(sp)
     448:	e04a                	sd	s2,0(sp)
     44a:	1000                	addi	s0,sp,32
     44c:	892a                	mv	s2,a0
     44e:	3e800493          	li	s1,1000
    int pid1 = fork();
     452:	00004097          	auipc	ra,0x4
     456:	17a080e7          	jalr	378(ra) # 45cc <fork>
    if(pid1 < 0){
     45a:	02054c63          	bltz	a0,492 <twochildren+0x52>
    if(pid1 == 0){
     45e:	c921                	beqz	a0,4ae <twochildren+0x6e>
      int pid2 = fork();
     460:	00004097          	auipc	ra,0x4
     464:	16c080e7          	jalr	364(ra) # 45cc <fork>
      if(pid2 < 0){
     468:	04054763          	bltz	a0,4b6 <twochildren+0x76>
      if(pid2 == 0){
     46c:	c13d                	beqz	a0,4d2 <twochildren+0x92>
        wait(0);
     46e:	4501                	li	a0,0
     470:	00004097          	auipc	ra,0x4
     474:	16c080e7          	jalr	364(ra) # 45dc <wait>
        wait(0);
     478:	4501                	li	a0,0
     47a:	00004097          	auipc	ra,0x4
     47e:	162080e7          	jalr	354(ra) # 45dc <wait>
  for(int i = 0; i < 1000; i++){
     482:	34fd                	addiw	s1,s1,-1
     484:	f4f9                	bnez	s1,452 <twochildren+0x12>
}
     486:	60e2                	ld	ra,24(sp)
     488:	6442                	ld	s0,16(sp)
     48a:	64a2                	ld	s1,8(sp)
     48c:	6902                	ld	s2,0(sp)
     48e:	6105                	addi	sp,sp,32
     490:	8082                	ret
      printf("%s: fork failed\n", s);
     492:	85ca                	mv	a1,s2
     494:	00004517          	auipc	a0,0x4
     498:	7f450513          	addi	a0,a0,2036 # 4c88 <malloc+0x28a>
     49c:	00004097          	auipc	ra,0x4
     4a0:	4a6080e7          	jalr	1190(ra) # 4942 <printf>
      exit(1);
     4a4:	4505                	li	a0,1
     4a6:	00004097          	auipc	ra,0x4
     4aa:	12e080e7          	jalr	302(ra) # 45d4 <exit>
      exit(0);
     4ae:	00004097          	auipc	ra,0x4
     4b2:	126080e7          	jalr	294(ra) # 45d4 <exit>
        printf("%s: fork failed\n", s);
     4b6:	85ca                	mv	a1,s2
     4b8:	00004517          	auipc	a0,0x4
     4bc:	7d050513          	addi	a0,a0,2000 # 4c88 <malloc+0x28a>
     4c0:	00004097          	auipc	ra,0x4
     4c4:	482080e7          	jalr	1154(ra) # 4942 <printf>
        exit(1);
     4c8:	4505                	li	a0,1
     4ca:	00004097          	auipc	ra,0x4
     4ce:	10a080e7          	jalr	266(ra) # 45d4 <exit>
        exit(0);
     4d2:	00004097          	auipc	ra,0x4
     4d6:	102080e7          	jalr	258(ra) # 45d4 <exit>

00000000000004da <forkfork>:
{
     4da:	7179                	addi	sp,sp,-48
     4dc:	f406                	sd	ra,40(sp)
     4de:	f022                	sd	s0,32(sp)
     4e0:	ec26                	sd	s1,24(sp)
     4e2:	1800                	addi	s0,sp,48
     4e4:	84aa                	mv	s1,a0
    int pid = fork();
     4e6:	00004097          	auipc	ra,0x4
     4ea:	0e6080e7          	jalr	230(ra) # 45cc <fork>
    if(pid < 0){
     4ee:	04054163          	bltz	a0,530 <forkfork+0x56>
    if(pid == 0){
     4f2:	cd29                	beqz	a0,54c <forkfork+0x72>
    int pid = fork();
     4f4:	00004097          	auipc	ra,0x4
     4f8:	0d8080e7          	jalr	216(ra) # 45cc <fork>
    if(pid < 0){
     4fc:	02054a63          	bltz	a0,530 <forkfork+0x56>
    if(pid == 0){
     500:	c531                	beqz	a0,54c <forkfork+0x72>
    wait(&xstatus);
     502:	fdc40513          	addi	a0,s0,-36
     506:	00004097          	auipc	ra,0x4
     50a:	0d6080e7          	jalr	214(ra) # 45dc <wait>
    if(xstatus != 0) {
     50e:	fdc42783          	lw	a5,-36(s0)
     512:	ebbd                	bnez	a5,588 <forkfork+0xae>
    wait(&xstatus);
     514:	fdc40513          	addi	a0,s0,-36
     518:	00004097          	auipc	ra,0x4
     51c:	0c4080e7          	jalr	196(ra) # 45dc <wait>
    if(xstatus != 0) {
     520:	fdc42783          	lw	a5,-36(s0)
     524:	e3b5                	bnez	a5,588 <forkfork+0xae>
}
     526:	70a2                	ld	ra,40(sp)
     528:	7402                	ld	s0,32(sp)
     52a:	64e2                	ld	s1,24(sp)
     52c:	6145                	addi	sp,sp,48
     52e:	8082                	ret
      printf("%s: fork failed", s);
     530:	85a6                	mv	a1,s1
     532:	00004517          	auipc	a0,0x4
     536:	7be50513          	addi	a0,a0,1982 # 4cf0 <malloc+0x2f2>
     53a:	00004097          	auipc	ra,0x4
     53e:	408080e7          	jalr	1032(ra) # 4942 <printf>
      exit(1);
     542:	4505                	li	a0,1
     544:	00004097          	auipc	ra,0x4
     548:	090080e7          	jalr	144(ra) # 45d4 <exit>
{
     54c:	0c800493          	li	s1,200
        int pid1 = fork();
     550:	00004097          	auipc	ra,0x4
     554:	07c080e7          	jalr	124(ra) # 45cc <fork>
        if(pid1 < 0){
     558:	00054f63          	bltz	a0,576 <forkfork+0x9c>
        if(pid1 == 0){
     55c:	c115                	beqz	a0,580 <forkfork+0xa6>
        wait(0);
     55e:	4501                	li	a0,0
     560:	00004097          	auipc	ra,0x4
     564:	07c080e7          	jalr	124(ra) # 45dc <wait>
      for(int j = 0; j < 200; j++){
     568:	34fd                	addiw	s1,s1,-1
     56a:	f0fd                	bnez	s1,550 <forkfork+0x76>
      exit(0);
     56c:	4501                	li	a0,0
     56e:	00004097          	auipc	ra,0x4
     572:	066080e7          	jalr	102(ra) # 45d4 <exit>
          exit(1);
     576:	4505                	li	a0,1
     578:	00004097          	auipc	ra,0x4
     57c:	05c080e7          	jalr	92(ra) # 45d4 <exit>
          exit(0);
     580:	00004097          	auipc	ra,0x4
     584:	054080e7          	jalr	84(ra) # 45d4 <exit>
      printf("%s: fork in child failed", s);
     588:	85a6                	mv	a1,s1
     58a:	00004517          	auipc	a0,0x4
     58e:	77650513          	addi	a0,a0,1910 # 4d00 <malloc+0x302>
     592:	00004097          	auipc	ra,0x4
     596:	3b0080e7          	jalr	944(ra) # 4942 <printf>
      exit(1);
     59a:	4505                	li	a0,1
     59c:	00004097          	auipc	ra,0x4
     5a0:	038080e7          	jalr	56(ra) # 45d4 <exit>

00000000000005a4 <reparent2>:
{
     5a4:	1101                	addi	sp,sp,-32
     5a6:	ec06                	sd	ra,24(sp)
     5a8:	e822                	sd	s0,16(sp)
     5aa:	e426                	sd	s1,8(sp)
     5ac:	1000                	addi	s0,sp,32
     5ae:	32000493          	li	s1,800
    int pid1 = fork();
     5b2:	00004097          	auipc	ra,0x4
     5b6:	01a080e7          	jalr	26(ra) # 45cc <fork>
    if(pid1 < 0){
     5ba:	00054f63          	bltz	a0,5d8 <reparent2+0x34>
    if(pid1 == 0){
     5be:	c915                	beqz	a0,5f2 <reparent2+0x4e>
    wait(0);
     5c0:	4501                	li	a0,0
     5c2:	00004097          	auipc	ra,0x4
     5c6:	01a080e7          	jalr	26(ra) # 45dc <wait>
  for(int i = 0; i < 800; i++){
     5ca:	34fd                	addiw	s1,s1,-1
     5cc:	f0fd                	bnez	s1,5b2 <reparent2+0xe>
  exit(0);
     5ce:	4501                	li	a0,0
     5d0:	00004097          	auipc	ra,0x4
     5d4:	004080e7          	jalr	4(ra) # 45d4 <exit>
      printf("fork failed\n");
     5d8:	00005517          	auipc	a0,0x5
     5dc:	fd050513          	addi	a0,a0,-48 # 55a8 <malloc+0xbaa>
     5e0:	00004097          	auipc	ra,0x4
     5e4:	362080e7          	jalr	866(ra) # 4942 <printf>
      exit(1);
     5e8:	4505                	li	a0,1
     5ea:	00004097          	auipc	ra,0x4
     5ee:	fea080e7          	jalr	-22(ra) # 45d4 <exit>
      fork();
     5f2:	00004097          	auipc	ra,0x4
     5f6:	fda080e7          	jalr	-38(ra) # 45cc <fork>
      fork();
     5fa:	00004097          	auipc	ra,0x4
     5fe:	fd2080e7          	jalr	-46(ra) # 45cc <fork>
      exit(0);
     602:	4501                	li	a0,0
     604:	00004097          	auipc	ra,0x4
     608:	fd0080e7          	jalr	-48(ra) # 45d4 <exit>

000000000000060c <forktest>:
{
     60c:	7179                	addi	sp,sp,-48
     60e:	f406                	sd	ra,40(sp)
     610:	f022                	sd	s0,32(sp)
     612:	ec26                	sd	s1,24(sp)
     614:	e84a                	sd	s2,16(sp)
     616:	e44e                	sd	s3,8(sp)
     618:	1800                	addi	s0,sp,48
     61a:	89aa                	mv	s3,a0
  for(n=0; n<N; n++){
     61c:	4481                	li	s1,0
     61e:	3e800913          	li	s2,1000
    pid = fork();
     622:	00004097          	auipc	ra,0x4
     626:	faa080e7          	jalr	-86(ra) # 45cc <fork>
    if(pid < 0)
     62a:	08054263          	bltz	a0,6ae <forktest+0xa2>
    if(pid == 0)
     62e:	c115                	beqz	a0,652 <forktest+0x46>
  for(n=0; n<N; n++){
     630:	2485                	addiw	s1,s1,1
     632:	ff2498e3          	bne	s1,s2,622 <forktest+0x16>
    printf("%s: fork claimed to work 1000 times!\n", s);
     636:	85ce                	mv	a1,s3
     638:	00004517          	auipc	a0,0x4
     63c:	73050513          	addi	a0,a0,1840 # 4d68 <malloc+0x36a>
     640:	00004097          	auipc	ra,0x4
     644:	302080e7          	jalr	770(ra) # 4942 <printf>
    exit(1);
     648:	4505                	li	a0,1
     64a:	00004097          	auipc	ra,0x4
     64e:	f8a080e7          	jalr	-118(ra) # 45d4 <exit>
      exit(0);
     652:	00004097          	auipc	ra,0x4
     656:	f82080e7          	jalr	-126(ra) # 45d4 <exit>
    printf("%s: no fork at all!\n", s);
     65a:	85ce                	mv	a1,s3
     65c:	00004517          	auipc	a0,0x4
     660:	6c450513          	addi	a0,a0,1732 # 4d20 <malloc+0x322>
     664:	00004097          	auipc	ra,0x4
     668:	2de080e7          	jalr	734(ra) # 4942 <printf>
    exit(1);
     66c:	4505                	li	a0,1
     66e:	00004097          	auipc	ra,0x4
     672:	f66080e7          	jalr	-154(ra) # 45d4 <exit>
      printf("%s: wait stopped early\n", s);
     676:	85ce                	mv	a1,s3
     678:	00004517          	auipc	a0,0x4
     67c:	6c050513          	addi	a0,a0,1728 # 4d38 <malloc+0x33a>
     680:	00004097          	auipc	ra,0x4
     684:	2c2080e7          	jalr	706(ra) # 4942 <printf>
      exit(1);
     688:	4505                	li	a0,1
     68a:	00004097          	auipc	ra,0x4
     68e:	f4a080e7          	jalr	-182(ra) # 45d4 <exit>
    printf("%s: wait got too many\n", s);
     692:	85ce                	mv	a1,s3
     694:	00004517          	auipc	a0,0x4
     698:	6bc50513          	addi	a0,a0,1724 # 4d50 <malloc+0x352>
     69c:	00004097          	auipc	ra,0x4
     6a0:	2a6080e7          	jalr	678(ra) # 4942 <printf>
    exit(1);
     6a4:	4505                	li	a0,1
     6a6:	00004097          	auipc	ra,0x4
     6aa:	f2e080e7          	jalr	-210(ra) # 45d4 <exit>
  if (n == 0) {
     6ae:	d4d5                	beqz	s1,65a <forktest+0x4e>
  for(; n > 0; n--){
     6b0:	00905b63          	blez	s1,6c6 <forktest+0xba>
    if(wait(0) < 0){
     6b4:	4501                	li	a0,0
     6b6:	00004097          	auipc	ra,0x4
     6ba:	f26080e7          	jalr	-218(ra) # 45dc <wait>
     6be:	fa054ce3          	bltz	a0,676 <forktest+0x6a>
  for(; n > 0; n--){
     6c2:	34fd                	addiw	s1,s1,-1
     6c4:	f8e5                	bnez	s1,6b4 <forktest+0xa8>
  if(wait(0) != -1){
     6c6:	4501                	li	a0,0
     6c8:	00004097          	auipc	ra,0x4
     6cc:	f14080e7          	jalr	-236(ra) # 45dc <wait>
     6d0:	57fd                	li	a5,-1
     6d2:	fcf510e3          	bne	a0,a5,692 <forktest+0x86>
}
     6d6:	70a2                	ld	ra,40(sp)
     6d8:	7402                	ld	s0,32(sp)
     6da:	64e2                	ld	s1,24(sp)
     6dc:	6942                	ld	s2,16(sp)
     6de:	69a2                	ld	s3,8(sp)
     6e0:	6145                	addi	sp,sp,48
     6e2:	8082                	ret

00000000000006e4 <kernmem>:
{
     6e4:	715d                	addi	sp,sp,-80
     6e6:	e486                	sd	ra,72(sp)
     6e8:	e0a2                	sd	s0,64(sp)
     6ea:	fc26                	sd	s1,56(sp)
     6ec:	f84a                	sd	s2,48(sp)
     6ee:	f44e                	sd	s3,40(sp)
     6f0:	f052                	sd	s4,32(sp)
     6f2:	ec56                	sd	s5,24(sp)
     6f4:	e85a                	sd	s6,16(sp)
     6f6:	0880                	addi	s0,sp,80
     6f8:	8b2a                	mv	s6,a0
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
     6fa:	4485                	li	s1,1
     6fc:	04fe                	slli	s1,s1,0x1f
    wait(&xstatus);
     6fe:	fbc40a93          	addi	s5,s0,-68
    if(xstatus != -1)  // did kernel kill child?
     702:	5a7d                	li	s4,-1
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
     704:	69b1                	lui	s3,0xc
     706:	35098993          	addi	s3,s3,848 # c350 <buf+0x2f20>
     70a:	1003d937          	lui	s2,0x1003d
     70e:	090e                	slli	s2,s2,0x3
     710:	48090913          	addi	s2,s2,1152 # 1003d480 <__BSS_END__+0x10031040>
    pid = fork();
     714:	00004097          	auipc	ra,0x4
     718:	eb8080e7          	jalr	-328(ra) # 45cc <fork>
    if(pid < 0){
     71c:	02054963          	bltz	a0,74e <kernmem+0x6a>
    if(pid == 0){
     720:	c529                	beqz	a0,76a <kernmem+0x86>
    wait(&xstatus);
     722:	8556                	mv	a0,s5
     724:	00004097          	auipc	ra,0x4
     728:	eb8080e7          	jalr	-328(ra) # 45dc <wait>
    if(xstatus != -1)  // did kernel kill child?
     72c:	fbc42783          	lw	a5,-68(s0)
     730:	05479d63          	bne	a5,s4,78a <kernmem+0xa6>
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
     734:	94ce                	add	s1,s1,s3
     736:	fd249fe3          	bne	s1,s2,714 <kernmem+0x30>
}
     73a:	60a6                	ld	ra,72(sp)
     73c:	6406                	ld	s0,64(sp)
     73e:	74e2                	ld	s1,56(sp)
     740:	7942                	ld	s2,48(sp)
     742:	79a2                	ld	s3,40(sp)
     744:	7a02                	ld	s4,32(sp)
     746:	6ae2                	ld	s5,24(sp)
     748:	6b42                	ld	s6,16(sp)
     74a:	6161                	addi	sp,sp,80
     74c:	8082                	ret
      printf("%s: fork failed\n", s);
     74e:	85da                	mv	a1,s6
     750:	00004517          	auipc	a0,0x4
     754:	53850513          	addi	a0,a0,1336 # 4c88 <malloc+0x28a>
     758:	00004097          	auipc	ra,0x4
     75c:	1ea080e7          	jalr	490(ra) # 4942 <printf>
      exit(1);
     760:	4505                	li	a0,1
     762:	00004097          	auipc	ra,0x4
     766:	e72080e7          	jalr	-398(ra) # 45d4 <exit>
      printf("%s: oops could read %x = %x\n", a, *a);
     76a:	0004c603          	lbu	a2,0(s1)
     76e:	85a6                	mv	a1,s1
     770:	00004517          	auipc	a0,0x4
     774:	62050513          	addi	a0,a0,1568 # 4d90 <malloc+0x392>
     778:	00004097          	auipc	ra,0x4
     77c:	1ca080e7          	jalr	458(ra) # 4942 <printf>
      exit(1);
     780:	4505                	li	a0,1
     782:	00004097          	auipc	ra,0x4
     786:	e52080e7          	jalr	-430(ra) # 45d4 <exit>
      exit(1);
     78a:	4505                	li	a0,1
     78c:	00004097          	auipc	ra,0x4
     790:	e48080e7          	jalr	-440(ra) # 45d4 <exit>

0000000000000794 <stacktest>:

// check that there's an invalid page beneath
// the user stack, to catch stack overflow.
void
stacktest(char *s)
{
     794:	7179                	addi	sp,sp,-48
     796:	f406                	sd	ra,40(sp)
     798:	f022                	sd	s0,32(sp)
     79a:	ec26                	sd	s1,24(sp)
     79c:	1800                	addi	s0,sp,48
     79e:	84aa                	mv	s1,a0
  int pid;
  int xstatus;
  
  pid = fork();
     7a0:	00004097          	auipc	ra,0x4
     7a4:	e2c080e7          	jalr	-468(ra) # 45cc <fork>
  if(pid == 0) {
     7a8:	c115                	beqz	a0,7cc <stacktest+0x38>
    char *sp = (char *) r_sp();
    sp -= PGSIZE;
    // the *sp should cause a trap.
    printf("%s: stacktest: read below stack %p\n", *sp);
    exit(1);
  } else if(pid < 0){
     7aa:	04054363          	bltz	a0,7f0 <stacktest+0x5c>
    printf("%s: fork failed\n", s);
    exit(1);
  }
  wait(&xstatus);
     7ae:	fdc40513          	addi	a0,s0,-36
     7b2:	00004097          	auipc	ra,0x4
     7b6:	e2a080e7          	jalr	-470(ra) # 45dc <wait>
  if(xstatus == -1)  // kernel killed child?
     7ba:	fdc42503          	lw	a0,-36(s0)
     7be:	57fd                	li	a5,-1
     7c0:	04f50663          	beq	a0,a5,80c <stacktest+0x78>
    exit(0);
  else
    exit(xstatus);
     7c4:	00004097          	auipc	ra,0x4
     7c8:	e10080e7          	jalr	-496(ra) # 45d4 <exit>

static inline uint64
r_sp()
{
  uint64 x;
  asm volatile("mv %0, sp" : "=r" (x) );
     7cc:	878a                	mv	a5,sp
    printf("%s: stacktest: read below stack %p\n", *sp);
     7ce:	80078793          	addi	a5,a5,-2048
     7d2:	8007c583          	lbu	a1,-2048(a5)
     7d6:	00004517          	auipc	a0,0x4
     7da:	5da50513          	addi	a0,a0,1498 # 4db0 <malloc+0x3b2>
     7de:	00004097          	auipc	ra,0x4
     7e2:	164080e7          	jalr	356(ra) # 4942 <printf>
    exit(1);
     7e6:	4505                	li	a0,1
     7e8:	00004097          	auipc	ra,0x4
     7ec:	dec080e7          	jalr	-532(ra) # 45d4 <exit>
    printf("%s: fork failed\n", s);
     7f0:	85a6                	mv	a1,s1
     7f2:	00004517          	auipc	a0,0x4
     7f6:	49650513          	addi	a0,a0,1174 # 4c88 <malloc+0x28a>
     7fa:	00004097          	auipc	ra,0x4
     7fe:	148080e7          	jalr	328(ra) # 4942 <printf>
    exit(1);
     802:	4505                	li	a0,1
     804:	00004097          	auipc	ra,0x4
     808:	dd0080e7          	jalr	-560(ra) # 45d4 <exit>
    exit(0);
     80c:	4501                	li	a0,0
     80e:	00004097          	auipc	ra,0x4
     812:	dc6080e7          	jalr	-570(ra) # 45d4 <exit>

0000000000000816 <openiputtest>:
{
     816:	7179                	addi	sp,sp,-48
     818:	f406                	sd	ra,40(sp)
     81a:	f022                	sd	s0,32(sp)
     81c:	ec26                	sd	s1,24(sp)
     81e:	1800                	addi	s0,sp,48
     820:	84aa                	mv	s1,a0
  if(mkdir("oidir") < 0){
     822:	00004517          	auipc	a0,0x4
     826:	5b650513          	addi	a0,a0,1462 # 4dd8 <malloc+0x3da>
     82a:	00004097          	auipc	ra,0x4
     82e:	e12080e7          	jalr	-494(ra) # 463c <mkdir>
     832:	04054263          	bltz	a0,876 <openiputtest+0x60>
  pid = fork();
     836:	00004097          	auipc	ra,0x4
     83a:	d96080e7          	jalr	-618(ra) # 45cc <fork>
  if(pid < 0){
     83e:	04054a63          	bltz	a0,892 <openiputtest+0x7c>
  if(pid == 0){
     842:	e93d                	bnez	a0,8b8 <openiputtest+0xa2>
    int fd = open("oidir", O_RDWR);
     844:	4589                	li	a1,2
     846:	00004517          	auipc	a0,0x4
     84a:	59250513          	addi	a0,a0,1426 # 4dd8 <malloc+0x3da>
     84e:	00004097          	auipc	ra,0x4
     852:	dc6080e7          	jalr	-570(ra) # 4614 <open>
    if(fd >= 0){
     856:	04054c63          	bltz	a0,8ae <openiputtest+0x98>
      printf("%s: open directory for write succeeded\n", s);
     85a:	85a6                	mv	a1,s1
     85c:	00004517          	auipc	a0,0x4
     860:	59c50513          	addi	a0,a0,1436 # 4df8 <malloc+0x3fa>
     864:	00004097          	auipc	ra,0x4
     868:	0de080e7          	jalr	222(ra) # 4942 <printf>
      exit(1);
     86c:	4505                	li	a0,1
     86e:	00004097          	auipc	ra,0x4
     872:	d66080e7          	jalr	-666(ra) # 45d4 <exit>
    printf("%s: mkdir oidir failed\n", s);
     876:	85a6                	mv	a1,s1
     878:	00004517          	auipc	a0,0x4
     87c:	56850513          	addi	a0,a0,1384 # 4de0 <malloc+0x3e2>
     880:	00004097          	auipc	ra,0x4
     884:	0c2080e7          	jalr	194(ra) # 4942 <printf>
    exit(1);
     888:	4505                	li	a0,1
     88a:	00004097          	auipc	ra,0x4
     88e:	d4a080e7          	jalr	-694(ra) # 45d4 <exit>
    printf("%s: fork failed\n", s);
     892:	85a6                	mv	a1,s1
     894:	00004517          	auipc	a0,0x4
     898:	3f450513          	addi	a0,a0,1012 # 4c88 <malloc+0x28a>
     89c:	00004097          	auipc	ra,0x4
     8a0:	0a6080e7          	jalr	166(ra) # 4942 <printf>
    exit(1);
     8a4:	4505                	li	a0,1
     8a6:	00004097          	auipc	ra,0x4
     8aa:	d2e080e7          	jalr	-722(ra) # 45d4 <exit>
    exit(0);
     8ae:	4501                	li	a0,0
     8b0:	00004097          	auipc	ra,0x4
     8b4:	d24080e7          	jalr	-732(ra) # 45d4 <exit>
  sleep(1);
     8b8:	4505                	li	a0,1
     8ba:	00004097          	auipc	ra,0x4
     8be:	daa080e7          	jalr	-598(ra) # 4664 <sleep>
  if(unlink("oidir") != 0){
     8c2:	00004517          	auipc	a0,0x4
     8c6:	51650513          	addi	a0,a0,1302 # 4dd8 <malloc+0x3da>
     8ca:	00004097          	auipc	ra,0x4
     8ce:	d5a080e7          	jalr	-678(ra) # 4624 <unlink>
     8d2:	cd19                	beqz	a0,8f0 <openiputtest+0xda>
    printf("%s: unlink failed\n", s);
     8d4:	85a6                	mv	a1,s1
     8d6:	00004517          	auipc	a0,0x4
     8da:	54a50513          	addi	a0,a0,1354 # 4e20 <malloc+0x422>
     8de:	00004097          	auipc	ra,0x4
     8e2:	064080e7          	jalr	100(ra) # 4942 <printf>
    exit(1);
     8e6:	4505                	li	a0,1
     8e8:	00004097          	auipc	ra,0x4
     8ec:	cec080e7          	jalr	-788(ra) # 45d4 <exit>
  wait(&xstatus);
     8f0:	fdc40513          	addi	a0,s0,-36
     8f4:	00004097          	auipc	ra,0x4
     8f8:	ce8080e7          	jalr	-792(ra) # 45dc <wait>
  exit(xstatus);
     8fc:	fdc42503          	lw	a0,-36(s0)
     900:	00004097          	auipc	ra,0x4
     904:	cd4080e7          	jalr	-812(ra) # 45d4 <exit>

0000000000000908 <opentest>:
{
     908:	1101                	addi	sp,sp,-32
     90a:	ec06                	sd	ra,24(sp)
     90c:	e822                	sd	s0,16(sp)
     90e:	e426                	sd	s1,8(sp)
     910:	1000                	addi	s0,sp,32
     912:	84aa                	mv	s1,a0
  fd = open("echo", 0);
     914:	4581                	li	a1,0
     916:	00004517          	auipc	a0,0x4
     91a:	52250513          	addi	a0,a0,1314 # 4e38 <malloc+0x43a>
     91e:	00004097          	auipc	ra,0x4
     922:	cf6080e7          	jalr	-778(ra) # 4614 <open>
  if(fd < 0){
     926:	02054663          	bltz	a0,952 <opentest+0x4a>
  close(fd);
     92a:	00004097          	auipc	ra,0x4
     92e:	cd2080e7          	jalr	-814(ra) # 45fc <close>
  fd = open("doesnotexist", 0);
     932:	4581                	li	a1,0
     934:	00004517          	auipc	a0,0x4
     938:	52450513          	addi	a0,a0,1316 # 4e58 <malloc+0x45a>
     93c:	00004097          	auipc	ra,0x4
     940:	cd8080e7          	jalr	-808(ra) # 4614 <open>
  if(fd >= 0){
     944:	02055563          	bgez	a0,96e <opentest+0x66>
}
     948:	60e2                	ld	ra,24(sp)
     94a:	6442                	ld	s0,16(sp)
     94c:	64a2                	ld	s1,8(sp)
     94e:	6105                	addi	sp,sp,32
     950:	8082                	ret
    printf("%s: open echo failed!\n", s);
     952:	85a6                	mv	a1,s1
     954:	00004517          	auipc	a0,0x4
     958:	4ec50513          	addi	a0,a0,1260 # 4e40 <malloc+0x442>
     95c:	00004097          	auipc	ra,0x4
     960:	fe6080e7          	jalr	-26(ra) # 4942 <printf>
    exit(1);
     964:	4505                	li	a0,1
     966:	00004097          	auipc	ra,0x4
     96a:	c6e080e7          	jalr	-914(ra) # 45d4 <exit>
    printf("%s: open doesnotexist succeeded!\n", s);
     96e:	85a6                	mv	a1,s1
     970:	00004517          	auipc	a0,0x4
     974:	4f850513          	addi	a0,a0,1272 # 4e68 <malloc+0x46a>
     978:	00004097          	auipc	ra,0x4
     97c:	fca080e7          	jalr	-54(ra) # 4942 <printf>
    exit(1);
     980:	4505                	li	a0,1
     982:	00004097          	auipc	ra,0x4
     986:	c52080e7          	jalr	-942(ra) # 45d4 <exit>

000000000000098a <createtest>:
{
     98a:	7179                	addi	sp,sp,-48
     98c:	f406                	sd	ra,40(sp)
     98e:	f022                	sd	s0,32(sp)
     990:	ec26                	sd	s1,24(sp)
     992:	e84a                	sd	s2,16(sp)
     994:	e44e                	sd	s3,8(sp)
     996:	e052                	sd	s4,0(sp)
     998:	1800                	addi	s0,sp,48
  name[0] = 'a';
     99a:	00006797          	auipc	a5,0x6
     99e:	27678793          	addi	a5,a5,630 # 6c10 <name>
     9a2:	06100713          	li	a4,97
     9a6:	00e78023          	sb	a4,0(a5)
  name[2] = '\0';
     9aa:	00078123          	sb	zero,2(a5)
     9ae:	03000493          	li	s1,48
    name[1] = '0' + i;
     9b2:	893e                	mv	s2,a5
    fd = open(name, O_CREATE|O_RDWR);
     9b4:	20200a13          	li	s4,514
  for(i = 0; i < N; i++){
     9b8:	06400993          	li	s3,100
    name[1] = '0' + i;
     9bc:	009900a3          	sb	s1,1(s2)
    fd = open(name, O_CREATE|O_RDWR);
     9c0:	85d2                	mv	a1,s4
     9c2:	854a                	mv	a0,s2
     9c4:	00004097          	auipc	ra,0x4
     9c8:	c50080e7          	jalr	-944(ra) # 4614 <open>
    close(fd);
     9cc:	00004097          	auipc	ra,0x4
     9d0:	c30080e7          	jalr	-976(ra) # 45fc <close>
  for(i = 0; i < N; i++){
     9d4:	2485                	addiw	s1,s1,1
     9d6:	0ff4f493          	zext.b	s1,s1
     9da:	ff3491e3          	bne	s1,s3,9bc <createtest+0x32>
  name[0] = 'a';
     9de:	00006797          	auipc	a5,0x6
     9e2:	23278793          	addi	a5,a5,562 # 6c10 <name>
     9e6:	06100713          	li	a4,97
     9ea:	00e78023          	sb	a4,0(a5)
  name[2] = '\0';
     9ee:	00078123          	sb	zero,2(a5)
     9f2:	03000493          	li	s1,48
    name[1] = '0' + i;
     9f6:	893e                	mv	s2,a5
  for(i = 0; i < N; i++){
     9f8:	06400993          	li	s3,100
    name[1] = '0' + i;
     9fc:	009900a3          	sb	s1,1(s2)
    unlink(name);
     a00:	854a                	mv	a0,s2
     a02:	00004097          	auipc	ra,0x4
     a06:	c22080e7          	jalr	-990(ra) # 4624 <unlink>
  for(i = 0; i < N; i++){
     a0a:	2485                	addiw	s1,s1,1
     a0c:	0ff4f493          	zext.b	s1,s1
     a10:	ff3496e3          	bne	s1,s3,9fc <createtest+0x72>
}
     a14:	70a2                	ld	ra,40(sp)
     a16:	7402                	ld	s0,32(sp)
     a18:	64e2                	ld	s1,24(sp)
     a1a:	6942                	ld	s2,16(sp)
     a1c:	69a2                	ld	s3,8(sp)
     a1e:	6a02                	ld	s4,0(sp)
     a20:	6145                	addi	sp,sp,48
     a22:	8082                	ret

0000000000000a24 <forkforkfork>:
{
     a24:	1101                	addi	sp,sp,-32
     a26:	ec06                	sd	ra,24(sp)
     a28:	e822                	sd	s0,16(sp)
     a2a:	e426                	sd	s1,8(sp)
     a2c:	1000                	addi	s0,sp,32
     a2e:	84aa                	mv	s1,a0
  unlink("stopforking");
     a30:	00004517          	auipc	a0,0x4
     a34:	46050513          	addi	a0,a0,1120 # 4e90 <malloc+0x492>
     a38:	00004097          	auipc	ra,0x4
     a3c:	bec080e7          	jalr	-1044(ra) # 4624 <unlink>
  int pid = fork();
     a40:	00004097          	auipc	ra,0x4
     a44:	b8c080e7          	jalr	-1140(ra) # 45cc <fork>
  if(pid < 0){
     a48:	04054563          	bltz	a0,a92 <forkforkfork+0x6e>
  if(pid == 0){
     a4c:	c12d                	beqz	a0,aae <forkforkfork+0x8a>
  sleep(20); // two seconds
     a4e:	4551                	li	a0,20
     a50:	00004097          	auipc	ra,0x4
     a54:	c14080e7          	jalr	-1004(ra) # 4664 <sleep>
  close(open("stopforking", O_CREATE|O_RDWR));
     a58:	20200593          	li	a1,514
     a5c:	00004517          	auipc	a0,0x4
     a60:	43450513          	addi	a0,a0,1076 # 4e90 <malloc+0x492>
     a64:	00004097          	auipc	ra,0x4
     a68:	bb0080e7          	jalr	-1104(ra) # 4614 <open>
     a6c:	00004097          	auipc	ra,0x4
     a70:	b90080e7          	jalr	-1136(ra) # 45fc <close>
  wait(0);
     a74:	4501                	li	a0,0
     a76:	00004097          	auipc	ra,0x4
     a7a:	b66080e7          	jalr	-1178(ra) # 45dc <wait>
  sleep(10); // one second
     a7e:	4529                	li	a0,10
     a80:	00004097          	auipc	ra,0x4
     a84:	be4080e7          	jalr	-1052(ra) # 4664 <sleep>
}
     a88:	60e2                	ld	ra,24(sp)
     a8a:	6442                	ld	s0,16(sp)
     a8c:	64a2                	ld	s1,8(sp)
     a8e:	6105                	addi	sp,sp,32
     a90:	8082                	ret
    printf("%s: fork failed", s);
     a92:	85a6                	mv	a1,s1
     a94:	00004517          	auipc	a0,0x4
     a98:	25c50513          	addi	a0,a0,604 # 4cf0 <malloc+0x2f2>
     a9c:	00004097          	auipc	ra,0x4
     aa0:	ea6080e7          	jalr	-346(ra) # 4942 <printf>
    exit(1);
     aa4:	4505                	li	a0,1
     aa6:	00004097          	auipc	ra,0x4
     aaa:	b2e080e7          	jalr	-1234(ra) # 45d4 <exit>
      int fd = open("stopforking", 0);
     aae:	4581                	li	a1,0
     ab0:	00004517          	auipc	a0,0x4
     ab4:	3e050513          	addi	a0,a0,992 # 4e90 <malloc+0x492>
     ab8:	00004097          	auipc	ra,0x4
     abc:	b5c080e7          	jalr	-1188(ra) # 4614 <open>
      if(fd >= 0){
     ac0:	02055763          	bgez	a0,aee <forkforkfork+0xca>
      if(fork() < 0){
     ac4:	00004097          	auipc	ra,0x4
     ac8:	b08080e7          	jalr	-1272(ra) # 45cc <fork>
     acc:	fe0551e3          	bgez	a0,aae <forkforkfork+0x8a>
        close(open("stopforking", O_CREATE|O_RDWR));
     ad0:	20200593          	li	a1,514
     ad4:	00004517          	auipc	a0,0x4
     ad8:	3bc50513          	addi	a0,a0,956 # 4e90 <malloc+0x492>
     adc:	00004097          	auipc	ra,0x4
     ae0:	b38080e7          	jalr	-1224(ra) # 4614 <open>
     ae4:	00004097          	auipc	ra,0x4
     ae8:	b18080e7          	jalr	-1256(ra) # 45fc <close>
     aec:	b7c9                	j	aae <forkforkfork+0x8a>
        exit(0);
     aee:	4501                	li	a0,0
     af0:	00004097          	auipc	ra,0x4
     af4:	ae4080e7          	jalr	-1308(ra) # 45d4 <exit>

0000000000000af8 <createdelete>:
{
     af8:	7135                	addi	sp,sp,-160
     afa:	ed06                	sd	ra,152(sp)
     afc:	e922                	sd	s0,144(sp)
     afe:	e526                	sd	s1,136(sp)
     b00:	e14a                	sd	s2,128(sp)
     b02:	fcce                	sd	s3,120(sp)
     b04:	f8d2                	sd	s4,112(sp)
     b06:	f4d6                	sd	s5,104(sp)
     b08:	f0da                	sd	s6,96(sp)
     b0a:	ecde                	sd	s7,88(sp)
     b0c:	e8e2                	sd	s8,80(sp)
     b0e:	e4e6                	sd	s9,72(sp)
     b10:	e0ea                	sd	s10,64(sp)
     b12:	fc6e                	sd	s11,56(sp)
     b14:	1100                	addi	s0,sp,160
     b16:	8daa                	mv	s11,a0
  for(pi = 0; pi < NCHILD; pi++){
     b18:	4901                	li	s2,0
     b1a:	4991                	li	s3,4
    pid = fork();
     b1c:	00004097          	auipc	ra,0x4
     b20:	ab0080e7          	jalr	-1360(ra) # 45cc <fork>
     b24:	84aa                	mv	s1,a0
    if(pid < 0){
     b26:	04054263          	bltz	a0,b6a <createdelete+0x72>
    if(pid == 0){
     b2a:	cd31                	beqz	a0,b86 <createdelete+0x8e>
  for(pi = 0; pi < NCHILD; pi++){
     b2c:	2905                	addiw	s2,s2,1
     b2e:	ff3917e3          	bne	s2,s3,b1c <createdelete+0x24>
     b32:	4491                	li	s1,4
    wait(&xstatus);
     b34:	f6c40913          	addi	s2,s0,-148
     b38:	854a                	mv	a0,s2
     b3a:	00004097          	auipc	ra,0x4
     b3e:	aa2080e7          	jalr	-1374(ra) # 45dc <wait>
    if(xstatus != 0)
     b42:	f6c42a83          	lw	s5,-148(s0)
     b46:	0e0a9663          	bnez	s5,c32 <createdelete+0x13a>
  for(pi = 0; pi < NCHILD; pi++){
     b4a:	34fd                	addiw	s1,s1,-1
     b4c:	f4f5                	bnez	s1,b38 <createdelete+0x40>
  name[0] = name[1] = name[2] = 0;
     b4e:	f6040923          	sb	zero,-142(s0)
     b52:	03000913          	li	s2,48
     b56:	5a7d                	li	s4,-1
      if((i == 0 || i >= N/2) && fd < 0){
     b58:	4d25                	li	s10,9
     b5a:	07000c93          	li	s9,112
      fd = open(name, 0);
     b5e:	f7040c13          	addi	s8,s0,-144
      } else if((i >= 1 && i < N/2) && fd >= 0){
     b62:	4ba1                	li	s7,8
    for(pi = 0; pi < NCHILD; pi++){
     b64:	07400b13          	li	s6,116
     b68:	a28d                	j	cca <createdelete+0x1d2>
      printf("fork failed\n", s);
     b6a:	85ee                	mv	a1,s11
     b6c:	00005517          	auipc	a0,0x5
     b70:	a3c50513          	addi	a0,a0,-1476 # 55a8 <malloc+0xbaa>
     b74:	00004097          	auipc	ra,0x4
     b78:	dce080e7          	jalr	-562(ra) # 4942 <printf>
      exit(1);
     b7c:	4505                	li	a0,1
     b7e:	00004097          	auipc	ra,0x4
     b82:	a56080e7          	jalr	-1450(ra) # 45d4 <exit>
      name[0] = 'p' + pi;
     b86:	0709091b          	addiw	s2,s2,112
     b8a:	f7240823          	sb	s2,-144(s0)
      name[2] = '\0';
     b8e:	f6040923          	sb	zero,-142(s0)
        fd = open(name, O_CREATE | O_RDWR);
     b92:	f7040913          	addi	s2,s0,-144
     b96:	20200993          	li	s3,514
      for(i = 0; i < N; i++){
     b9a:	4a51                	li	s4,20
     b9c:	a081                	j	bdc <createdelete+0xe4>
          printf("%s: create failed\n", s);
     b9e:	85ee                	mv	a1,s11
     ba0:	00004517          	auipc	a0,0x4
     ba4:	30050513          	addi	a0,a0,768 # 4ea0 <malloc+0x4a2>
     ba8:	00004097          	auipc	ra,0x4
     bac:	d9a080e7          	jalr	-614(ra) # 4942 <printf>
          exit(1);
     bb0:	4505                	li	a0,1
     bb2:	00004097          	auipc	ra,0x4
     bb6:	a22080e7          	jalr	-1502(ra) # 45d4 <exit>
          name[1] = '0' + (i / 2);
     bba:	01f4d79b          	srliw	a5,s1,0x1f
     bbe:	9fa5                	addw	a5,a5,s1
     bc0:	4017d79b          	sraiw	a5,a5,0x1
     bc4:	0307879b          	addiw	a5,a5,48
     bc8:	f6f408a3          	sb	a5,-143(s0)
          if(unlink(name) < 0){
     bcc:	854a                	mv	a0,s2
     bce:	00004097          	auipc	ra,0x4
     bd2:	a56080e7          	jalr	-1450(ra) # 4624 <unlink>
     bd6:	04054063          	bltz	a0,c16 <createdelete+0x11e>
      for(i = 0; i < N; i++){
     bda:	2485                	addiw	s1,s1,1
        name[1] = '0' + i;
     bdc:	0304879b          	addiw	a5,s1,48
     be0:	f6f408a3          	sb	a5,-143(s0)
        fd = open(name, O_CREATE | O_RDWR);
     be4:	85ce                	mv	a1,s3
     be6:	854a                	mv	a0,s2
     be8:	00004097          	auipc	ra,0x4
     bec:	a2c080e7          	jalr	-1492(ra) # 4614 <open>
        if(fd < 0){
     bf0:	fa0547e3          	bltz	a0,b9e <createdelete+0xa6>
        close(fd);
     bf4:	00004097          	auipc	ra,0x4
     bf8:	a08080e7          	jalr	-1528(ra) # 45fc <close>
        if(i > 0 && (i % 2 ) == 0){
     bfc:	fc905fe3          	blez	s1,bda <createdelete+0xe2>
     c00:	0014f793          	andi	a5,s1,1
     c04:	dbdd                	beqz	a5,bba <createdelete+0xc2>
      for(i = 0; i < N; i++){
     c06:	2485                	addiw	s1,s1,1
     c08:	fd449ae3          	bne	s1,s4,bdc <createdelete+0xe4>
      exit(0);
     c0c:	4501                	li	a0,0
     c0e:	00004097          	auipc	ra,0x4
     c12:	9c6080e7          	jalr	-1594(ra) # 45d4 <exit>
            printf("%s: unlink failed\n", s);
     c16:	85ee                	mv	a1,s11
     c18:	00004517          	auipc	a0,0x4
     c1c:	20850513          	addi	a0,a0,520 # 4e20 <malloc+0x422>
     c20:	00004097          	auipc	ra,0x4
     c24:	d22080e7          	jalr	-734(ra) # 4942 <printf>
            exit(1);
     c28:	4505                	li	a0,1
     c2a:	00004097          	auipc	ra,0x4
     c2e:	9aa080e7          	jalr	-1622(ra) # 45d4 <exit>
      exit(1);
     c32:	4505                	li	a0,1
     c34:	00004097          	auipc	ra,0x4
     c38:	9a0080e7          	jalr	-1632(ra) # 45d4 <exit>
      } else if((i >= 1 && i < N/2) && fd >= 0){
     c3c:	054bf863          	bgeu	s7,s4,c8c <createdelete+0x194>
      if(fd >= 0)
     c40:	06055863          	bgez	a0,cb0 <createdelete+0x1b8>
    for(pi = 0; pi < NCHILD; pi++){
     c44:	2485                	addiw	s1,s1,1
     c46:	0ff4f493          	zext.b	s1,s1
     c4a:	07648863          	beq	s1,s6,cba <createdelete+0x1c2>
      name[0] = 'p' + pi;
     c4e:	f6940823          	sb	s1,-144(s0)
      name[1] = '0' + i;
     c52:	f72408a3          	sb	s2,-143(s0)
      fd = open(name, 0);
     c56:	4581                	li	a1,0
     c58:	8562                	mv	a0,s8
     c5a:	00004097          	auipc	ra,0x4
     c5e:	9ba080e7          	jalr	-1606(ra) # 4614 <open>
      if((i == 0 || i >= N/2) && fd < 0){
     c62:	01f5579b          	srliw	a5,a0,0x1f
     c66:	dbf9                	beqz	a5,c3c <createdelete+0x144>
     c68:	fc098ae3          	beqz	s3,c3c <createdelete+0x144>
        printf("%s: oops createdelete %s didn't exist\n", s, name);
     c6c:	f7040613          	addi	a2,s0,-144
     c70:	85ee                	mv	a1,s11
     c72:	00004517          	auipc	a0,0x4
     c76:	24650513          	addi	a0,a0,582 # 4eb8 <malloc+0x4ba>
     c7a:	00004097          	auipc	ra,0x4
     c7e:	cc8080e7          	jalr	-824(ra) # 4942 <printf>
        exit(1);
     c82:	4505                	li	a0,1
     c84:	00004097          	auipc	ra,0x4
     c88:	950080e7          	jalr	-1712(ra) # 45d4 <exit>
      } else if((i >= 1 && i < N/2) && fd >= 0){
     c8c:	fa054ce3          	bltz	a0,c44 <createdelete+0x14c>
        printf("%s: oops createdelete %s did exist\n", s, name);
     c90:	f7040613          	addi	a2,s0,-144
     c94:	85ee                	mv	a1,s11
     c96:	00004517          	auipc	a0,0x4
     c9a:	24a50513          	addi	a0,a0,586 # 4ee0 <malloc+0x4e2>
     c9e:	00004097          	auipc	ra,0x4
     ca2:	ca4080e7          	jalr	-860(ra) # 4942 <printf>
        exit(1);
     ca6:	4505                	li	a0,1
     ca8:	00004097          	auipc	ra,0x4
     cac:	92c080e7          	jalr	-1748(ra) # 45d4 <exit>
        close(fd);
     cb0:	00004097          	auipc	ra,0x4
     cb4:	94c080e7          	jalr	-1716(ra) # 45fc <close>
     cb8:	b771                	j	c44 <createdelete+0x14c>
  for(i = 0; i < N; i++){
     cba:	2a85                	addiw	s5,s5,1
     cbc:	2a05                	addiw	s4,s4,1
     cbe:	2905                	addiw	s2,s2,1
     cc0:	0ff97913          	zext.b	s2,s2
     cc4:	47d1                	li	a5,20
     cc6:	00fa8a63          	beq	s5,a5,cda <createdelete+0x1e2>
      if((i == 0 || i >= N/2) && fd < 0){
     cca:	001ab993          	seqz	s3,s5
     cce:	015d27b3          	slt	a5,s10,s5
     cd2:	00f9e9b3          	or	s3,s3,a5
     cd6:	84e6                	mv	s1,s9
     cd8:	bf9d                	j	c4e <createdelete+0x156>
     cda:	03000993          	li	s3,48
     cde:	07000913          	li	s2,112
  name[0] = name[1] = name[2] = 0;
     ce2:	4b11                	li	s6,4
      unlink(name);
     ce4:	f7040a13          	addi	s4,s0,-144
  for(i = 0; i < N; i++){
     ce8:	08400a93          	li	s5,132
  name[0] = name[1] = name[2] = 0;
     cec:	84da                	mv	s1,s6
      name[0] = 'p' + i;
     cee:	f7240823          	sb	s2,-144(s0)
      name[1] = '0' + i;
     cf2:	f73408a3          	sb	s3,-143(s0)
      unlink(name);
     cf6:	8552                	mv	a0,s4
     cf8:	00004097          	auipc	ra,0x4
     cfc:	92c080e7          	jalr	-1748(ra) # 4624 <unlink>
    for(pi = 0; pi < NCHILD; pi++){
     d00:	34fd                	addiw	s1,s1,-1
     d02:	f4f5                	bnez	s1,cee <createdelete+0x1f6>
  for(i = 0; i < N; i++){
     d04:	2905                	addiw	s2,s2,1
     d06:	0ff97913          	zext.b	s2,s2
     d0a:	2985                	addiw	s3,s3,1
     d0c:	0ff9f993          	zext.b	s3,s3
     d10:	fd591ee3          	bne	s2,s5,cec <createdelete+0x1f4>
}
     d14:	60ea                	ld	ra,152(sp)
     d16:	644a                	ld	s0,144(sp)
     d18:	64aa                	ld	s1,136(sp)
     d1a:	690a                	ld	s2,128(sp)
     d1c:	79e6                	ld	s3,120(sp)
     d1e:	7a46                	ld	s4,112(sp)
     d20:	7aa6                	ld	s5,104(sp)
     d22:	7b06                	ld	s6,96(sp)
     d24:	6be6                	ld	s7,88(sp)
     d26:	6c46                	ld	s8,80(sp)
     d28:	6ca6                	ld	s9,72(sp)
     d2a:	6d06                	ld	s10,64(sp)
     d2c:	7de2                	ld	s11,56(sp)
     d2e:	610d                	addi	sp,sp,160
     d30:	8082                	ret

0000000000000d32 <fourteen>:
{
     d32:	1101                	addi	sp,sp,-32
     d34:	ec06                	sd	ra,24(sp)
     d36:	e822                	sd	s0,16(sp)
     d38:	e426                	sd	s1,8(sp)
     d3a:	1000                	addi	s0,sp,32
     d3c:	84aa                	mv	s1,a0
  if(mkdir("12345678901234") != 0){
     d3e:	00004517          	auipc	a0,0x4
     d42:	39a50513          	addi	a0,a0,922 # 50d8 <malloc+0x6da>
     d46:	00004097          	auipc	ra,0x4
     d4a:	8f6080e7          	jalr	-1802(ra) # 463c <mkdir>
     d4e:	e141                	bnez	a0,dce <fourteen+0x9c>
  if(mkdir("12345678901234/123456789012345") != 0){
     d50:	00004517          	auipc	a0,0x4
     d54:	1e050513          	addi	a0,a0,480 # 4f30 <malloc+0x532>
     d58:	00004097          	auipc	ra,0x4
     d5c:	8e4080e7          	jalr	-1820(ra) # 463c <mkdir>
     d60:	e549                	bnez	a0,dea <fourteen+0xb8>
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
     d62:	20000593          	li	a1,512
     d66:	00004517          	auipc	a0,0x4
     d6a:	22250513          	addi	a0,a0,546 # 4f88 <malloc+0x58a>
     d6e:	00004097          	auipc	ra,0x4
     d72:	8a6080e7          	jalr	-1882(ra) # 4614 <open>
  if(fd < 0){
     d76:	08054863          	bltz	a0,e06 <fourteen+0xd4>
  close(fd);
     d7a:	00004097          	auipc	ra,0x4
     d7e:	882080e7          	jalr	-1918(ra) # 45fc <close>
  fd = open("12345678901234/12345678901234/12345678901234", 0);
     d82:	4581                	li	a1,0
     d84:	00004517          	auipc	a0,0x4
     d88:	27c50513          	addi	a0,a0,636 # 5000 <malloc+0x602>
     d8c:	00004097          	auipc	ra,0x4
     d90:	888080e7          	jalr	-1912(ra) # 4614 <open>
  if(fd < 0){
     d94:	08054763          	bltz	a0,e22 <fourteen+0xf0>
  close(fd);
     d98:	00004097          	auipc	ra,0x4
     d9c:	864080e7          	jalr	-1948(ra) # 45fc <close>
  if(mkdir("12345678901234/12345678901234") == 0){
     da0:	00004517          	auipc	a0,0x4
     da4:	2d050513          	addi	a0,a0,720 # 5070 <malloc+0x672>
     da8:	00004097          	auipc	ra,0x4
     dac:	894080e7          	jalr	-1900(ra) # 463c <mkdir>
     db0:	c559                	beqz	a0,e3e <fourteen+0x10c>
  if(mkdir("123456789012345/12345678901234") == 0){
     db2:	00004517          	auipc	a0,0x4
     db6:	31650513          	addi	a0,a0,790 # 50c8 <malloc+0x6ca>
     dba:	00004097          	auipc	ra,0x4
     dbe:	882080e7          	jalr	-1918(ra) # 463c <mkdir>
     dc2:	cd41                	beqz	a0,e5a <fourteen+0x128>
}
     dc4:	60e2                	ld	ra,24(sp)
     dc6:	6442                	ld	s0,16(sp)
     dc8:	64a2                	ld	s1,8(sp)
     dca:	6105                	addi	sp,sp,32
     dcc:	8082                	ret
    printf("%s: mkdir 12345678901234 failed\n", s);
     dce:	85a6                	mv	a1,s1
     dd0:	00004517          	auipc	a0,0x4
     dd4:	13850513          	addi	a0,a0,312 # 4f08 <malloc+0x50a>
     dd8:	00004097          	auipc	ra,0x4
     ddc:	b6a080e7          	jalr	-1174(ra) # 4942 <printf>
    exit(1);
     de0:	4505                	li	a0,1
     de2:	00003097          	auipc	ra,0x3
     de6:	7f2080e7          	jalr	2034(ra) # 45d4 <exit>
    printf("%s: mkdir 12345678901234/123456789012345 failed\n", s);
     dea:	85a6                	mv	a1,s1
     dec:	00004517          	auipc	a0,0x4
     df0:	16450513          	addi	a0,a0,356 # 4f50 <malloc+0x552>
     df4:	00004097          	auipc	ra,0x4
     df8:	b4e080e7          	jalr	-1202(ra) # 4942 <printf>
    exit(1);
     dfc:	4505                	li	a0,1
     dfe:	00003097          	auipc	ra,0x3
     e02:	7d6080e7          	jalr	2006(ra) # 45d4 <exit>
    printf("%s: create 123456789012345/123456789012345/123456789012345 failed\n", s);
     e06:	85a6                	mv	a1,s1
     e08:	00004517          	auipc	a0,0x4
     e0c:	1b050513          	addi	a0,a0,432 # 4fb8 <malloc+0x5ba>
     e10:	00004097          	auipc	ra,0x4
     e14:	b32080e7          	jalr	-1230(ra) # 4942 <printf>
    exit(1);
     e18:	4505                	li	a0,1
     e1a:	00003097          	auipc	ra,0x3
     e1e:	7ba080e7          	jalr	1978(ra) # 45d4 <exit>
    printf("%s: open 12345678901234/12345678901234/12345678901234 failed\n", s);
     e22:	85a6                	mv	a1,s1
     e24:	00004517          	auipc	a0,0x4
     e28:	20c50513          	addi	a0,a0,524 # 5030 <malloc+0x632>
     e2c:	00004097          	auipc	ra,0x4
     e30:	b16080e7          	jalr	-1258(ra) # 4942 <printf>
    exit(1);
     e34:	4505                	li	a0,1
     e36:	00003097          	auipc	ra,0x3
     e3a:	79e080e7          	jalr	1950(ra) # 45d4 <exit>
    printf("%s: mkdir 12345678901234/12345678901234 succeeded!\n", s);
     e3e:	85a6                	mv	a1,s1
     e40:	00004517          	auipc	a0,0x4
     e44:	25050513          	addi	a0,a0,592 # 5090 <malloc+0x692>
     e48:	00004097          	auipc	ra,0x4
     e4c:	afa080e7          	jalr	-1286(ra) # 4942 <printf>
    exit(1);
     e50:	4505                	li	a0,1
     e52:	00003097          	auipc	ra,0x3
     e56:	782080e7          	jalr	1922(ra) # 45d4 <exit>
    printf("%s: mkdir 12345678901234/123456789012345 succeeded!\n", s);
     e5a:	85a6                	mv	a1,s1
     e5c:	00004517          	auipc	a0,0x4
     e60:	28c50513          	addi	a0,a0,652 # 50e8 <malloc+0x6ea>
     e64:	00004097          	auipc	ra,0x4
     e68:	ade080e7          	jalr	-1314(ra) # 4942 <printf>
    exit(1);
     e6c:	4505                	li	a0,1
     e6e:	00003097          	auipc	ra,0x3
     e72:	766080e7          	jalr	1894(ra) # 45d4 <exit>

0000000000000e76 <bigwrite>:
{
     e76:	711d                	addi	sp,sp,-96
     e78:	ec86                	sd	ra,88(sp)
     e7a:	e8a2                	sd	s0,80(sp)
     e7c:	e4a6                	sd	s1,72(sp)
     e7e:	e0ca                	sd	s2,64(sp)
     e80:	fc4e                	sd	s3,56(sp)
     e82:	f852                	sd	s4,48(sp)
     e84:	f456                	sd	s5,40(sp)
     e86:	f05a                	sd	s6,32(sp)
     e88:	ec5e                	sd	s7,24(sp)
     e8a:	e862                	sd	s8,16(sp)
     e8c:	e466                	sd	s9,8(sp)
     e8e:	1080                	addi	s0,sp,96
     e90:	8caa                	mv	s9,a0
  unlink("bigwrite");
     e92:	00004517          	auipc	a0,0x4
     e96:	28e50513          	addi	a0,a0,654 # 5120 <malloc+0x722>
     e9a:	00003097          	auipc	ra,0x3
     e9e:	78a080e7          	jalr	1930(ra) # 4624 <unlink>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     ea2:	1f300493          	li	s1,499
    fd = open("bigwrite", O_CREATE | O_RDWR);
     ea6:	20200b93          	li	s7,514
     eaa:	00004a17          	auipc	s4,0x4
     eae:	276a0a13          	addi	s4,s4,630 # 5120 <malloc+0x722>
     eb2:	4b09                	li	s6,2
      int cc = write(fd, buf, sz);
     eb4:	00008997          	auipc	s3,0x8
     eb8:	57c98993          	addi	s3,s3,1404 # 9430 <buf>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     ebc:	6a8d                	lui	s5,0x3
     ebe:	1c9a8a93          	addi	s5,s5,457 # 31c9 <subdir+0x739>
    fd = open("bigwrite", O_CREATE | O_RDWR);
     ec2:	85de                	mv	a1,s7
     ec4:	8552                	mv	a0,s4
     ec6:	00003097          	auipc	ra,0x3
     eca:	74e080e7          	jalr	1870(ra) # 4614 <open>
     ece:	892a                	mv	s2,a0
    if(fd < 0){
     ed0:	04054a63          	bltz	a0,f24 <bigwrite+0xae>
     ed4:	8c5a                	mv	s8,s6
      int cc = write(fd, buf, sz);
     ed6:	8626                	mv	a2,s1
     ed8:	85ce                	mv	a1,s3
     eda:	854a                	mv	a0,s2
     edc:	00003097          	auipc	ra,0x3
     ee0:	718080e7          	jalr	1816(ra) # 45f4 <write>
      if(cc != sz){
     ee4:	04951e63          	bne	a0,s1,f40 <bigwrite+0xca>
    for(i = 0; i < 2; i++){
     ee8:	3c7d                	addiw	s8,s8,-1
     eea:	fe0c16e3          	bnez	s8,ed6 <bigwrite+0x60>
    close(fd);
     eee:	854a                	mv	a0,s2
     ef0:	00003097          	auipc	ra,0x3
     ef4:	70c080e7          	jalr	1804(ra) # 45fc <close>
    unlink("bigwrite");
     ef8:	8552                	mv	a0,s4
     efa:	00003097          	auipc	ra,0x3
     efe:	72a080e7          	jalr	1834(ra) # 4624 <unlink>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     f02:	1d74849b          	addiw	s1,s1,471
     f06:	fb549ee3          	bne	s1,s5,ec2 <bigwrite+0x4c>
}
     f0a:	60e6                	ld	ra,88(sp)
     f0c:	6446                	ld	s0,80(sp)
     f0e:	64a6                	ld	s1,72(sp)
     f10:	6906                	ld	s2,64(sp)
     f12:	79e2                	ld	s3,56(sp)
     f14:	7a42                	ld	s4,48(sp)
     f16:	7aa2                	ld	s5,40(sp)
     f18:	7b02                	ld	s6,32(sp)
     f1a:	6be2                	ld	s7,24(sp)
     f1c:	6c42                	ld	s8,16(sp)
     f1e:	6ca2                	ld	s9,8(sp)
     f20:	6125                	addi	sp,sp,96
     f22:	8082                	ret
      printf("%s: cannot create bigwrite\n", s);
     f24:	85e6                	mv	a1,s9
     f26:	00004517          	auipc	a0,0x4
     f2a:	20a50513          	addi	a0,a0,522 # 5130 <malloc+0x732>
     f2e:	00004097          	auipc	ra,0x4
     f32:	a14080e7          	jalr	-1516(ra) # 4942 <printf>
      exit(1);
     f36:	4505                	li	a0,1
     f38:	00003097          	auipc	ra,0x3
     f3c:	69c080e7          	jalr	1692(ra) # 45d4 <exit>
        printf("%s: write(%d) ret %d\n", s, sz, cc);
     f40:	86aa                	mv	a3,a0
     f42:	8626                	mv	a2,s1
     f44:	85e6                	mv	a1,s9
     f46:	00004517          	auipc	a0,0x4
     f4a:	20a50513          	addi	a0,a0,522 # 5150 <malloc+0x752>
     f4e:	00004097          	auipc	ra,0x4
     f52:	9f4080e7          	jalr	-1548(ra) # 4942 <printf>
        exit(1);
     f56:	4505                	li	a0,1
     f58:	00003097          	auipc	ra,0x3
     f5c:	67c080e7          	jalr	1660(ra) # 45d4 <exit>

0000000000000f60 <writetest>:
{
     f60:	715d                	addi	sp,sp,-80
     f62:	e486                	sd	ra,72(sp)
     f64:	e0a2                	sd	s0,64(sp)
     f66:	fc26                	sd	s1,56(sp)
     f68:	f84a                	sd	s2,48(sp)
     f6a:	f44e                	sd	s3,40(sp)
     f6c:	f052                	sd	s4,32(sp)
     f6e:	ec56                	sd	s5,24(sp)
     f70:	e85a                	sd	s6,16(sp)
     f72:	e45e                	sd	s7,8(sp)
     f74:	0880                	addi	s0,sp,80
     f76:	8baa                	mv	s7,a0
  fd = open("small", O_CREATE|O_RDWR);
     f78:	20200593          	li	a1,514
     f7c:	00004517          	auipc	a0,0x4
     f80:	1ec50513          	addi	a0,a0,492 # 5168 <malloc+0x76a>
     f84:	00003097          	auipc	ra,0x3
     f88:	690080e7          	jalr	1680(ra) # 4614 <open>
  if(fd < 0){
     f8c:	0a054d63          	bltz	a0,1046 <writetest+0xe6>
     f90:	89aa                	mv	s3,a0
     f92:	4901                	li	s2,0
    if(write(fd, "aaaaaaaaaa", SZ) != SZ){
     f94:	44a9                	li	s1,10
     f96:	00004a17          	auipc	s4,0x4
     f9a:	1faa0a13          	addi	s4,s4,506 # 5190 <malloc+0x792>
    if(write(fd, "bbbbbbbbbb", SZ) != SZ){
     f9e:	00004b17          	auipc	s6,0x4
     fa2:	22ab0b13          	addi	s6,s6,554 # 51c8 <malloc+0x7ca>
  for(i = 0; i < N; i++){
     fa6:	06400a93          	li	s5,100
    if(write(fd, "aaaaaaaaaa", SZ) != SZ){
     faa:	8626                	mv	a2,s1
     fac:	85d2                	mv	a1,s4
     fae:	854e                	mv	a0,s3
     fb0:	00003097          	auipc	ra,0x3
     fb4:	644080e7          	jalr	1604(ra) # 45f4 <write>
     fb8:	0a951563          	bne	a0,s1,1062 <writetest+0x102>
    if(write(fd, "bbbbbbbbbb", SZ) != SZ){
     fbc:	8626                	mv	a2,s1
     fbe:	85da                	mv	a1,s6
     fc0:	854e                	mv	a0,s3
     fc2:	00003097          	auipc	ra,0x3
     fc6:	632080e7          	jalr	1586(ra) # 45f4 <write>
     fca:	0a951a63          	bne	a0,s1,107e <writetest+0x11e>
  for(i = 0; i < N; i++){
     fce:	2905                	addiw	s2,s2,1
     fd0:	fd591de3          	bne	s2,s5,faa <writetest+0x4a>
  close(fd);
     fd4:	854e                	mv	a0,s3
     fd6:	00003097          	auipc	ra,0x3
     fda:	626080e7          	jalr	1574(ra) # 45fc <close>
  fd = open("small", O_RDONLY);
     fde:	4581                	li	a1,0
     fe0:	00004517          	auipc	a0,0x4
     fe4:	18850513          	addi	a0,a0,392 # 5168 <malloc+0x76a>
     fe8:	00003097          	auipc	ra,0x3
     fec:	62c080e7          	jalr	1580(ra) # 4614 <open>
     ff0:	84aa                	mv	s1,a0
  if(fd < 0){
     ff2:	0a054463          	bltz	a0,109a <writetest+0x13a>
  i = read(fd, buf, N*SZ*2);
     ff6:	7d000613          	li	a2,2000
     ffa:	00008597          	auipc	a1,0x8
     ffe:	43658593          	addi	a1,a1,1078 # 9430 <buf>
    1002:	00003097          	auipc	ra,0x3
    1006:	5ea080e7          	jalr	1514(ra) # 45ec <read>
  if(i != N*SZ*2){
    100a:	7d000793          	li	a5,2000
    100e:	0af51463          	bne	a0,a5,10b6 <writetest+0x156>
  close(fd);
    1012:	8526                	mv	a0,s1
    1014:	00003097          	auipc	ra,0x3
    1018:	5e8080e7          	jalr	1512(ra) # 45fc <close>
  if(unlink("small") < 0){
    101c:	00004517          	auipc	a0,0x4
    1020:	14c50513          	addi	a0,a0,332 # 5168 <malloc+0x76a>
    1024:	00003097          	auipc	ra,0x3
    1028:	600080e7          	jalr	1536(ra) # 4624 <unlink>
    102c:	0a054363          	bltz	a0,10d2 <writetest+0x172>
}
    1030:	60a6                	ld	ra,72(sp)
    1032:	6406                	ld	s0,64(sp)
    1034:	74e2                	ld	s1,56(sp)
    1036:	7942                	ld	s2,48(sp)
    1038:	79a2                	ld	s3,40(sp)
    103a:	7a02                	ld	s4,32(sp)
    103c:	6ae2                	ld	s5,24(sp)
    103e:	6b42                	ld	s6,16(sp)
    1040:	6ba2                	ld	s7,8(sp)
    1042:	6161                	addi	sp,sp,80
    1044:	8082                	ret
    printf("%s: error: creat small failed!\n", s);
    1046:	85de                	mv	a1,s7
    1048:	00004517          	auipc	a0,0x4
    104c:	12850513          	addi	a0,a0,296 # 5170 <malloc+0x772>
    1050:	00004097          	auipc	ra,0x4
    1054:	8f2080e7          	jalr	-1806(ra) # 4942 <printf>
    exit(1);
    1058:	4505                	li	a0,1
    105a:	00003097          	auipc	ra,0x3
    105e:	57a080e7          	jalr	1402(ra) # 45d4 <exit>
      printf("%s: error: write aa %d new file failed\n", i);
    1062:	85ca                	mv	a1,s2
    1064:	00004517          	auipc	a0,0x4
    1068:	13c50513          	addi	a0,a0,316 # 51a0 <malloc+0x7a2>
    106c:	00004097          	auipc	ra,0x4
    1070:	8d6080e7          	jalr	-1834(ra) # 4942 <printf>
      exit(1);
    1074:	4505                	li	a0,1
    1076:	00003097          	auipc	ra,0x3
    107a:	55e080e7          	jalr	1374(ra) # 45d4 <exit>
      printf("%s: error: write bb %d new file failed\n", i);
    107e:	85ca                	mv	a1,s2
    1080:	00004517          	auipc	a0,0x4
    1084:	15850513          	addi	a0,a0,344 # 51d8 <malloc+0x7da>
    1088:	00004097          	auipc	ra,0x4
    108c:	8ba080e7          	jalr	-1862(ra) # 4942 <printf>
      exit(1);
    1090:	4505                	li	a0,1
    1092:	00003097          	auipc	ra,0x3
    1096:	542080e7          	jalr	1346(ra) # 45d4 <exit>
    printf("%s: error: open small failed!\n", s);
    109a:	85de                	mv	a1,s7
    109c:	00004517          	auipc	a0,0x4
    10a0:	16450513          	addi	a0,a0,356 # 5200 <malloc+0x802>
    10a4:	00004097          	auipc	ra,0x4
    10a8:	89e080e7          	jalr	-1890(ra) # 4942 <printf>
    exit(1);
    10ac:	4505                	li	a0,1
    10ae:	00003097          	auipc	ra,0x3
    10b2:	526080e7          	jalr	1318(ra) # 45d4 <exit>
    printf("%s: read failed\n", s);
    10b6:	85de                	mv	a1,s7
    10b8:	00004517          	auipc	a0,0x4
    10bc:	16850513          	addi	a0,a0,360 # 5220 <malloc+0x822>
    10c0:	00004097          	auipc	ra,0x4
    10c4:	882080e7          	jalr	-1918(ra) # 4942 <printf>
    exit(1);
    10c8:	4505                	li	a0,1
    10ca:	00003097          	auipc	ra,0x3
    10ce:	50a080e7          	jalr	1290(ra) # 45d4 <exit>
    printf("%s: unlink small failed\n", s);
    10d2:	85de                	mv	a1,s7
    10d4:	00004517          	auipc	a0,0x4
    10d8:	16450513          	addi	a0,a0,356 # 5238 <malloc+0x83a>
    10dc:	00004097          	auipc	ra,0x4
    10e0:	866080e7          	jalr	-1946(ra) # 4942 <printf>
    exit(1);
    10e4:	4505                	li	a0,1
    10e6:	00003097          	auipc	ra,0x3
    10ea:	4ee080e7          	jalr	1262(ra) # 45d4 <exit>

00000000000010ee <writebig>:
{
    10ee:	7139                	addi	sp,sp,-64
    10f0:	fc06                	sd	ra,56(sp)
    10f2:	f822                	sd	s0,48(sp)
    10f4:	f426                	sd	s1,40(sp)
    10f6:	f04a                	sd	s2,32(sp)
    10f8:	ec4e                	sd	s3,24(sp)
    10fa:	e852                	sd	s4,16(sp)
    10fc:	e456                	sd	s5,8(sp)
    10fe:	e05a                	sd	s6,0(sp)
    1100:	0080                	addi	s0,sp,64
    1102:	8b2a                	mv	s6,a0
  fd = open("big", O_CREATE|O_RDWR);
    1104:	20200593          	li	a1,514
    1108:	00004517          	auipc	a0,0x4
    110c:	15050513          	addi	a0,a0,336 # 5258 <malloc+0x85a>
    1110:	00003097          	auipc	ra,0x3
    1114:	504080e7          	jalr	1284(ra) # 4614 <open>
  if(fd < 0){
    1118:	08054263          	bltz	a0,119c <writebig+0xae>
    111c:	8a2a                	mv	s4,a0
    111e:	4481                	li	s1,0
    ((int*)buf)[0] = i;
    1120:	00008997          	auipc	s3,0x8
    1124:	31098993          	addi	s3,s3,784 # 9430 <buf>
    if(write(fd, buf, BSIZE) != BSIZE){
    1128:	40000913          	li	s2,1024
  for(i = 0; i < MAXFILE; i++){
    112c:	10c00a93          	li	s5,268
    ((int*)buf)[0] = i;
    1130:	0099a023          	sw	s1,0(s3)
    if(write(fd, buf, BSIZE) != BSIZE){
    1134:	864a                	mv	a2,s2
    1136:	85ce                	mv	a1,s3
    1138:	8552                	mv	a0,s4
    113a:	00003097          	auipc	ra,0x3
    113e:	4ba080e7          	jalr	1210(ra) # 45f4 <write>
    1142:	07251b63          	bne	a0,s2,11b8 <writebig+0xca>
  for(i = 0; i < MAXFILE; i++){
    1146:	2485                	addiw	s1,s1,1
    1148:	ff5494e3          	bne	s1,s5,1130 <writebig+0x42>
  close(fd);
    114c:	8552                	mv	a0,s4
    114e:	00003097          	auipc	ra,0x3
    1152:	4ae080e7          	jalr	1198(ra) # 45fc <close>
  fd = open("big", O_RDONLY);
    1156:	4581                	li	a1,0
    1158:	00004517          	auipc	a0,0x4
    115c:	10050513          	addi	a0,a0,256 # 5258 <malloc+0x85a>
    1160:	00003097          	auipc	ra,0x3
    1164:	4b4080e7          	jalr	1204(ra) # 4614 <open>
    1168:	8a2a                	mv	s4,a0
  n = 0;
    116a:	4481                	li	s1,0
    i = read(fd, buf, BSIZE);
    116c:	40000993          	li	s3,1024
    1170:	00008917          	auipc	s2,0x8
    1174:	2c090913          	addi	s2,s2,704 # 9430 <buf>
  if(fd < 0){
    1178:	04054e63          	bltz	a0,11d4 <writebig+0xe6>
    i = read(fd, buf, BSIZE);
    117c:	864e                	mv	a2,s3
    117e:	85ca                	mv	a1,s2
    1180:	8552                	mv	a0,s4
    1182:	00003097          	auipc	ra,0x3
    1186:	46a080e7          	jalr	1130(ra) # 45ec <read>
    if(i == 0){
    118a:	c13d                	beqz	a0,11f0 <writebig+0x102>
    } else if(i != BSIZE){
    118c:	0b351d63          	bne	a0,s3,1246 <writebig+0x158>
    if(((int*)buf)[0] != n){
    1190:	00092603          	lw	a2,0(s2)
    1194:	0c961763          	bne	a2,s1,1262 <writebig+0x174>
    n++;
    1198:	2485                	addiw	s1,s1,1
    i = read(fd, buf, BSIZE);
    119a:	b7cd                	j	117c <writebig+0x8e>
    printf("%s: error: creat big failed!\n", s);
    119c:	85da                	mv	a1,s6
    119e:	00004517          	auipc	a0,0x4
    11a2:	0c250513          	addi	a0,a0,194 # 5260 <malloc+0x862>
    11a6:	00003097          	auipc	ra,0x3
    11aa:	79c080e7          	jalr	1948(ra) # 4942 <printf>
    exit(1);
    11ae:	4505                	li	a0,1
    11b0:	00003097          	auipc	ra,0x3
    11b4:	424080e7          	jalr	1060(ra) # 45d4 <exit>
      printf("%s: error: write big file failed\n", i);
    11b8:	85a6                	mv	a1,s1
    11ba:	00004517          	auipc	a0,0x4
    11be:	0c650513          	addi	a0,a0,198 # 5280 <malloc+0x882>
    11c2:	00003097          	auipc	ra,0x3
    11c6:	780080e7          	jalr	1920(ra) # 4942 <printf>
      exit(1);
    11ca:	4505                	li	a0,1
    11cc:	00003097          	auipc	ra,0x3
    11d0:	408080e7          	jalr	1032(ra) # 45d4 <exit>
    printf("%s: error: open big failed!\n", s);
    11d4:	85da                	mv	a1,s6
    11d6:	00004517          	auipc	a0,0x4
    11da:	0d250513          	addi	a0,a0,210 # 52a8 <malloc+0x8aa>
    11de:	00003097          	auipc	ra,0x3
    11e2:	764080e7          	jalr	1892(ra) # 4942 <printf>
    exit(1);
    11e6:	4505                	li	a0,1
    11e8:	00003097          	auipc	ra,0x3
    11ec:	3ec080e7          	jalr	1004(ra) # 45d4 <exit>
      if(n == MAXFILE - 1){
    11f0:	10b00793          	li	a5,267
    11f4:	02f48b63          	beq	s1,a5,122a <writebig+0x13c>
  close(fd);
    11f8:	8552                	mv	a0,s4
    11fa:	00003097          	auipc	ra,0x3
    11fe:	402080e7          	jalr	1026(ra) # 45fc <close>
  if(unlink("big") < 0){
    1202:	00004517          	auipc	a0,0x4
    1206:	05650513          	addi	a0,a0,86 # 5258 <malloc+0x85a>
    120a:	00003097          	auipc	ra,0x3
    120e:	41a080e7          	jalr	1050(ra) # 4624 <unlink>
    1212:	06054663          	bltz	a0,127e <writebig+0x190>
}
    1216:	70e2                	ld	ra,56(sp)
    1218:	7442                	ld	s0,48(sp)
    121a:	74a2                	ld	s1,40(sp)
    121c:	7902                	ld	s2,32(sp)
    121e:	69e2                	ld	s3,24(sp)
    1220:	6a42                	ld	s4,16(sp)
    1222:	6aa2                	ld	s5,8(sp)
    1224:	6b02                	ld	s6,0(sp)
    1226:	6121                	addi	sp,sp,64
    1228:	8082                	ret
        printf("%s: read only %d blocks from big", n);
    122a:	85a6                	mv	a1,s1
    122c:	00004517          	auipc	a0,0x4
    1230:	09c50513          	addi	a0,a0,156 # 52c8 <malloc+0x8ca>
    1234:	00003097          	auipc	ra,0x3
    1238:	70e080e7          	jalr	1806(ra) # 4942 <printf>
        exit(1);
    123c:	4505                	li	a0,1
    123e:	00003097          	auipc	ra,0x3
    1242:	396080e7          	jalr	918(ra) # 45d4 <exit>
      printf("%s: read failed %d\n", i);
    1246:	85aa                	mv	a1,a0
    1248:	00004517          	auipc	a0,0x4
    124c:	0a850513          	addi	a0,a0,168 # 52f0 <malloc+0x8f2>
    1250:	00003097          	auipc	ra,0x3
    1254:	6f2080e7          	jalr	1778(ra) # 4942 <printf>
      exit(1);
    1258:	4505                	li	a0,1
    125a:	00003097          	auipc	ra,0x3
    125e:	37a080e7          	jalr	890(ra) # 45d4 <exit>
      printf("%s: read content of block %d is %d\n",
    1262:	85a6                	mv	a1,s1
    1264:	00004517          	auipc	a0,0x4
    1268:	0a450513          	addi	a0,a0,164 # 5308 <malloc+0x90a>
    126c:	00003097          	auipc	ra,0x3
    1270:	6d6080e7          	jalr	1750(ra) # 4942 <printf>
      exit(1);
    1274:	4505                	li	a0,1
    1276:	00003097          	auipc	ra,0x3
    127a:	35e080e7          	jalr	862(ra) # 45d4 <exit>
    printf("%s: unlink big failed\n", s);
    127e:	85da                	mv	a1,s6
    1280:	00004517          	auipc	a0,0x4
    1284:	0b050513          	addi	a0,a0,176 # 5330 <malloc+0x932>
    1288:	00003097          	auipc	ra,0x3
    128c:	6ba080e7          	jalr	1722(ra) # 4942 <printf>
    exit(1);
    1290:	4505                	li	a0,1
    1292:	00003097          	auipc	ra,0x3
    1296:	342080e7          	jalr	834(ra) # 45d4 <exit>

000000000000129a <unlinkread>:
{
    129a:	7179                	addi	sp,sp,-48
    129c:	f406                	sd	ra,40(sp)
    129e:	f022                	sd	s0,32(sp)
    12a0:	ec26                	sd	s1,24(sp)
    12a2:	e84a                	sd	s2,16(sp)
    12a4:	e44e                	sd	s3,8(sp)
    12a6:	1800                	addi	s0,sp,48
    12a8:	89aa                	mv	s3,a0
  fd = open("unlinkread", O_CREATE | O_RDWR);
    12aa:	20200593          	li	a1,514
    12ae:	00004517          	auipc	a0,0x4
    12b2:	09a50513          	addi	a0,a0,154 # 5348 <malloc+0x94a>
    12b6:	00003097          	auipc	ra,0x3
    12ba:	35e080e7          	jalr	862(ra) # 4614 <open>
  if(fd < 0){
    12be:	0e054563          	bltz	a0,13a8 <unlinkread+0x10e>
    12c2:	84aa                	mv	s1,a0
  write(fd, "hello", SZ);
    12c4:	4615                	li	a2,5
    12c6:	00004597          	auipc	a1,0x4
    12ca:	0b258593          	addi	a1,a1,178 # 5378 <malloc+0x97a>
    12ce:	00003097          	auipc	ra,0x3
    12d2:	326080e7          	jalr	806(ra) # 45f4 <write>
  close(fd);
    12d6:	8526                	mv	a0,s1
    12d8:	00003097          	auipc	ra,0x3
    12dc:	324080e7          	jalr	804(ra) # 45fc <close>
  fd = open("unlinkread", O_RDWR);
    12e0:	4589                	li	a1,2
    12e2:	00004517          	auipc	a0,0x4
    12e6:	06650513          	addi	a0,a0,102 # 5348 <malloc+0x94a>
    12ea:	00003097          	auipc	ra,0x3
    12ee:	32a080e7          	jalr	810(ra) # 4614 <open>
    12f2:	84aa                	mv	s1,a0
  if(fd < 0){
    12f4:	0c054863          	bltz	a0,13c4 <unlinkread+0x12a>
  if(unlink("unlinkread") != 0){
    12f8:	00004517          	auipc	a0,0x4
    12fc:	05050513          	addi	a0,a0,80 # 5348 <malloc+0x94a>
    1300:	00003097          	auipc	ra,0x3
    1304:	324080e7          	jalr	804(ra) # 4624 <unlink>
    1308:	ed61                	bnez	a0,13e0 <unlinkread+0x146>
  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    130a:	20200593          	li	a1,514
    130e:	00004517          	auipc	a0,0x4
    1312:	03a50513          	addi	a0,a0,58 # 5348 <malloc+0x94a>
    1316:	00003097          	auipc	ra,0x3
    131a:	2fe080e7          	jalr	766(ra) # 4614 <open>
    131e:	892a                	mv	s2,a0
  write(fd1, "yyy", 3);
    1320:	460d                	li	a2,3
    1322:	00004597          	auipc	a1,0x4
    1326:	09e58593          	addi	a1,a1,158 # 53c0 <malloc+0x9c2>
    132a:	00003097          	auipc	ra,0x3
    132e:	2ca080e7          	jalr	714(ra) # 45f4 <write>
  close(fd1);
    1332:	854a                	mv	a0,s2
    1334:	00003097          	auipc	ra,0x3
    1338:	2c8080e7          	jalr	712(ra) # 45fc <close>
  if(read(fd, buf, sizeof(buf)) != SZ){
    133c:	660d                	lui	a2,0x3
    133e:	00008597          	auipc	a1,0x8
    1342:	0f258593          	addi	a1,a1,242 # 9430 <buf>
    1346:	8526                	mv	a0,s1
    1348:	00003097          	auipc	ra,0x3
    134c:	2a4080e7          	jalr	676(ra) # 45ec <read>
    1350:	4795                	li	a5,5
    1352:	0af51563          	bne	a0,a5,13fc <unlinkread+0x162>
  if(buf[0] != 'h'){
    1356:	00008717          	auipc	a4,0x8
    135a:	0da74703          	lbu	a4,218(a4) # 9430 <buf>
    135e:	06800793          	li	a5,104
    1362:	0af71b63          	bne	a4,a5,1418 <unlinkread+0x17e>
  if(write(fd, buf, 10) != 10){
    1366:	4629                	li	a2,10
    1368:	00008597          	auipc	a1,0x8
    136c:	0c858593          	addi	a1,a1,200 # 9430 <buf>
    1370:	8526                	mv	a0,s1
    1372:	00003097          	auipc	ra,0x3
    1376:	282080e7          	jalr	642(ra) # 45f4 <write>
    137a:	47a9                	li	a5,10
    137c:	0af51c63          	bne	a0,a5,1434 <unlinkread+0x19a>
  close(fd);
    1380:	8526                	mv	a0,s1
    1382:	00003097          	auipc	ra,0x3
    1386:	27a080e7          	jalr	634(ra) # 45fc <close>
  unlink("unlinkread");
    138a:	00004517          	auipc	a0,0x4
    138e:	fbe50513          	addi	a0,a0,-66 # 5348 <malloc+0x94a>
    1392:	00003097          	auipc	ra,0x3
    1396:	292080e7          	jalr	658(ra) # 4624 <unlink>
}
    139a:	70a2                	ld	ra,40(sp)
    139c:	7402                	ld	s0,32(sp)
    139e:	64e2                	ld	s1,24(sp)
    13a0:	6942                	ld	s2,16(sp)
    13a2:	69a2                	ld	s3,8(sp)
    13a4:	6145                	addi	sp,sp,48
    13a6:	8082                	ret
    printf("%s: create unlinkread failed\n", s);
    13a8:	85ce                	mv	a1,s3
    13aa:	00004517          	auipc	a0,0x4
    13ae:	fae50513          	addi	a0,a0,-82 # 5358 <malloc+0x95a>
    13b2:	00003097          	auipc	ra,0x3
    13b6:	590080e7          	jalr	1424(ra) # 4942 <printf>
    exit(1);
    13ba:	4505                	li	a0,1
    13bc:	00003097          	auipc	ra,0x3
    13c0:	218080e7          	jalr	536(ra) # 45d4 <exit>
    printf("%s: open unlinkread failed\n", s);
    13c4:	85ce                	mv	a1,s3
    13c6:	00004517          	auipc	a0,0x4
    13ca:	fba50513          	addi	a0,a0,-70 # 5380 <malloc+0x982>
    13ce:	00003097          	auipc	ra,0x3
    13d2:	574080e7          	jalr	1396(ra) # 4942 <printf>
    exit(1);
    13d6:	4505                	li	a0,1
    13d8:	00003097          	auipc	ra,0x3
    13dc:	1fc080e7          	jalr	508(ra) # 45d4 <exit>
    printf("%s: unlink unlinkread failed\n", s);
    13e0:	85ce                	mv	a1,s3
    13e2:	00004517          	auipc	a0,0x4
    13e6:	fbe50513          	addi	a0,a0,-66 # 53a0 <malloc+0x9a2>
    13ea:	00003097          	auipc	ra,0x3
    13ee:	558080e7          	jalr	1368(ra) # 4942 <printf>
    exit(1);
    13f2:	4505                	li	a0,1
    13f4:	00003097          	auipc	ra,0x3
    13f8:	1e0080e7          	jalr	480(ra) # 45d4 <exit>
    printf("%s: unlinkread read failed", s);
    13fc:	85ce                	mv	a1,s3
    13fe:	00004517          	auipc	a0,0x4
    1402:	fca50513          	addi	a0,a0,-54 # 53c8 <malloc+0x9ca>
    1406:	00003097          	auipc	ra,0x3
    140a:	53c080e7          	jalr	1340(ra) # 4942 <printf>
    exit(1);
    140e:	4505                	li	a0,1
    1410:	00003097          	auipc	ra,0x3
    1414:	1c4080e7          	jalr	452(ra) # 45d4 <exit>
    printf("%s: unlinkread wrong data\n", s);
    1418:	85ce                	mv	a1,s3
    141a:	00004517          	auipc	a0,0x4
    141e:	fce50513          	addi	a0,a0,-50 # 53e8 <malloc+0x9ea>
    1422:	00003097          	auipc	ra,0x3
    1426:	520080e7          	jalr	1312(ra) # 4942 <printf>
    exit(1);
    142a:	4505                	li	a0,1
    142c:	00003097          	auipc	ra,0x3
    1430:	1a8080e7          	jalr	424(ra) # 45d4 <exit>
    printf("%s: unlinkread write failed\n", s);
    1434:	85ce                	mv	a1,s3
    1436:	00004517          	auipc	a0,0x4
    143a:	fd250513          	addi	a0,a0,-46 # 5408 <malloc+0xa0a>
    143e:	00003097          	auipc	ra,0x3
    1442:	504080e7          	jalr	1284(ra) # 4942 <printf>
    exit(1);
    1446:	4505                	li	a0,1
    1448:	00003097          	auipc	ra,0x3
    144c:	18c080e7          	jalr	396(ra) # 45d4 <exit>

0000000000001450 <exectest>:
{
    1450:	715d                	addi	sp,sp,-80
    1452:	e486                	sd	ra,72(sp)
    1454:	e0a2                	sd	s0,64(sp)
    1456:	f84a                	sd	s2,48(sp)
    1458:	0880                	addi	s0,sp,80
    145a:	892a                	mv	s2,a0
  char *echoargv[] = { "echo", "OK", 0 };
    145c:	00004797          	auipc	a5,0x4
    1460:	9dc78793          	addi	a5,a5,-1572 # 4e38 <malloc+0x43a>
    1464:	fcf43023          	sd	a5,-64(s0)
    1468:	00004797          	auipc	a5,0x4
    146c:	fc078793          	addi	a5,a5,-64 # 5428 <malloc+0xa2a>
    1470:	fcf43423          	sd	a5,-56(s0)
    1474:	fc043823          	sd	zero,-48(s0)
  unlink("echo-ok");
    1478:	00004517          	auipc	a0,0x4
    147c:	fb850513          	addi	a0,a0,-72 # 5430 <malloc+0xa32>
    1480:	00003097          	auipc	ra,0x3
    1484:	1a4080e7          	jalr	420(ra) # 4624 <unlink>
  pid = fork();
    1488:	00003097          	auipc	ra,0x3
    148c:	144080e7          	jalr	324(ra) # 45cc <fork>
  if(pid < 0) {
    1490:	04054763          	bltz	a0,14de <exectest+0x8e>
    1494:	fc26                	sd	s1,56(sp)
    1496:	84aa                	mv	s1,a0
  if(pid == 0) {
    1498:	ed41                	bnez	a0,1530 <exectest+0xe0>
    close(1);
    149a:	4505                	li	a0,1
    149c:	00003097          	auipc	ra,0x3
    14a0:	160080e7          	jalr	352(ra) # 45fc <close>
    fd = open("echo-ok", O_CREATE|O_WRONLY);
    14a4:	20100593          	li	a1,513
    14a8:	00004517          	auipc	a0,0x4
    14ac:	f8850513          	addi	a0,a0,-120 # 5430 <malloc+0xa32>
    14b0:	00003097          	auipc	ra,0x3
    14b4:	164080e7          	jalr	356(ra) # 4614 <open>
    if(fd < 0) {
    14b8:	04054263          	bltz	a0,14fc <exectest+0xac>
    if(fd != 1) {
    14bc:	4785                	li	a5,1
    14be:	04f50d63          	beq	a0,a5,1518 <exectest+0xc8>
      printf("%s: wrong fd\n", s);
    14c2:	85ca                	mv	a1,s2
    14c4:	00004517          	auipc	a0,0x4
    14c8:	f7450513          	addi	a0,a0,-140 # 5438 <malloc+0xa3a>
    14cc:	00003097          	auipc	ra,0x3
    14d0:	476080e7          	jalr	1142(ra) # 4942 <printf>
      exit(1);
    14d4:	4505                	li	a0,1
    14d6:	00003097          	auipc	ra,0x3
    14da:	0fe080e7          	jalr	254(ra) # 45d4 <exit>
    14de:	fc26                	sd	s1,56(sp)
     printf("%s: fork failed\n", s);
    14e0:	85ca                	mv	a1,s2
    14e2:	00003517          	auipc	a0,0x3
    14e6:	7a650513          	addi	a0,a0,1958 # 4c88 <malloc+0x28a>
    14ea:	00003097          	auipc	ra,0x3
    14ee:	458080e7          	jalr	1112(ra) # 4942 <printf>
     exit(1);
    14f2:	4505                	li	a0,1
    14f4:	00003097          	auipc	ra,0x3
    14f8:	0e0080e7          	jalr	224(ra) # 45d4 <exit>
      printf("%s: create failed\n", s);
    14fc:	85ca                	mv	a1,s2
    14fe:	00004517          	auipc	a0,0x4
    1502:	9a250513          	addi	a0,a0,-1630 # 4ea0 <malloc+0x4a2>
    1506:	00003097          	auipc	ra,0x3
    150a:	43c080e7          	jalr	1084(ra) # 4942 <printf>
      exit(1);
    150e:	4505                	li	a0,1
    1510:	00003097          	auipc	ra,0x3
    1514:	0c4080e7          	jalr	196(ra) # 45d4 <exit>
    if(exec("echo", echoargv) < 0){
    1518:	fc040593          	addi	a1,s0,-64
    151c:	00004517          	auipc	a0,0x4
    1520:	91c50513          	addi	a0,a0,-1764 # 4e38 <malloc+0x43a>
    1524:	00003097          	auipc	ra,0x3
    1528:	0e8080e7          	jalr	232(ra) # 460c <exec>
    152c:	02054163          	bltz	a0,154e <exectest+0xfe>
  if (wait(&xstatus) != pid) {
    1530:	fdc40513          	addi	a0,s0,-36
    1534:	00003097          	auipc	ra,0x3
    1538:	0a8080e7          	jalr	168(ra) # 45dc <wait>
    153c:	02951763          	bne	a0,s1,156a <exectest+0x11a>
  if(xstatus != 0)
    1540:	fdc42503          	lw	a0,-36(s0)
    1544:	cd0d                	beqz	a0,157e <exectest+0x12e>
    exit(xstatus);
    1546:	00003097          	auipc	ra,0x3
    154a:	08e080e7          	jalr	142(ra) # 45d4 <exit>
      printf("%s: exec echo failed\n", s);
    154e:	85ca                	mv	a1,s2
    1550:	00004517          	auipc	a0,0x4
    1554:	ef850513          	addi	a0,a0,-264 # 5448 <malloc+0xa4a>
    1558:	00003097          	auipc	ra,0x3
    155c:	3ea080e7          	jalr	1002(ra) # 4942 <printf>
      exit(1);
    1560:	4505                	li	a0,1
    1562:	00003097          	auipc	ra,0x3
    1566:	072080e7          	jalr	114(ra) # 45d4 <exit>
    printf("%s: wait failed!\n", s);
    156a:	85ca                	mv	a1,s2
    156c:	00004517          	auipc	a0,0x4
    1570:	ef450513          	addi	a0,a0,-268 # 5460 <malloc+0xa62>
    1574:	00003097          	auipc	ra,0x3
    1578:	3ce080e7          	jalr	974(ra) # 4942 <printf>
    157c:	b7d1                	j	1540 <exectest+0xf0>
  fd = open("echo-ok", O_RDONLY);
    157e:	4581                	li	a1,0
    1580:	00004517          	auipc	a0,0x4
    1584:	eb050513          	addi	a0,a0,-336 # 5430 <malloc+0xa32>
    1588:	00003097          	auipc	ra,0x3
    158c:	08c080e7          	jalr	140(ra) # 4614 <open>
  if(fd < 0) {
    1590:	02054a63          	bltz	a0,15c4 <exectest+0x174>
  if (read(fd, buf, 2) != 2) {
    1594:	4609                	li	a2,2
    1596:	fb840593          	addi	a1,s0,-72
    159a:	00003097          	auipc	ra,0x3
    159e:	052080e7          	jalr	82(ra) # 45ec <read>
    15a2:	4789                	li	a5,2
    15a4:	02f50e63          	beq	a0,a5,15e0 <exectest+0x190>
    printf("%s: read failed\n", s);
    15a8:	85ca                	mv	a1,s2
    15aa:	00004517          	auipc	a0,0x4
    15ae:	c7650513          	addi	a0,a0,-906 # 5220 <malloc+0x822>
    15b2:	00003097          	auipc	ra,0x3
    15b6:	390080e7          	jalr	912(ra) # 4942 <printf>
    exit(1);
    15ba:	4505                	li	a0,1
    15bc:	00003097          	auipc	ra,0x3
    15c0:	018080e7          	jalr	24(ra) # 45d4 <exit>
    printf("%s: open failed\n", s);
    15c4:	85ca                	mv	a1,s2
    15c6:	00004517          	auipc	a0,0x4
    15ca:	eb250513          	addi	a0,a0,-334 # 5478 <malloc+0xa7a>
    15ce:	00003097          	auipc	ra,0x3
    15d2:	374080e7          	jalr	884(ra) # 4942 <printf>
    exit(1);
    15d6:	4505                	li	a0,1
    15d8:	00003097          	auipc	ra,0x3
    15dc:	ffc080e7          	jalr	-4(ra) # 45d4 <exit>
  unlink("echo-ok");
    15e0:	00004517          	auipc	a0,0x4
    15e4:	e5050513          	addi	a0,a0,-432 # 5430 <malloc+0xa32>
    15e8:	00003097          	auipc	ra,0x3
    15ec:	03c080e7          	jalr	60(ra) # 4624 <unlink>
  if(buf[0] == 'O' && buf[1] == 'K')
    15f0:	fb844703          	lbu	a4,-72(s0)
    15f4:	04f00793          	li	a5,79
    15f8:	00f71863          	bne	a4,a5,1608 <exectest+0x1b8>
    15fc:	fb944703          	lbu	a4,-71(s0)
    1600:	04b00793          	li	a5,75
    1604:	02f70063          	beq	a4,a5,1624 <exectest+0x1d4>
    printf("%s: wrong output\n", s);
    1608:	85ca                	mv	a1,s2
    160a:	00004517          	auipc	a0,0x4
    160e:	e8650513          	addi	a0,a0,-378 # 5490 <malloc+0xa92>
    1612:	00003097          	auipc	ra,0x3
    1616:	330080e7          	jalr	816(ra) # 4942 <printf>
    exit(1);
    161a:	4505                	li	a0,1
    161c:	00003097          	auipc	ra,0x3
    1620:	fb8080e7          	jalr	-72(ra) # 45d4 <exit>
    exit(0);
    1624:	4501                	li	a0,0
    1626:	00003097          	auipc	ra,0x3
    162a:	fae080e7          	jalr	-82(ra) # 45d4 <exit>

000000000000162e <bigargtest>:
{
    162e:	7179                	addi	sp,sp,-48
    1630:	f406                	sd	ra,40(sp)
    1632:	f022                	sd	s0,32(sp)
    1634:	ec26                	sd	s1,24(sp)
    1636:	1800                	addi	s0,sp,48
    1638:	84aa                	mv	s1,a0
  unlink("bigarg-ok");
    163a:	00004517          	auipc	a0,0x4
    163e:	e6e50513          	addi	a0,a0,-402 # 54a8 <malloc+0xaaa>
    1642:	00003097          	auipc	ra,0x3
    1646:	fe2080e7          	jalr	-30(ra) # 4624 <unlink>
  pid = fork();
    164a:	00003097          	auipc	ra,0x3
    164e:	f82080e7          	jalr	-126(ra) # 45cc <fork>
  if(pid == 0){
    1652:	c121                	beqz	a0,1692 <bigargtest+0x64>
  } else if(pid < 0){
    1654:	0a054263          	bltz	a0,16f8 <bigargtest+0xca>
  wait(&xstatus);
    1658:	fdc40513          	addi	a0,s0,-36
    165c:	00003097          	auipc	ra,0x3
    1660:	f80080e7          	jalr	-128(ra) # 45dc <wait>
  if(xstatus != 0)
    1664:	fdc42503          	lw	a0,-36(s0)
    1668:	e555                	bnez	a0,1714 <bigargtest+0xe6>
  fd = open("bigarg-ok", 0);
    166a:	4581                	li	a1,0
    166c:	00004517          	auipc	a0,0x4
    1670:	e3c50513          	addi	a0,a0,-452 # 54a8 <malloc+0xaaa>
    1674:	00003097          	auipc	ra,0x3
    1678:	fa0080e7          	jalr	-96(ra) # 4614 <open>
  if(fd < 0){
    167c:	0a054063          	bltz	a0,171c <bigargtest+0xee>
  close(fd);
    1680:	00003097          	auipc	ra,0x3
    1684:	f7c080e7          	jalr	-132(ra) # 45fc <close>
}
    1688:	70a2                	ld	ra,40(sp)
    168a:	7402                	ld	s0,32(sp)
    168c:	64e2                	ld	s1,24(sp)
    168e:	6145                	addi	sp,sp,48
    1690:	8082                	ret
    1692:	00005797          	auipc	a5,0x5
    1696:	58e78793          	addi	a5,a5,1422 # 6c20 <args.0>
    169a:	00005697          	auipc	a3,0x5
    169e:	67e68693          	addi	a3,a3,1662 # 6d18 <args.0+0xf8>
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    16a2:	00004717          	auipc	a4,0x4
    16a6:	e1670713          	addi	a4,a4,-490 # 54b8 <malloc+0xaba>
    16aa:	e398                	sd	a4,0(a5)
    for(i = 0; i < MAXARG-1; i++)
    16ac:	07a1                	addi	a5,a5,8
    16ae:	fed79ee3          	bne	a5,a3,16aa <bigargtest+0x7c>
    args[MAXARG-1] = 0;
    16b2:	00005797          	auipc	a5,0x5
    16b6:	6607b323          	sd	zero,1638(a5) # 6d18 <args.0+0xf8>
    exec("echo", args);
    16ba:	00005597          	auipc	a1,0x5
    16be:	56658593          	addi	a1,a1,1382 # 6c20 <args.0>
    16c2:	00003517          	auipc	a0,0x3
    16c6:	77650513          	addi	a0,a0,1910 # 4e38 <malloc+0x43a>
    16ca:	00003097          	auipc	ra,0x3
    16ce:	f42080e7          	jalr	-190(ra) # 460c <exec>
    fd = open("bigarg-ok", O_CREATE);
    16d2:	20000593          	li	a1,512
    16d6:	00004517          	auipc	a0,0x4
    16da:	dd250513          	addi	a0,a0,-558 # 54a8 <malloc+0xaaa>
    16de:	00003097          	auipc	ra,0x3
    16e2:	f36080e7          	jalr	-202(ra) # 4614 <open>
    close(fd);
    16e6:	00003097          	auipc	ra,0x3
    16ea:	f16080e7          	jalr	-234(ra) # 45fc <close>
    exit(0);
    16ee:	4501                	li	a0,0
    16f0:	00003097          	auipc	ra,0x3
    16f4:	ee4080e7          	jalr	-284(ra) # 45d4 <exit>
    printf("%s: bigargtest: fork failed\n", s);
    16f8:	85a6                	mv	a1,s1
    16fa:	00004517          	auipc	a0,0x4
    16fe:	e9e50513          	addi	a0,a0,-354 # 5598 <malloc+0xb9a>
    1702:	00003097          	auipc	ra,0x3
    1706:	240080e7          	jalr	576(ra) # 4942 <printf>
    exit(1);
    170a:	4505                	li	a0,1
    170c:	00003097          	auipc	ra,0x3
    1710:	ec8080e7          	jalr	-312(ra) # 45d4 <exit>
    exit(xstatus);
    1714:	00003097          	auipc	ra,0x3
    1718:	ec0080e7          	jalr	-320(ra) # 45d4 <exit>
    printf("%s: bigarg test failed!\n", s);
    171c:	85a6                	mv	a1,s1
    171e:	00004517          	auipc	a0,0x4
    1722:	e9a50513          	addi	a0,a0,-358 # 55b8 <malloc+0xbba>
    1726:	00003097          	auipc	ra,0x3
    172a:	21c080e7          	jalr	540(ra) # 4942 <printf>
    exit(1);
    172e:	4505                	li	a0,1
    1730:	00003097          	auipc	ra,0x3
    1734:	ea4080e7          	jalr	-348(ra) # 45d4 <exit>

0000000000001738 <badarg>:

// regression test. test whether exec() leaks memory if one of the
// arguments is invalid. the test passes if the kernel doesn't panic.
void
badarg(char *s)
{
    1738:	7139                	addi	sp,sp,-64
    173a:	fc06                	sd	ra,56(sp)
    173c:	f822                	sd	s0,48(sp)
    173e:	f426                	sd	s1,40(sp)
    1740:	f04a                	sd	s2,32(sp)
    1742:	ec4e                	sd	s3,24(sp)
    1744:	e852                	sd	s4,16(sp)
    1746:	0080                	addi	s0,sp,64
    1748:	64b1                	lui	s1,0xc
    174a:	35048493          	addi	s1,s1,848 # c350 <buf+0x2f20>
  for(int i = 0; i < 50000; i++){
    char *argv[2];
    argv[0] = (char*)0xffffffff;
    174e:	597d                	li	s2,-1
    1750:	02095913          	srli	s2,s2,0x20
    argv[1] = 0;
    exec("echo", argv);
    1754:	fc040a13          	addi	s4,s0,-64
    1758:	00003997          	auipc	s3,0x3
    175c:	6e098993          	addi	s3,s3,1760 # 4e38 <malloc+0x43a>
    argv[0] = (char*)0xffffffff;
    1760:	fd243023          	sd	s2,-64(s0)
    argv[1] = 0;
    1764:	fc043423          	sd	zero,-56(s0)
    exec("echo", argv);
    1768:	85d2                	mv	a1,s4
    176a:	854e                	mv	a0,s3
    176c:	00003097          	auipc	ra,0x3
    1770:	ea0080e7          	jalr	-352(ra) # 460c <exec>
  for(int i = 0; i < 50000; i++){
    1774:	34fd                	addiw	s1,s1,-1
    1776:	f4ed                	bnez	s1,1760 <badarg+0x28>
  }
  
  exit(0);
    1778:	4501                	li	a0,0
    177a:	00003097          	auipc	ra,0x3
    177e:	e5a080e7          	jalr	-422(ra) # 45d4 <exit>

0000000000001782 <pipe1>:
{
    1782:	711d                	addi	sp,sp,-96
    1784:	ec86                	sd	ra,88(sp)
    1786:	e8a2                	sd	s0,80(sp)
    1788:	e862                	sd	s8,16(sp)
    178a:	1080                	addi	s0,sp,96
    178c:	8c2a                	mv	s8,a0
  if(pipe(fds) != 0){
    178e:	fa840513          	addi	a0,s0,-88
    1792:	00003097          	auipc	ra,0x3
    1796:	e52080e7          	jalr	-430(ra) # 45e4 <pipe>
    179a:	ed35                	bnez	a0,1816 <pipe1+0x94>
    179c:	e4a6                	sd	s1,72(sp)
    179e:	fc4e                	sd	s3,56(sp)
    17a0:	84aa                	mv	s1,a0
  pid = fork();
    17a2:	00003097          	auipc	ra,0x3
    17a6:	e2a080e7          	jalr	-470(ra) # 45cc <fork>
    17aa:	89aa                	mv	s3,a0
  if(pid == 0){
    17ac:	c951                	beqz	a0,1840 <pipe1+0xbe>
  } else if(pid > 0){
    17ae:	18a05d63          	blez	a0,1948 <pipe1+0x1c6>
    17b2:	e0ca                	sd	s2,64(sp)
    17b4:	f852                	sd	s4,48(sp)
    close(fds[1]);
    17b6:	fac42503          	lw	a0,-84(s0)
    17ba:	00003097          	auipc	ra,0x3
    17be:	e42080e7          	jalr	-446(ra) # 45fc <close>
    total = 0;
    17c2:	89a6                	mv	s3,s1
    cc = 1;
    17c4:	4905                	li	s2,1
    while((n = read(fds[0], buf, cc)) > 0){
    17c6:	00008a17          	auipc	s4,0x8
    17ca:	c6aa0a13          	addi	s4,s4,-918 # 9430 <buf>
    17ce:	864a                	mv	a2,s2
    17d0:	85d2                	mv	a1,s4
    17d2:	fa842503          	lw	a0,-88(s0)
    17d6:	00003097          	auipc	ra,0x3
    17da:	e16080e7          	jalr	-490(ra) # 45ec <read>
    17de:	85aa                	mv	a1,a0
    17e0:	10a05963          	blez	a0,18f2 <pipe1+0x170>
    17e4:	00008797          	auipc	a5,0x8
    17e8:	c4c78793          	addi	a5,a5,-948 # 9430 <buf>
    17ec:	00b4863b          	addw	a2,s1,a1
        if((buf[i] & 0xff) != (seq++ & 0xff)){
    17f0:	0007c683          	lbu	a3,0(a5)
    17f4:	0ff4f713          	zext.b	a4,s1
    17f8:	0ce69b63          	bne	a3,a4,18ce <pipe1+0x14c>
    17fc:	2485                	addiw	s1,s1,1
      for(i = 0; i < n; i++){
    17fe:	0785                	addi	a5,a5,1
    1800:	fec498e3          	bne	s1,a2,17f0 <pipe1+0x6e>
      total += n;
    1804:	00b989bb          	addw	s3,s3,a1
      cc = cc * 2;
    1808:	0019191b          	slliw	s2,s2,0x1
      if(cc > sizeof(buf))
    180c:	678d                	lui	a5,0x3
    180e:	fd27f0e3          	bgeu	a5,s2,17ce <pipe1+0x4c>
        cc = sizeof(buf);
    1812:	893e                	mv	s2,a5
    1814:	bf6d                	j	17ce <pipe1+0x4c>
    1816:	e4a6                	sd	s1,72(sp)
    1818:	e0ca                	sd	s2,64(sp)
    181a:	fc4e                	sd	s3,56(sp)
    181c:	f852                	sd	s4,48(sp)
    181e:	f456                	sd	s5,40(sp)
    1820:	f05a                	sd	s6,32(sp)
    1822:	ec5e                	sd	s7,24(sp)
    printf("%s: pipe() failed\n", s);
    1824:	85e2                	mv	a1,s8
    1826:	00004517          	auipc	a0,0x4
    182a:	db250513          	addi	a0,a0,-590 # 55d8 <malloc+0xbda>
    182e:	00003097          	auipc	ra,0x3
    1832:	114080e7          	jalr	276(ra) # 4942 <printf>
    exit(1);
    1836:	4505                	li	a0,1
    1838:	00003097          	auipc	ra,0x3
    183c:	d9c080e7          	jalr	-612(ra) # 45d4 <exit>
    1840:	e0ca                	sd	s2,64(sp)
    1842:	f852                	sd	s4,48(sp)
    1844:	f456                	sd	s5,40(sp)
    1846:	f05a                	sd	s6,32(sp)
    1848:	ec5e                	sd	s7,24(sp)
    close(fds[0]);
    184a:	fa842503          	lw	a0,-88(s0)
    184e:	00003097          	auipc	ra,0x3
    1852:	dae080e7          	jalr	-594(ra) # 45fc <close>
    for(n = 0; n < N; n++){
    1856:	00008b17          	auipc	s6,0x8
    185a:	bdab0b13          	addi	s6,s6,-1062 # 9430 <buf>
    185e:	416004bb          	negw	s1,s6
    1862:	0ff4f493          	zext.b	s1,s1
    1866:	409b0913          	addi	s2,s6,1033
      if(write(fds[1], buf, SZ) != SZ){
    186a:	40900a13          	li	s4,1033
    186e:	8bda                	mv	s7,s6
    for(n = 0; n < N; n++){
    1870:	6a85                	lui	s5,0x1
    1872:	42da8a93          	addi	s5,s5,1069 # 142d <unlinkread+0x193>
{
    1876:	87da                	mv	a5,s6
        buf[i] = seq++;
    1878:	0097873b          	addw	a4,a5,s1
    187c:	00e78023          	sb	a4,0(a5) # 3000 <subdir+0x570>
      for(i = 0; i < SZ; i++)
    1880:	0785                	addi	a5,a5,1
    1882:	ff279be3          	bne	a5,s2,1878 <pipe1+0xf6>
      if(write(fds[1], buf, SZ) != SZ){
    1886:	8652                	mv	a2,s4
    1888:	85de                	mv	a1,s7
    188a:	fac42503          	lw	a0,-84(s0)
    188e:	00003097          	auipc	ra,0x3
    1892:	d66080e7          	jalr	-666(ra) # 45f4 <write>
    1896:	01451e63          	bne	a0,s4,18b2 <pipe1+0x130>
    189a:	4099899b          	addiw	s3,s3,1033
    for(n = 0; n < N; n++){
    189e:	24a5                	addiw	s1,s1,9
    18a0:	0ff4f493          	zext.b	s1,s1
    18a4:	fd5999e3          	bne	s3,s5,1876 <pipe1+0xf4>
    exit(0);
    18a8:	4501                	li	a0,0
    18aa:	00003097          	auipc	ra,0x3
    18ae:	d2a080e7          	jalr	-726(ra) # 45d4 <exit>
        printf("%s: pipe1 oops 1\n", s);
    18b2:	85e2                	mv	a1,s8
    18b4:	00004517          	auipc	a0,0x4
    18b8:	d3c50513          	addi	a0,a0,-708 # 55f0 <malloc+0xbf2>
    18bc:	00003097          	auipc	ra,0x3
    18c0:	086080e7          	jalr	134(ra) # 4942 <printf>
        exit(1);
    18c4:	4505                	li	a0,1
    18c6:	00003097          	auipc	ra,0x3
    18ca:	d0e080e7          	jalr	-754(ra) # 45d4 <exit>
          printf("%s: pipe1 oops 2\n", s);
    18ce:	85e2                	mv	a1,s8
    18d0:	00004517          	auipc	a0,0x4
    18d4:	d3850513          	addi	a0,a0,-712 # 5608 <malloc+0xc0a>
    18d8:	00003097          	auipc	ra,0x3
    18dc:	06a080e7          	jalr	106(ra) # 4942 <printf>
          return;
    18e0:	64a6                	ld	s1,72(sp)
    18e2:	6906                	ld	s2,64(sp)
    18e4:	79e2                	ld	s3,56(sp)
    18e6:	7a42                	ld	s4,48(sp)
}
    18e8:	60e6                	ld	ra,88(sp)
    18ea:	6446                	ld	s0,80(sp)
    18ec:	6c42                	ld	s8,16(sp)
    18ee:	6125                	addi	sp,sp,96
    18f0:	8082                	ret
    if(total != N * SZ){
    18f2:	6785                	lui	a5,0x1
    18f4:	42d78793          	addi	a5,a5,1069 # 142d <unlinkread+0x193>
    18f8:	02f98363          	beq	s3,a5,191e <pipe1+0x19c>
    18fc:	f456                	sd	s5,40(sp)
    18fe:	f05a                	sd	s6,32(sp)
    1900:	ec5e                	sd	s7,24(sp)
      printf("%s: pipe1 oops 3 total %d\n", total);
    1902:	85ce                	mv	a1,s3
    1904:	00004517          	auipc	a0,0x4
    1908:	d1c50513          	addi	a0,a0,-740 # 5620 <malloc+0xc22>
    190c:	00003097          	auipc	ra,0x3
    1910:	036080e7          	jalr	54(ra) # 4942 <printf>
      exit(1);
    1914:	4505                	li	a0,1
    1916:	00003097          	auipc	ra,0x3
    191a:	cbe080e7          	jalr	-834(ra) # 45d4 <exit>
    191e:	f456                	sd	s5,40(sp)
    1920:	f05a                	sd	s6,32(sp)
    1922:	ec5e                	sd	s7,24(sp)
    close(fds[0]);
    1924:	fa842503          	lw	a0,-88(s0)
    1928:	00003097          	auipc	ra,0x3
    192c:	cd4080e7          	jalr	-812(ra) # 45fc <close>
    wait(&xstatus);
    1930:	fa440513          	addi	a0,s0,-92
    1934:	00003097          	auipc	ra,0x3
    1938:	ca8080e7          	jalr	-856(ra) # 45dc <wait>
    exit(xstatus);
    193c:	fa442503          	lw	a0,-92(s0)
    1940:	00003097          	auipc	ra,0x3
    1944:	c94080e7          	jalr	-876(ra) # 45d4 <exit>
    1948:	e0ca                	sd	s2,64(sp)
    194a:	f852                	sd	s4,48(sp)
    194c:	f456                	sd	s5,40(sp)
    194e:	f05a                	sd	s6,32(sp)
    1950:	ec5e                	sd	s7,24(sp)
    printf("%s: fork() failed\n", s);
    1952:	85e2                	mv	a1,s8
    1954:	00004517          	auipc	a0,0x4
    1958:	cec50513          	addi	a0,a0,-788 # 5640 <malloc+0xc42>
    195c:	00003097          	auipc	ra,0x3
    1960:	fe6080e7          	jalr	-26(ra) # 4942 <printf>
    exit(1);
    1964:	4505                	li	a0,1
    1966:	00003097          	auipc	ra,0x3
    196a:	c6e080e7          	jalr	-914(ra) # 45d4 <exit>

000000000000196e <pgbug>:
{
    196e:	7179                	addi	sp,sp,-48
    1970:	f406                	sd	ra,40(sp)
    1972:	f022                	sd	s0,32(sp)
    1974:	ec26                	sd	s1,24(sp)
    1976:	1800                	addi	s0,sp,48
  argv[0] = 0;
    1978:	fc043c23          	sd	zero,-40(s0)
  exec((char*)0xeaeb0b5b00002f5e, argv);
    197c:	eaeb14b7          	lui	s1,0xeaeb1
    1980:	b5b48493          	addi	s1,s1,-1189 # ffffffffeaeb0b5b <__BSS_END__+0xffffffffeaea471b>
    1984:	04d2                	slli	s1,s1,0x14
    1986:	048d                	addi	s1,s1,3
    1988:	04b2                	slli	s1,s1,0xc
    198a:	f5e48493          	addi	s1,s1,-162
    198e:	fd840593          	addi	a1,s0,-40
    1992:	8526                	mv	a0,s1
    1994:	00003097          	auipc	ra,0x3
    1998:	c78080e7          	jalr	-904(ra) # 460c <exec>
  pipe((int*)0xeaeb0b5b00002f5e);
    199c:	8526                	mv	a0,s1
    199e:	00003097          	auipc	ra,0x3
    19a2:	c46080e7          	jalr	-954(ra) # 45e4 <pipe>
  exit(0);
    19a6:	4501                	li	a0,0
    19a8:	00003097          	auipc	ra,0x3
    19ac:	c2c080e7          	jalr	-980(ra) # 45d4 <exit>

00000000000019b0 <preempt>:
{
    19b0:	7139                	addi	sp,sp,-64
    19b2:	fc06                	sd	ra,56(sp)
    19b4:	f822                	sd	s0,48(sp)
    19b6:	f426                	sd	s1,40(sp)
    19b8:	f04a                	sd	s2,32(sp)
    19ba:	ec4e                	sd	s3,24(sp)
    19bc:	e852                	sd	s4,16(sp)
    19be:	0080                	addi	s0,sp,64
    19c0:	892a                	mv	s2,a0
  pid1 = fork();
    19c2:	00003097          	auipc	ra,0x3
    19c6:	c0a080e7          	jalr	-1014(ra) # 45cc <fork>
  if(pid1 < 0) {
    19ca:	00054563          	bltz	a0,19d4 <preempt+0x24>
    19ce:	84aa                	mv	s1,a0
  if(pid1 == 0)
    19d0:	ed19                	bnez	a0,19ee <preempt+0x3e>
    for(;;)
    19d2:	a001                	j	19d2 <preempt+0x22>
    printf("%s: fork failed");
    19d4:	00003517          	auipc	a0,0x3
    19d8:	31c50513          	addi	a0,a0,796 # 4cf0 <malloc+0x2f2>
    19dc:	00003097          	auipc	ra,0x3
    19e0:	f66080e7          	jalr	-154(ra) # 4942 <printf>
    exit(1);
    19e4:	4505                	li	a0,1
    19e6:	00003097          	auipc	ra,0x3
    19ea:	bee080e7          	jalr	-1042(ra) # 45d4 <exit>
  pid2 = fork();
    19ee:	00003097          	auipc	ra,0x3
    19f2:	bde080e7          	jalr	-1058(ra) # 45cc <fork>
    19f6:	89aa                	mv	s3,a0
  if(pid2 < 0) {
    19f8:	00054463          	bltz	a0,1a00 <preempt+0x50>
  if(pid2 == 0)
    19fc:	e105                	bnez	a0,1a1c <preempt+0x6c>
    for(;;)
    19fe:	a001                	j	19fe <preempt+0x4e>
    printf("%s: fork failed\n", s);
    1a00:	85ca                	mv	a1,s2
    1a02:	00003517          	auipc	a0,0x3
    1a06:	28650513          	addi	a0,a0,646 # 4c88 <malloc+0x28a>
    1a0a:	00003097          	auipc	ra,0x3
    1a0e:	f38080e7          	jalr	-200(ra) # 4942 <printf>
    exit(1);
    1a12:	4505                	li	a0,1
    1a14:	00003097          	auipc	ra,0x3
    1a18:	bc0080e7          	jalr	-1088(ra) # 45d4 <exit>
  pipe(pfds);
    1a1c:	fc840513          	addi	a0,s0,-56
    1a20:	00003097          	auipc	ra,0x3
    1a24:	bc4080e7          	jalr	-1084(ra) # 45e4 <pipe>
  pid3 = fork();
    1a28:	00003097          	auipc	ra,0x3
    1a2c:	ba4080e7          	jalr	-1116(ra) # 45cc <fork>
    1a30:	8a2a                	mv	s4,a0
  if(pid3 < 0) {
    1a32:	02054e63          	bltz	a0,1a6e <preempt+0xbe>
  if(pid3 == 0){
    1a36:	e13d                	bnez	a0,1a9c <preempt+0xec>
    close(pfds[0]);
    1a38:	fc842503          	lw	a0,-56(s0)
    1a3c:	00003097          	auipc	ra,0x3
    1a40:	bc0080e7          	jalr	-1088(ra) # 45fc <close>
    if(write(pfds[1], "x", 1) != 1)
    1a44:	4605                	li	a2,1
    1a46:	00004597          	auipc	a1,0x4
    1a4a:	c1258593          	addi	a1,a1,-1006 # 5658 <malloc+0xc5a>
    1a4e:	fcc42503          	lw	a0,-52(s0)
    1a52:	00003097          	auipc	ra,0x3
    1a56:	ba2080e7          	jalr	-1118(ra) # 45f4 <write>
    1a5a:	4785                	li	a5,1
    1a5c:	02f51763          	bne	a0,a5,1a8a <preempt+0xda>
    close(pfds[1]);
    1a60:	fcc42503          	lw	a0,-52(s0)
    1a64:	00003097          	auipc	ra,0x3
    1a68:	b98080e7          	jalr	-1128(ra) # 45fc <close>
    for(;;)
    1a6c:	a001                	j	1a6c <preempt+0xbc>
     printf("%s: fork failed\n", s);
    1a6e:	85ca                	mv	a1,s2
    1a70:	00003517          	auipc	a0,0x3
    1a74:	21850513          	addi	a0,a0,536 # 4c88 <malloc+0x28a>
    1a78:	00003097          	auipc	ra,0x3
    1a7c:	eca080e7          	jalr	-310(ra) # 4942 <printf>
     exit(1);
    1a80:	4505                	li	a0,1
    1a82:	00003097          	auipc	ra,0x3
    1a86:	b52080e7          	jalr	-1198(ra) # 45d4 <exit>
      printf("%s: preempt write error");
    1a8a:	00004517          	auipc	a0,0x4
    1a8e:	bd650513          	addi	a0,a0,-1066 # 5660 <malloc+0xc62>
    1a92:	00003097          	auipc	ra,0x3
    1a96:	eb0080e7          	jalr	-336(ra) # 4942 <printf>
    1a9a:	b7d9                	j	1a60 <preempt+0xb0>
  close(pfds[1]);
    1a9c:	fcc42503          	lw	a0,-52(s0)
    1aa0:	00003097          	auipc	ra,0x3
    1aa4:	b5c080e7          	jalr	-1188(ra) # 45fc <close>
  if(read(pfds[0], buf, sizeof(buf)) != 1){
    1aa8:	660d                	lui	a2,0x3
    1aaa:	00008597          	auipc	a1,0x8
    1aae:	98658593          	addi	a1,a1,-1658 # 9430 <buf>
    1ab2:	fc842503          	lw	a0,-56(s0)
    1ab6:	00003097          	auipc	ra,0x3
    1aba:	b36080e7          	jalr	-1226(ra) # 45ec <read>
    1abe:	4785                	li	a5,1
    1ac0:	02f50263          	beq	a0,a5,1ae4 <preempt+0x134>
    printf("%s: preempt read error");
    1ac4:	00004517          	auipc	a0,0x4
    1ac8:	bb450513          	addi	a0,a0,-1100 # 5678 <malloc+0xc7a>
    1acc:	00003097          	auipc	ra,0x3
    1ad0:	e76080e7          	jalr	-394(ra) # 4942 <printf>
}
    1ad4:	70e2                	ld	ra,56(sp)
    1ad6:	7442                	ld	s0,48(sp)
    1ad8:	74a2                	ld	s1,40(sp)
    1ada:	7902                	ld	s2,32(sp)
    1adc:	69e2                	ld	s3,24(sp)
    1ade:	6a42                	ld	s4,16(sp)
    1ae0:	6121                	addi	sp,sp,64
    1ae2:	8082                	ret
  close(pfds[0]);
    1ae4:	fc842503          	lw	a0,-56(s0)
    1ae8:	00003097          	auipc	ra,0x3
    1aec:	b14080e7          	jalr	-1260(ra) # 45fc <close>
  printf("kill... ");
    1af0:	00004517          	auipc	a0,0x4
    1af4:	ba050513          	addi	a0,a0,-1120 # 5690 <malloc+0xc92>
    1af8:	00003097          	auipc	ra,0x3
    1afc:	e4a080e7          	jalr	-438(ra) # 4942 <printf>
  kill(pid1);
    1b00:	8526                	mv	a0,s1
    1b02:	00003097          	auipc	ra,0x3
    1b06:	b02080e7          	jalr	-1278(ra) # 4604 <kill>
  kill(pid2);
    1b0a:	854e                	mv	a0,s3
    1b0c:	00003097          	auipc	ra,0x3
    1b10:	af8080e7          	jalr	-1288(ra) # 4604 <kill>
  kill(pid3);
    1b14:	8552                	mv	a0,s4
    1b16:	00003097          	auipc	ra,0x3
    1b1a:	aee080e7          	jalr	-1298(ra) # 4604 <kill>
  printf("wait... ");
    1b1e:	00004517          	auipc	a0,0x4
    1b22:	b8250513          	addi	a0,a0,-1150 # 56a0 <malloc+0xca2>
    1b26:	00003097          	auipc	ra,0x3
    1b2a:	e1c080e7          	jalr	-484(ra) # 4942 <printf>
  wait(0);
    1b2e:	4501                	li	a0,0
    1b30:	00003097          	auipc	ra,0x3
    1b34:	aac080e7          	jalr	-1364(ra) # 45dc <wait>
  wait(0);
    1b38:	4501                	li	a0,0
    1b3a:	00003097          	auipc	ra,0x3
    1b3e:	aa2080e7          	jalr	-1374(ra) # 45dc <wait>
  wait(0);
    1b42:	4501                	li	a0,0
    1b44:	00003097          	auipc	ra,0x3
    1b48:	a98080e7          	jalr	-1384(ra) # 45dc <wait>
    1b4c:	b761                	j	1ad4 <preempt+0x124>

0000000000001b4e <reparent>:
{
    1b4e:	7179                	addi	sp,sp,-48
    1b50:	f406                	sd	ra,40(sp)
    1b52:	f022                	sd	s0,32(sp)
    1b54:	ec26                	sd	s1,24(sp)
    1b56:	e84a                	sd	s2,16(sp)
    1b58:	e44e                	sd	s3,8(sp)
    1b5a:	e052                	sd	s4,0(sp)
    1b5c:	1800                	addi	s0,sp,48
    1b5e:	89aa                	mv	s3,a0
  int master_pid = getpid();
    1b60:	00003097          	auipc	ra,0x3
    1b64:	af4080e7          	jalr	-1292(ra) # 4654 <getpid>
    1b68:	8a2a                	mv	s4,a0
    1b6a:	0c800913          	li	s2,200
    int pid = fork();
    1b6e:	00003097          	auipc	ra,0x3
    1b72:	a5e080e7          	jalr	-1442(ra) # 45cc <fork>
    1b76:	84aa                	mv	s1,a0
    if(pid < 0){
    1b78:	02054263          	bltz	a0,1b9c <reparent+0x4e>
    if(pid){
    1b7c:	cd21                	beqz	a0,1bd4 <reparent+0x86>
      if(wait(0) != pid){
    1b7e:	4501                	li	a0,0
    1b80:	00003097          	auipc	ra,0x3
    1b84:	a5c080e7          	jalr	-1444(ra) # 45dc <wait>
    1b88:	02951863          	bne	a0,s1,1bb8 <reparent+0x6a>
  for(int i = 0; i < 200; i++){
    1b8c:	397d                	addiw	s2,s2,-1
    1b8e:	fe0910e3          	bnez	s2,1b6e <reparent+0x20>
  exit(0);
    1b92:	4501                	li	a0,0
    1b94:	00003097          	auipc	ra,0x3
    1b98:	a40080e7          	jalr	-1472(ra) # 45d4 <exit>
      printf("%s: fork failed\n", s);
    1b9c:	85ce                	mv	a1,s3
    1b9e:	00003517          	auipc	a0,0x3
    1ba2:	0ea50513          	addi	a0,a0,234 # 4c88 <malloc+0x28a>
    1ba6:	00003097          	auipc	ra,0x3
    1baa:	d9c080e7          	jalr	-612(ra) # 4942 <printf>
      exit(1);
    1bae:	4505                	li	a0,1
    1bb0:	00003097          	auipc	ra,0x3
    1bb4:	a24080e7          	jalr	-1500(ra) # 45d4 <exit>
        printf("%s: wait wrong pid\n", s);
    1bb8:	85ce                	mv	a1,s3
    1bba:	00003517          	auipc	a0,0x3
    1bbe:	0fe50513          	addi	a0,a0,254 # 4cb8 <malloc+0x2ba>
    1bc2:	00003097          	auipc	ra,0x3
    1bc6:	d80080e7          	jalr	-640(ra) # 4942 <printf>
        exit(1);
    1bca:	4505                	li	a0,1
    1bcc:	00003097          	auipc	ra,0x3
    1bd0:	a08080e7          	jalr	-1528(ra) # 45d4 <exit>
      int pid2 = fork();
    1bd4:	00003097          	auipc	ra,0x3
    1bd8:	9f8080e7          	jalr	-1544(ra) # 45cc <fork>
      if(pid2 < 0){
    1bdc:	00054763          	bltz	a0,1bea <reparent+0x9c>
      exit(0);
    1be0:	4501                	li	a0,0
    1be2:	00003097          	auipc	ra,0x3
    1be6:	9f2080e7          	jalr	-1550(ra) # 45d4 <exit>
        kill(master_pid);
    1bea:	8552                	mv	a0,s4
    1bec:	00003097          	auipc	ra,0x3
    1bf0:	a18080e7          	jalr	-1512(ra) # 4604 <kill>
        exit(1);
    1bf4:	4505                	li	a0,1
    1bf6:	00003097          	auipc	ra,0x3
    1bfa:	9de080e7          	jalr	-1570(ra) # 45d4 <exit>

0000000000001bfe <mem>:
{
    1bfe:	7139                	addi	sp,sp,-64
    1c00:	fc06                	sd	ra,56(sp)
    1c02:	f822                	sd	s0,48(sp)
    1c04:	f426                	sd	s1,40(sp)
    1c06:	f04a                	sd	s2,32(sp)
    1c08:	ec4e                	sd	s3,24(sp)
    1c0a:	0080                	addi	s0,sp,64
    1c0c:	89aa                	mv	s3,a0
  if((pid = fork()) == 0){
    1c0e:	00003097          	auipc	ra,0x3
    1c12:	9be080e7          	jalr	-1602(ra) # 45cc <fork>
    m1 = 0;
    1c16:	4481                	li	s1,0
    while((m2 = malloc(10001)) != 0){
    1c18:	6909                	lui	s2,0x2
    1c1a:	71190913          	addi	s2,s2,1809 # 2711 <concreate+0x267>
  if((pid = fork()) == 0){
    1c1e:	cd19                	beqz	a0,1c3c <mem+0x3e>
    wait(&xstatus);
    1c20:	fcc40513          	addi	a0,s0,-52
    1c24:	00003097          	auipc	ra,0x3
    1c28:	9b8080e7          	jalr	-1608(ra) # 45dc <wait>
    exit(xstatus);
    1c2c:	fcc42503          	lw	a0,-52(s0)
    1c30:	00003097          	auipc	ra,0x3
    1c34:	9a4080e7          	jalr	-1628(ra) # 45d4 <exit>
      *(char**)m2 = m1;
    1c38:	e104                	sd	s1,0(a0)
      m1 = m2;
    1c3a:	84aa                	mv	s1,a0
    while((m2 = malloc(10001)) != 0){
    1c3c:	854a                	mv	a0,s2
    1c3e:	00003097          	auipc	ra,0x3
    1c42:	dc0080e7          	jalr	-576(ra) # 49fe <malloc>
    1c46:	f96d                	bnez	a0,1c38 <mem+0x3a>
    while(m1){
    1c48:	c881                	beqz	s1,1c58 <mem+0x5a>
      m2 = *(char**)m1;
    1c4a:	8526                	mv	a0,s1
    1c4c:	6084                	ld	s1,0(s1)
      free(m1);
    1c4e:	00003097          	auipc	ra,0x3
    1c52:	d2a080e7          	jalr	-726(ra) # 4978 <free>
    while(m1){
    1c56:	f8f5                	bnez	s1,1c4a <mem+0x4c>
    m1 = malloc(1024*20);
    1c58:	6515                	lui	a0,0x5
    1c5a:	00003097          	auipc	ra,0x3
    1c5e:	da4080e7          	jalr	-604(ra) # 49fe <malloc>
    if(m1 == 0){
    1c62:	c911                	beqz	a0,1c76 <mem+0x78>
    free(m1);
    1c64:	00003097          	auipc	ra,0x3
    1c68:	d14080e7          	jalr	-748(ra) # 4978 <free>
    exit(0);
    1c6c:	4501                	li	a0,0
    1c6e:	00003097          	auipc	ra,0x3
    1c72:	966080e7          	jalr	-1690(ra) # 45d4 <exit>
      printf("couldn't allocate mem?!!\n", s);
    1c76:	85ce                	mv	a1,s3
    1c78:	00004517          	auipc	a0,0x4
    1c7c:	a3850513          	addi	a0,a0,-1480 # 56b0 <malloc+0xcb2>
    1c80:	00003097          	auipc	ra,0x3
    1c84:	cc2080e7          	jalr	-830(ra) # 4942 <printf>
      exit(1);
    1c88:	4505                	li	a0,1
    1c8a:	00003097          	auipc	ra,0x3
    1c8e:	94a080e7          	jalr	-1718(ra) # 45d4 <exit>

0000000000001c92 <sharedfd>:
{
    1c92:	7159                	addi	sp,sp,-112
    1c94:	f486                	sd	ra,104(sp)
    1c96:	f0a2                	sd	s0,96(sp)
    1c98:	eca6                	sd	s1,88(sp)
    1c9a:	f85a                	sd	s6,48(sp)
    1c9c:	1880                	addi	s0,sp,112
    1c9e:	84aa                	mv	s1,a0
    1ca0:	8b2a                	mv	s6,a0
  unlink("sharedfd");
    1ca2:	00004517          	auipc	a0,0x4
    1ca6:	a2e50513          	addi	a0,a0,-1490 # 56d0 <malloc+0xcd2>
    1caa:	00003097          	auipc	ra,0x3
    1cae:	97a080e7          	jalr	-1670(ra) # 4624 <unlink>
  fd = open("sharedfd", O_CREATE|O_RDWR);
    1cb2:	20200593          	li	a1,514
    1cb6:	00004517          	auipc	a0,0x4
    1cba:	a1a50513          	addi	a0,a0,-1510 # 56d0 <malloc+0xcd2>
    1cbe:	00003097          	auipc	ra,0x3
    1cc2:	956080e7          	jalr	-1706(ra) # 4614 <open>
  if(fd < 0){
    1cc6:	06054063          	bltz	a0,1d26 <sharedfd+0x94>
    1cca:	e8ca                	sd	s2,80(sp)
    1ccc:	e4ce                	sd	s3,72(sp)
    1cce:	e0d2                	sd	s4,64(sp)
    1cd0:	fc56                	sd	s5,56(sp)
    1cd2:	89aa                	mv	s3,a0
  pid = fork();
    1cd4:	00003097          	auipc	ra,0x3
    1cd8:	8f8080e7          	jalr	-1800(ra) # 45cc <fork>
    1cdc:	8aaa                	mv	s5,a0
  memset(buf, pid==0?'c':'p', sizeof(buf));
    1cde:	07000593          	li	a1,112
    1ce2:	e119                	bnez	a0,1ce8 <sharedfd+0x56>
    1ce4:	06300593          	li	a1,99
    1ce8:	4629                	li	a2,10
    1cea:	fa040513          	addi	a0,s0,-96
    1cee:	00002097          	auipc	ra,0x2
    1cf2:	6d4080e7          	jalr	1748(ra) # 43c2 <memset>
    1cf6:	3e800493          	li	s1,1000
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
    1cfa:	fa040a13          	addi	s4,s0,-96
    1cfe:	4929                	li	s2,10
    1d00:	864a                	mv	a2,s2
    1d02:	85d2                	mv	a1,s4
    1d04:	854e                	mv	a0,s3
    1d06:	00003097          	auipc	ra,0x3
    1d0a:	8ee080e7          	jalr	-1810(ra) # 45f4 <write>
    1d0e:	03251f63          	bne	a0,s2,1d4c <sharedfd+0xba>
  for(i = 0; i < N; i++){
    1d12:	34fd                	addiw	s1,s1,-1
    1d14:	f4f5                	bnez	s1,1d00 <sharedfd+0x6e>
  if(pid == 0) {
    1d16:	040a9a63          	bnez	s5,1d6a <sharedfd+0xd8>
    1d1a:	f45e                	sd	s7,40(sp)
    exit(0);
    1d1c:	4501                	li	a0,0
    1d1e:	00003097          	auipc	ra,0x3
    1d22:	8b6080e7          	jalr	-1866(ra) # 45d4 <exit>
    1d26:	e8ca                	sd	s2,80(sp)
    1d28:	e4ce                	sd	s3,72(sp)
    1d2a:	e0d2                	sd	s4,64(sp)
    1d2c:	fc56                	sd	s5,56(sp)
    1d2e:	f45e                	sd	s7,40(sp)
    printf("%s: cannot open sharedfd for writing", s);
    1d30:	85a6                	mv	a1,s1
    1d32:	00004517          	auipc	a0,0x4
    1d36:	9ae50513          	addi	a0,a0,-1618 # 56e0 <malloc+0xce2>
    1d3a:	00003097          	auipc	ra,0x3
    1d3e:	c08080e7          	jalr	-1016(ra) # 4942 <printf>
    exit(1);
    1d42:	4505                	li	a0,1
    1d44:	00003097          	auipc	ra,0x3
    1d48:	890080e7          	jalr	-1904(ra) # 45d4 <exit>
    1d4c:	f45e                	sd	s7,40(sp)
      printf("%s: write sharedfd failed\n", s);
    1d4e:	85da                	mv	a1,s6
    1d50:	00004517          	auipc	a0,0x4
    1d54:	9b850513          	addi	a0,a0,-1608 # 5708 <malloc+0xd0a>
    1d58:	00003097          	auipc	ra,0x3
    1d5c:	bea080e7          	jalr	-1046(ra) # 4942 <printf>
      exit(1);
    1d60:	4505                	li	a0,1
    1d62:	00003097          	auipc	ra,0x3
    1d66:	872080e7          	jalr	-1934(ra) # 45d4 <exit>
    wait(&xstatus);
    1d6a:	f9c40513          	addi	a0,s0,-100
    1d6e:	00003097          	auipc	ra,0x3
    1d72:	86e080e7          	jalr	-1938(ra) # 45dc <wait>
    if(xstatus != 0)
    1d76:	f9c42a03          	lw	s4,-100(s0)
    1d7a:	000a0863          	beqz	s4,1d8a <sharedfd+0xf8>
    1d7e:	f45e                	sd	s7,40(sp)
      exit(xstatus);
    1d80:	8552                	mv	a0,s4
    1d82:	00003097          	auipc	ra,0x3
    1d86:	852080e7          	jalr	-1966(ra) # 45d4 <exit>
    1d8a:	f45e                	sd	s7,40(sp)
  close(fd);
    1d8c:	854e                	mv	a0,s3
    1d8e:	00003097          	auipc	ra,0x3
    1d92:	86e080e7          	jalr	-1938(ra) # 45fc <close>
  fd = open("sharedfd", 0);
    1d96:	4581                	li	a1,0
    1d98:	00004517          	auipc	a0,0x4
    1d9c:	93850513          	addi	a0,a0,-1736 # 56d0 <malloc+0xcd2>
    1da0:	00003097          	auipc	ra,0x3
    1da4:	874080e7          	jalr	-1932(ra) # 4614 <open>
    1da8:	8baa                	mv	s7,a0
  nc = np = 0;
    1daa:	89d2                	mv	s3,s4
  if(fd < 0){
    1dac:	02054563          	bltz	a0,1dd6 <sharedfd+0x144>
    1db0:	faa40913          	addi	s2,s0,-86
      if(buf[i] == 'c')
    1db4:	06300493          	li	s1,99
      if(buf[i] == 'p')
    1db8:	07000a93          	li	s5,112
  while((n = read(fd, buf, sizeof(buf))) > 0){
    1dbc:	4629                	li	a2,10
    1dbe:	fa040593          	addi	a1,s0,-96
    1dc2:	855e                	mv	a0,s7
    1dc4:	00003097          	auipc	ra,0x3
    1dc8:	828080e7          	jalr	-2008(ra) # 45ec <read>
    1dcc:	02a05f63          	blez	a0,1e0a <sharedfd+0x178>
    1dd0:	fa040793          	addi	a5,s0,-96
    1dd4:	a01d                	j	1dfa <sharedfd+0x168>
    printf("%s: cannot open sharedfd for reading\n", s);
    1dd6:	85da                	mv	a1,s6
    1dd8:	00004517          	auipc	a0,0x4
    1ddc:	95050513          	addi	a0,a0,-1712 # 5728 <malloc+0xd2a>
    1de0:	00003097          	auipc	ra,0x3
    1de4:	b62080e7          	jalr	-1182(ra) # 4942 <printf>
    exit(1);
    1de8:	4505                	li	a0,1
    1dea:	00002097          	auipc	ra,0x2
    1dee:	7ea080e7          	jalr	2026(ra) # 45d4 <exit>
        nc++;
    1df2:	2a05                	addiw	s4,s4,1
    for(i = 0; i < sizeof(buf); i++){
    1df4:	0785                	addi	a5,a5,1
    1df6:	fd2783e3          	beq	a5,s2,1dbc <sharedfd+0x12a>
      if(buf[i] == 'c')
    1dfa:	0007c703          	lbu	a4,0(a5)
    1dfe:	fe970ae3          	beq	a4,s1,1df2 <sharedfd+0x160>
      if(buf[i] == 'p')
    1e02:	ff5719e3          	bne	a4,s5,1df4 <sharedfd+0x162>
        np++;
    1e06:	2985                	addiw	s3,s3,1
    1e08:	b7f5                	j	1df4 <sharedfd+0x162>
  close(fd);
    1e0a:	855e                	mv	a0,s7
    1e0c:	00002097          	auipc	ra,0x2
    1e10:	7f0080e7          	jalr	2032(ra) # 45fc <close>
  unlink("sharedfd");
    1e14:	00004517          	auipc	a0,0x4
    1e18:	8bc50513          	addi	a0,a0,-1860 # 56d0 <malloc+0xcd2>
    1e1c:	00003097          	auipc	ra,0x3
    1e20:	808080e7          	jalr	-2040(ra) # 4624 <unlink>
  if(nc == N*SZ && np == N*SZ){
    1e24:	6789                	lui	a5,0x2
    1e26:	71078793          	addi	a5,a5,1808 # 2710 <concreate+0x266>
    1e2a:	00fa1963          	bne	s4,a5,1e3c <sharedfd+0x1aa>
    1e2e:	01499763          	bne	s3,s4,1e3c <sharedfd+0x1aa>
    exit(0);
    1e32:	4501                	li	a0,0
    1e34:	00002097          	auipc	ra,0x2
    1e38:	7a0080e7          	jalr	1952(ra) # 45d4 <exit>
    printf("%s: nc/np test fails\n", s);
    1e3c:	85da                	mv	a1,s6
    1e3e:	00004517          	auipc	a0,0x4
    1e42:	91250513          	addi	a0,a0,-1774 # 5750 <malloc+0xd52>
    1e46:	00003097          	auipc	ra,0x3
    1e4a:	afc080e7          	jalr	-1284(ra) # 4942 <printf>
    exit(1);
    1e4e:	4505                	li	a0,1
    1e50:	00002097          	auipc	ra,0x2
    1e54:	784080e7          	jalr	1924(ra) # 45d4 <exit>

0000000000001e58 <fourfiles>:
{
    1e58:	7135                	addi	sp,sp,-160
    1e5a:	ed06                	sd	ra,152(sp)
    1e5c:	e922                	sd	s0,144(sp)
    1e5e:	e526                	sd	s1,136(sp)
    1e60:	e14a                	sd	s2,128(sp)
    1e62:	fcce                	sd	s3,120(sp)
    1e64:	f8d2                	sd	s4,112(sp)
    1e66:	f4d6                	sd	s5,104(sp)
    1e68:	f0da                	sd	s6,96(sp)
    1e6a:	ecde                	sd	s7,88(sp)
    1e6c:	e8e2                	sd	s8,80(sp)
    1e6e:	e4e6                	sd	s9,72(sp)
    1e70:	e0ea                	sd	s10,64(sp)
    1e72:	fc6e                	sd	s11,56(sp)
    1e74:	1100                	addi	s0,sp,160
    1e76:	8caa                	mv	s9,a0
  char *names[] = { "f0", "f1", "f2", "f3" };
    1e78:	00004797          	auipc	a5,0x4
    1e7c:	8f078793          	addi	a5,a5,-1808 # 5768 <malloc+0xd6a>
    1e80:	f6f43823          	sd	a5,-144(s0)
    1e84:	00004797          	auipc	a5,0x4
    1e88:	8ec78793          	addi	a5,a5,-1812 # 5770 <malloc+0xd72>
    1e8c:	f6f43c23          	sd	a5,-136(s0)
    1e90:	00004797          	auipc	a5,0x4
    1e94:	8e878793          	addi	a5,a5,-1816 # 5778 <malloc+0xd7a>
    1e98:	f8f43023          	sd	a5,-128(s0)
    1e9c:	00004797          	auipc	a5,0x4
    1ea0:	8e478793          	addi	a5,a5,-1820 # 5780 <malloc+0xd82>
    1ea4:	f8f43423          	sd	a5,-120(s0)
  for(pi = 0; pi < NCHILD; pi++){
    1ea8:	f7040b93          	addi	s7,s0,-144
  char *names[] = { "f0", "f1", "f2", "f3" };
    1eac:	895e                	mv	s2,s7
  for(pi = 0; pi < NCHILD; pi++){
    1eae:	4481                	li	s1,0
    1eb0:	4a11                	li	s4,4
    fname = names[pi];
    1eb2:	00093983          	ld	s3,0(s2)
    unlink(fname);
    1eb6:	854e                	mv	a0,s3
    1eb8:	00002097          	auipc	ra,0x2
    1ebc:	76c080e7          	jalr	1900(ra) # 4624 <unlink>
    pid = fork();
    1ec0:	00002097          	auipc	ra,0x2
    1ec4:	70c080e7          	jalr	1804(ra) # 45cc <fork>
    if(pid < 0){
    1ec8:	04054263          	bltz	a0,1f0c <fourfiles+0xb4>
    if(pid == 0){
    1ecc:	cd31                	beqz	a0,1f28 <fourfiles+0xd0>
  for(pi = 0; pi < NCHILD; pi++){
    1ece:	2485                	addiw	s1,s1,1
    1ed0:	0921                	addi	s2,s2,8
    1ed2:	ff4490e3          	bne	s1,s4,1eb2 <fourfiles+0x5a>
    1ed6:	4491                	li	s1,4
    wait(&xstatus);
    1ed8:	f6c40913          	addi	s2,s0,-148
    1edc:	854a                	mv	a0,s2
    1ede:	00002097          	auipc	ra,0x2
    1ee2:	6fe080e7          	jalr	1790(ra) # 45dc <wait>
    if(xstatus != 0)
    1ee6:	f6c42b03          	lw	s6,-148(s0)
    1eea:	0c0b1863          	bnez	s6,1fba <fourfiles+0x162>
  for(pi = 0; pi < NCHILD; pi++){
    1eee:	34fd                	addiw	s1,s1,-1
    1ef0:	f4f5                	bnez	s1,1edc <fourfiles+0x84>
    1ef2:	03000493          	li	s1,48
    while((n = read(fd, buf, sizeof(buf))) > 0){
    1ef6:	6a8d                	lui	s5,0x3
    1ef8:	00007a17          	auipc	s4,0x7
    1efc:	538a0a13          	addi	s4,s4,1336 # 9430 <buf>
    if(total != N*SZ){
    1f00:	6d05                	lui	s10,0x1
    1f02:	770d0d13          	addi	s10,s10,1904 # 1770 <badarg+0x38>
  for(i = 0; i < NCHILD; i++){
    1f06:	03400d93          	li	s11,52
    1f0a:	a8dd                	j	2000 <fourfiles+0x1a8>
      printf("fork failed\n", s);
    1f0c:	85e6                	mv	a1,s9
    1f0e:	00003517          	auipc	a0,0x3
    1f12:	69a50513          	addi	a0,a0,1690 # 55a8 <malloc+0xbaa>
    1f16:	00003097          	auipc	ra,0x3
    1f1a:	a2c080e7          	jalr	-1492(ra) # 4942 <printf>
      exit(1);
    1f1e:	4505                	li	a0,1
    1f20:	00002097          	auipc	ra,0x2
    1f24:	6b4080e7          	jalr	1716(ra) # 45d4 <exit>
      fd = open(fname, O_CREATE | O_RDWR);
    1f28:	20200593          	li	a1,514
    1f2c:	854e                	mv	a0,s3
    1f2e:	00002097          	auipc	ra,0x2
    1f32:	6e6080e7          	jalr	1766(ra) # 4614 <open>
    1f36:	892a                	mv	s2,a0
      if(fd < 0){
    1f38:	04054663          	bltz	a0,1f84 <fourfiles+0x12c>
      memset(buf, '0'+pi, SZ);
    1f3c:	1f400613          	li	a2,500
    1f40:	0304859b          	addiw	a1,s1,48
    1f44:	00007517          	auipc	a0,0x7
    1f48:	4ec50513          	addi	a0,a0,1260 # 9430 <buf>
    1f4c:	00002097          	auipc	ra,0x2
    1f50:	476080e7          	jalr	1142(ra) # 43c2 <memset>
    1f54:	44b1                	li	s1,12
        if((n = write(fd, buf, SZ)) != SZ){
    1f56:	1f400993          	li	s3,500
    1f5a:	00007a17          	auipc	s4,0x7
    1f5e:	4d6a0a13          	addi	s4,s4,1238 # 9430 <buf>
    1f62:	864e                	mv	a2,s3
    1f64:	85d2                	mv	a1,s4
    1f66:	854a                	mv	a0,s2
    1f68:	00002097          	auipc	ra,0x2
    1f6c:	68c080e7          	jalr	1676(ra) # 45f4 <write>
    1f70:	85aa                	mv	a1,a0
    1f72:	03351763          	bne	a0,s3,1fa0 <fourfiles+0x148>
      for(i = 0; i < N; i++){
    1f76:	34fd                	addiw	s1,s1,-1
    1f78:	f4ed                	bnez	s1,1f62 <fourfiles+0x10a>
      exit(0);
    1f7a:	4501                	li	a0,0
    1f7c:	00002097          	auipc	ra,0x2
    1f80:	658080e7          	jalr	1624(ra) # 45d4 <exit>
        printf("create failed\n", s);
    1f84:	85e6                	mv	a1,s9
    1f86:	00004517          	auipc	a0,0x4
    1f8a:	80250513          	addi	a0,a0,-2046 # 5788 <malloc+0xd8a>
    1f8e:	00003097          	auipc	ra,0x3
    1f92:	9b4080e7          	jalr	-1612(ra) # 4942 <printf>
        exit(1);
    1f96:	4505                	li	a0,1
    1f98:	00002097          	auipc	ra,0x2
    1f9c:	63c080e7          	jalr	1596(ra) # 45d4 <exit>
          printf("write failed %d\n", n);
    1fa0:	00003517          	auipc	a0,0x3
    1fa4:	7f850513          	addi	a0,a0,2040 # 5798 <malloc+0xd9a>
    1fa8:	00003097          	auipc	ra,0x3
    1fac:	99a080e7          	jalr	-1638(ra) # 4942 <printf>
          exit(1);
    1fb0:	4505                	li	a0,1
    1fb2:	00002097          	auipc	ra,0x2
    1fb6:	622080e7          	jalr	1570(ra) # 45d4 <exit>
      exit(xstatus);
    1fba:	855a                	mv	a0,s6
    1fbc:	00002097          	auipc	ra,0x2
    1fc0:	618080e7          	jalr	1560(ra) # 45d4 <exit>
          printf("wrong char\n", s);
    1fc4:	85e6                	mv	a1,s9
    1fc6:	00003517          	auipc	a0,0x3
    1fca:	7ea50513          	addi	a0,a0,2026 # 57b0 <malloc+0xdb2>
    1fce:	00003097          	auipc	ra,0x3
    1fd2:	974080e7          	jalr	-1676(ra) # 4942 <printf>
          exit(1);
    1fd6:	4505                	li	a0,1
    1fd8:	00002097          	auipc	ra,0x2
    1fdc:	5fc080e7          	jalr	1532(ra) # 45d4 <exit>
    close(fd);
    1fe0:	854e                	mv	a0,s3
    1fe2:	00002097          	auipc	ra,0x2
    1fe6:	61a080e7          	jalr	1562(ra) # 45fc <close>
    if(total != N*SZ){
    1fea:	05a91e63          	bne	s2,s10,2046 <fourfiles+0x1ee>
    unlink(fname);
    1fee:	8562                	mv	a0,s8
    1ff0:	00002097          	auipc	ra,0x2
    1ff4:	634080e7          	jalr	1588(ra) # 4624 <unlink>
  for(i = 0; i < NCHILD; i++){
    1ff8:	0ba1                	addi	s7,s7,8
    1ffa:	2485                	addiw	s1,s1,1
    1ffc:	07b48363          	beq	s1,s11,2062 <fourfiles+0x20a>
    fname = names[i];
    2000:	000bbc03          	ld	s8,0(s7)
    fd = open(fname, 0);
    2004:	4581                	li	a1,0
    2006:	8562                	mv	a0,s8
    2008:	00002097          	auipc	ra,0x2
    200c:	60c080e7          	jalr	1548(ra) # 4614 <open>
    2010:	89aa                	mv	s3,a0
    total = 0;
    2012:	895a                	mv	s2,s6
    while((n = read(fd, buf, sizeof(buf))) > 0){
    2014:	8656                	mv	a2,s5
    2016:	85d2                	mv	a1,s4
    2018:	854e                	mv	a0,s3
    201a:	00002097          	auipc	ra,0x2
    201e:	5d2080e7          	jalr	1490(ra) # 45ec <read>
    2022:	faa05fe3          	blez	a0,1fe0 <fourfiles+0x188>
    2026:	00007797          	auipc	a5,0x7
    202a:	40a78793          	addi	a5,a5,1034 # 9430 <buf>
    202e:	00f506b3          	add	a3,a0,a5
        if(buf[j] != '0'+i){
    2032:	0007c703          	lbu	a4,0(a5)
    2036:	f89717e3          	bne	a4,s1,1fc4 <fourfiles+0x16c>
      for(j = 0; j < n; j++){
    203a:	0785                	addi	a5,a5,1
    203c:	fed79be3          	bne	a5,a3,2032 <fourfiles+0x1da>
      total += n;
    2040:	00a9093b          	addw	s2,s2,a0
    2044:	bfc1                	j	2014 <fourfiles+0x1bc>
      printf("wrong length %d\n", total);
    2046:	85ca                	mv	a1,s2
    2048:	00003517          	auipc	a0,0x3
    204c:	77850513          	addi	a0,a0,1912 # 57c0 <malloc+0xdc2>
    2050:	00003097          	auipc	ra,0x3
    2054:	8f2080e7          	jalr	-1806(ra) # 4942 <printf>
      exit(1);
    2058:	4505                	li	a0,1
    205a:	00002097          	auipc	ra,0x2
    205e:	57a080e7          	jalr	1402(ra) # 45d4 <exit>
}
    2062:	60ea                	ld	ra,152(sp)
    2064:	644a                	ld	s0,144(sp)
    2066:	64aa                	ld	s1,136(sp)
    2068:	690a                	ld	s2,128(sp)
    206a:	79e6                	ld	s3,120(sp)
    206c:	7a46                	ld	s4,112(sp)
    206e:	7aa6                	ld	s5,104(sp)
    2070:	7b06                	ld	s6,96(sp)
    2072:	6be6                	ld	s7,88(sp)
    2074:	6c46                	ld	s8,80(sp)
    2076:	6ca6                	ld	s9,72(sp)
    2078:	6d06                	ld	s10,64(sp)
    207a:	7de2                	ld	s11,56(sp)
    207c:	610d                	addi	sp,sp,160
    207e:	8082                	ret

0000000000002080 <bigfile>:
{
    2080:	7139                	addi	sp,sp,-64
    2082:	fc06                	sd	ra,56(sp)
    2084:	f822                	sd	s0,48(sp)
    2086:	f426                	sd	s1,40(sp)
    2088:	f04a                	sd	s2,32(sp)
    208a:	ec4e                	sd	s3,24(sp)
    208c:	e852                	sd	s4,16(sp)
    208e:	e456                	sd	s5,8(sp)
    2090:	e05a                	sd	s6,0(sp)
    2092:	0080                	addi	s0,sp,64
    2094:	8b2a                	mv	s6,a0
  unlink("bigfile.test");
    2096:	00003517          	auipc	a0,0x3
    209a:	74250513          	addi	a0,a0,1858 # 57d8 <malloc+0xdda>
    209e:	00002097          	auipc	ra,0x2
    20a2:	586080e7          	jalr	1414(ra) # 4624 <unlink>
  fd = open("bigfile.test", O_CREATE | O_RDWR);
    20a6:	20200593          	li	a1,514
    20aa:	00003517          	auipc	a0,0x3
    20ae:	72e50513          	addi	a0,a0,1838 # 57d8 <malloc+0xdda>
    20b2:	00002097          	auipc	ra,0x2
    20b6:	562080e7          	jalr	1378(ra) # 4614 <open>
  if(fd < 0){
    20ba:	0a054463          	bltz	a0,2162 <bigfile+0xe2>
    20be:	8a2a                	mv	s4,a0
    20c0:	4481                	li	s1,0
    memset(buf, i, SZ);
    20c2:	25800913          	li	s2,600
    20c6:	00007997          	auipc	s3,0x7
    20ca:	36a98993          	addi	s3,s3,874 # 9430 <buf>
  for(i = 0; i < N; i++){
    20ce:	4ad1                	li	s5,20
    memset(buf, i, SZ);
    20d0:	864a                	mv	a2,s2
    20d2:	85a6                	mv	a1,s1
    20d4:	854e                	mv	a0,s3
    20d6:	00002097          	auipc	ra,0x2
    20da:	2ec080e7          	jalr	748(ra) # 43c2 <memset>
    if(write(fd, buf, SZ) != SZ){
    20de:	864a                	mv	a2,s2
    20e0:	85ce                	mv	a1,s3
    20e2:	8552                	mv	a0,s4
    20e4:	00002097          	auipc	ra,0x2
    20e8:	510080e7          	jalr	1296(ra) # 45f4 <write>
    20ec:	09251963          	bne	a0,s2,217e <bigfile+0xfe>
  for(i = 0; i < N; i++){
    20f0:	2485                	addiw	s1,s1,1
    20f2:	fd549fe3          	bne	s1,s5,20d0 <bigfile+0x50>
  close(fd);
    20f6:	8552                	mv	a0,s4
    20f8:	00002097          	auipc	ra,0x2
    20fc:	504080e7          	jalr	1284(ra) # 45fc <close>
  fd = open("bigfile.test", 0);
    2100:	4581                	li	a1,0
    2102:	00003517          	auipc	a0,0x3
    2106:	6d650513          	addi	a0,a0,1750 # 57d8 <malloc+0xdda>
    210a:	00002097          	auipc	ra,0x2
    210e:	50a080e7          	jalr	1290(ra) # 4614 <open>
    2112:	8aaa                	mv	s5,a0
  total = 0;
    2114:	4a01                	li	s4,0
  for(i = 0; ; i++){
    2116:	4481                	li	s1,0
    cc = read(fd, buf, SZ/2);
    2118:	12c00993          	li	s3,300
    211c:	00007917          	auipc	s2,0x7
    2120:	31490913          	addi	s2,s2,788 # 9430 <buf>
  if(fd < 0){
    2124:	06054b63          	bltz	a0,219a <bigfile+0x11a>
    cc = read(fd, buf, SZ/2);
    2128:	864e                	mv	a2,s3
    212a:	85ca                	mv	a1,s2
    212c:	8556                	mv	a0,s5
    212e:	00002097          	auipc	ra,0x2
    2132:	4be080e7          	jalr	1214(ra) # 45ec <read>
    if(cc < 0){
    2136:	08054063          	bltz	a0,21b6 <bigfile+0x136>
    if(cc == 0)
    213a:	c961                	beqz	a0,220a <bigfile+0x18a>
    if(cc != SZ/2){
    213c:	09351b63          	bne	a0,s3,21d2 <bigfile+0x152>
    if(buf[0] != i/2 || buf[SZ/2-1] != i/2){
    2140:	01f4d79b          	srliw	a5,s1,0x1f
    2144:	9fa5                	addw	a5,a5,s1
    2146:	4017d79b          	sraiw	a5,a5,0x1
    214a:	00094703          	lbu	a4,0(s2)
    214e:	0af71063          	bne	a4,a5,21ee <bigfile+0x16e>
    2152:	12b94703          	lbu	a4,299(s2)
    2156:	08f71c63          	bne	a4,a5,21ee <bigfile+0x16e>
    total += cc;
    215a:	12ca0a1b          	addiw	s4,s4,300
  for(i = 0; ; i++){
    215e:	2485                	addiw	s1,s1,1
    cc = read(fd, buf, SZ/2);
    2160:	b7e1                	j	2128 <bigfile+0xa8>
    printf("%s: cannot create bigfile", s);
    2162:	85da                	mv	a1,s6
    2164:	00003517          	auipc	a0,0x3
    2168:	68450513          	addi	a0,a0,1668 # 57e8 <malloc+0xdea>
    216c:	00002097          	auipc	ra,0x2
    2170:	7d6080e7          	jalr	2006(ra) # 4942 <printf>
    exit(1);
    2174:	4505                	li	a0,1
    2176:	00002097          	auipc	ra,0x2
    217a:	45e080e7          	jalr	1118(ra) # 45d4 <exit>
      printf("%s: write bigfile failed\n", s);
    217e:	85da                	mv	a1,s6
    2180:	00003517          	auipc	a0,0x3
    2184:	68850513          	addi	a0,a0,1672 # 5808 <malloc+0xe0a>
    2188:	00002097          	auipc	ra,0x2
    218c:	7ba080e7          	jalr	1978(ra) # 4942 <printf>
      exit(1);
    2190:	4505                	li	a0,1
    2192:	00002097          	auipc	ra,0x2
    2196:	442080e7          	jalr	1090(ra) # 45d4 <exit>
    printf("%s: cannot open bigfile\n", s);
    219a:	85da                	mv	a1,s6
    219c:	00003517          	auipc	a0,0x3
    21a0:	68c50513          	addi	a0,a0,1676 # 5828 <malloc+0xe2a>
    21a4:	00002097          	auipc	ra,0x2
    21a8:	79e080e7          	jalr	1950(ra) # 4942 <printf>
    exit(1);
    21ac:	4505                	li	a0,1
    21ae:	00002097          	auipc	ra,0x2
    21b2:	426080e7          	jalr	1062(ra) # 45d4 <exit>
      printf("%s: read bigfile failed\n", s);
    21b6:	85da                	mv	a1,s6
    21b8:	00003517          	auipc	a0,0x3
    21bc:	69050513          	addi	a0,a0,1680 # 5848 <malloc+0xe4a>
    21c0:	00002097          	auipc	ra,0x2
    21c4:	782080e7          	jalr	1922(ra) # 4942 <printf>
      exit(1);
    21c8:	4505                	li	a0,1
    21ca:	00002097          	auipc	ra,0x2
    21ce:	40a080e7          	jalr	1034(ra) # 45d4 <exit>
      printf("%s: short read bigfile\n", s);
    21d2:	85da                	mv	a1,s6
    21d4:	00003517          	auipc	a0,0x3
    21d8:	69450513          	addi	a0,a0,1684 # 5868 <malloc+0xe6a>
    21dc:	00002097          	auipc	ra,0x2
    21e0:	766080e7          	jalr	1894(ra) # 4942 <printf>
      exit(1);
    21e4:	4505                	li	a0,1
    21e6:	00002097          	auipc	ra,0x2
    21ea:	3ee080e7          	jalr	1006(ra) # 45d4 <exit>
      printf("%s: read bigfile wrong data\n", s);
    21ee:	85da                	mv	a1,s6
    21f0:	00003517          	auipc	a0,0x3
    21f4:	69050513          	addi	a0,a0,1680 # 5880 <malloc+0xe82>
    21f8:	00002097          	auipc	ra,0x2
    21fc:	74a080e7          	jalr	1866(ra) # 4942 <printf>
      exit(1);
    2200:	4505                	li	a0,1
    2202:	00002097          	auipc	ra,0x2
    2206:	3d2080e7          	jalr	978(ra) # 45d4 <exit>
  close(fd);
    220a:	8556                	mv	a0,s5
    220c:	00002097          	auipc	ra,0x2
    2210:	3f0080e7          	jalr	1008(ra) # 45fc <close>
  if(total != N*SZ){
    2214:	678d                	lui	a5,0x3
    2216:	ee078793          	addi	a5,a5,-288 # 2ee0 <subdir+0x450>
    221a:	02fa1463          	bne	s4,a5,2242 <bigfile+0x1c2>
  unlink("bigfile.test");
    221e:	00003517          	auipc	a0,0x3
    2222:	5ba50513          	addi	a0,a0,1466 # 57d8 <malloc+0xdda>
    2226:	00002097          	auipc	ra,0x2
    222a:	3fe080e7          	jalr	1022(ra) # 4624 <unlink>
}
    222e:	70e2                	ld	ra,56(sp)
    2230:	7442                	ld	s0,48(sp)
    2232:	74a2                	ld	s1,40(sp)
    2234:	7902                	ld	s2,32(sp)
    2236:	69e2                	ld	s3,24(sp)
    2238:	6a42                	ld	s4,16(sp)
    223a:	6aa2                	ld	s5,8(sp)
    223c:	6b02                	ld	s6,0(sp)
    223e:	6121                	addi	sp,sp,64
    2240:	8082                	ret
    printf("%s: read bigfile wrong total\n", s);
    2242:	85da                	mv	a1,s6
    2244:	00003517          	auipc	a0,0x3
    2248:	65c50513          	addi	a0,a0,1628 # 58a0 <malloc+0xea2>
    224c:	00002097          	auipc	ra,0x2
    2250:	6f6080e7          	jalr	1782(ra) # 4942 <printf>
    exit(1);
    2254:	4505                	li	a0,1
    2256:	00002097          	auipc	ra,0x2
    225a:	37e080e7          	jalr	894(ra) # 45d4 <exit>

000000000000225e <linktest>:
{
    225e:	1101                	addi	sp,sp,-32
    2260:	ec06                	sd	ra,24(sp)
    2262:	e822                	sd	s0,16(sp)
    2264:	e426                	sd	s1,8(sp)
    2266:	e04a                	sd	s2,0(sp)
    2268:	1000                	addi	s0,sp,32
    226a:	892a                	mv	s2,a0
  unlink("lf1");
    226c:	00003517          	auipc	a0,0x3
    2270:	65450513          	addi	a0,a0,1620 # 58c0 <malloc+0xec2>
    2274:	00002097          	auipc	ra,0x2
    2278:	3b0080e7          	jalr	944(ra) # 4624 <unlink>
  unlink("lf2");
    227c:	00003517          	auipc	a0,0x3
    2280:	64c50513          	addi	a0,a0,1612 # 58c8 <malloc+0xeca>
    2284:	00002097          	auipc	ra,0x2
    2288:	3a0080e7          	jalr	928(ra) # 4624 <unlink>
  fd = open("lf1", O_CREATE|O_RDWR);
    228c:	20200593          	li	a1,514
    2290:	00003517          	auipc	a0,0x3
    2294:	63050513          	addi	a0,a0,1584 # 58c0 <malloc+0xec2>
    2298:	00002097          	auipc	ra,0x2
    229c:	37c080e7          	jalr	892(ra) # 4614 <open>
  if(fd < 0){
    22a0:	10054763          	bltz	a0,23ae <linktest+0x150>
    22a4:	84aa                	mv	s1,a0
  if(write(fd, "hello", SZ) != SZ){
    22a6:	4615                	li	a2,5
    22a8:	00003597          	auipc	a1,0x3
    22ac:	0d058593          	addi	a1,a1,208 # 5378 <malloc+0x97a>
    22b0:	00002097          	auipc	ra,0x2
    22b4:	344080e7          	jalr	836(ra) # 45f4 <write>
    22b8:	4795                	li	a5,5
    22ba:	10f51863          	bne	a0,a5,23ca <linktest+0x16c>
  close(fd);
    22be:	8526                	mv	a0,s1
    22c0:	00002097          	auipc	ra,0x2
    22c4:	33c080e7          	jalr	828(ra) # 45fc <close>
  if(link("lf1", "lf2") < 0){
    22c8:	00003597          	auipc	a1,0x3
    22cc:	60058593          	addi	a1,a1,1536 # 58c8 <malloc+0xeca>
    22d0:	00003517          	auipc	a0,0x3
    22d4:	5f050513          	addi	a0,a0,1520 # 58c0 <malloc+0xec2>
    22d8:	00002097          	auipc	ra,0x2
    22dc:	35c080e7          	jalr	860(ra) # 4634 <link>
    22e0:	10054363          	bltz	a0,23e6 <linktest+0x188>
  unlink("lf1");
    22e4:	00003517          	auipc	a0,0x3
    22e8:	5dc50513          	addi	a0,a0,1500 # 58c0 <malloc+0xec2>
    22ec:	00002097          	auipc	ra,0x2
    22f0:	338080e7          	jalr	824(ra) # 4624 <unlink>
  if(open("lf1", 0) >= 0){
    22f4:	4581                	li	a1,0
    22f6:	00003517          	auipc	a0,0x3
    22fa:	5ca50513          	addi	a0,a0,1482 # 58c0 <malloc+0xec2>
    22fe:	00002097          	auipc	ra,0x2
    2302:	316080e7          	jalr	790(ra) # 4614 <open>
    2306:	0e055e63          	bgez	a0,2402 <linktest+0x1a4>
  fd = open("lf2", 0);
    230a:	4581                	li	a1,0
    230c:	00003517          	auipc	a0,0x3
    2310:	5bc50513          	addi	a0,a0,1468 # 58c8 <malloc+0xeca>
    2314:	00002097          	auipc	ra,0x2
    2318:	300080e7          	jalr	768(ra) # 4614 <open>
    231c:	84aa                	mv	s1,a0
  if(fd < 0){
    231e:	10054063          	bltz	a0,241e <linktest+0x1c0>
  if(read(fd, buf, sizeof(buf)) != SZ){
    2322:	660d                	lui	a2,0x3
    2324:	00007597          	auipc	a1,0x7
    2328:	10c58593          	addi	a1,a1,268 # 9430 <buf>
    232c:	00002097          	auipc	ra,0x2
    2330:	2c0080e7          	jalr	704(ra) # 45ec <read>
    2334:	4795                	li	a5,5
    2336:	10f51263          	bne	a0,a5,243a <linktest+0x1dc>
  close(fd);
    233a:	8526                	mv	a0,s1
    233c:	00002097          	auipc	ra,0x2
    2340:	2c0080e7          	jalr	704(ra) # 45fc <close>
  if(link("lf2", "lf2") >= 0){
    2344:	00003597          	auipc	a1,0x3
    2348:	58458593          	addi	a1,a1,1412 # 58c8 <malloc+0xeca>
    234c:	852e                	mv	a0,a1
    234e:	00002097          	auipc	ra,0x2
    2352:	2e6080e7          	jalr	742(ra) # 4634 <link>
    2356:	10055063          	bgez	a0,2456 <linktest+0x1f8>
  unlink("lf2");
    235a:	00003517          	auipc	a0,0x3
    235e:	56e50513          	addi	a0,a0,1390 # 58c8 <malloc+0xeca>
    2362:	00002097          	auipc	ra,0x2
    2366:	2c2080e7          	jalr	706(ra) # 4624 <unlink>
  if(link("lf2", "lf1") >= 0){
    236a:	00003597          	auipc	a1,0x3
    236e:	55658593          	addi	a1,a1,1366 # 58c0 <malloc+0xec2>
    2372:	00003517          	auipc	a0,0x3
    2376:	55650513          	addi	a0,a0,1366 # 58c8 <malloc+0xeca>
    237a:	00002097          	auipc	ra,0x2
    237e:	2ba080e7          	jalr	698(ra) # 4634 <link>
    2382:	0e055863          	bgez	a0,2472 <linktest+0x214>
  if(link(".", "lf1") >= 0){
    2386:	00003597          	auipc	a1,0x3
    238a:	53a58593          	addi	a1,a1,1338 # 58c0 <malloc+0xec2>
    238e:	00003517          	auipc	a0,0x3
    2392:	84a50513          	addi	a0,a0,-1974 # 4bd8 <malloc+0x1da>
    2396:	00002097          	auipc	ra,0x2
    239a:	29e080e7          	jalr	670(ra) # 4634 <link>
    239e:	0e055863          	bgez	a0,248e <linktest+0x230>
}
    23a2:	60e2                	ld	ra,24(sp)
    23a4:	6442                	ld	s0,16(sp)
    23a6:	64a2                	ld	s1,8(sp)
    23a8:	6902                	ld	s2,0(sp)
    23aa:	6105                	addi	sp,sp,32
    23ac:	8082                	ret
    printf("%s: create lf1 failed\n", s);
    23ae:	85ca                	mv	a1,s2
    23b0:	00003517          	auipc	a0,0x3
    23b4:	52050513          	addi	a0,a0,1312 # 58d0 <malloc+0xed2>
    23b8:	00002097          	auipc	ra,0x2
    23bc:	58a080e7          	jalr	1418(ra) # 4942 <printf>
    exit(1);
    23c0:	4505                	li	a0,1
    23c2:	00002097          	auipc	ra,0x2
    23c6:	212080e7          	jalr	530(ra) # 45d4 <exit>
    printf("%s: write lf1 failed\n", s);
    23ca:	85ca                	mv	a1,s2
    23cc:	00003517          	auipc	a0,0x3
    23d0:	51c50513          	addi	a0,a0,1308 # 58e8 <malloc+0xeea>
    23d4:	00002097          	auipc	ra,0x2
    23d8:	56e080e7          	jalr	1390(ra) # 4942 <printf>
    exit(1);
    23dc:	4505                	li	a0,1
    23de:	00002097          	auipc	ra,0x2
    23e2:	1f6080e7          	jalr	502(ra) # 45d4 <exit>
    printf("%s: link lf1 lf2 failed\n", s);
    23e6:	85ca                	mv	a1,s2
    23e8:	00003517          	auipc	a0,0x3
    23ec:	51850513          	addi	a0,a0,1304 # 5900 <malloc+0xf02>
    23f0:	00002097          	auipc	ra,0x2
    23f4:	552080e7          	jalr	1362(ra) # 4942 <printf>
    exit(1);
    23f8:	4505                	li	a0,1
    23fa:	00002097          	auipc	ra,0x2
    23fe:	1da080e7          	jalr	474(ra) # 45d4 <exit>
    printf("%s: unlinked lf1 but it is still there!\n", s);
    2402:	85ca                	mv	a1,s2
    2404:	00003517          	auipc	a0,0x3
    2408:	51c50513          	addi	a0,a0,1308 # 5920 <malloc+0xf22>
    240c:	00002097          	auipc	ra,0x2
    2410:	536080e7          	jalr	1334(ra) # 4942 <printf>
    exit(1);
    2414:	4505                	li	a0,1
    2416:	00002097          	auipc	ra,0x2
    241a:	1be080e7          	jalr	446(ra) # 45d4 <exit>
    printf("%s: open lf2 failed\n", s);
    241e:	85ca                	mv	a1,s2
    2420:	00003517          	auipc	a0,0x3
    2424:	53050513          	addi	a0,a0,1328 # 5950 <malloc+0xf52>
    2428:	00002097          	auipc	ra,0x2
    242c:	51a080e7          	jalr	1306(ra) # 4942 <printf>
    exit(1);
    2430:	4505                	li	a0,1
    2432:	00002097          	auipc	ra,0x2
    2436:	1a2080e7          	jalr	418(ra) # 45d4 <exit>
    printf("%s: read lf2 failed\n", s);
    243a:	85ca                	mv	a1,s2
    243c:	00003517          	auipc	a0,0x3
    2440:	52c50513          	addi	a0,a0,1324 # 5968 <malloc+0xf6a>
    2444:	00002097          	auipc	ra,0x2
    2448:	4fe080e7          	jalr	1278(ra) # 4942 <printf>
    exit(1);
    244c:	4505                	li	a0,1
    244e:	00002097          	auipc	ra,0x2
    2452:	186080e7          	jalr	390(ra) # 45d4 <exit>
    printf("%s: link lf2 lf2 succeeded! oops\n", s);
    2456:	85ca                	mv	a1,s2
    2458:	00003517          	auipc	a0,0x3
    245c:	52850513          	addi	a0,a0,1320 # 5980 <malloc+0xf82>
    2460:	00002097          	auipc	ra,0x2
    2464:	4e2080e7          	jalr	1250(ra) # 4942 <printf>
    exit(1);
    2468:	4505                	li	a0,1
    246a:	00002097          	auipc	ra,0x2
    246e:	16a080e7          	jalr	362(ra) # 45d4 <exit>
    printf("%s: link non-existant succeeded! oops\n", s);
    2472:	85ca                	mv	a1,s2
    2474:	00003517          	auipc	a0,0x3
    2478:	53450513          	addi	a0,a0,1332 # 59a8 <malloc+0xfaa>
    247c:	00002097          	auipc	ra,0x2
    2480:	4c6080e7          	jalr	1222(ra) # 4942 <printf>
    exit(1);
    2484:	4505                	li	a0,1
    2486:	00002097          	auipc	ra,0x2
    248a:	14e080e7          	jalr	334(ra) # 45d4 <exit>
    printf("%s: link . lf1 succeeded! oops\n", s);
    248e:	85ca                	mv	a1,s2
    2490:	00003517          	auipc	a0,0x3
    2494:	54050513          	addi	a0,a0,1344 # 59d0 <malloc+0xfd2>
    2498:	00002097          	auipc	ra,0x2
    249c:	4aa080e7          	jalr	1194(ra) # 4942 <printf>
    exit(1);
    24a0:	4505                	li	a0,1
    24a2:	00002097          	auipc	ra,0x2
    24a6:	132080e7          	jalr	306(ra) # 45d4 <exit>

00000000000024aa <concreate>:
{
    24aa:	7171                	addi	sp,sp,-176
    24ac:	f506                	sd	ra,168(sp)
    24ae:	f122                	sd	s0,160(sp)
    24b0:	ed26                	sd	s1,152(sp)
    24b2:	e94a                	sd	s2,144(sp)
    24b4:	e54e                	sd	s3,136(sp)
    24b6:	e152                	sd	s4,128(sp)
    24b8:	fcd6                	sd	s5,120(sp)
    24ba:	f8da                	sd	s6,112(sp)
    24bc:	f4de                	sd	s7,104(sp)
    24be:	f0e2                	sd	s8,96(sp)
    24c0:	ece6                	sd	s9,88(sp)
    24c2:	e8ea                	sd	s10,80(sp)
    24c4:	1900                	addi	s0,sp,176
    24c6:	8d2a                	mv	s10,a0
  file[0] = 'C';
    24c8:	04300793          	li	a5,67
    24cc:	f8f40c23          	sb	a5,-104(s0)
  file[2] = '\0';
    24d0:	f8040d23          	sb	zero,-102(s0)
  for(i = 0; i < N; i++){
    24d4:	4901                	li	s2,0
    unlink(file);
    24d6:	f9840993          	addi	s3,s0,-104
    if(pid && (i % 3) == 1){
    24da:	55555b37          	lui	s6,0x55555
    24de:	556b0b13          	addi	s6,s6,1366 # 55555556 <__BSS_END__+0x55549116>
    24e2:	4b85                	li	s7,1
      fd = open(file, O_CREATE | O_RDWR);
    24e4:	20200c13          	li	s8,514
      link("C0", file);
    24e8:	00003c97          	auipc	s9,0x3
    24ec:	508c8c93          	addi	s9,s9,1288 # 59f0 <malloc+0xff2>
      wait(&xstatus);
    24f0:	f5c40a93          	addi	s5,s0,-164
  for(i = 0; i < N; i++){
    24f4:	02800a13          	li	s4,40
    24f8:	a465                	j	27a0 <concreate+0x2f6>
      link("C0", file);
    24fa:	85ce                	mv	a1,s3
    24fc:	8566                	mv	a0,s9
    24fe:	00002097          	auipc	ra,0x2
    2502:	136080e7          	jalr	310(ra) # 4634 <link>
    if(pid == 0) {
    2506:	a449                	j	2788 <concreate+0x2de>
    } else if(pid == 0 && (i % 5) == 1){
    2508:	666667b7          	lui	a5,0x66666
    250c:	66778793          	addi	a5,a5,1639 # 66666667 <__BSS_END__+0x6665a227>
    2510:	02f907b3          	mul	a5,s2,a5
    2514:	9785                	srai	a5,a5,0x21
    2516:	41f9571b          	sraiw	a4,s2,0x1f
    251a:	9f99                	subw	a5,a5,a4
    251c:	0027971b          	slliw	a4,a5,0x2
    2520:	9fb9                	addw	a5,a5,a4
    2522:	40f9093b          	subw	s2,s2,a5
    2526:	4785                	li	a5,1
    2528:	02f90b63          	beq	s2,a5,255e <concreate+0xb4>
      fd = open(file, O_CREATE | O_RDWR);
    252c:	20200593          	li	a1,514
    2530:	f9840513          	addi	a0,s0,-104
    2534:	00002097          	auipc	ra,0x2
    2538:	0e0080e7          	jalr	224(ra) # 4614 <open>
      if(fd < 0){
    253c:	22055d63          	bgez	a0,2776 <concreate+0x2cc>
        printf("concreate create %s failed\n", file);
    2540:	f9840593          	addi	a1,s0,-104
    2544:	00003517          	auipc	a0,0x3
    2548:	4b450513          	addi	a0,a0,1204 # 59f8 <malloc+0xffa>
    254c:	00002097          	auipc	ra,0x2
    2550:	3f6080e7          	jalr	1014(ra) # 4942 <printf>
        exit(1);
    2554:	4505                	li	a0,1
    2556:	00002097          	auipc	ra,0x2
    255a:	07e080e7          	jalr	126(ra) # 45d4 <exit>
      link("C0", file);
    255e:	f9840593          	addi	a1,s0,-104
    2562:	00003517          	auipc	a0,0x3
    2566:	48e50513          	addi	a0,a0,1166 # 59f0 <malloc+0xff2>
    256a:	00002097          	auipc	ra,0x2
    256e:	0ca080e7          	jalr	202(ra) # 4634 <link>
      exit(0);
    2572:	4501                	li	a0,0
    2574:	00002097          	auipc	ra,0x2
    2578:	060080e7          	jalr	96(ra) # 45d4 <exit>
        exit(1);
    257c:	4505                	li	a0,1
    257e:	00002097          	auipc	ra,0x2
    2582:	056080e7          	jalr	86(ra) # 45d4 <exit>
  memset(fa, 0, sizeof(fa));
    2586:	02800613          	li	a2,40
    258a:	4581                	li	a1,0
    258c:	f7040513          	addi	a0,s0,-144
    2590:	00002097          	auipc	ra,0x2
    2594:	e32080e7          	jalr	-462(ra) # 43c2 <memset>
  fd = open(".", 0);
    2598:	4581                	li	a1,0
    259a:	00002517          	auipc	a0,0x2
    259e:	63e50513          	addi	a0,a0,1598 # 4bd8 <malloc+0x1da>
    25a2:	00002097          	auipc	ra,0x2
    25a6:	072080e7          	jalr	114(ra) # 4614 <open>
    25aa:	892a                	mv	s2,a0
  n = 0;
    25ac:	8b26                	mv	s6,s1
  while(read(fd, &de, sizeof(de)) > 0){
    25ae:	f6040a13          	addi	s4,s0,-160
    25b2:	49c1                	li	s3,16
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    25b4:	04300a93          	li	s5,67
      if(i < 0 || i >= sizeof(fa)){
    25b8:	02700b93          	li	s7,39
      fa[i] = 1;
    25bc:	4c05                	li	s8,1
  while(read(fd, &de, sizeof(de)) > 0){
    25be:	864e                	mv	a2,s3
    25c0:	85d2                	mv	a1,s4
    25c2:	854a                	mv	a0,s2
    25c4:	00002097          	auipc	ra,0x2
    25c8:	028080e7          	jalr	40(ra) # 45ec <read>
    25cc:	06a05f63          	blez	a0,264a <concreate+0x1a0>
    if(de.inum == 0)
    25d0:	f6045783          	lhu	a5,-160(s0)
    25d4:	d7ed                	beqz	a5,25be <concreate+0x114>
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    25d6:	f6244783          	lbu	a5,-158(s0)
    25da:	ff5792e3          	bne	a5,s5,25be <concreate+0x114>
    25de:	f6444783          	lbu	a5,-156(s0)
    25e2:	fff1                	bnez	a5,25be <concreate+0x114>
      i = de.name[1] - '0';
    25e4:	f6344783          	lbu	a5,-157(s0)
    25e8:	fd07879b          	addiw	a5,a5,-48
      if(i < 0 || i >= sizeof(fa)){
    25ec:	00fbef63          	bltu	s7,a5,260a <concreate+0x160>
      if(fa[i]){
    25f0:	fa078713          	addi	a4,a5,-96
    25f4:	9722                	add	a4,a4,s0
    25f6:	fd074703          	lbu	a4,-48(a4)
    25fa:	eb05                	bnez	a4,262a <concreate+0x180>
      fa[i] = 1;
    25fc:	fa078793          	addi	a5,a5,-96
    2600:	97a2                	add	a5,a5,s0
    2602:	fd878823          	sb	s8,-48(a5)
      n++;
    2606:	2b05                	addiw	s6,s6,1
    2608:	bf5d                	j	25be <concreate+0x114>
        printf("%s: concreate weird file %s\n", s, de.name);
    260a:	f6240613          	addi	a2,s0,-158
    260e:	85ea                	mv	a1,s10
    2610:	00003517          	auipc	a0,0x3
    2614:	40850513          	addi	a0,a0,1032 # 5a18 <malloc+0x101a>
    2618:	00002097          	auipc	ra,0x2
    261c:	32a080e7          	jalr	810(ra) # 4942 <printf>
        exit(1);
    2620:	4505                	li	a0,1
    2622:	00002097          	auipc	ra,0x2
    2626:	fb2080e7          	jalr	-78(ra) # 45d4 <exit>
        printf("%s: concreate duplicate file %s\n", s, de.name);
    262a:	f6240613          	addi	a2,s0,-158
    262e:	85ea                	mv	a1,s10
    2630:	00003517          	auipc	a0,0x3
    2634:	40850513          	addi	a0,a0,1032 # 5a38 <malloc+0x103a>
    2638:	00002097          	auipc	ra,0x2
    263c:	30a080e7          	jalr	778(ra) # 4942 <printf>
        exit(1);
    2640:	4505                	li	a0,1
    2642:	00002097          	auipc	ra,0x2
    2646:	f92080e7          	jalr	-110(ra) # 45d4 <exit>
  close(fd);
    264a:	854a                	mv	a0,s2
    264c:	00002097          	auipc	ra,0x2
    2650:	fb0080e7          	jalr	-80(ra) # 45fc <close>
  if(n != N){
    2654:	02800793          	li	a5,40
    2658:	00fb1a63          	bne	s6,a5,266c <concreate+0x1c2>
    if(((i % 3) == 0 && pid == 0) ||
    265c:	55555a37          	lui	s4,0x55555
    2660:	556a0a13          	addi	s4,s4,1366 # 55555556 <__BSS_END__+0x55549116>
      close(open(file, 0));
    2664:	f9840993          	addi	s3,s0,-104
  for(i = 0; i < N; i++){
    2668:	8ada                	mv	s5,s6
    266a:	a879                	j	2708 <concreate+0x25e>
    printf("%s: concreate not enough files in directory listing\n", s);
    266c:	85ea                	mv	a1,s10
    266e:	00003517          	auipc	a0,0x3
    2672:	3f250513          	addi	a0,a0,1010 # 5a60 <malloc+0x1062>
    2676:	00002097          	auipc	ra,0x2
    267a:	2cc080e7          	jalr	716(ra) # 4942 <printf>
    exit(1);
    267e:	4505                	li	a0,1
    2680:	00002097          	auipc	ra,0x2
    2684:	f54080e7          	jalr	-172(ra) # 45d4 <exit>
      printf("%s: fork failed\n", s);
    2688:	85ea                	mv	a1,s10
    268a:	00002517          	auipc	a0,0x2
    268e:	5fe50513          	addi	a0,a0,1534 # 4c88 <malloc+0x28a>
    2692:	00002097          	auipc	ra,0x2
    2696:	2b0080e7          	jalr	688(ra) # 4942 <printf>
      exit(1);
    269a:	4505                	li	a0,1
    269c:	00002097          	auipc	ra,0x2
    26a0:	f38080e7          	jalr	-200(ra) # 45d4 <exit>
      close(open(file, 0));
    26a4:	4581                	li	a1,0
    26a6:	854e                	mv	a0,s3
    26a8:	00002097          	auipc	ra,0x2
    26ac:	f6c080e7          	jalr	-148(ra) # 4614 <open>
    26b0:	00002097          	auipc	ra,0x2
    26b4:	f4c080e7          	jalr	-180(ra) # 45fc <close>
      close(open(file, 0));
    26b8:	4581                	li	a1,0
    26ba:	854e                	mv	a0,s3
    26bc:	00002097          	auipc	ra,0x2
    26c0:	f58080e7          	jalr	-168(ra) # 4614 <open>
    26c4:	00002097          	auipc	ra,0x2
    26c8:	f38080e7          	jalr	-200(ra) # 45fc <close>
      close(open(file, 0));
    26cc:	4581                	li	a1,0
    26ce:	854e                	mv	a0,s3
    26d0:	00002097          	auipc	ra,0x2
    26d4:	f44080e7          	jalr	-188(ra) # 4614 <open>
    26d8:	00002097          	auipc	ra,0x2
    26dc:	f24080e7          	jalr	-220(ra) # 45fc <close>
      close(open(file, 0));
    26e0:	4581                	li	a1,0
    26e2:	854e                	mv	a0,s3
    26e4:	00002097          	auipc	ra,0x2
    26e8:	f30080e7          	jalr	-208(ra) # 4614 <open>
    26ec:	00002097          	auipc	ra,0x2
    26f0:	f10080e7          	jalr	-240(ra) # 45fc <close>
    if(pid == 0)
    26f4:	06090c63          	beqz	s2,276c <concreate+0x2c2>
      wait(0);
    26f8:	4501                	li	a0,0
    26fa:	00002097          	auipc	ra,0x2
    26fe:	ee2080e7          	jalr	-286(ra) # 45dc <wait>
  for(i = 0; i < N; i++){
    2702:	2485                	addiw	s1,s1,1
    2704:	0f548363          	beq	s1,s5,27ea <concreate+0x340>
    file[1] = '0' + i;
    2708:	0304879b          	addiw	a5,s1,48
    270c:	f8f40ca3          	sb	a5,-103(s0)
    pid = fork();
    2710:	00002097          	auipc	ra,0x2
    2714:	ebc080e7          	jalr	-324(ra) # 45cc <fork>
    2718:	892a                	mv	s2,a0
    if(pid < 0){
    271a:	f60547e3          	bltz	a0,2688 <concreate+0x1de>
    if(((i % 3) == 0 && pid == 0) ||
    271e:	03448733          	mul	a4,s1,s4
    2722:	9301                	srli	a4,a4,0x20
    2724:	41f4d79b          	sraiw	a5,s1,0x1f
    2728:	9f1d                	subw	a4,a4,a5
    272a:	0017179b          	slliw	a5,a4,0x1
    272e:	9fb9                	addw	a5,a5,a4
    2730:	40f487bb          	subw	a5,s1,a5
    2734:	00a7e733          	or	a4,a5,a0
    2738:	2701                	sext.w	a4,a4
    273a:	d72d                	beqz	a4,26a4 <concreate+0x1fa>
       ((i % 3) == 1 && pid != 0)){
    273c:	c119                	beqz	a0,2742 <concreate+0x298>
    if(((i % 3) == 0 && pid == 0) ||
    273e:	17fd                	addi	a5,a5,-1
       ((i % 3) == 1 && pid != 0)){
    2740:	d3b5                	beqz	a5,26a4 <concreate+0x1fa>
      unlink(file);
    2742:	854e                	mv	a0,s3
    2744:	00002097          	auipc	ra,0x2
    2748:	ee0080e7          	jalr	-288(ra) # 4624 <unlink>
      unlink(file);
    274c:	854e                	mv	a0,s3
    274e:	00002097          	auipc	ra,0x2
    2752:	ed6080e7          	jalr	-298(ra) # 4624 <unlink>
      unlink(file);
    2756:	854e                	mv	a0,s3
    2758:	00002097          	auipc	ra,0x2
    275c:	ecc080e7          	jalr	-308(ra) # 4624 <unlink>
      unlink(file);
    2760:	854e                	mv	a0,s3
    2762:	00002097          	auipc	ra,0x2
    2766:	ec2080e7          	jalr	-318(ra) # 4624 <unlink>
    276a:	b769                	j	26f4 <concreate+0x24a>
      exit(0);
    276c:	4501                	li	a0,0
    276e:	00002097          	auipc	ra,0x2
    2772:	e66080e7          	jalr	-410(ra) # 45d4 <exit>
      close(fd);
    2776:	00002097          	auipc	ra,0x2
    277a:	e86080e7          	jalr	-378(ra) # 45fc <close>
    if(pid == 0) {
    277e:	bbd5                	j	2572 <concreate+0xc8>
      close(fd);
    2780:	00002097          	auipc	ra,0x2
    2784:	e7c080e7          	jalr	-388(ra) # 45fc <close>
      wait(&xstatus);
    2788:	8556                	mv	a0,s5
    278a:	00002097          	auipc	ra,0x2
    278e:	e52080e7          	jalr	-430(ra) # 45dc <wait>
      if(xstatus != 0)
    2792:	f5c42483          	lw	s1,-164(s0)
    2796:	de0493e3          	bnez	s1,257c <concreate+0xd2>
  for(i = 0; i < N; i++){
    279a:	2905                	addiw	s2,s2,1
    279c:	df4905e3          	beq	s2,s4,2586 <concreate+0xdc>
    file[1] = '0' + i;
    27a0:	0309079b          	addiw	a5,s2,48
    27a4:	f8f40ca3          	sb	a5,-103(s0)
    unlink(file);
    27a8:	854e                	mv	a0,s3
    27aa:	00002097          	auipc	ra,0x2
    27ae:	e7a080e7          	jalr	-390(ra) # 4624 <unlink>
    pid = fork();
    27b2:	00002097          	auipc	ra,0x2
    27b6:	e1a080e7          	jalr	-486(ra) # 45cc <fork>
    if(pid && (i % 3) == 1){
    27ba:	d40507e3          	beqz	a0,2508 <concreate+0x5e>
    27be:	036907b3          	mul	a5,s2,s6
    27c2:	9381                	srli	a5,a5,0x20
    27c4:	41f9571b          	sraiw	a4,s2,0x1f
    27c8:	9f99                	subw	a5,a5,a4
    27ca:	0017971b          	slliw	a4,a5,0x1
    27ce:	9fb9                	addw	a5,a5,a4
    27d0:	40f907bb          	subw	a5,s2,a5
    27d4:	d37783e3          	beq	a5,s7,24fa <concreate+0x50>
      fd = open(file, O_CREATE | O_RDWR);
    27d8:	85e2                	mv	a1,s8
    27da:	854e                	mv	a0,s3
    27dc:	00002097          	auipc	ra,0x2
    27e0:	e38080e7          	jalr	-456(ra) # 4614 <open>
      if(fd < 0){
    27e4:	f8055ee3          	bgez	a0,2780 <concreate+0x2d6>
    27e8:	bba1                	j	2540 <concreate+0x96>
}
    27ea:	70aa                	ld	ra,168(sp)
    27ec:	740a                	ld	s0,160(sp)
    27ee:	64ea                	ld	s1,152(sp)
    27f0:	694a                	ld	s2,144(sp)
    27f2:	69aa                	ld	s3,136(sp)
    27f4:	6a0a                	ld	s4,128(sp)
    27f6:	7ae6                	ld	s5,120(sp)
    27f8:	7b46                	ld	s6,112(sp)
    27fa:	7ba6                	ld	s7,104(sp)
    27fc:	7c06                	ld	s8,96(sp)
    27fe:	6ce6                	ld	s9,88(sp)
    2800:	6d46                	ld	s10,80(sp)
    2802:	614d                	addi	sp,sp,176
    2804:	8082                	ret

0000000000002806 <linkunlink>:
{
    2806:	711d                	addi	sp,sp,-96
    2808:	ec86                	sd	ra,88(sp)
    280a:	e8a2                	sd	s0,80(sp)
    280c:	e4a6                	sd	s1,72(sp)
    280e:	e0ca                	sd	s2,64(sp)
    2810:	fc4e                	sd	s3,56(sp)
    2812:	f852                	sd	s4,48(sp)
    2814:	f456                	sd	s5,40(sp)
    2816:	f05a                	sd	s6,32(sp)
    2818:	ec5e                	sd	s7,24(sp)
    281a:	e862                	sd	s8,16(sp)
    281c:	e466                	sd	s9,8(sp)
    281e:	e06a                	sd	s10,0(sp)
    2820:	1080                	addi	s0,sp,96
    2822:	84aa                	mv	s1,a0
  unlink("x");
    2824:	00003517          	auipc	a0,0x3
    2828:	e3450513          	addi	a0,a0,-460 # 5658 <malloc+0xc5a>
    282c:	00002097          	auipc	ra,0x2
    2830:	df8080e7          	jalr	-520(ra) # 4624 <unlink>
  pid = fork();
    2834:	00002097          	auipc	ra,0x2
    2838:	d98080e7          	jalr	-616(ra) # 45cc <fork>
  if(pid < 0){
    283c:	04054363          	bltz	a0,2882 <linkunlink+0x7c>
    2840:	8d2a                	mv	s10,a0
  unsigned int x = (pid ? 1 : 97);
    2842:	06100913          	li	s2,97
    2846:	c111                	beqz	a0,284a <linkunlink+0x44>
    2848:	4905                	li	s2,1
    284a:	06400493          	li	s1,100
    x = x * 1103515245 + 12345;
    284e:	41c65ab7          	lui	s5,0x41c65
    2852:	e6da8a9b          	addiw	s5,s5,-403 # 41c64e6d <__BSS_END__+0x41c58a2d>
    2856:	6a0d                	lui	s4,0x3
    2858:	039a0a1b          	addiw	s4,s4,57 # 3039 <subdir+0x5a9>
    if((x % 3) == 0){
    285c:	000ab9b7          	lui	s3,0xab
    2860:	aab98993          	addi	s3,s3,-1365 # aaaab <__BSS_END__+0x9e66b>
    2864:	09b2                	slli	s3,s3,0xc
    2866:	aab98993          	addi	s3,s3,-1365
    } else if((x % 3) == 1){
    286a:	4b85                	li	s7,1
      unlink("x");
    286c:	00003b17          	auipc	s6,0x3
    2870:	decb0b13          	addi	s6,s6,-532 # 5658 <malloc+0xc5a>
      link("cat", "x");
    2874:	00003c97          	auipc	s9,0x3
    2878:	224c8c93          	addi	s9,s9,548 # 5a98 <malloc+0x109a>
      close(open("x", O_RDWR | O_CREATE));
    287c:	20200c13          	li	s8,514
    2880:	a089                	j	28c2 <linkunlink+0xbc>
    printf("%s: fork failed\n", s);
    2882:	85a6                	mv	a1,s1
    2884:	00002517          	auipc	a0,0x2
    2888:	40450513          	addi	a0,a0,1028 # 4c88 <malloc+0x28a>
    288c:	00002097          	auipc	ra,0x2
    2890:	0b6080e7          	jalr	182(ra) # 4942 <printf>
    exit(1);
    2894:	4505                	li	a0,1
    2896:	00002097          	auipc	ra,0x2
    289a:	d3e080e7          	jalr	-706(ra) # 45d4 <exit>
      close(open("x", O_RDWR | O_CREATE));
    289e:	85e2                	mv	a1,s8
    28a0:	855a                	mv	a0,s6
    28a2:	00002097          	auipc	ra,0x2
    28a6:	d72080e7          	jalr	-654(ra) # 4614 <open>
    28aa:	00002097          	auipc	ra,0x2
    28ae:	d52080e7          	jalr	-686(ra) # 45fc <close>
    28b2:	a031                	j	28be <linkunlink+0xb8>
      unlink("x");
    28b4:	855a                	mv	a0,s6
    28b6:	00002097          	auipc	ra,0x2
    28ba:	d6e080e7          	jalr	-658(ra) # 4624 <unlink>
  for(i = 0; i < 100; i++){
    28be:	34fd                	addiw	s1,s1,-1
    28c0:	c895                	beqz	s1,28f4 <linkunlink+0xee>
    x = x * 1103515245 + 12345;
    28c2:	035907bb          	mulw	a5,s2,s5
    28c6:	00fa07bb          	addw	a5,s4,a5
    28ca:	893e                	mv	s2,a5
    if((x % 3) == 0){
    28cc:	02079713          	slli	a4,a5,0x20
    28d0:	9301                	srli	a4,a4,0x20
    28d2:	03370733          	mul	a4,a4,s3
    28d6:	9305                	srli	a4,a4,0x21
    28d8:	0017169b          	slliw	a3,a4,0x1
    28dc:	9f35                	addw	a4,a4,a3
    28de:	9f99                	subw	a5,a5,a4
    28e0:	dfdd                	beqz	a5,289e <linkunlink+0x98>
    } else if((x % 3) == 1){
    28e2:	fd7799e3          	bne	a5,s7,28b4 <linkunlink+0xae>
      link("cat", "x");
    28e6:	85da                	mv	a1,s6
    28e8:	8566                	mv	a0,s9
    28ea:	00002097          	auipc	ra,0x2
    28ee:	d4a080e7          	jalr	-694(ra) # 4634 <link>
    28f2:	b7f1                	j	28be <linkunlink+0xb8>
  if(pid)
    28f4:	020d0563          	beqz	s10,291e <linkunlink+0x118>
    wait(0);
    28f8:	4501                	li	a0,0
    28fa:	00002097          	auipc	ra,0x2
    28fe:	ce2080e7          	jalr	-798(ra) # 45dc <wait>
}
    2902:	60e6                	ld	ra,88(sp)
    2904:	6446                	ld	s0,80(sp)
    2906:	64a6                	ld	s1,72(sp)
    2908:	6906                	ld	s2,64(sp)
    290a:	79e2                	ld	s3,56(sp)
    290c:	7a42                	ld	s4,48(sp)
    290e:	7aa2                	ld	s5,40(sp)
    2910:	7b02                	ld	s6,32(sp)
    2912:	6be2                	ld	s7,24(sp)
    2914:	6c42                	ld	s8,16(sp)
    2916:	6ca2                	ld	s9,8(sp)
    2918:	6d02                	ld	s10,0(sp)
    291a:	6125                	addi	sp,sp,96
    291c:	8082                	ret
    exit(0);
    291e:	4501                	li	a0,0
    2920:	00002097          	auipc	ra,0x2
    2924:	cb4080e7          	jalr	-844(ra) # 45d4 <exit>

0000000000002928 <bigdir>:
{
    2928:	711d                	addi	sp,sp,-96
    292a:	ec86                	sd	ra,88(sp)
    292c:	e8a2                	sd	s0,80(sp)
    292e:	e4a6                	sd	s1,72(sp)
    2930:	e0ca                	sd	s2,64(sp)
    2932:	fc4e                	sd	s3,56(sp)
    2934:	f852                	sd	s4,48(sp)
    2936:	f456                	sd	s5,40(sp)
    2938:	f05a                	sd	s6,32(sp)
    293a:	ec5e                	sd	s7,24(sp)
    293c:	1080                	addi	s0,sp,96
    293e:	8baa                	mv	s7,a0
  unlink("bd");
    2940:	00003517          	auipc	a0,0x3
    2944:	16050513          	addi	a0,a0,352 # 5aa0 <malloc+0x10a2>
    2948:	00002097          	auipc	ra,0x2
    294c:	cdc080e7          	jalr	-804(ra) # 4624 <unlink>
  fd = open("bd", O_CREATE);
    2950:	20000593          	li	a1,512
    2954:	00003517          	auipc	a0,0x3
    2958:	14c50513          	addi	a0,a0,332 # 5aa0 <malloc+0x10a2>
    295c:	00002097          	auipc	ra,0x2
    2960:	cb8080e7          	jalr	-840(ra) # 4614 <open>
  if(fd < 0){
    2964:	0c054c63          	bltz	a0,2a3c <bigdir+0x114>
  close(fd);
    2968:	00002097          	auipc	ra,0x2
    296c:	c94080e7          	jalr	-876(ra) # 45fc <close>
  for(i = 0; i < N; i++){
    2970:	4901                	li	s2,0
    name[0] = 'x';
    2972:	07800a93          	li	s5,120
    if(link("bd", name) != 0){
    2976:	fa040a13          	addi	s4,s0,-96
    297a:	00003997          	auipc	s3,0x3
    297e:	12698993          	addi	s3,s3,294 # 5aa0 <malloc+0x10a2>
  for(i = 0; i < N; i++){
    2982:	1f400b13          	li	s6,500
    name[0] = 'x';
    2986:	fb540023          	sb	s5,-96(s0)
    name[1] = '0' + (i / 64);
    298a:	41f9571b          	sraiw	a4,s2,0x1f
    298e:	01a7571b          	srliw	a4,a4,0x1a
    2992:	012707bb          	addw	a5,a4,s2
    2996:	4067d69b          	sraiw	a3,a5,0x6
    299a:	0306869b          	addiw	a3,a3,48
    299e:	fad400a3          	sb	a3,-95(s0)
    name[2] = '0' + (i % 64);
    29a2:	03f7f793          	andi	a5,a5,63
    29a6:	9f99                	subw	a5,a5,a4
    29a8:	0307879b          	addiw	a5,a5,48
    29ac:	faf40123          	sb	a5,-94(s0)
    name[3] = '\0';
    29b0:	fa0401a3          	sb	zero,-93(s0)
    if(link("bd", name) != 0){
    29b4:	85d2                	mv	a1,s4
    29b6:	854e                	mv	a0,s3
    29b8:	00002097          	auipc	ra,0x2
    29bc:	c7c080e7          	jalr	-900(ra) # 4634 <link>
    29c0:	84aa                	mv	s1,a0
    29c2:	e959                	bnez	a0,2a58 <bigdir+0x130>
  for(i = 0; i < N; i++){
    29c4:	2905                	addiw	s2,s2,1
    29c6:	fd6910e3          	bne	s2,s6,2986 <bigdir+0x5e>
  unlink("bd");
    29ca:	00003517          	auipc	a0,0x3
    29ce:	0d650513          	addi	a0,a0,214 # 5aa0 <malloc+0x10a2>
    29d2:	00002097          	auipc	ra,0x2
    29d6:	c52080e7          	jalr	-942(ra) # 4624 <unlink>
    name[0] = 'x';
    29da:	07800993          	li	s3,120
    if(unlink(name) != 0){
    29de:	fa040913          	addi	s2,s0,-96
  for(i = 0; i < N; i++){
    29e2:	1f400a13          	li	s4,500
    name[0] = 'x';
    29e6:	fb340023          	sb	s3,-96(s0)
    name[1] = '0' + (i / 64);
    29ea:	41f4d71b          	sraiw	a4,s1,0x1f
    29ee:	01a7571b          	srliw	a4,a4,0x1a
    29f2:	009707bb          	addw	a5,a4,s1
    29f6:	4067d69b          	sraiw	a3,a5,0x6
    29fa:	0306869b          	addiw	a3,a3,48
    29fe:	fad400a3          	sb	a3,-95(s0)
    name[2] = '0' + (i % 64);
    2a02:	03f7f793          	andi	a5,a5,63
    2a06:	9f99                	subw	a5,a5,a4
    2a08:	0307879b          	addiw	a5,a5,48
    2a0c:	faf40123          	sb	a5,-94(s0)
    name[3] = '\0';
    2a10:	fa0401a3          	sb	zero,-93(s0)
    if(unlink(name) != 0){
    2a14:	854a                	mv	a0,s2
    2a16:	00002097          	auipc	ra,0x2
    2a1a:	c0e080e7          	jalr	-1010(ra) # 4624 <unlink>
    2a1e:	e939                	bnez	a0,2a74 <bigdir+0x14c>
  for(i = 0; i < N; i++){
    2a20:	2485                	addiw	s1,s1,1
    2a22:	fd4492e3          	bne	s1,s4,29e6 <bigdir+0xbe>
}
    2a26:	60e6                	ld	ra,88(sp)
    2a28:	6446                	ld	s0,80(sp)
    2a2a:	64a6                	ld	s1,72(sp)
    2a2c:	6906                	ld	s2,64(sp)
    2a2e:	79e2                	ld	s3,56(sp)
    2a30:	7a42                	ld	s4,48(sp)
    2a32:	7aa2                	ld	s5,40(sp)
    2a34:	7b02                	ld	s6,32(sp)
    2a36:	6be2                	ld	s7,24(sp)
    2a38:	6125                	addi	sp,sp,96
    2a3a:	8082                	ret
    printf("%s: bigdir create failed\n", s);
    2a3c:	85de                	mv	a1,s7
    2a3e:	00003517          	auipc	a0,0x3
    2a42:	06a50513          	addi	a0,a0,106 # 5aa8 <malloc+0x10aa>
    2a46:	00002097          	auipc	ra,0x2
    2a4a:	efc080e7          	jalr	-260(ra) # 4942 <printf>
    exit(1);
    2a4e:	4505                	li	a0,1
    2a50:	00002097          	auipc	ra,0x2
    2a54:	b84080e7          	jalr	-1148(ra) # 45d4 <exit>
      printf("%s: bigdir link failed\n", s);
    2a58:	85de                	mv	a1,s7
    2a5a:	00003517          	auipc	a0,0x3
    2a5e:	06e50513          	addi	a0,a0,110 # 5ac8 <malloc+0x10ca>
    2a62:	00002097          	auipc	ra,0x2
    2a66:	ee0080e7          	jalr	-288(ra) # 4942 <printf>
      exit(1);
    2a6a:	4505                	li	a0,1
    2a6c:	00002097          	auipc	ra,0x2
    2a70:	b68080e7          	jalr	-1176(ra) # 45d4 <exit>
      printf("%s: bigdir unlink failed", s);
    2a74:	85de                	mv	a1,s7
    2a76:	00003517          	auipc	a0,0x3
    2a7a:	06a50513          	addi	a0,a0,106 # 5ae0 <malloc+0x10e2>
    2a7e:	00002097          	auipc	ra,0x2
    2a82:	ec4080e7          	jalr	-316(ra) # 4942 <printf>
      exit(1);
    2a86:	4505                	li	a0,1
    2a88:	00002097          	auipc	ra,0x2
    2a8c:	b4c080e7          	jalr	-1204(ra) # 45d4 <exit>

0000000000002a90 <subdir>:
{
    2a90:	1101                	addi	sp,sp,-32
    2a92:	ec06                	sd	ra,24(sp)
    2a94:	e822                	sd	s0,16(sp)
    2a96:	e426                	sd	s1,8(sp)
    2a98:	e04a                	sd	s2,0(sp)
    2a9a:	1000                	addi	s0,sp,32
    2a9c:	892a                	mv	s2,a0
  unlink("ff");
    2a9e:	00003517          	auipc	a0,0x3
    2aa2:	19250513          	addi	a0,a0,402 # 5c30 <malloc+0x1232>
    2aa6:	00002097          	auipc	ra,0x2
    2aaa:	b7e080e7          	jalr	-1154(ra) # 4624 <unlink>
  if(mkdir("dd") != 0){
    2aae:	00003517          	auipc	a0,0x3
    2ab2:	05250513          	addi	a0,a0,82 # 5b00 <malloc+0x1102>
    2ab6:	00002097          	auipc	ra,0x2
    2aba:	b86080e7          	jalr	-1146(ra) # 463c <mkdir>
    2abe:	38051663          	bnez	a0,2e4a <subdir+0x3ba>
  fd = open("dd/ff", O_CREATE | O_RDWR);
    2ac2:	20200593          	li	a1,514
    2ac6:	00003517          	auipc	a0,0x3
    2aca:	05a50513          	addi	a0,a0,90 # 5b20 <malloc+0x1122>
    2ace:	00002097          	auipc	ra,0x2
    2ad2:	b46080e7          	jalr	-1210(ra) # 4614 <open>
    2ad6:	84aa                	mv	s1,a0
  if(fd < 0){
    2ad8:	38054763          	bltz	a0,2e66 <subdir+0x3d6>
  write(fd, "ff", 2);
    2adc:	4609                	li	a2,2
    2ade:	00003597          	auipc	a1,0x3
    2ae2:	15258593          	addi	a1,a1,338 # 5c30 <malloc+0x1232>
    2ae6:	00002097          	auipc	ra,0x2
    2aea:	b0e080e7          	jalr	-1266(ra) # 45f4 <write>
  close(fd);
    2aee:	8526                	mv	a0,s1
    2af0:	00002097          	auipc	ra,0x2
    2af4:	b0c080e7          	jalr	-1268(ra) # 45fc <close>
  if(unlink("dd") >= 0){
    2af8:	00003517          	auipc	a0,0x3
    2afc:	00850513          	addi	a0,a0,8 # 5b00 <malloc+0x1102>
    2b00:	00002097          	auipc	ra,0x2
    2b04:	b24080e7          	jalr	-1244(ra) # 4624 <unlink>
    2b08:	36055d63          	bgez	a0,2e82 <subdir+0x3f2>
  if(mkdir("/dd/dd") != 0){
    2b0c:	00003517          	auipc	a0,0x3
    2b10:	06c50513          	addi	a0,a0,108 # 5b78 <malloc+0x117a>
    2b14:	00002097          	auipc	ra,0x2
    2b18:	b28080e7          	jalr	-1240(ra) # 463c <mkdir>
    2b1c:	38051163          	bnez	a0,2e9e <subdir+0x40e>
  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    2b20:	20200593          	li	a1,514
    2b24:	00003517          	auipc	a0,0x3
    2b28:	07c50513          	addi	a0,a0,124 # 5ba0 <malloc+0x11a2>
    2b2c:	00002097          	auipc	ra,0x2
    2b30:	ae8080e7          	jalr	-1304(ra) # 4614 <open>
    2b34:	84aa                	mv	s1,a0
  if(fd < 0){
    2b36:	38054263          	bltz	a0,2eba <subdir+0x42a>
  write(fd, "FF", 2);
    2b3a:	4609                	li	a2,2
    2b3c:	00003597          	auipc	a1,0x3
    2b40:	09458593          	addi	a1,a1,148 # 5bd0 <malloc+0x11d2>
    2b44:	00002097          	auipc	ra,0x2
    2b48:	ab0080e7          	jalr	-1360(ra) # 45f4 <write>
  close(fd);
    2b4c:	8526                	mv	a0,s1
    2b4e:	00002097          	auipc	ra,0x2
    2b52:	aae080e7          	jalr	-1362(ra) # 45fc <close>
  fd = open("dd/dd/../ff", 0);
    2b56:	4581                	li	a1,0
    2b58:	00003517          	auipc	a0,0x3
    2b5c:	08050513          	addi	a0,a0,128 # 5bd8 <malloc+0x11da>
    2b60:	00002097          	auipc	ra,0x2
    2b64:	ab4080e7          	jalr	-1356(ra) # 4614 <open>
    2b68:	84aa                	mv	s1,a0
  if(fd < 0){
    2b6a:	36054663          	bltz	a0,2ed6 <subdir+0x446>
  cc = read(fd, buf, sizeof(buf));
    2b6e:	660d                	lui	a2,0x3
    2b70:	00007597          	auipc	a1,0x7
    2b74:	8c058593          	addi	a1,a1,-1856 # 9430 <buf>
    2b78:	00002097          	auipc	ra,0x2
    2b7c:	a74080e7          	jalr	-1420(ra) # 45ec <read>
  if(cc != 2 || buf[0] != 'f'){
    2b80:	4789                	li	a5,2
    2b82:	36f51863          	bne	a0,a5,2ef2 <subdir+0x462>
    2b86:	00007717          	auipc	a4,0x7
    2b8a:	8aa74703          	lbu	a4,-1878(a4) # 9430 <buf>
    2b8e:	06600793          	li	a5,102
    2b92:	36f71063          	bne	a4,a5,2ef2 <subdir+0x462>
  close(fd);
    2b96:	8526                	mv	a0,s1
    2b98:	00002097          	auipc	ra,0x2
    2b9c:	a64080e7          	jalr	-1436(ra) # 45fc <close>
  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    2ba0:	00003597          	auipc	a1,0x3
    2ba4:	08858593          	addi	a1,a1,136 # 5c28 <malloc+0x122a>
    2ba8:	00003517          	auipc	a0,0x3
    2bac:	ff850513          	addi	a0,a0,-8 # 5ba0 <malloc+0x11a2>
    2bb0:	00002097          	auipc	ra,0x2
    2bb4:	a84080e7          	jalr	-1404(ra) # 4634 <link>
    2bb8:	34051b63          	bnez	a0,2f0e <subdir+0x47e>
  if(unlink("dd/dd/ff") != 0){
    2bbc:	00003517          	auipc	a0,0x3
    2bc0:	fe450513          	addi	a0,a0,-28 # 5ba0 <malloc+0x11a2>
    2bc4:	00002097          	auipc	ra,0x2
    2bc8:	a60080e7          	jalr	-1440(ra) # 4624 <unlink>
    2bcc:	34051f63          	bnez	a0,2f2a <subdir+0x49a>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    2bd0:	4581                	li	a1,0
    2bd2:	00003517          	auipc	a0,0x3
    2bd6:	fce50513          	addi	a0,a0,-50 # 5ba0 <malloc+0x11a2>
    2bda:	00002097          	auipc	ra,0x2
    2bde:	a3a080e7          	jalr	-1478(ra) # 4614 <open>
    2be2:	36055263          	bgez	a0,2f46 <subdir+0x4b6>
  if(chdir("dd") != 0){
    2be6:	00003517          	auipc	a0,0x3
    2bea:	f1a50513          	addi	a0,a0,-230 # 5b00 <malloc+0x1102>
    2bee:	00002097          	auipc	ra,0x2
    2bf2:	a56080e7          	jalr	-1450(ra) # 4644 <chdir>
    2bf6:	36051663          	bnez	a0,2f62 <subdir+0x4d2>
  if(chdir("dd/../../dd") != 0){
    2bfa:	00003517          	auipc	a0,0x3
    2bfe:	0c650513          	addi	a0,a0,198 # 5cc0 <malloc+0x12c2>
    2c02:	00002097          	auipc	ra,0x2
    2c06:	a42080e7          	jalr	-1470(ra) # 4644 <chdir>
    2c0a:	36051a63          	bnez	a0,2f7e <subdir+0x4ee>
  if(chdir("dd/../../../dd") != 0){
    2c0e:	00003517          	auipc	a0,0x3
    2c12:	0e250513          	addi	a0,a0,226 # 5cf0 <malloc+0x12f2>
    2c16:	00002097          	auipc	ra,0x2
    2c1a:	a2e080e7          	jalr	-1490(ra) # 4644 <chdir>
    2c1e:	36051e63          	bnez	a0,2f9a <subdir+0x50a>
  if(chdir("./..") != 0){
    2c22:	00003517          	auipc	a0,0x3
    2c26:	0fe50513          	addi	a0,a0,254 # 5d20 <malloc+0x1322>
    2c2a:	00002097          	auipc	ra,0x2
    2c2e:	a1a080e7          	jalr	-1510(ra) # 4644 <chdir>
    2c32:	38051263          	bnez	a0,2fb6 <subdir+0x526>
  fd = open("dd/dd/ffff", 0);
    2c36:	4581                	li	a1,0
    2c38:	00003517          	auipc	a0,0x3
    2c3c:	ff050513          	addi	a0,a0,-16 # 5c28 <malloc+0x122a>
    2c40:	00002097          	auipc	ra,0x2
    2c44:	9d4080e7          	jalr	-1580(ra) # 4614 <open>
    2c48:	84aa                	mv	s1,a0
  if(fd < 0){
    2c4a:	38054463          	bltz	a0,2fd2 <subdir+0x542>
  if(read(fd, buf, sizeof(buf)) != 2){
    2c4e:	660d                	lui	a2,0x3
    2c50:	00006597          	auipc	a1,0x6
    2c54:	7e058593          	addi	a1,a1,2016 # 9430 <buf>
    2c58:	00002097          	auipc	ra,0x2
    2c5c:	994080e7          	jalr	-1644(ra) # 45ec <read>
    2c60:	4789                	li	a5,2
    2c62:	38f51663          	bne	a0,a5,2fee <subdir+0x55e>
  close(fd);
    2c66:	8526                	mv	a0,s1
    2c68:	00002097          	auipc	ra,0x2
    2c6c:	994080e7          	jalr	-1644(ra) # 45fc <close>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    2c70:	4581                	li	a1,0
    2c72:	00003517          	auipc	a0,0x3
    2c76:	f2e50513          	addi	a0,a0,-210 # 5ba0 <malloc+0x11a2>
    2c7a:	00002097          	auipc	ra,0x2
    2c7e:	99a080e7          	jalr	-1638(ra) # 4614 <open>
    2c82:	38055463          	bgez	a0,300a <subdir+0x57a>
  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    2c86:	20200593          	li	a1,514
    2c8a:	00003517          	auipc	a0,0x3
    2c8e:	12650513          	addi	a0,a0,294 # 5db0 <malloc+0x13b2>
    2c92:	00002097          	auipc	ra,0x2
    2c96:	982080e7          	jalr	-1662(ra) # 4614 <open>
    2c9a:	38055663          	bgez	a0,3026 <subdir+0x596>
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    2c9e:	20200593          	li	a1,514
    2ca2:	00003517          	auipc	a0,0x3
    2ca6:	13e50513          	addi	a0,a0,318 # 5de0 <malloc+0x13e2>
    2caa:	00002097          	auipc	ra,0x2
    2cae:	96a080e7          	jalr	-1686(ra) # 4614 <open>
    2cb2:	38055863          	bgez	a0,3042 <subdir+0x5b2>
  if(open("dd", O_CREATE) >= 0){
    2cb6:	20000593          	li	a1,512
    2cba:	00003517          	auipc	a0,0x3
    2cbe:	e4650513          	addi	a0,a0,-442 # 5b00 <malloc+0x1102>
    2cc2:	00002097          	auipc	ra,0x2
    2cc6:	952080e7          	jalr	-1710(ra) # 4614 <open>
    2cca:	38055a63          	bgez	a0,305e <subdir+0x5ce>
  if(open("dd", O_RDWR) >= 0){
    2cce:	4589                	li	a1,2
    2cd0:	00003517          	auipc	a0,0x3
    2cd4:	e3050513          	addi	a0,a0,-464 # 5b00 <malloc+0x1102>
    2cd8:	00002097          	auipc	ra,0x2
    2cdc:	93c080e7          	jalr	-1732(ra) # 4614 <open>
    2ce0:	38055d63          	bgez	a0,307a <subdir+0x5ea>
  if(open("dd", O_WRONLY) >= 0){
    2ce4:	4585                	li	a1,1
    2ce6:	00003517          	auipc	a0,0x3
    2cea:	e1a50513          	addi	a0,a0,-486 # 5b00 <malloc+0x1102>
    2cee:	00002097          	auipc	ra,0x2
    2cf2:	926080e7          	jalr	-1754(ra) # 4614 <open>
    2cf6:	3a055063          	bgez	a0,3096 <subdir+0x606>
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    2cfa:	00003597          	auipc	a1,0x3
    2cfe:	17658593          	addi	a1,a1,374 # 5e70 <malloc+0x1472>
    2d02:	00003517          	auipc	a0,0x3
    2d06:	0ae50513          	addi	a0,a0,174 # 5db0 <malloc+0x13b2>
    2d0a:	00002097          	auipc	ra,0x2
    2d0e:	92a080e7          	jalr	-1750(ra) # 4634 <link>
    2d12:	3a050063          	beqz	a0,30b2 <subdir+0x622>
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    2d16:	00003597          	auipc	a1,0x3
    2d1a:	15a58593          	addi	a1,a1,346 # 5e70 <malloc+0x1472>
    2d1e:	00003517          	auipc	a0,0x3
    2d22:	0c250513          	addi	a0,a0,194 # 5de0 <malloc+0x13e2>
    2d26:	00002097          	auipc	ra,0x2
    2d2a:	90e080e7          	jalr	-1778(ra) # 4634 <link>
    2d2e:	3a050063          	beqz	a0,30ce <subdir+0x63e>
  if(link("dd/ff", "dd/dd/ffff") == 0){
    2d32:	00003597          	auipc	a1,0x3
    2d36:	ef658593          	addi	a1,a1,-266 # 5c28 <malloc+0x122a>
    2d3a:	00003517          	auipc	a0,0x3
    2d3e:	de650513          	addi	a0,a0,-538 # 5b20 <malloc+0x1122>
    2d42:	00002097          	auipc	ra,0x2
    2d46:	8f2080e7          	jalr	-1806(ra) # 4634 <link>
    2d4a:	3a050063          	beqz	a0,30ea <subdir+0x65a>
  if(mkdir("dd/ff/ff") == 0){
    2d4e:	00003517          	auipc	a0,0x3
    2d52:	06250513          	addi	a0,a0,98 # 5db0 <malloc+0x13b2>
    2d56:	00002097          	auipc	ra,0x2
    2d5a:	8e6080e7          	jalr	-1818(ra) # 463c <mkdir>
    2d5e:	3a050463          	beqz	a0,3106 <subdir+0x676>
  if(mkdir("dd/xx/ff") == 0){
    2d62:	00003517          	auipc	a0,0x3
    2d66:	07e50513          	addi	a0,a0,126 # 5de0 <malloc+0x13e2>
    2d6a:	00002097          	auipc	ra,0x2
    2d6e:	8d2080e7          	jalr	-1838(ra) # 463c <mkdir>
    2d72:	3a050863          	beqz	a0,3122 <subdir+0x692>
  if(mkdir("dd/dd/ffff") == 0){
    2d76:	00003517          	auipc	a0,0x3
    2d7a:	eb250513          	addi	a0,a0,-334 # 5c28 <malloc+0x122a>
    2d7e:	00002097          	auipc	ra,0x2
    2d82:	8be080e7          	jalr	-1858(ra) # 463c <mkdir>
    2d86:	3a050c63          	beqz	a0,313e <subdir+0x6ae>
  if(unlink("dd/xx/ff") == 0){
    2d8a:	00003517          	auipc	a0,0x3
    2d8e:	05650513          	addi	a0,a0,86 # 5de0 <malloc+0x13e2>
    2d92:	00002097          	auipc	ra,0x2
    2d96:	892080e7          	jalr	-1902(ra) # 4624 <unlink>
    2d9a:	3c050063          	beqz	a0,315a <subdir+0x6ca>
  if(unlink("dd/ff/ff") == 0){
    2d9e:	00003517          	auipc	a0,0x3
    2da2:	01250513          	addi	a0,a0,18 # 5db0 <malloc+0x13b2>
    2da6:	00002097          	auipc	ra,0x2
    2daa:	87e080e7          	jalr	-1922(ra) # 4624 <unlink>
    2dae:	3c050463          	beqz	a0,3176 <subdir+0x6e6>
  if(chdir("dd/ff") == 0){
    2db2:	00003517          	auipc	a0,0x3
    2db6:	d6e50513          	addi	a0,a0,-658 # 5b20 <malloc+0x1122>
    2dba:	00002097          	auipc	ra,0x2
    2dbe:	88a080e7          	jalr	-1910(ra) # 4644 <chdir>
    2dc2:	3c050863          	beqz	a0,3192 <subdir+0x702>
  if(chdir("dd/xx") == 0){
    2dc6:	00003517          	auipc	a0,0x3
    2dca:	1fa50513          	addi	a0,a0,506 # 5fc0 <malloc+0x15c2>
    2dce:	00002097          	auipc	ra,0x2
    2dd2:	876080e7          	jalr	-1930(ra) # 4644 <chdir>
    2dd6:	3c050c63          	beqz	a0,31ae <subdir+0x71e>
  if(unlink("dd/dd/ffff") != 0){
    2dda:	00003517          	auipc	a0,0x3
    2dde:	e4e50513          	addi	a0,a0,-434 # 5c28 <malloc+0x122a>
    2de2:	00002097          	auipc	ra,0x2
    2de6:	842080e7          	jalr	-1982(ra) # 4624 <unlink>
    2dea:	3e051063          	bnez	a0,31ca <subdir+0x73a>
  if(unlink("dd/ff") != 0){
    2dee:	00003517          	auipc	a0,0x3
    2df2:	d3250513          	addi	a0,a0,-718 # 5b20 <malloc+0x1122>
    2df6:	00002097          	auipc	ra,0x2
    2dfa:	82e080e7          	jalr	-2002(ra) # 4624 <unlink>
    2dfe:	3e051463          	bnez	a0,31e6 <subdir+0x756>
  if(unlink("dd") == 0){
    2e02:	00003517          	auipc	a0,0x3
    2e06:	cfe50513          	addi	a0,a0,-770 # 5b00 <malloc+0x1102>
    2e0a:	00002097          	auipc	ra,0x2
    2e0e:	81a080e7          	jalr	-2022(ra) # 4624 <unlink>
    2e12:	3e050863          	beqz	a0,3202 <subdir+0x772>
  if(unlink("dd/dd") < 0){
    2e16:	00003517          	auipc	a0,0x3
    2e1a:	21a50513          	addi	a0,a0,538 # 6030 <malloc+0x1632>
    2e1e:	00002097          	auipc	ra,0x2
    2e22:	806080e7          	jalr	-2042(ra) # 4624 <unlink>
    2e26:	3e054c63          	bltz	a0,321e <subdir+0x78e>
  if(unlink("dd") < 0){
    2e2a:	00003517          	auipc	a0,0x3
    2e2e:	cd650513          	addi	a0,a0,-810 # 5b00 <malloc+0x1102>
    2e32:	00001097          	auipc	ra,0x1
    2e36:	7f2080e7          	jalr	2034(ra) # 4624 <unlink>
    2e3a:	40054063          	bltz	a0,323a <subdir+0x7aa>
}
    2e3e:	60e2                	ld	ra,24(sp)
    2e40:	6442                	ld	s0,16(sp)
    2e42:	64a2                	ld	s1,8(sp)
    2e44:	6902                	ld	s2,0(sp)
    2e46:	6105                	addi	sp,sp,32
    2e48:	8082                	ret
    printf("%s: mkdir dd failed\n", s);
    2e4a:	85ca                	mv	a1,s2
    2e4c:	00003517          	auipc	a0,0x3
    2e50:	cbc50513          	addi	a0,a0,-836 # 5b08 <malloc+0x110a>
    2e54:	00002097          	auipc	ra,0x2
    2e58:	aee080e7          	jalr	-1298(ra) # 4942 <printf>
    exit(1);
    2e5c:	4505                	li	a0,1
    2e5e:	00001097          	auipc	ra,0x1
    2e62:	776080e7          	jalr	1910(ra) # 45d4 <exit>
    printf("%s: create dd/ff failed\n", s);
    2e66:	85ca                	mv	a1,s2
    2e68:	00003517          	auipc	a0,0x3
    2e6c:	cc050513          	addi	a0,a0,-832 # 5b28 <malloc+0x112a>
    2e70:	00002097          	auipc	ra,0x2
    2e74:	ad2080e7          	jalr	-1326(ra) # 4942 <printf>
    exit(1);
    2e78:	4505                	li	a0,1
    2e7a:	00001097          	auipc	ra,0x1
    2e7e:	75a080e7          	jalr	1882(ra) # 45d4 <exit>
    printf("%s: unlink dd (non-empty dir) succeeded!\n", s);
    2e82:	85ca                	mv	a1,s2
    2e84:	00003517          	auipc	a0,0x3
    2e88:	cc450513          	addi	a0,a0,-828 # 5b48 <malloc+0x114a>
    2e8c:	00002097          	auipc	ra,0x2
    2e90:	ab6080e7          	jalr	-1354(ra) # 4942 <printf>
    exit(1);
    2e94:	4505                	li	a0,1
    2e96:	00001097          	auipc	ra,0x1
    2e9a:	73e080e7          	jalr	1854(ra) # 45d4 <exit>
    printf("subdir mkdir dd/dd failed\n", s);
    2e9e:	85ca                	mv	a1,s2
    2ea0:	00003517          	auipc	a0,0x3
    2ea4:	ce050513          	addi	a0,a0,-800 # 5b80 <malloc+0x1182>
    2ea8:	00002097          	auipc	ra,0x2
    2eac:	a9a080e7          	jalr	-1382(ra) # 4942 <printf>
    exit(1);
    2eb0:	4505                	li	a0,1
    2eb2:	00001097          	auipc	ra,0x1
    2eb6:	722080e7          	jalr	1826(ra) # 45d4 <exit>
    printf("%s: create dd/dd/ff failed\n", s);
    2eba:	85ca                	mv	a1,s2
    2ebc:	00003517          	auipc	a0,0x3
    2ec0:	cf450513          	addi	a0,a0,-780 # 5bb0 <malloc+0x11b2>
    2ec4:	00002097          	auipc	ra,0x2
    2ec8:	a7e080e7          	jalr	-1410(ra) # 4942 <printf>
    exit(1);
    2ecc:	4505                	li	a0,1
    2ece:	00001097          	auipc	ra,0x1
    2ed2:	706080e7          	jalr	1798(ra) # 45d4 <exit>
    printf("%s: open dd/dd/../ff failed\n", s);
    2ed6:	85ca                	mv	a1,s2
    2ed8:	00003517          	auipc	a0,0x3
    2edc:	d1050513          	addi	a0,a0,-752 # 5be8 <malloc+0x11ea>
    2ee0:	00002097          	auipc	ra,0x2
    2ee4:	a62080e7          	jalr	-1438(ra) # 4942 <printf>
    exit(1);
    2ee8:	4505                	li	a0,1
    2eea:	00001097          	auipc	ra,0x1
    2eee:	6ea080e7          	jalr	1770(ra) # 45d4 <exit>
    printf("%s: dd/dd/../ff wrong content\n", s);
    2ef2:	85ca                	mv	a1,s2
    2ef4:	00003517          	auipc	a0,0x3
    2ef8:	d1450513          	addi	a0,a0,-748 # 5c08 <malloc+0x120a>
    2efc:	00002097          	auipc	ra,0x2
    2f00:	a46080e7          	jalr	-1466(ra) # 4942 <printf>
    exit(1);
    2f04:	4505                	li	a0,1
    2f06:	00001097          	auipc	ra,0x1
    2f0a:	6ce080e7          	jalr	1742(ra) # 45d4 <exit>
    printf("link dd/dd/ff dd/dd/ffff failed\n", s);
    2f0e:	85ca                	mv	a1,s2
    2f10:	00003517          	auipc	a0,0x3
    2f14:	d2850513          	addi	a0,a0,-728 # 5c38 <malloc+0x123a>
    2f18:	00002097          	auipc	ra,0x2
    2f1c:	a2a080e7          	jalr	-1494(ra) # 4942 <printf>
    exit(1);
    2f20:	4505                	li	a0,1
    2f22:	00001097          	auipc	ra,0x1
    2f26:	6b2080e7          	jalr	1714(ra) # 45d4 <exit>
    printf("%s: unlink dd/dd/ff failed\n", s);
    2f2a:	85ca                	mv	a1,s2
    2f2c:	00003517          	auipc	a0,0x3
    2f30:	d3450513          	addi	a0,a0,-716 # 5c60 <malloc+0x1262>
    2f34:	00002097          	auipc	ra,0x2
    2f38:	a0e080e7          	jalr	-1522(ra) # 4942 <printf>
    exit(1);
    2f3c:	4505                	li	a0,1
    2f3e:	00001097          	auipc	ra,0x1
    2f42:	696080e7          	jalr	1686(ra) # 45d4 <exit>
    printf("%s: open (unlinked) dd/dd/ff succeeded\n", s);
    2f46:	85ca                	mv	a1,s2
    2f48:	00003517          	auipc	a0,0x3
    2f4c:	d3850513          	addi	a0,a0,-712 # 5c80 <malloc+0x1282>
    2f50:	00002097          	auipc	ra,0x2
    2f54:	9f2080e7          	jalr	-1550(ra) # 4942 <printf>
    exit(1);
    2f58:	4505                	li	a0,1
    2f5a:	00001097          	auipc	ra,0x1
    2f5e:	67a080e7          	jalr	1658(ra) # 45d4 <exit>
    printf("%s: chdir dd failed\n", s);
    2f62:	85ca                	mv	a1,s2
    2f64:	00003517          	auipc	a0,0x3
    2f68:	d4450513          	addi	a0,a0,-700 # 5ca8 <malloc+0x12aa>
    2f6c:	00002097          	auipc	ra,0x2
    2f70:	9d6080e7          	jalr	-1578(ra) # 4942 <printf>
    exit(1);
    2f74:	4505                	li	a0,1
    2f76:	00001097          	auipc	ra,0x1
    2f7a:	65e080e7          	jalr	1630(ra) # 45d4 <exit>
    printf("%s: chdir dd/../../dd failed\n", s);
    2f7e:	85ca                	mv	a1,s2
    2f80:	00003517          	auipc	a0,0x3
    2f84:	d5050513          	addi	a0,a0,-688 # 5cd0 <malloc+0x12d2>
    2f88:	00002097          	auipc	ra,0x2
    2f8c:	9ba080e7          	jalr	-1606(ra) # 4942 <printf>
    exit(1);
    2f90:	4505                	li	a0,1
    2f92:	00001097          	auipc	ra,0x1
    2f96:	642080e7          	jalr	1602(ra) # 45d4 <exit>
    printf("chdir dd/../../dd failed\n", s);
    2f9a:	85ca                	mv	a1,s2
    2f9c:	00003517          	auipc	a0,0x3
    2fa0:	d6450513          	addi	a0,a0,-668 # 5d00 <malloc+0x1302>
    2fa4:	00002097          	auipc	ra,0x2
    2fa8:	99e080e7          	jalr	-1634(ra) # 4942 <printf>
    exit(1);
    2fac:	4505                	li	a0,1
    2fae:	00001097          	auipc	ra,0x1
    2fb2:	626080e7          	jalr	1574(ra) # 45d4 <exit>
    printf("%s: chdir ./.. failed\n", s);
    2fb6:	85ca                	mv	a1,s2
    2fb8:	00003517          	auipc	a0,0x3
    2fbc:	d7050513          	addi	a0,a0,-656 # 5d28 <malloc+0x132a>
    2fc0:	00002097          	auipc	ra,0x2
    2fc4:	982080e7          	jalr	-1662(ra) # 4942 <printf>
    exit(1);
    2fc8:	4505                	li	a0,1
    2fca:	00001097          	auipc	ra,0x1
    2fce:	60a080e7          	jalr	1546(ra) # 45d4 <exit>
    printf("%s: open dd/dd/ffff failed\n", s);
    2fd2:	85ca                	mv	a1,s2
    2fd4:	00003517          	auipc	a0,0x3
    2fd8:	d6c50513          	addi	a0,a0,-660 # 5d40 <malloc+0x1342>
    2fdc:	00002097          	auipc	ra,0x2
    2fe0:	966080e7          	jalr	-1690(ra) # 4942 <printf>
    exit(1);
    2fe4:	4505                	li	a0,1
    2fe6:	00001097          	auipc	ra,0x1
    2fea:	5ee080e7          	jalr	1518(ra) # 45d4 <exit>
    printf("%s: read dd/dd/ffff wrong len\n", s);
    2fee:	85ca                	mv	a1,s2
    2ff0:	00003517          	auipc	a0,0x3
    2ff4:	d7050513          	addi	a0,a0,-656 # 5d60 <malloc+0x1362>
    2ff8:	00002097          	auipc	ra,0x2
    2ffc:	94a080e7          	jalr	-1718(ra) # 4942 <printf>
    exit(1);
    3000:	4505                	li	a0,1
    3002:	00001097          	auipc	ra,0x1
    3006:	5d2080e7          	jalr	1490(ra) # 45d4 <exit>
    printf("%s: open (unlinked) dd/dd/ff succeeded!\n", s);
    300a:	85ca                	mv	a1,s2
    300c:	00003517          	auipc	a0,0x3
    3010:	d7450513          	addi	a0,a0,-652 # 5d80 <malloc+0x1382>
    3014:	00002097          	auipc	ra,0x2
    3018:	92e080e7          	jalr	-1746(ra) # 4942 <printf>
    exit(1);
    301c:	4505                	li	a0,1
    301e:	00001097          	auipc	ra,0x1
    3022:	5b6080e7          	jalr	1462(ra) # 45d4 <exit>
    printf("%s: create dd/ff/ff succeeded!\n", s);
    3026:	85ca                	mv	a1,s2
    3028:	00003517          	auipc	a0,0x3
    302c:	d9850513          	addi	a0,a0,-616 # 5dc0 <malloc+0x13c2>
    3030:	00002097          	auipc	ra,0x2
    3034:	912080e7          	jalr	-1774(ra) # 4942 <printf>
    exit(1);
    3038:	4505                	li	a0,1
    303a:	00001097          	auipc	ra,0x1
    303e:	59a080e7          	jalr	1434(ra) # 45d4 <exit>
    printf("%s: create dd/xx/ff succeeded!\n", s);
    3042:	85ca                	mv	a1,s2
    3044:	00003517          	auipc	a0,0x3
    3048:	dac50513          	addi	a0,a0,-596 # 5df0 <malloc+0x13f2>
    304c:	00002097          	auipc	ra,0x2
    3050:	8f6080e7          	jalr	-1802(ra) # 4942 <printf>
    exit(1);
    3054:	4505                	li	a0,1
    3056:	00001097          	auipc	ra,0x1
    305a:	57e080e7          	jalr	1406(ra) # 45d4 <exit>
    printf("%s: create dd succeeded!\n", s);
    305e:	85ca                	mv	a1,s2
    3060:	00003517          	auipc	a0,0x3
    3064:	db050513          	addi	a0,a0,-592 # 5e10 <malloc+0x1412>
    3068:	00002097          	auipc	ra,0x2
    306c:	8da080e7          	jalr	-1830(ra) # 4942 <printf>
    exit(1);
    3070:	4505                	li	a0,1
    3072:	00001097          	auipc	ra,0x1
    3076:	562080e7          	jalr	1378(ra) # 45d4 <exit>
    printf("%s: open dd rdwr succeeded!\n", s);
    307a:	85ca                	mv	a1,s2
    307c:	00003517          	auipc	a0,0x3
    3080:	db450513          	addi	a0,a0,-588 # 5e30 <malloc+0x1432>
    3084:	00002097          	auipc	ra,0x2
    3088:	8be080e7          	jalr	-1858(ra) # 4942 <printf>
    exit(1);
    308c:	4505                	li	a0,1
    308e:	00001097          	auipc	ra,0x1
    3092:	546080e7          	jalr	1350(ra) # 45d4 <exit>
    printf("%s: open dd wronly succeeded!\n", s);
    3096:	85ca                	mv	a1,s2
    3098:	00003517          	auipc	a0,0x3
    309c:	db850513          	addi	a0,a0,-584 # 5e50 <malloc+0x1452>
    30a0:	00002097          	auipc	ra,0x2
    30a4:	8a2080e7          	jalr	-1886(ra) # 4942 <printf>
    exit(1);
    30a8:	4505                	li	a0,1
    30aa:	00001097          	auipc	ra,0x1
    30ae:	52a080e7          	jalr	1322(ra) # 45d4 <exit>
    printf("%s: link dd/ff/ff dd/dd/xx succeeded!\n", s);
    30b2:	85ca                	mv	a1,s2
    30b4:	00003517          	auipc	a0,0x3
    30b8:	dcc50513          	addi	a0,a0,-564 # 5e80 <malloc+0x1482>
    30bc:	00002097          	auipc	ra,0x2
    30c0:	886080e7          	jalr	-1914(ra) # 4942 <printf>
    exit(1);
    30c4:	4505                	li	a0,1
    30c6:	00001097          	auipc	ra,0x1
    30ca:	50e080e7          	jalr	1294(ra) # 45d4 <exit>
    printf("%s: link dd/xx/ff dd/dd/xx succeeded!\n", s);
    30ce:	85ca                	mv	a1,s2
    30d0:	00003517          	auipc	a0,0x3
    30d4:	dd850513          	addi	a0,a0,-552 # 5ea8 <malloc+0x14aa>
    30d8:	00002097          	auipc	ra,0x2
    30dc:	86a080e7          	jalr	-1942(ra) # 4942 <printf>
    exit(1);
    30e0:	4505                	li	a0,1
    30e2:	00001097          	auipc	ra,0x1
    30e6:	4f2080e7          	jalr	1266(ra) # 45d4 <exit>
    printf("%s: link dd/ff dd/dd/ffff succeeded!\n", s);
    30ea:	85ca                	mv	a1,s2
    30ec:	00003517          	auipc	a0,0x3
    30f0:	de450513          	addi	a0,a0,-540 # 5ed0 <malloc+0x14d2>
    30f4:	00002097          	auipc	ra,0x2
    30f8:	84e080e7          	jalr	-1970(ra) # 4942 <printf>
    exit(1);
    30fc:	4505                	li	a0,1
    30fe:	00001097          	auipc	ra,0x1
    3102:	4d6080e7          	jalr	1238(ra) # 45d4 <exit>
    printf("%s: mkdir dd/ff/ff succeeded!\n", s);
    3106:	85ca                	mv	a1,s2
    3108:	00003517          	auipc	a0,0x3
    310c:	df050513          	addi	a0,a0,-528 # 5ef8 <malloc+0x14fa>
    3110:	00002097          	auipc	ra,0x2
    3114:	832080e7          	jalr	-1998(ra) # 4942 <printf>
    exit(1);
    3118:	4505                	li	a0,1
    311a:	00001097          	auipc	ra,0x1
    311e:	4ba080e7          	jalr	1210(ra) # 45d4 <exit>
    printf("%s: mkdir dd/xx/ff succeeded!\n", s);
    3122:	85ca                	mv	a1,s2
    3124:	00003517          	auipc	a0,0x3
    3128:	df450513          	addi	a0,a0,-524 # 5f18 <malloc+0x151a>
    312c:	00002097          	auipc	ra,0x2
    3130:	816080e7          	jalr	-2026(ra) # 4942 <printf>
    exit(1);
    3134:	4505                	li	a0,1
    3136:	00001097          	auipc	ra,0x1
    313a:	49e080e7          	jalr	1182(ra) # 45d4 <exit>
    printf("%s: mkdir dd/dd/ffff succeeded!\n", s);
    313e:	85ca                	mv	a1,s2
    3140:	00003517          	auipc	a0,0x3
    3144:	df850513          	addi	a0,a0,-520 # 5f38 <malloc+0x153a>
    3148:	00001097          	auipc	ra,0x1
    314c:	7fa080e7          	jalr	2042(ra) # 4942 <printf>
    exit(1);
    3150:	4505                	li	a0,1
    3152:	00001097          	auipc	ra,0x1
    3156:	482080e7          	jalr	1154(ra) # 45d4 <exit>
    printf("%s: unlink dd/xx/ff succeeded!\n", s);
    315a:	85ca                	mv	a1,s2
    315c:	00003517          	auipc	a0,0x3
    3160:	e0450513          	addi	a0,a0,-508 # 5f60 <malloc+0x1562>
    3164:	00001097          	auipc	ra,0x1
    3168:	7de080e7          	jalr	2014(ra) # 4942 <printf>
    exit(1);
    316c:	4505                	li	a0,1
    316e:	00001097          	auipc	ra,0x1
    3172:	466080e7          	jalr	1126(ra) # 45d4 <exit>
    printf("%s: unlink dd/ff/ff succeeded!\n", s);
    3176:	85ca                	mv	a1,s2
    3178:	00003517          	auipc	a0,0x3
    317c:	e0850513          	addi	a0,a0,-504 # 5f80 <malloc+0x1582>
    3180:	00001097          	auipc	ra,0x1
    3184:	7c2080e7          	jalr	1986(ra) # 4942 <printf>
    exit(1);
    3188:	4505                	li	a0,1
    318a:	00001097          	auipc	ra,0x1
    318e:	44a080e7          	jalr	1098(ra) # 45d4 <exit>
    printf("%s: chdir dd/ff succeeded!\n", s);
    3192:	85ca                	mv	a1,s2
    3194:	00003517          	auipc	a0,0x3
    3198:	e0c50513          	addi	a0,a0,-500 # 5fa0 <malloc+0x15a2>
    319c:	00001097          	auipc	ra,0x1
    31a0:	7a6080e7          	jalr	1958(ra) # 4942 <printf>
    exit(1);
    31a4:	4505                	li	a0,1
    31a6:	00001097          	auipc	ra,0x1
    31aa:	42e080e7          	jalr	1070(ra) # 45d4 <exit>
    printf("%s: chdir dd/xx succeeded!\n", s);
    31ae:	85ca                	mv	a1,s2
    31b0:	00003517          	auipc	a0,0x3
    31b4:	e1850513          	addi	a0,a0,-488 # 5fc8 <malloc+0x15ca>
    31b8:	00001097          	auipc	ra,0x1
    31bc:	78a080e7          	jalr	1930(ra) # 4942 <printf>
    exit(1);
    31c0:	4505                	li	a0,1
    31c2:	00001097          	auipc	ra,0x1
    31c6:	412080e7          	jalr	1042(ra) # 45d4 <exit>
    printf("%s: unlink dd/dd/ff failed\n", s);
    31ca:	85ca                	mv	a1,s2
    31cc:	00003517          	auipc	a0,0x3
    31d0:	a9450513          	addi	a0,a0,-1388 # 5c60 <malloc+0x1262>
    31d4:	00001097          	auipc	ra,0x1
    31d8:	76e080e7          	jalr	1902(ra) # 4942 <printf>
    exit(1);
    31dc:	4505                	li	a0,1
    31de:	00001097          	auipc	ra,0x1
    31e2:	3f6080e7          	jalr	1014(ra) # 45d4 <exit>
    printf("%s: unlink dd/ff failed\n", s);
    31e6:	85ca                	mv	a1,s2
    31e8:	00003517          	auipc	a0,0x3
    31ec:	e0050513          	addi	a0,a0,-512 # 5fe8 <malloc+0x15ea>
    31f0:	00001097          	auipc	ra,0x1
    31f4:	752080e7          	jalr	1874(ra) # 4942 <printf>
    exit(1);
    31f8:	4505                	li	a0,1
    31fa:	00001097          	auipc	ra,0x1
    31fe:	3da080e7          	jalr	986(ra) # 45d4 <exit>
    printf("%s: unlink non-empty dd succeeded!\n", s);
    3202:	85ca                	mv	a1,s2
    3204:	00003517          	auipc	a0,0x3
    3208:	e0450513          	addi	a0,a0,-508 # 6008 <malloc+0x160a>
    320c:	00001097          	auipc	ra,0x1
    3210:	736080e7          	jalr	1846(ra) # 4942 <printf>
    exit(1);
    3214:	4505                	li	a0,1
    3216:	00001097          	auipc	ra,0x1
    321a:	3be080e7          	jalr	958(ra) # 45d4 <exit>
    printf("%s: unlink dd/dd failed\n", s);
    321e:	85ca                	mv	a1,s2
    3220:	00003517          	auipc	a0,0x3
    3224:	e1850513          	addi	a0,a0,-488 # 6038 <malloc+0x163a>
    3228:	00001097          	auipc	ra,0x1
    322c:	71a080e7          	jalr	1818(ra) # 4942 <printf>
    exit(1);
    3230:	4505                	li	a0,1
    3232:	00001097          	auipc	ra,0x1
    3236:	3a2080e7          	jalr	930(ra) # 45d4 <exit>
    printf("%s: unlink dd failed\n", s);
    323a:	85ca                	mv	a1,s2
    323c:	00003517          	auipc	a0,0x3
    3240:	e1c50513          	addi	a0,a0,-484 # 6058 <malloc+0x165a>
    3244:	00001097          	auipc	ra,0x1
    3248:	6fe080e7          	jalr	1790(ra) # 4942 <printf>
    exit(1);
    324c:	4505                	li	a0,1
    324e:	00001097          	auipc	ra,0x1
    3252:	386080e7          	jalr	902(ra) # 45d4 <exit>

0000000000003256 <dirfile>:
{
    3256:	1101                	addi	sp,sp,-32
    3258:	ec06                	sd	ra,24(sp)
    325a:	e822                	sd	s0,16(sp)
    325c:	e426                	sd	s1,8(sp)
    325e:	e04a                	sd	s2,0(sp)
    3260:	1000                	addi	s0,sp,32
    3262:	892a                	mv	s2,a0
  fd = open("dirfile", O_CREATE);
    3264:	20000593          	li	a1,512
    3268:	00003517          	auipc	a0,0x3
    326c:	e0850513          	addi	a0,a0,-504 # 6070 <malloc+0x1672>
    3270:	00001097          	auipc	ra,0x1
    3274:	3a4080e7          	jalr	932(ra) # 4614 <open>
  if(fd < 0){
    3278:	0e054d63          	bltz	a0,3372 <dirfile+0x11c>
  close(fd);
    327c:	00001097          	auipc	ra,0x1
    3280:	380080e7          	jalr	896(ra) # 45fc <close>
  if(chdir("dirfile") == 0){
    3284:	00003517          	auipc	a0,0x3
    3288:	dec50513          	addi	a0,a0,-532 # 6070 <malloc+0x1672>
    328c:	00001097          	auipc	ra,0x1
    3290:	3b8080e7          	jalr	952(ra) # 4644 <chdir>
    3294:	cd6d                	beqz	a0,338e <dirfile+0x138>
  fd = open("dirfile/xx", 0);
    3296:	4581                	li	a1,0
    3298:	00003517          	auipc	a0,0x3
    329c:	e2050513          	addi	a0,a0,-480 # 60b8 <malloc+0x16ba>
    32a0:	00001097          	auipc	ra,0x1
    32a4:	374080e7          	jalr	884(ra) # 4614 <open>
  if(fd >= 0){
    32a8:	10055163          	bgez	a0,33aa <dirfile+0x154>
  fd = open("dirfile/xx", O_CREATE);
    32ac:	20000593          	li	a1,512
    32b0:	00003517          	auipc	a0,0x3
    32b4:	e0850513          	addi	a0,a0,-504 # 60b8 <malloc+0x16ba>
    32b8:	00001097          	auipc	ra,0x1
    32bc:	35c080e7          	jalr	860(ra) # 4614 <open>
  if(fd >= 0){
    32c0:	10055363          	bgez	a0,33c6 <dirfile+0x170>
  if(mkdir("dirfile/xx") == 0){
    32c4:	00003517          	auipc	a0,0x3
    32c8:	df450513          	addi	a0,a0,-524 # 60b8 <malloc+0x16ba>
    32cc:	00001097          	auipc	ra,0x1
    32d0:	370080e7          	jalr	880(ra) # 463c <mkdir>
    32d4:	10050763          	beqz	a0,33e2 <dirfile+0x18c>
  if(unlink("dirfile/xx") == 0){
    32d8:	00003517          	auipc	a0,0x3
    32dc:	de050513          	addi	a0,a0,-544 # 60b8 <malloc+0x16ba>
    32e0:	00001097          	auipc	ra,0x1
    32e4:	344080e7          	jalr	836(ra) # 4624 <unlink>
    32e8:	10050b63          	beqz	a0,33fe <dirfile+0x1a8>
  if(link("README", "dirfile/xx") == 0){
    32ec:	00003597          	auipc	a1,0x3
    32f0:	dcc58593          	addi	a1,a1,-564 # 60b8 <malloc+0x16ba>
    32f4:	00003517          	auipc	a0,0x3
    32f8:	e4c50513          	addi	a0,a0,-436 # 6140 <malloc+0x1742>
    32fc:	00001097          	auipc	ra,0x1
    3300:	338080e7          	jalr	824(ra) # 4634 <link>
    3304:	10050b63          	beqz	a0,341a <dirfile+0x1c4>
  if(unlink("dirfile") != 0){
    3308:	00003517          	auipc	a0,0x3
    330c:	d6850513          	addi	a0,a0,-664 # 6070 <malloc+0x1672>
    3310:	00001097          	auipc	ra,0x1
    3314:	314080e7          	jalr	788(ra) # 4624 <unlink>
    3318:	10051f63          	bnez	a0,3436 <dirfile+0x1e0>
  fd = open(".", O_RDWR);
    331c:	4589                	li	a1,2
    331e:	00002517          	auipc	a0,0x2
    3322:	8ba50513          	addi	a0,a0,-1862 # 4bd8 <malloc+0x1da>
    3326:	00001097          	auipc	ra,0x1
    332a:	2ee080e7          	jalr	750(ra) # 4614 <open>
  if(fd >= 0){
    332e:	12055263          	bgez	a0,3452 <dirfile+0x1fc>
  fd = open(".", 0);
    3332:	4581                	li	a1,0
    3334:	00002517          	auipc	a0,0x2
    3338:	8a450513          	addi	a0,a0,-1884 # 4bd8 <malloc+0x1da>
    333c:	00001097          	auipc	ra,0x1
    3340:	2d8080e7          	jalr	728(ra) # 4614 <open>
    3344:	84aa                	mv	s1,a0
  if(write(fd, "x", 1) > 0){
    3346:	4605                	li	a2,1
    3348:	00002597          	auipc	a1,0x2
    334c:	31058593          	addi	a1,a1,784 # 5658 <malloc+0xc5a>
    3350:	00001097          	auipc	ra,0x1
    3354:	2a4080e7          	jalr	676(ra) # 45f4 <write>
    3358:	10a04b63          	bgtz	a0,346e <dirfile+0x218>
  close(fd);
    335c:	8526                	mv	a0,s1
    335e:	00001097          	auipc	ra,0x1
    3362:	29e080e7          	jalr	670(ra) # 45fc <close>
}
    3366:	60e2                	ld	ra,24(sp)
    3368:	6442                	ld	s0,16(sp)
    336a:	64a2                	ld	s1,8(sp)
    336c:	6902                	ld	s2,0(sp)
    336e:	6105                	addi	sp,sp,32
    3370:	8082                	ret
    printf("%s: create dirfile failed\n", s);
    3372:	85ca                	mv	a1,s2
    3374:	00003517          	auipc	a0,0x3
    3378:	d0450513          	addi	a0,a0,-764 # 6078 <malloc+0x167a>
    337c:	00001097          	auipc	ra,0x1
    3380:	5c6080e7          	jalr	1478(ra) # 4942 <printf>
    exit(1);
    3384:	4505                	li	a0,1
    3386:	00001097          	auipc	ra,0x1
    338a:	24e080e7          	jalr	590(ra) # 45d4 <exit>
    printf("%s: chdir dirfile succeeded!\n", s);
    338e:	85ca                	mv	a1,s2
    3390:	00003517          	auipc	a0,0x3
    3394:	d0850513          	addi	a0,a0,-760 # 6098 <malloc+0x169a>
    3398:	00001097          	auipc	ra,0x1
    339c:	5aa080e7          	jalr	1450(ra) # 4942 <printf>
    exit(1);
    33a0:	4505                	li	a0,1
    33a2:	00001097          	auipc	ra,0x1
    33a6:	232080e7          	jalr	562(ra) # 45d4 <exit>
    printf("%s: create dirfile/xx succeeded!\n", s);
    33aa:	85ca                	mv	a1,s2
    33ac:	00003517          	auipc	a0,0x3
    33b0:	d1c50513          	addi	a0,a0,-740 # 60c8 <malloc+0x16ca>
    33b4:	00001097          	auipc	ra,0x1
    33b8:	58e080e7          	jalr	1422(ra) # 4942 <printf>
    exit(1);
    33bc:	4505                	li	a0,1
    33be:	00001097          	auipc	ra,0x1
    33c2:	216080e7          	jalr	534(ra) # 45d4 <exit>
    printf("%s: create dirfile/xx succeeded!\n", s);
    33c6:	85ca                	mv	a1,s2
    33c8:	00003517          	auipc	a0,0x3
    33cc:	d0050513          	addi	a0,a0,-768 # 60c8 <malloc+0x16ca>
    33d0:	00001097          	auipc	ra,0x1
    33d4:	572080e7          	jalr	1394(ra) # 4942 <printf>
    exit(1);
    33d8:	4505                	li	a0,1
    33da:	00001097          	auipc	ra,0x1
    33de:	1fa080e7          	jalr	506(ra) # 45d4 <exit>
    printf("%s: mkdir dirfile/xx succeeded!\n", s);
    33e2:	85ca                	mv	a1,s2
    33e4:	00003517          	auipc	a0,0x3
    33e8:	d0c50513          	addi	a0,a0,-756 # 60f0 <malloc+0x16f2>
    33ec:	00001097          	auipc	ra,0x1
    33f0:	556080e7          	jalr	1366(ra) # 4942 <printf>
    exit(1);
    33f4:	4505                	li	a0,1
    33f6:	00001097          	auipc	ra,0x1
    33fa:	1de080e7          	jalr	478(ra) # 45d4 <exit>
    printf("%s: unlink dirfile/xx succeeded!\n", s);
    33fe:	85ca                	mv	a1,s2
    3400:	00003517          	auipc	a0,0x3
    3404:	d1850513          	addi	a0,a0,-744 # 6118 <malloc+0x171a>
    3408:	00001097          	auipc	ra,0x1
    340c:	53a080e7          	jalr	1338(ra) # 4942 <printf>
    exit(1);
    3410:	4505                	li	a0,1
    3412:	00001097          	auipc	ra,0x1
    3416:	1c2080e7          	jalr	450(ra) # 45d4 <exit>
    printf("%s: link to dirfile/xx succeeded!\n", s);
    341a:	85ca                	mv	a1,s2
    341c:	00003517          	auipc	a0,0x3
    3420:	d2c50513          	addi	a0,a0,-724 # 6148 <malloc+0x174a>
    3424:	00001097          	auipc	ra,0x1
    3428:	51e080e7          	jalr	1310(ra) # 4942 <printf>
    exit(1);
    342c:	4505                	li	a0,1
    342e:	00001097          	auipc	ra,0x1
    3432:	1a6080e7          	jalr	422(ra) # 45d4 <exit>
    printf("%s: unlink dirfile failed!\n", s);
    3436:	85ca                	mv	a1,s2
    3438:	00003517          	auipc	a0,0x3
    343c:	d3850513          	addi	a0,a0,-712 # 6170 <malloc+0x1772>
    3440:	00001097          	auipc	ra,0x1
    3444:	502080e7          	jalr	1282(ra) # 4942 <printf>
    exit(1);
    3448:	4505                	li	a0,1
    344a:	00001097          	auipc	ra,0x1
    344e:	18a080e7          	jalr	394(ra) # 45d4 <exit>
    printf("%s: open . for writing succeeded!\n", s);
    3452:	85ca                	mv	a1,s2
    3454:	00003517          	auipc	a0,0x3
    3458:	d3c50513          	addi	a0,a0,-708 # 6190 <malloc+0x1792>
    345c:	00001097          	auipc	ra,0x1
    3460:	4e6080e7          	jalr	1254(ra) # 4942 <printf>
    exit(1);
    3464:	4505                	li	a0,1
    3466:	00001097          	auipc	ra,0x1
    346a:	16e080e7          	jalr	366(ra) # 45d4 <exit>
    printf("%s: write . succeeded!\n", s);
    346e:	85ca                	mv	a1,s2
    3470:	00003517          	auipc	a0,0x3
    3474:	d4850513          	addi	a0,a0,-696 # 61b8 <malloc+0x17ba>
    3478:	00001097          	auipc	ra,0x1
    347c:	4ca080e7          	jalr	1226(ra) # 4942 <printf>
    exit(1);
    3480:	4505                	li	a0,1
    3482:	00001097          	auipc	ra,0x1
    3486:	152080e7          	jalr	338(ra) # 45d4 <exit>

000000000000348a <iref>:
{
    348a:	715d                	addi	sp,sp,-80
    348c:	e486                	sd	ra,72(sp)
    348e:	e0a2                	sd	s0,64(sp)
    3490:	fc26                	sd	s1,56(sp)
    3492:	f84a                	sd	s2,48(sp)
    3494:	f44e                	sd	s3,40(sp)
    3496:	f052                	sd	s4,32(sp)
    3498:	ec56                	sd	s5,24(sp)
    349a:	e85a                	sd	s6,16(sp)
    349c:	e45e                	sd	s7,8(sp)
    349e:	0880                	addi	s0,sp,80
    34a0:	8baa                	mv	s7,a0
    34a2:	03300913          	li	s2,51
    if(mkdir("irefd") != 0){
    34a6:	00003a97          	auipc	s5,0x3
    34aa:	d2aa8a93          	addi	s5,s5,-726 # 61d0 <malloc+0x17d2>
    mkdir("");
    34ae:	00003497          	auipc	s1,0x3
    34b2:	8fa48493          	addi	s1,s1,-1798 # 5da8 <malloc+0x13aa>
    link("README", "");
    34b6:	00003b17          	auipc	s6,0x3
    34ba:	c8ab0b13          	addi	s6,s6,-886 # 6140 <malloc+0x1742>
    fd = open("", O_CREATE);
    34be:	20000a13          	li	s4,512
    fd = open("xx", O_CREATE);
    34c2:	00003997          	auipc	s3,0x3
    34c6:	bfe98993          	addi	s3,s3,-1026 # 60c0 <malloc+0x16c2>
    34ca:	a891                	j	351e <iref+0x94>
      printf("%s: mkdir irefd failed\n", s);
    34cc:	85de                	mv	a1,s7
    34ce:	00003517          	auipc	a0,0x3
    34d2:	d0a50513          	addi	a0,a0,-758 # 61d8 <malloc+0x17da>
    34d6:	00001097          	auipc	ra,0x1
    34da:	46c080e7          	jalr	1132(ra) # 4942 <printf>
      exit(1);
    34de:	4505                	li	a0,1
    34e0:	00001097          	auipc	ra,0x1
    34e4:	0f4080e7          	jalr	244(ra) # 45d4 <exit>
      printf("%s: chdir irefd failed\n", s);
    34e8:	85de                	mv	a1,s7
    34ea:	00003517          	auipc	a0,0x3
    34ee:	d0650513          	addi	a0,a0,-762 # 61f0 <malloc+0x17f2>
    34f2:	00001097          	auipc	ra,0x1
    34f6:	450080e7          	jalr	1104(ra) # 4942 <printf>
      exit(1);
    34fa:	4505                	li	a0,1
    34fc:	00001097          	auipc	ra,0x1
    3500:	0d8080e7          	jalr	216(ra) # 45d4 <exit>
      close(fd);
    3504:	00001097          	auipc	ra,0x1
    3508:	0f8080e7          	jalr	248(ra) # 45fc <close>
    350c:	a881                	j	355c <iref+0xd2>
    unlink("xx");
    350e:	854e                	mv	a0,s3
    3510:	00001097          	auipc	ra,0x1
    3514:	114080e7          	jalr	276(ra) # 4624 <unlink>
  for(i = 0; i < NINODE + 1; i++){
    3518:	397d                	addiw	s2,s2,-1
    351a:	04090e63          	beqz	s2,3576 <iref+0xec>
    if(mkdir("irefd") != 0){
    351e:	8556                	mv	a0,s5
    3520:	00001097          	auipc	ra,0x1
    3524:	11c080e7          	jalr	284(ra) # 463c <mkdir>
    3528:	f155                	bnez	a0,34cc <iref+0x42>
    if(chdir("irefd") != 0){
    352a:	8556                	mv	a0,s5
    352c:	00001097          	auipc	ra,0x1
    3530:	118080e7          	jalr	280(ra) # 4644 <chdir>
    3534:	f955                	bnez	a0,34e8 <iref+0x5e>
    mkdir("");
    3536:	8526                	mv	a0,s1
    3538:	00001097          	auipc	ra,0x1
    353c:	104080e7          	jalr	260(ra) # 463c <mkdir>
    link("README", "");
    3540:	85a6                	mv	a1,s1
    3542:	855a                	mv	a0,s6
    3544:	00001097          	auipc	ra,0x1
    3548:	0f0080e7          	jalr	240(ra) # 4634 <link>
    fd = open("", O_CREATE);
    354c:	85d2                	mv	a1,s4
    354e:	8526                	mv	a0,s1
    3550:	00001097          	auipc	ra,0x1
    3554:	0c4080e7          	jalr	196(ra) # 4614 <open>
    if(fd >= 0)
    3558:	fa0556e3          	bgez	a0,3504 <iref+0x7a>
    fd = open("xx", O_CREATE);
    355c:	85d2                	mv	a1,s4
    355e:	854e                	mv	a0,s3
    3560:	00001097          	auipc	ra,0x1
    3564:	0b4080e7          	jalr	180(ra) # 4614 <open>
    if(fd >= 0)
    3568:	fa0543e3          	bltz	a0,350e <iref+0x84>
      close(fd);
    356c:	00001097          	auipc	ra,0x1
    3570:	090080e7          	jalr	144(ra) # 45fc <close>
    3574:	bf69                	j	350e <iref+0x84>
  chdir("/");
    3576:	00001517          	auipc	a0,0x1
    357a:	60a50513          	addi	a0,a0,1546 # 4b80 <malloc+0x182>
    357e:	00001097          	auipc	ra,0x1
    3582:	0c6080e7          	jalr	198(ra) # 4644 <chdir>
}
    3586:	60a6                	ld	ra,72(sp)
    3588:	6406                	ld	s0,64(sp)
    358a:	74e2                	ld	s1,56(sp)
    358c:	7942                	ld	s2,48(sp)
    358e:	79a2                	ld	s3,40(sp)
    3590:	7a02                	ld	s4,32(sp)
    3592:	6ae2                	ld	s5,24(sp)
    3594:	6b42                	ld	s6,16(sp)
    3596:	6ba2                	ld	s7,8(sp)
    3598:	6161                	addi	sp,sp,80
    359a:	8082                	ret

000000000000359c <validatetest>:
{
    359c:	7139                	addi	sp,sp,-64
    359e:	fc06                	sd	ra,56(sp)
    35a0:	f822                	sd	s0,48(sp)
    35a2:	f426                	sd	s1,40(sp)
    35a4:	f04a                	sd	s2,32(sp)
    35a6:	ec4e                	sd	s3,24(sp)
    35a8:	e852                	sd	s4,16(sp)
    35aa:	e456                	sd	s5,8(sp)
    35ac:	e05a                	sd	s6,0(sp)
    35ae:	0080                	addi	s0,sp,64
    35b0:	8b2a                	mv	s6,a0
  for(p = 0; p <= (uint)hi; p += PGSIZE){
    35b2:	4481                	li	s1,0
    if(link("nosuchfile", (char*)p) != -1){
    35b4:	00003997          	auipc	s3,0x3
    35b8:	c5498993          	addi	s3,s3,-940 # 6208 <malloc+0x180a>
    35bc:	597d                	li	s2,-1
  for(p = 0; p <= (uint)hi; p += PGSIZE){
    35be:	6a85                	lui	s5,0x1
    35c0:	00114a37          	lui	s4,0x114
    if(link("nosuchfile", (char*)p) != -1){
    35c4:	85a6                	mv	a1,s1
    35c6:	854e                	mv	a0,s3
    35c8:	00001097          	auipc	ra,0x1
    35cc:	06c080e7          	jalr	108(ra) # 4634 <link>
    35d0:	01251f63          	bne	a0,s2,35ee <validatetest+0x52>
  for(p = 0; p <= (uint)hi; p += PGSIZE){
    35d4:	94d6                	add	s1,s1,s5
    35d6:	ff4497e3          	bne	s1,s4,35c4 <validatetest+0x28>
}
    35da:	70e2                	ld	ra,56(sp)
    35dc:	7442                	ld	s0,48(sp)
    35de:	74a2                	ld	s1,40(sp)
    35e0:	7902                	ld	s2,32(sp)
    35e2:	69e2                	ld	s3,24(sp)
    35e4:	6a42                	ld	s4,16(sp)
    35e6:	6aa2                	ld	s5,8(sp)
    35e8:	6b02                	ld	s6,0(sp)
    35ea:	6121                	addi	sp,sp,64
    35ec:	8082                	ret
      printf("%s: link should not succeed\n", s);
    35ee:	85da                	mv	a1,s6
    35f0:	00003517          	auipc	a0,0x3
    35f4:	c2850513          	addi	a0,a0,-984 # 6218 <malloc+0x181a>
    35f8:	00001097          	auipc	ra,0x1
    35fc:	34a080e7          	jalr	842(ra) # 4942 <printf>
      exit(1);
    3600:	4505                	li	a0,1
    3602:	00001097          	auipc	ra,0x1
    3606:	fd2080e7          	jalr	-46(ra) # 45d4 <exit>

000000000000360a <sbrkbasic>:
{
    360a:	715d                	addi	sp,sp,-80
    360c:	e486                	sd	ra,72(sp)
    360e:	e0a2                	sd	s0,64(sp)
    3610:	ec56                	sd	s5,24(sp)
    3612:	0880                	addi	s0,sp,80
    3614:	8aaa                	mv	s5,a0
  a = sbrk(TOOMUCH);
    3616:	40000537          	lui	a0,0x40000
    361a:	00001097          	auipc	ra,0x1
    361e:	042080e7          	jalr	66(ra) # 465c <sbrk>
  if(a != (char*)0xffffffffffffffffL){
    3622:	57fd                	li	a5,-1
    3624:	02f50463          	beq	a0,a5,364c <sbrkbasic+0x42>
    3628:	fc26                	sd	s1,56(sp)
    362a:	f84a                	sd	s2,48(sp)
    362c:	f44e                	sd	s3,40(sp)
    362e:	f052                	sd	s4,32(sp)
    3630:	85aa                	mv	a1,a0
    printf("%s: sbrk(<toomuch>) returned %p\n", a);
    3632:	00003517          	auipc	a0,0x3
    3636:	c0650513          	addi	a0,a0,-1018 # 6238 <malloc+0x183a>
    363a:	00001097          	auipc	ra,0x1
    363e:	308080e7          	jalr	776(ra) # 4942 <printf>
    exit(1);
    3642:	4505                	li	a0,1
    3644:	00001097          	auipc	ra,0x1
    3648:	f90080e7          	jalr	-112(ra) # 45d4 <exit>
    364c:	fc26                	sd	s1,56(sp)
    364e:	f84a                	sd	s2,48(sp)
    3650:	f44e                	sd	s3,40(sp)
    3652:	f052                	sd	s4,32(sp)
  a = sbrk(0);
    3654:	4501                	li	a0,0
    3656:	00001097          	auipc	ra,0x1
    365a:	006080e7          	jalr	6(ra) # 465c <sbrk>
    365e:	84aa                	mv	s1,a0
  for(i = 0; i < 5000; i++){
    3660:	4901                	li	s2,0
    b = sbrk(1);
    3662:	4985                	li	s3,1
  for(i = 0; i < 5000; i++){
    3664:	6a05                	lui	s4,0x1
    3666:	388a0a13          	addi	s4,s4,904 # 1388 <unlinkread+0xee>
    366a:	a011                	j	366e <sbrkbasic+0x64>
    366c:	84be                	mv	s1,a5
    b = sbrk(1);
    366e:	854e                	mv	a0,s3
    3670:	00001097          	auipc	ra,0x1
    3674:	fec080e7          	jalr	-20(ra) # 465c <sbrk>
    if(b != a){
    3678:	04951b63          	bne	a0,s1,36ce <sbrkbasic+0xc4>
    *b = 1;
    367c:	01348023          	sb	s3,0(s1)
    a = b + 1;
    3680:	00148793          	addi	a5,s1,1
  for(i = 0; i < 5000; i++){
    3684:	2905                	addiw	s2,s2,1
    3686:	ff4913e3          	bne	s2,s4,366c <sbrkbasic+0x62>
  pid = fork();
    368a:	00001097          	auipc	ra,0x1
    368e:	f42080e7          	jalr	-190(ra) # 45cc <fork>
    3692:	892a                	mv	s2,a0
  if(pid < 0){
    3694:	04054d63          	bltz	a0,36ee <sbrkbasic+0xe4>
  c = sbrk(1);
    3698:	4505                	li	a0,1
    369a:	00001097          	auipc	ra,0x1
    369e:	fc2080e7          	jalr	-62(ra) # 465c <sbrk>
  c = sbrk(1);
    36a2:	4505                	li	a0,1
    36a4:	00001097          	auipc	ra,0x1
    36a8:	fb8080e7          	jalr	-72(ra) # 465c <sbrk>
  if(c != a + 1){
    36ac:	0489                	addi	s1,s1,2
    36ae:	04950e63          	beq	a0,s1,370a <sbrkbasic+0x100>
    printf("%s: sbrk test failed post-fork\n", s);
    36b2:	85d6                	mv	a1,s5
    36b4:	00003517          	auipc	a0,0x3
    36b8:	bec50513          	addi	a0,a0,-1044 # 62a0 <malloc+0x18a2>
    36bc:	00001097          	auipc	ra,0x1
    36c0:	286080e7          	jalr	646(ra) # 4942 <printf>
    exit(1);
    36c4:	4505                	li	a0,1
    36c6:	00001097          	auipc	ra,0x1
    36ca:	f0e080e7          	jalr	-242(ra) # 45d4 <exit>
      printf("%s: sbrk test failed %d %x %x\n", i, a, b);
    36ce:	86aa                	mv	a3,a0
    36d0:	8626                	mv	a2,s1
    36d2:	85ca                	mv	a1,s2
    36d4:	00003517          	auipc	a0,0x3
    36d8:	b8c50513          	addi	a0,a0,-1140 # 6260 <malloc+0x1862>
    36dc:	00001097          	auipc	ra,0x1
    36e0:	266080e7          	jalr	614(ra) # 4942 <printf>
      exit(1);
    36e4:	4505                	li	a0,1
    36e6:	00001097          	auipc	ra,0x1
    36ea:	eee080e7          	jalr	-274(ra) # 45d4 <exit>
    printf("%s: sbrk test fork failed\n", s);
    36ee:	85d6                	mv	a1,s5
    36f0:	00003517          	auipc	a0,0x3
    36f4:	b9050513          	addi	a0,a0,-1136 # 6280 <malloc+0x1882>
    36f8:	00001097          	auipc	ra,0x1
    36fc:	24a080e7          	jalr	586(ra) # 4942 <printf>
    exit(1);
    3700:	4505                	li	a0,1
    3702:	00001097          	auipc	ra,0x1
    3706:	ed2080e7          	jalr	-302(ra) # 45d4 <exit>
  if(pid == 0)
    370a:	00091763          	bnez	s2,3718 <sbrkbasic+0x10e>
    exit(0);
    370e:	4501                	li	a0,0
    3710:	00001097          	auipc	ra,0x1
    3714:	ec4080e7          	jalr	-316(ra) # 45d4 <exit>
  wait(&xstatus);
    3718:	fbc40513          	addi	a0,s0,-68
    371c:	00001097          	auipc	ra,0x1
    3720:	ec0080e7          	jalr	-320(ra) # 45dc <wait>
  exit(xstatus);
    3724:	fbc42503          	lw	a0,-68(s0)
    3728:	00001097          	auipc	ra,0x1
    372c:	eac080e7          	jalr	-340(ra) # 45d4 <exit>

0000000000003730 <sbrkmuch>:
{
    3730:	7179                	addi	sp,sp,-48
    3732:	f406                	sd	ra,40(sp)
    3734:	f022                	sd	s0,32(sp)
    3736:	ec26                	sd	s1,24(sp)
    3738:	e84a                	sd	s2,16(sp)
    373a:	e44e                	sd	s3,8(sp)
    373c:	e052                	sd	s4,0(sp)
    373e:	1800                	addi	s0,sp,48
    3740:	89aa                	mv	s3,a0
  oldbrk = sbrk(0);
    3742:	4501                	li	a0,0
    3744:	00001097          	auipc	ra,0x1
    3748:	f18080e7          	jalr	-232(ra) # 465c <sbrk>
    374c:	892a                	mv	s2,a0
  a = sbrk(0);
    374e:	4501                	li	a0,0
    3750:	00001097          	auipc	ra,0x1
    3754:	f0c080e7          	jalr	-244(ra) # 465c <sbrk>
    3758:	84aa                	mv	s1,a0
  p = sbrk(amt);
    375a:	06400537          	lui	a0,0x6400
    375e:	9d05                	subw	a0,a0,s1
    3760:	00001097          	auipc	ra,0x1
    3764:	efc080e7          	jalr	-260(ra) # 465c <sbrk>
  if (p != a) {
    3768:	0aa49b63          	bne	s1,a0,381e <sbrkmuch+0xee>
  *lastaddr = 99;
    376c:	064007b7          	lui	a5,0x6400
    3770:	06300713          	li	a4,99
    3774:	fee78fa3          	sb	a4,-1(a5) # 63fffff <__BSS_END__+0x63f3bbf>
  a = sbrk(0);
    3778:	4501                	li	a0,0
    377a:	00001097          	auipc	ra,0x1
    377e:	ee2080e7          	jalr	-286(ra) # 465c <sbrk>
    3782:	84aa                	mv	s1,a0
  c = sbrk(-PGSIZE);
    3784:	757d                	lui	a0,0xfffff
    3786:	00001097          	auipc	ra,0x1
    378a:	ed6080e7          	jalr	-298(ra) # 465c <sbrk>
  if(c == (char*)0xffffffffffffffffL){
    378e:	57fd                	li	a5,-1
    3790:	0af50563          	beq	a0,a5,383a <sbrkmuch+0x10a>
  c = sbrk(0);
    3794:	4501                	li	a0,0
    3796:	00001097          	auipc	ra,0x1
    379a:	ec6080e7          	jalr	-314(ra) # 465c <sbrk>
  if(c != a - PGSIZE){
    379e:	80048793          	addi	a5,s1,-2048
    37a2:	80078793          	addi	a5,a5,-2048
    37a6:	0af51863          	bne	a0,a5,3856 <sbrkmuch+0x126>
  a = sbrk(0);
    37aa:	4501                	li	a0,0
    37ac:	00001097          	auipc	ra,0x1
    37b0:	eb0080e7          	jalr	-336(ra) # 465c <sbrk>
    37b4:	84aa                	mv	s1,a0
  c = sbrk(PGSIZE);
    37b6:	6505                	lui	a0,0x1
    37b8:	00001097          	auipc	ra,0x1
    37bc:	ea4080e7          	jalr	-348(ra) # 465c <sbrk>
    37c0:	8a2a                	mv	s4,a0
  if(c != a || sbrk(0) != a + PGSIZE){
    37c2:	0aa49963          	bne	s1,a0,3874 <sbrkmuch+0x144>
    37c6:	4501                	li	a0,0
    37c8:	00001097          	auipc	ra,0x1
    37cc:	e94080e7          	jalr	-364(ra) # 465c <sbrk>
    37d0:	6785                	lui	a5,0x1
    37d2:	97a6                	add	a5,a5,s1
    37d4:	0af51063          	bne	a0,a5,3874 <sbrkmuch+0x144>
  if(*lastaddr == 99){
    37d8:	064007b7          	lui	a5,0x6400
    37dc:	fff7c703          	lbu	a4,-1(a5) # 63fffff <__BSS_END__+0x63f3bbf>
    37e0:	06300793          	li	a5,99
    37e4:	0af70763          	beq	a4,a5,3892 <sbrkmuch+0x162>
  a = sbrk(0);
    37e8:	4501                	li	a0,0
    37ea:	00001097          	auipc	ra,0x1
    37ee:	e72080e7          	jalr	-398(ra) # 465c <sbrk>
    37f2:	84aa                	mv	s1,a0
  c = sbrk(-(sbrk(0) - oldbrk));
    37f4:	4501                	li	a0,0
    37f6:	00001097          	auipc	ra,0x1
    37fa:	e66080e7          	jalr	-410(ra) # 465c <sbrk>
    37fe:	40a9053b          	subw	a0,s2,a0
    3802:	00001097          	auipc	ra,0x1
    3806:	e5a080e7          	jalr	-422(ra) # 465c <sbrk>
  if(c != a){
    380a:	0aa49263          	bne	s1,a0,38ae <sbrkmuch+0x17e>
}
    380e:	70a2                	ld	ra,40(sp)
    3810:	7402                	ld	s0,32(sp)
    3812:	64e2                	ld	s1,24(sp)
    3814:	6942                	ld	s2,16(sp)
    3816:	69a2                	ld	s3,8(sp)
    3818:	6a02                	ld	s4,0(sp)
    381a:	6145                	addi	sp,sp,48
    381c:	8082                	ret
    printf("%s: sbrk test failed to grow big address space; enough phys mem?\n", s);
    381e:	85ce                	mv	a1,s3
    3820:	00003517          	auipc	a0,0x3
    3824:	aa050513          	addi	a0,a0,-1376 # 62c0 <malloc+0x18c2>
    3828:	00001097          	auipc	ra,0x1
    382c:	11a080e7          	jalr	282(ra) # 4942 <printf>
    exit(1);
    3830:	4505                	li	a0,1
    3832:	00001097          	auipc	ra,0x1
    3836:	da2080e7          	jalr	-606(ra) # 45d4 <exit>
    printf("%s: sbrk could not deallocate\n", s);
    383a:	85ce                	mv	a1,s3
    383c:	00003517          	auipc	a0,0x3
    3840:	acc50513          	addi	a0,a0,-1332 # 6308 <malloc+0x190a>
    3844:	00001097          	auipc	ra,0x1
    3848:	0fe080e7          	jalr	254(ra) # 4942 <printf>
    exit(1);
    384c:	4505                	li	a0,1
    384e:	00001097          	auipc	ra,0x1
    3852:	d86080e7          	jalr	-634(ra) # 45d4 <exit>
    printf("%s: sbrk deallocation produced wrong address, a %x c %x\n", a, c);
    3856:	862a                	mv	a2,a0
    3858:	85a6                	mv	a1,s1
    385a:	00003517          	auipc	a0,0x3
    385e:	ace50513          	addi	a0,a0,-1330 # 6328 <malloc+0x192a>
    3862:	00001097          	auipc	ra,0x1
    3866:	0e0080e7          	jalr	224(ra) # 4942 <printf>
    exit(1);
    386a:	4505                	li	a0,1
    386c:	00001097          	auipc	ra,0x1
    3870:	d68080e7          	jalr	-664(ra) # 45d4 <exit>
    printf("%s: sbrk re-allocation failed, a %x c %x\n", a, c);
    3874:	8652                	mv	a2,s4
    3876:	85a6                	mv	a1,s1
    3878:	00003517          	auipc	a0,0x3
    387c:	af050513          	addi	a0,a0,-1296 # 6368 <malloc+0x196a>
    3880:	00001097          	auipc	ra,0x1
    3884:	0c2080e7          	jalr	194(ra) # 4942 <printf>
    exit(1);
    3888:	4505                	li	a0,1
    388a:	00001097          	auipc	ra,0x1
    388e:	d4a080e7          	jalr	-694(ra) # 45d4 <exit>
    printf("%s: sbrk de-allocation didn't really deallocate\n", s);
    3892:	85ce                	mv	a1,s3
    3894:	00003517          	auipc	a0,0x3
    3898:	b0450513          	addi	a0,a0,-1276 # 6398 <malloc+0x199a>
    389c:	00001097          	auipc	ra,0x1
    38a0:	0a6080e7          	jalr	166(ra) # 4942 <printf>
    exit(1);
    38a4:	4505                	li	a0,1
    38a6:	00001097          	auipc	ra,0x1
    38aa:	d2e080e7          	jalr	-722(ra) # 45d4 <exit>
    printf("%s: sbrk downsize failed, a %x c %x\n", a, c);
    38ae:	862a                	mv	a2,a0
    38b0:	85a6                	mv	a1,s1
    38b2:	00003517          	auipc	a0,0x3
    38b6:	b1e50513          	addi	a0,a0,-1250 # 63d0 <malloc+0x19d2>
    38ba:	00001097          	auipc	ra,0x1
    38be:	088080e7          	jalr	136(ra) # 4942 <printf>
    exit(1);
    38c2:	4505                	li	a0,1
    38c4:	00001097          	auipc	ra,0x1
    38c8:	d10080e7          	jalr	-752(ra) # 45d4 <exit>

00000000000038cc <sbrkfail>:
{
    38cc:	7175                	addi	sp,sp,-144
    38ce:	e506                	sd	ra,136(sp)
    38d0:	e122                	sd	s0,128(sp)
    38d2:	fca6                	sd	s1,120(sp)
    38d4:	f8ca                	sd	s2,112(sp)
    38d6:	f4ce                	sd	s3,104(sp)
    38d8:	f0d2                	sd	s4,96(sp)
    38da:	ecd6                	sd	s5,88(sp)
    38dc:	e8da                	sd	s6,80(sp)
    38de:	e4de                	sd	s7,72(sp)
    38e0:	0900                	addi	s0,sp,144
    38e2:	8baa                	mv	s7,a0
  if(pipe(fds) != 0){
    38e4:	fa040513          	addi	a0,s0,-96
    38e8:	00001097          	auipc	ra,0x1
    38ec:	cfc080e7          	jalr	-772(ra) # 45e4 <pipe>
    38f0:	e919                	bnez	a0,3906 <sbrkfail+0x3a>
    38f2:	f7040493          	addi	s1,s0,-144
    38f6:	f9840993          	addi	s3,s0,-104
    38fa:	8926                	mv	s2,s1
    if(pids[i] != -1)
    38fc:	5a7d                	li	s4,-1
      read(fds[0], &scratch, 1);
    38fe:	f9f40b13          	addi	s6,s0,-97
    3902:	4a85                	li	s5,1
    3904:	a08d                	j	3966 <sbrkfail+0x9a>
    printf("%s: pipe() failed\n", s);
    3906:	85de                	mv	a1,s7
    3908:	00002517          	auipc	a0,0x2
    390c:	cd050513          	addi	a0,a0,-816 # 55d8 <malloc+0xbda>
    3910:	00001097          	auipc	ra,0x1
    3914:	032080e7          	jalr	50(ra) # 4942 <printf>
    exit(1);
    3918:	4505                	li	a0,1
    391a:	00001097          	auipc	ra,0x1
    391e:	cba080e7          	jalr	-838(ra) # 45d4 <exit>
      sbrk(BIG - (uint64)sbrk(0));
    3922:	00001097          	auipc	ra,0x1
    3926:	d3a080e7          	jalr	-710(ra) # 465c <sbrk>
    392a:	064007b7          	lui	a5,0x6400
    392e:	40a7853b          	subw	a0,a5,a0
    3932:	00001097          	auipc	ra,0x1
    3936:	d2a080e7          	jalr	-726(ra) # 465c <sbrk>
      write(fds[1], "x", 1);
    393a:	4605                	li	a2,1
    393c:	00002597          	auipc	a1,0x2
    3940:	d1c58593          	addi	a1,a1,-740 # 5658 <malloc+0xc5a>
    3944:	fa442503          	lw	a0,-92(s0)
    3948:	00001097          	auipc	ra,0x1
    394c:	cac080e7          	jalr	-852(ra) # 45f4 <write>
      for(;;) sleep(1000);
    3950:	3e800493          	li	s1,1000
    3954:	8526                	mv	a0,s1
    3956:	00001097          	auipc	ra,0x1
    395a:	d0e080e7          	jalr	-754(ra) # 4664 <sleep>
    395e:	bfdd                	j	3954 <sbrkfail+0x88>
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    3960:	0911                	addi	s2,s2,4
    3962:	03390463          	beq	s2,s3,398a <sbrkfail+0xbe>
    if((pids[i] = fork()) == 0){
    3966:	00001097          	auipc	ra,0x1
    396a:	c66080e7          	jalr	-922(ra) # 45cc <fork>
    396e:	00a92023          	sw	a0,0(s2)
    3972:	d945                	beqz	a0,3922 <sbrkfail+0x56>
    if(pids[i] != -1)
    3974:	ff4506e3          	beq	a0,s4,3960 <sbrkfail+0x94>
      read(fds[0], &scratch, 1);
    3978:	8656                	mv	a2,s5
    397a:	85da                	mv	a1,s6
    397c:	fa042503          	lw	a0,-96(s0)
    3980:	00001097          	auipc	ra,0x1
    3984:	c6c080e7          	jalr	-916(ra) # 45ec <read>
    3988:	bfe1                	j	3960 <sbrkfail+0x94>
  c = sbrk(PGSIZE);
    398a:	6505                	lui	a0,0x1
    398c:	00001097          	auipc	ra,0x1
    3990:	cd0080e7          	jalr	-816(ra) # 465c <sbrk>
    3994:	8a2a                	mv	s4,a0
    if(pids[i] == -1)
    3996:	597d                	li	s2,-1
    3998:	a021                	j	39a0 <sbrkfail+0xd4>
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    399a:	0491                	addi	s1,s1,4
    399c:	01348f63          	beq	s1,s3,39ba <sbrkfail+0xee>
    if(pids[i] == -1)
    39a0:	4088                	lw	a0,0(s1)
    39a2:	ff250ce3          	beq	a0,s2,399a <sbrkfail+0xce>
    kill(pids[i]);
    39a6:	00001097          	auipc	ra,0x1
    39aa:	c5e080e7          	jalr	-930(ra) # 4604 <kill>
    wait(0);
    39ae:	4501                	li	a0,0
    39b0:	00001097          	auipc	ra,0x1
    39b4:	c2c080e7          	jalr	-980(ra) # 45dc <wait>
    39b8:	b7cd                	j	399a <sbrkfail+0xce>
  if(c == (char*)0xffffffffffffffffL){
    39ba:	57fd                	li	a5,-1
    39bc:	04fa0063          	beq	s4,a5,39fc <sbrkfail+0x130>
  pid = fork();
    39c0:	00001097          	auipc	ra,0x1
    39c4:	c0c080e7          	jalr	-1012(ra) # 45cc <fork>
    39c8:	84aa                	mv	s1,a0
  if(pid < 0){
    39ca:	04054763          	bltz	a0,3a18 <sbrkfail+0x14c>
  if(pid == 0){
    39ce:	c13d                	beqz	a0,3a34 <sbrkfail+0x168>
  wait(&xstatus);
    39d0:	fac40513          	addi	a0,s0,-84
    39d4:	00001097          	auipc	ra,0x1
    39d8:	c08080e7          	jalr	-1016(ra) # 45dc <wait>
  if(xstatus != -1)
    39dc:	fac42703          	lw	a4,-84(s0)
    39e0:	57fd                	li	a5,-1
    39e2:	08f71e63          	bne	a4,a5,3a7e <sbrkfail+0x1b2>
}
    39e6:	60aa                	ld	ra,136(sp)
    39e8:	640a                	ld	s0,128(sp)
    39ea:	74e6                	ld	s1,120(sp)
    39ec:	7946                	ld	s2,112(sp)
    39ee:	79a6                	ld	s3,104(sp)
    39f0:	7a06                	ld	s4,96(sp)
    39f2:	6ae6                	ld	s5,88(sp)
    39f4:	6b46                	ld	s6,80(sp)
    39f6:	6ba6                	ld	s7,72(sp)
    39f8:	6149                	addi	sp,sp,144
    39fa:	8082                	ret
    printf("%s: failed sbrk leaked memory\n", s);
    39fc:	85de                	mv	a1,s7
    39fe:	00003517          	auipc	a0,0x3
    3a02:	9fa50513          	addi	a0,a0,-1542 # 63f8 <malloc+0x19fa>
    3a06:	00001097          	auipc	ra,0x1
    3a0a:	f3c080e7          	jalr	-196(ra) # 4942 <printf>
    exit(1);
    3a0e:	4505                	li	a0,1
    3a10:	00001097          	auipc	ra,0x1
    3a14:	bc4080e7          	jalr	-1084(ra) # 45d4 <exit>
    printf("%s: fork failed\n", s);
    3a18:	85de                	mv	a1,s7
    3a1a:	00001517          	auipc	a0,0x1
    3a1e:	26e50513          	addi	a0,a0,622 # 4c88 <malloc+0x28a>
    3a22:	00001097          	auipc	ra,0x1
    3a26:	f20080e7          	jalr	-224(ra) # 4942 <printf>
    exit(1);
    3a2a:	4505                	li	a0,1
    3a2c:	00001097          	auipc	ra,0x1
    3a30:	ba8080e7          	jalr	-1112(ra) # 45d4 <exit>
    a = sbrk(0);
    3a34:	4501                	li	a0,0
    3a36:	00001097          	auipc	ra,0x1
    3a3a:	c26080e7          	jalr	-986(ra) # 465c <sbrk>
    3a3e:	892a                	mv	s2,a0
    sbrk(10*BIG);
    3a40:	3e800537          	lui	a0,0x3e800
    3a44:	00001097          	auipc	ra,0x1
    3a48:	c18080e7          	jalr	-1000(ra) # 465c <sbrk>
    for (i = 0; i < 10*BIG; i += PGSIZE) {
    3a4c:	87ca                	mv	a5,s2
    3a4e:	3e800737          	lui	a4,0x3e800
    3a52:	993a                	add	s2,s2,a4
    3a54:	6705                	lui	a4,0x1
      n += *(a+i);
    3a56:	0007c583          	lbu	a1,0(a5) # 6400000 <__BSS_END__+0x63f3bc0>
    3a5a:	9da5                	addw	a1,a1,s1
    3a5c:	84ae                	mv	s1,a1
    for (i = 0; i < 10*BIG; i += PGSIZE) {
    3a5e:	97ba                	add	a5,a5,a4
    3a60:	fef91be3          	bne	s2,a5,3a56 <sbrkfail+0x18a>
    printf("%s: allocate a lot of memory succeeded %d\n", n);
    3a64:	00003517          	auipc	a0,0x3
    3a68:	9b450513          	addi	a0,a0,-1612 # 6418 <malloc+0x1a1a>
    3a6c:	00001097          	auipc	ra,0x1
    3a70:	ed6080e7          	jalr	-298(ra) # 4942 <printf>
    exit(1);
    3a74:	4505                	li	a0,1
    3a76:	00001097          	auipc	ra,0x1
    3a7a:	b5e080e7          	jalr	-1186(ra) # 45d4 <exit>
    exit(1);
    3a7e:	4505                	li	a0,1
    3a80:	00001097          	auipc	ra,0x1
    3a84:	b54080e7          	jalr	-1196(ra) # 45d4 <exit>

0000000000003a88 <sbrkarg>:
{
    3a88:	7179                	addi	sp,sp,-48
    3a8a:	f406                	sd	ra,40(sp)
    3a8c:	f022                	sd	s0,32(sp)
    3a8e:	ec26                	sd	s1,24(sp)
    3a90:	e84a                	sd	s2,16(sp)
    3a92:	e44e                	sd	s3,8(sp)
    3a94:	1800                	addi	s0,sp,48
    3a96:	89aa                	mv	s3,a0
  a = sbrk(PGSIZE);
    3a98:	6505                	lui	a0,0x1
    3a9a:	00001097          	auipc	ra,0x1
    3a9e:	bc2080e7          	jalr	-1086(ra) # 465c <sbrk>
    3aa2:	892a                	mv	s2,a0
  fd = open("sbrk", O_CREATE|O_WRONLY);
    3aa4:	20100593          	li	a1,513
    3aa8:	00003517          	auipc	a0,0x3
    3aac:	9a050513          	addi	a0,a0,-1632 # 6448 <malloc+0x1a4a>
    3ab0:	00001097          	auipc	ra,0x1
    3ab4:	b64080e7          	jalr	-1180(ra) # 4614 <open>
    3ab8:	84aa                	mv	s1,a0
  unlink("sbrk");
    3aba:	00003517          	auipc	a0,0x3
    3abe:	98e50513          	addi	a0,a0,-1650 # 6448 <malloc+0x1a4a>
    3ac2:	00001097          	auipc	ra,0x1
    3ac6:	b62080e7          	jalr	-1182(ra) # 4624 <unlink>
  if(fd < 0)  {
    3aca:	0404c163          	bltz	s1,3b0c <sbrkarg+0x84>
  if ((n = write(fd, a, PGSIZE)) < 0) {
    3ace:	6605                	lui	a2,0x1
    3ad0:	85ca                	mv	a1,s2
    3ad2:	8526                	mv	a0,s1
    3ad4:	00001097          	auipc	ra,0x1
    3ad8:	b20080e7          	jalr	-1248(ra) # 45f4 <write>
    3adc:	04054663          	bltz	a0,3b28 <sbrkarg+0xa0>
  close(fd);
    3ae0:	8526                	mv	a0,s1
    3ae2:	00001097          	auipc	ra,0x1
    3ae6:	b1a080e7          	jalr	-1254(ra) # 45fc <close>
  a = sbrk(PGSIZE);
    3aea:	6505                	lui	a0,0x1
    3aec:	00001097          	auipc	ra,0x1
    3af0:	b70080e7          	jalr	-1168(ra) # 465c <sbrk>
  if(pipe((int *) a) != 0){
    3af4:	00001097          	auipc	ra,0x1
    3af8:	af0080e7          	jalr	-1296(ra) # 45e4 <pipe>
    3afc:	e521                	bnez	a0,3b44 <sbrkarg+0xbc>
}
    3afe:	70a2                	ld	ra,40(sp)
    3b00:	7402                	ld	s0,32(sp)
    3b02:	64e2                	ld	s1,24(sp)
    3b04:	6942                	ld	s2,16(sp)
    3b06:	69a2                	ld	s3,8(sp)
    3b08:	6145                	addi	sp,sp,48
    3b0a:	8082                	ret
    printf("%s: open sbrk failed\n", s);
    3b0c:	85ce                	mv	a1,s3
    3b0e:	00003517          	auipc	a0,0x3
    3b12:	94250513          	addi	a0,a0,-1726 # 6450 <malloc+0x1a52>
    3b16:	00001097          	auipc	ra,0x1
    3b1a:	e2c080e7          	jalr	-468(ra) # 4942 <printf>
    exit(1);
    3b1e:	4505                	li	a0,1
    3b20:	00001097          	auipc	ra,0x1
    3b24:	ab4080e7          	jalr	-1356(ra) # 45d4 <exit>
    printf("%s: write sbrk failed\n", s);
    3b28:	85ce                	mv	a1,s3
    3b2a:	00003517          	auipc	a0,0x3
    3b2e:	93e50513          	addi	a0,a0,-1730 # 6468 <malloc+0x1a6a>
    3b32:	00001097          	auipc	ra,0x1
    3b36:	e10080e7          	jalr	-496(ra) # 4942 <printf>
    exit(1);
    3b3a:	4505                	li	a0,1
    3b3c:	00001097          	auipc	ra,0x1
    3b40:	a98080e7          	jalr	-1384(ra) # 45d4 <exit>
    printf("%s: pipe() failed\n", s);
    3b44:	85ce                	mv	a1,s3
    3b46:	00002517          	auipc	a0,0x2
    3b4a:	a9250513          	addi	a0,a0,-1390 # 55d8 <malloc+0xbda>
    3b4e:	00001097          	auipc	ra,0x1
    3b52:	df4080e7          	jalr	-524(ra) # 4942 <printf>
    exit(1);
    3b56:	4505                	li	a0,1
    3b58:	00001097          	auipc	ra,0x1
    3b5c:	a7c080e7          	jalr	-1412(ra) # 45d4 <exit>

0000000000003b60 <argptest>:
{
    3b60:	1101                	addi	sp,sp,-32
    3b62:	ec06                	sd	ra,24(sp)
    3b64:	e822                	sd	s0,16(sp)
    3b66:	e426                	sd	s1,8(sp)
    3b68:	e04a                	sd	s2,0(sp)
    3b6a:	1000                	addi	s0,sp,32
    3b6c:	892a                	mv	s2,a0
  fd = open("init", O_RDONLY);
    3b6e:	4581                	li	a1,0
    3b70:	00003517          	auipc	a0,0x3
    3b74:	91050513          	addi	a0,a0,-1776 # 6480 <malloc+0x1a82>
    3b78:	00001097          	auipc	ra,0x1
    3b7c:	a9c080e7          	jalr	-1380(ra) # 4614 <open>
  if (fd < 0) {
    3b80:	02054b63          	bltz	a0,3bb6 <argptest+0x56>
    3b84:	84aa                	mv	s1,a0
  read(fd, sbrk(0) - 1, -1);
    3b86:	4501                	li	a0,0
    3b88:	00001097          	auipc	ra,0x1
    3b8c:	ad4080e7          	jalr	-1324(ra) # 465c <sbrk>
    3b90:	567d                	li	a2,-1
    3b92:	00c505b3          	add	a1,a0,a2
    3b96:	8526                	mv	a0,s1
    3b98:	00001097          	auipc	ra,0x1
    3b9c:	a54080e7          	jalr	-1452(ra) # 45ec <read>
  close(fd);
    3ba0:	8526                	mv	a0,s1
    3ba2:	00001097          	auipc	ra,0x1
    3ba6:	a5a080e7          	jalr	-1446(ra) # 45fc <close>
}
    3baa:	60e2                	ld	ra,24(sp)
    3bac:	6442                	ld	s0,16(sp)
    3bae:	64a2                	ld	s1,8(sp)
    3bb0:	6902                	ld	s2,0(sp)
    3bb2:	6105                	addi	sp,sp,32
    3bb4:	8082                	ret
    printf("%s: open failed\n", s);
    3bb6:	85ca                	mv	a1,s2
    3bb8:	00002517          	auipc	a0,0x2
    3bbc:	8c050513          	addi	a0,a0,-1856 # 5478 <malloc+0xa7a>
    3bc0:	00001097          	auipc	ra,0x1
    3bc4:	d82080e7          	jalr	-638(ra) # 4942 <printf>
    exit(1);
    3bc8:	4505                	li	a0,1
    3bca:	00001097          	auipc	ra,0x1
    3bce:	a0a080e7          	jalr	-1526(ra) # 45d4 <exit>

0000000000003bd2 <sbrkbugs>:
{
    3bd2:	1141                	addi	sp,sp,-16
    3bd4:	e406                	sd	ra,8(sp)
    3bd6:	e022                	sd	s0,0(sp)
    3bd8:	0800                	addi	s0,sp,16
  int pid = fork();
    3bda:	00001097          	auipc	ra,0x1
    3bde:	9f2080e7          	jalr	-1550(ra) # 45cc <fork>
  if(pid < 0){
    3be2:	02054263          	bltz	a0,3c06 <sbrkbugs+0x34>
  if(pid == 0){
    3be6:	ed0d                	bnez	a0,3c20 <sbrkbugs+0x4e>
    int sz = (uint64) sbrk(0);
    3be8:	00001097          	auipc	ra,0x1
    3bec:	a74080e7          	jalr	-1420(ra) # 465c <sbrk>
    sbrk(-sz);
    3bf0:	40a0053b          	negw	a0,a0
    3bf4:	00001097          	auipc	ra,0x1
    3bf8:	a68080e7          	jalr	-1432(ra) # 465c <sbrk>
    exit(0);
    3bfc:	4501                	li	a0,0
    3bfe:	00001097          	auipc	ra,0x1
    3c02:	9d6080e7          	jalr	-1578(ra) # 45d4 <exit>
    printf("fork failed\n");
    3c06:	00002517          	auipc	a0,0x2
    3c0a:	9a250513          	addi	a0,a0,-1630 # 55a8 <malloc+0xbaa>
    3c0e:	00001097          	auipc	ra,0x1
    3c12:	d34080e7          	jalr	-716(ra) # 4942 <printf>
    exit(1);
    3c16:	4505                	li	a0,1
    3c18:	00001097          	auipc	ra,0x1
    3c1c:	9bc080e7          	jalr	-1604(ra) # 45d4 <exit>
  wait(0);
    3c20:	4501                	li	a0,0
    3c22:	00001097          	auipc	ra,0x1
    3c26:	9ba080e7          	jalr	-1606(ra) # 45dc <wait>
  pid = fork();
    3c2a:	00001097          	auipc	ra,0x1
    3c2e:	9a2080e7          	jalr	-1630(ra) # 45cc <fork>
  if(pid < 0){
    3c32:	02054563          	bltz	a0,3c5c <sbrkbugs+0x8a>
  if(pid == 0){
    3c36:	e121                	bnez	a0,3c76 <sbrkbugs+0xa4>
    int sz = (uint64) sbrk(0);
    3c38:	00001097          	auipc	ra,0x1
    3c3c:	a24080e7          	jalr	-1500(ra) # 465c <sbrk>
    sbrk(-(sz - 3500));
    3c40:	6785                	lui	a5,0x1
    3c42:	dac7879b          	addiw	a5,a5,-596 # dac <fourteen+0x7a>
    3c46:	40a7853b          	subw	a0,a5,a0
    3c4a:	00001097          	auipc	ra,0x1
    3c4e:	a12080e7          	jalr	-1518(ra) # 465c <sbrk>
    exit(0);
    3c52:	4501                	li	a0,0
    3c54:	00001097          	auipc	ra,0x1
    3c58:	980080e7          	jalr	-1664(ra) # 45d4 <exit>
    printf("fork failed\n");
    3c5c:	00002517          	auipc	a0,0x2
    3c60:	94c50513          	addi	a0,a0,-1716 # 55a8 <malloc+0xbaa>
    3c64:	00001097          	auipc	ra,0x1
    3c68:	cde080e7          	jalr	-802(ra) # 4942 <printf>
    exit(1);
    3c6c:	4505                	li	a0,1
    3c6e:	00001097          	auipc	ra,0x1
    3c72:	966080e7          	jalr	-1690(ra) # 45d4 <exit>
  wait(0);
    3c76:	4501                	li	a0,0
    3c78:	00001097          	auipc	ra,0x1
    3c7c:	964080e7          	jalr	-1692(ra) # 45dc <wait>
  pid = fork();
    3c80:	00001097          	auipc	ra,0x1
    3c84:	94c080e7          	jalr	-1716(ra) # 45cc <fork>
  if(pid < 0){
    3c88:	02054a63          	bltz	a0,3cbc <sbrkbugs+0xea>
  if(pid == 0){
    3c8c:	e529                	bnez	a0,3cd6 <sbrkbugs+0x104>
    sbrk((10*4096 + 2048) - (uint64)sbrk(0));
    3c8e:	00001097          	auipc	ra,0x1
    3c92:	9ce080e7          	jalr	-1586(ra) # 465c <sbrk>
    3c96:	67ad                	lui	a5,0xb
    3c98:	8007879b          	addiw	a5,a5,-2048 # a800 <buf+0x13d0>
    3c9c:	40a7853b          	subw	a0,a5,a0
    3ca0:	00001097          	auipc	ra,0x1
    3ca4:	9bc080e7          	jalr	-1604(ra) # 465c <sbrk>
    sbrk(-10);
    3ca8:	5559                	li	a0,-10
    3caa:	00001097          	auipc	ra,0x1
    3cae:	9b2080e7          	jalr	-1614(ra) # 465c <sbrk>
    exit(0);
    3cb2:	4501                	li	a0,0
    3cb4:	00001097          	auipc	ra,0x1
    3cb8:	920080e7          	jalr	-1760(ra) # 45d4 <exit>
    printf("fork failed\n");
    3cbc:	00002517          	auipc	a0,0x2
    3cc0:	8ec50513          	addi	a0,a0,-1812 # 55a8 <malloc+0xbaa>
    3cc4:	00001097          	auipc	ra,0x1
    3cc8:	c7e080e7          	jalr	-898(ra) # 4942 <printf>
    exit(1);
    3ccc:	4505                	li	a0,1
    3cce:	00001097          	auipc	ra,0x1
    3cd2:	906080e7          	jalr	-1786(ra) # 45d4 <exit>
  wait(0);
    3cd6:	4501                	li	a0,0
    3cd8:	00001097          	auipc	ra,0x1
    3cdc:	904080e7          	jalr	-1788(ra) # 45dc <wait>
  exit(0);
    3ce0:	4501                	li	a0,0
    3ce2:	00001097          	auipc	ra,0x1
    3ce6:	8f2080e7          	jalr	-1806(ra) # 45d4 <exit>

0000000000003cea <dirtest>:
{
    3cea:	1101                	addi	sp,sp,-32
    3cec:	ec06                	sd	ra,24(sp)
    3cee:	e822                	sd	s0,16(sp)
    3cf0:	e426                	sd	s1,8(sp)
    3cf2:	1000                	addi	s0,sp,32
    3cf4:	84aa                	mv	s1,a0
  printf("mkdir test\n");
    3cf6:	00002517          	auipc	a0,0x2
    3cfa:	79250513          	addi	a0,a0,1938 # 6488 <malloc+0x1a8a>
    3cfe:	00001097          	auipc	ra,0x1
    3d02:	c44080e7          	jalr	-956(ra) # 4942 <printf>
  if(mkdir("dir0") < 0){
    3d06:	00002517          	auipc	a0,0x2
    3d0a:	79250513          	addi	a0,a0,1938 # 6498 <malloc+0x1a9a>
    3d0e:	00001097          	auipc	ra,0x1
    3d12:	92e080e7          	jalr	-1746(ra) # 463c <mkdir>
    3d16:	04054d63          	bltz	a0,3d70 <dirtest+0x86>
  if(chdir("dir0") < 0){
    3d1a:	00002517          	auipc	a0,0x2
    3d1e:	77e50513          	addi	a0,a0,1918 # 6498 <malloc+0x1a9a>
    3d22:	00001097          	auipc	ra,0x1
    3d26:	922080e7          	jalr	-1758(ra) # 4644 <chdir>
    3d2a:	06054163          	bltz	a0,3d8c <dirtest+0xa2>
  if(chdir("..") < 0){
    3d2e:	00001517          	auipc	a0,0x1
    3d32:	eca50513          	addi	a0,a0,-310 # 4bf8 <malloc+0x1fa>
    3d36:	00001097          	auipc	ra,0x1
    3d3a:	90e080e7          	jalr	-1778(ra) # 4644 <chdir>
    3d3e:	06054563          	bltz	a0,3da8 <dirtest+0xbe>
  if(unlink("dir0") < 0){
    3d42:	00002517          	auipc	a0,0x2
    3d46:	75650513          	addi	a0,a0,1878 # 6498 <malloc+0x1a9a>
    3d4a:	00001097          	auipc	ra,0x1
    3d4e:	8da080e7          	jalr	-1830(ra) # 4624 <unlink>
    3d52:	06054963          	bltz	a0,3dc4 <dirtest+0xda>
  printf("%s: mkdir test ok\n");
    3d56:	00002517          	auipc	a0,0x2
    3d5a:	79250513          	addi	a0,a0,1938 # 64e8 <malloc+0x1aea>
    3d5e:	00001097          	auipc	ra,0x1
    3d62:	be4080e7          	jalr	-1052(ra) # 4942 <printf>
}
    3d66:	60e2                	ld	ra,24(sp)
    3d68:	6442                	ld	s0,16(sp)
    3d6a:	64a2                	ld	s1,8(sp)
    3d6c:	6105                	addi	sp,sp,32
    3d6e:	8082                	ret
    printf("%s: mkdir failed\n", s);
    3d70:	85a6                	mv	a1,s1
    3d72:	00001517          	auipc	a0,0x1
    3d76:	da650513          	addi	a0,a0,-602 # 4b18 <malloc+0x11a>
    3d7a:	00001097          	auipc	ra,0x1
    3d7e:	bc8080e7          	jalr	-1080(ra) # 4942 <printf>
    exit(1);
    3d82:	4505                	li	a0,1
    3d84:	00001097          	auipc	ra,0x1
    3d88:	850080e7          	jalr	-1968(ra) # 45d4 <exit>
    printf("%s: chdir dir0 failed\n", s);
    3d8c:	85a6                	mv	a1,s1
    3d8e:	00002517          	auipc	a0,0x2
    3d92:	71250513          	addi	a0,a0,1810 # 64a0 <malloc+0x1aa2>
    3d96:	00001097          	auipc	ra,0x1
    3d9a:	bac080e7          	jalr	-1108(ra) # 4942 <printf>
    exit(1);
    3d9e:	4505                	li	a0,1
    3da0:	00001097          	auipc	ra,0x1
    3da4:	834080e7          	jalr	-1996(ra) # 45d4 <exit>
    printf("%s: chdir .. failed\n", s);
    3da8:	85a6                	mv	a1,s1
    3daa:	00002517          	auipc	a0,0x2
    3dae:	70e50513          	addi	a0,a0,1806 # 64b8 <malloc+0x1aba>
    3db2:	00001097          	auipc	ra,0x1
    3db6:	b90080e7          	jalr	-1136(ra) # 4942 <printf>
    exit(1);
    3dba:	4505                	li	a0,1
    3dbc:	00001097          	auipc	ra,0x1
    3dc0:	818080e7          	jalr	-2024(ra) # 45d4 <exit>
    printf("%s: unlink dir0 failed\n", s);
    3dc4:	85a6                	mv	a1,s1
    3dc6:	00002517          	auipc	a0,0x2
    3dca:	70a50513          	addi	a0,a0,1802 # 64d0 <malloc+0x1ad2>
    3dce:	00001097          	auipc	ra,0x1
    3dd2:	b74080e7          	jalr	-1164(ra) # 4942 <printf>
    exit(1);
    3dd6:	4505                	li	a0,1
    3dd8:	00000097          	auipc	ra,0x0
    3ddc:	7fc080e7          	jalr	2044(ra) # 45d4 <exit>

0000000000003de0 <fsfull>:
{
    3de0:	7171                	addi	sp,sp,-176
    3de2:	f506                	sd	ra,168(sp)
    3de4:	f122                	sd	s0,160(sp)
    3de6:	ed26                	sd	s1,152(sp)
    3de8:	e94a                	sd	s2,144(sp)
    3dea:	e54e                	sd	s3,136(sp)
    3dec:	e152                	sd	s4,128(sp)
    3dee:	fcd6                	sd	s5,120(sp)
    3df0:	f8da                	sd	s6,112(sp)
    3df2:	f4de                	sd	s7,104(sp)
    3df4:	f0e2                	sd	s8,96(sp)
    3df6:	ece6                	sd	s9,88(sp)
    3df8:	e8ea                	sd	s10,80(sp)
    3dfa:	e4ee                	sd	s11,72(sp)
    3dfc:	1900                	addi	s0,sp,176
  printf("fsfull test\n");
    3dfe:	00002517          	auipc	a0,0x2
    3e02:	70250513          	addi	a0,a0,1794 # 6500 <malloc+0x1b02>
    3e06:	00001097          	auipc	ra,0x1
    3e0a:	b3c080e7          	jalr	-1220(ra) # 4942 <printf>
  for(nfiles = 0; ; nfiles++){
    3e0e:	4481                	li	s1,0
    name[0] = 'f';
    3e10:	06600d93          	li	s11,102
    name[1] = '0' + nfiles / 1000;
    3e14:	10625cb7          	lui	s9,0x10625
    3e18:	dd3c8c93          	addi	s9,s9,-557 # 10624dd3 <__BSS_END__+0x10618993>
    name[2] = '0' + (nfiles % 1000) / 100;
    3e1c:	51eb8ab7          	lui	s5,0x51eb8
    3e20:	51fa8a93          	addi	s5,s5,1311 # 51eb851f <__BSS_END__+0x51eac0df>
    name[3] = '0' + (nfiles % 100) / 10;
    3e24:	66666a37          	lui	s4,0x66666
    3e28:	667a0a13          	addi	s4,s4,1639 # 66666667 <__BSS_END__+0x6665a227>
    printf("%s: writing %s\n", name);
    3e2c:	f5040d13          	addi	s10,s0,-176
    name[0] = 'f';
    3e30:	f5b40823          	sb	s11,-176(s0)
    name[1] = '0' + nfiles / 1000;
    3e34:	039487b3          	mul	a5,s1,s9
    3e38:	9799                	srai	a5,a5,0x26
    3e3a:	41f4d69b          	sraiw	a3,s1,0x1f
    3e3e:	9f95                	subw	a5,a5,a3
    3e40:	0307871b          	addiw	a4,a5,48
    3e44:	f4e408a3          	sb	a4,-175(s0)
    name[2] = '0' + (nfiles % 1000) / 100;
    3e48:	3e800713          	li	a4,1000
    3e4c:	02f707bb          	mulw	a5,a4,a5
    3e50:	40f487bb          	subw	a5,s1,a5
    3e54:	03578733          	mul	a4,a5,s5
    3e58:	9715                	srai	a4,a4,0x25
    3e5a:	41f7d79b          	sraiw	a5,a5,0x1f
    3e5e:	40f707bb          	subw	a5,a4,a5
    3e62:	0307879b          	addiw	a5,a5,48
    3e66:	f4f40923          	sb	a5,-174(s0)
    name[3] = '0' + (nfiles % 100) / 10;
    3e6a:	035487b3          	mul	a5,s1,s5
    3e6e:	9795                	srai	a5,a5,0x25
    3e70:	9f95                	subw	a5,a5,a3
    3e72:	06400713          	li	a4,100
    3e76:	02f707bb          	mulw	a5,a4,a5
    3e7a:	40f487bb          	subw	a5,s1,a5
    3e7e:	03478733          	mul	a4,a5,s4
    3e82:	9709                	srai	a4,a4,0x22
    3e84:	41f7d79b          	sraiw	a5,a5,0x1f
    3e88:	40f707bb          	subw	a5,a4,a5
    3e8c:	0307879b          	addiw	a5,a5,48
    3e90:	f4f409a3          	sb	a5,-173(s0)
    name[4] = '0' + (nfiles % 10);
    3e94:	03448733          	mul	a4,s1,s4
    3e98:	9709                	srai	a4,a4,0x22
    3e9a:	9f15                	subw	a4,a4,a3
    3e9c:	0027179b          	slliw	a5,a4,0x2
    3ea0:	9fb9                	addw	a5,a5,a4
    3ea2:	0017979b          	slliw	a5,a5,0x1
    3ea6:	40f487bb          	subw	a5,s1,a5
    3eaa:	0307879b          	addiw	a5,a5,48
    3eae:	f4f40a23          	sb	a5,-172(s0)
    name[5] = '\0';
    3eb2:	f4040aa3          	sb	zero,-171(s0)
    printf("%s: writing %s\n", name);
    3eb6:	85ea                	mv	a1,s10
    3eb8:	00002517          	auipc	a0,0x2
    3ebc:	65850513          	addi	a0,a0,1624 # 6510 <malloc+0x1b12>
    3ec0:	00001097          	auipc	ra,0x1
    3ec4:	a82080e7          	jalr	-1406(ra) # 4942 <printf>
    int fd = open(name, O_CREATE|O_RDWR);
    3ec8:	20200593          	li	a1,514
    3ecc:	856a                	mv	a0,s10
    3ece:	00000097          	auipc	ra,0x0
    3ed2:	746080e7          	jalr	1862(ra) # 4614 <open>
    3ed6:	892a                	mv	s2,a0
    if(fd < 0){
    3ed8:	10055163          	bgez	a0,3fda <fsfull+0x1fa>
      printf("%s: open %s failed\n", name);
    3edc:	f5040593          	addi	a1,s0,-176
    3ee0:	00002517          	auipc	a0,0x2
    3ee4:	64050513          	addi	a0,a0,1600 # 6520 <malloc+0x1b22>
    3ee8:	00001097          	auipc	ra,0x1
    3eec:	a5a080e7          	jalr	-1446(ra) # 4942 <printf>
  while(nfiles >= 0){
    3ef0:	0a04ce63          	bltz	s1,3fac <fsfull+0x1cc>
    name[0] = 'f';
    3ef4:	06600c13          	li	s8,102
    name[1] = '0' + nfiles / 1000;
    3ef8:	10625a37          	lui	s4,0x10625
    3efc:	dd3a0a13          	addi	s4,s4,-557 # 10624dd3 <__BSS_END__+0x10618993>
    name[2] = '0' + (nfiles % 1000) / 100;
    3f00:	3e800b93          	li	s7,1000
    3f04:	51eb89b7          	lui	s3,0x51eb8
    3f08:	51f98993          	addi	s3,s3,1311 # 51eb851f <__BSS_END__+0x51eac0df>
    name[3] = '0' + (nfiles % 100) / 10;
    3f0c:	06400b13          	li	s6,100
    3f10:	66666937          	lui	s2,0x66666
    3f14:	66790913          	addi	s2,s2,1639 # 66666667 <__BSS_END__+0x6665a227>
    unlink(name);
    3f18:	f5040a93          	addi	s5,s0,-176
    name[0] = 'f';
    3f1c:	f5840823          	sb	s8,-176(s0)
    name[1] = '0' + nfiles / 1000;
    3f20:	034487b3          	mul	a5,s1,s4
    3f24:	9799                	srai	a5,a5,0x26
    3f26:	41f4d69b          	sraiw	a3,s1,0x1f
    3f2a:	9f95                	subw	a5,a5,a3
    3f2c:	0307871b          	addiw	a4,a5,48
    3f30:	f4e408a3          	sb	a4,-175(s0)
    name[2] = '0' + (nfiles % 1000) / 100;
    3f34:	02fb87bb          	mulw	a5,s7,a5
    3f38:	40f487bb          	subw	a5,s1,a5
    3f3c:	03378733          	mul	a4,a5,s3
    3f40:	9715                	srai	a4,a4,0x25
    3f42:	41f7d79b          	sraiw	a5,a5,0x1f
    3f46:	40f707bb          	subw	a5,a4,a5
    3f4a:	0307879b          	addiw	a5,a5,48
    3f4e:	f4f40923          	sb	a5,-174(s0)
    name[3] = '0' + (nfiles % 100) / 10;
    3f52:	033487b3          	mul	a5,s1,s3
    3f56:	9795                	srai	a5,a5,0x25
    3f58:	9f95                	subw	a5,a5,a3
    3f5a:	02fb07bb          	mulw	a5,s6,a5
    3f5e:	40f487bb          	subw	a5,s1,a5
    3f62:	03278733          	mul	a4,a5,s2
    3f66:	9709                	srai	a4,a4,0x22
    3f68:	41f7d79b          	sraiw	a5,a5,0x1f
    3f6c:	40f707bb          	subw	a5,a4,a5
    3f70:	0307879b          	addiw	a5,a5,48
    3f74:	f4f409a3          	sb	a5,-173(s0)
    name[4] = '0' + (nfiles % 10);
    3f78:	03248733          	mul	a4,s1,s2
    3f7c:	9709                	srai	a4,a4,0x22
    3f7e:	9f15                	subw	a4,a4,a3
    3f80:	0027179b          	slliw	a5,a4,0x2
    3f84:	9fb9                	addw	a5,a5,a4
    3f86:	0017979b          	slliw	a5,a5,0x1
    3f8a:	40f487bb          	subw	a5,s1,a5
    3f8e:	0307879b          	addiw	a5,a5,48
    3f92:	f4f40a23          	sb	a5,-172(s0)
    name[5] = '\0';
    3f96:	f4040aa3          	sb	zero,-171(s0)
    unlink(name);
    3f9a:	8556                	mv	a0,s5
    3f9c:	00000097          	auipc	ra,0x0
    3fa0:	688080e7          	jalr	1672(ra) # 4624 <unlink>
    nfiles--;
    3fa4:	34fd                	addiw	s1,s1,-1
  while(nfiles >= 0){
    3fa6:	57fd                	li	a5,-1
    3fa8:	f6f49ae3          	bne	s1,a5,3f1c <fsfull+0x13c>
  printf("fsfull test finished\n");
    3fac:	00002517          	auipc	a0,0x2
    3fb0:	5a450513          	addi	a0,a0,1444 # 6550 <malloc+0x1b52>
    3fb4:	00001097          	auipc	ra,0x1
    3fb8:	98e080e7          	jalr	-1650(ra) # 4942 <printf>
}
    3fbc:	70aa                	ld	ra,168(sp)
    3fbe:	740a                	ld	s0,160(sp)
    3fc0:	64ea                	ld	s1,152(sp)
    3fc2:	694a                	ld	s2,144(sp)
    3fc4:	69aa                	ld	s3,136(sp)
    3fc6:	6a0a                	ld	s4,128(sp)
    3fc8:	7ae6                	ld	s5,120(sp)
    3fca:	7b46                	ld	s6,112(sp)
    3fcc:	7ba6                	ld	s7,104(sp)
    3fce:	7c06                	ld	s8,96(sp)
    3fd0:	6ce6                	ld	s9,88(sp)
    3fd2:	6d46                	ld	s10,80(sp)
    3fd4:	6da6                	ld	s11,72(sp)
    3fd6:	614d                	addi	sp,sp,176
    3fd8:	8082                	ret
    int total = 0;
    3fda:	4981                	li	s3,0
      int cc = write(fd, buf, BSIZE);
    3fdc:	40000c13          	li	s8,1024
    3fe0:	00005b97          	auipc	s7,0x5
    3fe4:	450b8b93          	addi	s7,s7,1104 # 9430 <buf>
      if(cc < BSIZE)
    3fe8:	3ff00b13          	li	s6,1023
      int cc = write(fd, buf, BSIZE);
    3fec:	8662                	mv	a2,s8
    3fee:	85de                	mv	a1,s7
    3ff0:	854a                	mv	a0,s2
    3ff2:	00000097          	auipc	ra,0x0
    3ff6:	602080e7          	jalr	1538(ra) # 45f4 <write>
      if(cc < BSIZE)
    3ffa:	00ab5563          	bge	s6,a0,4004 <fsfull+0x224>
      total += cc;
    3ffe:	00a989bb          	addw	s3,s3,a0
    while(1){
    4002:	b7ed                	j	3fec <fsfull+0x20c>
    printf("%s: wrote %d bytes\n", total);
    4004:	85ce                	mv	a1,s3
    4006:	00002517          	auipc	a0,0x2
    400a:	53250513          	addi	a0,a0,1330 # 6538 <malloc+0x1b3a>
    400e:	00001097          	auipc	ra,0x1
    4012:	934080e7          	jalr	-1740(ra) # 4942 <printf>
    close(fd);
    4016:	854a                	mv	a0,s2
    4018:	00000097          	auipc	ra,0x0
    401c:	5e4080e7          	jalr	1508(ra) # 45fc <close>
    if(total == 0)
    4020:	ec0988e3          	beqz	s3,3ef0 <fsfull+0x110>
  for(nfiles = 0; ; nfiles++){
    4024:	2485                	addiw	s1,s1,1
    4026:	b529                	j	3e30 <fsfull+0x50>

0000000000004028 <rand>:
{
    4028:	1141                	addi	sp,sp,-16
    402a:	e406                	sd	ra,8(sp)
    402c:	e022                	sd	s0,0(sp)
    402e:	0800                	addi	s0,sp,16
  randstate = randstate * 1664525 + 1013904223;
    4030:	00003717          	auipc	a4,0x3
    4034:	bd870713          	addi	a4,a4,-1064 # 6c08 <randstate>
    4038:	6308                	ld	a0,0(a4)
    403a:	001967b7          	lui	a5,0x196
    403e:	60d78793          	addi	a5,a5,1549 # 19660d <__BSS_END__+0x18a1cd>
    4042:	02f50533          	mul	a0,a0,a5
    4046:	3c6ef7b7          	lui	a5,0x3c6ef
    404a:	35f78793          	addi	a5,a5,863 # 3c6ef35f <__BSS_END__+0x3c6e2f1f>
    404e:	953e                	add	a0,a0,a5
    4050:	e308                	sd	a0,0(a4)
}
    4052:	2501                	sext.w	a0,a0
    4054:	60a2                	ld	ra,8(sp)
    4056:	6402                	ld	s0,0(sp)
    4058:	0141                	addi	sp,sp,16
    405a:	8082                	ret

000000000000405c <badwrite>:
{
    405c:	7139                	addi	sp,sp,-64
    405e:	fc06                	sd	ra,56(sp)
    4060:	f822                	sd	s0,48(sp)
    4062:	f426                	sd	s1,40(sp)
    4064:	f04a                	sd	s2,32(sp)
    4066:	ec4e                	sd	s3,24(sp)
    4068:	e852                	sd	s4,16(sp)
    406a:	e456                	sd	s5,8(sp)
    406c:	e05a                	sd	s6,0(sp)
    406e:	0080                	addi	s0,sp,64
  unlink("junk");
    4070:	00002517          	auipc	a0,0x2
    4074:	4f850513          	addi	a0,a0,1272 # 6568 <malloc+0x1b6a>
    4078:	00000097          	auipc	ra,0x0
    407c:	5ac080e7          	jalr	1452(ra) # 4624 <unlink>
    4080:	25800913          	li	s2,600
    int fd = open("junk", O_CREATE|O_WRONLY);
    4084:	20100a93          	li	s5,513
    4088:	00002997          	auipc	s3,0x2
    408c:	4e098993          	addi	s3,s3,1248 # 6568 <malloc+0x1b6a>
    write(fd, (char*)0xffffffffffL, 1);
    4090:	4b05                	li	s6,1
    4092:	5a7d                	li	s4,-1
    4094:	018a5a13          	srli	s4,s4,0x18
    int fd = open("junk", O_CREATE|O_WRONLY);
    4098:	85d6                	mv	a1,s5
    409a:	854e                	mv	a0,s3
    409c:	00000097          	auipc	ra,0x0
    40a0:	578080e7          	jalr	1400(ra) # 4614 <open>
    40a4:	84aa                	mv	s1,a0
    if(fd < 0){
    40a6:	06054b63          	bltz	a0,411c <badwrite+0xc0>
    write(fd, (char*)0xffffffffffL, 1);
    40aa:	865a                	mv	a2,s6
    40ac:	85d2                	mv	a1,s4
    40ae:	00000097          	auipc	ra,0x0
    40b2:	546080e7          	jalr	1350(ra) # 45f4 <write>
    close(fd);
    40b6:	8526                	mv	a0,s1
    40b8:	00000097          	auipc	ra,0x0
    40bc:	544080e7          	jalr	1348(ra) # 45fc <close>
    unlink("junk");
    40c0:	854e                	mv	a0,s3
    40c2:	00000097          	auipc	ra,0x0
    40c6:	562080e7          	jalr	1378(ra) # 4624 <unlink>
  for(int i = 0; i < assumed_free; i++){
    40ca:	397d                	addiw	s2,s2,-1
    40cc:	fc0916e3          	bnez	s2,4098 <badwrite+0x3c>
  int fd = open("junk", O_CREATE|O_WRONLY);
    40d0:	20100593          	li	a1,513
    40d4:	00002517          	auipc	a0,0x2
    40d8:	49450513          	addi	a0,a0,1172 # 6568 <malloc+0x1b6a>
    40dc:	00000097          	auipc	ra,0x0
    40e0:	538080e7          	jalr	1336(ra) # 4614 <open>
    40e4:	84aa                	mv	s1,a0
  if(fd < 0){
    40e6:	04054863          	bltz	a0,4136 <badwrite+0xda>
  if(write(fd, "x", 1) != 1){
    40ea:	4605                	li	a2,1
    40ec:	00001597          	auipc	a1,0x1
    40f0:	56c58593          	addi	a1,a1,1388 # 5658 <malloc+0xc5a>
    40f4:	00000097          	auipc	ra,0x0
    40f8:	500080e7          	jalr	1280(ra) # 45f4 <write>
    40fc:	4785                	li	a5,1
    40fe:	04f50963          	beq	a0,a5,4150 <badwrite+0xf4>
    printf("write failed\n");
    4102:	00002517          	auipc	a0,0x2
    4106:	48650513          	addi	a0,a0,1158 # 6588 <malloc+0x1b8a>
    410a:	00001097          	auipc	ra,0x1
    410e:	838080e7          	jalr	-1992(ra) # 4942 <printf>
    exit(1);
    4112:	4505                	li	a0,1
    4114:	00000097          	auipc	ra,0x0
    4118:	4c0080e7          	jalr	1216(ra) # 45d4 <exit>
      printf("open junk failed\n");
    411c:	00002517          	auipc	a0,0x2
    4120:	45450513          	addi	a0,a0,1108 # 6570 <malloc+0x1b72>
    4124:	00001097          	auipc	ra,0x1
    4128:	81e080e7          	jalr	-2018(ra) # 4942 <printf>
      exit(1);
    412c:	4505                	li	a0,1
    412e:	00000097          	auipc	ra,0x0
    4132:	4a6080e7          	jalr	1190(ra) # 45d4 <exit>
    printf("open junk failed\n");
    4136:	00002517          	auipc	a0,0x2
    413a:	43a50513          	addi	a0,a0,1082 # 6570 <malloc+0x1b72>
    413e:	00001097          	auipc	ra,0x1
    4142:	804080e7          	jalr	-2044(ra) # 4942 <printf>
    exit(1);
    4146:	4505                	li	a0,1
    4148:	00000097          	auipc	ra,0x0
    414c:	48c080e7          	jalr	1164(ra) # 45d4 <exit>
  close(fd);
    4150:	8526                	mv	a0,s1
    4152:	00000097          	auipc	ra,0x0
    4156:	4aa080e7          	jalr	1194(ra) # 45fc <close>
  unlink("junk");
    415a:	00002517          	auipc	a0,0x2
    415e:	40e50513          	addi	a0,a0,1038 # 6568 <malloc+0x1b6a>
    4162:	00000097          	auipc	ra,0x0
    4166:	4c2080e7          	jalr	1218(ra) # 4624 <unlink>
  exit(0);
    416a:	4501                	li	a0,0
    416c:	00000097          	auipc	ra,0x0
    4170:	468080e7          	jalr	1128(ra) # 45d4 <exit>

0000000000004174 <run>:
}

// run each test in its own process. run returns 1 if child's exit()
// indicates success.
int
run(void f(char *), char *s) {
    4174:	7179                	addi	sp,sp,-48
    4176:	f406                	sd	ra,40(sp)
    4178:	f022                	sd	s0,32(sp)
    417a:	ec26                	sd	s1,24(sp)
    417c:	e84a                	sd	s2,16(sp)
    417e:	1800                	addi	s0,sp,48
    4180:	892a                	mv	s2,a0
    4182:	84ae                	mv	s1,a1
  int pid;
  int xstatus;
  
  printf("test %s: ", s);
    4184:	00002517          	auipc	a0,0x2
    4188:	41450513          	addi	a0,a0,1044 # 6598 <malloc+0x1b9a>
    418c:	00000097          	auipc	ra,0x0
    4190:	7b6080e7          	jalr	1974(ra) # 4942 <printf>
  if((pid = fork()) < 0) {
    4194:	00000097          	auipc	ra,0x0
    4198:	438080e7          	jalr	1080(ra) # 45cc <fork>
    419c:	02054f63          	bltz	a0,41da <run+0x66>
    printf("runtest: fork error\n");
    exit(1);
  }
  if(pid == 0) {
    41a0:	c931                	beqz	a0,41f4 <run+0x80>
    f(s);
    exit(0);
  } else {
    wait(&xstatus);
    41a2:	fdc40513          	addi	a0,s0,-36
    41a6:	00000097          	auipc	ra,0x0
    41aa:	436080e7          	jalr	1078(ra) # 45dc <wait>
    if(xstatus != 0) 
    41ae:	fdc42783          	lw	a5,-36(s0)
    41b2:	cba1                	beqz	a5,4202 <run+0x8e>
      printf("FAILED\n", s);
    41b4:	85a6                	mv	a1,s1
    41b6:	00002517          	auipc	a0,0x2
    41ba:	40a50513          	addi	a0,a0,1034 # 65c0 <malloc+0x1bc2>
    41be:	00000097          	auipc	ra,0x0
    41c2:	784080e7          	jalr	1924(ra) # 4942 <printf>
    else
      printf("OK\n", s);
    return xstatus == 0;
    41c6:	fdc42503          	lw	a0,-36(s0)
  }
}
    41ca:	00153513          	seqz	a0,a0
    41ce:	70a2                	ld	ra,40(sp)
    41d0:	7402                	ld	s0,32(sp)
    41d2:	64e2                	ld	s1,24(sp)
    41d4:	6942                	ld	s2,16(sp)
    41d6:	6145                	addi	sp,sp,48
    41d8:	8082                	ret
    printf("runtest: fork error\n");
    41da:	00002517          	auipc	a0,0x2
    41de:	3ce50513          	addi	a0,a0,974 # 65a8 <malloc+0x1baa>
    41e2:	00000097          	auipc	ra,0x0
    41e6:	760080e7          	jalr	1888(ra) # 4942 <printf>
    exit(1);
    41ea:	4505                	li	a0,1
    41ec:	00000097          	auipc	ra,0x0
    41f0:	3e8080e7          	jalr	1000(ra) # 45d4 <exit>
    f(s);
    41f4:	8526                	mv	a0,s1
    41f6:	9902                	jalr	s2
    exit(0);
    41f8:	4501                	li	a0,0
    41fa:	00000097          	auipc	ra,0x0
    41fe:	3da080e7          	jalr	986(ra) # 45d4 <exit>
      printf("OK\n", s);
    4202:	85a6                	mv	a1,s1
    4204:	00002517          	auipc	a0,0x2
    4208:	3c450513          	addi	a0,a0,964 # 65c8 <malloc+0x1bca>
    420c:	00000097          	auipc	ra,0x0
    4210:	736080e7          	jalr	1846(ra) # 4942 <printf>
    4214:	bf4d                	j	41c6 <run+0x52>

0000000000004216 <main>:

int
main(int argc, char *argv[])
{
    4216:	ce010113          	addi	sp,sp,-800
    421a:	30113c23          	sd	ra,792(sp)
    421e:	30813823          	sd	s0,784(sp)
    4222:	30913423          	sd	s1,776(sp)
    4226:	31213023          	sd	s2,768(sp)
    422a:	2f313c23          	sd	s3,760(sp)
    422e:	2f413823          	sd	s4,752(sp)
    4232:	1600                	addi	s0,sp,800
  char *n = 0;
  if(argc > 1) {
    4234:	4785                	li	a5,1
  char *n = 0;
    4236:	4981                	li	s3,0
  if(argc > 1) {
    4238:	00a7d463          	bge	a5,a0,4240 <main+0x2a>
    n = argv[1];
    423c:	0085b983          	ld	s3,8(a1)
  }
  
  struct test {
    void (*f)(char *);
    char *s;
  } tests[] = {
    4240:	00002797          	auipc	a5,0x2
    4244:	66878793          	addi	a5,a5,1640 # 68a8 <malloc+0x1eaa>
    4248:	ce040713          	addi	a4,s0,-800
    424c:	00003697          	auipc	a3,0x3
    4250:	93c68693          	addi	a3,a3,-1732 # 6b88 <malloc+0x218a>
    4254:	6388                	ld	a0,0(a5)
    4256:	678c                	ld	a1,8(a5)
    4258:	6b90                	ld	a2,16(a5)
    425a:	e308                	sd	a0,0(a4)
    425c:	e70c                	sd	a1,8(a4)
    425e:	eb10                	sd	a2,16(a4)
    4260:	6f90                	ld	a2,24(a5)
    4262:	ef10                	sd	a2,24(a4)
    4264:	02078793          	addi	a5,a5,32
    4268:	02070713          	addi	a4,a4,32
    426c:	fed794e3          	bne	a5,a3,4254 <main+0x3e>
    4270:	6394                	ld	a3,0(a5)
    4272:	e314                	sd	a3,0(a4)
    4274:	679c                	ld	a5,8(a5)
    4276:	e71c                	sd	a5,8(a4)
    {forktest, "forktest"},
    {bigdir, "bigdir"}, // slow
    { 0, 0},
  };
    
  printf("usertests starting\n");
    4278:	00002517          	auipc	a0,0x2
    427c:	35850513          	addi	a0,a0,856 # 65d0 <malloc+0x1bd2>
    4280:	00000097          	auipc	ra,0x0
    4284:	6c2080e7          	jalr	1730(ra) # 4942 <printf>

  if(open("usertests.ran", 0) >= 0){
    4288:	4581                	li	a1,0
    428a:	00002517          	auipc	a0,0x2
    428e:	35e50513          	addi	a0,a0,862 # 65e8 <malloc+0x1bea>
    4292:	00000097          	auipc	ra,0x0
    4296:	382080e7          	jalr	898(ra) # 4614 <open>
    429a:	00054f63          	bltz	a0,42b8 <main+0xa2>
    printf("already ran user tests -- rebuild fs.img (rm fs.img; make fs.img)\n");
    429e:	00002517          	auipc	a0,0x2
    42a2:	35a50513          	addi	a0,a0,858 # 65f8 <malloc+0x1bfa>
    42a6:	00000097          	auipc	ra,0x0
    42aa:	69c080e7          	jalr	1692(ra) # 4942 <printf>
    exit(1);
    42ae:	4505                	li	a0,1
    42b0:	00000097          	auipc	ra,0x0
    42b4:	324080e7          	jalr	804(ra) # 45d4 <exit>
  }
  close(open("usertests.ran", O_CREATE));
    42b8:	20000593          	li	a1,512
    42bc:	00002517          	auipc	a0,0x2
    42c0:	32c50513          	addi	a0,a0,812 # 65e8 <malloc+0x1bea>
    42c4:	00000097          	auipc	ra,0x0
    42c8:	350080e7          	jalr	848(ra) # 4614 <open>
    42cc:	00000097          	auipc	ra,0x0
    42d0:	330080e7          	jalr	816(ra) # 45fc <close>

  int fail = 0;
  for (struct test *t = tests; t->s != 0; t++) {
    42d4:	ce843903          	ld	s2,-792(s0)
    42d8:	04090a63          	beqz	s2,432c <main+0x116>
    42dc:	ce040493          	addi	s1,s0,-800
  int fail = 0;
    42e0:	4a01                	li	s4,0
    42e2:	a005                	j	4302 <main+0xec>
    if((n == 0) || strcmp(t->s, n) == 0) {
      if(!run(t->f, t->s))
    42e4:	85ca                	mv	a1,s2
    42e6:	6088                	ld	a0,0(s1)
    42e8:	00000097          	auipc	ra,0x0
    42ec:	e8c080e7          	jalr	-372(ra) # 4174 <run>
    42f0:	00153513          	seqz	a0,a0
    42f4:	00aa6a33          	or	s4,s4,a0
  for (struct test *t = tests; t->s != 0; t++) {
    42f8:	04c1                	addi	s1,s1,16
    42fa:	0084b903          	ld	s2,8(s1)
    42fe:	00090c63          	beqz	s2,4316 <main+0x100>
    if((n == 0) || strcmp(t->s, n) == 0) {
    4302:	fe0981e3          	beqz	s3,42e4 <main+0xce>
    4306:	85ce                	mv	a1,s3
    4308:	854a                	mv	a0,s2
    430a:	00000097          	auipc	ra,0x0
    430e:	05c080e7          	jalr	92(ra) # 4366 <strcmp>
    4312:	f17d                	bnez	a0,42f8 <main+0xe2>
    4314:	bfc1                	j	42e4 <main+0xce>
        fail = 1;
    }
  }
  if(!fail)
    4316:	000a0b63          	beqz	s4,432c <main+0x116>
    printf("ALL TESTS PASSED\n");
  else
    printf("SOME TESTS FAILED\n");
    431a:	00002517          	auipc	a0,0x2
    431e:	33e50513          	addi	a0,a0,830 # 6658 <malloc+0x1c5a>
    4322:	00000097          	auipc	ra,0x0
    4326:	620080e7          	jalr	1568(ra) # 4942 <printf>
    432a:	a809                	j	433c <main+0x126>
    printf("ALL TESTS PASSED\n");
    432c:	00002517          	auipc	a0,0x2
    4330:	31450513          	addi	a0,a0,788 # 6640 <malloc+0x1c42>
    4334:	00000097          	auipc	ra,0x0
    4338:	60e080e7          	jalr	1550(ra) # 4942 <printf>
  exit(1);   // not reached.
    433c:	4505                	li	a0,1
    433e:	00000097          	auipc	ra,0x0
    4342:	296080e7          	jalr	662(ra) # 45d4 <exit>

0000000000004346 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
    4346:	1141                	addi	sp,sp,-16
    4348:	e406                	sd	ra,8(sp)
    434a:	e022                	sd	s0,0(sp)
    434c:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    434e:	87aa                	mv	a5,a0
    4350:	0585                	addi	a1,a1,1
    4352:	0785                	addi	a5,a5,1
    4354:	fff5c703          	lbu	a4,-1(a1)
    4358:	fee78fa3          	sb	a4,-1(a5)
    435c:	fb75                	bnez	a4,4350 <strcpy+0xa>
    ;
  return os;
}
    435e:	60a2                	ld	ra,8(sp)
    4360:	6402                	ld	s0,0(sp)
    4362:	0141                	addi	sp,sp,16
    4364:	8082                	ret

0000000000004366 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    4366:	1141                	addi	sp,sp,-16
    4368:	e406                	sd	ra,8(sp)
    436a:	e022                	sd	s0,0(sp)
    436c:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
    436e:	00054783          	lbu	a5,0(a0)
    4372:	cb91                	beqz	a5,4386 <strcmp+0x20>
    4374:	0005c703          	lbu	a4,0(a1)
    4378:	00f71763          	bne	a4,a5,4386 <strcmp+0x20>
    p++, q++;
    437c:	0505                	addi	a0,a0,1
    437e:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
    4380:	00054783          	lbu	a5,0(a0)
    4384:	fbe5                	bnez	a5,4374 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
    4386:	0005c503          	lbu	a0,0(a1)
}
    438a:	40a7853b          	subw	a0,a5,a0
    438e:	60a2                	ld	ra,8(sp)
    4390:	6402                	ld	s0,0(sp)
    4392:	0141                	addi	sp,sp,16
    4394:	8082                	ret

0000000000004396 <strlen>:

uint
strlen(const char *s)
{
    4396:	1141                	addi	sp,sp,-16
    4398:	e406                	sd	ra,8(sp)
    439a:	e022                	sd	s0,0(sp)
    439c:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    439e:	00054783          	lbu	a5,0(a0)
    43a2:	cf91                	beqz	a5,43be <strlen+0x28>
    43a4:	00150793          	addi	a5,a0,1
    43a8:	86be                	mv	a3,a5
    43aa:	0785                	addi	a5,a5,1
    43ac:	fff7c703          	lbu	a4,-1(a5)
    43b0:	ff65                	bnez	a4,43a8 <strlen+0x12>
    43b2:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
    43b6:	60a2                	ld	ra,8(sp)
    43b8:	6402                	ld	s0,0(sp)
    43ba:	0141                	addi	sp,sp,16
    43bc:	8082                	ret
  for(n = 0; s[n]; n++)
    43be:	4501                	li	a0,0
    43c0:	bfdd                	j	43b6 <strlen+0x20>

00000000000043c2 <memset>:

void*
memset(void *dst, int c, uint n)
{
    43c2:	1141                	addi	sp,sp,-16
    43c4:	e406                	sd	ra,8(sp)
    43c6:	e022                	sd	s0,0(sp)
    43c8:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    43ca:	ca19                	beqz	a2,43e0 <memset+0x1e>
    43cc:	87aa                	mv	a5,a0
    43ce:	1602                	slli	a2,a2,0x20
    43d0:	9201                	srli	a2,a2,0x20
    43d2:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    43d6:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    43da:	0785                	addi	a5,a5,1
    43dc:	fee79de3          	bne	a5,a4,43d6 <memset+0x14>
  }
  return dst;
}
    43e0:	60a2                	ld	ra,8(sp)
    43e2:	6402                	ld	s0,0(sp)
    43e4:	0141                	addi	sp,sp,16
    43e6:	8082                	ret

00000000000043e8 <strchr>:

char*
strchr(const char *s, char c)
{
    43e8:	1141                	addi	sp,sp,-16
    43ea:	e406                	sd	ra,8(sp)
    43ec:	e022                	sd	s0,0(sp)
    43ee:	0800                	addi	s0,sp,16
  for(; *s; s++)
    43f0:	00054783          	lbu	a5,0(a0)
    43f4:	cf81                	beqz	a5,440c <strchr+0x24>
    if(*s == c)
    43f6:	00f58763          	beq	a1,a5,4404 <strchr+0x1c>
  for(; *s; s++)
    43fa:	0505                	addi	a0,a0,1
    43fc:	00054783          	lbu	a5,0(a0)
    4400:	fbfd                	bnez	a5,43f6 <strchr+0xe>
      return (char*)s;
  return 0;
    4402:	4501                	li	a0,0
}
    4404:	60a2                	ld	ra,8(sp)
    4406:	6402                	ld	s0,0(sp)
    4408:	0141                	addi	sp,sp,16
    440a:	8082                	ret
  return 0;
    440c:	4501                	li	a0,0
    440e:	bfdd                	j	4404 <strchr+0x1c>

0000000000004410 <gets>:

char*
gets(char *buf, int max)
{
    4410:	711d                	addi	sp,sp,-96
    4412:	ec86                	sd	ra,88(sp)
    4414:	e8a2                	sd	s0,80(sp)
    4416:	e4a6                	sd	s1,72(sp)
    4418:	e0ca                	sd	s2,64(sp)
    441a:	fc4e                	sd	s3,56(sp)
    441c:	f852                	sd	s4,48(sp)
    441e:	f456                	sd	s5,40(sp)
    4420:	f05a                	sd	s6,32(sp)
    4422:	ec5e                	sd	s7,24(sp)
    4424:	e862                	sd	s8,16(sp)
    4426:	1080                	addi	s0,sp,96
    4428:	8baa                	mv	s7,a0
    442a:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    442c:	892a                	mv	s2,a0
    442e:	4481                	li	s1,0
    cc = read(0, &c, 1);
    4430:	faf40b13          	addi	s6,s0,-81
    4434:	4a85                	li	s5,1
  for(i=0; i+1 < max; ){
    4436:	8c26                	mv	s8,s1
    4438:	0014899b          	addiw	s3,s1,1
    443c:	84ce                	mv	s1,s3
    443e:	0349d663          	bge	s3,s4,446a <gets+0x5a>
    cc = read(0, &c, 1);
    4442:	8656                	mv	a2,s5
    4444:	85da                	mv	a1,s6
    4446:	4501                	li	a0,0
    4448:	00000097          	auipc	ra,0x0
    444c:	1a4080e7          	jalr	420(ra) # 45ec <read>
    if(cc < 1)
    4450:	00a05d63          	blez	a0,446a <gets+0x5a>
      break;
    buf[i++] = c;
    4454:	faf44783          	lbu	a5,-81(s0)
    4458:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
    445c:	0905                	addi	s2,s2,1
    445e:	ff678713          	addi	a4,a5,-10
    4462:	c319                	beqz	a4,4468 <gets+0x58>
    4464:	17cd                	addi	a5,a5,-13
    4466:	fbe1                	bnez	a5,4436 <gets+0x26>
    buf[i++] = c;
    4468:	8c4e                	mv	s8,s3
      break;
  }
  buf[i] = '\0';
    446a:	9c5e                	add	s8,s8,s7
    446c:	000c0023          	sb	zero,0(s8)
  return buf;
}
    4470:	855e                	mv	a0,s7
    4472:	60e6                	ld	ra,88(sp)
    4474:	6446                	ld	s0,80(sp)
    4476:	64a6                	ld	s1,72(sp)
    4478:	6906                	ld	s2,64(sp)
    447a:	79e2                	ld	s3,56(sp)
    447c:	7a42                	ld	s4,48(sp)
    447e:	7aa2                	ld	s5,40(sp)
    4480:	7b02                	ld	s6,32(sp)
    4482:	6be2                	ld	s7,24(sp)
    4484:	6c42                	ld	s8,16(sp)
    4486:	6125                	addi	sp,sp,96
    4488:	8082                	ret

000000000000448a <stat>:

int
stat(const char *n, struct stat *st)
{
    448a:	1101                	addi	sp,sp,-32
    448c:	ec06                	sd	ra,24(sp)
    448e:	e822                	sd	s0,16(sp)
    4490:	e04a                	sd	s2,0(sp)
    4492:	1000                	addi	s0,sp,32
    4494:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    4496:	4581                	li	a1,0
    4498:	00000097          	auipc	ra,0x0
    449c:	17c080e7          	jalr	380(ra) # 4614 <open>
  if(fd < 0)
    44a0:	02054663          	bltz	a0,44cc <stat+0x42>
    44a4:	e426                	sd	s1,8(sp)
    44a6:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
    44a8:	85ca                	mv	a1,s2
    44aa:	00000097          	auipc	ra,0x0
    44ae:	182080e7          	jalr	386(ra) # 462c <fstat>
    44b2:	892a                	mv	s2,a0
  close(fd);
    44b4:	8526                	mv	a0,s1
    44b6:	00000097          	auipc	ra,0x0
    44ba:	146080e7          	jalr	326(ra) # 45fc <close>
  return r;
    44be:	64a2                	ld	s1,8(sp)
}
    44c0:	854a                	mv	a0,s2
    44c2:	60e2                	ld	ra,24(sp)
    44c4:	6442                	ld	s0,16(sp)
    44c6:	6902                	ld	s2,0(sp)
    44c8:	6105                	addi	sp,sp,32
    44ca:	8082                	ret
    return -1;
    44cc:	57fd                	li	a5,-1
    44ce:	893e                	mv	s2,a5
    44d0:	bfc5                	j	44c0 <stat+0x36>

00000000000044d2 <atoi>:

int
atoi(const char *s)
{
    44d2:	1141                	addi	sp,sp,-16
    44d4:	e406                	sd	ra,8(sp)
    44d6:	e022                	sd	s0,0(sp)
    44d8:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    44da:	00054683          	lbu	a3,0(a0)
    44de:	fd06879b          	addiw	a5,a3,-48
    44e2:	0ff7f793          	zext.b	a5,a5
    44e6:	4625                	li	a2,9
    44e8:	02f66963          	bltu	a2,a5,451a <atoi+0x48>
    44ec:	872a                	mv	a4,a0
  n = 0;
    44ee:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
    44f0:	0705                	addi	a4,a4,1
    44f2:	0025179b          	slliw	a5,a0,0x2
    44f6:	9fa9                	addw	a5,a5,a0
    44f8:	0017979b          	slliw	a5,a5,0x1
    44fc:	9fb5                	addw	a5,a5,a3
    44fe:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
    4502:	00074683          	lbu	a3,0(a4)
    4506:	fd06879b          	addiw	a5,a3,-48
    450a:	0ff7f793          	zext.b	a5,a5
    450e:	fef671e3          	bgeu	a2,a5,44f0 <atoi+0x1e>
  return n;
}
    4512:	60a2                	ld	ra,8(sp)
    4514:	6402                	ld	s0,0(sp)
    4516:	0141                	addi	sp,sp,16
    4518:	8082                	ret
  n = 0;
    451a:	4501                	li	a0,0
    451c:	bfdd                	j	4512 <atoi+0x40>

000000000000451e <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    451e:	1141                	addi	sp,sp,-16
    4520:	e406                	sd	ra,8(sp)
    4522:	e022                	sd	s0,0(sp)
    4524:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
    4526:	02b57563          	bgeu	a0,a1,4550 <memmove+0x32>
    while(n-- > 0)
    452a:	00c05f63          	blez	a2,4548 <memmove+0x2a>
    452e:	1602                	slli	a2,a2,0x20
    4530:	9201                	srli	a2,a2,0x20
    4532:	00c507b3          	add	a5,a0,a2
  dst = vdst;
    4536:	872a                	mv	a4,a0
      *dst++ = *src++;
    4538:	0585                	addi	a1,a1,1
    453a:	0705                	addi	a4,a4,1
    453c:	fff5c683          	lbu	a3,-1(a1)
    4540:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    4544:	fee79ae3          	bne	a5,a4,4538 <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
    4548:	60a2                	ld	ra,8(sp)
    454a:	6402                	ld	s0,0(sp)
    454c:	0141                	addi	sp,sp,16
    454e:	8082                	ret
    while(n-- > 0)
    4550:	fec05ce3          	blez	a2,4548 <memmove+0x2a>
    dst += n;
    4554:	00c50733          	add	a4,a0,a2
    src += n;
    4558:	95b2                	add	a1,a1,a2
    455a:	fff6079b          	addiw	a5,a2,-1 # fff <writetest+0x9f>
    455e:	1782                	slli	a5,a5,0x20
    4560:	9381                	srli	a5,a5,0x20
    4562:	fff7c793          	not	a5,a5
    4566:	97ba                	add	a5,a5,a4
      *--dst = *--src;
    4568:	15fd                	addi	a1,a1,-1
    456a:	177d                	addi	a4,a4,-1
    456c:	0005c683          	lbu	a3,0(a1)
    4570:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
    4574:	fef71ae3          	bne	a4,a5,4568 <memmove+0x4a>
    4578:	bfc1                	j	4548 <memmove+0x2a>

000000000000457a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
    457a:	1141                	addi	sp,sp,-16
    457c:	e406                	sd	ra,8(sp)
    457e:	e022                	sd	s0,0(sp)
    4580:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
    4582:	c61d                	beqz	a2,45b0 <memcmp+0x36>
    4584:	1602                	slli	a2,a2,0x20
    4586:	9201                	srli	a2,a2,0x20
    4588:	00c506b3          	add	a3,a0,a2
    if (*p1 != *p2) {
    458c:	00054783          	lbu	a5,0(a0)
    4590:	0005c703          	lbu	a4,0(a1)
    4594:	00e79863          	bne	a5,a4,45a4 <memcmp+0x2a>
      return *p1 - *p2;
    }
    p1++;
    4598:	0505                	addi	a0,a0,1
    p2++;
    459a:	0585                	addi	a1,a1,1
  while (n-- > 0) {
    459c:	fed518e3          	bne	a0,a3,458c <memcmp+0x12>
  }
  return 0;
    45a0:	4501                	li	a0,0
    45a2:	a019                	j	45a8 <memcmp+0x2e>
      return *p1 - *p2;
    45a4:	40e7853b          	subw	a0,a5,a4
}
    45a8:	60a2                	ld	ra,8(sp)
    45aa:	6402                	ld	s0,0(sp)
    45ac:	0141                	addi	sp,sp,16
    45ae:	8082                	ret
  return 0;
    45b0:	4501                	li	a0,0
    45b2:	bfdd                	j	45a8 <memcmp+0x2e>

00000000000045b4 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    45b4:	1141                	addi	sp,sp,-16
    45b6:	e406                	sd	ra,8(sp)
    45b8:	e022                	sd	s0,0(sp)
    45ba:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    45bc:	00000097          	auipc	ra,0x0
    45c0:	f62080e7          	jalr	-158(ra) # 451e <memmove>
}
    45c4:	60a2                	ld	ra,8(sp)
    45c6:	6402                	ld	s0,0(sp)
    45c8:	0141                	addi	sp,sp,16
    45ca:	8082                	ret

00000000000045cc <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    45cc:	4885                	li	a7,1
 ecall
    45ce:	00000073          	ecall
 ret
    45d2:	8082                	ret

00000000000045d4 <exit>:
.global exit
exit:
 li a7, SYS_exit
    45d4:	4889                	li	a7,2
 ecall
    45d6:	00000073          	ecall
 ret
    45da:	8082                	ret

00000000000045dc <wait>:
.global wait
wait:
 li a7, SYS_wait
    45dc:	488d                	li	a7,3
 ecall
    45de:	00000073          	ecall
 ret
    45e2:	8082                	ret

00000000000045e4 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    45e4:	4891                	li	a7,4
 ecall
    45e6:	00000073          	ecall
 ret
    45ea:	8082                	ret

00000000000045ec <read>:
.global read
read:
 li a7, SYS_read
    45ec:	4895                	li	a7,5
 ecall
    45ee:	00000073          	ecall
 ret
    45f2:	8082                	ret

00000000000045f4 <write>:
.global write
write:
 li a7, SYS_write
    45f4:	48c1                	li	a7,16
 ecall
    45f6:	00000073          	ecall
 ret
    45fa:	8082                	ret

00000000000045fc <close>:
.global close
close:
 li a7, SYS_close
    45fc:	48d5                	li	a7,21
 ecall
    45fe:	00000073          	ecall
 ret
    4602:	8082                	ret

0000000000004604 <kill>:
.global kill
kill:
 li a7, SYS_kill
    4604:	4899                	li	a7,6
 ecall
    4606:	00000073          	ecall
 ret
    460a:	8082                	ret

000000000000460c <exec>:
.global exec
exec:
 li a7, SYS_exec
    460c:	489d                	li	a7,7
 ecall
    460e:	00000073          	ecall
 ret
    4612:	8082                	ret

0000000000004614 <open>:
.global open
open:
 li a7, SYS_open
    4614:	48bd                	li	a7,15
 ecall
    4616:	00000073          	ecall
 ret
    461a:	8082                	ret

000000000000461c <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    461c:	48c5                	li	a7,17
 ecall
    461e:	00000073          	ecall
 ret
    4622:	8082                	ret

0000000000004624 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    4624:	48c9                	li	a7,18
 ecall
    4626:	00000073          	ecall
 ret
    462a:	8082                	ret

000000000000462c <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    462c:	48a1                	li	a7,8
 ecall
    462e:	00000073          	ecall
 ret
    4632:	8082                	ret

0000000000004634 <link>:
.global link
link:
 li a7, SYS_link
    4634:	48cd                	li	a7,19
 ecall
    4636:	00000073          	ecall
 ret
    463a:	8082                	ret

000000000000463c <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    463c:	48d1                	li	a7,20
 ecall
    463e:	00000073          	ecall
 ret
    4642:	8082                	ret

0000000000004644 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    4644:	48a5                	li	a7,9
 ecall
    4646:	00000073          	ecall
 ret
    464a:	8082                	ret

000000000000464c <dup>:
.global dup
dup:
 li a7, SYS_dup
    464c:	48a9                	li	a7,10
 ecall
    464e:	00000073          	ecall
 ret
    4652:	8082                	ret

0000000000004654 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    4654:	48ad                	li	a7,11
 ecall
    4656:	00000073          	ecall
 ret
    465a:	8082                	ret

000000000000465c <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    465c:	48b1                	li	a7,12
 ecall
    465e:	00000073          	ecall
 ret
    4662:	8082                	ret

0000000000004664 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    4664:	48b5                	li	a7,13
 ecall
    4666:	00000073          	ecall
 ret
    466a:	8082                	ret

000000000000466c <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    466c:	48b9                	li	a7,14
 ecall
    466e:	00000073          	ecall
 ret
    4672:	8082                	ret

0000000000004674 <ntas>:
.global ntas
ntas:
 li a7, SYS_ntas
    4674:	48d9                	li	a7,22
 ecall
    4676:	00000073          	ecall
 ret
    467a:	8082                	ret

000000000000467c <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    467c:	1101                	addi	sp,sp,-32
    467e:	ec06                	sd	ra,24(sp)
    4680:	e822                	sd	s0,16(sp)
    4682:	1000                	addi	s0,sp,32
    4684:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
    4688:	4605                	li	a2,1
    468a:	fef40593          	addi	a1,s0,-17
    468e:	00000097          	auipc	ra,0x0
    4692:	f66080e7          	jalr	-154(ra) # 45f4 <write>
}
    4696:	60e2                	ld	ra,24(sp)
    4698:	6442                	ld	s0,16(sp)
    469a:	6105                	addi	sp,sp,32
    469c:	8082                	ret

000000000000469e <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    469e:	7139                	addi	sp,sp,-64
    46a0:	fc06                	sd	ra,56(sp)
    46a2:	f822                	sd	s0,48(sp)
    46a4:	f04a                	sd	s2,32(sp)
    46a6:	ec4e                	sd	s3,24(sp)
    46a8:	0080                	addi	s0,sp,64
    46aa:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    46ac:	cad9                	beqz	a3,4742 <printint+0xa4>
    46ae:	01f5d79b          	srliw	a5,a1,0x1f
    46b2:	cbc1                	beqz	a5,4742 <printint+0xa4>
    neg = 1;
    x = -xx;
    46b4:	40b005bb          	negw	a1,a1
    neg = 1;
    46b8:	4305                	li	t1,1
  } else {
    x = xx;
  }

  i = 0;
    46ba:	fc040993          	addi	s3,s0,-64
  neg = 0;
    46be:	86ce                	mv	a3,s3
  i = 0;
    46c0:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
    46c2:	00002817          	auipc	a6,0x2
    46c6:	52e80813          	addi	a6,a6,1326 # 6bf0 <digits>
    46ca:	88ba                	mv	a7,a4
    46cc:	0017051b          	addiw	a0,a4,1
    46d0:	872a                	mv	a4,a0
    46d2:	02c5f7bb          	remuw	a5,a1,a2
    46d6:	1782                	slli	a5,a5,0x20
    46d8:	9381                	srli	a5,a5,0x20
    46da:	97c2                	add	a5,a5,a6
    46dc:	0007c783          	lbu	a5,0(a5)
    46e0:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
    46e4:	87ae                	mv	a5,a1
    46e6:	02c5d5bb          	divuw	a1,a1,a2
    46ea:	0685                	addi	a3,a3,1
    46ec:	fcc7ffe3          	bgeu	a5,a2,46ca <printint+0x2c>
  if(neg)
    46f0:	00030c63          	beqz	t1,4708 <printint+0x6a>
    buf[i++] = '-';
    46f4:	fd050793          	addi	a5,a0,-48
    46f8:	00878533          	add	a0,a5,s0
    46fc:	02d00793          	li	a5,45
    4700:	fef50823          	sb	a5,-16(a0)
    4704:	0028871b          	addiw	a4,a7,2

  while(--i >= 0)
    4708:	02e05763          	blez	a4,4736 <printint+0x98>
    470c:	f426                	sd	s1,40(sp)
    470e:	377d                	addiw	a4,a4,-1
    4710:	00e984b3          	add	s1,s3,a4
    4714:	19fd                	addi	s3,s3,-1
    4716:	99ba                	add	s3,s3,a4
    4718:	1702                	slli	a4,a4,0x20
    471a:	9301                	srli	a4,a4,0x20
    471c:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
    4720:	0004c583          	lbu	a1,0(s1)
    4724:	854a                	mv	a0,s2
    4726:	00000097          	auipc	ra,0x0
    472a:	f56080e7          	jalr	-170(ra) # 467c <putc>
  while(--i >= 0)
    472e:	14fd                	addi	s1,s1,-1
    4730:	ff3498e3          	bne	s1,s3,4720 <printint+0x82>
    4734:	74a2                	ld	s1,40(sp)
}
    4736:	70e2                	ld	ra,56(sp)
    4738:	7442                	ld	s0,48(sp)
    473a:	7902                	ld	s2,32(sp)
    473c:	69e2                	ld	s3,24(sp)
    473e:	6121                	addi	sp,sp,64
    4740:	8082                	ret
  neg = 0;
    4742:	4301                	li	t1,0
    4744:	bf9d                	j	46ba <printint+0x1c>

0000000000004746 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    4746:	715d                	addi	sp,sp,-80
    4748:	e486                	sd	ra,72(sp)
    474a:	e0a2                	sd	s0,64(sp)
    474c:	f84a                	sd	s2,48(sp)
    474e:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    4750:	0005c903          	lbu	s2,0(a1)
    4754:	1a090b63          	beqz	s2,490a <vprintf+0x1c4>
    4758:	fc26                	sd	s1,56(sp)
    475a:	f44e                	sd	s3,40(sp)
    475c:	f052                	sd	s4,32(sp)
    475e:	ec56                	sd	s5,24(sp)
    4760:	e85a                	sd	s6,16(sp)
    4762:	e45e                	sd	s7,8(sp)
    4764:	8aaa                	mv	s5,a0
    4766:	8bb2                	mv	s7,a2
    4768:	00158493          	addi	s1,a1,1
  state = 0;
    476c:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    476e:	02500a13          	li	s4,37
    4772:	4b55                	li	s6,21
    4774:	a839                	j	4792 <vprintf+0x4c>
        putc(fd, c);
    4776:	85ca                	mv	a1,s2
    4778:	8556                	mv	a0,s5
    477a:	00000097          	auipc	ra,0x0
    477e:	f02080e7          	jalr	-254(ra) # 467c <putc>
    4782:	a019                	j	4788 <vprintf+0x42>
    } else if(state == '%'){
    4784:	01498d63          	beq	s3,s4,479e <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
    4788:	0485                	addi	s1,s1,1
    478a:	fff4c903          	lbu	s2,-1(s1)
    478e:	16090863          	beqz	s2,48fe <vprintf+0x1b8>
    if(state == 0){
    4792:	fe0999e3          	bnez	s3,4784 <vprintf+0x3e>
      if(c == '%'){
    4796:	ff4910e3          	bne	s2,s4,4776 <vprintf+0x30>
        state = '%';
    479a:	89d2                	mv	s3,s4
    479c:	b7f5                	j	4788 <vprintf+0x42>
      if(c == 'd'){
    479e:	13490563          	beq	s2,s4,48c8 <vprintf+0x182>
    47a2:	f9d9079b          	addiw	a5,s2,-99
    47a6:	0ff7f793          	zext.b	a5,a5
    47aa:	12fb6863          	bltu	s6,a5,48da <vprintf+0x194>
    47ae:	f9d9079b          	addiw	a5,s2,-99
    47b2:	0ff7f713          	zext.b	a4,a5
    47b6:	12eb6263          	bltu	s6,a4,48da <vprintf+0x194>
    47ba:	00271793          	slli	a5,a4,0x2
    47be:	00002717          	auipc	a4,0x2
    47c2:	3da70713          	addi	a4,a4,986 # 6b98 <malloc+0x219a>
    47c6:	97ba                	add	a5,a5,a4
    47c8:	439c                	lw	a5,0(a5)
    47ca:	97ba                	add	a5,a5,a4
    47cc:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
    47ce:	008b8913          	addi	s2,s7,8
    47d2:	4685                	li	a3,1
    47d4:	4629                	li	a2,10
    47d6:	000ba583          	lw	a1,0(s7)
    47da:	8556                	mv	a0,s5
    47dc:	00000097          	auipc	ra,0x0
    47e0:	ec2080e7          	jalr	-318(ra) # 469e <printint>
    47e4:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    47e6:	4981                	li	s3,0
    47e8:	b745                	j	4788 <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
    47ea:	008b8913          	addi	s2,s7,8
    47ee:	4681                	li	a3,0
    47f0:	4629                	li	a2,10
    47f2:	000ba583          	lw	a1,0(s7)
    47f6:	8556                	mv	a0,s5
    47f8:	00000097          	auipc	ra,0x0
    47fc:	ea6080e7          	jalr	-346(ra) # 469e <printint>
    4800:	8bca                	mv	s7,s2
      state = 0;
    4802:	4981                	li	s3,0
    4804:	b751                	j	4788 <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
    4806:	008b8913          	addi	s2,s7,8
    480a:	4681                	li	a3,0
    480c:	4641                	li	a2,16
    480e:	000ba583          	lw	a1,0(s7)
    4812:	8556                	mv	a0,s5
    4814:	00000097          	auipc	ra,0x0
    4818:	e8a080e7          	jalr	-374(ra) # 469e <printint>
    481c:	8bca                	mv	s7,s2
      state = 0;
    481e:	4981                	li	s3,0
    4820:	b7a5                	j	4788 <vprintf+0x42>
    4822:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
    4824:	008b8793          	addi	a5,s7,8
    4828:	8c3e                	mv	s8,a5
    482a:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
    482e:	03000593          	li	a1,48
    4832:	8556                	mv	a0,s5
    4834:	00000097          	auipc	ra,0x0
    4838:	e48080e7          	jalr	-440(ra) # 467c <putc>
  putc(fd, 'x');
    483c:	07800593          	li	a1,120
    4840:	8556                	mv	a0,s5
    4842:	00000097          	auipc	ra,0x0
    4846:	e3a080e7          	jalr	-454(ra) # 467c <putc>
    484a:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    484c:	00002b97          	auipc	s7,0x2
    4850:	3a4b8b93          	addi	s7,s7,932 # 6bf0 <digits>
    4854:	03c9d793          	srli	a5,s3,0x3c
    4858:	97de                	add	a5,a5,s7
    485a:	0007c583          	lbu	a1,0(a5)
    485e:	8556                	mv	a0,s5
    4860:	00000097          	auipc	ra,0x0
    4864:	e1c080e7          	jalr	-484(ra) # 467c <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    4868:	0992                	slli	s3,s3,0x4
    486a:	397d                	addiw	s2,s2,-1
    486c:	fe0914e3          	bnez	s2,4854 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
    4870:	8be2                	mv	s7,s8
      state = 0;
    4872:	4981                	li	s3,0
    4874:	6c02                	ld	s8,0(sp)
    4876:	bf09                	j	4788 <vprintf+0x42>
        s = va_arg(ap, char*);
    4878:	008b8993          	addi	s3,s7,8
    487c:	000bb903          	ld	s2,0(s7)
        if(s == 0)
    4880:	02090163          	beqz	s2,48a2 <vprintf+0x15c>
        while(*s != 0){
    4884:	00094583          	lbu	a1,0(s2)
    4888:	c9a5                	beqz	a1,48f8 <vprintf+0x1b2>
          putc(fd, *s);
    488a:	8556                	mv	a0,s5
    488c:	00000097          	auipc	ra,0x0
    4890:	df0080e7          	jalr	-528(ra) # 467c <putc>
          s++;
    4894:	0905                	addi	s2,s2,1
        while(*s != 0){
    4896:	00094583          	lbu	a1,0(s2)
    489a:	f9e5                	bnez	a1,488a <vprintf+0x144>
        s = va_arg(ap, char*);
    489c:	8bce                	mv	s7,s3
      state = 0;
    489e:	4981                	li	s3,0
    48a0:	b5e5                	j	4788 <vprintf+0x42>
          s = "(null)";
    48a2:	00002917          	auipc	s2,0x2
    48a6:	ffe90913          	addi	s2,s2,-2 # 68a0 <malloc+0x1ea2>
        while(*s != 0){
    48aa:	02800593          	li	a1,40
    48ae:	bff1                	j	488a <vprintf+0x144>
        putc(fd, va_arg(ap, uint));
    48b0:	008b8913          	addi	s2,s7,8
    48b4:	000bc583          	lbu	a1,0(s7)
    48b8:	8556                	mv	a0,s5
    48ba:	00000097          	auipc	ra,0x0
    48be:	dc2080e7          	jalr	-574(ra) # 467c <putc>
    48c2:	8bca                	mv	s7,s2
      state = 0;
    48c4:	4981                	li	s3,0
    48c6:	b5c9                	j	4788 <vprintf+0x42>
        putc(fd, c);
    48c8:	02500593          	li	a1,37
    48cc:	8556                	mv	a0,s5
    48ce:	00000097          	auipc	ra,0x0
    48d2:	dae080e7          	jalr	-594(ra) # 467c <putc>
      state = 0;
    48d6:	4981                	li	s3,0
    48d8:	bd45                	j	4788 <vprintf+0x42>
        putc(fd, '%');
    48da:	02500593          	li	a1,37
    48de:	8556                	mv	a0,s5
    48e0:	00000097          	auipc	ra,0x0
    48e4:	d9c080e7          	jalr	-612(ra) # 467c <putc>
        putc(fd, c);
    48e8:	85ca                	mv	a1,s2
    48ea:	8556                	mv	a0,s5
    48ec:	00000097          	auipc	ra,0x0
    48f0:	d90080e7          	jalr	-624(ra) # 467c <putc>
      state = 0;
    48f4:	4981                	li	s3,0
    48f6:	bd49                	j	4788 <vprintf+0x42>
        s = va_arg(ap, char*);
    48f8:	8bce                	mv	s7,s3
      state = 0;
    48fa:	4981                	li	s3,0
    48fc:	b571                	j	4788 <vprintf+0x42>
    48fe:	74e2                	ld	s1,56(sp)
    4900:	79a2                	ld	s3,40(sp)
    4902:	7a02                	ld	s4,32(sp)
    4904:	6ae2                	ld	s5,24(sp)
    4906:	6b42                	ld	s6,16(sp)
    4908:	6ba2                	ld	s7,8(sp)
    }
  }
}
    490a:	60a6                	ld	ra,72(sp)
    490c:	6406                	ld	s0,64(sp)
    490e:	7942                	ld	s2,48(sp)
    4910:	6161                	addi	sp,sp,80
    4912:	8082                	ret

0000000000004914 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    4914:	715d                	addi	sp,sp,-80
    4916:	ec06                	sd	ra,24(sp)
    4918:	e822                	sd	s0,16(sp)
    491a:	1000                	addi	s0,sp,32
    491c:	e010                	sd	a2,0(s0)
    491e:	e414                	sd	a3,8(s0)
    4920:	e818                	sd	a4,16(s0)
    4922:	ec1c                	sd	a5,24(s0)
    4924:	03043023          	sd	a6,32(s0)
    4928:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    492c:	8622                	mv	a2,s0
    492e:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    4932:	00000097          	auipc	ra,0x0
    4936:	e14080e7          	jalr	-492(ra) # 4746 <vprintf>
}
    493a:	60e2                	ld	ra,24(sp)
    493c:	6442                	ld	s0,16(sp)
    493e:	6161                	addi	sp,sp,80
    4940:	8082                	ret

0000000000004942 <printf>:

void
printf(const char *fmt, ...)
{
    4942:	711d                	addi	sp,sp,-96
    4944:	ec06                	sd	ra,24(sp)
    4946:	e822                	sd	s0,16(sp)
    4948:	1000                	addi	s0,sp,32
    494a:	e40c                	sd	a1,8(s0)
    494c:	e810                	sd	a2,16(s0)
    494e:	ec14                	sd	a3,24(s0)
    4950:	f018                	sd	a4,32(s0)
    4952:	f41c                	sd	a5,40(s0)
    4954:	03043823          	sd	a6,48(s0)
    4958:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    495c:	00840613          	addi	a2,s0,8
    4960:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    4964:	85aa                	mv	a1,a0
    4966:	4505                	li	a0,1
    4968:	00000097          	auipc	ra,0x0
    496c:	dde080e7          	jalr	-546(ra) # 4746 <vprintf>
}
    4970:	60e2                	ld	ra,24(sp)
    4972:	6442                	ld	s0,16(sp)
    4974:	6125                	addi	sp,sp,96
    4976:	8082                	ret

0000000000004978 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    4978:	1141                	addi	sp,sp,-16
    497a:	e406                	sd	ra,8(sp)
    497c:	e022                	sd	s0,0(sp)
    497e:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    4980:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    4984:	00002797          	auipc	a5,0x2
    4988:	2947b783          	ld	a5,660(a5) # 6c18 <freep>
    498c:	a039                	j	499a <free+0x22>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    498e:	6398                	ld	a4,0(a5)
    4990:	00e7e463          	bltu	a5,a4,4998 <free+0x20>
    4994:	00e6ea63          	bltu	a3,a4,49a8 <free+0x30>
{
    4998:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    499a:	fed7fae3          	bgeu	a5,a3,498e <free+0x16>
    499e:	6398                	ld	a4,0(a5)
    49a0:	00e6e463          	bltu	a3,a4,49a8 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    49a4:	fee7eae3          	bltu	a5,a4,4998 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
    49a8:	ff852583          	lw	a1,-8(a0)
    49ac:	6390                	ld	a2,0(a5)
    49ae:	02059813          	slli	a6,a1,0x20
    49b2:	01c85713          	srli	a4,a6,0x1c
    49b6:	9736                	add	a4,a4,a3
    49b8:	02e60563          	beq	a2,a4,49e2 <free+0x6a>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
    49bc:	fec53823          	sd	a2,-16(a0)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    49c0:	4790                	lw	a2,8(a5)
    49c2:	02061593          	slli	a1,a2,0x20
    49c6:	01c5d713          	srli	a4,a1,0x1c
    49ca:	973e                	add	a4,a4,a5
    49cc:	02e68263          	beq	a3,a4,49f0 <free+0x78>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
    49d0:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
    49d2:	00002717          	auipc	a4,0x2
    49d6:	24f73323          	sd	a5,582(a4) # 6c18 <freep>
}
    49da:	60a2                	ld	ra,8(sp)
    49dc:	6402                	ld	s0,0(sp)
    49de:	0141                	addi	sp,sp,16
    49e0:	8082                	ret
    bp->s.size += p->s.ptr->s.size;
    49e2:	4618                	lw	a4,8(a2)
    49e4:	9f2d                	addw	a4,a4,a1
    49e6:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    49ea:	6398                	ld	a4,0(a5)
    49ec:	6310                	ld	a2,0(a4)
    49ee:	b7f9                	j	49bc <free+0x44>
    p->s.size += bp->s.size;
    49f0:	ff852703          	lw	a4,-8(a0)
    49f4:	9f31                	addw	a4,a4,a2
    49f6:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    49f8:	ff053683          	ld	a3,-16(a0)
    49fc:	bfd1                	j	49d0 <free+0x58>

00000000000049fe <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    49fe:	7139                	addi	sp,sp,-64
    4a00:	fc06                	sd	ra,56(sp)
    4a02:	f822                	sd	s0,48(sp)
    4a04:	f04a                	sd	s2,32(sp)
    4a06:	ec4e                	sd	s3,24(sp)
    4a08:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    4a0a:	02051993          	slli	s3,a0,0x20
    4a0e:	0209d993          	srli	s3,s3,0x20
    4a12:	09bd                	addi	s3,s3,15
    4a14:	0049d993          	srli	s3,s3,0x4
    4a18:	2985                	addiw	s3,s3,1
    4a1a:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
    4a1c:	00002517          	auipc	a0,0x2
    4a20:	1fc53503          	ld	a0,508(a0) # 6c18 <freep>
    4a24:	c905                	beqz	a0,4a54 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    4a26:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    4a28:	4798                	lw	a4,8(a5)
    4a2a:	09377a63          	bgeu	a4,s3,4abe <malloc+0xc0>
    4a2e:	f426                	sd	s1,40(sp)
    4a30:	e852                	sd	s4,16(sp)
    4a32:	e456                	sd	s5,8(sp)
    4a34:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
    4a36:	8a4e                	mv	s4,s3
    4a38:	6705                	lui	a4,0x1
    4a3a:	00e9f363          	bgeu	s3,a4,4a40 <malloc+0x42>
    4a3e:	6a05                	lui	s4,0x1
    4a40:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    4a44:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    4a48:	00002497          	auipc	s1,0x2
    4a4c:	1d048493          	addi	s1,s1,464 # 6c18 <freep>
  if(p == (char*)-1)
    4a50:	5afd                	li	s5,-1
    4a52:	a089                	j	4a94 <malloc+0x96>
    4a54:	f426                	sd	s1,40(sp)
    4a56:	e852                	sd	s4,16(sp)
    4a58:	e456                	sd	s5,8(sp)
    4a5a:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
    4a5c:	00008797          	auipc	a5,0x8
    4a60:	9d478793          	addi	a5,a5,-1580 # c430 <base>
    4a64:	00002717          	auipc	a4,0x2
    4a68:	1af73a23          	sd	a5,436(a4) # 6c18 <freep>
    4a6c:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    4a6e:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    4a72:	b7d1                	j	4a36 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
    4a74:	6398                	ld	a4,0(a5)
    4a76:	e118                	sd	a4,0(a0)
    4a78:	a8b9                	j	4ad6 <malloc+0xd8>
  hp->s.size = nu;
    4a7a:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    4a7e:	0541                	addi	a0,a0,16
    4a80:	00000097          	auipc	ra,0x0
    4a84:	ef8080e7          	jalr	-264(ra) # 4978 <free>
  return freep;
    4a88:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
    4a8a:	c135                	beqz	a0,4aee <malloc+0xf0>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    4a8c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    4a8e:	4798                	lw	a4,8(a5)
    4a90:	03277363          	bgeu	a4,s2,4ab6 <malloc+0xb8>
    if(p == freep)
    4a94:	6098                	ld	a4,0(s1)
    4a96:	853e                	mv	a0,a5
    4a98:	fef71ae3          	bne	a4,a5,4a8c <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
    4a9c:	8552                	mv	a0,s4
    4a9e:	00000097          	auipc	ra,0x0
    4aa2:	bbe080e7          	jalr	-1090(ra) # 465c <sbrk>
  if(p == (char*)-1)
    4aa6:	fd551ae3          	bne	a0,s5,4a7a <malloc+0x7c>
        return 0;
    4aaa:	4501                	li	a0,0
    4aac:	74a2                	ld	s1,40(sp)
    4aae:	6a42                	ld	s4,16(sp)
    4ab0:	6aa2                	ld	s5,8(sp)
    4ab2:	6b02                	ld	s6,0(sp)
    4ab4:	a03d                	j	4ae2 <malloc+0xe4>
    4ab6:	74a2                	ld	s1,40(sp)
    4ab8:	6a42                	ld	s4,16(sp)
    4aba:	6aa2                	ld	s5,8(sp)
    4abc:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
    4abe:	fae90be3          	beq	s2,a4,4a74 <malloc+0x76>
        p->s.size -= nunits;
    4ac2:	4137073b          	subw	a4,a4,s3
    4ac6:	c798                	sw	a4,8(a5)
        p += p->s.size;
    4ac8:	02071693          	slli	a3,a4,0x20
    4acc:	01c6d713          	srli	a4,a3,0x1c
    4ad0:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    4ad2:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    4ad6:	00002717          	auipc	a4,0x2
    4ada:	14a73123          	sd	a0,322(a4) # 6c18 <freep>
      return (void*)(p + 1);
    4ade:	01078513          	addi	a0,a5,16
  }
}
    4ae2:	70e2                	ld	ra,56(sp)
    4ae4:	7442                	ld	s0,48(sp)
    4ae6:	7902                	ld	s2,32(sp)
    4ae8:	69e2                	ld	s3,24(sp)
    4aea:	6121                	addi	sp,sp,64
    4aec:	8082                	ret
    4aee:	74a2                	ld	s1,40(sp)
    4af0:	6a42                	ld	s4,16(sp)
    4af2:	6aa2                	ld	s5,8(sp)
    4af4:	6b02                	ld	s6,0(sp)
    4af6:	b7f5                	j	4ae2 <malloc+0xe4>
