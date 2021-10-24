#include <iostream>
#include <stdio.h>

using namespace std;

const
    int maxn=4010,
    maxm=400010,
    lgn=12;
int
    n,m,q;
int
    x[maxm], y[maxm], w[maxm];
int
    root[maxn], head[maxn], ke[maxn*2], link[maxn*2], ww[maxn*2];
int
    h[maxn];
int
    pa[maxn][lgn], fw[maxn][lgn];
long long
    res=0;

void enter()
{
    scanf("%d%d", &n, &m);
    for (int i=1; i<=m; i++)
    {
        scanf("%d%d%d", &x[i], &y[i], &w[i]);
    }
}

void qsort(int l, int r)
{
    if (l>=r) return;
    int i=l, j=r, tmp;
    int t=w[(r+l)/2];
    do
    {
        while (w[i]<t) i++;
        while (t<w[j]) j--;
        if (i<=j)
        {
            tmp=w[i]; w[i]=w[j]; w[j]=tmp;
            tmp=x[i]; x[i]=x[j]; x[j]=tmp;
            tmp=y[i]; y[i]=y[j]; y[j]=tmp;
            i++; j--;
        }
    }
    while (i<=j);
    qsort(l,j); qsort(i,r);
}

int findr(int p)
{
    while (root[p]!=p) p=root[p];
    return p;
}

void dfs(int u)
{
    int i=head[u];
    while (i!=0)
    {
        if (h[ke[i]]==0)
        {
            h[ke[i]]=h[u]+1;
            pa[ke[i]][0]=u;
            fw[ke[i]][0]=ww[i];
            dfs(ke[i]);
        }
        i=link[i];
    }
}

void init_kruscal()
{
    qsort(1,m);
    for (int i=1; i<=n; i++) root[i]=i;
    int cou=0;
    for (int i=1; i<=m; i++)
    {
        int x0=findr(x[i]), y0=findr(y[i]);
        if (x0!=y0)
        {
                res+=w[i];
                cou++;
                ke[cou*2]=y[i];
                ww[cou*2]=w[i];
                link[cou*2]=head[x[i]];
                head[x[i]]=cou*2;
                ke[cou*2+1]=x[i];
                ww[cou*2+1]=w[i];
                link[cou*2+1]=head[y[i]];
                head[y[i]]=cou*2+1;
        }
        if (cou>=n-1) break;
        root[x[i]]=x0; root[y[i]]=x0; root[y0]=x0;
    }
}

void init_lca()
{
    h[1]=1;
    dfs(1);
    for (int j=1; j<=lgn; j++)
        for (int i=1; i<=n; i++)
        {
            pa[i][j]=pa[pa[i][j-1]][j-1];
            fw[i][j]=max(fw[i][j-1], fw[pa[i][j-1]][j-1]);
        }
}

int lca(int u, int v)
{
    int rr=0;
    if (h[u]<h[v])
    {
        int tmp=u; u=v; v=tmp;
    }
    for (int j=lgn; j>=0; j--)
        if (h[pa[u][j]]<=h[v])
        {
            rr=max(rr, fw[u][j]);
            u=pa[u][j];
        }
    if (u==v) return rr;
    for (int j=lgn; j>=0; j--)
        if (pa[u][j]!=pa[v][j])
        {
            rr=max(rr, max(fw[u][j], fw[v][j]));
            u=pa[u][j]; v=pa[v][j];
        }
    rr=max(rr, max(fw[u][0], fw[v][0]));
    return rr;
}

void process()
{
    scanf("%d", &q);
    for (int i=1; i<=q; i++)
    {
        int s1,s2;
        scanf("%d%d", &s1, &s2);
        cout << res-lca(s1,s2) << endl;
    }
}

int main()
{
    //freopen("electric.inp", "r", stdin);
    //freopen("electric.out", "w", stdout);
    enter();
    init_kruscal();
    init_lca();
    process();
    return 0;
}
