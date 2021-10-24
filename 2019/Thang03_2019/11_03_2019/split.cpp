#include <iostream>
#include <stdio.h>
#include <string.h>

using namespace std;
//////

const
    int maxn=1e3+10;

int n, m, k;
char a[maxn], b[maxn];
int d[maxn][maxn];
int f[11][maxn][maxn];
//////

void enter()
{
    scanf("%d%d%d\n", &n, &m, &k);
    scanf("%s\n", a+1);
    scanf("%s\n", b+1);
    for (int i=1; i<=n; i++) for (int j=1; j<=m; j++)
        if (a[i]==b[j]) d[i][j]=d[i-1][j-1]+1; else d[i][j]=0;
}
//////

void process()
{
    for (int t=1; t<=k; t++)
        for (int i=1; i<=n; i++) for (int j=1; j<=m; j++)
    {
        f[t][i][j]=max(f[t-1][i][j], max(f[t][i-1][j], f[t][i][j-1]));
        if (d[i][j]>0) f[t][i][j]=max(f[t][i][j], f[t-1][i-d[i][j]][j-d[i][j]]+d[i][j]);
    }
    if (f[k][n][m]>=k) cout << f[k][n][m]; else cout << -1;
}
//////

int main()
{
    freopen("split.inp", "r", stdin);
    freopen("split.out", "w", stdout);
    enter();
    process();
}
