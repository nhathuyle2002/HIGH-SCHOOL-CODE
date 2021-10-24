#include <iostream>
#include <stdio.h>

using namespace std;
//////

const
    int maxn=1e6+100;
int n, k, l;
bool d[maxn];
//////

int main()
{
    freopen("coins.inp", "r", stdin);
    freopen("coins.out", "w", stdout);

    scanf("%d%d%d\n", &k, &l, &n);

    d[0]=false;
    for (int i=1; i<=maxn; i++)
    {
        d[i]=d[i-1];
        if (i>=k) d[i]&=d[i-k];
        if (i>=l) d[i]&=d[i-l];
        d[i]=!d[i];
    }

    for (int i=1; i<=n; i++)
    {
        int x;
        scanf("%d", &x);
        if (d[x]) cout << "A"; else cout << "B";
    }
}
