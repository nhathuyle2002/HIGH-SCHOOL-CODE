#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
using namespace std;
//////

const
    int maxn=1e5+100;
int n, k;
int a[maxn];
long long f1[maxn], sum[maxn], f2[maxn];
long long res;
//////

void enter()
{
    scanf("%d%d\n", &n, &k);
    sum[0]=0;
    forn(i, 1, n)
    {
        scanf("%d", &a[i]);
        sum[i]=sum[i-1]+a[i];
    }
    forn(i, k, n) f1[i]=max(f1[i-1], sum[i]-sum[i-k]);
    ford(i, n-k+1, k) f2[i]=max(f2[i+1], sum[i+k-1]-sum[i-1]);
}
//////

void process()
{
    res=1e15;
    forn(i, k, n)
    {
        long long sum1=sum[i]-sum[i-k];
        long long gmax=-1e15;
        if (i-k>=k) gmax=max(gmax, f1[i-k]);
        if (i+k<=n) gmax=max(gmax, f2[i+1]);
        if (sum1>=gmax) res=min(res, gmax);//sum1);
    }
    cout << res;
}
//////

int main()
{
    freopen("prizes.inp", "r", stdin);
    freopen("prizes.out", "w", stdout);
    enter();
    process();
}
