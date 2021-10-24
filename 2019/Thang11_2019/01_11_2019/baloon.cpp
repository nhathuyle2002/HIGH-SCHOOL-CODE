#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
#define repn(i,a,b) for(int i=(a); i<(b); ++i)
using namespace std;
//////

const
    int maxn=210;
int nTest, n;
int a[maxn], d[4][maxn], f[maxn][maxn][4], gmax[4];
bool del[maxn][maxn];
//////

void enter()
{
    n=0;
    register char c=getchar();
    forn(x, 0, 3) d[x][0]=0;
    for(; c>='A' && c<='Z'; c=getchar())
    {
        ++n;
        if (c=='R') a[n]=0; else
        if (c=='B') a[n]=1; else
        if (c=='G') a[n]=2; else
        if (c=='Y') a[n]=3;
        forn(t, 0, 3) d[t][n]=d[t][n-1];
        d[a[n]][n]++;
    }
}
//////

void init()
{
    ford(i, n, 1)
    forn(j, i, n)
    {
        del[i][j]=false;
        if (j==i+1 && a[i]==a[j]) del[i][j]=true; else
        if (j>=i+2)
        forn(k, i, j-1)

    }
}
//////

void maximize(int &x, int y) { if (x<y) x=y;}

void process()
{
    forn(i, 1, n)
    {
        forn(x, 0, 3) f[i][i][x]=1;
        f[i][i][a[i]]=0;
    }
    ford(i, n, 1)
    forn(j, i+1, n)
    {
        forn(x, 0, 3)
        {
            gmax[x]=0;
            forn(k, i, j-1)
                maximize(gmax[x], f[i][k][x]+f[k+1][j][x]);
        }
        forn(x, 0, 3)
        {
            f[i][j][x]=gmax[x];
            if (d[x][j]-d[x][i-1]==0)
            forn(t, 0, 3)
                if (t!=x) maximize(f[i][j][x], gmax[t]+(d[t][j]-d[t][i-1])*(d[t][j]-d[t][i-1]));
        }
    }

    gmax[0]=0;
    forn(x, 0, 3) maximize(gmax[0], f[1][n][x]+d[x][n]*d[x][n]);
    cout << gmax[0] << '\n';
}
//////

int main()
{
    freopen("baloon.inp", "r", stdin);
    freopen("baloon.out", "w", stdout);
    scanf("%d\n", &nTest);
    while (nTest--)
    {
        enter();
        init();
        process();
    }
}
