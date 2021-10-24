#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
#define repn(i,a,b) for(int i=(a); i<(b); ++i)
using namespace std;
//////

typedef pair<int, int> pii;
const
    int maxn=1e2+100;
const
    pii dd[4]={{0, 1}, {1, 0}, {0, -1}, {-1, 0}};
int n, W, H;
pii a[maxn], b[maxn], c[maxn];
int realX[maxn], realY[maxn];
bool e[maxn][maxn][4], d[maxn][maxn];
int n_area;
long long area[maxn*maxn];
//////

void fastscan(int &number)
{
    number=0;
    register char c=getchar();
    while (c!='-' && (c<48 || c>57)) c=getchar();
    bool negative=false;
    if (c=='-') negative=true, c=getchar();
    for(; c>47 && c<58; c=getchar())
        number=number*10+c-48;
    if (negative) number=-number;
}

void enter()
{
    fastscan(W); fastscan(H);
    fastscan(n);
    forn(i, 1, n)
    {
        fastscan(a[i].first); fastscan(a[i].second);
        fastscan(b[i].first); fastscan(b[i].second);
        if (a[i]>b[i]) swap(a[i], b[i]);
        a[i].first=min(a[i].first, W); b[i].first=min(b[i].first, W);
        a[i].first=max(a[i].first, 0); b[i].first=max(b[i].first, 0);
        a[i].second=min(a[i].second, H); b[i].second=min(b[i].second, H);
        a[i].second=max(a[i].second, 0); b[i].second=max(b[i].second, 0);
    }
}
//////

void init()
{
    forn(i, 1, n)
    {
        c[i]={a[i].first, i};
        c[i+n]={b[i].first, i+n};
    }
    c[2*n+1]={W, 2*n+1};
    sort(c+1, c+2*n+2);
    int cou=0; realX[0]=0;
    c[0].first=0;
    forn(i, 1, 2*n+1)
    {
        if (c[i].first>c[i-1].first) realX[++cou]=c[i].first;
        int p=c[i].second;
        if (p<=n) a[p].first=cou; else
        if (p<=2*n) b[p-n].first=cou; else
        W=cou;
    }

    forn(i, 1, n)
    {
        c[i]={a[i].second, i};
        c[i+n]={b[i].second, i+n};
    }
    c[2*n+1]={H, 2*n+1};
    sort(c+1, c+2*n+2);
    cou=0; realY[0]=0;
    c[0].first=0;
    forn(i, 1, 2*n+1)
    {
        if (c[i].first>c[i-1].first) realY[++cou]=c[i].first;
        int p=c[i].second;
        if (p<=n) a[p].second=cou; else
        if (p<=2*n) b[p-n].second=cou; else
        H=cou;
    }

    forn(x, 1, W)
        forn(y, 1, H)
            forn(div, 0, 3) e[x][y][div]=true;

    forn(i, 1, n)
        if (a[i].first==b[i].first)
        {
            int x=a[i].first;
            forn(y, a[i].second+1, b[i].second)
                e[x][y][1]=false, e[x+1][y][3]=false;
        } else
        if (a[i].second==b[i].second)
        {
            int y=a[i].second;
            forn(x, a[i].first+1, b[i].first)
                e[x][y][0]=false, e[x][y+1][2]=false;
        }
}
//////

void dfs(int x, int y)
{
    area[n_area]+=1LL*(realX[x]-realX[x-1])*(realY[y]-realY[y-1]);
    d[x][y]=false;
    forn(div, 0, 3)
    if (e[x][y][div])
    {
        int i=x+dd[div].first, j=y+dd[div].second;
        if (i>0 && j>0 && i<=W && j<=H && d[i][j]) dfs(i, j);
    }
}

void process()
{
    forn(x, 1, W)
        forn(y, 1, H) d[x][y]=true;
    n_area=0;
    forn(x, 1, W)
        forn(y, 1, H)
            if (d[x][y])
            {
                area[++n_area]=0;
                dfs(x, y);
            }
    sort(area+1, area+n_area+1);
    ford(i, n_area, 1) cout << area[i] << '\n';
}
//////

int main()
{
    freopen("segments.inp", "r", stdin);
    freopen("segments.out", "w", stdout);
    enter();
    init();
    process();
}
