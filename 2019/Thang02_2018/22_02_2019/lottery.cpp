#include <iostream>
#include <stdio.h>
#include <algorithm>
#include <vector>

using namespace std;
////////

const
    int maxn=1e6+100;
int n, x, cou;
int a[maxn];
long long res;
////////

void enter()
{
    scanf("%d%d\n", &n, &x);
    for (int i=1; i<=n; i++)
        scanf("%d\n", &a[i]);
    res=(long long)(1) *n *x;
    sort(a+1, a+n+1);
}
////////

void process()
{
    cou=n+1;
    for (int i=1; i<=n; i++)
    {
        int c=upper_bound(a+1, a+n+1, a[i])-lower_bound(a+1, a+n+1, a[i]);
        if (c<cou)
        {
            x=a[i];
            cou=c;
        } else
        if (c==cou && a[i]>x) x=a[i];
    }
    res=res-(long long)(1) *x *cou;
    cout << res;
}

int main()
{
    freopen("lottery.inp", "r", stdin);
    freopen("lottery.out", "w", stdout);
    enter();
    process();
}
