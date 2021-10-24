#include <iostream>
#include <stdio.h>

using namespace std;
//////

const
    int maxn=1e5+100;
int n, m;
long long a[maxn], bit[maxn];
//////

void update(int i, long long x)
{
    if (i>n) return;
    bit[i]+=x;
    update(i+(i & (-i)), x);
}

void enter()
{
    scanf("%d%d\n", &n, &m);
    for (int i=1; i<=n; i++)
    {
        scanf("%lld", &a[i]);
        update(i, a[i]);
    }
    scanf("\n");
}
//////

long long query(int i)
{
    if (i<1) return 0;
    return bit[i]+query(i-(i & (-i)));
}

void process()
{
    for (int t=1; t<=m; t++)
    {
        char ms;
        int i, j;
        scanf("%c%d%d\n", &ms, &i, &j);
        if (ms=='Q') cout << query(j+1)-query(i) << '\n'; else
        {
            update(i+1, -a[i+1]+j);
            a[i+1]=j;
        }
    }
}
//////

int main()
{
    freopen("dayso.inp", "r", stdin);
    freopen("dayso.out", "w", stdout);
    enter();
    process();
}
