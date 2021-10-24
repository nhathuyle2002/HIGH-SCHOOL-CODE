#include <iostream>
#include <stdio.h>

using namespace std;
//////

const
    int maxn=2e2;
int n;
int a[maxn], b[maxn];
//////

void enter()
{
    scanf("%d/n", &n);
    for (int i=1; i<=n; i++) scanf("%d", &a[i]);
}
//////

bool check()
{
    for (int i=1; i<=n; i++)
    if (b[i]!=0)
    {
        if (b[b[i]]==i) continue;
        if (b[b[i]]==0)
        {
            b[b[i]]=i;
            continue;
        }
        return 0;
    }
    for (int i=1; i<=n; i++)
    if (b[i]==0) b[i]=i;
    return 1;
}
//////

bool process()
{
    for (int i=n; i>=1; i--)
    {
        for (int j=1; j<=i-1; j++) b[j]=a[j];
        for (int j=i+1; j<=n; j++) b[j]=0;
        for (int j=a[i]+1; j<=n; j++)
        {
            b[i]=j;
            if (check()) return 1;
        }
    }
    return 0;
}
//////
int main()
{
    freopen("convol.inp", "r", stdin);
    freopen("convol.out", "w", stdout);
    enter();
    if (process())
    for (int i=1; i<=n; i++) cout << b[i] << ' ';
    else cout << -1;
}
