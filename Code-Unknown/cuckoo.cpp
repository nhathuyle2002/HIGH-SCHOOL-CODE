#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
using namespace std;
//////

const
    int maxn=2e5+100;
int n, m, T;
int root[maxn], child[maxn], h[maxn];
long long res;
//////

int find_root(int p)
{
    while (root[p]!=p) p=root[p];
    return p;
}

void del(int u)
{
    res-=1LL*child[u]*child[0]*2+1LL*child[u]*(child[u]-1);
    child[0]+=child[u];
}

bool add1(int x, int y)
{
    int x0=find_root(x), y0=find_root(y);
    if (x0==y0)
    {
        if (x0==0) return false;
        else return true;
    } else
    return true;
}

bool add2(int x, int y)
{
    int x0=find_root(x), y0=find_root(y);
    if (x0==y0)
    {
        if (x0==0)
        {
            root[x]=0; root[y]=0;
            return false;
        } else
        {
            del(x0);
            root[x]=0; root[y]=0; root[x0]=0; root[y0]=0;
            return true;
        }
    } else
    {
        if (x0==0)
        {
            del(y0);
            root[x]=0; root[y]=0; root[y0]=0;
        } else
        if (y0==0)
        {
            del(x0);
            root[x]=0; root[y]=0; root[x0]=0;
        } else
        {
            if (h[x0]>h[y0])
            {
                root[y0]=x0; root[x]=x0; root[y]=x0;
                child[x0]+=child[y0];
            } else
            {
                root[x0]=y0; root[x]=y0; root[y]=y0;
                child[y0]+=child[x0];
                h[y0]=max(h[y0], h[x0]+1);
            }
        }
        return true;
    }
}
//////

void enter()
{
    scanf("%d%d%d\n", &n, &m, &T);

    res=1LL*n*(n-1);
    forn(u, 0, n)
    {
        root[u]=u;
        child[u]=1;
        h[u]=1;
    }
    child[0]=0;

    forn(i, 1, m)
    {
        int u, v;
        scanf("%d%d\n", &u, &v);
        add2(u, v);
    }
}
//////

void process()
{
    while (T--)
    {
        int cs;
        scanf("%d", &cs);
        if (cs==3) cout << res; else
        {
            int u, v;
            scanf("%d%d", &u, &v);
            if (cs==1 && add1(u, v)) cout << "Yes";
            else if (cs==2 && add2(u, v)) cout << "Yes";
            else cout << "No";
        }
        scanf("\n"); cout << '\n';
    }
}
//////

int main()
{
    freopen("cuckoo.inp", "r", stdin);
    freopen("cuckoo.out", "w", stdout);
    enter();
    process();
}
