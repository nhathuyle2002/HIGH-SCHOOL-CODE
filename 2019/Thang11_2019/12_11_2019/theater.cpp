#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
#define repn(i,a,b) for(int i=(a); i<(b); ++i)
using namespace std;
//////

typedef pair<int, int> pii;
const
    int maxn=17, maxm=1e4+10;
int n, W, H, vA, vB, m;
pii a[maxn];
bool b[maxm][maxn];
double dis[maxn][maxn];
double g[maxn][1<<maxn], Ft[2][2][1<<maxn], F[maxm][2][2];
double res;
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
    fastscan(H); fastscan(W); fastscan(vA); fastscan(vB); fastscan(n);
    forn(i, 1, n) fastscan(a[i].first), fastscan(a[i].second);
    fastscan(m);
    forn(i, 1, m)
    {
        int len; fastscan(len);
        while (len--)
        {
            int p; fastscan(p);
            b[i][p]=true;
        }
    }
    #define sqr(x) (x)*(x)
    forn(i, 1, n)
        forn(j, 1, n)
            dis[i][j]=sqrt(sqr(a[i].first-a[j].first)+sqr(a[i].second-a[j].second));
}
//////

void minimize(double &x, double y) { if (x>y) x=y;}
int getb(int x, int i) { return (x >> (i-1)) &1;}
int daob(int x, int i) { return x ^ (1 << (i-1));}

void init(int S, int T, double f[])
{
    repn(x, 1, 1<<n)
        forn(i, 1, n)
        {
            g[i][x]=1e9;
            if (getb(x, i))
            {
                int y=daob(x, i);
                if (y==0)
                {
                    if (S==0) g[i][x]=a[i].first; else g[i][x]=W-a[i].first;
                    continue;
                }
                forn(j, 1, n)
                    if (getb(y, j))
                        minimize(g[i][x], g[j][y]+dis[j][i]);
            }
        }

    if (S==T) f[0]=0; else f[0]=W;
    repn(x, 1, 1<<n)
    {
        f[x]=1e9;
        forn(i, 1, n)
            if (getb(x, i))
            {
                if (T==0) g[i][x]+=a[i].first; else g[i][x]+=W-a[i].first;
                minimize(f[x], g[i][x]);
            }
    }
}
//////

void process()
{
    forn(S, 0, 1)
        forn(T, 0, 1) F[1][S][T]=1e15;
    F[1][0][1]=0;
    int X=0;
    forn(i, 1, n)
        if (b[1][i]) X=daob(X, i);

    int Y, Z;
    forn(t, 2, m)
    {
        Y=0; Z=0;
        forn(i, 1, n)
            if (b[t][i] && !getb(X, i)) Y=daob(Y, i); else
            if (!b[t][i] && getb(X, i)) Z=daob(Z, i);

        forn(S, 0, 1)
            forn(T, 0, 1)
            {
                F[t][S][T]=1e15;
                forn(S2, 0, 1)
                    forn(T2, 0, 1)
                        minimize(F[t][S][T], F[t-1][S2][T2]+ max(Ft[S2][S][Y]/vA, Ft[T2][T][Z]/vB));
            }

        X=0;
        forn(i, 1, n)
            if (b[t][i]) X=daob(X, i);
    }

    res=1e15;
    forn(S, 0, 1)
        forn(T, 0, 1)
            minimize(res, F[m][S][T]);
    printf("%0.5f", res);
}
//////

int main()
{
    freopen("theater.inp", "r", stdin);
    freopen("theater.out", "w", stdout);
    enter();
    forn(S, 0, 1)
        forn(T, 0, 1)
            init(S, T, Ft[S][T]);
    process();
}
