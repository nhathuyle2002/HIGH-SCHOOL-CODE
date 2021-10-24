#include <iostream>
#include <stdio.h>

using namespace std;
//////

const
    int maxn=1e4+10, maxm=5e3+10;
int n, m;
int d[maxn];
int f[maxn][maxm];
//////

void enter()
{
    scanf("%d%d\n", &n, &m);
    for (int i=1; i<=n; i++) scanf("%d\n", &d[i]);
}
//////

void process()
{
    for (int i=1; i<=n; i++)
    {
        f[i][0]=f[i-1][0];
        for (int j=1; j<=min(i-1, m); j++)
            f[i][0]=max(f[i][0], f[i-j][j]);
        for (int j=1; j<=m; j++)
            f[i][j]=f[i-1][j-1]+d[i];
    }
    cout << f[n][0];
}
//////

int main()
{
    freopen("running.inp", "r", stdin);
    freopen("running.out", "w", stdout);
    enter();
    process();
}
