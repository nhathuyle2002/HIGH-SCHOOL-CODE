#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); i++)
#define ford(i,a,b) for(int i=(a); i>=(b); i--)

using namespace std;
//////

typedef pair<int, int> pii;
const
    int maxn=2e3+100, maxx=1001;
const
    int di[4]={-1, 0, 1, 0}, dj[4]={0, 1, 0, -1};
int nc, S;
bool d[maxn][maxn];
int f[maxn][maxn];
long long res;
///////

void enter()
{
    scanf("%d%d\n", &nc, &S);
    forn(x, 0, 2*maxx)
        forn(y, 0, 2*maxx) d[x][y]=true;
    forn(i, 1, nc)
    {
        int x, y; scanf("%d%d\n", &x, &y);
        d[x+maxx][y+maxx]=false;
    }
}
///////

void bfs()
{
    deque<pii> Q; Q.clear();
    f[maxx][maxx]=0; Q.push_back(pii(maxx, maxx)); d[maxx][maxx]=false;
    res=0;
    while (!Q.empty())
    {
        int x0=Q.front().first, y0=Q.front().second; Q.pop_front();
        if (f[x0][y0]<=S) res++;
        forn(i, 0, 3)
        {
            int x=x0+di[i], y=y0+dj[i];
            if (x>=0 && y>=0 && x<=2*maxx && y<=2*maxx && d[x][y])
            {
                f[x][y]=f[x0][y0]+1;
                d[x][y]=false;
                Q.push_back(pii(x, y));
            }
        }
    }
}

long long calc(int x, int y)
{
    if (d[x][y]) return 0;
    int dd=S-f[x][y]-1;
    if (dd<=0) return 0;
    return 1LL*dd*(dd+1)/2;
}

void process()
{
    bfs();
    forn(x, 0, 2*maxx)
    {
        if (f[x][0]<S && !d[x][0]) res+=S-f[x][0];
        if (f[x][2*maxx]<S && !d[x][2*maxx]) res+=S-f[x][2*maxx];
    }
    forn(y, 0, 2*maxx)
    {
        if (f[0][y]<S && !d[0][y]) res+=S-f[0][y];
        if (f[2*maxx][y]<S && !d[2*maxx][y]) res+=S-f[2*maxx][y];
    }
    res+=calc(0, 0)+ calc(2*maxx, 0)+ calc(0, 2*maxx)+ calc(2*maxx, 2*maxx);
    cout << res;
}
///////

int main()
{
    freopen("ant.inp", "r", stdin);
    freopen("ant.out", "w", stdout);
    enter();
    process();
}
