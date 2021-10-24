#include <iostream>
#include <stdio.h>
#include <algorithm>

using namespace std;
//////

const   int maxn=1e5+100, base=1e9+9;
int n;
int a[maxn], p[maxn];
int bit[maxn];
int res;
//////

bool cmp(int x, int y)
{
    if (a[x]!=a[y]) return a[x]<a[y];
    return x<y;
}

void enter()
{
    scanf("%d\n", &n);
    int p2[maxn];
    for (int i=1; i<=n; i++)
    {
        scanf("%d\n", &a[i]);
        a[i]+=a[i-1];
        p2[i]=i;
    }
    sort(p2+1, p2+n+1, cmp);
    for (int i=1; i<=n; i++) p[p2[i]]=i;
}
//////

int query(int i)
{
    if (i<1) return 0;
    return (bit[i]+query(i-(i & (-i)))) % base;
}

void update(int i, int x)
{
    if (i>n) return ;
    bit[i]=(bit[i]+x) % base;
    update(i+(i & (-i)), x);
}

void process()
{
    for (int i=1; i<=n; i++)
    {
        int qq=query(p[i]);
        if (a[i]>=0) qq=(qq+1) % base;
        if (i==n) res=qq;
        else update(p[i], qq);
    }
    cout << res;
}
//////

int main()
{
    freopen("protest.inp", "r", stdin);
    freopen("protest.out", "w", stdout);
    enter();
    process();
}
