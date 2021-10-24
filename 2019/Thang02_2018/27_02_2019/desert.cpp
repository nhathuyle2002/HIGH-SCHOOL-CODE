#include <iostream>
#include <stdio.h>
#include <vector>

using namespace std;
///////

const
    int maxn=5e3+100;
int n;
int x[maxn], y[maxn];
int f[maxn], avail[maxn], trace[maxn];
vector<int> ot;
///////

void enter()
{
    scanf("%d\n", &n);
    for (int i=1; i<=n; i++)
        scanf("%d%d\n", &x[i], &y[i]);
}
///////

void process()
{
    for (int i=0; i<=n; i++)
    {
        f[i]=(int)(1e9);
        avail[i]=0;
        trace[i]=0;
    }
    f[1]=0;
    do
    {
        int u=0;
        for (int i=1; i<=n; i++)
            if (avail[i]==0 && f[i]<f[u]) u=i;
        avail[u]=1;
        if (u==0 || u==n) break;
        for (int i=1; i<=n; i++)
        {
            int dis=abs(x[i]-x[u])+abs(y[i]-y[u]);
            dis=max(dis, f[u]);
            if (dis<f[i])
            {
                f[i]=dis;
                trace[i]=u;
            }
        }

    }
    while (true);
    cout << f[n] << '\n';
    ot.clear();
    int i=n;
    while (i!=0)
    {
        ot.push_back(i);
        i=trace[i];
    }
    for (int i=int(ot.size())-1; i>=0; i--)
        cout << ot[i] << ' ';
}
///////

int main()
{
    freopen("desert.inp", "r", stdin);
    freopen("desert.out", "w", stdout);
    enter();
    process();
}
