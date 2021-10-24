#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); i++)
#define repn(i,a,b) for(int i=(a); i<(b); i++)
using namespace std;
//////

const
    int maxn=1e5+100, maxlg=18;
int n, m;
vector<int> e[maxn];
int low[maxn], num[maxn], pa[maxn][maxlg+1];
int Time, tin[maxn], tout[maxn];
//////

void dfs(int u, int p)
{
    num[u]=++num[0]; low[u]=num[u];
    tin[u]=++Time;
    pa[u][0]=p;
    forn(i, 1, maxlg) pa[u][i]=pa[pa[u][i-1]][i-1];
    repn(i, 0, e[u].size())
    {
        int v=e[u][i];
        if (v==p) continue;
        if (num[v]==0)
        {
            dfs(v, u);
            low[u]=min(low[u], low[v]);
        } else
            low[u]=min(low[u], num[v]);
    }
    tout[u]=++Time;
}

void enter()
{
    scanf("%d%d\n", &n, &m);
    forn(i, 1, m)
    {
        int u, v;
        scanf("%d%d\n", &u, &v);
        e[u].push_back(v);
        e[v].push_back(u);
    }
    dfs(1, 0);
}
//////

bool in(int v, int u)
{
    return tin[u]<=tin[v] && tout[v]<=tout[u];
}

int find_PA(int u, int p)
{
    for(int i=maxlg; i>=0; i--)
    {
        int v=pa[u][i];
        if (v!=0 && v!=p && in(v, p)) u=v;
    }
    return u;
}

bool solve1(int A, int B, int G1, int G2)
{
    if (num[G1]>num[G2]) swap(G1, G2);
    if (pa[G2][0]!=G1) return true;
    if (low[G2]<=num[G1]) return true;
    if (in(A, G2)==in(B, G2)) return true;
    return false;
}

bool solve2(int A, int B, int C)
{
    if (num[A]>num[B]) swap(A, B);
    if (in(B, A))
    {
        if (in(C, A) && in(B, C))
        {
            B=find_PA(B, C);
            if (low[B]<num[C]) return true; else return false;
        }
        return true;
    }
    if (in(C, A) || in(C, B)) return true;
    if (in(A, C) && in(B, C))
    {
        A=find_PA(A, C); B=find_PA(B, C);
        if (A==B) return true;
        if (low[A]<num[C] && low[B]<num[C]) return true; else return false;
    }
    if (in(A, C) || in(B, C))
    {
        if (in(A, C)) swap(A, B);
        B=find_PA(B, C);
        if (low[B]<num[C]) return true; else return false;
    }
    return true;
}

void process()
{
    scanf("%d\n", &m);
    while (m--)
    {
        int ms, A, B, C, G1, G2;
        scanf("%d", &ms);
        if (ms==1)
        {
            scanf("%d%d%d%d\n", &A, &B, &G1, &G2);
            if (solve1(A, B, G1, G2)) cout << "yes"; else cout << "no";
        } else
        if (ms==2)
        {
            scanf("%d%d%d\n", &A, &B, &C);
            if (solve2(A, B, C)) cout << "yes"; else cout << "no";
        }
        cout << '\n';
    }
}

int main()
{
    freopen("criminal.inp", "r", stdin);
    freopen("criminal.out", "w", stdout);
    enter();
    process();
}
