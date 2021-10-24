#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
using namespace std;
//////

const
    int maxn=5010;
const
    long long oo=1e15;
int n, k;
long long a[maxn];
long long f[maxn][maxn], gmax[3][maxn][maxn];
//////

void enter()
{
    scanf("%d%d\n", &n, &k);
    forn(i, 1, n) scanf("%lld", &a[i]);
}
//////

void process()
{
    forn(i, 1, n)
    {
        gmax[0][i][i]=a[i];
        gmax[1][i][i]=-oo;
        gmax[2][i][i]=-oo;
        forn(j, i+1, n)
        {
            gmax[2][i][j]=max(gmax[2][i][j-1], gmax[1][i][j-1]+a[j]);
            gmax[1][i][j]=max(gmax[1][i][j-1], gmax[0][i][j-1]-a[j]);
            gmax[0][i][j]=max(gmax[0][i][j-1], a[j]);
        }
    }

    forn(t, 0, k) f[0][t]=-oo;
    f[0][0]=0;
    forn(i, 1, n)
        forn(t, 0, k)
        {
            f[i][t]=f[i-1][t];
            if (t>0)
            ford(j, i-3, 3*(t-1))
                f[i][t]=max(f[i][t], f[j][t-1]+gmax[2][j+1][i]);
        }
    cout << f[n][k];
}
//////

int main()
{
    freopen("tkseq.inp", "r", stdin);
    freopen("tkseq.out", "w", stdout);
    enter();
    process();
}
