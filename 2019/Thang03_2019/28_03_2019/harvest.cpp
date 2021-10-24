#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); i++)
#define repn(i,a,b) for(int i=(a); i<(b); i++)
using namespace std;
//////

const
    int maxn=1e5+100;
const
    double PI=atan(1)*4;
int n, L, k;
pair<int, int> a[maxn];
double s;
long long sum[maxn];
long long res;
//////

void enter()
{
    scanf("%d%d%d\n", &n, &L, &k);
    forn(i, 1, n) scanf("%d", &a[i].first); scanf("\n");
    forn(i, 1, n) scanf("%d", &a[i].second);
    sort(a+1, a+n+1);
    s=PI*k*k;
}
//////

void process()
{
    forn(i, 1, n) sum[i]=sum[i-1]+a[i].second;
    int j=0;
    res=0;
    forn(i, 1, n)
    {
        if (j<i-1) j=i-1;
        while (j<n && s+2LL*(a[j+1].first-a[i].first)<=L) j++;
        if (j>=i) res=max(res, sum[j]-sum[i-1]);
    }
    cout << res;
}
//////

int main()
{
    freopen("harvest.inp", "r", stdin);
    freopen("harvest.out", "w", stdout);
    enter();
    process();
}
