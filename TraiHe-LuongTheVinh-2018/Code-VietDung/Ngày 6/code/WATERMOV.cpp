#include <iostream>
#include <stdio.h>
#define For(i,a,b) for(int i=a; i<=b; i++)

using namespace std;
const int N = 1000100;
int a[N], d[N], r, n;
long long s[N], kq;

void nhap()
{
    freopen("WATERMOV.INP","r",stdin);
    freopen("WATERMOV.OUT","w",stdout);
    scanf("%d", &n);
    For(i,1,n)
    {
        scanf("%d", &a[i]);
        s[i] = s[i-1] + a[i];
    }
}
long long tinh(int l, int r)
{
    long long ans = (s[l] + s[r])*(l+1-r);
    For(i,l+1,r-1) ans+= s[i]*2;
    return ans;
}
void xuly()
{
    For(i,0,n)
    {
        while (r > 1 && (s[i] - s[d[r]])*(i-d[r-1]) < (s[i] - s[d[r-1]])*(i-d[r])) r--;
        d[++r] = i;
    }
    For(i,2,r) kq+= tinh(d[i-1], d[i]);
}

int main()
{
    nhap();
    xuly();
    printf("%lld.%lld", kq/2, (kq&1)*5);
    return 0;
}
