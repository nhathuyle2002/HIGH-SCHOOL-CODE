#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); i++)
#define ford(i,a,b) for(int i=(a); i>=(b); i--)

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
    int maxn=1e3+100, oo=maxn*maxn;
const
    int di[4]={-1, 0, 1, 0}, dj[4]={0, 1, 0, -1};
int n, m;
int a[maxn][maxn], d[maxn][maxn];
set<data> Q;
///////

void enter()
{
    scanf("%d%d\n", &n, &m);
    forn(i, 1, n)
    {
        forn(j, 1, m) scanf("%d", &a[i][j]);
        scanf("\n");
    }
}
///////

bool inrange(int x, int l, int r)
{
    return l<=x && x<=r;
}

void process()
{
    forn(x, 1, n)
        forn(y, 1, m) d[x][y]=oo;
    d[1][1]=0; if (d[1][1] % 2== a[1][1]) ++d[1][1];
    Q.insert({d[1][1], 1, 1});
    while (!Q.empty())
    {
        data p=*Q.begin(); Q.erase(Q.begin());
        if (p.x==n && p.y==m) break;
        forn(i, 0, 3)
        {
            int x=p.x+di[i], y=p.y+dj[i];
            if (inrange(x, 1, n) && inrange(y, 1, m))
            {
                int w=p.w+1;
                if (w % 2==a[x][y]) ++w;
                if (w<d[x][y])
                {
                    if (d[x][y]<oo) Q.erase({d[x][y], x, y});
                    d[x][y]=w;
                    Q.insert({w, x, y});
                }
            }
        }
    }
    cout << d[n][m];
}
///////

int main()
{
    freopen("bus.inp", "r", stdin);
    freopen("bus.out", "w", stdout);
    enter();
    process();
}
