#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
using namespace std;
//////

const
    int maxd=55;
struct matrix
{
    int g[maxd][maxd];
};
int T, n, d;
int b[maxd], a[maxd];
matrix dd, dv;
//////

void enter()
{
    scanf("%d%d\n", &n, &d);
    forn(i, 1, d) scanf("%d", &b[d-i+1]);
    scanf("\n");
    forn(i, 0, maxd-1)
        forn(j, 0, maxd-1)
        {
            dd.g[i][j]=0;
            dv.g[i][j]=0;
        }
    forn(i, 1, d)
    {
        dv.g[i][i]=1;
        if (i<d) dd.g[i][i+1]=1; else
        {
            dd.g[d][1]=1;
            forn(j, 2, d) dd.g[d][j]=-1;
        }
    }
}
//////

matrix operator * (matrix a, matrix b)
{
    matrix c;
    forn(i, 0, maxd-1)
        forn(j, 0, maxd-1)
            c.g[i][j]=0;
    forn(i, 1, d)
        forn(j, 1, d)
            forn(k, 1, d)
                c.g[i][j]=(c.g[i][j]+a.g[i][k]*b.g[k][j]) % 3;
    return c;
}

matrix power(int b)
{
    if (b==0) return dv;
    matrix c=power(b>>1);
    c=c*c;
    if ((b&1)==1) c=c*dd;
    return c;
}

void process()
{
    matrix c=power(n-1);
    forn(i, 1, d)
    {
        a[i]=0;
        forn(j, 1, d)
            a[i]=(a[i]+c.g[i][j]*b[j]) % 3;
        if (a[i]<0) a[i]+=3;
    }
    ford(i, d, 1) cout << a[i] << ' ';
    cout << '\n';
}
//////

int main()
{
    freopen("recurr.inp", "r", stdin);
    freopen("recurr.out", "w", stdout);
    scanf("%d\n", &T);
    while (T--)
    {
        enter();
        process();
    }
}
