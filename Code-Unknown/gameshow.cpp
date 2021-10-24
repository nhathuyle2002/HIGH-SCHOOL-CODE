#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
using namespace std;
//////

const
    int maxn=5010;
int n;
long long T;
int c[maxn];
long long f[maxn][maxn], gmax[maxn];
//////

void enter()
{
    scanf("%d%lld\n", &n ,&T);
    forn(i, 1, n)
        scanf("%d", &c[i]);
}
//////

void process()
{
    forn(j, 0, n)
    {
        f[0][j]=-1;
        gmax[j]=-1;
    }
    f[0][0]=0;
    forn(i, 1, n)
        forn(j, 0, n)
        {
            f[i][j]=-1;
            if (j==0) continue;
            if (f[i-1][j-1]>-1) f[i][j]=max(f[i][j], f[i-1][j-1]+c[i]);
            gmax[j]-=T;
            if (gmax[j-1]>-1) f[i][j]=max(f[i][j], gmax[j-1]+c[i]);
            gmax[j]=max(gmax[j], f[i-1][j]);
        }
    int res=-1;
    forn(j, 0, n)
        if (f[n][j]>-1)
        {
            res=j;
            break;
        }
    cout << res;
}
//////

int main()
{
    freopen("gameshow.inp", "r", stdin);
    freopen("gameshow.out", "w", stdout);
    enter();
    process();
}
