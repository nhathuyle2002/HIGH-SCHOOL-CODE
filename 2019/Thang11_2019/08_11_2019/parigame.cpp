#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
#define repn(i,a,b) for(int i=(a); i<(b); ++i)
using namespace std;
//////

const
    int maxn=1e3+100;
int nTest, n;
int srow[maxn][maxn], scol[maxn][maxn];
bool f[maxn][maxn];
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
    fastscan(n);
    int x;
    forn(i, 1, n)
        forn(j, 1, n)
        {
            fastscan(x); x%=2;
            srow[i][j]=srow[i][j-1]+x;
            scol[i][j]=scol[i-1][j]+x;
        }
}
//////

void process()
{
    forn(i, 1, n)
        forn(j, 1, n)
        {
            f[i][j]=false;
            if (srow[i][j]%2==0 && !f[i-1][j]) f[i][j]=true;
            if (scol[i][j]%2==0 && !f[i][j-1]) f[i][j]=true;
        }
    if (f[n][n]) cout << "YES"; else cout << "NO";
    cout << '\n';
}
//////

int main()
{
    freopen("parigame.inp", "r", stdin);
    freopen("parigame.out", "w", stdout);
    fastscan(nTest);
    while (nTest--)
    {
        enter();
        process();
    }
}
