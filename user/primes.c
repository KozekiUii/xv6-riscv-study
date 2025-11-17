#include "kernel/types.h"
#include "user.h"

#define SUCCESS 0

// Function Declarations
void generate_nums(int nums[34]);
void send_primes(int pd[], int infos[], int infoslen);
void check_pd(int pd[], int len);
__attribute__((noreturn)) void process(int pd[]);

int main(int argc, char **argv)
{
    // 声明管道
    int pd[2]; // pipe descriper
    // 创建管道
    pipe(pd);
    // check_pd(pd, 2);
    int pid;

    // Child Process
    if ((pid = fork()) == 0)
    {
        process(pd);
        exit(SUCCESS);
    }
    // Parent Process
    else
    {
        int nums[34];
        generate_nums(nums);
        send_primes(pd, nums, 34);
        // sleep(10);
        exit(SUCCESS);
    }
}

__attribute__((noreturn)) void process(int pd[])
{
    int p;
    int n;
    int len;
    int pid;
    int pd_child[2];
    int infos[34];
    int infos_i = 0;
    pipe(pd_child);
    // check_pd(pd_child, 2);

    close(pd[1]);
    // 读取管道中的第一个数作为素数
    len = read(pd[0], &p, sizeof(p));
    printf("prime %d\n", p);

    // 当管道未读完时，继续读取
    while (len != 0)
    {
        len = read(pd[0], &n, sizeof(n));
        // 筛选出不能被p整除的数，存入infos数组
        // infos用于存储筛选后的数
        if (n % p != 0)
        {
            *(infos + infos_i) = n;
            infos_i++;
        }
    }

    close(pd[0]);
    // 若infos数组为空，则结束进程
    if (infos_i == 0)
    {
        exit(SUCCESS);
    }

    // Child Process
    // 子进程中继续筛选
    if ((pid = fork()) == 0)
    {
        process(pd_child);
    }
    // Parent Process
    // 向父进程中发送筛选后的数组
    else
    {
        send_primes(pd_child, infos, infos_i);
        exit(SUCCESS);
    }
}

void generate_nums(int nums[34])
{
    int i = 0;
    for (int count = 2; count <= 35; count++)
    {
        nums[i] = count;
        i++;
    }
}

void check_pd(int pd[], int len)
{
    printf("pd:\n");
    for (int i = 0; i < len; i++)
    {
        printf("%d \n", pd[i]);
    }
}

void send_primes(int pd[], int infos[], int infoslen)
{
    int info;
    close(pd[0]);
    for (int i = 0; i < infoslen; i++)
    {
        info = infos[i];
        write(pd[1], &info, sizeof(info));
    }
}
