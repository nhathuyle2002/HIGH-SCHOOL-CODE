#include <iostream>
#include <stdio.h>
#include <algorithm>
#define For(i,a,b) for(int i=a; i<=b; i++)

using namespace std;
const int N = 100100;
int n, k, kq, a[N], l[N];
long long sum[N];

void nhap()
{
    freopen("SEQUENCE.INP","r",stdin);
    freopen("SEQUENCE.OUT","w",stdout);
    scanf("%d%d", &n, &k);
    For(i,1,n)
    {
        scanf("%d", &a[i]);
        sum[i] = sum[i-1] + a[i];
    }
}
int tinh(int l, int r)
{
    return (sum[r] - sum[l-1])/(r-l+1);
}
void xuly()
{
    For(i,1,n)
    {
        l[i] = i;
        while (l[i] > 1 && tinh(l[l[i]-1], i) >= tinh(l[i], i) ) l[i] = l[l[i]-1];
        if (sum[i] < k) continue;
        int t = upper_bound(sum+1, sum+1+n, sum[i]-k) - sum;
        if (l[i] <= t) kq = max(kq, tinh(l[i], i));
        else
        {
            while (t > 1 && tinh(l[t-1], i) >= tinh(t, i)) t = l[t-1];
            kq = max(kq, tinh(t, i));
        }
    }
}

int main()
{
    nhap();
    xuly();
    printf("%d", kq);
    return 0;
}
