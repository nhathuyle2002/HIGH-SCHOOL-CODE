#include <iostream>
#include <stdio.h>

using namespace std;
////////

typedef unsigned long long ull;

int n, k, l;
int a[200010];
ull x, y;
////////

void enter()
{
    scanf("%d%d%d", &n, &k, &l);
    for (int i=1; i<=n; i++)
    {
        scanf("%d", &a[i]);
        a[i+n]=a[i];
    }
    scanf("%llu", &x);
}
////////

ull power(ull a, ull b, int base)
{
    if (a==0) return 0;
    return (power(a/2, b*2 % base, base)+a % 2*b) % base;
}

void process()
{
    y=abs(k-l);
    y=power(x, y, n);
    if (k>=l)
        for (int i=y+1; i<=y+n; i++) cout << a[i] << ' ';
    else
        for (int i=n-y+1; i<=n-y+n; i++) cout << a[i] << ' ';

}
////////

int main()
{
    freopen("clist.inp", "r" ,stdin);
    freopen("clist.out", "w", stdout);
    enter();
    process();
}
