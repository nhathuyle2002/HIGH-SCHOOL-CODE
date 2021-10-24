#include <iostream>
#include <stdio.h>
#include <math.h>

using namespace std;
//////

const
    int maxn=1e6+100;
typedef long long LL;
typedef pair<int, int> pii;
int n, m, res;
LL R;
pii a[maxn], b[maxn];
//////

void enter()
{
    scanf("%d%d%lld\n", &n, &m, &R);
    R=R*R;
    for (int i=1; i<=n; i++)
        scanf("%d%d\n", &a[i].first, &a[i].second);
    for (int i=1; i<=m; i++)
        scanf("%d%d\n", &b[i].first, &b[i].second);
}
//////

void process()
{
    res=0;
    for (int i=1; i<=n; i++)
        for (int j=1; j<=m; j++)
    {
        LL d=1LL*(a[i].first-b[j].first)*(a[i].first-b[j].first)+1LL*(a[i].second-b[j].second)*(a[i].second-b[j].second);
        if (d<=R)
        {
            res++;
            break;
        }
    }
    cout << res;
}
//////

int main()
{
    freopen("spid.inp", "r", stdin);
    freopen("spid.out", "w", stdout);
    enter();
    process();
}
