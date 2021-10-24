#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
using namespace std;
//////

const
    int maxx=2e3+10, kk=1e3+1;
const
    int dx[4]={0, 1, 0, -1}, dy[4]={1, 0, -1, 0};
bool d[maxx+1][maxx+1][4];
bool d2[maxx+1][maxx+1];
int deg[maxx+1][maxx+1];
bool found;
int res, coul, couc;
//////

void enter()
{
    int n; scanf("%d\n", &n);
    while (n--)
    {
        int a, b, c, D;
        scanf("%d%d%d%d\n", &a, &b, &c, &D);
        a+=kk; b+=kk; c+=kk; D+=kk;
        if (a>c) swap(a, c);
        if (b>D) swap(b, D);
        forn(x, a, c)
            forn(y, b, D)
        {
            if (x>a) d[x][y][3]=true;
            if (x<c) d[x][y][1]=true;
            if (y>b) d[x][y][2]=true;
            if (y<D) d[x][y][0]=true;
            //if ((x!=a || y!=b) && (x!=c || y!=D)) deg[x][y]+=2; else deg[x][y]++;
            if ((x==a && y==b) || (x==c && y==D)) deg[x][y]++;
            else deg[x][y]+=2;
        }
    }
}
//////

void dfs(int x, int y)
{
    d2[x][y]=true;
    if (deg[x][y] % 2==1)
    {
        found=true;
        res++; coul++;
    }
    forn(dir, 0, 3)
    if (d[x][y][dir])
    {
        int i=x+dx[dir], j=y+dy[dir];
        if (!d2[i][j]) dfs(i, j);
    }
}

void process()
{
    res=0;
    forn(x, 0, maxx)
        forn(y, 0, maxx)
        if (!d2[x][y] && deg[x][y]>0)
        {
            found=false;
            dfs(x, y);
            if (!found)
            {
                res+=2;
                //cout << x-kk << ' ' << y-kk << '\n';
            }
        }
    cout << res/2;
    //cout << '\n' << coul << '\n' << couc;
}
//////

int main()
{
    freopen("archi.inp", "r", stdin);
    freopen("archi.out", "w", stdout);
    enter();
    process();
}
