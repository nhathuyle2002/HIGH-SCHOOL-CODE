#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
using namespace std;
//////

const
    int maxn=2e5+100;
int n, k;
long long a[maxn], sum[maxn];
deque<int> Q;
long long res;
//////

void enter()
{
    scanf("%d%d\n", &n, &k);
    sum[0]=0;
    forn(i, 1, n)
    {
        scanf("%lld", &a[i]);
        a[i]+=n-i;
        sum[i]=sum[i-1]+a[i];
    }
}
//////

void process()
{
    Q.clear();
    forn(i, 1, k-1)
    {
        while (!Q.empty() && a[Q.back()]<=a[i]) Q.pop_back();
        Q.push_back(i);
    }

    res=1e15;
    forn(i, k, n)
    {
        while (!Q.empty() && Q.front()<=i-k) Q.pop_front();
        while (!Q.empty() && a[Q.back()]<=a[i]) Q.pop_back();
        Q.push_back(i);
        if (a[Q.front()]<=k+n-i) res=min(res, 1LL*(k+n-i)*k-sum[i]+sum[i-k]);
    }

    if (res==1e15) cout << -1; else cout << res;
}
//////

int main()
{
    freopen("seq.inp", "r", stdin);
    freopen("seq.out", "w", stdout);
    enter();
    process();
}
