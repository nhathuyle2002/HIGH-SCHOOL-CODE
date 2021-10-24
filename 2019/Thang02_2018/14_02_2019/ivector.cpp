#include <iostream>
#include <stdio.h>

using namespace std;
//////////

const
    int maxn=1e5+100;

int n;
int a[maxn], b[maxn], bit[maxn];
//////////

void enter()
{
    scanf("%d", &n);
}
//////////

int quece(int i)
{
    if (i==0) return 0;
    return bit[i]+quece(i-(i & (-i)));
}
//////////

void update(int i, int x)
{
    if (i>n) return;
    bit[i]+=x;
    update(i+(i & (-i)), x);
}
//////////

void process1()
{
    for (int i=1; i<=n; i++) scanf("%d", &a[i]);
    for (int i=1; i<=n; i++) bit[i]=0;
    for (int i=1; i<=n; i++)
    {
        b[a[i]]=i-1-quece(a[i]);
        update(a[i], 1);
    }
    for (int i=1; i<=n; i++) cout << b[i] << ' ';
    cout << '\n';
}
//////////

void process2()
{
    for (int i=1; i<=n; i++) scanf("%d", &b[i]);
    for (int i=1; i<=n; i++) bit[i]=0;
    for (int i=1; i<=n; i++) update(i,1);
    for (int i=1; i<=n; i++)
    {
        int l=1, r=n+1, mid;
        while (l<r)
        {
            mid=(l+r)/2;
            int sum=quece(mid);
            if (quece(mid)<=b[i]) l=mid+1; else r=mid;
        }
        a[l]=i; update(l, -1);
    }
    for (int i=1; i<=n; i++) cout << a[i] << ' ';
}

int main()
{
    freopen("ivector.inp", "r", stdin);
    freopen("ivector.out", "w", stdout);
    enter();
    process1();
    process2();
}
