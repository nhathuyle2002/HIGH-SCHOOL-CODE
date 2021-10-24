#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
#define repn(i,a,b) for(int i=(a); i<(b); ++i)
using namespace std;
//////

struct point
{
    int x, y;
};
typedef pair<point, point > pairpp;
const
    int maxn=82;
const
    point dd[4]={-1, 0, 0, 1, 1, 0, 0, -1};

int m, n;
char a[maxn][maxn];
point S1, S2, T;
int d[maxn][maxn][maxn][maxn];
deque<pairpp> Q;
//////

void enter()
{
    scanf("%d%d\n", &m, &n);
    forn(i, 1, m)
    {
        scanf("%s\n", a[i]+1);
        forn(j, 1, n)
            if (a[i][j]=='*') S1={i, j}; else
            if (a[i][j]=='$') S2={i, j}; else
            if (a[i][j]=='@') T={i, j};
    }
}
//////

bool check(point p)
{
    if (p.x<1 || p.x>m || p.y<1 || p.y>n) return false;
    if (a[p.x][p.y]=='#') return false;
    return true;
}

void process()
{
    Q.clear();
    d[S1.x][S1.y][S2.x][S2.y]=1;
    Q.push_back({S1, S2});
    while (!Q.empty())
    {
        point u1=Q.front().first, u2=Q.front().second; Q.pop_front();
        forn(div, 0, 3)
        {
            point v1={u1.x+dd[div].x, u1.y+dd[div].y}, v2=u2;
            if (!check(v1)) continue;
            if (v1.x==v2.x && v1.y==v2.y) v2={v2.x+dd[div].x, v2.y+dd[div].y};
            if (!check(v2)) continue;
            if (d[v1.x][v1.y][v2.x][v2.y]==0)
            {
                d[v1.x][v1.y][v2.x][v2.y]=d[u1.x][u1.y][u2.x][u2.y]+1;
                Q.push_back({v1, v2});
                if (v2.x==T.x && v2.y==T.y)
                {
                    cout << d[v1.x][v1.y][v2.x][v2.y]-1;
                    return;
                }
            }
        }
    }
    cout << -1;
}
//////

int main()
{
    freopen("cargo.inp", "r", stdin);
    freopen("cargo.out", "w", stdout);
    enter();
    process();
}
