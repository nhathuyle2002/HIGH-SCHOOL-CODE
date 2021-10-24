#include <iostream>
#include <stdio.h>

using namespace std;
//////

const
    int maxn=2e2+10;
int n, m, t;
int o[maxn];
int a[maxn][maxn], b[maxn][maxn];
int f[maxn][maxn];
//////

void enter()
{
    scanf("%d%d%d\n", &n, &m, &t);
    for (int i=1; i<=t; i++) scanf("%d", &o[i]);
    for (int i=1; i<=n; i++)
        for (int j=1; j<=n; j++)
            scanf("%d", &a[i][j]);
    for (int i=1; i<=n; i++)
        for (int j=1; j<=m; j++)
            scanf("%d", &b[i][j]);
}
//////

void process()
{
    for (int i=1; i<=t; i++)
        for (int j=1; j<=n; j++)
        {
            f[i][j]=maxn*maxn*maxn;
            for (int j2=1; j2<=n; j2++)
                f[i][j]=min(f[i][j], f[i-1][j2]+a[j2][j]+b[j][o[i]]);
        }
    int res=maxn*maxn*maxn;
    for (int j=1; j<=n; j++) res=min(res, f[t][j]);
    cout << res;
}
//////

int main()
{
    freopen("viterbi.inp", "r", stdin);
    freopen("viterbi.out", "w", stdout);
    enter();
    process();
}
