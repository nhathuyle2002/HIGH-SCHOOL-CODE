#include <iostream>
#include <stdio.h>
#define For(i,a,b) for(int i=a; i<=b; i++)

using namespace std;
const int N = 200100;
int n, a[N], d[N];
long long sum[N], kq, h;

void nhap()
{
    freopen("INCREASING.INP","r",stdin);
    freopen("INCREASING.OUT","w",stdout);
    scanf("%d%lld", &n, &h);
    For(i,1,n)
    {
        scanf("%d", &a[i]);
        sum[i] = sum[i-1] + a[i];
    }
}
void xuly()
{
    int l = 1, r = 0; kq = 1e18;
    For(i,1,n)
    {
        while (l <= r && d[r] - a[d[r]] > i - a[i]) r--;
        d[++r] = i;
        while (d[l] <= i-h) l++;
        if (i >= h && d[l] - a[d[l]] - i+h >= 0) kq = min(kq, (h*h+h)/2 - (sum[i] - sum[i-h]));
    }
}

int main()
{
    nhap();
    xuly();
    if (kq == 1e18) kq = -1;
    printf("%lld", kq);
    return 0;
}
