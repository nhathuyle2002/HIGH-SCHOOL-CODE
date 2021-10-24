#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); i++)
#define repn(i,a,b) for(int i=(a); i<(b); i++)
using namespace std;
//////

const
    int maxn=5e5+100, oo=1e9+100;
int n;
pair<int, int> a[maxn];
long long sumb[maxn];
int min1[maxn], min2[maxn];
//////

void enter()
{
    scanf("%d\n", &n);
    forn(i, 1, n) scanf("%d%d\n", &a[i].second, &a[i].first);
    sort(a+1, a+n+1);
}
//////

void process()
{
    sumb[0]=0;
    min1[0]=oo;
    forn(i, 1, n)
    {
        sumb[i]=a[i].first+sumb[i-1];
        min1[i]=a[i].second-a[i].first;
        min1[i]=min(min1[i], min1[i-1]);
        min2[i]=a[i].second;
    }
    min2[n+1]=oo;
    for (int i=n; i>=1; i--) min2[i]=min(min2[i], min2[i+1]);
    forn(k, 0, n-1)
        cout << min(sumb[k+1]+min1[k], sumb[k]+min2[k+1]) << '\n';
}
//////

int main()
{
    freopen("popust.inp", "r", stdin);
    freopen("popust.out", "w", stdout);
    enter();
    process();
}
