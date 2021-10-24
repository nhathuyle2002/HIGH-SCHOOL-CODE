#include <iostream>
#include <stdio.h>

using namespace std;
//////

const
    int maxm=102, maxk=510;
const
    long long INF=1e15;

int n, m, k;
int d[maxm];
long long g[maxm][maxk], f[maxm][maxk];
//////

void enter()
{
    scanf("%d%d%d\n", &n, &m, &k);
    for (int i=1; i<=n; i++)
    {
        int x;
        scanf("%d\n", &x);
        d[x]++;
    }
}
//////

long long ccl(int x, int j)
{
    if (x==0) return 0;
    int t=x/(j+1);
    return (long long)(1)*t*(t+1)/2 +ccl(x-t, j-1);
}

void process()
{
    for (int i=1; i<=m; i++)
        for (int j=0; j<=k; j++)
            g[i][j]=ccl(d[i], j);
    for (int i=1; i<=m; i++)
        for (int j=0; j<=k; j++)
    {
        f[i][j]=INF;
        for (int t=0; t<=j; t++)
            f[i][j]=min(f[i][j], f[i-1][t]+g[i][j-t]);
    }
    cout << f[m][k];
}
//////

int main()
{
    freopen("noise.inp", "r", stdin);
    freopen("noise.out", "w", stdout);
    enter();
    process();
}
