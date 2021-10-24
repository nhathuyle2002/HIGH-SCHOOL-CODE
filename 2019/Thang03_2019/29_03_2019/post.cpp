#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); i++)
#define repn(i,a,b) for(int i=(a); i<(b); i++)
using namespace std;
//////

const
    int maxn=310, maxk=33, oo=1e9;
int n, K;
int x[maxn], sum[maxn];
int f[maxn][maxk], trace[maxn][maxk];
int rr[maxn];
//////

void enter()
{
    scanf("%d%d\n", &n, &K);
    sum[0]=0;
    forn(i, 1, n)
    {
        scanf("%d", &x[i]);
        sum[i]=sum[i-1]+x[i];
    }
}
//////

int gsum(int l, int r)
{
    return sum[r]-sum[l-1];
}

void process()
{
    forn(i, 1, n) f[i][1]=(gsum(i, n)-x[i]*(n-i+1))+(x[i]*i-gsum(1, i));
    forn(k, 2, K)
        forn(i, k, n)
        {
            f[i][k]=oo;
            int j2=k-1;
            forn(j, k-1, i-1)
            {
                while (x[i]-x[j2]>x[j2]-x[j]) j2++;
                int s=-(gsum(j2, n)-x[j]*(n-j2+1))+(gsum(i, n)-x[i]*(n-i+1))+(x[i]*(i-j2+1)-gsum(j2, i));
                if (f[i][k]>f[j][k-1]+s)
                {
                    f[i][k]=f[j][k-1]+s;
                    trace[i][k]=j;
                }
            }
        }

    f[0][K]=oo; int ires=0;
    forn(i, K, n)
        if (f[i][K]<f[ires][K]) ires=i;
    cout << f[ires][K] << '\n';
    int k=K;
    while (k>0)
    {
        rr[k]=ires;
        ires=trace[ires][k];
        k--;
    }
    forn(i, 1, K) cout << x[rr[i]] << ' ';
}
//////

int main()
{
    freopen("post.inp", "r", stdin);
    freopen("post.out", "w", stdout);
    enter();
    process();
}
