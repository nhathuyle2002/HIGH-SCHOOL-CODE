#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
#define repn(i,a,b) for(int i=(a); i<(b); ++i)
using namespace std;
//////

struct edge
{
    int x, y, w;
};
const
    int maxn=1e5+100, oo=1e9;
int n, m, res;
vector<edge> e;
vector<int> pos_e[maxn];
int matchx[maxn], matchy[maxn], fx[maxn], fy[maxn];
int top, source[maxn];
bool d[maxn];
//////

void fastscan(int &number)
{
    number=0;
    char c=getchar();
    for(; c>47 && c<58; c=getchar())
        number=number*10+c-48;
}

void enter()
{
    fastscan(n); fastscan(m);
    forn(i, 1, m)
    {
        int u, v, c;
        fastscan(u); fastscan(v); fastscan(c);
        pos_e[u].push_back(e.size());
        e.push_back({u, v, c});
    }

    forn(u, 1, n) fx[u]=oo, fy[u]=oo;
    for(edge p : e) fx[p.x]=min(fx[p.x], p.w);
    for(edge p : e) fy[p.y]=min(fy[p.y], p.w-fx[p.x]);
}
//////

int getw(edge &p) { return p.w-fx[p.x]-fy[p.y]; }

bool FindPath(int u)
{
    int v;
    for(int pos : pos_e[u])
        if (d[v=e[pos].y] && getw(e[pos])==0)
        {
            d[v]=false;
            if (matchy[v]==0 || FindPath(matchy[v]))
            {
                matchx[u]=v;
                matchy[v]=u;
                return true;
            }
        }
    return false;
}

void SubX_AddY()
{
    int delta=oo;
    repn(i, 0, e.size())
        if ((matchx[e[i].x]==0 || !d[matchx[e[i].x]]) && d[e[i].y]) delta=min(delta, getw(e[i]));
    forn(u, 1, n) if (matchx[u]==0 || !d[matchx[u]]) fx[u]+=delta;
    forn(v, 1, n) if (!d[v]) fy[v]-=delta;
}

void process()
{
    for(edge p : e)
        if (getw(p)==0 && matchx[p.x]==0 && matchy[p.y]==0)
        {
            matchx[p.x]=p.y;
            matchy[p.y]=p.x;
        }

    top=0;
    forn(u, 1, n)
        if (matchx[u]==0) source[++top]=u;

    do
    {
        int oldtop=top;
        forn(u, 1, n) d[u]=true;
        ford(i, oldtop, 1)
            if (FindPath(source[i])) swap(source[i], source[top]), --top;
        if (oldtop==top) SubX_AddY();
    }
    while (top>0);

    res=0;
    forn(u, 1, n)
        for(int pos : pos_e[u])
            if (getw(e[pos])==0 && e[pos].y==matchx[u]) {res+=e[pos].w; break;};
    cout << res << '\n';
    forn(v, 1, n) cout << matchy[v] << ' ';
}
//////

int main()
{
    freopen("assign.inp", "r", stdin);
    freopen("assign.out", "w", stdout);
    enter();
    process();
}
