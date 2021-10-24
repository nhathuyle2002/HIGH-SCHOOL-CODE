#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
#define repn(i,a,b) for(int i=(a); i<(b); ++i)
using namespace std;
//////

typedef pair<int, int> pii;
const
    int maxn=2e5+100;
int n;
pii a[maxn];
int bit[maxn], bit2[maxn];
long long res;
//////

bool compare(pii x, pii y)
{
    return x.second<y.second;
}

void enter()
{
    scanf("%d\n", &n);
    forn(i, 1, n)
    {
        scanf("%d%d\n", &a[i].first, &a[i].second);
        if (a[i].first>a[i].second) swap(a[i].first, a[i].second);
    }
    sort(a+1, a+n+1, compare);
}
//////

int query(int i)
{
    int ans=0;
    while (i>0)
    {
        ans+=bit[i];
        i-=i&(-i);
    }
    return ans;
}

void update(int i, int x)
{
    while (i<=2*n)
    {
        bit[i]+=x;
        i+=i&(-i);
    }
}

int query2(int i)
{
    int ans=0;
    while (i>0)
    {
        ans+=bit2[i];
        i-=i&(-i);
    }
    return ans;
}

void update2(int i, int x)
{
    while (i<=2*n)
    {
        bit2[i]+=x;
        i+=i&(-i);
    }
}

void process()
{
    res=0;
    int j=1;
    forn(i, 1, n)
    {
        for(; j<i; ++j)
            if (a[j].second<a[i].second) update(a[j].first, 1), update2(a[j].second, 1); else break;
        //int x1=query(a[i].first-1), x2=query2(a[i].first);
        res+=query(a[i].first-1)-query2(a[i].first);
    }
    cout << res;
}
//////

int main()
{
    freopen("chords.inp", "r", stdin);
    freopen("chords.out", "w", stdout);
    enter();
    process();
}
