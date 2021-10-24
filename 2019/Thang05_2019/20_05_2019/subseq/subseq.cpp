#include <bits/stdc++.h>
#define forn(i, a, b) for (int i=(a); i<=(b); ++i)
#define ford(i, a, b) for (int i=(a); i>=(b); --i)
using namespace std;
//////

const
    int maxn=1e6+100;
int n, k;
int a[maxn], gmin[maxn], gmax[maxn];
int res;
//////

void enter()
{
    scanf("%d%d\n", &n, &k);
    gmin[0]=0;
    gmax[0]=0;
    forn(i, 1, n)
    {
        scanf("%d\n", &a[i]);
        a[i]+=a[i-1];
        gmin[i]=min(gmin[i-1], a[i]);
        gmax[i]=max(gmax[i-1], a[i]);
    }
}
//////

void process()
{
    res=-1e9;
    forn(i, k, n)
        res=max(res, a[i]-gmin[i-k]);
    cout << res;
}
//////

int main()
{
    freopen("subseq.inp", "r", stdin);
    freopen("subseq.out", "w", stdout);
    enter();
    process();
}
