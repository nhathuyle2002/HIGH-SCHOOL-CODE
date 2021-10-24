#include <bits/stdc++.h>
#define forn(i, a, b) for (int i=(a); i<=(b); ++i)
#define ford(i, a, b) for (int i=(a); i>=(b); --i)
using namespace std;
//////

typedef pair<int, int> pii;
const
    int maxn=1e3+10;
const
    int dx[4]={-1, 0, 1, 0}, dy[4]={0, 1, 0, -1};
const
    char s[4]={'N', 'E', 'S', 'W'};
int n, m;
char a[maxn][maxn];
int trace[maxn][maxn];
deque<pii> Q;
vector<int> OP;
pii res;
//////

void enter()
{
    scanf("%d%d\n", &n, &m);
    Q.clear();
    forn(i, 1, n)
    {
        scanf("%s\n", a[i]+1);
        forn(j, 1, m)
            if (a[i][j]=='*')
            {
                trace[i][j]=-1;
                Q.push_back({i, j});
            }
    }
}
//////

void process()
{
    while (!Q.empty())
    {
        pii p=Q.front(); Q.pop_front();
        if (p.first==1 || p.first==n || p.second==1 || p.second==m)
        {
            res=p;
            return;
        }
        forn(dir, 0, 3)
        {
            int x=p.first+dx[dir], y=p.second+dy[dir];
            if (x>=1 && y>=1 && x<=n && y<=m && trace[x][y]==0 && a[x][y]!='#')
            {
                trace[x][y]=dir+1;
                Q.push_back({x, y});
            }
        }
    }
}
//////

void pr()
{
    int x=res.first, y=res.second;
    while (trace[x][y]>0)
    {
        int dir=trace[x][y]-1;
        OP.push_back(dir);
        x-=dx[dir];
        y-=dy[dir];
    }
    if (!OP.empty())
        ford(i, OP.size()-1, 0) cout << s[OP[i]];
}
//////

int main()
{
    freopen("labyrinth.inp", "r", stdin);
    freopen("labyrinth.out", "w", stdout);
    enter();
    process();
    pr();
}
