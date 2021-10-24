#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
using namespace std;
//////

const
    int maxn=1e5+100;
int n;
pair<int, int> a[maxn];
//////

void enter()
{
    scanf("%d\n", &n);
    forn(i, 1, n)
    {
        scanf("%d", &a[i].first);
        a[i].second=i;
    }
}
//////

void process()
{
    sort(a+1, a+n+1);
    forn(i, 1, n) cout << a[i].second << ' ';
}
//////

int main()
{
    freopen("stable.inp", "r", stdin);
    freopen("stable.out", "w", stdout);
    enter();
    process();
}
