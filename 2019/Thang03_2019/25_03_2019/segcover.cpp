#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); i++)
#define repn(i,a,b) for(int i=(a); i<(b); i++)
using namespace std;
//////

const
    int maxn=1e5+100;
int n, res;
pair<int, int> a[maxn];
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
    res=n;
    int minb=-1e9-100;
    forn(i, 1, n)
        if (a[i].second>=minb)
        {
            res--;
            minb=a[i].first;
        }
    cout << res;
}

int main()
{
    freopen("segcover.inp", "r", stdin);
    freopen("segcover.out", "w", stdout);
    enter();
    process();
}
