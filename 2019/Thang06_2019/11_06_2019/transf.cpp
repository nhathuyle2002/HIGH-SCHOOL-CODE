#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
using namespace std;
//////

const
    int maxn=200;
int n;
char a[maxn], b[maxn];
int c[maxn], d[maxn];
int f[maxn][maxn][4];
//////

void enter()
{
    scanf("%s\n", a+1);
    scanf("%s", b+1);
    n=strlen(a+1);

    d['A']=1; d['C']=2; d['G']=3; d['T']=4;

    forn(i, 1, n) c[i]=(d[b[i]]+4-d[a[i]]) % 4;
}
//////

void process()
{
    forn(i, 1, n)
        forn(k, 0, 3)
            if (c[i]==k) f[i][i][k]=0; else f[i][i][k]=1;

    forn(sl, 2, n)
        forn(i, 1, n-sl+1)
        {
            int j=i+sl-1, gmin=maxn;
            forn(k, 0, 3)
            {
                f[i][j][k]=maxn;
                forn(mid, i, j-1)
                    f[i][j][k]=min(f[i][j][k], f[i][mid][k]+f[mid+1][j][k]);
                gmin=min(gmin, f[i][j][k]);
            }

            forn(k, 0, 3)
                f[i][j][k]=min(f[i][j][k], gmin+1);
        }

    cout << f[1][n][0];
}
//////

int main()
{
    freopen("transf.inp", "r", stdin);
    freopen("transf.out", "w", stdout);
    enter();
    process();
}
