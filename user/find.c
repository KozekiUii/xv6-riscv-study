#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/fs.h"

//Copy from Grep.c
char buf[1024];
int match(char*, char*);
int matchhere(char*, char*);
int matchstar(int, char*, char*);

int
match(char *re, char *text)
{
  // 若正则表达式以^开头，则要求从文本开头匹配（即从text的第一个字符开始匹配）
  if(re[0] == '^')
    return matchhere(re+1, text);
  // 否则，尝试在文本的每个位置匹配正则表达式
  do{  // must look at empty string
    if(matchhere(re, text))
      return 1;
  }while(*text++ != '\0');
  return 0;
}

// 匹配re开头的正则表达式与text开头的文本
int matchhere(char *re, char *text)
{
  // 匹配规则结束，表示匹配成功
  if(re[0] == '\0')
    return 1;
  // 处理'*'通配符，表示前一个字符可以出现零次或多次
  if(re[1] == '*')
    return matchstar(re[0], re+2, text);
  // 处理'$'，表示匹配文本结尾
  if(re[0] == '$' && re[1] == '\0')
    return *text == '\0';
  // 处理单个字符匹配，支持'.'通配符，表示匹配任意单个字符
  // 这里就是匹配上了
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
    return matchhere(re+1, text+1);
  return 0;
}

// 处理'*'通配符，匹配零次或多次出现的字符c
int matchstar(int c, char *re, char *text)
{
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
      return 1;
  }while(*text!='\0' && (*text++==c || c=='.'));  // 只有当text未结束且当前字符与c匹配时，才继续尝试匹配
  return 0;
}


/*
  find.c
*/
char* fmtname(char *path);
void find(char *path, char *re);

int 
main(int argc, char** argv){
    if(argc < 2){
      printf("Parameters are not enough\n");
    }
    else{
      //在路径path下递归搜索文件 
      find(argv[1], argv[2]);
    }
    exit(0);
}

// 对ls中的fmtname，去掉了空白字符串
char*
fmtname(char *path)
{
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
    ;
  p++;
  // printf("len of p: %d\n", strlen(p));
  if(strlen(p) >= DIRSIZ)
    return p;
  memset(buf, 0, sizeof(buf));
  memmove(buf, p, strlen(p));
  //memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  return buf;
}

void 
find(char *path, char *re){
  // printf("---------------------------------------------\n");
  // printf("path:%s\n", path);
  // printf("fmtpath:%s\n",fmtname(path));
  // printf("re:%s\n", re);
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;
  
  if((fd = open(path, 0)) < 0){
      fprintf(2, "find: cannot open %s\n", path);
      return;
  }

  if(fstat(fd, &st) < 0){
      fprintf(2, "find: cannot stat %s\n", path);
      close(fd);
      return;
  }
  
  switch(st.type){
  case T_FILE:
      //printf("File re: %s, fmtpath: %s\n", re, fmtname(path));
      // 检查文件名是否匹配正则表达式（re是正则表达式，表示文件名模式；fmtname(path)是文件名）
      if(match(re, fmtname(path)))
          printf("%s\n", path);
      break;
          //printf("%s %d %d %l\n", fmtname(path), st.type, st.ino, st.size);

  case T_DIR:
      if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
          printf("find: path too long\n");
          break;
      }
      strcpy(buf, path);
      p = buf + strlen(buf);
      *p++ = '/';
      while(read(fd, &de, sizeof(de)) == sizeof(de)){
          if(de.inum == 0)
              continue;
          // 将目录项名复制到buf中，形成新的路径
          memmove(p, de.name, DIRSIZ);
          // p的DIRSIZ位置设为0，确保字符串正确结束
          p[DIRSIZ] = 0;
          if(stat(buf, &st) < 0){
              printf("find: cannot stat %s\n", buf);
              continue;
          }
          // printf("%s, %d\n",fmtname(buf), strlen(fmtname(buf)));
          // printf("%s\n",buf);
          // // printf("%d\n",strcmp(".", fmtname(buf)));
          // // printf("%d\n",strcmp("..", fmtname(buf)));
          char* lstname = fmtname(buf);
          // printf("lstname: %s\n", lstname);

          // 判断是否为"."或".."目录，若是则跳过，避免无限递归
          if(strcmp(".", lstname) == 0 || strcmp("..", lstname) == 0){
            //printf("%s %d %d %d\n", buf, st.type, st.ino, st.size);
            continue;
          }
          // 递归调用find函数，继续在子目录中搜索
          else{
            //printf("deep: %s %d %d %d\n", buf, st.type, st.ino, st.size);
            find(buf, re);
          }
          //printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
      }
      break;
  }
  close(fd);
}
