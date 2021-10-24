#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
using namespace std;
//////

typedef pair<int, int> pii;
const
    pii d[2][8]={
    {{-1, -2}, {-2, -1}, {-2, 1}, {-1, 2}, {1, 2}, {2, 1}, {2, -1}, {1, -2}},
    {{-1, -1}, {-1, 0}, {-1, 1}, {0, 1}, {1, 1}, {1, 0}, {1, -1}, {0, -1}}
    };
const
    int maxn=500, oo=1e6;
int m, n, res;
char a[maxn][maxn];
pii sma, stot;
bool dd[2][maxn][maxn];
int f[2][2][maxn][maxn];
deque<pair<int, pii> > Q;
//////

void enter()
{
    scanf("%d%d\n", &m, &n);
    forn(i, 1, m)
    {
        scanf("%s\n", a[i]+1);
        forn(j, 1, n)
            if (a[i][j]=='M') sma={i, j}; else
            if (a[i][j]=='T') stot={i, j};
    }
}
//////

void bfs(int t, pii S)
{
    forn(i, 1, m)
        forn(j, 1, n)
        {
            f[t][0][i][j]=oo;
            f[t][1][i][j]=oo;
        }
    f[t][0][S.first][S.second]=0;
    Q.clear(); Q.push_back({0, S});
    while (!Q.empty())
    {
        pair<int, pii> p=Q.front(); Q.pop_front();
        int t2=p.first, x=p.second.first, y=p.second.second;
        forn(dir, 0, 7)
        {
            int i=x+d[t][dir].first, j=y+d[t][dir].second;
            if (i>0 && i<=m && j>0 && j<=n && a[i][j]!='#' && f[t][1-t2][i][j]==oo)
            {
                f[t][1-t2][i][j]=f[t][t2][x][y]+1;
                Q.push_back({1-t2, {i, j}});
            }
        }
    }
}

void process()
{
    if (sma==stot)
    {
        cout << 0;
        return;
    }
    forn(x, 1, m)
    forn(y, 1, n)
        forn(t, 0, 1)
        {
            dd[t][x][y]=false;
            forn(dir, 0, 7)
            {
                int i=x+d[t][dir].first, j=y+d[t][dir].second;
                if (i>0 && i<=m && j>0 && j<=n && a[i][j]!='#')
                        dd[t][x][y]=true;
            }
        }
    bfs(0, sma); bfs(1, stot);
    res=oo;
    forn(t2, 0, 1)
    forn(i, 1, m)
        forn(j, 1, n)
            if (dd[0][i][j] && dd[1][i][j]) res=min(res, max(f[0][t2][i][j], f[1][t2][i][j]));
    if (res==oo) cout << -1; else cout << res;
}
//////

int main()
{
    freopen("matot.inp", "r", stdin);
    freopen("matot.out", "w", stdout);
    enter();
    process();
}
