#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
using namespace std;
//////

const
    int maxn=35;
const
    int dx[4]={-1, 0, 1, 0}, dy[4]={0, 1, 0, -1};
int m, n, res;
int a[maxn][maxn], b[maxn][maxn];
//////

void enter()
{
    scanf("%d%d\n", &m, &n);
    forn(i, 1, m)
        forn(j, 1, n)
            scanf("%d", &a[i][j]);
}
//////

bool calc(int x, int y)
{
    if (x<1 || a[x][y]==-1) return true;
    int cou=0;
    forn(dir, 0, 3)
        cou+=b[x+dx[dir]][y+dy[dir]];
    return (a[x][y]-cou) % 2==0;
}

void dequy(int x, int y)
{
    if (y>n)
    {
        dequy(x+1, 1);
        return;
    }
    if (x>m)
    {
        forn(j, 1, n)
            if (!calc(m, j)) return;
        ++res; return;
    }
    b[x][y]=0;
    if (calc(x-1, y)) dequy(x, y+1);
    b[x][y]=1;
    if (calc(x-1, y)) dequy(x, y+1);
}
//////

int main()
{
    freopen("bomb.inp", "r", stdin);
    freopen("bomb.out", "w", stdout);
    enter();
    res=0;
    dequy(1, 1);
    cout << res;
}
