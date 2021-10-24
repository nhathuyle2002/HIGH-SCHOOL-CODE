#include <iostream>
#include <stdio.h>

using namespace std;
///////

const int maxn=5010;
int n;
int a[maxn];
int f[maxn];
int ires, gres;
///////

void enter()
{
    scanf("%d\n", &n);
    for (int i=1; i<=n; i++) scanf("%d", &a[i]);
}
///////

void process()
{
    f[1]=0;
    for (int i=2; i<=n; i++)
    {
        f[i]=n+1;
        for (int j=1; j<i; j++)
            if (a[j]+(i-j)*(i-j+1)/2<=a[i])
            f[i]=min(f[i], f[j]+1);
    }
    ires=n+1; gres=int(1e9);
    for (int i=1; i<=n; i++)
        if (f[i]<n+1)
    {
        int g=a[i]+(n+1-i)*(n+2-i)/2;
        if (g<gres || (g==gres && f[i]<ires))
        {
            gres=g; ires=f[i];
        }
    }

    cout << gres << ' ' << ires;
}
///////

int main()
{
    freopen("horses.inp", "r", stdin);
    freopen("horses.out", "w", stdout);
    enter();
    process();
}
