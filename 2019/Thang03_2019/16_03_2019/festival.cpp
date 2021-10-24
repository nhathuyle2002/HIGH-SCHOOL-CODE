#include <iostream>
#include <stdio.h>

using namespace std;
//////

const
    int maxn=1e3+100, maxb=1<<20;
int n, m;
int d[maxn][maxn/20];
int f1[maxb];
long long res;
//////

void enter()
{
    scanf("%d%d\n", &n, &m);
    for (int i=0; i<m; i++)
    {
        int u, v;
        scanf("%d%d\n", &u, &v);
        d[u][v/20]|=(1 << (v % 20));
    }
    for (int i=0; i<maxb; i++)
    {
        f1[i]=0;
        for (int j=0; j<=19; j++)
            if ((i>>j&1)==1) f1[i]++;
    }
}
//////

void process()
{
    res=0;
    for (int x=1; x<=n; x++) for (int y=x+1; y<=n; y++)
    {
        int cou=0;
        for (int z=0; z<=n/20; z++)
            cou+=f1[d[x][z] & d[y][z]];
        res+=cou*(cou-1)/2;
    }
    cout << res;
}

int main()
{
    freopen("festival.inp", "r", stdin);
    freopen("festival.out", "w", stdout);
    enter();
    process();
}
