#include <iostream>
#include <stdio.h>

using namespace std;
///////

const
    int maxn=1e6+100;

int n;
int y[maxn], deg[maxn], d[maxn];
int cou;
int start[maxn], finish[maxn];
///////

void enter()
{
    scanf("%d\n", &n);
    for (int i=1; i<=n; i++)
    {
        scanf("%d", &y[i]);
        deg[y[i]]++;
    }
}
///////

void dfs(int i)
{
    d[i]=1;
    if (d[y[i]]==0) dfs(y[i]);
    else finish[cou]=i;
}

void process()
{
    for (int i=1; i<=n; i++)
    if (deg[i]==0)
    {
        cou++;
        start[cou]=i;
        dfs(i);
    }
    for (int i=1; i<=n; i++)
    if (d[i]==0)
    {
        cou++;
        start[cou]=i;
        dfs(i);
    }
    start[cou+1]=start[1];
    cout << cou << '\n';
    for (int i=1; i<=cou; i++)
        cout << finish[i] << ' ' << start[i+1] << '\n';
}
///////

int main()
{
    freopen("circle.inp", "r", stdin);
    freopen("circle.out", "w", stdout);
    enter();
    process();
}
