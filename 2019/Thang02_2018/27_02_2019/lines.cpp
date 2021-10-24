#include <iostream>
#include <stdio.h>

#define _x first
#define _y second

using namespace std;
//////

typedef pair<long long ,long long> pll;
const
    int maxn=1e5+100;
int n;
pll a[maxn], b[maxn];
//////

void enter()
{
    scanf("%d\n", &n);
    for (int i=1; i<=n; i++)
        scanf("%lld%lld%lld%lld", &a[i]._x, &a[i]._y, &b[i]._x, &b[i]._y);
}
//////

int vttd(pll p, pll d, pll c)
{
    long long s=(d._x-p._x)*(d._y+p._y)+(c._x-d._x)*(c._y+d._y)+(p._x-c._x)*(p._y+c._y);
    if (s>0) return 1; else
    if (s==0) return 0; else
    return -1;
}

bool indt(pll p, pll d, pll c)
{
    if (p._x<min(d._x, c._x) || p._x>max(d._x, c._x)) return 0;
    if (p._y<min(d._y, c._y) || p._y>max(d._y, c._y)) return 0;
    return 1;
}

int process()
{
    for (int i=1; i<=n; i++)
        for (int j=1; j<i; j++)
    {
        int x1=vttd(a[j], a[i], b[i]),
            y1=vttd(b[j], a[i], b[i]),
            x2=vttd(a[i], a[j], b[j]),
            y2=vttd(b[i], a[j], b[j]);
        if (x1*y1>0 || x2*y2>0) continue;
        bool ok=false;
        if (x1*y1<0 && x2*y2<0) ok=true;
        if (x1==0 && indt(a[j], a[i], b[i])) ok=true;
        if (x2==0 && indt(b[j], a[i], b[i])) ok=true;
        if (y1==0 && indt(a[i], a[j], b[j])) ok=true;
        if (y2==0 && indt(b[i], a[j], b[j])) ok=true;
        if (ok)
        {
            cout << j << ' ';
            return i;
        }
    }
    return -1;
}

int main()
{
    freopen("lines.inp", "r", stdin);
    freopen("lines.out", "w", stdout);
    enter();
    cout << process();
}
