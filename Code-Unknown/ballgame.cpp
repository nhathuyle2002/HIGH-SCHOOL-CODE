#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
using namespace std;
//////

typedef long long LL;
typedef pair<int, int> pii;
const
    int maxx=101, oo=1e7;
const
    int di[4]={-1, 0, 1, 0}, dj[4]={0, 1, 0, -1};
int m, n;
bool avail[maxx+1][maxx+1];
vector<pii> QS;
deque<pii> Q;
int d[maxx+1][maxx+1], sum[maxx+1][maxx+1];
LL res;
//////

void enter()
{
    forn(x, 0, maxx)
        forn(y, 0, maxx)
            avail[x][y]=true;
    scanf("%d\n", &m);
    forn(i, 1, m)
    {
        int x, y; scanf("%d%d\n", &x, &y);
        avail[x][y]=false;
    }

    scanf("%d\n", &n);
    forn(i, 1, n)
    {
        int x, y; scanf("%d%d\n", &x, &y);
        QS.push_back({x, y});
    }
}
//////

void bfs(pii S)
{
    forn(x, 0, maxx)
        forn(y, 0, maxx)
            d[x][y]=oo;
    Q.clear();
    if (!avail[S.first][S.second]) return;
    d[S.first][S.second]=0;
    Q.push_back(S);
    while (!Q.empty())
    {
        pii p=Q.front(); Q.pop_front();
        int x0=p.first, y0=p.second;
        forn(dir, 0, 3)
        {
            int x=x0+di[dir], y=y0+dj[dir];
            if (x>=0 && x<=maxx && y>=0 && y<=maxx && d[x][y]==oo && avail[x][y])
            {
                d[x][y]=d[x0][y0]+1;
                Q.push_back({x, y});
            }
        }
    }
}

void process1()
{
    for(pii p : QS)
    {
        bfs(p);
        forn(x, 0, maxx)
            forn(y, 0, maxx) sum[x][y]+=d[x][y];
    }
    int res=oo;
    forn(x, 0, maxx)
            forn(y, 0, maxx)
            {
                //if (sum[x][y]==2) cout << x<< ' '<< y<< '\n';
                res=min(res, sum[x][y]);
            }
    if (res==oo) cout << -1; else cout << res;
}
//////

void process2()
{
    res=1e15;
    forn(i, 0, QS.size()-1)
        forn(j, 0, QS.size()-1)
        {
            int x0=QS[i].first, y0=QS[j].second;
            LL sum=0;
            forn(t, 0, QS.size()-1)
                sum+=abs(x0-QS[t].first)+abs(y0-QS[t].second);
            res=min(res, sum);
        }
    cout << res;
}
//////

int main()
{
    freopen("ballgame.inp", "r", stdin);
    freopen("ballgame.out", "w", stdout);
    enter();
    if (m==0) process2(); else
    process1();
}
