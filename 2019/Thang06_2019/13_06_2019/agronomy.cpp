#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
#define F first
#define S second
using namespace std;
//////

typedef pair<int, int> pii;
struct edge
{
    int x, y;
    double w;
};
const
    int maxn=1e5+100;

int n, m;
long long res;
pii a[maxn];
edge pr_e[maxn];
vector<int> e[maxn];
int d[3][maxn];
bool ok[3];
int posL[3];
vector<int> Q;
//////

bool comp(edge x, edge y)
{
    return x.w<y.w;
}

void enter()
{
    scanf("%d%d\n", &n, &m);
    forn(i, 1, n) scanf("%d%d\n", &a[i].F, &a[i].S);

    forn(i, 1, m)
    {
        int u, v;
        scanf("%d%d\n", &u, &v);
        if (a[u]>a[v]) swap(u, v);

        double w;
        pii p={a[v].F-a[u].F, a[v].S-a[u].S};
        if (p.S==0) w=1e12; else w=double(p.F)/p.S;

        pr_e[i]={u, v, w};
        e[u].push_back(v);
        e[v].push_back(u);
    }

    sort(pr_e+1, pr_e+m+1, comp);
}
//////

int area(int x, int y, int z)
{
    int sum=(a[y].F-a[x].F)*(a[y].S+a[x].S)+(a[z].F-a[y].F)*(a[z].S+a[y].S)+(a[x].F-a[z].F)*(a[x].S+a[z].S);
    if (sum==0) return 0; else
    if (sum<0) return 1; else
    return 2;
}

void query()
{
    if (!Q.empty()) return;
    posL[1]=0, posL[2]=0;
    int l=Q[0], r=Q[1];

    forn(i, 0, Q.size()-1)
    {
        int u=Q[i];
        ok[1]=false; ok[2]=false;

        for(int v : e[u])
        {
            int k=area(v, l, r);
            if (k==0) continue;
            if (d[k][v]>0) ok[k]=true;
            d[k][v]++;
        }

        int min_pos=i;
        forn(k, 1, 2)
        if (ok[k])
        {
            res++;
            min_pos=min(min_pos, posL[k]);
            posL[k]=i;
        }

        forn(j, min_pos, i-1)
        {
            int u=Q[j];
            for(int v : e[u])
            {
                int k=area(v, l, r);
                if (j>=posL[k] && ok[k]) d[k][v]--;
            }
        }
    }

    forn(j, min(posL[1], posL[2]), Q.size()-1)
    {
        int u=Q[j];
        for(int v : e[u])
        {
            int k=area(v, l, r);
            d[k][v]=0;
        }
    }
}

void process()
{
    res=0;
    int L=1, R=1;
    while (L<=m)
    {
        while (R<=m && pr_e[L].w==pr_e[R].w) R++;
        Q.clear();
        Q.push_back(a[L].F);
        forn(i, L+1, R-1)
            if (a[i].F==a[i-1].S) Q.push_back(a[i].S); else
            {
                Q.push_back(a[i-1].S);
                query();
                Q.clear();
                Q.push_back(a[i].F);
            }
        if (!Q.empty()) query();
        L=R;
    }
    cout << res/3;
}
//////

int main()
{
    freopen("agronomy.inp", "r", stdin);
    freopen("agronomy.out", "w", stdout);
    enter();
    process();
}
