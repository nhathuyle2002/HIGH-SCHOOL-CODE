#include <iostream>
#include <stdio.h>
#include <algorithm>

using namespace std;
///////

const   int maxn=5e4+100;
int n, m;
int d[maxn];
///////

void enter()
{
    int x;
    scanf("%d%d%d\n", &x, &n, &m);
    d[0]=0; d[n+1]=x;
    for (int i=1; i<=n; i++) scanf("%d\n", &d[i]);
    sort(d+1, d+n+1);
}
///////

void process()
{
    int l=0, r=d[n+1]+1;
    while (l<r)
    {
        int mid=(l+r)/2;
        int cou=0, ir=0;
        for (int i=1; i<=n+1; i++)
        {
            if (d[i]-d[ir]<mid) cou++; else
                ir=i;
        }
        if (cou<=m) l=mid+1; else r=mid;
    }
    cout << l-1;
}
///////

int main()
{
    freopen("rock.inp", "r", stdin);
    freopen("rock.out", "w", stdout);
    enter();
    process();
}
