#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); i++)
#define ford(i,a,b) for(int i=(a); i>=(b); i--)
using namespace std;
//////

typedef pair<int, int> pii;
const
    int maxn=1010, oo=1e7;
const
    int di[4]={-1, 0, 1, 0}, dj[4]={0, 1, 0, -1};

int n, m, K;
char a[maxn][maxn];
pii start, finish;
vector<pii> QS;
deque<pii> QB;
int c[maxn][maxn];
priority_queue<pair<int, pii> > Q;
int d[maxn][maxn];
//////

void enter()
{
    scanf("%d%d%d\n", &n, &m, &K);
    QS.clear();
    forn(i, 1, n)
    {
        scanf("%s\n", a[i]+1);
        forn(j, 1, m)
            if (a[i][j]=='H') start={i, j}; else
            if (a[i][j]=='G') finish={i, j}; else
            if (a[i][j]=='S') QS.push_back({i, j});
    }
}
//////

void bfs(int k)
{
    forn(i, 1, n)
        forn(j, 1, m) c[i][j]=0;
    if (k==0) return;
    QB.clear();
    for(pii p : QS)
    {
        c[p.first][p.second]=1;
        QB.push_back(p);
    }
    c[start.first][start.second]=-1; c[finish.first][finish.second]=-1;
    while (!QB.empty())
    {
        int x=QB.front().first, y=QB.front().second; QB.pop_front();
        if (c[x][y]==k) continue;
        forn(i, 0, 3)
        {
            int xx=x+di[i], yy=y+dj[i];
            if (xx>0 && xx<=n && yy>0 && yy<=m && c[xx][yy]==0)
            {
                c[xx][yy]=c[x][y]+1;
                QB.push_back({xx, yy});
            }
        }
    }
    c[start.first][start.second]=0; c[finish.first][finish.second]=0;
}
//////

void dijkstra()
{
    forn(i, 1, n)
        forn(j, 1, m) d[i][j]=oo;
    d[start.first][start.second]=0;
    while (!Q.empty()) Q.pop();
    Q.push({0, start});
    while (!Q.empty())
    {
        int ww=Q.top().first;
        pii p=Q.top().second; Q.pop();
        int x=p.first, y=p.second;
        if (-ww!=d[x][y]) continue;
        if (x==finish.first && y==finish.second) return;
        forn(i, 0, 3)
        {
            int xx=x+di[i], yy=y+dj[i], w=d[x][y];
            if (c[xx][yy]>0) ++w;
            if (xx>0 && xx<=n && yy>0 && yy<=m && w<d[xx][yy])
            {
                d[xx][yy]=w;
                Q.push({-w, {xx, yy}});
            }
        }
    }
}
//////

void process()
{
    if (K>=n+m-3)
    {
        cout << -1;
        return;
    }
    int L=0, R=n+m;
    while (L<R)
    {
        int mid=(L+R)>>1;
        bfs(mid);
        dijkstra();
        if (d[finish.first][finish.second]<=K) L=mid+1; else R=mid;
    }
    cout << L-1;
}
//////

int main()
{
    freopen("flood.inp", "r", stdin);
    freopen("flood.out", "w", stdout);
    enter();
    process();
}
