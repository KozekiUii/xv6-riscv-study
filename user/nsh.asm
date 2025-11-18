
user/_nsh：     文件格式 elf64-littleriscv


Disassembly of section .text:

0000000000000000 <evaluate>:
void evaluate(cmd *parsedcmd)
{

    int pd[2];

    if (parsedcmd->type == NULLcmd)
   0:	411c                	lw	a5,0(a0)
   2:	470d                	li	a4,3
   4:	12e78263          	beq	a5,a4,128 <evaluate+0x128>
{
   8:	7179                	addi	sp,sp,-48
   a:	f406                	sd	ra,40(sp)
   c:	f022                	sd	s0,32(sp)
   e:	ec26                	sd	s1,24(sp)
  10:	1800                	addi	s0,sp,48
  12:	84aa                	mv	s1,a0
    {

        return;
    }

    switch (parsedcmd->type)
  14:	4705                	li	a4,1
  16:	0ae78c63          	beq	a5,a4,ce <evaluate+0xce>
  1a:	4709                	li	a4,2
  1c:	00e78b63          	beq	a5,a4,32 <evaluate+0x32>
  20:	e7ad                	bnez	a5,8a <evaluate+0x8a>
        /* stdin */
        break;

    case Execcmd:
        /* fprintf(2,"exec execmd: %s, %d\n",parsedcmd->cmdcontent.execcmd.argv[0], strlen(parsedcmd->cmdcontent.execcmd.argv[0])); */
        exec(parsedcmd->cmdcontent.execcmd.argv[0], parsedcmd->cmdcontent.execcmd.argv);
  22:	00850593          	addi	a1,a0,8
  26:	6508                	ld	a0,8(a0)
  28:	00001097          	auipc	ra,0x1
  2c:	980080e7          	jalr	-1664(ra) # 9a8 <exec>
        break;
  30:	a8a9                	j	8a <evaluate+0x8a>
        pipe(pd);
  32:	fd840513          	addi	a0,s0,-40
  36:	00001097          	auipc	ra,0x1
  3a:	94a080e7          	jalr	-1718(ra) # 980 <pipe>
        if (fork() == 0)
  3e:	00001097          	auipc	ra,0x1
  42:	92a080e7          	jalr	-1750(ra) # 968 <fork>
  46:	e539                	bnez	a0,94 <evaluate+0x94>
            close(1);
  48:	4505                	li	a0,1
  4a:	00001097          	auipc	ra,0x1
  4e:	94e080e7          	jalr	-1714(ra) # 998 <close>
            dup(pd[1]);
  52:	fdc42503          	lw	a0,-36(s0)
  56:	00001097          	auipc	ra,0x1
  5a:	992080e7          	jalr	-1646(ra) # 9e8 <dup>
            close(pd[0]);
  5e:	fd842503          	lw	a0,-40(s0)
  62:	00001097          	auipc	ra,0x1
  66:	936080e7          	jalr	-1738(ra) # 998 <close>
            close(pd[1]);
  6a:	fdc42503          	lw	a0,-36(s0)
  6e:	00001097          	auipc	ra,0x1
  72:	92a080e7          	jalr	-1750(ra) # 998 <close>
            evaluate(parsedcmd->cmdcontent.pipecmd.leftcmd);
  76:	6488                	ld	a0,8(s1)
  78:	00000097          	auipc	ra,0x0
  7c:	f88080e7          	jalr	-120(ra) # 0 <evaluate>
        wait(0);
  80:	4501                	li	a0,0
  82:	00001097          	auipc	ra,0x1
  86:	8f6080e7          	jalr	-1802(ra) # 978 <wait>
        }
        break;
    default:
        break;
    }
}
  8a:	70a2                	ld	ra,40(sp)
  8c:	7402                	ld	s0,32(sp)
  8e:	64e2                	ld	s1,24(sp)
  90:	6145                	addi	sp,sp,48
  92:	8082                	ret
            close(0);
  94:	4501                	li	a0,0
  96:	00001097          	auipc	ra,0x1
  9a:	902080e7          	jalr	-1790(ra) # 998 <close>
            dup(pd[0]);
  9e:	fd842503          	lw	a0,-40(s0)
  a2:	00001097          	auipc	ra,0x1
  a6:	946080e7          	jalr	-1722(ra) # 9e8 <dup>
            close(pd[0]);
  aa:	fd842503          	lw	a0,-40(s0)
  ae:	00001097          	auipc	ra,0x1
  b2:	8ea080e7          	jalr	-1814(ra) # 998 <close>
            close(pd[1]);
  b6:	fdc42503          	lw	a0,-36(s0)
  ba:	00001097          	auipc	ra,0x1
  be:	8de080e7          	jalr	-1826(ra) # 998 <close>
            evaluate(parsedcmd->cmdcontent.pipecmd.rightcmd);
  c2:	6888                	ld	a0,16(s1)
  c4:	00000097          	auipc	ra,0x0
  c8:	f3c080e7          	jalr	-196(ra) # 0 <evaluate>
  cc:	bf55                	j	80 <evaluate+0x80>
        close(parsedcmd->cmdcontent.redircmd.fd);
  ce:	4d48                	lw	a0,28(a0)
  d0:	00001097          	auipc	ra,0x1
  d4:	8c8080e7          	jalr	-1848(ra) # 998 <close>
        if (open(parsedcmd->cmdcontent.redircmd.file, parsedcmd->cmdcontent.redircmd.mode) < 0)
  d8:	548c                	lw	a1,40(s1)
  da:	7088                	ld	a0,32(s1)
  dc:	00001097          	auipc	ra,0x1
  e0:	8d4080e7          	jalr	-1836(ra) # 9b0 <open>
  e4:	00054d63          	bltz	a0,fe <evaluate+0xfe>
        if (parsedcmd->cmdcontent.redircmd.redirtype == File2stdin)
  e8:	4c9c                	lw	a5,24(s1)
  ea:	4705                	li	a4,1
  ec:	02e78863          	beq	a5,a4,11c <evaluate+0x11c>
        else if (parsedcmd->cmdcontent.redircmd.redirtype == Stdout2file)
  f0:	ffc9                	bnez	a5,8a <evaluate+0x8a>
            evaluate(parsedcmd->cmdcontent.redircmd.stdoutcmd);
  f2:	6888                	ld	a0,16(s1)
  f4:	00000097          	auipc	ra,0x0
  f8:	f0c080e7          	jalr	-244(ra) # 0 <evaluate>
  fc:	b779                	j	8a <evaluate+0x8a>
            fprintf(2, "open %s failed\n", parsedcmd->cmdcontent.redircmd.file);
  fe:	7090                	ld	a2,32(s1)
 100:	00001597          	auipc	a1,0x1
 104:	d9858593          	addi	a1,a1,-616 # e98 <malloc+0xfe>
 108:	4509                	li	a0,2
 10a:	00001097          	auipc	ra,0x1
 10e:	ba6080e7          	jalr	-1114(ra) # cb0 <fprintf>
            exit(-1);
 112:	557d                	li	a0,-1
 114:	00001097          	auipc	ra,0x1
 118:	85c080e7          	jalr	-1956(ra) # 970 <exit>
            evaluate(parsedcmd->cmdcontent.redircmd.stdincmd);
 11c:	6488                	ld	a0,8(s1)
 11e:	00000097          	auipc	ra,0x0
 122:	ee2080e7          	jalr	-286(ra) # 0 <evaluate>
 126:	b795                	j	8a <evaluate+0x8a>
 128:	8082                	ret

000000000000012a <init>:
    }
    return &cmdstack[currentstackpointer];
}

void init()
{
 12a:	1141                	addi	sp,sp,-16
 12c:	e406                	sd	ra,8(sp)
 12e:	e022                	sd	s0,0(sp)
 130:	0800                	addi	s0,sp,16

    memset(tokens, 0, sizeof(tokens));
 132:	50000613          	li	a2,1280
 136:	4581                	li	a1,0
 138:	00001517          	auipc	a0,0x1
 13c:	e2050513          	addi	a0,a0,-480 # f58 <tokens>
 140:	00000097          	auipc	ra,0x0
 144:	61e080e7          	jalr	1566(ra) # 75e <memset>
    memset(files, 0, sizeof(files));
 148:	50000613          	li	a2,1280
 14c:	4581                	li	a1,0
 14e:	00001517          	auipc	a0,0x1
 152:	30a50513          	addi	a0,a0,778 # 1458 <files>
 156:	00000097          	auipc	ra,0x0
 15a:	608080e7          	jalr	1544(ra) # 75e <memset>
    memset(cmdstack, 0, sizeof(cmdstack));
 15e:	6609                	lui	a2,0x2
 160:	26060613          	addi	a2,a2,608 # 2260 <cmdstack+0x8b0>
 164:	4581                	li	a1,0
 166:	00002517          	auipc	a0,0x2
 16a:	84a50513          	addi	a0,a0,-1974 # 19b0 <cmdstack>
 16e:	00000097          	auipc	ra,0x0
 172:	5f0080e7          	jalr	1520(ra) # 75e <memset>
    for (int i = 0; i < MAXSTACKSIZ; i++)
 176:	00002797          	auipc	a5,0x2
 17a:	83a78793          	addi	a5,a5,-1990 # 19b0 <cmdstack>
 17e:	00004697          	auipc	a3,0x4
 182:	a9268693          	addi	a3,a3,-1390 # 3c10 <base>
    {

        /* code */
        cmdstack[i].type = NULLcmd;
 186:	470d                	li	a4,3
 188:	c398                	sw	a4,0(a5)
    for (int i = 0; i < MAXSTACKSIZ; i++)
 18a:	05878793          	addi	a5,a5,88
 18e:	fed79de3          	bne	a5,a3,188 <init+0x5e>
    }
}
 192:	60a2                	ld	ra,8(sp)
 194:	6402                	ld	s0,0(sp)
 196:	0141                	addi	sp,sp,16
 198:	8082                	ret

000000000000019a <allocatestack>:
/* 分配栈 */
int allocatestack()
{
 19a:	1141                	addi	sp,sp,-16
 19c:	e406                	sd	ra,8(sp)
 19e:	e022                	sd	s0,0(sp)
 1a0:	0800                	addi	s0,sp,16

    int newpointer = 0;
    while (cmdstack[newpointer].type != NULLcmd)
 1a2:	00002717          	auipc	a4,0x2
 1a6:	80e72703          	lw	a4,-2034(a4) # 19b0 <cmdstack>
 1aa:	478d                	li	a5,3
 1ac:	02f70363          	beq	a4,a5,1d2 <allocatestack+0x38>
 1b0:	00002797          	auipc	a5,0x2
 1b4:	85878793          	addi	a5,a5,-1960 # 1a08 <cmdstack+0x58>
    int newpointer = 0;
 1b8:	4501                	li	a0,0
    while (cmdstack[newpointer].type != NULLcmd)
 1ba:	468d                	li	a3,3
        newpointer++;
 1bc:	2505                	addiw	a0,a0,1
    while (cmdstack[newpointer].type != NULLcmd)
 1be:	05878793          	addi	a5,a5,88
 1c2:	fa87a703          	lw	a4,-88(a5)
 1c6:	fed71be3          	bne	a4,a3,1bc <allocatestack+0x22>
    return newpointer;
}
 1ca:	60a2                	ld	ra,8(sp)
 1cc:	6402                	ld	s0,0(sp)
 1ce:	0141                	addi	sp,sp,16
 1d0:	8082                	ret
    int newpointer = 0;
 1d2:	4501                	li	a0,0
 1d4:	bfdd                	j	1ca <allocatestack+0x30>

00000000000001d6 <allocatetokens>:

int allocatetokens()
{
 1d6:	1141                	addi	sp,sp,-16
 1d8:	e406                	sd	ra,8(sp)
 1da:	e022                	sd	s0,0(sp)
 1dc:	0800                	addi	s0,sp,16

    int newpointer = 0;
    while (tokens[newpointer][0] != 0)
 1de:	00001797          	auipc	a5,0x1
 1e2:	d7a7c783          	lbu	a5,-646(a5) # f58 <tokens>
 1e6:	c385                	beqz	a5,206 <allocatetokens+0x30>
 1e8:	00001797          	auipc	a5,0x1
 1ec:	d7078793          	addi	a5,a5,-656 # f58 <tokens>
    int newpointer = 0;
 1f0:	4501                	li	a0,0
        newpointer++;
 1f2:	2505                	addiw	a0,a0,1
    while (tokens[newpointer][0] != 0)
 1f4:	08078793          	addi	a5,a5,128
 1f8:	0007c703          	lbu	a4,0(a5)
 1fc:	fb7d                	bnez	a4,1f2 <allocatetokens+0x1c>
    return newpointer;
}
 1fe:	60a2                	ld	ra,8(sp)
 200:	6402                	ld	s0,0(sp)
 202:	0141                	addi	sp,sp,16
 204:	8082                	ret
    int newpointer = 0;
 206:	4501                	li	a0,0
 208:	bfdd                	j	1fe <allocatetokens+0x28>

000000000000020a <allocatefiles>:

int allocatefiles()
{
 20a:	1141                	addi	sp,sp,-16
 20c:	e406                	sd	ra,8(sp)
 20e:	e022                	sd	s0,0(sp)
 210:	0800                	addi	s0,sp,16

    int newpointer = 0;
    while (files[newpointer][0] != 0)
 212:	00001797          	auipc	a5,0x1
 216:	2467c783          	lbu	a5,582(a5) # 1458 <files>
 21a:	c385                	beqz	a5,23a <allocatefiles+0x30>
 21c:	00001797          	auipc	a5,0x1
 220:	23c78793          	addi	a5,a5,572 # 1458 <files>
    int newpointer = 0;
 224:	4501                	li	a0,0
        newpointer++;
 226:	2505                	addiw	a0,a0,1
    while (files[newpointer][0] != 0)
 228:	08078793          	addi	a5,a5,128
 22c:	0007c703          	lbu	a4,0(a5)
 230:	fb7d                	bnez	a4,226 <allocatefiles+0x1c>
    return newpointer;
}
 232:	60a2                	ld	ra,8(sp)
 234:	6402                	ld	s0,0(sp)
 236:	0141                	addi	sp,sp,16
 238:	8082                	ret
    int newpointer = 0;
 23a:	4501                	li	a0,0
 23c:	bfdd                	j	232 <allocatefiles+0x28>

000000000000023e <preprocessCmd>:

/* 去掉回车符 */
void preprocessCmd(char *cmd)
{
 23e:	1101                	addi	sp,sp,-32
 240:	ec06                	sd	ra,24(sp)
 242:	e822                	sd	s0,16(sp)
 244:	e426                	sd	s1,8(sp)
 246:	1000                	addi	s0,sp,32
 248:	84aa                	mv	s1,a0

    int n = strlen(cmd);
 24a:	00000097          	auipc	ra,0x0
 24e:	4e8080e7          	jalr	1256(ra) # 732 <strlen>
    if (n > MAXBUFSIZ)
 252:	10000793          	li	a5,256
 256:	00a7ce63          	blt	a5,a0,272 <preprocessCmd+0x34>
    }
    else
    {

        /* code */
        if (cmd[n - 1] == '\n')
 25a:	157d                	addi	a0,a0,-1
 25c:	9526                	add	a0,a0,s1
 25e:	00054703          	lbu	a4,0(a0)
 262:	47a9                	li	a5,10
 264:	02f70463          	beq	a4,a5,28c <preprocessCmd+0x4e>
        {

            cmd[n - 1] = '\0';
        }
    }
}
 268:	60e2                	ld	ra,24(sp)
 26a:	6442                	ld	s0,16(sp)
 26c:	64a2                	ld	s1,8(sp)
 26e:	6105                	addi	sp,sp,32
 270:	8082                	ret
        printf("command too long!");
 272:	00001517          	auipc	a0,0x1
 276:	c3650513          	addi	a0,a0,-970 # ea8 <malloc+0x10e>
 27a:	00001097          	auipc	ra,0x1
 27e:	a64080e7          	jalr	-1436(ra) # cde <printf>
        exit(0);
 282:	4501                	li	a0,0
 284:	00000097          	auipc	ra,0x0
 288:	6ec080e7          	jalr	1772(ra) # 970 <exit>
            cmd[n - 1] = '\0';
 28c:	00050023          	sb	zero,0(a0)
}
 290:	bfe1                	j	268 <preprocessCmd+0x2a>

0000000000000292 <parsetoken>:

/************************* Utils **************************/
void parsetoken(char **token, char *endoftoken, char *parsedtoken)
{
 292:	1141                	addi	sp,sp,-16
 294:	e406                	sd	ra,8(sp)
 296:	e022                	sd	s0,0(sp)
 298:	0800                	addi	s0,sp,16

    // printf("gettoken: ");
    char *s = *token;
 29a:	6118                	ld	a4,0(a0)
    for (; s < endoftoken; s++)
 29c:	02b77263          	bgeu	a4,a1,2c0 <parsetoken+0x2e>
 2a0:	883a                	mv	a6,a4
 2a2:	40e58533          	sub	a0,a1,a4
 2a6:	9532                	add	a0,a0,a2
 2a8:	87b2                	mv	a5,a2
    {

        *(parsedtoken++) = *s;
 2aa:	0785                	addi	a5,a5,1
 2ac:	00074683          	lbu	a3,0(a4)
 2b0:	fed78fa3          	sb	a3,-1(a5)
    for (; s < endoftoken; s++)
 2b4:	0705                	addi	a4,a4,1
 2b6:	fea79ae3          	bne	a5,a0,2aa <parsetoken+0x18>
 2ba:	962e                	add	a2,a2,a1
 2bc:	41060633          	sub	a2,a2,a6
        // printf("%c", *s);
    }
    *parsedtoken = '\0';
 2c0:	00060023          	sb	zero,0(a2)
    // printf("\n");
}
 2c4:	60a2                	ld	ra,8(sp)
 2c6:	6402                	ld	s0,0(sp)
 2c8:	0141                	addi	sp,sp,16
 2ca:	8082                	ret

00000000000002cc <gettoken>:

int gettoken(char **ps, char *es, int startpos, char **token, char **endoftoken)
{
 2cc:	7139                	addi	sp,sp,-64
 2ce:	fc06                	sd	ra,56(sp)
 2d0:	f822                	sd	s0,48(sp)
 2d2:	f426                	sd	s1,40(sp)
 2d4:	f04a                	sd	s2,32(sp)
 2d6:	ec4e                	sd	s3,24(sp)
 2d8:	e852                	sd	s4,16(sp)
 2da:	e456                	sd	s5,8(sp)
 2dc:	e05a                	sd	s6,0(sp)
 2de:	0080                	addi	s0,sp,64
 2e0:	89ae                	mv	s3,a1
 2e2:	8932                	mv	s2,a2
 2e4:	8ab6                	mv	s5,a3
 2e6:	8b3a                	mv	s6,a4

    char *s;
    int pos = startpos;
    s = *ps + startpos;
 2e8:	6104                	ld	s1,0(a0)
 2ea:	94b2                	add	s1,s1,a2
    /* 清理所有s的空格 trim */
    while (s < es && strchr(whitespace, *s))
 2ec:	00001a17          	auipc	s4,0x1
 2f0:	c5ca0a13          	addi	s4,s4,-932 # f48 <whitespace>
 2f4:	06b4fc63          	bgeu	s1,a1,36c <gettoken+0xa0>
 2f8:	0004c583          	lbu	a1,0(s1)
 2fc:	8552                	mv	a0,s4
 2fe:	00000097          	auipc	ra,0x0
 302:	486080e7          	jalr	1158(ra) # 784 <strchr>
 306:	cd01                	beqz	a0,31e <gettoken+0x52>
    {

        s++;
 308:	0485                	addi	s1,s1,1
        pos++;
 30a:	0019079b          	addiw	a5,s2,1
 30e:	893e                	mv	s2,a5
    while (s < es && strchr(whitespace, *s))
 310:	fe9994e3          	bne	s3,s1,2f8 <gettoken+0x2c>
    }
    *token = s;
 314:	013ab023          	sd	s3,0(s5)
 318:	853e                	mv	a0,a5
 31a:	84ce                	mv	s1,s3
 31c:	a825                	j	354 <gettoken+0x88>
 31e:	009ab023          	sd	s1,0(s5)
    while (s < es && !strchr(whitespace, *s))
 322:	00001a17          	auipc	s4,0x1
 326:	c26a0a13          	addi	s4,s4,-986 # f48 <whitespace>
 32a:	854a                	mv	a0,s2
 32c:	0334f463          	bgeu	s1,s3,354 <gettoken+0x88>
 330:	0004c583          	lbu	a1,0(s1)
 334:	8552                	mv	a0,s4
 336:	00000097          	auipc	ra,0x0
 33a:	44e080e7          	jalr	1102(ra) # 784 <strchr>
 33e:	e911                	bnez	a0,352 <gettoken+0x86>
    {

        /* code */
        s++;
 340:	0485                	addi	s1,s1,1
        pos++;
 342:	0019079b          	addiw	a5,s2,1
 346:	893e                	mv	s2,a5
    while (s < es && !strchr(whitespace, *s))
 348:	fe9994e3          	bne	s3,s1,330 <gettoken+0x64>
 34c:	853e                	mv	a0,a5
 34e:	84ce                	mv	s1,s3
 350:	a011                	j	354 <gettoken+0x88>
 352:	854a                	mv	a0,s2
    }
    *endoftoken = s;
 354:	009b3023          	sd	s1,0(s6)
    return pos;
 358:	70e2                	ld	ra,56(sp)
 35a:	7442                	ld	s0,48(sp)
 35c:	74a2                	ld	s1,40(sp)
 35e:	7902                	ld	s2,32(sp)
 360:	69e2                	ld	s3,24(sp)
 362:	6a42                	ld	s4,16(sp)
 364:	6aa2                	ld	s5,8(sp)
 366:	6b02                	ld	s6,0(sp)
 368:	6121                	addi	sp,sp,64
 36a:	8082                	ret
    *token = s;
 36c:	e284                	sd	s1,0(a3)
    int pos = startpos;
 36e:	8532                	mv	a0,a2
 370:	b7d5                	j	354 <gettoken+0x88>

0000000000000372 <parsecmd>:
{
 372:	7119                	addi	sp,sp,-128
 374:	fc86                	sd	ra,120(sp)
 376:	f8a2                	sd	s0,112(sp)
 378:	f4a6                	sd	s1,104(sp)
 37a:	f0ca                	sd	s2,96(sp)
 37c:	ecce                	sd	s3,88(sp)
 37e:	e8d2                	sd	s4,80(sp)
 380:	0100                	addi	s0,sp,128
 382:	f8a43423          	sd	a0,-120(s0)
 386:	8a2e                	mv	s4,a1
 388:	89b2                	mv	s3,a2
    for (; s >= _cmd; s--)
 38a:	892a                	mv	s2,a0
 38c:	20a5e063          	bltu	a1,a0,58c <parsecmd+0x21a>
    s = _endofcmd;
 390:	84ae                	mv	s1,a1
        if (*s == '|')
 392:	07c00713          	li	a4,124
 396:	0004c783          	lbu	a5,0(s1)
 39a:	06e78663          	beq	a5,a4,406 <parsecmd+0x94>
    for (; s >= _cmd; s--)
 39e:	14fd                	addi	s1,s1,-1
 3a0:	ff24fbe3          	bgeu	s1,s2,396 <parsecmd+0x24>
 3a4:	e0da                	sd	s6,64(sp)
        s = _endofcmd;
 3a6:	84d2                	mv	s1,s4
            if (*s == '<' || *s == '>')
 3a8:	03c00713          	li	a4,60
 3ac:	0004c783          	lbu	a5,0(s1)
 3b0:	0fd7f793          	andi	a5,a5,253
 3b4:	0ce78463          	beq	a5,a4,47c <parsecmd+0x10a>
        for (; s >= _cmd; s--)
 3b8:	14fd                	addi	s1,s1,-1
 3ba:	ff24f9e3          	bgeu	s1,s2,3ac <parsecmd+0x3a>
            cmdstack[currentstackpointer].type = Execcmd;
 3be:	05800713          	li	a4,88
 3c2:	02e98733          	mul	a4,s3,a4
 3c6:	00001797          	auipc	a5,0x1
 3ca:	5ea78793          	addi	a5,a5,1514 # 19b0 <cmdstack>
 3ce:	97ba                	add	a5,a5,a4
 3d0:	0007a023          	sw	zero,0(a5)
            int totallen = _endofcmd - _cmd;
 3d4:	412a093b          	subw	s2,s4,s2
            while (startpos < totallen)
 3d8:	25205463          	blez	s2,620 <parsecmd+0x2ae>
 3dc:	e4d6                	sd	s5,72(sp)
 3de:	fc5e                	sd	s7,56(sp)
 3e0:	f862                	sd	s8,48(sp)
 3e2:	f466                	sd	s9,40(sp)
 3e4:	f06a                	sd	s10,32(sp)
            int count = 0;
 3e6:	4b01                	li	s6,0
            int startpos = 0;
 3e8:	4481                	li	s1,0
                startpos = gettoken(&_cmd, _endofcmd, startpos, &token, &endoftoken);
 3ea:	f9840c93          	addi	s9,s0,-104
 3ee:	f9040b93          	addi	s7,s0,-112
 3f2:	f8840c13          	addi	s8,s0,-120
                    cmdstack[currentstackpointer].cmdcontent.execcmd.argv[count] = tokens[pos];
 3f6:	00199793          	slli	a5,s3,0x1
 3fa:	97ce                	add	a5,a5,s3
 3fc:	078a                	slli	a5,a5,0x2
 3fe:	413787b3          	sub	a5,a5,s3
 402:	8d3e                	mv	s10,a5
 404:	aa41                	j	594 <parsecmd+0x222>
 406:	e4d6                	sd	s5,72(sp)
            cmdstack[currentstackpointer].type = Pipecmd;
 408:	05800793          	li	a5,88
 40c:	02f987b3          	mul	a5,s3,a5
 410:	00001a97          	auipc	s5,0x1
 414:	5a0a8a93          	addi	s5,s5,1440 # 19b0 <cmdstack>
 418:	9abe                	add	s5,s5,a5
 41a:	4789                	li	a5,2
 41c:	00faa023          	sw	a5,0(s5)
            cmdstack[currentstackpointer].cmdcontent.pipecmd.leftcmd = parsecmd(_cmd, s - 1, allocatestack());
 420:	00000097          	auipc	ra,0x0
 424:	d7a080e7          	jalr	-646(ra) # 19a <allocatestack>
 428:	862a                	mv	a2,a0
 42a:	fff48593          	addi	a1,s1,-1
 42e:	854a                	mv	a0,s2
 430:	00000097          	auipc	ra,0x0
 434:	f42080e7          	jalr	-190(ra) # 372 <parsecmd>
 438:	00aab423          	sd	a0,8(s5)
            cmdstack[currentstackpointer].cmdcontent.pipecmd.rightcmd = parsecmd(s + 1, _endofcmd, allocatestack());
 43c:	00000097          	auipc	ra,0x0
 440:	d5e080e7          	jalr	-674(ra) # 19a <allocatestack>
 444:	862a                	mv	a2,a0
 446:	85d2                	mv	a1,s4
 448:	00148513          	addi	a0,s1,1
 44c:	00000097          	auipc	ra,0x0
 450:	f26080e7          	jalr	-218(ra) # 372 <parsecmd>
 454:	00aab823          	sd	a0,16(s5)
    if (!ispipe)
 458:	6aa6                	ld	s5,72(sp)
    return &cmdstack[currentstackpointer];
 45a:	05800793          	li	a5,88
 45e:	02f989b3          	mul	s3,s3,a5
}
 462:	00001517          	auipc	a0,0x1
 466:	54e50513          	addi	a0,a0,1358 # 19b0 <cmdstack>
 46a:	954e                	add	a0,a0,s3
 46c:	70e6                	ld	ra,120(sp)
 46e:	7446                	ld	s0,112(sp)
 470:	74a6                	ld	s1,104(sp)
 472:	7906                	ld	s2,96(sp)
 474:	69e6                	ld	s3,88(sp)
 476:	6a46                	ld	s4,80(sp)
 478:	6109                	addi	sp,sp,128
 47a:	8082                	ret
 47c:	e4d6                	sd	s5,72(sp)
                cmdstack[currentstackpointer].type = Redircmd;
 47e:	05800713          	li	a4,88
 482:	02e98733          	mul	a4,s3,a4
 486:	00001797          	auipc	a5,0x1
 48a:	52a78793          	addi	a5,a5,1322 # 19b0 <cmdstack>
 48e:	97ba                	add	a5,a5,a4
 490:	4705                	li	a4,1
 492:	c398                	sw	a4,0(a5)
                if (*s == '<')
 494:	0004c703          	lbu	a4,0(s1)
 498:	03c00793          	li	a5,60
 49c:	0af70663          	beq	a4,a5,548 <parsecmd+0x1d6>
                    cmdstack[currentstackpointer].cmdcontent.redircmd.redirtype = Stdout2file;
 4a0:	05800713          	li	a4,88
 4a4:	02e98733          	mul	a4,s3,a4
 4a8:	00001797          	auipc	a5,0x1
 4ac:	50878793          	addi	a5,a5,1288 # 19b0 <cmdstack>
 4b0:	97ba                	add	a5,a5,a4
 4b2:	0007ac23          	sw	zero,24(a5)
                    cmdstack[currentstackpointer].cmdcontent.redircmd.fd = 1;
 4b6:	4705                	li	a4,1
 4b8:	cfd8                	sw	a4,28(a5)
                    cmdstack[currentstackpointer].cmdcontent.redircmd.stdincmd = &nullcmd;
 4ba:	00001717          	auipc	a4,0x1
 4be:	49e70713          	addi	a4,a4,1182 # 1958 <nullcmd>
 4c2:	e798                	sd	a4,8(a5)
                    cmdstack[currentstackpointer].cmdcontent.redircmd.stdoutcmd = parsecmd(_cmd, s - 1, allocatestack());
 4c4:	00000097          	auipc	ra,0x0
 4c8:	cd6080e7          	jalr	-810(ra) # 19a <allocatestack>
 4cc:	862a                	mv	a2,a0
 4ce:	fff48593          	addi	a1,s1,-1
 4d2:	854a                	mv	a0,s2
 4d4:	00000097          	auipc	ra,0x0
 4d8:	e9e080e7          	jalr	-354(ra) # 372 <parsecmd>
 4dc:	20100713          	li	a4,513
                    cmdstack[currentstackpointer].cmdcontent.redircmd.stdoutcmd = &nullcmd;
 4e0:	05800793          	li	a5,88
 4e4:	02f987b3          	mul	a5,s3,a5
 4e8:	00001a97          	auipc	s5,0x1
 4ec:	4c8a8a93          	addi	s5,s5,1224 # 19b0 <cmdstack>
 4f0:	9abe                	add	s5,s5,a5
 4f2:	00aab823          	sd	a0,16(s5)
                    cmdstack[currentstackpointer].cmdcontent.redircmd.mode = O_RDONLY;
 4f6:	02eaa423          	sw	a4,40(s5)
                gettoken(&_cmd, _endofcmd, s - _cmd + 1, &file, &endoffile);
 4fa:	f9040b13          	addi	s6,s0,-112
 4fe:	412484b3          	sub	s1,s1,s2
 502:	f9840713          	addi	a4,s0,-104
 506:	86da                	mv	a3,s6
 508:	0014861b          	addiw	a2,s1,1
 50c:	85d2                	mv	a1,s4
 50e:	f8840513          	addi	a0,s0,-120
 512:	00000097          	auipc	ra,0x0
 516:	dba080e7          	jalr	-582(ra) # 2cc <gettoken>
                int pos = allocatefiles();
 51a:	00000097          	auipc	ra,0x0
 51e:	cf0080e7          	jalr	-784(ra) # 20a <allocatefiles>
                parsetoken(&file, endoffile, files[pos]);
 522:	051e                	slli	a0,a0,0x7
 524:	00001497          	auipc	s1,0x1
 528:	f3448493          	addi	s1,s1,-204 # 1458 <files>
 52c:	94aa                	add	s1,s1,a0
 52e:	8626                	mv	a2,s1
 530:	f9843583          	ld	a1,-104(s0)
 534:	855a                	mv	a0,s6
 536:	00000097          	auipc	ra,0x0
 53a:	d5c080e7          	jalr	-676(ra) # 292 <parsetoken>
                cmdstack[currentstackpointer].cmdcontent.redircmd.file = files[pos];
 53e:	029ab023          	sd	s1,32(s5)
        if (isexec)
 542:	6aa6                	ld	s5,72(sp)
 544:	6b06                	ld	s6,64(sp)
 546:	bf11                	j	45a <parsecmd+0xe8>
                    cmdstack[currentstackpointer].cmdcontent.redircmd.redirtype = File2stdin;
 548:	05800793          	li	a5,88
 54c:	02f987b3          	mul	a5,s3,a5
 550:	00001a97          	auipc	s5,0x1
 554:	460a8a93          	addi	s5,s5,1120 # 19b0 <cmdstack>
 558:	9abe                	add	s5,s5,a5
 55a:	4785                	li	a5,1
 55c:	00faac23          	sw	a5,24(s5)
                    cmdstack[currentstackpointer].cmdcontent.redircmd.fd = 0;
 560:	000aae23          	sw	zero,28(s5)
                    cmdstack[currentstackpointer].cmdcontent.redircmd.stdincmd = parsecmd(_cmd, s - 1, allocatestack());
 564:	00000097          	auipc	ra,0x0
 568:	c36080e7          	jalr	-970(ra) # 19a <allocatestack>
 56c:	862a                	mv	a2,a0
 56e:	fff48593          	addi	a1,s1,-1
 572:	854a                	mv	a0,s2
 574:	00000097          	auipc	ra,0x0
 578:	dfe080e7          	jalr	-514(ra) # 372 <parsecmd>
 57c:	00aab423          	sd	a0,8(s5)
                    cmdstack[currentstackpointer].cmdcontent.redircmd.mode = O_RDONLY;
 580:	00001517          	auipc	a0,0x1
 584:	3d850513          	addi	a0,a0,984 # 1958 <nullcmd>
 588:	4701                	li	a4,0
 58a:	bf99                	j	4e0 <parsecmd+0x16e>
 58c:	e0da                	sd	s6,64(sp)
 58e:	bd05                	j	3be <parsecmd+0x4c>
            while (startpos < totallen)
 590:	0724d263          	bge	s1,s2,5f4 <parsecmd+0x282>
                startpos = gettoken(&_cmd, _endofcmd, startpos, &token, &endoftoken);
 594:	8766                	mv	a4,s9
 596:	86de                	mv	a3,s7
 598:	8626                	mv	a2,s1
 59a:	85d2                	mv	a1,s4
 59c:	8562                	mv	a0,s8
 59e:	00000097          	auipc	ra,0x0
 5a2:	d2e080e7          	jalr	-722(ra) # 2cc <gettoken>
 5a6:	84aa                	mv	s1,a0
                if (*token != ' ')
 5a8:	f9043783          	ld	a5,-112(s0)
 5ac:	0007c703          	lbu	a4,0(a5)
 5b0:	02000793          	li	a5,32
 5b4:	fcf70ee3          	beq	a4,a5,590 <parsecmd+0x21e>
                    int pos = allocatetokens();
 5b8:	00000097          	auipc	ra,0x0
 5bc:	c1e080e7          	jalr	-994(ra) # 1d6 <allocatetokens>
                    parsetoken(&token, endoftoken, tokens[pos]);
 5c0:	051e                	slli	a0,a0,0x7
 5c2:	00001a97          	auipc	s5,0x1
 5c6:	996a8a93          	addi	s5,s5,-1642 # f58 <tokens>
 5ca:	9aaa                	add	s5,s5,a0
 5cc:	8656                	mv	a2,s5
 5ce:	f9843583          	ld	a1,-104(s0)
 5d2:	855e                	mv	a0,s7
 5d4:	00000097          	auipc	ra,0x0
 5d8:	cbe080e7          	jalr	-834(ra) # 292 <parsetoken>
                    cmdstack[currentstackpointer].cmdcontent.execcmd.argv[count] = tokens[pos];
 5dc:	016d0733          	add	a4,s10,s6
 5e0:	070e                	slli	a4,a4,0x3
 5e2:	00001797          	auipc	a5,0x1
 5e6:	3ce78793          	addi	a5,a5,974 # 19b0 <cmdstack>
 5ea:	97ba                	add	a5,a5,a4
 5ec:	0157b423          	sd	s5,8(a5)
                    count++;
 5f0:	2b05                	addiw	s6,s6,1
 5f2:	bf79                	j	590 <parsecmd+0x21e>
 5f4:	6aa6                	ld	s5,72(sp)
 5f6:	7be2                	ld	s7,56(sp)
 5f8:	7c42                	ld	s8,48(sp)
 5fa:	7ca2                	ld	s9,40(sp)
 5fc:	7d02                	ld	s10,32(sp)
            cmdstack[currentstackpointer].cmdcontent.execcmd.argv[count] = 0;
 5fe:	00199793          	slli	a5,s3,0x1
 602:	97ce                	add	a5,a5,s3
 604:	078a                	slli	a5,a5,0x2
 606:	413787b3          	sub	a5,a5,s3
 60a:	97da                	add	a5,a5,s6
 60c:	078e                	slli	a5,a5,0x3
 60e:	00001717          	auipc	a4,0x1
 612:	3a270713          	addi	a4,a4,930 # 19b0 <cmdstack>
 616:	97ba                	add	a5,a5,a4
 618:	0007b423          	sd	zero,8(a5)
 61c:	6b06                	ld	s6,64(sp)
 61e:	bd35                	j	45a <parsecmd+0xe8>
            int count = 0;
 620:	4b01                	li	s6,0
 622:	bff1                	j	5fe <parsecmd+0x28c>

0000000000000624 <main>:
{
 624:	7169                	addi	sp,sp,-304
 626:	f606                	sd	ra,296(sp)
 628:	f222                	sd	s0,288(sp)
 62a:	ee26                	sd	s1,280(sp)
 62c:	ea4a                	sd	s2,272(sp)
 62e:	e64e                	sd	s3,264(sp)
 630:	e252                	sd	s4,256(sp)
 632:	1a00                	addi	s0,sp,304
    nullcmd.type = NULLcmd;
 634:	478d                	li	a5,3
 636:	00001717          	auipc	a4,0x1
 63a:	32f72123          	sw	a5,802(a4) # 1958 <nullcmd>
        memset(_cmd, 0, sizeof(_cmd));
 63e:	ed040493          	addi	s1,s0,-304
 642:	10000993          	li	s3,256
        printf("@ ");
 646:	00001a17          	auipc	s4,0x1
 64a:	87aa0a13          	addi	s4,s4,-1926 # ec0 <malloc+0x126>
 64e:	a819                	j	664 <main+0x40>
            exit(0);
 650:	4501                	li	a0,0
 652:	00000097          	auipc	ra,0x0
 656:	31e080e7          	jalr	798(ra) # 970 <exit>
        wait(0);
 65a:	4501                	li	a0,0
 65c:	00000097          	auipc	ra,0x0
 660:	31c080e7          	jalr	796(ra) # 978 <wait>
        memset(_cmd, 0, sizeof(_cmd));
 664:	864e                	mv	a2,s3
 666:	4581                	li	a1,0
 668:	8526                	mv	a0,s1
 66a:	00000097          	auipc	ra,0x0
 66e:	0f4080e7          	jalr	244(ra) # 75e <memset>
        printf("@ ");
 672:	8552                	mv	a0,s4
 674:	00000097          	auipc	ra,0x0
 678:	66a080e7          	jalr	1642(ra) # cde <printf>
        gets(_cmd, MAXBUFSIZ);
 67c:	85ce                	mv	a1,s3
 67e:	8526                	mv	a0,s1
 680:	00000097          	auipc	ra,0x0
 684:	12c080e7          	jalr	300(ra) # 7ac <gets>
        preprocessCmd(_cmd);
 688:	8526                	mv	a0,s1
 68a:	00000097          	auipc	ra,0x0
 68e:	bb4080e7          	jalr	-1100(ra) # 23e <preprocessCmd>
        if (strlen(_cmd) == 0 || _cmd[0] == 0)
 692:	8526                	mv	a0,s1
 694:	00000097          	auipc	ra,0x0
 698:	09e080e7          	jalr	158(ra) # 732 <strlen>
 69c:	d955                	beqz	a0,650 <main+0x2c>
 69e:	ed044783          	lbu	a5,-304(s0)
 6a2:	d7dd                	beqz	a5,650 <main+0x2c>
        init();
 6a4:	00000097          	auipc	ra,0x0
 6a8:	a86080e7          	jalr	-1402(ra) # 12a <init>
        endofcmd = _cmd + strlen(_cmd);
 6ac:	8526                	mv	a0,s1
 6ae:	00000097          	auipc	ra,0x0
 6b2:	084080e7          	jalr	132(ra) # 732 <strlen>
 6b6:	02051593          	slli	a1,a0,0x20
 6ba:	9181                	srli	a1,a1,0x20
        cmd *parsedcmd = parsecmd(_cmd, endofcmd, 0);
 6bc:	4601                	li	a2,0
 6be:	95a6                	add	a1,a1,s1
 6c0:	8526                	mv	a0,s1
 6c2:	00000097          	auipc	ra,0x0
 6c6:	cb0080e7          	jalr	-848(ra) # 372 <parsecmd>
 6ca:	892a                	mv	s2,a0
        if (fork() == 0)
 6cc:	00000097          	auipc	ra,0x0
 6d0:	29c080e7          	jalr	668(ra) # 968 <fork>
 6d4:	f159                	bnez	a0,65a <main+0x36>
            evaluate(parsedcmd);
 6d6:	854a                	mv	a0,s2
 6d8:	00000097          	auipc	ra,0x0
 6dc:	928080e7          	jalr	-1752(ra) # 0 <evaluate>
 6e0:	bfad                	j	65a <main+0x36>

00000000000006e2 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 6e2:	1141                	addi	sp,sp,-16
 6e4:	e406                	sd	ra,8(sp)
 6e6:	e022                	sd	s0,0(sp)
 6e8:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 6ea:	87aa                	mv	a5,a0
 6ec:	0585                	addi	a1,a1,1
 6ee:	0785                	addi	a5,a5,1
 6f0:	fff5c703          	lbu	a4,-1(a1)
 6f4:	fee78fa3          	sb	a4,-1(a5)
 6f8:	fb75                	bnez	a4,6ec <strcpy+0xa>
    ;
  return os;
}
 6fa:	60a2                	ld	ra,8(sp)
 6fc:	6402                	ld	s0,0(sp)
 6fe:	0141                	addi	sp,sp,16
 700:	8082                	ret

0000000000000702 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 702:	1141                	addi	sp,sp,-16
 704:	e406                	sd	ra,8(sp)
 706:	e022                	sd	s0,0(sp)
 708:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 70a:	00054783          	lbu	a5,0(a0)
 70e:	cb91                	beqz	a5,722 <strcmp+0x20>
 710:	0005c703          	lbu	a4,0(a1)
 714:	00f71763          	bne	a4,a5,722 <strcmp+0x20>
    p++, q++;
 718:	0505                	addi	a0,a0,1
 71a:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 71c:	00054783          	lbu	a5,0(a0)
 720:	fbe5                	bnez	a5,710 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 722:	0005c503          	lbu	a0,0(a1)
}
 726:	40a7853b          	subw	a0,a5,a0
 72a:	60a2                	ld	ra,8(sp)
 72c:	6402                	ld	s0,0(sp)
 72e:	0141                	addi	sp,sp,16
 730:	8082                	ret

0000000000000732 <strlen>:

uint
strlen(const char *s)
{
 732:	1141                	addi	sp,sp,-16
 734:	e406                	sd	ra,8(sp)
 736:	e022                	sd	s0,0(sp)
 738:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 73a:	00054783          	lbu	a5,0(a0)
 73e:	cf91                	beqz	a5,75a <strlen+0x28>
 740:	00150793          	addi	a5,a0,1
 744:	86be                	mv	a3,a5
 746:	0785                	addi	a5,a5,1
 748:	fff7c703          	lbu	a4,-1(a5)
 74c:	ff65                	bnez	a4,744 <strlen+0x12>
 74e:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
 752:	60a2                	ld	ra,8(sp)
 754:	6402                	ld	s0,0(sp)
 756:	0141                	addi	sp,sp,16
 758:	8082                	ret
  for(n = 0; s[n]; n++)
 75a:	4501                	li	a0,0
 75c:	bfdd                	j	752 <strlen+0x20>

000000000000075e <memset>:

void*
memset(void *dst, int c, uint n)
{
 75e:	1141                	addi	sp,sp,-16
 760:	e406                	sd	ra,8(sp)
 762:	e022                	sd	s0,0(sp)
 764:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 766:	ca19                	beqz	a2,77c <memset+0x1e>
 768:	87aa                	mv	a5,a0
 76a:	1602                	slli	a2,a2,0x20
 76c:	9201                	srli	a2,a2,0x20
 76e:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 772:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 776:	0785                	addi	a5,a5,1
 778:	fee79de3          	bne	a5,a4,772 <memset+0x14>
  }
  return dst;
}
 77c:	60a2                	ld	ra,8(sp)
 77e:	6402                	ld	s0,0(sp)
 780:	0141                	addi	sp,sp,16
 782:	8082                	ret

0000000000000784 <strchr>:

char*
strchr(const char *s, char c)
{
 784:	1141                	addi	sp,sp,-16
 786:	e406                	sd	ra,8(sp)
 788:	e022                	sd	s0,0(sp)
 78a:	0800                	addi	s0,sp,16
  for(; *s; s++)
 78c:	00054783          	lbu	a5,0(a0)
 790:	cf81                	beqz	a5,7a8 <strchr+0x24>
    if(*s == c)
 792:	00f58763          	beq	a1,a5,7a0 <strchr+0x1c>
  for(; *s; s++)
 796:	0505                	addi	a0,a0,1
 798:	00054783          	lbu	a5,0(a0)
 79c:	fbfd                	bnez	a5,792 <strchr+0xe>
      return (char*)s;
  return 0;
 79e:	4501                	li	a0,0
}
 7a0:	60a2                	ld	ra,8(sp)
 7a2:	6402                	ld	s0,0(sp)
 7a4:	0141                	addi	sp,sp,16
 7a6:	8082                	ret
  return 0;
 7a8:	4501                	li	a0,0
 7aa:	bfdd                	j	7a0 <strchr+0x1c>

00000000000007ac <gets>:

char*
gets(char *buf, int max)
{
 7ac:	711d                	addi	sp,sp,-96
 7ae:	ec86                	sd	ra,88(sp)
 7b0:	e8a2                	sd	s0,80(sp)
 7b2:	e4a6                	sd	s1,72(sp)
 7b4:	e0ca                	sd	s2,64(sp)
 7b6:	fc4e                	sd	s3,56(sp)
 7b8:	f852                	sd	s4,48(sp)
 7ba:	f456                	sd	s5,40(sp)
 7bc:	f05a                	sd	s6,32(sp)
 7be:	ec5e                	sd	s7,24(sp)
 7c0:	e862                	sd	s8,16(sp)
 7c2:	1080                	addi	s0,sp,96
 7c4:	8baa                	mv	s7,a0
 7c6:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 7c8:	892a                	mv	s2,a0
 7ca:	4481                	li	s1,0
    cc = read(0, &c, 1);
 7cc:	faf40b13          	addi	s6,s0,-81
 7d0:	4a85                	li	s5,1
  for(i=0; i+1 < max; ){
 7d2:	8c26                	mv	s8,s1
 7d4:	0014899b          	addiw	s3,s1,1
 7d8:	84ce                	mv	s1,s3
 7da:	0349d663          	bge	s3,s4,806 <gets+0x5a>
    cc = read(0, &c, 1);
 7de:	8656                	mv	a2,s5
 7e0:	85da                	mv	a1,s6
 7e2:	4501                	li	a0,0
 7e4:	00000097          	auipc	ra,0x0
 7e8:	1a4080e7          	jalr	420(ra) # 988 <read>
    if(cc < 1)
 7ec:	00a05d63          	blez	a0,806 <gets+0x5a>
      break;
    buf[i++] = c;
 7f0:	faf44783          	lbu	a5,-81(s0)
 7f4:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 7f8:	0905                	addi	s2,s2,1
 7fa:	ff678713          	addi	a4,a5,-10
 7fe:	c319                	beqz	a4,804 <gets+0x58>
 800:	17cd                	addi	a5,a5,-13
 802:	fbe1                	bnez	a5,7d2 <gets+0x26>
    buf[i++] = c;
 804:	8c4e                	mv	s8,s3
      break;
  }
  buf[i] = '\0';
 806:	9c5e                	add	s8,s8,s7
 808:	000c0023          	sb	zero,0(s8)
  return buf;
}
 80c:	855e                	mv	a0,s7
 80e:	60e6                	ld	ra,88(sp)
 810:	6446                	ld	s0,80(sp)
 812:	64a6                	ld	s1,72(sp)
 814:	6906                	ld	s2,64(sp)
 816:	79e2                	ld	s3,56(sp)
 818:	7a42                	ld	s4,48(sp)
 81a:	7aa2                	ld	s5,40(sp)
 81c:	7b02                	ld	s6,32(sp)
 81e:	6be2                	ld	s7,24(sp)
 820:	6c42                	ld	s8,16(sp)
 822:	6125                	addi	sp,sp,96
 824:	8082                	ret

0000000000000826 <stat>:

int
stat(const char *n, struct stat *st)
{
 826:	1101                	addi	sp,sp,-32
 828:	ec06                	sd	ra,24(sp)
 82a:	e822                	sd	s0,16(sp)
 82c:	e04a                	sd	s2,0(sp)
 82e:	1000                	addi	s0,sp,32
 830:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 832:	4581                	li	a1,0
 834:	00000097          	auipc	ra,0x0
 838:	17c080e7          	jalr	380(ra) # 9b0 <open>
  if(fd < 0)
 83c:	02054663          	bltz	a0,868 <stat+0x42>
 840:	e426                	sd	s1,8(sp)
 842:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 844:	85ca                	mv	a1,s2
 846:	00000097          	auipc	ra,0x0
 84a:	182080e7          	jalr	386(ra) # 9c8 <fstat>
 84e:	892a                	mv	s2,a0
  close(fd);
 850:	8526                	mv	a0,s1
 852:	00000097          	auipc	ra,0x0
 856:	146080e7          	jalr	326(ra) # 998 <close>
  return r;
 85a:	64a2                	ld	s1,8(sp)
}
 85c:	854a                	mv	a0,s2
 85e:	60e2                	ld	ra,24(sp)
 860:	6442                	ld	s0,16(sp)
 862:	6902                	ld	s2,0(sp)
 864:	6105                	addi	sp,sp,32
 866:	8082                	ret
    return -1;
 868:	57fd                	li	a5,-1
 86a:	893e                	mv	s2,a5
 86c:	bfc5                	j	85c <stat+0x36>

000000000000086e <atoi>:

int
atoi(const char *s)
{
 86e:	1141                	addi	sp,sp,-16
 870:	e406                	sd	ra,8(sp)
 872:	e022                	sd	s0,0(sp)
 874:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 876:	00054683          	lbu	a3,0(a0)
 87a:	fd06879b          	addiw	a5,a3,-48
 87e:	0ff7f793          	zext.b	a5,a5
 882:	4625                	li	a2,9
 884:	02f66963          	bltu	a2,a5,8b6 <atoi+0x48>
 888:	872a                	mv	a4,a0
  n = 0;
 88a:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 88c:	0705                	addi	a4,a4,1
 88e:	0025179b          	slliw	a5,a0,0x2
 892:	9fa9                	addw	a5,a5,a0
 894:	0017979b          	slliw	a5,a5,0x1
 898:	9fb5                	addw	a5,a5,a3
 89a:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 89e:	00074683          	lbu	a3,0(a4)
 8a2:	fd06879b          	addiw	a5,a3,-48
 8a6:	0ff7f793          	zext.b	a5,a5
 8aa:	fef671e3          	bgeu	a2,a5,88c <atoi+0x1e>
  return n;
}
 8ae:	60a2                	ld	ra,8(sp)
 8b0:	6402                	ld	s0,0(sp)
 8b2:	0141                	addi	sp,sp,16
 8b4:	8082                	ret
  n = 0;
 8b6:	4501                	li	a0,0
 8b8:	bfdd                	j	8ae <atoi+0x40>

00000000000008ba <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 8ba:	1141                	addi	sp,sp,-16
 8bc:	e406                	sd	ra,8(sp)
 8be:	e022                	sd	s0,0(sp)
 8c0:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 8c2:	02b57563          	bgeu	a0,a1,8ec <memmove+0x32>
    while(n-- > 0)
 8c6:	00c05f63          	blez	a2,8e4 <memmove+0x2a>
 8ca:	1602                	slli	a2,a2,0x20
 8cc:	9201                	srli	a2,a2,0x20
 8ce:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 8d2:	872a                	mv	a4,a0
      *dst++ = *src++;
 8d4:	0585                	addi	a1,a1,1
 8d6:	0705                	addi	a4,a4,1
 8d8:	fff5c683          	lbu	a3,-1(a1)
 8dc:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 8e0:	fee79ae3          	bne	a5,a4,8d4 <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 8e4:	60a2                	ld	ra,8(sp)
 8e6:	6402                	ld	s0,0(sp)
 8e8:	0141                	addi	sp,sp,16
 8ea:	8082                	ret
    while(n-- > 0)
 8ec:	fec05ce3          	blez	a2,8e4 <memmove+0x2a>
    dst += n;
 8f0:	00c50733          	add	a4,a0,a2
    src += n;
 8f4:	95b2                	add	a1,a1,a2
 8f6:	fff6079b          	addiw	a5,a2,-1
 8fa:	1782                	slli	a5,a5,0x20
 8fc:	9381                	srli	a5,a5,0x20
 8fe:	fff7c793          	not	a5,a5
 902:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 904:	15fd                	addi	a1,a1,-1
 906:	177d                	addi	a4,a4,-1
 908:	0005c683          	lbu	a3,0(a1)
 90c:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 910:	fef71ae3          	bne	a4,a5,904 <memmove+0x4a>
 914:	bfc1                	j	8e4 <memmove+0x2a>

0000000000000916 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 916:	1141                	addi	sp,sp,-16
 918:	e406                	sd	ra,8(sp)
 91a:	e022                	sd	s0,0(sp)
 91c:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 91e:	c61d                	beqz	a2,94c <memcmp+0x36>
 920:	1602                	slli	a2,a2,0x20
 922:	9201                	srli	a2,a2,0x20
 924:	00c506b3          	add	a3,a0,a2
    if (*p1 != *p2) {
 928:	00054783          	lbu	a5,0(a0)
 92c:	0005c703          	lbu	a4,0(a1)
 930:	00e79863          	bne	a5,a4,940 <memcmp+0x2a>
      return *p1 - *p2;
    }
    p1++;
 934:	0505                	addi	a0,a0,1
    p2++;
 936:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 938:	fed518e3          	bne	a0,a3,928 <memcmp+0x12>
  }
  return 0;
 93c:	4501                	li	a0,0
 93e:	a019                	j	944 <memcmp+0x2e>
      return *p1 - *p2;
 940:	40e7853b          	subw	a0,a5,a4
}
 944:	60a2                	ld	ra,8(sp)
 946:	6402                	ld	s0,0(sp)
 948:	0141                	addi	sp,sp,16
 94a:	8082                	ret
  return 0;
 94c:	4501                	li	a0,0
 94e:	bfdd                	j	944 <memcmp+0x2e>

0000000000000950 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 950:	1141                	addi	sp,sp,-16
 952:	e406                	sd	ra,8(sp)
 954:	e022                	sd	s0,0(sp)
 956:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 958:	00000097          	auipc	ra,0x0
 95c:	f62080e7          	jalr	-158(ra) # 8ba <memmove>
}
 960:	60a2                	ld	ra,8(sp)
 962:	6402                	ld	s0,0(sp)
 964:	0141                	addi	sp,sp,16
 966:	8082                	ret

0000000000000968 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 968:	4885                	li	a7,1
 ecall
 96a:	00000073          	ecall
 ret
 96e:	8082                	ret

0000000000000970 <exit>:
.global exit
exit:
 li a7, SYS_exit
 970:	4889                	li	a7,2
 ecall
 972:	00000073          	ecall
 ret
 976:	8082                	ret

0000000000000978 <wait>:
.global wait
wait:
 li a7, SYS_wait
 978:	488d                	li	a7,3
 ecall
 97a:	00000073          	ecall
 ret
 97e:	8082                	ret

0000000000000980 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 980:	4891                	li	a7,4
 ecall
 982:	00000073          	ecall
 ret
 986:	8082                	ret

0000000000000988 <read>:
.global read
read:
 li a7, SYS_read
 988:	4895                	li	a7,5
 ecall
 98a:	00000073          	ecall
 ret
 98e:	8082                	ret

0000000000000990 <write>:
.global write
write:
 li a7, SYS_write
 990:	48c1                	li	a7,16
 ecall
 992:	00000073          	ecall
 ret
 996:	8082                	ret

0000000000000998 <close>:
.global close
close:
 li a7, SYS_close
 998:	48d5                	li	a7,21
 ecall
 99a:	00000073          	ecall
 ret
 99e:	8082                	ret

00000000000009a0 <kill>:
.global kill
kill:
 li a7, SYS_kill
 9a0:	4899                	li	a7,6
 ecall
 9a2:	00000073          	ecall
 ret
 9a6:	8082                	ret

00000000000009a8 <exec>:
.global exec
exec:
 li a7, SYS_exec
 9a8:	489d                	li	a7,7
 ecall
 9aa:	00000073          	ecall
 ret
 9ae:	8082                	ret

00000000000009b0 <open>:
.global open
open:
 li a7, SYS_open
 9b0:	48bd                	li	a7,15
 ecall
 9b2:	00000073          	ecall
 ret
 9b6:	8082                	ret

00000000000009b8 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 9b8:	48c5                	li	a7,17
 ecall
 9ba:	00000073          	ecall
 ret
 9be:	8082                	ret

00000000000009c0 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 9c0:	48c9                	li	a7,18
 ecall
 9c2:	00000073          	ecall
 ret
 9c6:	8082                	ret

00000000000009c8 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 9c8:	48a1                	li	a7,8
 ecall
 9ca:	00000073          	ecall
 ret
 9ce:	8082                	ret

00000000000009d0 <link>:
.global link
link:
 li a7, SYS_link
 9d0:	48cd                	li	a7,19
 ecall
 9d2:	00000073          	ecall
 ret
 9d6:	8082                	ret

00000000000009d8 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 9d8:	48d1                	li	a7,20
 ecall
 9da:	00000073          	ecall
 ret
 9de:	8082                	ret

00000000000009e0 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 9e0:	48a5                	li	a7,9
 ecall
 9e2:	00000073          	ecall
 ret
 9e6:	8082                	ret

00000000000009e8 <dup>:
.global dup
dup:
 li a7, SYS_dup
 9e8:	48a9                	li	a7,10
 ecall
 9ea:	00000073          	ecall
 ret
 9ee:	8082                	ret

00000000000009f0 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 9f0:	48ad                	li	a7,11
 ecall
 9f2:	00000073          	ecall
 ret
 9f6:	8082                	ret

00000000000009f8 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 9f8:	48b1                	li	a7,12
 ecall
 9fa:	00000073          	ecall
 ret
 9fe:	8082                	ret

0000000000000a00 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 a00:	48b5                	li	a7,13
 ecall
 a02:	00000073          	ecall
 ret
 a06:	8082                	ret

0000000000000a08 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 a08:	48b9                	li	a7,14
 ecall
 a0a:	00000073          	ecall
 ret
 a0e:	8082                	ret

0000000000000a10 <ntas>:
.global ntas
ntas:
 li a7, SYS_ntas
 a10:	48d9                	li	a7,22
 ecall
 a12:	00000073          	ecall
 ret
 a16:	8082                	ret

0000000000000a18 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 a18:	1101                	addi	sp,sp,-32
 a1a:	ec06                	sd	ra,24(sp)
 a1c:	e822                	sd	s0,16(sp)
 a1e:	1000                	addi	s0,sp,32
 a20:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 a24:	4605                	li	a2,1
 a26:	fef40593          	addi	a1,s0,-17
 a2a:	00000097          	auipc	ra,0x0
 a2e:	f66080e7          	jalr	-154(ra) # 990 <write>
}
 a32:	60e2                	ld	ra,24(sp)
 a34:	6442                	ld	s0,16(sp)
 a36:	6105                	addi	sp,sp,32
 a38:	8082                	ret

0000000000000a3a <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 a3a:	7139                	addi	sp,sp,-64
 a3c:	fc06                	sd	ra,56(sp)
 a3e:	f822                	sd	s0,48(sp)
 a40:	f04a                	sd	s2,32(sp)
 a42:	ec4e                	sd	s3,24(sp)
 a44:	0080                	addi	s0,sp,64
 a46:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 a48:	cad9                	beqz	a3,ade <printint+0xa4>
 a4a:	01f5d79b          	srliw	a5,a1,0x1f
 a4e:	cbc1                	beqz	a5,ade <printint+0xa4>
    neg = 1;
    x = -xx;
 a50:	40b005bb          	negw	a1,a1
    neg = 1;
 a54:	4305                	li	t1,1
  } else {
    x = xx;
  }

  i = 0;
 a56:	fc040993          	addi	s3,s0,-64
  neg = 0;
 a5a:	86ce                	mv	a3,s3
  i = 0;
 a5c:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 a5e:	00000817          	auipc	a6,0x0
 a62:	4ca80813          	addi	a6,a6,1226 # f28 <digits>
 a66:	88ba                	mv	a7,a4
 a68:	0017051b          	addiw	a0,a4,1
 a6c:	872a                	mv	a4,a0
 a6e:	02c5f7bb          	remuw	a5,a1,a2
 a72:	1782                	slli	a5,a5,0x20
 a74:	9381                	srli	a5,a5,0x20
 a76:	97c2                	add	a5,a5,a6
 a78:	0007c783          	lbu	a5,0(a5)
 a7c:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 a80:	87ae                	mv	a5,a1
 a82:	02c5d5bb          	divuw	a1,a1,a2
 a86:	0685                	addi	a3,a3,1
 a88:	fcc7ffe3          	bgeu	a5,a2,a66 <printint+0x2c>
  if(neg)
 a8c:	00030c63          	beqz	t1,aa4 <printint+0x6a>
    buf[i++] = '-';
 a90:	fd050793          	addi	a5,a0,-48
 a94:	00878533          	add	a0,a5,s0
 a98:	02d00793          	li	a5,45
 a9c:	fef50823          	sb	a5,-16(a0)
 aa0:	0028871b          	addiw	a4,a7,2

  while(--i >= 0)
 aa4:	02e05763          	blez	a4,ad2 <printint+0x98>
 aa8:	f426                	sd	s1,40(sp)
 aaa:	377d                	addiw	a4,a4,-1
 aac:	00e984b3          	add	s1,s3,a4
 ab0:	19fd                	addi	s3,s3,-1
 ab2:	99ba                	add	s3,s3,a4
 ab4:	1702                	slli	a4,a4,0x20
 ab6:	9301                	srli	a4,a4,0x20
 ab8:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 abc:	0004c583          	lbu	a1,0(s1)
 ac0:	854a                	mv	a0,s2
 ac2:	00000097          	auipc	ra,0x0
 ac6:	f56080e7          	jalr	-170(ra) # a18 <putc>
  while(--i >= 0)
 aca:	14fd                	addi	s1,s1,-1
 acc:	ff3498e3          	bne	s1,s3,abc <printint+0x82>
 ad0:	74a2                	ld	s1,40(sp)
}
 ad2:	70e2                	ld	ra,56(sp)
 ad4:	7442                	ld	s0,48(sp)
 ad6:	7902                	ld	s2,32(sp)
 ad8:	69e2                	ld	s3,24(sp)
 ada:	6121                	addi	sp,sp,64
 adc:	8082                	ret
  neg = 0;
 ade:	4301                	li	t1,0
 ae0:	bf9d                	j	a56 <printint+0x1c>

0000000000000ae2 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 ae2:	715d                	addi	sp,sp,-80
 ae4:	e486                	sd	ra,72(sp)
 ae6:	e0a2                	sd	s0,64(sp)
 ae8:	f84a                	sd	s2,48(sp)
 aea:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 aec:	0005c903          	lbu	s2,0(a1)
 af0:	1a090b63          	beqz	s2,ca6 <vprintf+0x1c4>
 af4:	fc26                	sd	s1,56(sp)
 af6:	f44e                	sd	s3,40(sp)
 af8:	f052                	sd	s4,32(sp)
 afa:	ec56                	sd	s5,24(sp)
 afc:	e85a                	sd	s6,16(sp)
 afe:	e45e                	sd	s7,8(sp)
 b00:	8aaa                	mv	s5,a0
 b02:	8bb2                	mv	s7,a2
 b04:	00158493          	addi	s1,a1,1
  state = 0;
 b08:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 b0a:	02500a13          	li	s4,37
 b0e:	4b55                	li	s6,21
 b10:	a839                	j	b2e <vprintf+0x4c>
        putc(fd, c);
 b12:	85ca                	mv	a1,s2
 b14:	8556                	mv	a0,s5
 b16:	00000097          	auipc	ra,0x0
 b1a:	f02080e7          	jalr	-254(ra) # a18 <putc>
 b1e:	a019                	j	b24 <vprintf+0x42>
    } else if(state == '%'){
 b20:	01498d63          	beq	s3,s4,b3a <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
 b24:	0485                	addi	s1,s1,1
 b26:	fff4c903          	lbu	s2,-1(s1)
 b2a:	16090863          	beqz	s2,c9a <vprintf+0x1b8>
    if(state == 0){
 b2e:	fe0999e3          	bnez	s3,b20 <vprintf+0x3e>
      if(c == '%'){
 b32:	ff4910e3          	bne	s2,s4,b12 <vprintf+0x30>
        state = '%';
 b36:	89d2                	mv	s3,s4
 b38:	b7f5                	j	b24 <vprintf+0x42>
      if(c == 'd'){
 b3a:	13490563          	beq	s2,s4,c64 <vprintf+0x182>
 b3e:	f9d9079b          	addiw	a5,s2,-99
 b42:	0ff7f793          	zext.b	a5,a5
 b46:	12fb6863          	bltu	s6,a5,c76 <vprintf+0x194>
 b4a:	f9d9079b          	addiw	a5,s2,-99
 b4e:	0ff7f713          	zext.b	a4,a5
 b52:	12eb6263          	bltu	s6,a4,c76 <vprintf+0x194>
 b56:	00271793          	slli	a5,a4,0x2
 b5a:	00000717          	auipc	a4,0x0
 b5e:	37670713          	addi	a4,a4,886 # ed0 <malloc+0x136>
 b62:	97ba                	add	a5,a5,a4
 b64:	439c                	lw	a5,0(a5)
 b66:	97ba                	add	a5,a5,a4
 b68:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 b6a:	008b8913          	addi	s2,s7,8
 b6e:	4685                	li	a3,1
 b70:	4629                	li	a2,10
 b72:	000ba583          	lw	a1,0(s7)
 b76:	8556                	mv	a0,s5
 b78:	00000097          	auipc	ra,0x0
 b7c:	ec2080e7          	jalr	-318(ra) # a3a <printint>
 b80:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 b82:	4981                	li	s3,0
 b84:	b745                	j	b24 <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
 b86:	008b8913          	addi	s2,s7,8
 b8a:	4681                	li	a3,0
 b8c:	4629                	li	a2,10
 b8e:	000ba583          	lw	a1,0(s7)
 b92:	8556                	mv	a0,s5
 b94:	00000097          	auipc	ra,0x0
 b98:	ea6080e7          	jalr	-346(ra) # a3a <printint>
 b9c:	8bca                	mv	s7,s2
      state = 0;
 b9e:	4981                	li	s3,0
 ba0:	b751                	j	b24 <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
 ba2:	008b8913          	addi	s2,s7,8
 ba6:	4681                	li	a3,0
 ba8:	4641                	li	a2,16
 baa:	000ba583          	lw	a1,0(s7)
 bae:	8556                	mv	a0,s5
 bb0:	00000097          	auipc	ra,0x0
 bb4:	e8a080e7          	jalr	-374(ra) # a3a <printint>
 bb8:	8bca                	mv	s7,s2
      state = 0;
 bba:	4981                	li	s3,0
 bbc:	b7a5                	j	b24 <vprintf+0x42>
 bbe:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
 bc0:	008b8793          	addi	a5,s7,8
 bc4:	8c3e                	mv	s8,a5
 bc6:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 bca:	03000593          	li	a1,48
 bce:	8556                	mv	a0,s5
 bd0:	00000097          	auipc	ra,0x0
 bd4:	e48080e7          	jalr	-440(ra) # a18 <putc>
  putc(fd, 'x');
 bd8:	07800593          	li	a1,120
 bdc:	8556                	mv	a0,s5
 bde:	00000097          	auipc	ra,0x0
 be2:	e3a080e7          	jalr	-454(ra) # a18 <putc>
 be6:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 be8:	00000b97          	auipc	s7,0x0
 bec:	340b8b93          	addi	s7,s7,832 # f28 <digits>
 bf0:	03c9d793          	srli	a5,s3,0x3c
 bf4:	97de                	add	a5,a5,s7
 bf6:	0007c583          	lbu	a1,0(a5)
 bfa:	8556                	mv	a0,s5
 bfc:	00000097          	auipc	ra,0x0
 c00:	e1c080e7          	jalr	-484(ra) # a18 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 c04:	0992                	slli	s3,s3,0x4
 c06:	397d                	addiw	s2,s2,-1
 c08:	fe0914e3          	bnez	s2,bf0 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
 c0c:	8be2                	mv	s7,s8
      state = 0;
 c0e:	4981                	li	s3,0
 c10:	6c02                	ld	s8,0(sp)
 c12:	bf09                	j	b24 <vprintf+0x42>
        s = va_arg(ap, char*);
 c14:	008b8993          	addi	s3,s7,8
 c18:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 c1c:	02090163          	beqz	s2,c3e <vprintf+0x15c>
        while(*s != 0){
 c20:	00094583          	lbu	a1,0(s2)
 c24:	c9a5                	beqz	a1,c94 <vprintf+0x1b2>
          putc(fd, *s);
 c26:	8556                	mv	a0,s5
 c28:	00000097          	auipc	ra,0x0
 c2c:	df0080e7          	jalr	-528(ra) # a18 <putc>
          s++;
 c30:	0905                	addi	s2,s2,1
        while(*s != 0){
 c32:	00094583          	lbu	a1,0(s2)
 c36:	f9e5                	bnez	a1,c26 <vprintf+0x144>
        s = va_arg(ap, char*);
 c38:	8bce                	mv	s7,s3
      state = 0;
 c3a:	4981                	li	s3,0
 c3c:	b5e5                	j	b24 <vprintf+0x42>
          s = "(null)";
 c3e:	00000917          	auipc	s2,0x0
 c42:	28a90913          	addi	s2,s2,650 # ec8 <malloc+0x12e>
        while(*s != 0){
 c46:	02800593          	li	a1,40
 c4a:	bff1                	j	c26 <vprintf+0x144>
        putc(fd, va_arg(ap, uint));
 c4c:	008b8913          	addi	s2,s7,8
 c50:	000bc583          	lbu	a1,0(s7)
 c54:	8556                	mv	a0,s5
 c56:	00000097          	auipc	ra,0x0
 c5a:	dc2080e7          	jalr	-574(ra) # a18 <putc>
 c5e:	8bca                	mv	s7,s2
      state = 0;
 c60:	4981                	li	s3,0
 c62:	b5c9                	j	b24 <vprintf+0x42>
        putc(fd, c);
 c64:	02500593          	li	a1,37
 c68:	8556                	mv	a0,s5
 c6a:	00000097          	auipc	ra,0x0
 c6e:	dae080e7          	jalr	-594(ra) # a18 <putc>
      state = 0;
 c72:	4981                	li	s3,0
 c74:	bd45                	j	b24 <vprintf+0x42>
        putc(fd, '%');
 c76:	02500593          	li	a1,37
 c7a:	8556                	mv	a0,s5
 c7c:	00000097          	auipc	ra,0x0
 c80:	d9c080e7          	jalr	-612(ra) # a18 <putc>
        putc(fd, c);
 c84:	85ca                	mv	a1,s2
 c86:	8556                	mv	a0,s5
 c88:	00000097          	auipc	ra,0x0
 c8c:	d90080e7          	jalr	-624(ra) # a18 <putc>
      state = 0;
 c90:	4981                	li	s3,0
 c92:	bd49                	j	b24 <vprintf+0x42>
        s = va_arg(ap, char*);
 c94:	8bce                	mv	s7,s3
      state = 0;
 c96:	4981                	li	s3,0
 c98:	b571                	j	b24 <vprintf+0x42>
 c9a:	74e2                	ld	s1,56(sp)
 c9c:	79a2                	ld	s3,40(sp)
 c9e:	7a02                	ld	s4,32(sp)
 ca0:	6ae2                	ld	s5,24(sp)
 ca2:	6b42                	ld	s6,16(sp)
 ca4:	6ba2                	ld	s7,8(sp)
    }
  }
}
 ca6:	60a6                	ld	ra,72(sp)
 ca8:	6406                	ld	s0,64(sp)
 caa:	7942                	ld	s2,48(sp)
 cac:	6161                	addi	sp,sp,80
 cae:	8082                	ret

0000000000000cb0 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 cb0:	715d                	addi	sp,sp,-80
 cb2:	ec06                	sd	ra,24(sp)
 cb4:	e822                	sd	s0,16(sp)
 cb6:	1000                	addi	s0,sp,32
 cb8:	e010                	sd	a2,0(s0)
 cba:	e414                	sd	a3,8(s0)
 cbc:	e818                	sd	a4,16(s0)
 cbe:	ec1c                	sd	a5,24(s0)
 cc0:	03043023          	sd	a6,32(s0)
 cc4:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 cc8:	8622                	mv	a2,s0
 cca:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 cce:	00000097          	auipc	ra,0x0
 cd2:	e14080e7          	jalr	-492(ra) # ae2 <vprintf>
}
 cd6:	60e2                	ld	ra,24(sp)
 cd8:	6442                	ld	s0,16(sp)
 cda:	6161                	addi	sp,sp,80
 cdc:	8082                	ret

0000000000000cde <printf>:

void
printf(const char *fmt, ...)
{
 cde:	711d                	addi	sp,sp,-96
 ce0:	ec06                	sd	ra,24(sp)
 ce2:	e822                	sd	s0,16(sp)
 ce4:	1000                	addi	s0,sp,32
 ce6:	e40c                	sd	a1,8(s0)
 ce8:	e810                	sd	a2,16(s0)
 cea:	ec14                	sd	a3,24(s0)
 cec:	f018                	sd	a4,32(s0)
 cee:	f41c                	sd	a5,40(s0)
 cf0:	03043823          	sd	a6,48(s0)
 cf4:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 cf8:	00840613          	addi	a2,s0,8
 cfc:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 d00:	85aa                	mv	a1,a0
 d02:	4505                	li	a0,1
 d04:	00000097          	auipc	ra,0x0
 d08:	dde080e7          	jalr	-546(ra) # ae2 <vprintf>
}
 d0c:	60e2                	ld	ra,24(sp)
 d0e:	6442                	ld	s0,16(sp)
 d10:	6125                	addi	sp,sp,96
 d12:	8082                	ret

0000000000000d14 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 d14:	1141                	addi	sp,sp,-16
 d16:	e406                	sd	ra,8(sp)
 d18:	e022                	sd	s0,0(sp)
 d1a:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 d1c:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 d20:	00000797          	auipc	a5,0x0
 d24:	2307b783          	ld	a5,560(a5) # f50 <freep>
 d28:	a039                	j	d36 <free+0x22>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 d2a:	6398                	ld	a4,0(a5)
 d2c:	00e7e463          	bltu	a5,a4,d34 <free+0x20>
 d30:	00e6ea63          	bltu	a3,a4,d44 <free+0x30>
{
 d34:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 d36:	fed7fae3          	bgeu	a5,a3,d2a <free+0x16>
 d3a:	6398                	ld	a4,0(a5)
 d3c:	00e6e463          	bltu	a3,a4,d44 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 d40:	fee7eae3          	bltu	a5,a4,d34 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 d44:	ff852583          	lw	a1,-8(a0)
 d48:	6390                	ld	a2,0(a5)
 d4a:	02059813          	slli	a6,a1,0x20
 d4e:	01c85713          	srli	a4,a6,0x1c
 d52:	9736                	add	a4,a4,a3
 d54:	02e60563          	beq	a2,a4,d7e <free+0x6a>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 d58:	fec53823          	sd	a2,-16(a0)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 d5c:	4790                	lw	a2,8(a5)
 d5e:	02061593          	slli	a1,a2,0x20
 d62:	01c5d713          	srli	a4,a1,0x1c
 d66:	973e                	add	a4,a4,a5
 d68:	02e68263          	beq	a3,a4,d8c <free+0x78>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 d6c:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 d6e:	00000717          	auipc	a4,0x0
 d72:	1ef73123          	sd	a5,482(a4) # f50 <freep>
}
 d76:	60a2                	ld	ra,8(sp)
 d78:	6402                	ld	s0,0(sp)
 d7a:	0141                	addi	sp,sp,16
 d7c:	8082                	ret
    bp->s.size += p->s.ptr->s.size;
 d7e:	4618                	lw	a4,8(a2)
 d80:	9f2d                	addw	a4,a4,a1
 d82:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 d86:	6398                	ld	a4,0(a5)
 d88:	6310                	ld	a2,0(a4)
 d8a:	b7f9                	j	d58 <free+0x44>
    p->s.size += bp->s.size;
 d8c:	ff852703          	lw	a4,-8(a0)
 d90:	9f31                	addw	a4,a4,a2
 d92:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 d94:	ff053683          	ld	a3,-16(a0)
 d98:	bfd1                	j	d6c <free+0x58>

0000000000000d9a <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 d9a:	7139                	addi	sp,sp,-64
 d9c:	fc06                	sd	ra,56(sp)
 d9e:	f822                	sd	s0,48(sp)
 da0:	f04a                	sd	s2,32(sp)
 da2:	ec4e                	sd	s3,24(sp)
 da4:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 da6:	02051993          	slli	s3,a0,0x20
 daa:	0209d993          	srli	s3,s3,0x20
 dae:	09bd                	addi	s3,s3,15
 db0:	0049d993          	srli	s3,s3,0x4
 db4:	2985                	addiw	s3,s3,1
 db6:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 db8:	00000517          	auipc	a0,0x0
 dbc:	19853503          	ld	a0,408(a0) # f50 <freep>
 dc0:	c905                	beqz	a0,df0 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 dc2:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 dc4:	4798                	lw	a4,8(a5)
 dc6:	09377a63          	bgeu	a4,s3,e5a <malloc+0xc0>
 dca:	f426                	sd	s1,40(sp)
 dcc:	e852                	sd	s4,16(sp)
 dce:	e456                	sd	s5,8(sp)
 dd0:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 dd2:	8a4e                	mv	s4,s3
 dd4:	6705                	lui	a4,0x1
 dd6:	00e9f363          	bgeu	s3,a4,ddc <malloc+0x42>
 dda:	6a05                	lui	s4,0x1
 ddc:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 de0:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 de4:	00000497          	auipc	s1,0x0
 de8:	16c48493          	addi	s1,s1,364 # f50 <freep>
  if(p == (char*)-1)
 dec:	5afd                	li	s5,-1
 dee:	a089                	j	e30 <malloc+0x96>
 df0:	f426                	sd	s1,40(sp)
 df2:	e852                	sd	s4,16(sp)
 df4:	e456                	sd	s5,8(sp)
 df6:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 df8:	00003797          	auipc	a5,0x3
 dfc:	e1878793          	addi	a5,a5,-488 # 3c10 <base>
 e00:	00000717          	auipc	a4,0x0
 e04:	14f73823          	sd	a5,336(a4) # f50 <freep>
 e08:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 e0a:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 e0e:	b7d1                	j	dd2 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 e10:	6398                	ld	a4,0(a5)
 e12:	e118                	sd	a4,0(a0)
 e14:	a8b9                	j	e72 <malloc+0xd8>
  hp->s.size = nu;
 e16:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 e1a:	0541                	addi	a0,a0,16
 e1c:	00000097          	auipc	ra,0x0
 e20:	ef8080e7          	jalr	-264(ra) # d14 <free>
  return freep;
 e24:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 e26:	c135                	beqz	a0,e8a <malloc+0xf0>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 e28:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 e2a:	4798                	lw	a4,8(a5)
 e2c:	03277363          	bgeu	a4,s2,e52 <malloc+0xb8>
    if(p == freep)
 e30:	6098                	ld	a4,0(s1)
 e32:	853e                	mv	a0,a5
 e34:	fef71ae3          	bne	a4,a5,e28 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 e38:	8552                	mv	a0,s4
 e3a:	00000097          	auipc	ra,0x0
 e3e:	bbe080e7          	jalr	-1090(ra) # 9f8 <sbrk>
  if(p == (char*)-1)
 e42:	fd551ae3          	bne	a0,s5,e16 <malloc+0x7c>
        return 0;
 e46:	4501                	li	a0,0
 e48:	74a2                	ld	s1,40(sp)
 e4a:	6a42                	ld	s4,16(sp)
 e4c:	6aa2                	ld	s5,8(sp)
 e4e:	6b02                	ld	s6,0(sp)
 e50:	a03d                	j	e7e <malloc+0xe4>
 e52:	74a2                	ld	s1,40(sp)
 e54:	6a42                	ld	s4,16(sp)
 e56:	6aa2                	ld	s5,8(sp)
 e58:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 e5a:	fae90be3          	beq	s2,a4,e10 <malloc+0x76>
        p->s.size -= nunits;
 e5e:	4137073b          	subw	a4,a4,s3
 e62:	c798                	sw	a4,8(a5)
        p += p->s.size;
 e64:	02071693          	slli	a3,a4,0x20
 e68:	01c6d713          	srli	a4,a3,0x1c
 e6c:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 e6e:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 e72:	00000717          	auipc	a4,0x0
 e76:	0ca73f23          	sd	a0,222(a4) # f50 <freep>
      return (void*)(p + 1);
 e7a:	01078513          	addi	a0,a5,16
  }
}
 e7e:	70e2                	ld	ra,56(sp)
 e80:	7442                	ld	s0,48(sp)
 e82:	7902                	ld	s2,32(sp)
 e84:	69e2                	ld	s3,24(sp)
 e86:	6121                	addi	sp,sp,64
 e88:	8082                	ret
 e8a:	74a2                	ld	s1,40(sp)
 e8c:	6a42                	ld	s4,16(sp)
 e8e:	6aa2                	ld	s5,8(sp)
 e90:	6b02                	ld	s6,0(sp)
 e92:	b7f5                	j	e7e <malloc+0xe4>
