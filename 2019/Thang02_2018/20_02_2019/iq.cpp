#include <iostream>
#include <stdio.h>
#include <algorithm>

#define _x first
#define _p second

using namespace std;
///////

typedef pair<int, int> pii;
const
    int maxn=1e5+100;
int n;
pii a[maxn], b[maxn];
double a2[maxn];
int match[maxn];
///////

void enter()
{
    scanf("%d", &n);
    for (int i=1; i<=n; i++)
    {
        scanf("%d", &a[i]._x);
        a[i]._p=i;
    }
    sort(a+1, a+n+1);
    for (int i=1; i<=n; i++)
    {
        scanf("%d", &b[i]._x);
        b[i]._p=i;
    }
    sort(b+1, b+n+1);
    for (int i=1; i<=n; i++) a2[i]=sqrt((long long)(2)*a[i]._x*a[i]._x);
}
///////

void process()
{
    int l=1, r=n+1, mid;
    while (l<r)
    {
        mid=(l+r) >> 1;
        bool ok=1;
        for (int i=1; i<=mid; i++)
        if (a2[i]>b[i+n-mid]._x)
        {
            ok=0;
            break;
        }
        if (ok) l=mid+1; else r=mid;
    }
    for (int i=1; i<=l-1; i++) match[i]=b[i+n-l+1]._p;
    bool ok=1;
    for (int i=l; i<=n; i++)
    {
        if (a[i]._x<b[i-l+1]._x)
        {
            ok=0;
            break;
        }
        match[i]=b[i-l+1]._p;
    }
    if (!ok) cout << -1; else
    for (int i=1; i<=n; i++) cout << match[i] << ' ';
}
///////

int main()
{
    freopen("iq.inp", "r", stdin);
    freopen("iq.out", "w", stdout);
    enter();
    process();
}
