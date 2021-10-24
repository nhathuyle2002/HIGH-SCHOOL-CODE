#include <iostream>
#include <stdio.h>
#include <algorithm>

using namespace std;
//////

const
    int maxn=1e3+10, maxg=1e5+100, base=1e9+13;

int n, m, res, l1, l2;
long long a[maxn], b[maxn];
long long h[maxg];
pair<long long, int> c[maxn], d[maxn];
//////

void enter()
{
    h[0]=1;
    for (int i=1; i<maxg; i++) h[i]=(h[i-1]*maxg+1) % base;

    scanf("%d\n", &n);
    for (int i=1; i<=n; i++)
    {
        scanf("%lld", &a[i]);
        a[i]=(a[i-1]+h[a[i]]) % base;
    }
    scanf("%d\n", &m);
    for (int i=1; i<=m; i++)
    {
        scanf("%lld", &b[i]);
        b[i]=(b[i-1]+h[b[i]]) % base;
    }
}
//////

void process()
{
    l1=-1; l2=-1; res=0;
    for (int k=min(n, m); k>0; k--)
    {
        for (int i=k; i<=n; i++)
        {
            c[i-k+1].first=(a[i]-a[i-k]+base) % base;
            c[i-k+1].second=i-k+1;
        }

        for (int j=k; j<=m; j++)
        {
            d[j-k+1].first=(b[j]-b[j-k]+base) % base;
            d[j-k+1].second=j-k+1;
        }

        sort(c+1, c+n-k+2);
        sort(d+1, d+m-k+2);

        for (int i=1; i<=n-k+1; i++)
        {
            pair<long long, int> pp=c[i];
            pp.second=0;
            int j=lower_bound(d+1, d+m-k+2, pp)-d;
            if (j<=m-k+1 && c[i].first==d[j].first)
            {
                l1=c[i].second;
                l2=d[j].second;
                res=k;
                return;
            }
        }
    }
}
//////

int main()
{
    freopen("similarity.inp", "r", stdin);
    freopen("similarity.out", "w", stdout);
    enter();
    process();
    cout << res << ' ' << l1 << ' ' << l2;
}
