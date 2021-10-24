#include <iostream>
#include <stdio.h>

#define forn(i,a,b) for (int i=(a); i<=(b); i++)
#define repn(i,a,b) for (int i=(a); i<=(b); i++)

using namespace std;
//////

const
    int maxn=510;
int m, n;
long long f[maxn][maxn];
long long res;
//////

void enter()
{
    scanf("%d%d\n", &m, &n);
    forn(i, 1, m) forn(j, 1, n)
    {
        scanf("%lld", &f[i][j]);
        f[i][j]+=f[i-1][j]+f[i][j-1]-f[i-1][j-1];
    }
}
//////

long long calc(int i2, int j2, int i1, int j1)
{
    return f[i2][j2]-f[i1-1][j2]-f[i2][j1-1]+f[i1-1][j1-1];
}

void process()
{
    res=-1e12;
    forn(y1, 1, n) forn(y2, y1, n)
    {
        long long min_sum=0;
        forn(x, 1, m)
        {
            long long sum=calc(x, y2, 1, y1);
            res=max(res, sum-min_sum);
            min_sum=min(min_sum, sum);
        }
    }
    cout << res;
}
//////

int main()
{
    freopen("mrect.inp", "r", stdin);
    freopen("mrect.out", "w", stdout);
    enter();
    process();
}
