
user/_xargs：     文件格式 elf64-littleriscv


Disassembly of section .text:

0000000000000000 <printargs>:
void printargs(char* args[MAXARG][CMDSTYLE], int args_num);

/* 打印参数 */
void 
printargs(char* args[MAXARG][CMDSTYLE], int args_num){
    for (int i = 0; i < args_num; i++)
   0:	06b05f63          	blez	a1,7e <printargs+0x7e>
printargs(char* args[MAXARG][CMDSTYLE], int args_num){
   4:	715d                	addi	sp,sp,-80
   6:	e486                	sd	ra,72(sp)
   8:	e0a2                	sd	s0,64(sp)
   a:	fc26                	sd	s1,56(sp)
   c:	f84a                	sd	s2,48(sp)
   e:	f44e                	sd	s3,40(sp)
  10:	f052                	sd	s4,32(sp)
  12:	ec56                	sd	s5,24(sp)
  14:	e85a                	sd	s6,16(sp)
  16:	e45e                	sd	s7,8(sp)
  18:	0880                	addi	s0,sp,80
  1a:	8aae                	mv	s5,a1
  1c:	84aa                	mv	s1,a0
    for (int i = 0; i < args_num; i++)
  1e:	4901                	li	s2,0
    {
        /* code */
        printf("--------------args %d:--------------\n", i + 1);
  20:	00001b97          	auipc	s7,0x1
  24:	a18b8b93          	addi	s7,s7,-1512 # a38 <malloc+0x100>
        printf("cmd: %s, arg: %s, argslen: %d \n", args[i][0], args[i][1], strlen(args[i][1]));
  28:	00001b17          	auipc	s6,0x1
  2c:	a38b0b13          	addi	s6,s6,-1480 # a60 <malloc+0x128>
        printf("--------------args %d:--------------\n", i + 1);
  30:	0019059b          	addiw	a1,s2,1
  34:	892e                	mv	s2,a1
  36:	855e                	mv	a0,s7
  38:	00001097          	auipc	ra,0x1
  3c:	844080e7          	jalr	-1980(ra) # 87c <printf>
        printf("cmd: %s, arg: %s, argslen: %d \n", args[i][0], args[i][1], strlen(args[i][1]));
  40:	0004ba03          	ld	s4,0(s1)
  44:	0084b983          	ld	s3,8(s1)
  48:	854e                	mv	a0,s3
  4a:	00000097          	auipc	ra,0x0
  4e:	286080e7          	jalr	646(ra) # 2d0 <strlen>
  52:	86aa                	mv	a3,a0
  54:	864e                	mv	a2,s3
  56:	85d2                	mv	a1,s4
  58:	855a                	mv	a0,s6
  5a:	00001097          	auipc	ra,0x1
  5e:	822080e7          	jalr	-2014(ra) # 87c <printf>
    for (int i = 0; i < args_num; i++)
  62:	04c1                	addi	s1,s1,16
  64:	fd5916e3          	bne	s2,s5,30 <printargs+0x30>
    }
    
}
  68:	60a6                	ld	ra,72(sp)
  6a:	6406                	ld	s0,64(sp)
  6c:	74e2                	ld	s1,56(sp)
  6e:	7942                	ld	s2,48(sp)
  70:	79a2                	ld	s3,40(sp)
  72:	7a02                	ld	s4,32(sp)
  74:	6ae2                	ld	s5,24(sp)
  76:	6b42                	ld	s6,16(sp)
  78:	6ba2                	ld	s7,8(sp)
  7a:	6161                	addi	sp,sp,80
  7c:	8082                	ret
  7e:	8082                	ret

0000000000000080 <substring>:
/* 子串 */
// 替换s中从pos位置开始的len个字符到sub中，并在sub末尾添加'\0'
void 
substring(char s[], char *sub, int pos, int len) {
  80:	1141                	addi	sp,sp,-16
  82:	e406                	sd	ra,8(sp)
  84:	e022                	sd	s0,0(sp)
  86:	0800                	addi	s0,sp,16
   int c = 0;   
   while (c < len) {
  88:	02d05563          	blez	a3,b2 <substring+0x32>
  8c:	9532                	add	a0,a0,a2
  8e:	87ae                	mv	a5,a1
  90:	00b68633          	add	a2,a3,a1
      *(sub + c) = s[pos+c];
  94:	00054703          	lbu	a4,0(a0)
  98:	00e78023          	sb	a4,0(a5)
   while (c < len) {
  9c:	0505                	addi	a0,a0,1
  9e:	0785                	addi	a5,a5,1
  a0:	fec79ae3          	bne	a5,a2,94 <substring+0x14>
      c++;
   }
   *(sub + c) = '\0';
  a4:	95b6                	add	a1,a1,a3
  a6:	00058023          	sb	zero,0(a1)
}
  aa:	60a2                	ld	ra,8(sp)
  ac:	6402                	ld	s0,0(sp)
  ae:	0141                	addi	sp,sp,16
  b0:	8082                	ret
   int c = 0;   
  b2:	4681                	li	a3,0
  b4:	bfc5                	j	a4 <substring+0x24>

00000000000000b6 <cutoffinput>:

/* 截断 '\n' */
char* 
cutoffinput(char *buf){
  b6:	1101                	addi	sp,sp,-32
  b8:	ec06                	sd	ra,24(sp)
  ba:	e822                	sd	s0,16(sp)
  bc:	e426                	sd	s1,8(sp)
  be:	e04a                	sd	s2,0(sp)
  c0:	1000                	addi	s0,sp,32
  c2:	84aa                	mv	s1,a0
    /* 记得要为char *新分配一片地址空间，否则编译器默认指向同一片地址 */
    // 有换行符则截断
    if(strlen(buf) > 1 && buf[strlen(buf) - 1] == '\n'){
  c4:	00000097          	auipc	ra,0x0
  c8:	20c080e7          	jalr	524(ra) # 2d0 <strlen>
  cc:	4785                	li	a5,1
  ce:	02a7f063          	bgeu	a5,a0,ee <cutoffinput+0x38>
  d2:	8526                	mv	a0,s1
  d4:	00000097          	auipc	ra,0x0
  d8:	1fc080e7          	jalr	508(ra) # 2d0 <strlen>
  dc:	357d                	addiw	a0,a0,-1
  de:	1502                	slli	a0,a0,0x20
  e0:	9101                	srli	a0,a0,0x20
  e2:	9526                	add	a0,a0,s1
  e4:	00054703          	lbu	a4,0(a0)
  e8:	47a9                	li	a5,10
  ea:	02f70863          	beq	a4,a5,11a <cutoffinput+0x64>
        return subbuff;
    }
    // 没有换行符则直接复制整个buf
    else
    {
        char *subbuff = (char*)malloc(sizeof(char) * strlen(buf));
  ee:	8526                	mv	a0,s1
  f0:	00000097          	auipc	ra,0x0
  f4:	1e0080e7          	jalr	480(ra) # 2d0 <strlen>
  f8:	00001097          	auipc	ra,0x1
  fc:	840080e7          	jalr	-1984(ra) # 938 <malloc>
 100:	892a                	mv	s2,a0
        strcpy(subbuff, buf);
 102:	85a6                	mv	a1,s1
 104:	00000097          	auipc	ra,0x0
 108:	17c080e7          	jalr	380(ra) # 280 <strcpy>
        return subbuff;
    }
}
 10c:	854a                	mv	a0,s2
 10e:	60e2                	ld	ra,24(sp)
 110:	6442                	ld	s0,16(sp)
 112:	64a2                	ld	s1,8(sp)
 114:	6902                	ld	s2,0(sp)
 116:	6105                	addi	sp,sp,32
 118:	8082                	ret
        char *subbuff = (char*)malloc(sizeof(char) * (strlen(buf) - 1));
 11a:	8526                	mv	a0,s1
 11c:	00000097          	auipc	ra,0x0
 120:	1b4080e7          	jalr	436(ra) # 2d0 <strlen>
 124:	357d                	addiw	a0,a0,-1
 126:	00001097          	auipc	ra,0x1
 12a:	812080e7          	jalr	-2030(ra) # 938 <malloc>
 12e:	892a                	mv	s2,a0
        substring(buf, subbuff, 0, strlen(buf) - 1);
 130:	8526                	mv	a0,s1
 132:	00000097          	auipc	ra,0x0
 136:	19e080e7          	jalr	414(ra) # 2d0 <strlen>
 13a:	fff5069b          	addiw	a3,a0,-1
 13e:	4601                	li	a2,0
 140:	85ca                	mv	a1,s2
 142:	8526                	mv	a0,s1
 144:	00000097          	auipc	ra,0x0
 148:	f3c080e7          	jalr	-196(ra) # 80 <substring>
        return subbuff;
 14c:	b7c1                	j	10c <cutoffinput+0x56>

000000000000014e <main>:

int 
main(int argc, char *argv[])
{
 14e:	d2010113          	addi	sp,sp,-736
 152:	2c113c23          	sd	ra,728(sp)
 156:	2c813823          	sd	s0,720(sp)
 15a:	2c913423          	sd	s1,712(sp)
 15e:	2d213023          	sd	s2,704(sp)
 162:	2b313c23          	sd	s3,696(sp)
 166:	2b413823          	sd	s4,688(sp)
 16a:	2b513423          	sd	s5,680(sp)
 16e:	2b613023          	sd	s6,672(sp)
 172:	29713c23          	sd	s7,664(sp)
 176:	29813823          	sd	s8,656(sp)
 17a:	29913423          	sd	s9,648(sp)
 17e:	29a13023          	sd	s10,640(sp)
 182:	1580                	addi	s0,sp,736
 184:	8baa                	mv	s7,a0
 186:	8cae                	mv	s9,a1
    int pid;
    char buf[MAXPATH];
    char *args[MAXARG];
    char *cmd;
    /* 默认命令为echo */
    if(argc == 1){
 188:	4785                	li	a5,1
        cmd = "echo";
 18a:	00001d17          	auipc	s10,0x1
 18e:	8f6d0d13          	addi	s10,s10,-1802 # a80 <malloc+0x148>
    if(argc == 1){
 192:	00f50463          	beq	a0,a5,19a <main+0x4c>
    }
    else{
        cmd = argv[1];
 196:	0085bd03          	ld	s10,8(a1)
    }
    /* 计数器 */
    int args_num = 0;
 19a:	e2040a13          	addi	s4,s0,-480
        cmd = "echo";
 19e:	8ad2                	mv	s5,s4
    int args_num = 0;
 1a0:	4901                	li	s2,0

    // 读取标准输入的参数，存入args数组
    while (1)
    {
        memset(buf, 0, sizeof(buf));
 1a2:	f2040993          	addi	s3,s0,-224
 1a6:	08000b13          	li	s6,128

        // 截断输入，去掉buf末尾的换行符
        char *arg = cutoffinput(buf);
        /* printf("xargs:gets arg: %s, arglen: %d\n", arg, strlen(arg)); */
        /* press ctrl + D */
        if(strlen(arg) == 0 || args_num >= MAXARG){
 1aa:	4c7d                	li	s8,31
        memset(buf, 0, sizeof(buf));
 1ac:	865a                	mv	a2,s6
 1ae:	4581                	li	a1,0
 1b0:	854e                	mv	a0,s3
 1b2:	00000097          	auipc	ra,0x0
 1b6:	14a080e7          	jalr	330(ra) # 2fc <memset>
        gets(buf, MAXPATH);
 1ba:	85da                	mv	a1,s6
 1bc:	854e                	mv	a0,s3
 1be:	00000097          	auipc	ra,0x0
 1c2:	18c080e7          	jalr	396(ra) # 34a <gets>
        char *arg = cutoffinput(buf);
 1c6:	854e                	mv	a0,s3
 1c8:	00000097          	auipc	ra,0x0
 1cc:	eee080e7          	jalr	-274(ra) # b6 <cutoffinput>
 1d0:	84aa                	mv	s1,a0
        if(strlen(arg) == 0 || args_num >= MAXARG){
 1d2:	00000097          	auipc	ra,0x0
 1d6:	0fe080e7          	jalr	254(ra) # 2d0 <strlen>
 1da:	012c4863          	blt	s8,s2,1ea <main+0x9c>
 1de:	c511                	beqz	a0,1ea <main+0x9c>
            break;
        }
        args[args_num]= arg;
 1e0:	009ab023          	sd	s1,0(s5)
        args_num++;
 1e4:	2905                	addiw	s2,s2,1
    {
 1e6:	0aa1                	addi	s5,s5,8
 1e8:	b7d1                	j	1ac <main+0x5e>
     */
    /* 填充exec需要执行的命令至argv2exec */
    char *argv2exec[MAXARG];

    // 第一个参数必须为cmd
    argv2exec[0] = cmd;
 1ea:	d3a43023          	sd	s10,-736(s0)

    // 使用单独的目标索引 pos 来拼接参数，避免越界访问
    int pos = 1;
    // 先拷贝命令行中 argv[2..argc-1]（如果有）
    for (int k = 2; k < argc; k++) {
 1ee:	4789                	li	a5,2
 1f0:	0977d063          	bge	a5,s7,270 <main+0x122>
 1f4:	010c8793          	addi	a5,s9,16
 1f8:	d2840713          	addi	a4,s0,-728
 1fc:	ffdb861b          	addiw	a2,s7,-3
 200:	02061693          	slli	a3,a2,0x20
 204:	01d6d613          	srli	a2,a3,0x1d
 208:	0ce1                	addi	s9,s9,24
 20a:	9666                	add	a2,a2,s9
        argv2exec[pos++] = argv[k];
 20c:	6394                	ld	a3,0(a5)
 20e:	e314                	sd	a3,0(a4)
    for (int k = 2; k < argc; k++) {
 210:	07a1                	addi	a5,a5,8
 212:	0721                	addi	a4,a4,8
 214:	fec79ce3          	bne	a5,a2,20c <main+0xbe>
 218:	3bfd                	addiw	s7,s7,-1
    }
    // 再拷贝从标准输入读取的参数
    for (int i = 0; i < args_num; i++) {
 21a:	03205363          	blez	s2,240 <main+0xf2>
 21e:	003b9793          	slli	a5,s7,0x3
 222:	d2040713          	addi	a4,s0,-736
 226:	97ba                	add	a5,a5,a4
 228:	00391693          	slli	a3,s2,0x3
 22c:	96d2                	add	a3,a3,s4
        argv2exec[pos++] = args[i];
 22e:	000a3703          	ld	a4,0(s4)
 232:	e398                	sd	a4,0(a5)
    for (int i = 0; i < args_num; i++) {
 234:	0a21                	addi	s4,s4,8
 236:	07a1                	addi	a5,a5,8
 238:	feda1be3          	bne	s4,a3,22e <main+0xe0>
 23c:	01790bbb          	addw	s7,s2,s7
    }
    // 最后一个参数置为 NULL
    argv2exec[pos] = 0;
 240:	0b8e                	slli	s7,s7,0x3
 242:	fa0b8793          	addi	a5,s7,-96
 246:	00878bb3          	add	s7,a5,s0
 24a:	d80bb023          	sd	zero,-640(s7)
    
    /* 运行cmd */
    // 创建子进程执行cmd
    if((pid = fork()) == 0){   
 24e:	00000097          	auipc	ra,0x0
 252:	2b8080e7          	jalr	696(ra) # 506 <fork>
 256:	ed19                	bnez	a0,274 <main+0x126>
        exec(cmd, argv2exec);    
 258:	d2040593          	addi	a1,s0,-736
 25c:	856a                	mv	a0,s10
 25e:	00000097          	auipc	ra,0x0
 262:	2e8080e7          	jalr	744(ra) # 546 <exec>
    else
    {
        /* code */
        wait(0);
    }
    exit(0);
 266:	4501                	li	a0,0
 268:	00000097          	auipc	ra,0x0
 26c:	2a6080e7          	jalr	678(ra) # 50e <exit>
    int pos = 1;
 270:	4b85                	li	s7,1
 272:	b765                	j	21a <main+0xcc>
        wait(0);
 274:	4501                	li	a0,0
 276:	00000097          	auipc	ra,0x0
 27a:	2a0080e7          	jalr	672(ra) # 516 <wait>
 27e:	b7e5                	j	266 <main+0x118>

0000000000000280 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 280:	1141                	addi	sp,sp,-16
 282:	e406                	sd	ra,8(sp)
 284:	e022                	sd	s0,0(sp)
 286:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 288:	87aa                	mv	a5,a0
 28a:	0585                	addi	a1,a1,1
 28c:	0785                	addi	a5,a5,1
 28e:	fff5c703          	lbu	a4,-1(a1)
 292:	fee78fa3          	sb	a4,-1(a5)
 296:	fb75                	bnez	a4,28a <strcpy+0xa>
    ;
  return os;
}
 298:	60a2                	ld	ra,8(sp)
 29a:	6402                	ld	s0,0(sp)
 29c:	0141                	addi	sp,sp,16
 29e:	8082                	ret

00000000000002a0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 2a0:	1141                	addi	sp,sp,-16
 2a2:	e406                	sd	ra,8(sp)
 2a4:	e022                	sd	s0,0(sp)
 2a6:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 2a8:	00054783          	lbu	a5,0(a0)
 2ac:	cb91                	beqz	a5,2c0 <strcmp+0x20>
 2ae:	0005c703          	lbu	a4,0(a1)
 2b2:	00f71763          	bne	a4,a5,2c0 <strcmp+0x20>
    p++, q++;
 2b6:	0505                	addi	a0,a0,1
 2b8:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 2ba:	00054783          	lbu	a5,0(a0)
 2be:	fbe5                	bnez	a5,2ae <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 2c0:	0005c503          	lbu	a0,0(a1)
}
 2c4:	40a7853b          	subw	a0,a5,a0
 2c8:	60a2                	ld	ra,8(sp)
 2ca:	6402                	ld	s0,0(sp)
 2cc:	0141                	addi	sp,sp,16
 2ce:	8082                	ret

00000000000002d0 <strlen>:

uint
strlen(const char *s)
{
 2d0:	1141                	addi	sp,sp,-16
 2d2:	e406                	sd	ra,8(sp)
 2d4:	e022                	sd	s0,0(sp)
 2d6:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 2d8:	00054783          	lbu	a5,0(a0)
 2dc:	cf91                	beqz	a5,2f8 <strlen+0x28>
 2de:	00150793          	addi	a5,a0,1
 2e2:	86be                	mv	a3,a5
 2e4:	0785                	addi	a5,a5,1
 2e6:	fff7c703          	lbu	a4,-1(a5)
 2ea:	ff65                	bnez	a4,2e2 <strlen+0x12>
 2ec:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
 2f0:	60a2                	ld	ra,8(sp)
 2f2:	6402                	ld	s0,0(sp)
 2f4:	0141                	addi	sp,sp,16
 2f6:	8082                	ret
  for(n = 0; s[n]; n++)
 2f8:	4501                	li	a0,0
 2fa:	bfdd                	j	2f0 <strlen+0x20>

00000000000002fc <memset>:

void*
memset(void *dst, int c, uint n)
{
 2fc:	1141                	addi	sp,sp,-16
 2fe:	e406                	sd	ra,8(sp)
 300:	e022                	sd	s0,0(sp)
 302:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 304:	ca19                	beqz	a2,31a <memset+0x1e>
 306:	87aa                	mv	a5,a0
 308:	1602                	slli	a2,a2,0x20
 30a:	9201                	srli	a2,a2,0x20
 30c:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 310:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 314:	0785                	addi	a5,a5,1
 316:	fee79de3          	bne	a5,a4,310 <memset+0x14>
  }
  return dst;
}
 31a:	60a2                	ld	ra,8(sp)
 31c:	6402                	ld	s0,0(sp)
 31e:	0141                	addi	sp,sp,16
 320:	8082                	ret

0000000000000322 <strchr>:

char*
strchr(const char *s, char c)
{
 322:	1141                	addi	sp,sp,-16
 324:	e406                	sd	ra,8(sp)
 326:	e022                	sd	s0,0(sp)
 328:	0800                	addi	s0,sp,16
  for(; *s; s++)
 32a:	00054783          	lbu	a5,0(a0)
 32e:	cf81                	beqz	a5,346 <strchr+0x24>
    if(*s == c)
 330:	00f58763          	beq	a1,a5,33e <strchr+0x1c>
  for(; *s; s++)
 334:	0505                	addi	a0,a0,1
 336:	00054783          	lbu	a5,0(a0)
 33a:	fbfd                	bnez	a5,330 <strchr+0xe>
      return (char*)s;
  return 0;
 33c:	4501                	li	a0,0
}
 33e:	60a2                	ld	ra,8(sp)
 340:	6402                	ld	s0,0(sp)
 342:	0141                	addi	sp,sp,16
 344:	8082                	ret
  return 0;
 346:	4501                	li	a0,0
 348:	bfdd                	j	33e <strchr+0x1c>

000000000000034a <gets>:

char*
gets(char *buf, int max)
{
 34a:	711d                	addi	sp,sp,-96
 34c:	ec86                	sd	ra,88(sp)
 34e:	e8a2                	sd	s0,80(sp)
 350:	e4a6                	sd	s1,72(sp)
 352:	e0ca                	sd	s2,64(sp)
 354:	fc4e                	sd	s3,56(sp)
 356:	f852                	sd	s4,48(sp)
 358:	f456                	sd	s5,40(sp)
 35a:	f05a                	sd	s6,32(sp)
 35c:	ec5e                	sd	s7,24(sp)
 35e:	e862                	sd	s8,16(sp)
 360:	1080                	addi	s0,sp,96
 362:	8baa                	mv	s7,a0
 364:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 366:	892a                	mv	s2,a0
 368:	4481                	li	s1,0
    cc = read(0, &c, 1);
 36a:	faf40b13          	addi	s6,s0,-81
 36e:	4a85                	li	s5,1
  for(i=0; i+1 < max; ){
 370:	8c26                	mv	s8,s1
 372:	0014899b          	addiw	s3,s1,1
 376:	84ce                	mv	s1,s3
 378:	0349d663          	bge	s3,s4,3a4 <gets+0x5a>
    cc = read(0, &c, 1);
 37c:	8656                	mv	a2,s5
 37e:	85da                	mv	a1,s6
 380:	4501                	li	a0,0
 382:	00000097          	auipc	ra,0x0
 386:	1a4080e7          	jalr	420(ra) # 526 <read>
    if(cc < 1)
 38a:	00a05d63          	blez	a0,3a4 <gets+0x5a>
      break;
    buf[i++] = c;
 38e:	faf44783          	lbu	a5,-81(s0)
 392:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 396:	0905                	addi	s2,s2,1
 398:	ff678713          	addi	a4,a5,-10
 39c:	c319                	beqz	a4,3a2 <gets+0x58>
 39e:	17cd                	addi	a5,a5,-13
 3a0:	fbe1                	bnez	a5,370 <gets+0x26>
    buf[i++] = c;
 3a2:	8c4e                	mv	s8,s3
      break;
  }
  buf[i] = '\0';
 3a4:	9c5e                	add	s8,s8,s7
 3a6:	000c0023          	sb	zero,0(s8)
  return buf;
}
 3aa:	855e                	mv	a0,s7
 3ac:	60e6                	ld	ra,88(sp)
 3ae:	6446                	ld	s0,80(sp)
 3b0:	64a6                	ld	s1,72(sp)
 3b2:	6906                	ld	s2,64(sp)
 3b4:	79e2                	ld	s3,56(sp)
 3b6:	7a42                	ld	s4,48(sp)
 3b8:	7aa2                	ld	s5,40(sp)
 3ba:	7b02                	ld	s6,32(sp)
 3bc:	6be2                	ld	s7,24(sp)
 3be:	6c42                	ld	s8,16(sp)
 3c0:	6125                	addi	sp,sp,96
 3c2:	8082                	ret

00000000000003c4 <stat>:

int
stat(const char *n, struct stat *st)
{
 3c4:	1101                	addi	sp,sp,-32
 3c6:	ec06                	sd	ra,24(sp)
 3c8:	e822                	sd	s0,16(sp)
 3ca:	e04a                	sd	s2,0(sp)
 3cc:	1000                	addi	s0,sp,32
 3ce:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3d0:	4581                	li	a1,0
 3d2:	00000097          	auipc	ra,0x0
 3d6:	17c080e7          	jalr	380(ra) # 54e <open>
  if(fd < 0)
 3da:	02054663          	bltz	a0,406 <stat+0x42>
 3de:	e426                	sd	s1,8(sp)
 3e0:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 3e2:	85ca                	mv	a1,s2
 3e4:	00000097          	auipc	ra,0x0
 3e8:	182080e7          	jalr	386(ra) # 566 <fstat>
 3ec:	892a                	mv	s2,a0
  close(fd);
 3ee:	8526                	mv	a0,s1
 3f0:	00000097          	auipc	ra,0x0
 3f4:	146080e7          	jalr	326(ra) # 536 <close>
  return r;
 3f8:	64a2                	ld	s1,8(sp)
}
 3fa:	854a                	mv	a0,s2
 3fc:	60e2                	ld	ra,24(sp)
 3fe:	6442                	ld	s0,16(sp)
 400:	6902                	ld	s2,0(sp)
 402:	6105                	addi	sp,sp,32
 404:	8082                	ret
    return -1;
 406:	57fd                	li	a5,-1
 408:	893e                	mv	s2,a5
 40a:	bfc5                	j	3fa <stat+0x36>

000000000000040c <atoi>:

int
atoi(const char *s)
{
 40c:	1141                	addi	sp,sp,-16
 40e:	e406                	sd	ra,8(sp)
 410:	e022                	sd	s0,0(sp)
 412:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 414:	00054683          	lbu	a3,0(a0)
 418:	fd06879b          	addiw	a5,a3,-48
 41c:	0ff7f793          	zext.b	a5,a5
 420:	4625                	li	a2,9
 422:	02f66963          	bltu	a2,a5,454 <atoi+0x48>
 426:	872a                	mv	a4,a0
  n = 0;
 428:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 42a:	0705                	addi	a4,a4,1
 42c:	0025179b          	slliw	a5,a0,0x2
 430:	9fa9                	addw	a5,a5,a0
 432:	0017979b          	slliw	a5,a5,0x1
 436:	9fb5                	addw	a5,a5,a3
 438:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 43c:	00074683          	lbu	a3,0(a4)
 440:	fd06879b          	addiw	a5,a3,-48
 444:	0ff7f793          	zext.b	a5,a5
 448:	fef671e3          	bgeu	a2,a5,42a <atoi+0x1e>
  return n;
}
 44c:	60a2                	ld	ra,8(sp)
 44e:	6402                	ld	s0,0(sp)
 450:	0141                	addi	sp,sp,16
 452:	8082                	ret
  n = 0;
 454:	4501                	li	a0,0
 456:	bfdd                	j	44c <atoi+0x40>

0000000000000458 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 458:	1141                	addi	sp,sp,-16
 45a:	e406                	sd	ra,8(sp)
 45c:	e022                	sd	s0,0(sp)
 45e:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 460:	02b57563          	bgeu	a0,a1,48a <memmove+0x32>
    while(n-- > 0)
 464:	00c05f63          	blez	a2,482 <memmove+0x2a>
 468:	1602                	slli	a2,a2,0x20
 46a:	9201                	srli	a2,a2,0x20
 46c:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 470:	872a                	mv	a4,a0
      *dst++ = *src++;
 472:	0585                	addi	a1,a1,1
 474:	0705                	addi	a4,a4,1
 476:	fff5c683          	lbu	a3,-1(a1)
 47a:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 47e:	fee79ae3          	bne	a5,a4,472 <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 482:	60a2                	ld	ra,8(sp)
 484:	6402                	ld	s0,0(sp)
 486:	0141                	addi	sp,sp,16
 488:	8082                	ret
    while(n-- > 0)
 48a:	fec05ce3          	blez	a2,482 <memmove+0x2a>
    dst += n;
 48e:	00c50733          	add	a4,a0,a2
    src += n;
 492:	95b2                	add	a1,a1,a2
 494:	fff6079b          	addiw	a5,a2,-1
 498:	1782                	slli	a5,a5,0x20
 49a:	9381                	srli	a5,a5,0x20
 49c:	fff7c793          	not	a5,a5
 4a0:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 4a2:	15fd                	addi	a1,a1,-1
 4a4:	177d                	addi	a4,a4,-1
 4a6:	0005c683          	lbu	a3,0(a1)
 4aa:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 4ae:	fef71ae3          	bne	a4,a5,4a2 <memmove+0x4a>
 4b2:	bfc1                	j	482 <memmove+0x2a>

00000000000004b4 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 4b4:	1141                	addi	sp,sp,-16
 4b6:	e406                	sd	ra,8(sp)
 4b8:	e022                	sd	s0,0(sp)
 4ba:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 4bc:	c61d                	beqz	a2,4ea <memcmp+0x36>
 4be:	1602                	slli	a2,a2,0x20
 4c0:	9201                	srli	a2,a2,0x20
 4c2:	00c506b3          	add	a3,a0,a2
    if (*p1 != *p2) {
 4c6:	00054783          	lbu	a5,0(a0)
 4ca:	0005c703          	lbu	a4,0(a1)
 4ce:	00e79863          	bne	a5,a4,4de <memcmp+0x2a>
      return *p1 - *p2;
    }
    p1++;
 4d2:	0505                	addi	a0,a0,1
    p2++;
 4d4:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 4d6:	fed518e3          	bne	a0,a3,4c6 <memcmp+0x12>
  }
  return 0;
 4da:	4501                	li	a0,0
 4dc:	a019                	j	4e2 <memcmp+0x2e>
      return *p1 - *p2;
 4de:	40e7853b          	subw	a0,a5,a4
}
 4e2:	60a2                	ld	ra,8(sp)
 4e4:	6402                	ld	s0,0(sp)
 4e6:	0141                	addi	sp,sp,16
 4e8:	8082                	ret
  return 0;
 4ea:	4501                	li	a0,0
 4ec:	bfdd                	j	4e2 <memcmp+0x2e>

00000000000004ee <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 4ee:	1141                	addi	sp,sp,-16
 4f0:	e406                	sd	ra,8(sp)
 4f2:	e022                	sd	s0,0(sp)
 4f4:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 4f6:	00000097          	auipc	ra,0x0
 4fa:	f62080e7          	jalr	-158(ra) # 458 <memmove>
}
 4fe:	60a2                	ld	ra,8(sp)
 500:	6402                	ld	s0,0(sp)
 502:	0141                	addi	sp,sp,16
 504:	8082                	ret

0000000000000506 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 506:	4885                	li	a7,1
 ecall
 508:	00000073          	ecall
 ret
 50c:	8082                	ret

000000000000050e <exit>:
.global exit
exit:
 li a7, SYS_exit
 50e:	4889                	li	a7,2
 ecall
 510:	00000073          	ecall
 ret
 514:	8082                	ret

0000000000000516 <wait>:
.global wait
wait:
 li a7, SYS_wait
 516:	488d                	li	a7,3
 ecall
 518:	00000073          	ecall
 ret
 51c:	8082                	ret

000000000000051e <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 51e:	4891                	li	a7,4
 ecall
 520:	00000073          	ecall
 ret
 524:	8082                	ret

0000000000000526 <read>:
.global read
read:
 li a7, SYS_read
 526:	4895                	li	a7,5
 ecall
 528:	00000073          	ecall
 ret
 52c:	8082                	ret

000000000000052e <write>:
.global write
write:
 li a7, SYS_write
 52e:	48c1                	li	a7,16
 ecall
 530:	00000073          	ecall
 ret
 534:	8082                	ret

0000000000000536 <close>:
.global close
close:
 li a7, SYS_close
 536:	48d5                	li	a7,21
 ecall
 538:	00000073          	ecall
 ret
 53c:	8082                	ret

000000000000053e <kill>:
.global kill
kill:
 li a7, SYS_kill
 53e:	4899                	li	a7,6
 ecall
 540:	00000073          	ecall
 ret
 544:	8082                	ret

0000000000000546 <exec>:
.global exec
exec:
 li a7, SYS_exec
 546:	489d                	li	a7,7
 ecall
 548:	00000073          	ecall
 ret
 54c:	8082                	ret

000000000000054e <open>:
.global open
open:
 li a7, SYS_open
 54e:	48bd                	li	a7,15
 ecall
 550:	00000073          	ecall
 ret
 554:	8082                	ret

0000000000000556 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 556:	48c5                	li	a7,17
 ecall
 558:	00000073          	ecall
 ret
 55c:	8082                	ret

000000000000055e <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 55e:	48c9                	li	a7,18
 ecall
 560:	00000073          	ecall
 ret
 564:	8082                	ret

0000000000000566 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 566:	48a1                	li	a7,8
 ecall
 568:	00000073          	ecall
 ret
 56c:	8082                	ret

000000000000056e <link>:
.global link
link:
 li a7, SYS_link
 56e:	48cd                	li	a7,19
 ecall
 570:	00000073          	ecall
 ret
 574:	8082                	ret

0000000000000576 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 576:	48d1                	li	a7,20
 ecall
 578:	00000073          	ecall
 ret
 57c:	8082                	ret

000000000000057e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 57e:	48a5                	li	a7,9
 ecall
 580:	00000073          	ecall
 ret
 584:	8082                	ret

0000000000000586 <dup>:
.global dup
dup:
 li a7, SYS_dup
 586:	48a9                	li	a7,10
 ecall
 588:	00000073          	ecall
 ret
 58c:	8082                	ret

000000000000058e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 58e:	48ad                	li	a7,11
 ecall
 590:	00000073          	ecall
 ret
 594:	8082                	ret

0000000000000596 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 596:	48b1                	li	a7,12
 ecall
 598:	00000073          	ecall
 ret
 59c:	8082                	ret

000000000000059e <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 59e:	48b5                	li	a7,13
 ecall
 5a0:	00000073          	ecall
 ret
 5a4:	8082                	ret

00000000000005a6 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 5a6:	48b9                	li	a7,14
 ecall
 5a8:	00000073          	ecall
 ret
 5ac:	8082                	ret

00000000000005ae <ntas>:
.global ntas
ntas:
 li a7, SYS_ntas
 5ae:	48d9                	li	a7,22
 ecall
 5b0:	00000073          	ecall
 ret
 5b4:	8082                	ret

00000000000005b6 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 5b6:	1101                	addi	sp,sp,-32
 5b8:	ec06                	sd	ra,24(sp)
 5ba:	e822                	sd	s0,16(sp)
 5bc:	1000                	addi	s0,sp,32
 5be:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 5c2:	4605                	li	a2,1
 5c4:	fef40593          	addi	a1,s0,-17
 5c8:	00000097          	auipc	ra,0x0
 5cc:	f66080e7          	jalr	-154(ra) # 52e <write>
}
 5d0:	60e2                	ld	ra,24(sp)
 5d2:	6442                	ld	s0,16(sp)
 5d4:	6105                	addi	sp,sp,32
 5d6:	8082                	ret

00000000000005d8 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 5d8:	7139                	addi	sp,sp,-64
 5da:	fc06                	sd	ra,56(sp)
 5dc:	f822                	sd	s0,48(sp)
 5de:	f04a                	sd	s2,32(sp)
 5e0:	ec4e                	sd	s3,24(sp)
 5e2:	0080                	addi	s0,sp,64
 5e4:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 5e6:	cad9                	beqz	a3,67c <printint+0xa4>
 5e8:	01f5d79b          	srliw	a5,a1,0x1f
 5ec:	cbc1                	beqz	a5,67c <printint+0xa4>
    neg = 1;
    x = -xx;
 5ee:	40b005bb          	negw	a1,a1
    neg = 1;
 5f2:	4305                	li	t1,1
  } else {
    x = xx;
  }

  i = 0;
 5f4:	fc040993          	addi	s3,s0,-64
  neg = 0;
 5f8:	86ce                	mv	a3,s3
  i = 0;
 5fa:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 5fc:	00000817          	auipc	a6,0x0
 600:	4ec80813          	addi	a6,a6,1260 # ae8 <digits>
 604:	88ba                	mv	a7,a4
 606:	0017051b          	addiw	a0,a4,1
 60a:	872a                	mv	a4,a0
 60c:	02c5f7bb          	remuw	a5,a1,a2
 610:	1782                	slli	a5,a5,0x20
 612:	9381                	srli	a5,a5,0x20
 614:	97c2                	add	a5,a5,a6
 616:	0007c783          	lbu	a5,0(a5)
 61a:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 61e:	87ae                	mv	a5,a1
 620:	02c5d5bb          	divuw	a1,a1,a2
 624:	0685                	addi	a3,a3,1
 626:	fcc7ffe3          	bgeu	a5,a2,604 <printint+0x2c>
  if(neg)
 62a:	00030c63          	beqz	t1,642 <printint+0x6a>
    buf[i++] = '-';
 62e:	fd050793          	addi	a5,a0,-48
 632:	00878533          	add	a0,a5,s0
 636:	02d00793          	li	a5,45
 63a:	fef50823          	sb	a5,-16(a0)
 63e:	0028871b          	addiw	a4,a7,2

  while(--i >= 0)
 642:	02e05763          	blez	a4,670 <printint+0x98>
 646:	f426                	sd	s1,40(sp)
 648:	377d                	addiw	a4,a4,-1
 64a:	00e984b3          	add	s1,s3,a4
 64e:	19fd                	addi	s3,s3,-1
 650:	99ba                	add	s3,s3,a4
 652:	1702                	slli	a4,a4,0x20
 654:	9301                	srli	a4,a4,0x20
 656:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 65a:	0004c583          	lbu	a1,0(s1)
 65e:	854a                	mv	a0,s2
 660:	00000097          	auipc	ra,0x0
 664:	f56080e7          	jalr	-170(ra) # 5b6 <putc>
  while(--i >= 0)
 668:	14fd                	addi	s1,s1,-1
 66a:	ff3498e3          	bne	s1,s3,65a <printint+0x82>
 66e:	74a2                	ld	s1,40(sp)
}
 670:	70e2                	ld	ra,56(sp)
 672:	7442                	ld	s0,48(sp)
 674:	7902                	ld	s2,32(sp)
 676:	69e2                	ld	s3,24(sp)
 678:	6121                	addi	sp,sp,64
 67a:	8082                	ret
  neg = 0;
 67c:	4301                	li	t1,0
 67e:	bf9d                	j	5f4 <printint+0x1c>

0000000000000680 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 680:	715d                	addi	sp,sp,-80
 682:	e486                	sd	ra,72(sp)
 684:	e0a2                	sd	s0,64(sp)
 686:	f84a                	sd	s2,48(sp)
 688:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 68a:	0005c903          	lbu	s2,0(a1)
 68e:	1a090b63          	beqz	s2,844 <vprintf+0x1c4>
 692:	fc26                	sd	s1,56(sp)
 694:	f44e                	sd	s3,40(sp)
 696:	f052                	sd	s4,32(sp)
 698:	ec56                	sd	s5,24(sp)
 69a:	e85a                	sd	s6,16(sp)
 69c:	e45e                	sd	s7,8(sp)
 69e:	8aaa                	mv	s5,a0
 6a0:	8bb2                	mv	s7,a2
 6a2:	00158493          	addi	s1,a1,1
  state = 0;
 6a6:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 6a8:	02500a13          	li	s4,37
 6ac:	4b55                	li	s6,21
 6ae:	a839                	j	6cc <vprintf+0x4c>
        putc(fd, c);
 6b0:	85ca                	mv	a1,s2
 6b2:	8556                	mv	a0,s5
 6b4:	00000097          	auipc	ra,0x0
 6b8:	f02080e7          	jalr	-254(ra) # 5b6 <putc>
 6bc:	a019                	j	6c2 <vprintf+0x42>
    } else if(state == '%'){
 6be:	01498d63          	beq	s3,s4,6d8 <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
 6c2:	0485                	addi	s1,s1,1
 6c4:	fff4c903          	lbu	s2,-1(s1)
 6c8:	16090863          	beqz	s2,838 <vprintf+0x1b8>
    if(state == 0){
 6cc:	fe0999e3          	bnez	s3,6be <vprintf+0x3e>
      if(c == '%'){
 6d0:	ff4910e3          	bne	s2,s4,6b0 <vprintf+0x30>
        state = '%';
 6d4:	89d2                	mv	s3,s4
 6d6:	b7f5                	j	6c2 <vprintf+0x42>
      if(c == 'd'){
 6d8:	13490563          	beq	s2,s4,802 <vprintf+0x182>
 6dc:	f9d9079b          	addiw	a5,s2,-99
 6e0:	0ff7f793          	zext.b	a5,a5
 6e4:	12fb6863          	bltu	s6,a5,814 <vprintf+0x194>
 6e8:	f9d9079b          	addiw	a5,s2,-99
 6ec:	0ff7f713          	zext.b	a4,a5
 6f0:	12eb6263          	bltu	s6,a4,814 <vprintf+0x194>
 6f4:	00271793          	slli	a5,a4,0x2
 6f8:	00000717          	auipc	a4,0x0
 6fc:	39870713          	addi	a4,a4,920 # a90 <malloc+0x158>
 700:	97ba                	add	a5,a5,a4
 702:	439c                	lw	a5,0(a5)
 704:	97ba                	add	a5,a5,a4
 706:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 708:	008b8913          	addi	s2,s7,8
 70c:	4685                	li	a3,1
 70e:	4629                	li	a2,10
 710:	000ba583          	lw	a1,0(s7)
 714:	8556                	mv	a0,s5
 716:	00000097          	auipc	ra,0x0
 71a:	ec2080e7          	jalr	-318(ra) # 5d8 <printint>
 71e:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 720:	4981                	li	s3,0
 722:	b745                	j	6c2 <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
 724:	008b8913          	addi	s2,s7,8
 728:	4681                	li	a3,0
 72a:	4629                	li	a2,10
 72c:	000ba583          	lw	a1,0(s7)
 730:	8556                	mv	a0,s5
 732:	00000097          	auipc	ra,0x0
 736:	ea6080e7          	jalr	-346(ra) # 5d8 <printint>
 73a:	8bca                	mv	s7,s2
      state = 0;
 73c:	4981                	li	s3,0
 73e:	b751                	j	6c2 <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
 740:	008b8913          	addi	s2,s7,8
 744:	4681                	li	a3,0
 746:	4641                	li	a2,16
 748:	000ba583          	lw	a1,0(s7)
 74c:	8556                	mv	a0,s5
 74e:	00000097          	auipc	ra,0x0
 752:	e8a080e7          	jalr	-374(ra) # 5d8 <printint>
 756:	8bca                	mv	s7,s2
      state = 0;
 758:	4981                	li	s3,0
 75a:	b7a5                	j	6c2 <vprintf+0x42>
 75c:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
 75e:	008b8793          	addi	a5,s7,8
 762:	8c3e                	mv	s8,a5
 764:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 768:	03000593          	li	a1,48
 76c:	8556                	mv	a0,s5
 76e:	00000097          	auipc	ra,0x0
 772:	e48080e7          	jalr	-440(ra) # 5b6 <putc>
  putc(fd, 'x');
 776:	07800593          	li	a1,120
 77a:	8556                	mv	a0,s5
 77c:	00000097          	auipc	ra,0x0
 780:	e3a080e7          	jalr	-454(ra) # 5b6 <putc>
 784:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 786:	00000b97          	auipc	s7,0x0
 78a:	362b8b93          	addi	s7,s7,866 # ae8 <digits>
 78e:	03c9d793          	srli	a5,s3,0x3c
 792:	97de                	add	a5,a5,s7
 794:	0007c583          	lbu	a1,0(a5)
 798:	8556                	mv	a0,s5
 79a:	00000097          	auipc	ra,0x0
 79e:	e1c080e7          	jalr	-484(ra) # 5b6 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7a2:	0992                	slli	s3,s3,0x4
 7a4:	397d                	addiw	s2,s2,-1
 7a6:	fe0914e3          	bnez	s2,78e <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
 7aa:	8be2                	mv	s7,s8
      state = 0;
 7ac:	4981                	li	s3,0
 7ae:	6c02                	ld	s8,0(sp)
 7b0:	bf09                	j	6c2 <vprintf+0x42>
        s = va_arg(ap, char*);
 7b2:	008b8993          	addi	s3,s7,8
 7b6:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 7ba:	02090163          	beqz	s2,7dc <vprintf+0x15c>
        while(*s != 0){
 7be:	00094583          	lbu	a1,0(s2)
 7c2:	c9a5                	beqz	a1,832 <vprintf+0x1b2>
          putc(fd, *s);
 7c4:	8556                	mv	a0,s5
 7c6:	00000097          	auipc	ra,0x0
 7ca:	df0080e7          	jalr	-528(ra) # 5b6 <putc>
          s++;
 7ce:	0905                	addi	s2,s2,1
        while(*s != 0){
 7d0:	00094583          	lbu	a1,0(s2)
 7d4:	f9e5                	bnez	a1,7c4 <vprintf+0x144>
        s = va_arg(ap, char*);
 7d6:	8bce                	mv	s7,s3
      state = 0;
 7d8:	4981                	li	s3,0
 7da:	b5e5                	j	6c2 <vprintf+0x42>
          s = "(null)";
 7dc:	00000917          	auipc	s2,0x0
 7e0:	2ac90913          	addi	s2,s2,684 # a88 <malloc+0x150>
        while(*s != 0){
 7e4:	02800593          	li	a1,40
 7e8:	bff1                	j	7c4 <vprintf+0x144>
        putc(fd, va_arg(ap, uint));
 7ea:	008b8913          	addi	s2,s7,8
 7ee:	000bc583          	lbu	a1,0(s7)
 7f2:	8556                	mv	a0,s5
 7f4:	00000097          	auipc	ra,0x0
 7f8:	dc2080e7          	jalr	-574(ra) # 5b6 <putc>
 7fc:	8bca                	mv	s7,s2
      state = 0;
 7fe:	4981                	li	s3,0
 800:	b5c9                	j	6c2 <vprintf+0x42>
        putc(fd, c);
 802:	02500593          	li	a1,37
 806:	8556                	mv	a0,s5
 808:	00000097          	auipc	ra,0x0
 80c:	dae080e7          	jalr	-594(ra) # 5b6 <putc>
      state = 0;
 810:	4981                	li	s3,0
 812:	bd45                	j	6c2 <vprintf+0x42>
        putc(fd, '%');
 814:	02500593          	li	a1,37
 818:	8556                	mv	a0,s5
 81a:	00000097          	auipc	ra,0x0
 81e:	d9c080e7          	jalr	-612(ra) # 5b6 <putc>
        putc(fd, c);
 822:	85ca                	mv	a1,s2
 824:	8556                	mv	a0,s5
 826:	00000097          	auipc	ra,0x0
 82a:	d90080e7          	jalr	-624(ra) # 5b6 <putc>
      state = 0;
 82e:	4981                	li	s3,0
 830:	bd49                	j	6c2 <vprintf+0x42>
        s = va_arg(ap, char*);
 832:	8bce                	mv	s7,s3
      state = 0;
 834:	4981                	li	s3,0
 836:	b571                	j	6c2 <vprintf+0x42>
 838:	74e2                	ld	s1,56(sp)
 83a:	79a2                	ld	s3,40(sp)
 83c:	7a02                	ld	s4,32(sp)
 83e:	6ae2                	ld	s5,24(sp)
 840:	6b42                	ld	s6,16(sp)
 842:	6ba2                	ld	s7,8(sp)
    }
  }
}
 844:	60a6                	ld	ra,72(sp)
 846:	6406                	ld	s0,64(sp)
 848:	7942                	ld	s2,48(sp)
 84a:	6161                	addi	sp,sp,80
 84c:	8082                	ret

000000000000084e <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 84e:	715d                	addi	sp,sp,-80
 850:	ec06                	sd	ra,24(sp)
 852:	e822                	sd	s0,16(sp)
 854:	1000                	addi	s0,sp,32
 856:	e010                	sd	a2,0(s0)
 858:	e414                	sd	a3,8(s0)
 85a:	e818                	sd	a4,16(s0)
 85c:	ec1c                	sd	a5,24(s0)
 85e:	03043023          	sd	a6,32(s0)
 862:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 866:	8622                	mv	a2,s0
 868:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 86c:	00000097          	auipc	ra,0x0
 870:	e14080e7          	jalr	-492(ra) # 680 <vprintf>
}
 874:	60e2                	ld	ra,24(sp)
 876:	6442                	ld	s0,16(sp)
 878:	6161                	addi	sp,sp,80
 87a:	8082                	ret

000000000000087c <printf>:

void
printf(const char *fmt, ...)
{
 87c:	711d                	addi	sp,sp,-96
 87e:	ec06                	sd	ra,24(sp)
 880:	e822                	sd	s0,16(sp)
 882:	1000                	addi	s0,sp,32
 884:	e40c                	sd	a1,8(s0)
 886:	e810                	sd	a2,16(s0)
 888:	ec14                	sd	a3,24(s0)
 88a:	f018                	sd	a4,32(s0)
 88c:	f41c                	sd	a5,40(s0)
 88e:	03043823          	sd	a6,48(s0)
 892:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 896:	00840613          	addi	a2,s0,8
 89a:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 89e:	85aa                	mv	a1,a0
 8a0:	4505                	li	a0,1
 8a2:	00000097          	auipc	ra,0x0
 8a6:	dde080e7          	jalr	-546(ra) # 680 <vprintf>
}
 8aa:	60e2                	ld	ra,24(sp)
 8ac:	6442                	ld	s0,16(sp)
 8ae:	6125                	addi	sp,sp,96
 8b0:	8082                	ret

00000000000008b2 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8b2:	1141                	addi	sp,sp,-16
 8b4:	e406                	sd	ra,8(sp)
 8b6:	e022                	sd	s0,0(sp)
 8b8:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 8ba:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8be:	00000797          	auipc	a5,0x0
 8c2:	2427b783          	ld	a5,578(a5) # b00 <freep>
 8c6:	a039                	j	8d4 <free+0x22>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8c8:	6398                	ld	a4,0(a5)
 8ca:	00e7e463          	bltu	a5,a4,8d2 <free+0x20>
 8ce:	00e6ea63          	bltu	a3,a4,8e2 <free+0x30>
{
 8d2:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8d4:	fed7fae3          	bgeu	a5,a3,8c8 <free+0x16>
 8d8:	6398                	ld	a4,0(a5)
 8da:	00e6e463          	bltu	a3,a4,8e2 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8de:	fee7eae3          	bltu	a5,a4,8d2 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 8e2:	ff852583          	lw	a1,-8(a0)
 8e6:	6390                	ld	a2,0(a5)
 8e8:	02059813          	slli	a6,a1,0x20
 8ec:	01c85713          	srli	a4,a6,0x1c
 8f0:	9736                	add	a4,a4,a3
 8f2:	02e60563          	beq	a2,a4,91c <free+0x6a>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 8f6:	fec53823          	sd	a2,-16(a0)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 8fa:	4790                	lw	a2,8(a5)
 8fc:	02061593          	slli	a1,a2,0x20
 900:	01c5d713          	srli	a4,a1,0x1c
 904:	973e                	add	a4,a4,a5
 906:	02e68263          	beq	a3,a4,92a <free+0x78>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 90a:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 90c:	00000717          	auipc	a4,0x0
 910:	1ef73a23          	sd	a5,500(a4) # b00 <freep>
}
 914:	60a2                	ld	ra,8(sp)
 916:	6402                	ld	s0,0(sp)
 918:	0141                	addi	sp,sp,16
 91a:	8082                	ret
    bp->s.size += p->s.ptr->s.size;
 91c:	4618                	lw	a4,8(a2)
 91e:	9f2d                	addw	a4,a4,a1
 920:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 924:	6398                	ld	a4,0(a5)
 926:	6310                	ld	a2,0(a4)
 928:	b7f9                	j	8f6 <free+0x44>
    p->s.size += bp->s.size;
 92a:	ff852703          	lw	a4,-8(a0)
 92e:	9f31                	addw	a4,a4,a2
 930:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 932:	ff053683          	ld	a3,-16(a0)
 936:	bfd1                	j	90a <free+0x58>

0000000000000938 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 938:	7139                	addi	sp,sp,-64
 93a:	fc06                	sd	ra,56(sp)
 93c:	f822                	sd	s0,48(sp)
 93e:	f04a                	sd	s2,32(sp)
 940:	ec4e                	sd	s3,24(sp)
 942:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 944:	02051993          	slli	s3,a0,0x20
 948:	0209d993          	srli	s3,s3,0x20
 94c:	09bd                	addi	s3,s3,15
 94e:	0049d993          	srli	s3,s3,0x4
 952:	2985                	addiw	s3,s3,1
 954:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 956:	00000517          	auipc	a0,0x0
 95a:	1aa53503          	ld	a0,426(a0) # b00 <freep>
 95e:	c905                	beqz	a0,98e <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 960:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 962:	4798                	lw	a4,8(a5)
 964:	09377a63          	bgeu	a4,s3,9f8 <malloc+0xc0>
 968:	f426                	sd	s1,40(sp)
 96a:	e852                	sd	s4,16(sp)
 96c:	e456                	sd	s5,8(sp)
 96e:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 970:	8a4e                	mv	s4,s3
 972:	6705                	lui	a4,0x1
 974:	00e9f363          	bgeu	s3,a4,97a <malloc+0x42>
 978:	6a05                	lui	s4,0x1
 97a:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 97e:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 982:	00000497          	auipc	s1,0x0
 986:	17e48493          	addi	s1,s1,382 # b00 <freep>
  if(p == (char*)-1)
 98a:	5afd                	li	s5,-1
 98c:	a089                	j	9ce <malloc+0x96>
 98e:	f426                	sd	s1,40(sp)
 990:	e852                	sd	s4,16(sp)
 992:	e456                	sd	s5,8(sp)
 994:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 996:	00000797          	auipc	a5,0x0
 99a:	17278793          	addi	a5,a5,370 # b08 <base>
 99e:	00000717          	auipc	a4,0x0
 9a2:	16f73123          	sd	a5,354(a4) # b00 <freep>
 9a6:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 9a8:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 9ac:	b7d1                	j	970 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 9ae:	6398                	ld	a4,0(a5)
 9b0:	e118                	sd	a4,0(a0)
 9b2:	a8b9                	j	a10 <malloc+0xd8>
  hp->s.size = nu;
 9b4:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 9b8:	0541                	addi	a0,a0,16
 9ba:	00000097          	auipc	ra,0x0
 9be:	ef8080e7          	jalr	-264(ra) # 8b2 <free>
  return freep;
 9c2:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 9c4:	c135                	beqz	a0,a28 <malloc+0xf0>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9c6:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9c8:	4798                	lw	a4,8(a5)
 9ca:	03277363          	bgeu	a4,s2,9f0 <malloc+0xb8>
    if(p == freep)
 9ce:	6098                	ld	a4,0(s1)
 9d0:	853e                	mv	a0,a5
 9d2:	fef71ae3          	bne	a4,a5,9c6 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 9d6:	8552                	mv	a0,s4
 9d8:	00000097          	auipc	ra,0x0
 9dc:	bbe080e7          	jalr	-1090(ra) # 596 <sbrk>
  if(p == (char*)-1)
 9e0:	fd551ae3          	bne	a0,s5,9b4 <malloc+0x7c>
        return 0;
 9e4:	4501                	li	a0,0
 9e6:	74a2                	ld	s1,40(sp)
 9e8:	6a42                	ld	s4,16(sp)
 9ea:	6aa2                	ld	s5,8(sp)
 9ec:	6b02                	ld	s6,0(sp)
 9ee:	a03d                	j	a1c <malloc+0xe4>
 9f0:	74a2                	ld	s1,40(sp)
 9f2:	6a42                	ld	s4,16(sp)
 9f4:	6aa2                	ld	s5,8(sp)
 9f6:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 9f8:	fae90be3          	beq	s2,a4,9ae <malloc+0x76>
        p->s.size -= nunits;
 9fc:	4137073b          	subw	a4,a4,s3
 a00:	c798                	sw	a4,8(a5)
        p += p->s.size;
 a02:	02071693          	slli	a3,a4,0x20
 a06:	01c6d713          	srli	a4,a3,0x1c
 a0a:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 a0c:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 a10:	00000717          	auipc	a4,0x0
 a14:	0ea73823          	sd	a0,240(a4) # b00 <freep>
      return (void*)(p + 1);
 a18:	01078513          	addi	a0,a5,16
  }
}
 a1c:	70e2                	ld	ra,56(sp)
 a1e:	7442                	ld	s0,48(sp)
 a20:	7902                	ld	s2,32(sp)
 a22:	69e2                	ld	s3,24(sp)
 a24:	6121                	addi	sp,sp,64
 a26:	8082                	ret
 a28:	74a2                	ld	s1,40(sp)
 a2a:	6a42                	ld	s4,16(sp)
 a2c:	6aa2                	ld	s5,8(sp)
 a2e:	6b02                	ld	s6,0(sp)
 a30:	b7f5                	j	a1c <malloc+0xe4>
