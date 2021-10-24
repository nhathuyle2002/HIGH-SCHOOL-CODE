#include <iostream>
#include <stdio.h>
#include <algorithm>

using namespace std;
//////

typedef pair<int, int> pii;
const
    int maxn=1e5+100;
int n;
pii a[maxn];
long long res;

bool comp1(pii x, pii y)
{
    if (x.first!=y.first) return x.first<y.first;
    return x.second<y.second;
}
bool comp2(pii x, pii y)
{
    if (x.second!=y.second) return x.second<y.second;
    return x.first<y.first;
}
//////

void enter()
{
    scanf("%d\n", &n);
    for (int i=1; i<=n; i++)
    {
        scanf("%d\n", &a[i].first);
        a[i].first+=i; a[i].second=i;
    }
}
//////

void process()
{
    long long s;
    for (int i=1; i<=n; i++)
        for (int j=i+1
             ; j<=min(n, i+100); j++)
        {
            s=1LL*(a[i].first-a[j].first)*(a[i].first-a[j].first)+1LL*(a[i].second-a[j].second)*(a[i].second-a[j].second);
            res=min(res, s);
        }
}
//////

int main()
{
    freopen("poison.inp", "r", stdin);
    freopen("poison.out", "w", stdout);
    enter();
    res=1e17;
    sort(a+1, a+n+1, comp1); process();
    sort(a+1, a+n+1, comp2); process();
    cout << res;
}
