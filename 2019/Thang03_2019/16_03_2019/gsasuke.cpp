#include <iostream>
#include <stdio.h>
#include <math.h>

using namespace std;
//////

const
    int maxn=1e5+100;
int n;
long long h[maxn], f[maxn];
//////

void enter()
{
    scanf("%d\n", &n);
    for (int i=1; i<=n; i++) scanf("%lld", &h[i]);
}
//////

void process()
{
    f[1]=h[1];
    f[2]=f[1]+abs(h[2]-h[1]);
    for (int i=3; i<=n; i++)
        f[i]=min(f[i-1]+abs(h[i]-h[i-1]), f[i-2]+2*abs(h[i]-h[i-2]));
    cout << f[n];
}

int main()
{
    freopen("gsasuke.inp", "r", stdin);
    freopen("gsasuke.out", "w", stdout);
    enter();
    process();
}
