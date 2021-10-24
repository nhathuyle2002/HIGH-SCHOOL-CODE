#include <bits/stdc++.h>
#define forn(i, a, b) for (int i=(a); i<=(b); ++i)
#define ford(i, a, b) for (int i=(a); i>=(b); --i)
using namespace std;
//////

const
    int maxn=1e3+10;
const
    int dx[4]={-1, 0, 1, 0}, dy[4]={0, 1, 0, -1};
int n, m;
char a[maxn][maxn];
bool d[maxn][maxn];
int ck, fox, rck, rfox;
//////

void enter()
{
    scanf("%d%d\n", &n, &m);
    forn(i, 1, n)
        scanf("%s\n", a[i]+1);
}
//////

void dfs(int i, int j)
{
    d[i][j]=true;
    if (a[i][j]=='c') ck++; else
    if (a[i][j]=='f') fox++;
    forn(dir, 0, 3)
        {
            int x=i+dx[dir], y=j+dy[dir];
            if (x>=1 && y>=1 && x<=n && y<=m && d[x][y]==false && a[x][y]!='#')
                dfs(x, y);
        }
}

void process()
{
    rck=0; rfox=0;
    forn(i, 1, n)
        forn(j, 1, m)
            if (!d[i][j] && a[i][j]!='#')
            {
                ck=0; fox=0;
                dfs(i, j);
                if (ck>fox) rck+=ck; else rfox+=fox;
            }
    cout << rfox << ' ' << rck;
}
//////

int main()
{
    freopen("farm.inp", "r", stdin);
    freopen("farm.out", "w", stdout);
    enter();
    process();
}
