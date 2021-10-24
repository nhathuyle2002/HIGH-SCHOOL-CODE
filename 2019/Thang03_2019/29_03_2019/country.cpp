#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); i++)
#define repn(i,a,b) for(int i=(a); i<(b); i++)
using namespace std;
//////

/*const
    int maxn=1010;
int n;
vector<int> e[maxn];
int cou, num[maxn], low[maxn];
bool avail[maxn];
stack<int> Q;
int numid, id[maxn], rr[maxn];
int res;
//////

void enter()
{
    scanf("%d\n", &n);
    forn(u, 1, n)
    {
        int sz; scanf("%d", &sz);
        forn(i, 1, sz)
        {
            int v; scanf("%d", &v);
            e[u].push_back(v);
        }
        scanf("\n");
    }
}
//////

void dfs(int u)
{
    num[u]=++cou; low[u]=cou;
    Q.push(u);
    repn(i, 0, e[u].size())
    {
        int v=e[u][i];
        if (num[v]==0)
        {
            dfs(v);
            low[u]=min(low[u], low[v]);
        } else
        if (avail[v])
            low[u]=min(low[u], num[v]);
    }
    if (low[u]==num[u])
    {
        numid++;
        int v=n+1;
        while (v!=u)
        {
            v=Q.top(); Q.pop();
            id[v]=numid; avail[v]=false;
        }
    }
}

void process()
{
    forn(u, 1, n)
    {
        num[u]=0; avail[u]=true;
    }
    cou=0; numid=0;
    forn(u, 1, n)
        if (num[u]==0) dfs(u);
    forn(u, 1, n)
        repn(i, 0, e[u].size())
        {
            int v=e[u][i];
            if (id[u]==id[v]) rr[id[u]]++;
        }
    res=0;
    forn(i, 1, numid) res=max(res, rr[i]);
    cout << res;
}
//////

int main()
{
    freopen("country.inp", "r", stdin);
    freopen("country.out", "w", stdout);
    enter();
    process();
}*/


const
    int maxn=1010;
int n;
vector<int> e[maxn];
int h[maxn], gm1, gm2, gm3;
int res;
//////

void enter()
{
    scanf("%d\n", &n);
    forn(u, 1, n)
    {
        int sz; scanf("%d", &sz);
        forn(i, 1, sz)
        {
            int v; scanf("%d", &v);
            e[u].push_back(v);
        }
        scanf("\n");
    }
}
//////

void dfs(int u)
{
    h[u]=1;
    repn(i, 0, e[u].size())
    {
        int v=e[u][i];
        if (h[v]==0)
        {
            dfs(v);
            h[u]=max(h[u], h[v]+1);
        }
    }
}

void process()
{
    res=0;
    forn(u, 1, n)
        //if (e[u].size()>=3)
        {
            forn(v, 1, n) h[v]=0; h[u]=-1;
            gm1=0; gm2=0; gm3=0;
            repn(i, 0, e[u].size())
            {
                int v=e[u][i];
                if (h[v]!=0) continue;
                dfs(v);
                if (h[v]>=gm1)
                {
                    gm3=gm2; gm2=gm1; gm1=h[v];
                } else
                if (h[v]>=gm2)
                {
                    gm3=gm2; gm2=h[v];
                } else
                if (h[v]>gm3)
                    gm3=h[v];
            }
            res=max(res, (gm1+gm2+gm3)*2);
        }
    cout << res;
}
//////

int main()
{
    freopen("country.inp", "r", stdin);
    freopen("country.out", "w", stdout);
    enter();
    process();
}
