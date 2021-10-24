#include <iostream>
#include <stdio.h>
#include <vector>
#include <stack>
#include <algorithm>

#define for(i,a,b) for (int (i)=(a); (i)<=(b); (i)++)
#define pii pair<int,int>
#define fi first
#define se second

using namespace std;

const
    int maxn=1e5+100;

int n, m, q;
vector<int> e[maxn];
int cou, cou2, coutp;
int low[maxn], num[maxn], pa[maxn];
int id[maxn], posl[maxn], posr[maxn];
vector<pii> cau;
int khop[maxn];

bool cmp(pii x, pii y)
{
    if (x.fi!=y.fi) return x.fi<y.fi;
    return x.se<y.se;
}

void dfs(int u)
{
    id[u]=coutp;
    cou++; num[u]=cou; low[u]=cou;
    cou2++; posl[u]=cou2;
    for(i,0,int(e[u].size())-1)
    {
        int v=e[u][i];
        if (v==pa[u]) continue;
        if (pa[v]==0)
        {
            pa[v]=u;
            dfs(v);
            low[u]=min(low[u],low[v]);
        } else
        low[u]=min(low[u],num[v]);
    }
    cou2++; posr[u]=cou2;
}

bool In(int b, int a)
{
    return posl[a]<=posl[b] && posr[b]<=posr[a];
}

bool cdt1(int a, int b, int g1, int g2)
{
    if (id[a]!=id[b]) return 0;
    if (!binary_search(cau.begin(), cau.end(), make_pair(g1,g2), cmp)) return 0;
    if ((!In(a,g1) && In(b,g1)) || (!In(b,g1) && In(a,g1))) return 1;
    if ((!In(a,g2) && In(b,g2)) || (!In(b,g2) && In(a,g2))) return 1;
    return 0;
}

bool cdt2(int a, int b, int c)
{
    if (id[a]!=id[b]) return 0;
    if (khop[c]==0) return 0;
    if ((!In(a,c) && In(b,c)) || (!In(b,c) && In(a,c))) return 1;
    return 0;
}

void enter()
{
    scanf("%d%d", &n, &m);
    for(i,1,m)
    {
        int u,v;
        scanf("%d%d", &u, &v);
        e[u].push_back(v);
        e[v].push_back(u);
    }
}

void init()
{
    int child[maxn];
    for(u,1,n) pa[u]=0;
    coutp=0; cou=0; cou2=0;
    for(u,1,n)
        if (pa[u]==0)
        {
            coutp++;
            pa[u]=-1;
            dfs(u);
        }
    //int cc=0, kk=0;
    for(u,1,n)
        if (pa[u]!=-1 && low[u]>=num[u])
        {
            cau.push_back(make_pair(pa[u],u));
            cau.push_back(make_pair(u,pa[u]));
            //cc++;
        }
    sort(cau.begin(), cau.end(), cmp);
    for(u,1,n)
    {
        khop[u]=0;
        child[u]=0;
    }
    for(u,1,n)
        if (pa[u]!=-1) child[pa[u]]++;
    for(u,1,n)
        if (pa[u]!=-1)
        {
            int uu=pa[u];
            if ((pa[uu]==-1 && child[uu]>=2) || (pa[uu]!=-1 && low[u]>=num[uu])) khop[uu]=1;
        }
    /*for(u,1,n)
        if (khop[u]==1) kk++;*/
    //cout << kk << ' ' << cc;
}

void process()
{
    scanf("%d", &q);
    for(i,1,q)
    {
        int ms;
        scanf("%d", &ms);
        int a, b, g1, g2, c;
        bool ok;
        if (ms==1)
        {
            scanf("%d%d%d%d", &a, &b, &g1, &g2);
            ok=cdt1(a, b, g1, g2);
            if (!ok) cout << "yes"; else cout << "no";
        } else
        if (ms==2)
        {
            scanf("%d%d%d", &a, &b, &c);
            ok=cdt2(a, b, c);
            if (!ok) cout << "yes"; else cout << "no";
        }
        cout << '\n';
    }
}

int main()
{
    //freopen("nkpolice.inp", "r", stdin);
    //freopen("nkpolice.out", "w", stdout);
    enter();
    init();
    process();
    return 0;
}
