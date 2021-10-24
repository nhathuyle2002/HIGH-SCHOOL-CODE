#include <iostream>
#include <stdio.h>
#include <algorithm>
#include <math.h>

using namespace std;
//////

int n, q, n2;
struct data
{
    int l, r, pos;
    bool operator < (const data &A) const
    {
        if (l/n2!=A.l/n2) return l/n2<A.l/n2;
        return r<A.r;
    }
};
const
    int maxn=2e5+100, maxg=1e6+100;
int a[maxn];
data b[maxn];
int d[maxg];
long long sum, res[maxn];
//////

void enter()
{
    scanf("%d%d\n", &n, &q);
    n2=int(sqrt(n));
    for (int i=1; i<=n; i++) scanf("%d", &a[i]);
    scanf("\n");
    for (int i=1; i<=q; i++)
    {
        scanf("%d%d\n", &b[i].l, &b[i].r);
        b[i].pos=i;
    }
    sort(b+1, b+q+1);

}
//////

long long pow2(int a)
{
    return 1LL*a*a;
}

void PUSH(int i)
{
    d[a[i]]++;
    sum+=(pow2(d[a[i]])-pow2(d[a[i]]-1))*a[i];
}

void POP(int i)
{
    d[a[i]]--;
    sum-=(pow2(d[a[i]]+1)-pow2(d[a[i]]))*a[i];
}

void process()
{
    for (int i=0; i<maxg; i++) d[i]=0;
    int l=1, r=0;
    sum=0;
    for (int i=1; i<=q; i++)
    {
        while (l<b[i].l)
        {
            POP(l);
            l++;
        }
        while (l>b[i].l)
        {
            PUSH(l-1);
            l--;
        }
        while (r<b[i].r)
        {
            PUSH(r+1);
            r++;
        }
        while (r>b[i].r)
        {
            POP(r);
            r--;
        }
        res[b[i].pos]=sum;
    }
    for (int i=1; i<=q; i++)
        cout << res[i] << '\n';
}
//////

int main()
{
    freopen("powsub.inp", "r", stdin);
    freopen("powsub.out", "w", stdout);
    enter();
    process();
}
