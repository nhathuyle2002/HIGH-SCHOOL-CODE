#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
using namespace std;
//////

const
    int maxn=1e5+100;
int n, delta;
pair<int, int> a[maxn];
int bit[maxn];
long long res[maxn];
//////

void enter()
{
    scanf("%d%d\n", &n, &delta);
    forn(i, 1, n)
    {
        scanf("%d\n", &a[i].first);
        a[i].second=i;
    }
    sort(a+1, a+n+1);
}
//////

void update(int i, int x)
{
    while (i<=n)
    {
        bit[i]+=x;
        i+=i & (-i);
    }
}

int query(int i)
{
    int rr=0;
    while (i>0)
    {
        rr+=bit[i];
        i-=i & (-i);
    }
    return rr;
}

void process()
{
    forn(i, 1, n) bit[i]=0;
    forn(tt, 1, n)
    {
        int i=a[tt].second;
        int L=i, R=n+1, mid, sum=query(i);
        res[i]=a[tt].first+1LL*delta*(sum+1);

        while (L<R)
        {
            mid=(L+R)/2;
            if (query(mid)==sum) L=mid+1; else R=mid;
        }

        if (i<L)
        {
            update(i, 1);
            update(L, -1);
        }
    }

    forn(i, 1, n) cout << res[i] << '\n';
}
//////

int main()
{
    freopen("right.inp", "r", stdin);
    freopen("right.out", "w", stdout);
    enter();
    process();
}
