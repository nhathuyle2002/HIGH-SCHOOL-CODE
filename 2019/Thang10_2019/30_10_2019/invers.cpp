#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
#define repn(i,a,b) for(int i=(a); i<(b); ++i)
using namespace std;
//////

const
    int maxn=5e5+100;
int n;
int a[maxn], bit[maxn];
long long res;
//////

void enter()
{
    scanf("%d\n", &n);
    forn(i, 1, n) scanf("%d", &a[i]);
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
    while (i<=n)
    {
        bit[i]+=x;
        i+=i&(-i);
    }
}

void process()
{
    res=0;
    ford(i, n, 1)
    {
        res+=query(a[i]-1);
        update(a[i], 1);
    }
    cout << res;
}
//////

int main()
{
    freopen("invers.inp", "r", stdin);
    freopen("invers.out", "w", stdout);
    enter();
    process();
}
