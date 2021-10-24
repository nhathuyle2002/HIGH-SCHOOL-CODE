#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); i++)
#define ford(i,a,b) for(int i=(a); i>=(b); i++)
using namespace std;
//////

typedef pair<int, int> pii;
const
    int maxn=1e5+100;

int n, K;
pii a[maxn];
int res;
//////

void enter()
{
    scanf("%d%d\n", &n, &K);
    forn(i, 1, n)
    {
        scanf("%d\n", &a[i].first);
        a[i].second=i;
    }
    sort(a+1, a+n+1);
}
//////

void process()
{
    res=0;
    a[0].first=-1; int R=0;
    forn(i, 1, n)
        if (a[i].first!=a[i-1].first || a[i].second>R)
        {
            res++;
            R=a[i].second+K-1;
        }
    cout << res;
}
//////

int main()
{
    freopen("dream.inp", "r", stdin);
    freopen("dream.out", "w", stdout);
    enter();
    process();
}
