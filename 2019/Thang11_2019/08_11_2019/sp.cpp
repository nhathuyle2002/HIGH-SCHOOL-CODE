#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
#define repn(i,a,b) for(int i=(a); i<(b); ++i)
using namespace std;
//////

typedef pair<int, int> pii;
const
    int maxn=210;
int A, B, C, S;
pii f[maxn][maxn][maxn];
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
    fastscan(A); fastscan(B); fastscan(C); fastscan(S);
}
//////

void minimize(pii &x, pii y, int w)
{
    y.second+=w;
    if (y.second>=S) ++y.first, y.second=0;
    if (x<y) x=y;
}

void process()
{
    forn(i, 0, A)
        forn(j, 0, B)
            forn(k, 0, C)
            {
                if (i>0) minimize(f[i][j][k], f[i-1][j][k], 1);
                if (j>0) minimize(f[i][j][k], f[i][j-1][k], 2);
                if (k>0) minimize(f[i][j][k], f[i][j][k-1], 3);
            }
    cout << f[A][B][C].first;
}
//////

int main()
{
    freopen("sp.inp", "r", stdin);
    freopen("sp.out", "w", stdout);
    enter();
    process();
}
