#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
#define F first
#define S second
using namespace std;
//////

const
    int maxn=1e5+100;
int n, k, res, pres;
pair<long long, int> a[maxn];
//////

void enter()
{
    scanf("%d%d\n", &n, &k);
    forn(i, 1, n)
    {
        scanf("%d", &a[i].F);
        a[i].F=a[i].F-k+a[i-1].F;
        a[i].S=i;
    }
    sort(a, a+n+1);
}
//////

void process()
{
    res=0;
    int L=0; a[n+1].F=1e15;
    forn(i, 0, n)
        if (a[i].F!=a[i+1].F)
        {
            if (res<=a[i].S-a[L].S)
            {
                if (res<a[i].S-a[L].S || pres>a[L].S) pres=a[L].S;
                res=a[i].S-a[L].S;
            }
            L=i+1;
        }
    if (res==0) cout << res; else
    cout << res << ' ' << pres+1;
}
//////

int main()
{
    freopen("cubics.inp", "r", stdin);
    freopen("cubics.out", "w", stdout);
    enter();
    process();
}
