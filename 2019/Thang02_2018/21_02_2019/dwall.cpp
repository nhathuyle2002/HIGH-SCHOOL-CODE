#include <iostream>
#include <stdio.h>

using namespace std;
/////////

const
    int di[4]={-1, 0, 1, 0}, dj[4]={0, 1, 0, -1};
const
    int maxn=1e3+100;

int m, n;
int d[maxn][maxn][4];
int coutp;
int id[maxn][maxn];
int s[maxn*maxn];
int maxs;
/////////

void enter()
{
    scanf("%d%d", &m, &n);
    int x1, y1, x2, y2;
    while (scanf("%d%d%d%d", &x1, &y1, &x2, &y2)>0)
    {
        if (x1==x2)
        {
            if (y1>y2) swap(y1, y2);
            d[x1][y1][1]=1; d[x2][y2][3]=1;
        } else
        if (y1==y2)
        {
            if (x1>x2) swap(x1, x2);
            d[x1][y1][2]=1; d[x2][y2][0]=1;
        }
    }
}
/////////

void dfs(int x, int y)
{
    id[x][y]=coutp;
    s[coutp]++;
    for (int k=0; k<=3; k++)
    {
        int i=x+di[k], j=y+dj[k];
        if (d[x][y][k]==0 && i>0 && i<=m && j>0 && j<=n && id[i][j]==0) dfs(i, j);
    }
}

void process()
{
    coutp=0;
    maxs=0;
    for (int i=1; i<=m; i++)
        for (int j=1; j<=n; j++)
        if (id[i][j]==0)
        {
            coutp++;
            s[coutp]=0;
            dfs(i, j);
            maxs=max(maxs, s[coutp]);
        }
    cout << coutp << '\n';
    cout << maxs << '\n';
    int x1, y1, x2, y2;
    maxs=0;
    for (int i=1; i<=m; i++)
        for (int j=1; j<=n; j++)
            for (int k=1; k<=2; k++)
                if (d[i][j][k]==1)
                {
                    int x=i+di[k], y=j+dj[k];
                    if (x<1 || y>m || x<1 || y>n) continue;
                    int s2;
                    if (id[i][j]==id[x][y]) s2=s[id[i][j]]; else
                    s2=s[id[i][j]]+s[id[x][y]];
                    if (s2>maxs)
                    {
                        maxs=s2;
                        x1=i; y1=j; x2=x; y2=y;
                    }
                }
    cout << x1 << ' ' << y1 << ' ' << x2 << ' ' << y2 << '\n';
    cout << maxs;
}
/////////

int main()
{
    freopen("dwall.inp", "r", stdin);
    freopen("dwall.out", "w", stdout);
    enter();
    process();
}
