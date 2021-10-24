#include <iostream>
#include <stdio.h>
#include <vector>
#define For(i,a,b) for(int i=a; i<=b; i++)

using namespace std;
const int N = 2000100;
int dd[N], s[N], kq, n, k, m, ma;
vector<int> uoc[N];

void nhap()
{
    freopen("EQUA.INP","r",stdin);
    freopen("EQUA.OUT","w",stdout);
    scanf("%d%d%d\n", &n, &k, &m);
    int c;
    For(i,1,k)
    {
        scanf("%d", &c);
        n-= c-1;
    }
    ma = max(n, k);
}
void snt()
{
    For(i,2,ma)
        if (!dd[i])
        {
            dd[i] = i;
            long long j = 1LL*i*i;
            while (j <= ma)
            {
                dd[j] = i;
                j+= i;
            }
        }
}
void ptich(int a, int v)
{
    while (a > 1)
    {
        int p = dd[a];
        s[p]+= v;
        a/= p;
    }
}
int lt(int a, int b)
{
    if (b == 0) return 1;
    int t = lt(a, b/2);
    t = 1LL*t*t % m;
    if (b % 2 == 1) t = 1LL*t*a % m;
    return t;
}
void xuly()
{
    For(i,k,n-1) ptich(i, 1);
    For(i,2,n-k) ptich(i, -1);
    kq = 1;
    For(i,2,ma)
        kq = 1LL*kq*lt(i, s[i]) % m;
}
int main()
{
    nhap();
    snt();
    xuly();
    printf("%d", kq);
}
