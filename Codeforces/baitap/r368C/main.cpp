#include <iostream>
#include <stdio.h>
#include <vector>

using namespace std;
//////

struct data
{
    int x, y, z;
};

const
    int maxn=1e3+10,
    maxq=1e5+100;

int n, m, q, cou;
data a[maxq];
int d[maxn][maxn];
int sum[maxn], tick[maxn];
int res[maxq];
vector<int> e[maxq];
//////

void enter()
{
    scanf("%d%d%d", &n, &m, &q);
    for (int i=1; i<=q; i++)
    {
        scanf("%d", &a[i].x);
        if (a[i].x<=2) scanf("%d%d", &a[i].y, &a[i].z); else scanf("%d", &a[i].y);
    }
    for (int i=1; i<=q; i++)
        if (a[i].x<=3) e[i-1].push_back(i); else e[a[i].y].push_back(i);
}
//////

void dfs(int u)
{
    int x=a[u].x, y=a[u].y, z=a[u].z, ok=0;
    if (x==1 && d[y][z]==tick[y])
    {
        d[y][z]=1-d[y][z];
        cou++;
        sum[y]++;
        ok=1;
    } else
    if (x==2 && d[y][z]!=tick[y])
    {
        d[y][z]=1-d[y][z];
        cou--;
        sum[y]--;
        ok=1;
    } else
    if (x==3)
    {
        cou-=sum[y];
        sum[y]=m-sum[y];
        tick[y]=1-tick[y];
        cou+=sum[y];
        ok=1;
    }

    res[u]=cou;
    for (int i=0; i<(int)e[u].size(); i++) dfs(e[u][i]);
    if (ok==0) return;

    if (x==1)
    {
        d[y][z]=1-d[y][z];
        cou--;
        sum[y]--;
        ok=1;
    } else
    if (x==2)
    {
        d[y][z]=1-d[y][z];
        cou++;
        sum[y]++;
        ok=1;
    } else
    if (x==3)
    {
        cou-=sum[y];
        sum[y]=m-sum[y];
        tick[y]=1-tick[y];
        cou+=sum[y];
        ok=1;
    }
}

void process()
{
    dfs(0);
    for (int i=1; i<=q; i++) cout << res[i] << '\n';
}

int main()
{
    enter();
    process();
}
