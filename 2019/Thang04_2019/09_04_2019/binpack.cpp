#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
using namespace std;
//////

const
    int maxn=1e6+10, maxn2=1e4+10, maxw=5e3+10;
int n, W, res;
int a[maxn];
int f[maxn2][maxw+1], g[maxn2][maxw+1];
//////

void enter()
{
    scanf("%d%d\n", &W, &n);
    forn(i, 1, n) scanf("%d", &a[i]);
}
//////

void process1()
{
    res=n+1;
    forn(x, 0, (1<<n)-1)
    {
        int w0=W, w1=W, cou=0;
        forn(i, 1, n)
            if ((x>>(i-1)&1)==0)
            {
                if (w0+a[i]<=W) w0+=a[i]; else
                {
                    w0=a[i]; ++cou;
                }
            } else
            {
                if (w1+a[i]<=W) w1+=a[i]; else
                {
                    w1=a[i]; ++cou;
                }
            }
        res=min(res, cou);
    }
    cout << res << '\n';
}
//////

void process2()
{
    int sum=0;
    forn(i, 1, n) sum+=a[i];
    res=sum/W;
    if (sum % W >0) ++res;
    cout << res << '\n';
}
//////

void process3()
{
    forn(i, 1, n)
        forn(j, 0, maxw)
            f[i][j]=n+1;
    f[1][a[1]]=1; g[1][a[1]]=W;
    forn(i, 1, n-1)
        forn(j, 0, maxw)
        if (f[i][j]<n+1)
        {
            int j2=j+a[i+1], del=0;
            if (j2>W)
            {
                j2=a[i+1], del=1;
            }
            if ((f[i][j]+del<f[i+1][j2]) || (f[i][j]+del==f[i+1][j2] && g[i][j]<g[i+1][j2]))
            {
                f[i+1][j2]=f[i][j]+del;
                g[i+1][j2]=g[i][j];
            }
            j2=g[i][j]+a[i+1]; del=0;
            if (j2>W)
            {
                j2=a[i+1]; del=1;
            }
            if ((f[i][j]+del<f[i+1][j]) || (f[i][j]+del==f[i+1][j] && j2<g[i+1][j]))
            {
                f[i+1][j]=f[i][j]+del;
                g[i+1][j]=j2;
            }
        }
    res=n+1;
    forn(j, 0, maxw) res=min(res, f[n][j]);
    cout << res;
}
//////

int main()
{
    freopen("binpack.inp", "r", stdin);
    freopen("binpack.out", "w", stdout);
    enter();
    if (n<=20) process1(); else
    if (n>10000) process2(); else
    process3();
}
