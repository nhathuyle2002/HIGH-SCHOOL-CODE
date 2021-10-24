#include <bits/stdc++.h>
#define forn(i, a, b) for (int i=(a); i<=(b); ++i)
#define ford(i, a, b) for (int i=(a); i>=(b); --i)
#define F first
#define S second
using namespace std;
//////

struct data
{
    int w, x, y;
    bool operator < (const data &A) const
    {
        if (w!=A.w) return w<A.w;
        if (x!=A.x) return x<A.x;
        return y<A.y;
    }
};

const
    int maxn=400, oo=1e7;
const
    int dx[4]={-1, 0, 1, 0}, dy[4]={0, 1, 0, -1};
int n, m, q, x1, y1, x2, y2, x3, y3;
int a[maxn][maxn], c[maxn][maxn], d[maxn][maxn];
set<data> Q;
//////

void enter()
{
    scanf("%d%d%d\n", &n, &m, &q);
    forn(i, 1, n)
        forn(j, 1, m) scanf("%d", &a[i][j]);
}
//////

int dijkstra()
{
    if (x1==x2 && y1==y2) return 0;
    forn(i, 1, n)
        forn(j, 1, m)
        {
            d[i][j]=oo;
            c[i][j]=a[i][j];
        }
    c[x3][y3]=oo;
    Q.clear();
    d[x1][y1]=0; Q.insert({c[x1][y1], x1, y1});
    while (!Q.empty())
    {
        data p=*Q.begin(); Q.erase(Q.begin());
        if (p.x==x2 && p.y==y2) return p.w;
        forn(dir, 0, 3)
        {
            int x=p.x+dx[dir], y=p.y+dy[dir];
            if (x>0 && y>0 && x<=n && y<=m && p.w+c[x][y]<d[x][y])
            {
                if (d[x][y]<oo) Q.erase({d[x][y], x, y});
                d[x][y]=p.w+c[x][y];
                Q.insert({d[x][y], x, y});
            }
        }
    }
}
//////
void process()
{
    forn(i, 1, q)
    {
        scanf("%d%d%d%d%d%d\n", &x3, &y3, &x1, &y1, &x2, &y2);
        cout << dijkstra() << '\n';
    }
}
//////

int main()
{
    freopen("birthday.inp", "r", stdin);
    freopen("birthday.out", "w", stdout);
    enter();
    process();
}
