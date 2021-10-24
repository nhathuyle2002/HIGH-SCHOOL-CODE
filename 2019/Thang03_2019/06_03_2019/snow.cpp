#include <iostream>
#include <stdio.h>
#include <algorithm>

using namespace std;
//////

struct data
{
    int x, y, w;
    bool operator < (const data &A) const {return w<A.w;}
};
data make_data(int x, int y, int w)
{
    data r;
    r.x=x; r.y=y; r.w=w;
    return r;
}

const   int maxn=1e2+10, oo=1e9;
int n, k, m, typ;
int d[maxn][maxn];

data e[maxn*maxn];
int root[maxn];

int a[maxn], f[maxn];
bool dd[maxn], dd2[maxn];
long long res;
//////

void enter()
{
    scanf("%d%d%d%d\n", &n, &k, &m, &typ);

    for (int i=1; i<=n; i++)
        if (typ==1) dd[i]=false; else dd[i]=true;

    for (int i=1; i<=k; i++)
    {
        int x;
        scanf("%d", &x);
        if (typ==1) dd[x]=true; else dd[x]=false;
    }
    scanf("\n");
    if (typ==2) k=n-k;

    int k2=0;
    for (int i=1; i<=n; i++)
        if (dd[i])
        {
            k2++; a[k2]=i;
        }

    for (int i=1; i<=n; i++)
        for (int j=1; j<=n; j++)
            if (i==j) d[i][j]=0; else d[i][j]=oo;

    for (int i=1; i<=m; i++)
    {
        int u, v, c;
        scanf("%d%d%d\n", &u, &v, &c);
        d[u][v]=min(d[u][v], c);
        d[v][u]=d[u][v];
    }

    for (int t=1; t<=n; t++)
        for (int i=1; i<=n; i++)
            for (int j=1; j<=n; j++)
                d[i][j]=min(d[i][j], d[i][t]+d[t][j]);
}
//////

int findroot(int p)
{
    while (p!=root[p]) p=root[p];
    return p;
}

void kruscal()
{
    m=0;
    for (int i=1; i<=n; i++)
        for (int j=i+1; j<=n; j++)
            if (d[i][j]!=oo)
            {
                m++;
                e[m]=make_data(i, j, d[i][j]);
            }
    sort(e+1, e+m+1);

    for (int i=1; i<=n; i++) root[i]=i;
    res=0;

    int cou=0;
    for (int i=1; i<=m; i++)
    {
        int x0=findroot(e[i].x), y0=findroot(e[i].y);
        if (x0!=y0)
        {
            cou++;
            res+=e[i].w;
        }
        if (cou>=n-1) break;
        root[e[i].x]=x0; root[e[i].y]=x0; root[y0]=x0;
    }
}
//////

void process()
{
    res=oo;
    long long sum;

    for (int t=1; t<=n; t++)
    {
        sum=0;
        for (int i=1; i<=n; i++)
            if (dd[i]) sum+=d[t][i];
        res=min(res, sum);
    }

    for (int u=1; u<=n; u++)
        for (int v=u; v<=n; v++)
    {
        sum=d[u][v];
        for (int i=1; i<=n; i++) dd2[i]=true;
        dd2[u]=false; dd2[v]=false;

        int step=k;
        if (dd[u]) step--;
        if (v!=u && dd[v]) step--;

        while (step>0)
        {
            step--;
            int ir=0; f[0]=oo;
            for (int i=1; i<=k; i++)
                if (dd2[a[i]])
            {
                f[i]=oo;
                for (int j=1; j<=n; j++)
                    if (!dd2[j]) f[i]=min(f[i], d[j][a[i]]);
                if (f[i]<f[ir]) ir=i;
            }
            sum+=f[ir]; dd2[a[ir]]=false;
        }
        res=min(res, sum);
    }
}

//////

int main()
{
    freopen("snow.inp", "r", stdin);
    freopen("snow.out", "w", stdout);
    enter();
    if (k==1) res=0;
    else if (k==n) kruscal();
    else process();
    cout << res;
    //cout << ' ' << d[a[1]][a[2]];
}
