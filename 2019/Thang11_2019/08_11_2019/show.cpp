#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
#define repn(i,a,b) for(int i=(a); i<(b); ++i)
using namespace std;
//////

typedef pair<int, int> pii;
const
    int maxn=410;
int n, nd;
pii a[maxn], b[maxn], Q[2*maxn];
int d[2*maxn], sumd[2*maxn], f[2*maxn][maxn];
pii trace[2*maxn][maxn];
int ans[maxn], couans[3];
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

bool compare(pii x, pii y) {return x.second<y.second; }

void enter()
{
    fastscan(n);
    //scanf("%d\n", &n);
    forn(i, 1, n)
    {
        fastscan(a[i].first); fastscan(a[i].second);
        //scanf("%d%d\n", &a[i].first, &a[i].second);
        a[i].second+=a[i].first;
        b[i]=a[i];
        Q[i]={a[i].first, i}; Q[i+n]={a[i].second, i+n};
    }

    sort(Q+1, Q+2*n+1);
    nd=0; Q[0].first=-1;
    forn(i, 1, 2*n)
    {
        if (Q[i].first>Q[i-1].first) ++nd;
        if (Q[i].second<=n) a[Q[i].second].first=nd; else a[Q[i].second-n].second=nd;
    }
}
//////

bool maximize(int &x, int y) {if (y>=0 && x<y) {x=y; return true;} else return false; }

void truyvet(int i, int k)
{
    if (i==0) return;
    int j=trace[i][k].first, k2=trace[i][k].second;
    //if (trace[i][k]==make_pair(i-1, k)) truyvet(i-1, k); else
    if (k2==k)
    {
        forn(ia, 1, n)
            if (j<=a[ia].first && a[ia].second<=i) ans[ia]=1, ++couans[1];
        truyvet(j, k2);
    }
    else
    if (k2<k)
    {
        forn(ia, 1, n)
            if (j<=a[ia].first && a[ia].second<=i) ans[ia]=2, ++couans[2];
        truyvet(j, k2);
    }
}

void process()
{
    f[0][0]=0;
    forn(k, 1, n) f[0][k]=-maxn*maxn;
    forn(i, 1, nd) d[i]=0;

    forn(i, 1, nd)
    {
        forn(j, 1, n)
            if (a[j].second==i) d[a[j].first]++;
        sumd[i]=0;
        ford(j, i-1, 1) sumd[j]=sumd[j+1]+d[j];

        forn(k, 0, n)
        {
            f[i][k]=f[i-1][k]; trace[i][k]={i-1, k};
            if (k>sumd[1]) continue;
            ford(j, i-1, 1)
            {
                if (k-sumd[j]>=0 && maximize(f[i][k], f[j][k-sumd[j]])) trace[i][k]={j, k-sumd[j]};
                if (maximize(f[i][k], f[j][k]+sumd[j])) trace[i][k]={j, k};
            }
        }
    }
    int res=-1, kres=-1;
    forn(k, 0, n)
        if (res<min(k, f[nd][k])) res=min(k, f[nd][k]), kres=k;
    truyvet(nd, kres);

    //cout << res << '\n';
    forn(i, 1, n)
        cout << ans[i] << ' ';
}
//////

int main()
{
    freopen("show.inp", "r", stdin);
    freopen("show.out", "w", stdout);
    enter();
    process();
}
