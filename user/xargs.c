#include "kernel/types.h"
#include "kernel/stat.h"
#include "user.h"
#include "kernel/fs.h"
#include "kernel/param.h"

#define CMDSTYLE        2

char *cutoffinput(char *buf);
void substring(char s[], char sub[], int pos, int len);
void printargs(char* args[MAXARG][CMDSTYLE], int args_num);

/* 打印参数 */
void 
printargs(char* args[MAXARG][CMDSTYLE], int args_num){
    for (int i = 0; i < args_num; i++)
    {
        /* code */
        printf("--------------args %d:--------------\n", i + 1);
        printf("cmd: %s, arg: %s, argslen: %d \n", args[i][0], args[i][1], strlen(args[i][1]));
    }
    
}
/* 子串 */
// 替换s中从pos位置开始的len个字符到sub中，并在sub末尾添加'\0'
void 
substring(char s[], char *sub, int pos, int len) {
   int c = 0;   
   while (c < len) {
      *(sub + c) = s[pos+c];
      c++;
   }
   *(sub + c) = '\0';
}

/* 截断 '\n' */
char* 
cutoffinput(char *buf){
    /* 记得要为char *新分配一片地址空间，否则编译器默认指向同一片地址 */
    // 有换行符则截断
    if(strlen(buf) > 1 && buf[strlen(buf) - 1] == '\n'){
        char *subbuff = (char*)malloc(sizeof(char) * (strlen(buf) - 1));
        // 将buf的前strlen(buf)-1个字符复制到subbuff中，最后的换行符用'\0'替代
        substring(buf, subbuff, 0, strlen(buf) - 1);
        return subbuff;
    }
    // 没有换行符则直接复制整个buf
    else
    {
        char *subbuff = (char*)malloc(sizeof(char) * strlen(buf));
        strcpy(subbuff, buf);
        return subbuff;
    }
}

int 
main(int argc, char *argv[])
{
    /* code */
    int pid;
    char buf[MAXPATH];
    char *args[MAXARG];
    char *cmd;
    /* 默认命令为echo */
    if(argc == 1){
        cmd = "echo";
    }
    else{
        cmd = argv[1];
    }
    /* 计数器 */
    int args_num = 0;

    // 读取标准输入的参数，存入args数组
    while (1)
    {
        memset(buf, 0, sizeof(buf));
        gets(buf, MAXPATH);
        /* printf("buf:%s",buf); */

        // 截断输入，去掉buf末尾的换行符
        char *arg = cutoffinput(buf);
        /* printf("xargs:gets arg: %s, arglen: %d\n", arg, strlen(arg)); */
        /* press ctrl + D */
        if(strlen(arg) == 0 || args_num >= MAXARG){
            break;
        }
        args[args_num]= arg;
        args_num++;
    }

    /* 
        printargs(args, args_num);
        printf("Break Here\n");
     */
    /* 填充exec需要执行的命令至argv2exec */
    char *argv2exec[MAXARG];

    // 第一个参数必须为cmd
    argv2exec[0] = cmd;

    // 使用单独的目标索引 pos 来拼接参数，避免越界访问
    int pos = 1;
    // 先拷贝命令行中 argv[2..argc-1]（如果有）
    for (int k = 2; k < argc; k++) {
        argv2exec[pos++] = argv[k];
    }
    // 再拷贝从标准输入读取的参数
    for (int i = 0; i < args_num; i++) {
        argv2exec[pos++] = args[i];
    }
    // 最后一个参数置为 NULL
    argv2exec[pos] = 0;
    
    /* 运行cmd */
    // 创建子进程执行cmd
    if((pid = fork()) == 0){   
        exec(cmd, argv2exec);    
    }
    // 父进程等待子进程结束
    else
    {
        /* code */
        wait(0);
    }
    exit(0);
}



