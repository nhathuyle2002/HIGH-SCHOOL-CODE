#include <iostream>
#include <stdio.h>
#include <algorithm>

using namespace std;
///////

const int maxn=52;
const int di[]={-1, -1, -1, 0, 1, 1, 1, 0};
const int dj[]={-1, 0, 1, 1, 1, 0, -1, -1};

int n, x0, y0, couk;
char a[maxn][maxn];
int h[maxn][maxn];
int cou;
int d[maxn*maxn];
int res, num, ll, rr;
int dd[maxn][maxn];
///////

void enter()
{
    scanf("%d\n", &n);
    couk=0;
    for (int i=1; i<=n; i++)
    {
        scanf("%s\n", a[i]+1);
        for (int j=1; j<=n; j++)
            if (a[i][j]=='P')
        {
            x0=i; y0=j;
        } else
            if (a[i][j]=='K') couk++;
    }
    cou=0;
    for (int i=1; i<=n; i++)
    {
        for (int j=1; j<=n; j++)
        {
            scanf("%d", &h[i][j]);
            cou++;
            d[cou]=h[i][j];
        }
        scanf("\n");
    }
    sort(d+1, d+cou+1);
    int c2=cou; cou=0;
    d[0]=0;
    for (int i=1; i<=c2; i++)
        if (d[i]>d[i-1])
        {
            cou++;
            d[cou]=d[i];
        }
}
///////

void init(int x, int y)
{
    ll=d[x]; rr=d[y];
    num=0;
    for (int i=1; i<=n; i++)
        for (int j=1; j<=n; j++)
            dd[i][j]=0;
}

void dfs(int x, int y)
{
    dd[x][y]=1;
    if (a[x][y]=='K') num++;
    for (int k=0; k<8; k++)
    {
        int i=x+di[k], j=y+dj[k];
        if (i<1 || i>n || j<1 || j>n || dd[i][j]==1 || h[i][j]<ll || h[i][j]>rr) continue;
        dfs(i, j);
    }
}

void process()
{
    res=int(1e7);
    int j=1;
    for (int i=1; i<=cou; i++)
    {
        if (d[i]>h[x0][y0]) break;
        while (j<=cou)
        {
            if (d[j]>=h[x0][y0])
            {
                init(i, j);
                dfs(x0, y0);
                if (num==couk) break;
            }
            j++;
        }
        if (j>cou) break;
        res=min(res, rr-ll);
    }
    cout << res;
}
///////

int main()
{
    freopen("mailman.inp", "r", stdin);
    freopen("mailman.out", "w", stdout);
    enter();
    process();
}
