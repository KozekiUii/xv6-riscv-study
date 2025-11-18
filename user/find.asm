
user/_find：     文件格式 elf64-littleriscv


Disassembly of section .text:

0000000000000000 <matchstar>:
  return 0;
}

// 处理'*'通配符，匹配零次或多次出现的字符c
int matchstar(int c, char *re, char *text)
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	e052                	sd	s4,0(sp)
   e:	1800                	addi	s0,sp,48
  10:	892a                	mv	s2,a0
  12:	89ae                	mv	s3,a1
  14:	84b2                	mv	s1,a2
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
      return 1;
  }while(*text!='\0' && (*text++==c || c=='.'));  // 只有当text未结束且当前字符与c匹配时，才继续尝试匹配
  16:	fd250a13          	addi	s4,a0,-46
  1a:	001a3a13          	seqz	s4,s4
    if(matchhere(re, text))
  1e:	85a6                	mv	a1,s1
  20:	854e                	mv	a0,s3
  22:	00000097          	auipc	ra,0x0
  26:	02e080e7          	jalr	46(ra) # 50 <matchhere>
  2a:	e911                	bnez	a0,3e <matchstar+0x3e>
  }while(*text!='\0' && (*text++==c || c=='.'));  // 只有当text未结束且当前字符与c匹配时，才继续尝试匹配
  2c:	0004c783          	lbu	a5,0(s1)
  30:	cb81                	beqz	a5,40 <matchstar+0x40>
  32:	0485                	addi	s1,s1,1
  34:	ff2785e3          	beq	a5,s2,1e <matchstar+0x1e>
  38:	fe0a13e3          	bnez	s4,1e <matchstar+0x1e>
  3c:	a011                	j	40 <matchstar+0x40>
      return 1;
  3e:	4505                	li	a0,1
  return 0;
}
  40:	70a2                	ld	ra,40(sp)
  42:	7402                	ld	s0,32(sp)
  44:	64e2                	ld	s1,24(sp)
  46:	6942                	ld	s2,16(sp)
  48:	69a2                	ld	s3,8(sp)
  4a:	6a02                	ld	s4,0(sp)
  4c:	6145                	addi	sp,sp,48
  4e:	8082                	ret

0000000000000050 <matchhere>:
  if(re[0] == '\0')
  50:	00054703          	lbu	a4,0(a0)
  54:	c33d                	beqz	a4,ba <matchhere+0x6a>
{
  56:	1141                	addi	sp,sp,-16
  58:	e406                	sd	ra,8(sp)
  5a:	e022                	sd	s0,0(sp)
  5c:	0800                	addi	s0,sp,16
  5e:	87aa                	mv	a5,a0
  if(re[1] == '*')
  60:	00154683          	lbu	a3,1(a0)
  64:	02a00613          	li	a2,42
  68:	02c68363          	beq	a3,a2,8e <matchhere+0x3e>
  if(re[0] == '$' && re[1] == '\0')
  6c:	e681                	bnez	a3,74 <matchhere+0x24>
  6e:	fdc70693          	addi	a3,a4,-36
  72:	c69d                	beqz	a3,a0 <matchhere+0x50>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  74:	0005c683          	lbu	a3,0(a1)
  return 0;
  78:	4501                	li	a0,0
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  7a:	c691                	beqz	a3,86 <matchhere+0x36>
  7c:	02d70763          	beq	a4,a3,aa <matchhere+0x5a>
  80:	fd270713          	addi	a4,a4,-46
  84:	c31d                	beqz	a4,aa <matchhere+0x5a>
}
  86:	60a2                	ld	ra,8(sp)
  88:	6402                	ld	s0,0(sp)
  8a:	0141                	addi	sp,sp,16
  8c:	8082                	ret
    return matchstar(re[0], re+2, text);
  8e:	862e                	mv	a2,a1
  90:	00250593          	addi	a1,a0,2
  94:	853a                	mv	a0,a4
  96:	00000097          	auipc	ra,0x0
  9a:	f6a080e7          	jalr	-150(ra) # 0 <matchstar>
  9e:	b7e5                	j	86 <matchhere+0x36>
    return *text == '\0';
  a0:	0005c503          	lbu	a0,0(a1)
  a4:	00153513          	seqz	a0,a0
  a8:	bff9                	j	86 <matchhere+0x36>
    return matchhere(re+1, text+1);
  aa:	0585                	addi	a1,a1,1
  ac:	00178513          	addi	a0,a5,1
  b0:	00000097          	auipc	ra,0x0
  b4:	fa0080e7          	jalr	-96(ra) # 50 <matchhere>
  b8:	b7f9                	j	86 <matchhere+0x36>
    return 1;
  ba:	4505                	li	a0,1
}
  bc:	8082                	ret

00000000000000be <match>:
{
  be:	1101                	addi	sp,sp,-32
  c0:	ec06                	sd	ra,24(sp)
  c2:	e822                	sd	s0,16(sp)
  c4:	e426                	sd	s1,8(sp)
  c6:	e04a                	sd	s2,0(sp)
  c8:	1000                	addi	s0,sp,32
  ca:	892a                	mv	s2,a0
  cc:	84ae                	mv	s1,a1
  if(re[0] == '^')
  ce:	00054703          	lbu	a4,0(a0)
  d2:	05e00793          	li	a5,94
  d6:	00f70e63          	beq	a4,a5,f2 <match+0x34>
    if(matchhere(re, text))
  da:	85a6                	mv	a1,s1
  dc:	854a                	mv	a0,s2
  de:	00000097          	auipc	ra,0x0
  e2:	f72080e7          	jalr	-142(ra) # 50 <matchhere>
  e6:	ed01                	bnez	a0,fe <match+0x40>
  }while(*text++ != '\0');
  e8:	0485                	addi	s1,s1,1
  ea:	fff4c783          	lbu	a5,-1(s1)
  ee:	f7f5                	bnez	a5,da <match+0x1c>
  f0:	a801                	j	100 <match+0x42>
    return matchhere(re+1, text);
  f2:	0505                	addi	a0,a0,1
  f4:	00000097          	auipc	ra,0x0
  f8:	f5c080e7          	jalr	-164(ra) # 50 <matchhere>
  fc:	a011                	j	100 <match+0x42>
      return 1;
  fe:	4505                	li	a0,1
}
 100:	60e2                	ld	ra,24(sp)
 102:	6442                	ld	s0,16(sp)
 104:	64a2                	ld	s1,8(sp)
 106:	6902                	ld	s2,0(sp)
 108:	6105                	addi	sp,sp,32
 10a:	8082                	ret

000000000000010c <fmtname>:
}

// 对ls中的fmtname，去掉了空白字符串
char*
fmtname(char *path)
{
 10c:	1101                	addi	sp,sp,-32
 10e:	ec06                	sd	ra,24(sp)
 110:	e822                	sd	s0,16(sp)
 112:	e426                	sd	s1,8(sp)
 114:	1000                	addi	s0,sp,32
 116:	84aa                	mv	s1,a0
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
 118:	00000097          	auipc	ra,0x0
 11c:	2f0080e7          	jalr	752(ra) # 408 <strlen>
 120:	02051593          	slli	a1,a0,0x20
 124:	9181                	srli	a1,a1,0x20
 126:	95a6                	add	a1,a1,s1
 128:	02f00713          	li	a4,47
 12c:	0095e963          	bltu	a1,s1,13e <fmtname+0x32>
 130:	0005c783          	lbu	a5,0(a1)
 134:	00e78563          	beq	a5,a4,13e <fmtname+0x32>
 138:	15fd                	addi	a1,a1,-1
 13a:	fe95fbe3          	bgeu	a1,s1,130 <fmtname+0x24>
    ;
  p++;
 13e:	00158493          	addi	s1,a1,1
  // printf("len of p: %d\n", strlen(p));
  if(strlen(p) >= DIRSIZ)
 142:	8526                	mv	a0,s1
 144:	00000097          	auipc	ra,0x0
 148:	2c4080e7          	jalr	708(ra) # 408 <strlen>
 14c:	47b5                	li	a5,13
 14e:	00a7f863          	bgeu	a5,a0,15e <fmtname+0x52>
    return p;
  memset(buf, 0, sizeof(buf));
  memmove(buf, p, strlen(p));
  //memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  return buf;
}
 152:	8526                	mv	a0,s1
 154:	60e2                	ld	ra,24(sp)
 156:	6442                	ld	s0,16(sp)
 158:	64a2                	ld	s1,8(sp)
 15a:	6105                	addi	sp,sp,32
 15c:	8082                	ret
  memset(buf, 0, sizeof(buf));
 15e:	463d                	li	a2,15
 160:	4581                	li	a1,0
 162:	00001517          	auipc	a0,0x1
 166:	b0e50513          	addi	a0,a0,-1266 # c70 <buf.0>
 16a:	00000097          	auipc	ra,0x0
 16e:	2ca080e7          	jalr	714(ra) # 434 <memset>
  memmove(buf, p, strlen(p));
 172:	8526                	mv	a0,s1
 174:	00000097          	auipc	ra,0x0
 178:	294080e7          	jalr	660(ra) # 408 <strlen>
 17c:	862a                	mv	a2,a0
 17e:	85a6                	mv	a1,s1
 180:	00001517          	auipc	a0,0x1
 184:	af050513          	addi	a0,a0,-1296 # c70 <buf.0>
 188:	00000097          	auipc	ra,0x0
 18c:	408080e7          	jalr	1032(ra) # 590 <memmove>
  return buf;
 190:	00001497          	auipc	s1,0x1
 194:	ae048493          	addi	s1,s1,-1312 # c70 <buf.0>
 198:	bf6d                	j	152 <fmtname+0x46>

000000000000019a <find>:

void 
find(char *path, char *re){
 19a:	d9010113          	addi	sp,sp,-624
 19e:	26113423          	sd	ra,616(sp)
 1a2:	26813023          	sd	s0,608(sp)
 1a6:	25213823          	sd	s2,592(sp)
 1aa:	25313423          	sd	s3,584(sp)
 1ae:	1c80                	addi	s0,sp,624
 1b0:	892a                	mv	s2,a0
 1b2:	89ae                	mv	s3,a1
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;
  
  if((fd = open(path, 0)) < 0){
 1b4:	4581                	li	a1,0
 1b6:	00000097          	auipc	ra,0x0
 1ba:	4d0080e7          	jalr	1232(ra) # 686 <open>
 1be:	06054363          	bltz	a0,224 <find+0x8a>
 1c2:	24913c23          	sd	s1,600(sp)
 1c6:	84aa                	mv	s1,a0
      fprintf(2, "find: cannot open %s\n", path);
      return;
  }

  if(fstat(fd, &st) < 0){
 1c8:	d9840593          	addi	a1,s0,-616
 1cc:	00000097          	auipc	ra,0x0
 1d0:	4d2080e7          	jalr	1234(ra) # 69e <fstat>
 1d4:	06054363          	bltz	a0,23a <find+0xa0>
      fprintf(2, "find: cannot stat %s\n", path);
      close(fd);
      return;
  }
  
  switch(st.type){
 1d8:	da041783          	lh	a5,-608(s0)
 1dc:	4705                	li	a4,1
 1de:	08e78a63          	beq	a5,a4,272 <find+0xd8>
 1e2:	4709                	li	a4,2
 1e4:	00e79e63          	bne	a5,a4,200 <find+0x66>
  case T_FILE:
      //printf("File re: %s, fmtpath: %s\n", re, fmtname(path));
      // 检查文件名是否匹配正则表达式（re是正则表达式，表示文件名模式；fmtname(path)是文件名）
      if(match(re, fmtname(path)))
 1e8:	854a                	mv	a0,s2
 1ea:	00000097          	auipc	ra,0x0
 1ee:	f22080e7          	jalr	-222(ra) # 10c <fmtname>
 1f2:	85aa                	mv	a1,a0
 1f4:	854e                	mv	a0,s3
 1f6:	00000097          	auipc	ra,0x0
 1fa:	ec8080e7          	jalr	-312(ra) # be <match>
 1fe:	e125                	bnez	a0,25e <find+0xc4>
          }
          //printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
      }
      break;
  }
  close(fd);
 200:	8526                	mv	a0,s1
 202:	00000097          	auipc	ra,0x0
 206:	46c080e7          	jalr	1132(ra) # 66e <close>
 20a:	25813483          	ld	s1,600(sp)
}
 20e:	26813083          	ld	ra,616(sp)
 212:	26013403          	ld	s0,608(sp)
 216:	25013903          	ld	s2,592(sp)
 21a:	24813983          	ld	s3,584(sp)
 21e:	27010113          	addi	sp,sp,624
 222:	8082                	ret
      fprintf(2, "find: cannot open %s\n", path);
 224:	864a                	mv	a2,s2
 226:	00001597          	auipc	a1,0x1
 22a:	94a58593          	addi	a1,a1,-1718 # b70 <malloc+0x100>
 22e:	4509                	li	a0,2
 230:	00000097          	auipc	ra,0x0
 234:	756080e7          	jalr	1878(ra) # 986 <fprintf>
      return;
 238:	bfd9                	j	20e <find+0x74>
      fprintf(2, "find: cannot stat %s\n", path);
 23a:	864a                	mv	a2,s2
 23c:	00001597          	auipc	a1,0x1
 240:	94c58593          	addi	a1,a1,-1716 # b88 <malloc+0x118>
 244:	4509                	li	a0,2
 246:	00000097          	auipc	ra,0x0
 24a:	740080e7          	jalr	1856(ra) # 986 <fprintf>
      close(fd);
 24e:	8526                	mv	a0,s1
 250:	00000097          	auipc	ra,0x0
 254:	41e080e7          	jalr	1054(ra) # 66e <close>
      return;
 258:	25813483          	ld	s1,600(sp)
 25c:	bf4d                	j	20e <find+0x74>
          printf("%s\n", path);
 25e:	85ca                	mv	a1,s2
 260:	00001517          	auipc	a0,0x1
 264:	94050513          	addi	a0,a0,-1728 # ba0 <malloc+0x130>
 268:	00000097          	auipc	ra,0x0
 26c:	74c080e7          	jalr	1868(ra) # 9b4 <printf>
 270:	bf41                	j	200 <find+0x66>
      if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 272:	854a                	mv	a0,s2
 274:	00000097          	auipc	ra,0x0
 278:	194080e7          	jalr	404(ra) # 408 <strlen>
 27c:	2541                	addiw	a0,a0,16
 27e:	20000793          	li	a5,512
 282:	00a7fb63          	bgeu	a5,a0,298 <find+0xfe>
          printf("find: path too long\n");
 286:	00001517          	auipc	a0,0x1
 28a:	92250513          	addi	a0,a0,-1758 # ba8 <malloc+0x138>
 28e:	00000097          	auipc	ra,0x0
 292:	726080e7          	jalr	1830(ra) # 9b4 <printf>
          break;
 296:	b7ad                	j	200 <find+0x66>
 298:	25413023          	sd	s4,576(sp)
 29c:	23513c23          	sd	s5,568(sp)
      strcpy(buf, path);
 2a0:	85ca                	mv	a1,s2
 2a2:	dc040513          	addi	a0,s0,-576
 2a6:	00000097          	auipc	ra,0x0
 2aa:	112080e7          	jalr	274(ra) # 3b8 <strcpy>
      p = buf + strlen(buf);
 2ae:	dc040513          	addi	a0,s0,-576
 2b2:	00000097          	auipc	ra,0x0
 2b6:	156080e7          	jalr	342(ra) # 408 <strlen>
 2ba:	1502                	slli	a0,a0,0x20
 2bc:	9101                	srli	a0,a0,0x20
 2be:	dc040793          	addi	a5,s0,-576
 2c2:	00a78733          	add	a4,a5,a0
 2c6:	8a3a                	mv	s4,a4
      *p++ = '/';
 2c8:	00170793          	addi	a5,a4,1
 2cc:	8abe                	mv	s5,a5
 2ce:	02f00793          	li	a5,47
 2d2:	00f70023          	sb	a5,0(a4)
      while(read(fd, &de, sizeof(de)) == sizeof(de)){
 2d6:	4641                	li	a2,16
 2d8:	db040593          	addi	a1,s0,-592
 2dc:	8526                	mv	a0,s1
 2de:	00000097          	auipc	ra,0x0
 2e2:	380080e7          	jalr	896(ra) # 65e <read>
 2e6:	47c1                	li	a5,16
 2e8:	08f51763          	bne	a0,a5,376 <find+0x1dc>
          if(de.inum == 0)
 2ec:	db045783          	lhu	a5,-592(s0)
 2f0:	d3fd                	beqz	a5,2d6 <find+0x13c>
          memmove(p, de.name, DIRSIZ);
 2f2:	4639                	li	a2,14
 2f4:	db240593          	addi	a1,s0,-590
 2f8:	8556                	mv	a0,s5
 2fa:	00000097          	auipc	ra,0x0
 2fe:	296080e7          	jalr	662(ra) # 590 <memmove>
          p[DIRSIZ] = 0;
 302:	000a07a3          	sb	zero,15(s4)
          if(stat(buf, &st) < 0){
 306:	d9840593          	addi	a1,s0,-616
 30a:	dc040513          	addi	a0,s0,-576
 30e:	00000097          	auipc	ra,0x0
 312:	1ee080e7          	jalr	494(ra) # 4fc <stat>
 316:	04054563          	bltz	a0,360 <find+0x1c6>
          char* lstname = fmtname(buf);
 31a:	dc040513          	addi	a0,s0,-576
 31e:	00000097          	auipc	ra,0x0
 322:	dee080e7          	jalr	-530(ra) # 10c <fmtname>
 326:	892a                	mv	s2,a0
          if(strcmp(".", lstname) == 0 || strcmp("..", lstname) == 0){
 328:	85aa                	mv	a1,a0
 32a:	00001517          	auipc	a0,0x1
 32e:	89650513          	addi	a0,a0,-1898 # bc0 <malloc+0x150>
 332:	00000097          	auipc	ra,0x0
 336:	0a6080e7          	jalr	166(ra) # 3d8 <strcmp>
 33a:	dd51                	beqz	a0,2d6 <find+0x13c>
 33c:	85ca                	mv	a1,s2
 33e:	00001517          	auipc	a0,0x1
 342:	88a50513          	addi	a0,a0,-1910 # bc8 <malloc+0x158>
 346:	00000097          	auipc	ra,0x0
 34a:	092080e7          	jalr	146(ra) # 3d8 <strcmp>
 34e:	d541                	beqz	a0,2d6 <find+0x13c>
            find(buf, re);
 350:	85ce                	mv	a1,s3
 352:	dc040513          	addi	a0,s0,-576
 356:	00000097          	auipc	ra,0x0
 35a:	e44080e7          	jalr	-444(ra) # 19a <find>
 35e:	bfa5                	j	2d6 <find+0x13c>
              printf("find: cannot stat %s\n", buf);
 360:	dc040593          	addi	a1,s0,-576
 364:	00001517          	auipc	a0,0x1
 368:	82450513          	addi	a0,a0,-2012 # b88 <malloc+0x118>
 36c:	00000097          	auipc	ra,0x0
 370:	648080e7          	jalr	1608(ra) # 9b4 <printf>
              continue;
 374:	b78d                	j	2d6 <find+0x13c>
 376:	24013a03          	ld	s4,576(sp)
 37a:	23813a83          	ld	s5,568(sp)
 37e:	b549                	j	200 <find+0x66>

0000000000000380 <main>:
main(int argc, char** argv){
 380:	1141                	addi	sp,sp,-16
 382:	e406                	sd	ra,8(sp)
 384:	e022                	sd	s0,0(sp)
 386:	0800                	addi	s0,sp,16
    if(argc < 2){
 388:	4705                	li	a4,1
 38a:	00a75e63          	bge	a4,a0,3a6 <main+0x26>
 38e:	87ae                	mv	a5,a1
      find(argv[1], argv[2]);
 390:	698c                	ld	a1,16(a1)
 392:	6788                	ld	a0,8(a5)
 394:	00000097          	auipc	ra,0x0
 398:	e06080e7          	jalr	-506(ra) # 19a <find>
    exit(0);
 39c:	4501                	li	a0,0
 39e:	00000097          	auipc	ra,0x0
 3a2:	2a8080e7          	jalr	680(ra) # 646 <exit>
      printf("Parameters are not enough\n");
 3a6:	00001517          	auipc	a0,0x1
 3aa:	82a50513          	addi	a0,a0,-2006 # bd0 <malloc+0x160>
 3ae:	00000097          	auipc	ra,0x0
 3b2:	606080e7          	jalr	1542(ra) # 9b4 <printf>
 3b6:	b7dd                	j	39c <main+0x1c>

00000000000003b8 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 3b8:	1141                	addi	sp,sp,-16
 3ba:	e406                	sd	ra,8(sp)
 3bc:	e022                	sd	s0,0(sp)
 3be:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 3c0:	87aa                	mv	a5,a0
 3c2:	0585                	addi	a1,a1,1
 3c4:	0785                	addi	a5,a5,1
 3c6:	fff5c703          	lbu	a4,-1(a1)
 3ca:	fee78fa3          	sb	a4,-1(a5)
 3ce:	fb75                	bnez	a4,3c2 <strcpy+0xa>
    ;
  return os;
}
 3d0:	60a2                	ld	ra,8(sp)
 3d2:	6402                	ld	s0,0(sp)
 3d4:	0141                	addi	sp,sp,16
 3d6:	8082                	ret

00000000000003d8 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 3d8:	1141                	addi	sp,sp,-16
 3da:	e406                	sd	ra,8(sp)
 3dc:	e022                	sd	s0,0(sp)
 3de:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 3e0:	00054783          	lbu	a5,0(a0)
 3e4:	cb91                	beqz	a5,3f8 <strcmp+0x20>
 3e6:	0005c703          	lbu	a4,0(a1)
 3ea:	00f71763          	bne	a4,a5,3f8 <strcmp+0x20>
    p++, q++;
 3ee:	0505                	addi	a0,a0,1
 3f0:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 3f2:	00054783          	lbu	a5,0(a0)
 3f6:	fbe5                	bnez	a5,3e6 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 3f8:	0005c503          	lbu	a0,0(a1)
}
 3fc:	40a7853b          	subw	a0,a5,a0
 400:	60a2                	ld	ra,8(sp)
 402:	6402                	ld	s0,0(sp)
 404:	0141                	addi	sp,sp,16
 406:	8082                	ret

0000000000000408 <strlen>:

uint
strlen(const char *s)
{
 408:	1141                	addi	sp,sp,-16
 40a:	e406                	sd	ra,8(sp)
 40c:	e022                	sd	s0,0(sp)
 40e:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 410:	00054783          	lbu	a5,0(a0)
 414:	cf91                	beqz	a5,430 <strlen+0x28>
 416:	00150793          	addi	a5,a0,1
 41a:	86be                	mv	a3,a5
 41c:	0785                	addi	a5,a5,1
 41e:	fff7c703          	lbu	a4,-1(a5)
 422:	ff65                	bnez	a4,41a <strlen+0x12>
 424:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
 428:	60a2                	ld	ra,8(sp)
 42a:	6402                	ld	s0,0(sp)
 42c:	0141                	addi	sp,sp,16
 42e:	8082                	ret
  for(n = 0; s[n]; n++)
 430:	4501                	li	a0,0
 432:	bfdd                	j	428 <strlen+0x20>

0000000000000434 <memset>:

void*
memset(void *dst, int c, uint n)
{
 434:	1141                	addi	sp,sp,-16
 436:	e406                	sd	ra,8(sp)
 438:	e022                	sd	s0,0(sp)
 43a:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 43c:	ca19                	beqz	a2,452 <memset+0x1e>
 43e:	87aa                	mv	a5,a0
 440:	1602                	slli	a2,a2,0x20
 442:	9201                	srli	a2,a2,0x20
 444:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 448:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 44c:	0785                	addi	a5,a5,1
 44e:	fee79de3          	bne	a5,a4,448 <memset+0x14>
  }
  return dst;
}
 452:	60a2                	ld	ra,8(sp)
 454:	6402                	ld	s0,0(sp)
 456:	0141                	addi	sp,sp,16
 458:	8082                	ret

000000000000045a <strchr>:

char*
strchr(const char *s, char c)
{
 45a:	1141                	addi	sp,sp,-16
 45c:	e406                	sd	ra,8(sp)
 45e:	e022                	sd	s0,0(sp)
 460:	0800                	addi	s0,sp,16
  for(; *s; s++)
 462:	00054783          	lbu	a5,0(a0)
 466:	cf81                	beqz	a5,47e <strchr+0x24>
    if(*s == c)
 468:	00f58763          	beq	a1,a5,476 <strchr+0x1c>
  for(; *s; s++)
 46c:	0505                	addi	a0,a0,1
 46e:	00054783          	lbu	a5,0(a0)
 472:	fbfd                	bnez	a5,468 <strchr+0xe>
      return (char*)s;
  return 0;
 474:	4501                	li	a0,0
}
 476:	60a2                	ld	ra,8(sp)
 478:	6402                	ld	s0,0(sp)
 47a:	0141                	addi	sp,sp,16
 47c:	8082                	ret
  return 0;
 47e:	4501                	li	a0,0
 480:	bfdd                	j	476 <strchr+0x1c>

0000000000000482 <gets>:

char*
gets(char *buf, int max)
{
 482:	711d                	addi	sp,sp,-96
 484:	ec86                	sd	ra,88(sp)
 486:	e8a2                	sd	s0,80(sp)
 488:	e4a6                	sd	s1,72(sp)
 48a:	e0ca                	sd	s2,64(sp)
 48c:	fc4e                	sd	s3,56(sp)
 48e:	f852                	sd	s4,48(sp)
 490:	f456                	sd	s5,40(sp)
 492:	f05a                	sd	s6,32(sp)
 494:	ec5e                	sd	s7,24(sp)
 496:	e862                	sd	s8,16(sp)
 498:	1080                	addi	s0,sp,96
 49a:	8baa                	mv	s7,a0
 49c:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 49e:	892a                	mv	s2,a0
 4a0:	4481                	li	s1,0
    cc = read(0, &c, 1);
 4a2:	faf40b13          	addi	s6,s0,-81
 4a6:	4a85                	li	s5,1
  for(i=0; i+1 < max; ){
 4a8:	8c26                	mv	s8,s1
 4aa:	0014899b          	addiw	s3,s1,1
 4ae:	84ce                	mv	s1,s3
 4b0:	0349d663          	bge	s3,s4,4dc <gets+0x5a>
    cc = read(0, &c, 1);
 4b4:	8656                	mv	a2,s5
 4b6:	85da                	mv	a1,s6
 4b8:	4501                	li	a0,0
 4ba:	00000097          	auipc	ra,0x0
 4be:	1a4080e7          	jalr	420(ra) # 65e <read>
    if(cc < 1)
 4c2:	00a05d63          	blez	a0,4dc <gets+0x5a>
      break;
    buf[i++] = c;
 4c6:	faf44783          	lbu	a5,-81(s0)
 4ca:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 4ce:	0905                	addi	s2,s2,1
 4d0:	ff678713          	addi	a4,a5,-10
 4d4:	c319                	beqz	a4,4da <gets+0x58>
 4d6:	17cd                	addi	a5,a5,-13
 4d8:	fbe1                	bnez	a5,4a8 <gets+0x26>
    buf[i++] = c;
 4da:	8c4e                	mv	s8,s3
      break;
  }
  buf[i] = '\0';
 4dc:	9c5e                	add	s8,s8,s7
 4de:	000c0023          	sb	zero,0(s8)
  return buf;
}
 4e2:	855e                	mv	a0,s7
 4e4:	60e6                	ld	ra,88(sp)
 4e6:	6446                	ld	s0,80(sp)
 4e8:	64a6                	ld	s1,72(sp)
 4ea:	6906                	ld	s2,64(sp)
 4ec:	79e2                	ld	s3,56(sp)
 4ee:	7a42                	ld	s4,48(sp)
 4f0:	7aa2                	ld	s5,40(sp)
 4f2:	7b02                	ld	s6,32(sp)
 4f4:	6be2                	ld	s7,24(sp)
 4f6:	6c42                	ld	s8,16(sp)
 4f8:	6125                	addi	sp,sp,96
 4fa:	8082                	ret

00000000000004fc <stat>:

int
stat(const char *n, struct stat *st)
{
 4fc:	1101                	addi	sp,sp,-32
 4fe:	ec06                	sd	ra,24(sp)
 500:	e822                	sd	s0,16(sp)
 502:	e04a                	sd	s2,0(sp)
 504:	1000                	addi	s0,sp,32
 506:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 508:	4581                	li	a1,0
 50a:	00000097          	auipc	ra,0x0
 50e:	17c080e7          	jalr	380(ra) # 686 <open>
  if(fd < 0)
 512:	02054663          	bltz	a0,53e <stat+0x42>
 516:	e426                	sd	s1,8(sp)
 518:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 51a:	85ca                	mv	a1,s2
 51c:	00000097          	auipc	ra,0x0
 520:	182080e7          	jalr	386(ra) # 69e <fstat>
 524:	892a                	mv	s2,a0
  close(fd);
 526:	8526                	mv	a0,s1
 528:	00000097          	auipc	ra,0x0
 52c:	146080e7          	jalr	326(ra) # 66e <close>
  return r;
 530:	64a2                	ld	s1,8(sp)
}
 532:	854a                	mv	a0,s2
 534:	60e2                	ld	ra,24(sp)
 536:	6442                	ld	s0,16(sp)
 538:	6902                	ld	s2,0(sp)
 53a:	6105                	addi	sp,sp,32
 53c:	8082                	ret
    return -1;
 53e:	57fd                	li	a5,-1
 540:	893e                	mv	s2,a5
 542:	bfc5                	j	532 <stat+0x36>

0000000000000544 <atoi>:

int
atoi(const char *s)
{
 544:	1141                	addi	sp,sp,-16
 546:	e406                	sd	ra,8(sp)
 548:	e022                	sd	s0,0(sp)
 54a:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 54c:	00054683          	lbu	a3,0(a0)
 550:	fd06879b          	addiw	a5,a3,-48
 554:	0ff7f793          	zext.b	a5,a5
 558:	4625                	li	a2,9
 55a:	02f66963          	bltu	a2,a5,58c <atoi+0x48>
 55e:	872a                	mv	a4,a0
  n = 0;
 560:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 562:	0705                	addi	a4,a4,1
 564:	0025179b          	slliw	a5,a0,0x2
 568:	9fa9                	addw	a5,a5,a0
 56a:	0017979b          	slliw	a5,a5,0x1
 56e:	9fb5                	addw	a5,a5,a3
 570:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 574:	00074683          	lbu	a3,0(a4)
 578:	fd06879b          	addiw	a5,a3,-48
 57c:	0ff7f793          	zext.b	a5,a5
 580:	fef671e3          	bgeu	a2,a5,562 <atoi+0x1e>
  return n;
}
 584:	60a2                	ld	ra,8(sp)
 586:	6402                	ld	s0,0(sp)
 588:	0141                	addi	sp,sp,16
 58a:	8082                	ret
  n = 0;
 58c:	4501                	li	a0,0
 58e:	bfdd                	j	584 <atoi+0x40>

0000000000000590 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 590:	1141                	addi	sp,sp,-16
 592:	e406                	sd	ra,8(sp)
 594:	e022                	sd	s0,0(sp)
 596:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 598:	02b57563          	bgeu	a0,a1,5c2 <memmove+0x32>
    while(n-- > 0)
 59c:	00c05f63          	blez	a2,5ba <memmove+0x2a>
 5a0:	1602                	slli	a2,a2,0x20
 5a2:	9201                	srli	a2,a2,0x20
 5a4:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 5a8:	872a                	mv	a4,a0
      *dst++ = *src++;
 5aa:	0585                	addi	a1,a1,1
 5ac:	0705                	addi	a4,a4,1
 5ae:	fff5c683          	lbu	a3,-1(a1)
 5b2:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 5b6:	fee79ae3          	bne	a5,a4,5aa <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 5ba:	60a2                	ld	ra,8(sp)
 5bc:	6402                	ld	s0,0(sp)
 5be:	0141                	addi	sp,sp,16
 5c0:	8082                	ret
    while(n-- > 0)
 5c2:	fec05ce3          	blez	a2,5ba <memmove+0x2a>
    dst += n;
 5c6:	00c50733          	add	a4,a0,a2
    src += n;
 5ca:	95b2                	add	a1,a1,a2
 5cc:	fff6079b          	addiw	a5,a2,-1
 5d0:	1782                	slli	a5,a5,0x20
 5d2:	9381                	srli	a5,a5,0x20
 5d4:	fff7c793          	not	a5,a5
 5d8:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 5da:	15fd                	addi	a1,a1,-1
 5dc:	177d                	addi	a4,a4,-1
 5de:	0005c683          	lbu	a3,0(a1)
 5e2:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 5e6:	fef71ae3          	bne	a4,a5,5da <memmove+0x4a>
 5ea:	bfc1                	j	5ba <memmove+0x2a>

00000000000005ec <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 5ec:	1141                	addi	sp,sp,-16
 5ee:	e406                	sd	ra,8(sp)
 5f0:	e022                	sd	s0,0(sp)
 5f2:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 5f4:	c61d                	beqz	a2,622 <memcmp+0x36>
 5f6:	1602                	slli	a2,a2,0x20
 5f8:	9201                	srli	a2,a2,0x20
 5fa:	00c506b3          	add	a3,a0,a2
    if (*p1 != *p2) {
 5fe:	00054783          	lbu	a5,0(a0)
 602:	0005c703          	lbu	a4,0(a1)
 606:	00e79863          	bne	a5,a4,616 <memcmp+0x2a>
      return *p1 - *p2;
    }
    p1++;
 60a:	0505                	addi	a0,a0,1
    p2++;
 60c:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 60e:	fed518e3          	bne	a0,a3,5fe <memcmp+0x12>
  }
  return 0;
 612:	4501                	li	a0,0
 614:	a019                	j	61a <memcmp+0x2e>
      return *p1 - *p2;
 616:	40e7853b          	subw	a0,a5,a4
}
 61a:	60a2                	ld	ra,8(sp)
 61c:	6402                	ld	s0,0(sp)
 61e:	0141                	addi	sp,sp,16
 620:	8082                	ret
  return 0;
 622:	4501                	li	a0,0
 624:	bfdd                	j	61a <memcmp+0x2e>

0000000000000626 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 626:	1141                	addi	sp,sp,-16
 628:	e406                	sd	ra,8(sp)
 62a:	e022                	sd	s0,0(sp)
 62c:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 62e:	00000097          	auipc	ra,0x0
 632:	f62080e7          	jalr	-158(ra) # 590 <memmove>
}
 636:	60a2                	ld	ra,8(sp)
 638:	6402                	ld	s0,0(sp)
 63a:	0141                	addi	sp,sp,16
 63c:	8082                	ret

000000000000063e <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 63e:	4885                	li	a7,1
 ecall
 640:	00000073          	ecall
 ret
 644:	8082                	ret

0000000000000646 <exit>:
.global exit
exit:
 li a7, SYS_exit
 646:	4889                	li	a7,2
 ecall
 648:	00000073          	ecall
 ret
 64c:	8082                	ret

000000000000064e <wait>:
.global wait
wait:
 li a7, SYS_wait
 64e:	488d                	li	a7,3
 ecall
 650:	00000073          	ecall
 ret
 654:	8082                	ret

0000000000000656 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 656:	4891                	li	a7,4
 ecall
 658:	00000073          	ecall
 ret
 65c:	8082                	ret

000000000000065e <read>:
.global read
read:
 li a7, SYS_read
 65e:	4895                	li	a7,5
 ecall
 660:	00000073          	ecall
 ret
 664:	8082                	ret

0000000000000666 <write>:
.global write
write:
 li a7, SYS_write
 666:	48c1                	li	a7,16
 ecall
 668:	00000073          	ecall
 ret
 66c:	8082                	ret

000000000000066e <close>:
.global close
close:
 li a7, SYS_close
 66e:	48d5                	li	a7,21
 ecall
 670:	00000073          	ecall
 ret
 674:	8082                	ret

0000000000000676 <kill>:
.global kill
kill:
 li a7, SYS_kill
 676:	4899                	li	a7,6
 ecall
 678:	00000073          	ecall
 ret
 67c:	8082                	ret

000000000000067e <exec>:
.global exec
exec:
 li a7, SYS_exec
 67e:	489d                	li	a7,7
 ecall
 680:	00000073          	ecall
 ret
 684:	8082                	ret

0000000000000686 <open>:
.global open
open:
 li a7, SYS_open
 686:	48bd                	li	a7,15
 ecall
 688:	00000073          	ecall
 ret
 68c:	8082                	ret

000000000000068e <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 68e:	48c5                	li	a7,17
 ecall
 690:	00000073          	ecall
 ret
 694:	8082                	ret

0000000000000696 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 696:	48c9                	li	a7,18
 ecall
 698:	00000073          	ecall
 ret
 69c:	8082                	ret

000000000000069e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 69e:	48a1                	li	a7,8
 ecall
 6a0:	00000073          	ecall
 ret
 6a4:	8082                	ret

00000000000006a6 <link>:
.global link
link:
 li a7, SYS_link
 6a6:	48cd                	li	a7,19
 ecall
 6a8:	00000073          	ecall
 ret
 6ac:	8082                	ret

00000000000006ae <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 6ae:	48d1                	li	a7,20
 ecall
 6b0:	00000073          	ecall
 ret
 6b4:	8082                	ret

00000000000006b6 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 6b6:	48a5                	li	a7,9
 ecall
 6b8:	00000073          	ecall
 ret
 6bc:	8082                	ret

00000000000006be <dup>:
.global dup
dup:
 li a7, SYS_dup
 6be:	48a9                	li	a7,10
 ecall
 6c0:	00000073          	ecall
 ret
 6c4:	8082                	ret

00000000000006c6 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 6c6:	48ad                	li	a7,11
 ecall
 6c8:	00000073          	ecall
 ret
 6cc:	8082                	ret

00000000000006ce <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 6ce:	48b1                	li	a7,12
 ecall
 6d0:	00000073          	ecall
 ret
 6d4:	8082                	ret

00000000000006d6 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 6d6:	48b5                	li	a7,13
 ecall
 6d8:	00000073          	ecall
 ret
 6dc:	8082                	ret

00000000000006de <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 6de:	48b9                	li	a7,14
 ecall
 6e0:	00000073          	ecall
 ret
 6e4:	8082                	ret

00000000000006e6 <ntas>:
.global ntas
ntas:
 li a7, SYS_ntas
 6e6:	48d9                	li	a7,22
 ecall
 6e8:	00000073          	ecall
 ret
 6ec:	8082                	ret

00000000000006ee <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 6ee:	1101                	addi	sp,sp,-32
 6f0:	ec06                	sd	ra,24(sp)
 6f2:	e822                	sd	s0,16(sp)
 6f4:	1000                	addi	s0,sp,32
 6f6:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 6fa:	4605                	li	a2,1
 6fc:	fef40593          	addi	a1,s0,-17
 700:	00000097          	auipc	ra,0x0
 704:	f66080e7          	jalr	-154(ra) # 666 <write>
}
 708:	60e2                	ld	ra,24(sp)
 70a:	6442                	ld	s0,16(sp)
 70c:	6105                	addi	sp,sp,32
 70e:	8082                	ret

0000000000000710 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 710:	7139                	addi	sp,sp,-64
 712:	fc06                	sd	ra,56(sp)
 714:	f822                	sd	s0,48(sp)
 716:	f04a                	sd	s2,32(sp)
 718:	ec4e                	sd	s3,24(sp)
 71a:	0080                	addi	s0,sp,64
 71c:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 71e:	cad9                	beqz	a3,7b4 <printint+0xa4>
 720:	01f5d79b          	srliw	a5,a1,0x1f
 724:	cbc1                	beqz	a5,7b4 <printint+0xa4>
    neg = 1;
    x = -xx;
 726:	40b005bb          	negw	a1,a1
    neg = 1;
 72a:	4305                	li	t1,1
  } else {
    x = xx;
  }

  i = 0;
 72c:	fc040993          	addi	s3,s0,-64
  neg = 0;
 730:	86ce                	mv	a3,s3
  i = 0;
 732:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 734:	00000817          	auipc	a6,0x0
 738:	51c80813          	addi	a6,a6,1308 # c50 <digits>
 73c:	88ba                	mv	a7,a4
 73e:	0017051b          	addiw	a0,a4,1
 742:	872a                	mv	a4,a0
 744:	02c5f7bb          	remuw	a5,a1,a2
 748:	1782                	slli	a5,a5,0x20
 74a:	9381                	srli	a5,a5,0x20
 74c:	97c2                	add	a5,a5,a6
 74e:	0007c783          	lbu	a5,0(a5)
 752:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 756:	87ae                	mv	a5,a1
 758:	02c5d5bb          	divuw	a1,a1,a2
 75c:	0685                	addi	a3,a3,1
 75e:	fcc7ffe3          	bgeu	a5,a2,73c <printint+0x2c>
  if(neg)
 762:	00030c63          	beqz	t1,77a <printint+0x6a>
    buf[i++] = '-';
 766:	fd050793          	addi	a5,a0,-48
 76a:	00878533          	add	a0,a5,s0
 76e:	02d00793          	li	a5,45
 772:	fef50823          	sb	a5,-16(a0)
 776:	0028871b          	addiw	a4,a7,2

  while(--i >= 0)
 77a:	02e05763          	blez	a4,7a8 <printint+0x98>
 77e:	f426                	sd	s1,40(sp)
 780:	377d                	addiw	a4,a4,-1
 782:	00e984b3          	add	s1,s3,a4
 786:	19fd                	addi	s3,s3,-1
 788:	99ba                	add	s3,s3,a4
 78a:	1702                	slli	a4,a4,0x20
 78c:	9301                	srli	a4,a4,0x20
 78e:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 792:	0004c583          	lbu	a1,0(s1)
 796:	854a                	mv	a0,s2
 798:	00000097          	auipc	ra,0x0
 79c:	f56080e7          	jalr	-170(ra) # 6ee <putc>
  while(--i >= 0)
 7a0:	14fd                	addi	s1,s1,-1
 7a2:	ff3498e3          	bne	s1,s3,792 <printint+0x82>
 7a6:	74a2                	ld	s1,40(sp)
}
 7a8:	70e2                	ld	ra,56(sp)
 7aa:	7442                	ld	s0,48(sp)
 7ac:	7902                	ld	s2,32(sp)
 7ae:	69e2                	ld	s3,24(sp)
 7b0:	6121                	addi	sp,sp,64
 7b2:	8082                	ret
  neg = 0;
 7b4:	4301                	li	t1,0
 7b6:	bf9d                	j	72c <printint+0x1c>

00000000000007b8 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 7b8:	715d                	addi	sp,sp,-80
 7ba:	e486                	sd	ra,72(sp)
 7bc:	e0a2                	sd	s0,64(sp)
 7be:	f84a                	sd	s2,48(sp)
 7c0:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 7c2:	0005c903          	lbu	s2,0(a1)
 7c6:	1a090b63          	beqz	s2,97c <vprintf+0x1c4>
 7ca:	fc26                	sd	s1,56(sp)
 7cc:	f44e                	sd	s3,40(sp)
 7ce:	f052                	sd	s4,32(sp)
 7d0:	ec56                	sd	s5,24(sp)
 7d2:	e85a                	sd	s6,16(sp)
 7d4:	e45e                	sd	s7,8(sp)
 7d6:	8aaa                	mv	s5,a0
 7d8:	8bb2                	mv	s7,a2
 7da:	00158493          	addi	s1,a1,1
  state = 0;
 7de:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 7e0:	02500a13          	li	s4,37
 7e4:	4b55                	li	s6,21
 7e6:	a839                	j	804 <vprintf+0x4c>
        putc(fd, c);
 7e8:	85ca                	mv	a1,s2
 7ea:	8556                	mv	a0,s5
 7ec:	00000097          	auipc	ra,0x0
 7f0:	f02080e7          	jalr	-254(ra) # 6ee <putc>
 7f4:	a019                	j	7fa <vprintf+0x42>
    } else if(state == '%'){
 7f6:	01498d63          	beq	s3,s4,810 <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
 7fa:	0485                	addi	s1,s1,1
 7fc:	fff4c903          	lbu	s2,-1(s1)
 800:	16090863          	beqz	s2,970 <vprintf+0x1b8>
    if(state == 0){
 804:	fe0999e3          	bnez	s3,7f6 <vprintf+0x3e>
      if(c == '%'){
 808:	ff4910e3          	bne	s2,s4,7e8 <vprintf+0x30>
        state = '%';
 80c:	89d2                	mv	s3,s4
 80e:	b7f5                	j	7fa <vprintf+0x42>
      if(c == 'd'){
 810:	13490563          	beq	s2,s4,93a <vprintf+0x182>
 814:	f9d9079b          	addiw	a5,s2,-99
 818:	0ff7f793          	zext.b	a5,a5
 81c:	12fb6863          	bltu	s6,a5,94c <vprintf+0x194>
 820:	f9d9079b          	addiw	a5,s2,-99
 824:	0ff7f713          	zext.b	a4,a5
 828:	12eb6263          	bltu	s6,a4,94c <vprintf+0x194>
 82c:	00271793          	slli	a5,a4,0x2
 830:	00000717          	auipc	a4,0x0
 834:	3c870713          	addi	a4,a4,968 # bf8 <malloc+0x188>
 838:	97ba                	add	a5,a5,a4
 83a:	439c                	lw	a5,0(a5)
 83c:	97ba                	add	a5,a5,a4
 83e:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 840:	008b8913          	addi	s2,s7,8
 844:	4685                	li	a3,1
 846:	4629                	li	a2,10
 848:	000ba583          	lw	a1,0(s7)
 84c:	8556                	mv	a0,s5
 84e:	00000097          	auipc	ra,0x0
 852:	ec2080e7          	jalr	-318(ra) # 710 <printint>
 856:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 858:	4981                	li	s3,0
 85a:	b745                	j	7fa <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
 85c:	008b8913          	addi	s2,s7,8
 860:	4681                	li	a3,0
 862:	4629                	li	a2,10
 864:	000ba583          	lw	a1,0(s7)
 868:	8556                	mv	a0,s5
 86a:	00000097          	auipc	ra,0x0
 86e:	ea6080e7          	jalr	-346(ra) # 710 <printint>
 872:	8bca                	mv	s7,s2
      state = 0;
 874:	4981                	li	s3,0
 876:	b751                	j	7fa <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
 878:	008b8913          	addi	s2,s7,8
 87c:	4681                	li	a3,0
 87e:	4641                	li	a2,16
 880:	000ba583          	lw	a1,0(s7)
 884:	8556                	mv	a0,s5
 886:	00000097          	auipc	ra,0x0
 88a:	e8a080e7          	jalr	-374(ra) # 710 <printint>
 88e:	8bca                	mv	s7,s2
      state = 0;
 890:	4981                	li	s3,0
 892:	b7a5                	j	7fa <vprintf+0x42>
 894:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
 896:	008b8793          	addi	a5,s7,8
 89a:	8c3e                	mv	s8,a5
 89c:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 8a0:	03000593          	li	a1,48
 8a4:	8556                	mv	a0,s5
 8a6:	00000097          	auipc	ra,0x0
 8aa:	e48080e7          	jalr	-440(ra) # 6ee <putc>
  putc(fd, 'x');
 8ae:	07800593          	li	a1,120
 8b2:	8556                	mv	a0,s5
 8b4:	00000097          	auipc	ra,0x0
 8b8:	e3a080e7          	jalr	-454(ra) # 6ee <putc>
 8bc:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 8be:	00000b97          	auipc	s7,0x0
 8c2:	392b8b93          	addi	s7,s7,914 # c50 <digits>
 8c6:	03c9d793          	srli	a5,s3,0x3c
 8ca:	97de                	add	a5,a5,s7
 8cc:	0007c583          	lbu	a1,0(a5)
 8d0:	8556                	mv	a0,s5
 8d2:	00000097          	auipc	ra,0x0
 8d6:	e1c080e7          	jalr	-484(ra) # 6ee <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 8da:	0992                	slli	s3,s3,0x4
 8dc:	397d                	addiw	s2,s2,-1
 8de:	fe0914e3          	bnez	s2,8c6 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
 8e2:	8be2                	mv	s7,s8
      state = 0;
 8e4:	4981                	li	s3,0
 8e6:	6c02                	ld	s8,0(sp)
 8e8:	bf09                	j	7fa <vprintf+0x42>
        s = va_arg(ap, char*);
 8ea:	008b8993          	addi	s3,s7,8
 8ee:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 8f2:	02090163          	beqz	s2,914 <vprintf+0x15c>
        while(*s != 0){
 8f6:	00094583          	lbu	a1,0(s2)
 8fa:	c9a5                	beqz	a1,96a <vprintf+0x1b2>
          putc(fd, *s);
 8fc:	8556                	mv	a0,s5
 8fe:	00000097          	auipc	ra,0x0
 902:	df0080e7          	jalr	-528(ra) # 6ee <putc>
          s++;
 906:	0905                	addi	s2,s2,1
        while(*s != 0){
 908:	00094583          	lbu	a1,0(s2)
 90c:	f9e5                	bnez	a1,8fc <vprintf+0x144>
        s = va_arg(ap, char*);
 90e:	8bce                	mv	s7,s3
      state = 0;
 910:	4981                	li	s3,0
 912:	b5e5                	j	7fa <vprintf+0x42>
          s = "(null)";
 914:	00000917          	auipc	s2,0x0
 918:	2dc90913          	addi	s2,s2,732 # bf0 <malloc+0x180>
        while(*s != 0){
 91c:	02800593          	li	a1,40
 920:	bff1                	j	8fc <vprintf+0x144>
        putc(fd, va_arg(ap, uint));
 922:	008b8913          	addi	s2,s7,8
 926:	000bc583          	lbu	a1,0(s7)
 92a:	8556                	mv	a0,s5
 92c:	00000097          	auipc	ra,0x0
 930:	dc2080e7          	jalr	-574(ra) # 6ee <putc>
 934:	8bca                	mv	s7,s2
      state = 0;
 936:	4981                	li	s3,0
 938:	b5c9                	j	7fa <vprintf+0x42>
        putc(fd, c);
 93a:	02500593          	li	a1,37
 93e:	8556                	mv	a0,s5
 940:	00000097          	auipc	ra,0x0
 944:	dae080e7          	jalr	-594(ra) # 6ee <putc>
      state = 0;
 948:	4981                	li	s3,0
 94a:	bd45                	j	7fa <vprintf+0x42>
        putc(fd, '%');
 94c:	02500593          	li	a1,37
 950:	8556                	mv	a0,s5
 952:	00000097          	auipc	ra,0x0
 956:	d9c080e7          	jalr	-612(ra) # 6ee <putc>
        putc(fd, c);
 95a:	85ca                	mv	a1,s2
 95c:	8556                	mv	a0,s5
 95e:	00000097          	auipc	ra,0x0
 962:	d90080e7          	jalr	-624(ra) # 6ee <putc>
      state = 0;
 966:	4981                	li	s3,0
 968:	bd49                	j	7fa <vprintf+0x42>
        s = va_arg(ap, char*);
 96a:	8bce                	mv	s7,s3
      state = 0;
 96c:	4981                	li	s3,0
 96e:	b571                	j	7fa <vprintf+0x42>
 970:	74e2                	ld	s1,56(sp)
 972:	79a2                	ld	s3,40(sp)
 974:	7a02                	ld	s4,32(sp)
 976:	6ae2                	ld	s5,24(sp)
 978:	6b42                	ld	s6,16(sp)
 97a:	6ba2                	ld	s7,8(sp)
    }
  }
}
 97c:	60a6                	ld	ra,72(sp)
 97e:	6406                	ld	s0,64(sp)
 980:	7942                	ld	s2,48(sp)
 982:	6161                	addi	sp,sp,80
 984:	8082                	ret

0000000000000986 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 986:	715d                	addi	sp,sp,-80
 988:	ec06                	sd	ra,24(sp)
 98a:	e822                	sd	s0,16(sp)
 98c:	1000                	addi	s0,sp,32
 98e:	e010                	sd	a2,0(s0)
 990:	e414                	sd	a3,8(s0)
 992:	e818                	sd	a4,16(s0)
 994:	ec1c                	sd	a5,24(s0)
 996:	03043023          	sd	a6,32(s0)
 99a:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 99e:	8622                	mv	a2,s0
 9a0:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 9a4:	00000097          	auipc	ra,0x0
 9a8:	e14080e7          	jalr	-492(ra) # 7b8 <vprintf>
}
 9ac:	60e2                	ld	ra,24(sp)
 9ae:	6442                	ld	s0,16(sp)
 9b0:	6161                	addi	sp,sp,80
 9b2:	8082                	ret

00000000000009b4 <printf>:

void
printf(const char *fmt, ...)
{
 9b4:	711d                	addi	sp,sp,-96
 9b6:	ec06                	sd	ra,24(sp)
 9b8:	e822                	sd	s0,16(sp)
 9ba:	1000                	addi	s0,sp,32
 9bc:	e40c                	sd	a1,8(s0)
 9be:	e810                	sd	a2,16(s0)
 9c0:	ec14                	sd	a3,24(s0)
 9c2:	f018                	sd	a4,32(s0)
 9c4:	f41c                	sd	a5,40(s0)
 9c6:	03043823          	sd	a6,48(s0)
 9ca:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 9ce:	00840613          	addi	a2,s0,8
 9d2:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 9d6:	85aa                	mv	a1,a0
 9d8:	4505                	li	a0,1
 9da:	00000097          	auipc	ra,0x0
 9de:	dde080e7          	jalr	-546(ra) # 7b8 <vprintf>
}
 9e2:	60e2                	ld	ra,24(sp)
 9e4:	6442                	ld	s0,16(sp)
 9e6:	6125                	addi	sp,sp,96
 9e8:	8082                	ret

00000000000009ea <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 9ea:	1141                	addi	sp,sp,-16
 9ec:	e406                	sd	ra,8(sp)
 9ee:	e022                	sd	s0,0(sp)
 9f0:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 9f2:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9f6:	00000797          	auipc	a5,0x0
 9fa:	2727b783          	ld	a5,626(a5) # c68 <freep>
 9fe:	a039                	j	a0c <free+0x22>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a00:	6398                	ld	a4,0(a5)
 a02:	00e7e463          	bltu	a5,a4,a0a <free+0x20>
 a06:	00e6ea63          	bltu	a3,a4,a1a <free+0x30>
{
 a0a:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a0c:	fed7fae3          	bgeu	a5,a3,a00 <free+0x16>
 a10:	6398                	ld	a4,0(a5)
 a12:	00e6e463          	bltu	a3,a4,a1a <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a16:	fee7eae3          	bltu	a5,a4,a0a <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 a1a:	ff852583          	lw	a1,-8(a0)
 a1e:	6390                	ld	a2,0(a5)
 a20:	02059813          	slli	a6,a1,0x20
 a24:	01c85713          	srli	a4,a6,0x1c
 a28:	9736                	add	a4,a4,a3
 a2a:	02e60563          	beq	a2,a4,a54 <free+0x6a>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 a2e:	fec53823          	sd	a2,-16(a0)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 a32:	4790                	lw	a2,8(a5)
 a34:	02061593          	slli	a1,a2,0x20
 a38:	01c5d713          	srli	a4,a1,0x1c
 a3c:	973e                	add	a4,a4,a5
 a3e:	02e68263          	beq	a3,a4,a62 <free+0x78>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 a42:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 a44:	00000717          	auipc	a4,0x0
 a48:	22f73223          	sd	a5,548(a4) # c68 <freep>
}
 a4c:	60a2                	ld	ra,8(sp)
 a4e:	6402                	ld	s0,0(sp)
 a50:	0141                	addi	sp,sp,16
 a52:	8082                	ret
    bp->s.size += p->s.ptr->s.size;
 a54:	4618                	lw	a4,8(a2)
 a56:	9f2d                	addw	a4,a4,a1
 a58:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 a5c:	6398                	ld	a4,0(a5)
 a5e:	6310                	ld	a2,0(a4)
 a60:	b7f9                	j	a2e <free+0x44>
    p->s.size += bp->s.size;
 a62:	ff852703          	lw	a4,-8(a0)
 a66:	9f31                	addw	a4,a4,a2
 a68:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 a6a:	ff053683          	ld	a3,-16(a0)
 a6e:	bfd1                	j	a42 <free+0x58>

0000000000000a70 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a70:	7139                	addi	sp,sp,-64
 a72:	fc06                	sd	ra,56(sp)
 a74:	f822                	sd	s0,48(sp)
 a76:	f04a                	sd	s2,32(sp)
 a78:	ec4e                	sd	s3,24(sp)
 a7a:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a7c:	02051993          	slli	s3,a0,0x20
 a80:	0209d993          	srli	s3,s3,0x20
 a84:	09bd                	addi	s3,s3,15
 a86:	0049d993          	srli	s3,s3,0x4
 a8a:	2985                	addiw	s3,s3,1
 a8c:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 a8e:	00000517          	auipc	a0,0x0
 a92:	1da53503          	ld	a0,474(a0) # c68 <freep>
 a96:	c905                	beqz	a0,ac6 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a98:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a9a:	4798                	lw	a4,8(a5)
 a9c:	09377a63          	bgeu	a4,s3,b30 <malloc+0xc0>
 aa0:	f426                	sd	s1,40(sp)
 aa2:	e852                	sd	s4,16(sp)
 aa4:	e456                	sd	s5,8(sp)
 aa6:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 aa8:	8a4e                	mv	s4,s3
 aaa:	6705                	lui	a4,0x1
 aac:	00e9f363          	bgeu	s3,a4,ab2 <malloc+0x42>
 ab0:	6a05                	lui	s4,0x1
 ab2:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 ab6:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 aba:	00000497          	auipc	s1,0x0
 abe:	1ae48493          	addi	s1,s1,430 # c68 <freep>
  if(p == (char*)-1)
 ac2:	5afd                	li	s5,-1
 ac4:	a089                	j	b06 <malloc+0x96>
 ac6:	f426                	sd	s1,40(sp)
 ac8:	e852                	sd	s4,16(sp)
 aca:	e456                	sd	s5,8(sp)
 acc:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 ace:	00000797          	auipc	a5,0x0
 ad2:	5b278793          	addi	a5,a5,1458 # 1080 <base>
 ad6:	00000717          	auipc	a4,0x0
 ada:	18f73923          	sd	a5,402(a4) # c68 <freep>
 ade:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 ae0:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 ae4:	b7d1                	j	aa8 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 ae6:	6398                	ld	a4,0(a5)
 ae8:	e118                	sd	a4,0(a0)
 aea:	a8b9                	j	b48 <malloc+0xd8>
  hp->s.size = nu;
 aec:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 af0:	0541                	addi	a0,a0,16
 af2:	00000097          	auipc	ra,0x0
 af6:	ef8080e7          	jalr	-264(ra) # 9ea <free>
  return freep;
 afa:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 afc:	c135                	beqz	a0,b60 <malloc+0xf0>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 afe:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 b00:	4798                	lw	a4,8(a5)
 b02:	03277363          	bgeu	a4,s2,b28 <malloc+0xb8>
    if(p == freep)
 b06:	6098                	ld	a4,0(s1)
 b08:	853e                	mv	a0,a5
 b0a:	fef71ae3          	bne	a4,a5,afe <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 b0e:	8552                	mv	a0,s4
 b10:	00000097          	auipc	ra,0x0
 b14:	bbe080e7          	jalr	-1090(ra) # 6ce <sbrk>
  if(p == (char*)-1)
 b18:	fd551ae3          	bne	a0,s5,aec <malloc+0x7c>
        return 0;
 b1c:	4501                	li	a0,0
 b1e:	74a2                	ld	s1,40(sp)
 b20:	6a42                	ld	s4,16(sp)
 b22:	6aa2                	ld	s5,8(sp)
 b24:	6b02                	ld	s6,0(sp)
 b26:	a03d                	j	b54 <malloc+0xe4>
 b28:	74a2                	ld	s1,40(sp)
 b2a:	6a42                	ld	s4,16(sp)
 b2c:	6aa2                	ld	s5,8(sp)
 b2e:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 b30:	fae90be3          	beq	s2,a4,ae6 <malloc+0x76>
        p->s.size -= nunits;
 b34:	4137073b          	subw	a4,a4,s3
 b38:	c798                	sw	a4,8(a5)
        p += p->s.size;
 b3a:	02071693          	slli	a3,a4,0x20
 b3e:	01c6d713          	srli	a4,a3,0x1c
 b42:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 b44:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 b48:	00000717          	auipc	a4,0x0
 b4c:	12a73023          	sd	a0,288(a4) # c68 <freep>
      return (void*)(p + 1);
 b50:	01078513          	addi	a0,a5,16
  }
}
 b54:	70e2                	ld	ra,56(sp)
 b56:	7442                	ld	s0,48(sp)
 b58:	7902                	ld	s2,32(sp)
 b5a:	69e2                	ld	s3,24(sp)
 b5c:	6121                	addi	sp,sp,64
 b5e:	8082                	ret
 b60:	74a2                	ld	s1,40(sp)
 b62:	6a42                	ld	s4,16(sp)
 b64:	6aa2                	ld	s5,8(sp)
 b66:	6b02                	ld	s6,0(sp)
 b68:	b7f5                	j	b54 <malloc+0xe4>
