#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); i++)
#define repn(i,a,b) for(int i=(a); i<(b); i++)
using namespace std;
//////

const
    int maxn=210, maxc=101;
int n, m, s, t;
int w[maxn][maxn], f[maxn][maxn], c[maxn][maxn];
int res;
int d[maxn], delta[maxn], trace[maxn];
//////

void enter()
{
    scanf("%d%d\n", &n, &m);
    s=0; t=n+m+1;
    res=0;
    int s1=0, s2=0;
    forn(i, 1, n)
    {
        scanf("%d", &w[s][i]);
        s1+=w[s][i];
    }
    forn(i, 1, m)
    {
        scanf("%d", &w[n+i][t]);
        s2+=w[n+i][t];
    }
    if (s1!=s2)
    {
        res=-1;
        return;
    }
    forn(i, 1, n)
        forn(j, n+1, n+m)
        {
            scanf("%d", &c[i][j]);
            c[j][i]=-c[i][j];
            w[i][j]=maxc;
        }
}
//////

bool findpath()
{
    forn(u, 0, t)
    {
        trace[u]=0;
        d[u]=maxc; delta[u]=0;
    }
    d[s]=0; delta[s]=maxc;
    int countloop=0, stop=0;
    while (++countloop<t && !stop)
    {
        stop=1;
        forn(u, 0, t)
            forn(v, 0, t)
                if (d[u]+c[u][v]<d[v] && w[u][v]-f[u][v]>0)
                {
                    stop=0;
                    d[v]=d[u]+c[u][v]; trace[v]=u;
                    delta[v]=min(delta[u], w[u][v]-f[u][v]);
                }
    }
    if (d[t]!=maxc) return true; else return false;
}

void incflow()
{
    int v=t, u=trace[v], dd=delta[t];
    while (v!=0)
    {
        f[u][v]+=dd; f[v][u]-=dd;
        v=u; u=trace[v];
    }
}

void process()
{
    if (res==-1)
    {
        cout << res;
        return;
    }
    while (true)
    {
        if (!findpath()) break;
        incflow();
    }
    res=0;
    forn(i, 1, n)
        forn(j, n+1, n+m)
            res+=c[i][j]*f[i][j];
    cout << res;
}

int main()
{
    freopen("warehouse.inp", "r", stdin);
    freopen("warehouse.out", "w", stdout);
    enter();
    process();
}
