#include <iostream>
#include <stdio.h>
#include <algorithm>

using namespace std;
///////

struct data
{
    int h, pos;
    bool operator < (const data &B) const
    {
        if (h!=B.h) return h<B.h;
        return pos<B.pos;
    }
};

const   int maxn=1e6+100;
int n, cou, res;
data a[maxn];
///////

void enter()
{
    scanf("%d\n", &n);
    for (int i=1; i<=n; i++)
    {
        scanf("%d", &a[i].h);
        a[i].pos=i;
    }
    sort(a+1, a+n+1);
}
///////

void process()
{
    a[0].pos=maxn; cou=0; res=0;
    for (int i=1; i<=n; i++)
    {
        if (a[i].pos>=a[i-1].pos) cou++; else cou=1;
        res=max(res, cou);
    }
    cout << n-res;
}
///////

int main()
{
    freopen("xh.inp", "r", stdin);
    freopen("xh.out", "w", stdout);
    enter();
    process();
}
