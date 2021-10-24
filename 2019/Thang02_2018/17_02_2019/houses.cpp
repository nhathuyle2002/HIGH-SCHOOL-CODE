#include <iostream>
#include <stdio.h>
#include <algorithm>

using namespace std;
///////

const
    int maxn=1e3+10;
const
    long long base=1e9+13;

int m, n, cnt;
int a[maxn][maxn], id[maxn][maxn];
int adr[maxn*maxn][4];
long long pw[maxn];
long long hs[maxn*maxn][4];
long long h[maxn*maxn];
int res;
///////

void enter()
{
    scanf("%d%d", &m, &n);
    for (int i=1; i<=m; i++)
        for (int j=1; j<=n; j++) scanf("%d", &a[i][j]);
    pw[0]=1;
    for (int i=1; i<=max(m,n); i++)
        pw[i]=pw[i-1]*maxn % base;
}
///////

void dfs(int i, int j)
{
    if (a[i][j]==0 || id[i][j]!=0) return;
    id[i][j]=cnt;
    adr[cnt][0]=min(adr[cnt][0], i);
    adr[cnt][1]=max(adr[cnt][1], j);
    adr[cnt][2]=max(adr[cnt][2], i);
    adr[cnt][3]=min(adr[cnt][3], j);
    dfs(i-1, j);
    dfs(i, j-1);
    dfs(i+1, j);
    dfs(i, j+1);
}
///////

void init()
{
    for (int i=1; i<=m; i++)
        for (int j=1; j<=n; j++)
            if (a[i][j]==1 && id[i][j]==0)
            {
                cnt++;
                adr[cnt][0]=i; adr[cnt][1]=j; adr[cnt][2]=i; adr[cnt][3]=j;
                dfs(i, j);
            }
}
///////

void process()
{
    for (int i=1; i<=m; i++)
        for (int j=1; j<=n; j++)
        if (a[i][j]==1)
        {
            int v=id[i][j];
            int i1=adr[v][0], j2=adr[v][1], i2=adr[v][2], j1=adr[v][3];

            hs[v][0]=(hs[v][0]+pw[i-i1]*pw[j-j1]) % base;
            hs[v][1]=(hs[v][1]+pw[i-i1]*pw[j2-j]) % base;
            hs[v][2]=(hs[v][2]+pw[i2-i]*pw[j2-j]) % base;
            hs[v][3]=(hs[v][3]+pw[i2-i]*pw[j-j1]) % base;
        }
    for (int i=1; i<=cnt; i++)
        h[i]=(hs[i][0]*hs[i][1] % base)*(hs[i][2]*hs[i][3] % base) % base;//min(min(hs[i][0], hs[i][1]), min(hs[i][2], hs[i][3]));
    sort(h+1, h+cnt+1);
    h[0]=-1;
    res=0;
    for (int i=1; i<=cnt; i++)
        if (h[i]!=h[i-1]) res++;
    cout << res;
}
///////

int main()
{
    freopen("houses_0.inp", "r", stdin);
    freopen("houses.out", "w", stdout);
    enter();
    init();
    process();
}
