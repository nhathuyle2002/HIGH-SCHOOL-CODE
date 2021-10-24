#include <iostream>
#include <stdio.h>
#include <vector>
#include <algorithm>

using namespace std;
///////////

struct data
{
    int x, y, pos;
    data (int _x, int _y, int _pos)
    {
        x=_x; y=_y; pos=_pos;
    }
};
///////////

const
    int maxn=1e5+100, maxm=1e6+100;

int n, m;
vector<data> q1, q2, q3;
vector<int> res;
int cou, _cou;
int root[maxn], h[maxn], _root[maxn], _h[maxn];
///////////

void enter()
{
    scanf("%d%d", &n, &m);
    q1.clear();
    q2.clear();
    q3.clear();
    for (int i=1; i<=m; i++)
    {
        int x, y, z;
        scanf("%d%d%d", &x, &y, &z);
        if (z==1) q1.push_back(data(x, y, i)); else
        if (z==2) q2.push_back(data(x, y, i)); else
        if (z==3)
            q3.push_back(data(x, y, i));
    }
    res.clear();
    //cout << q3.size() << '\n';
}
//////////

int findroot(int x)
{
    while (root[x]!=x) x=root[x];
    return x;
}
///////////

void process()
{
    for (int i=1; i<=n; i++)
    {
        root[i]=i;
        h[i]=0;
    }
    cou=0;
    for (int i=0; i<q3.size(); i++)
    {
        data p=q3[i];
        if (cou==n-1)
        {
            res.push_back(p.pos);
            continue;
        }
        int u=findroot(p.x), v=findroot(p.y);
        if (u==v)
        {
            root[p.x]=u; root[p.y]=u;
            res.push_back(p.pos);
        } else
        if (h[u]>h[v])
        {
            root[p.x]=u; root[p.y]=u; root[v]=u;
            h[u]=max(h[u], h[v]+1);
            cou++;
        } else
        if (h[v]>=h[u])
        {
            root[p.x]=v; root[p.y]=v; root[u]=v;
            h[v]=max(h[v], h[u]+1);
            cou++;
        }
    }
}
//////////

bool process1()
{
    _cou=cou;
    for (int i=1; i<=n; i++)
    {
        _root[i]=root[i];
        _h[i]=h[i];
    }
    for (int i=0; i<q1.size(); i++)
    {
        data p=q1[i];
        if (cou==n-1)
        {
            res.push_back(p.pos);
            continue;
        }
        int u=findroot(p.x), v=findroot(p.y);
        if (u==v)
        {
            root[p.x]=u; root[p.y]=u;
            res.push_back(p.pos);
        } else
        if (h[u]>h[v])
        {
            root[p.x]=u; root[p.y]=u; root[v]=u;
            h[u]=max(h[u], h[v]+1);
            cou++;
        } else
        if (h[v]>=h[u])
        {
            root[p.x]=v; root[p.y]=v; root[u]=v;
            h[v]=max(h[v], h[u]+1);
            cou++;
        }
    }
    return cou==n-1;
}
////////////

bool process2()
{
    cou=_cou;
    for (int i=1; i<=n; i++)
    {
        root[i]=_root[i];
        h[i]=_h[i];
    }
    for (int i=0; i<q2.size(); i++)
    {
        data p=q2[i];
        if (cou==n-1)
        {
            res.push_back(p.pos);
            continue;
        }
        int u=findroot(p.x), v=findroot(p.y);
        if (u==v)
        {
            root[p.x]=u; root[p.y]=u;
            res.push_back(p.pos);
        } else
        if (h[u]>h[v])
        {
            root[p.x]=u; root[p.y]=u; root[v]=u;
            h[u]=max(h[u], h[v]+1);
            cou++;
        } else
        if (h[v]>=h[u])
        {
            root[p.x]=v; root[p.y]=v; root[u]=v;
            h[v]=max(h[v], h[u]+1);
            cou++;
        }
    }
    return cou==n-1;
}
///////////

void print()
{
    sort(res.begin(), res.end());
    cout << res.size() << '\n';
    for (int i=0; i<res.size(); i++)
        cout << res[i] << '\n';
}

int main()
{
    freopen("nreduce.inp", "r", stdin);
    freopen("nreduce.out", "w", stdout);
    enter();
    process();
    if (!process1() || !process2()) cout << -1; else
    print();
}
