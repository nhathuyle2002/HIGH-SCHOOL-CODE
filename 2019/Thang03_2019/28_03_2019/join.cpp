#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); i++)
#define ford(i,a,b) for(int i=(a); i>=(b); i++)
using namespace std;
//////

const
    int maxn=152;
int n, m;
vector<int> e[maxn];
int cou, num[2];
bool d[maxn];
int f[maxn][maxn];
bool dd[maxn][maxn];
//////

void enter()
{
    scanf("%d%d\n", &n, &m);
    int cc=0;
    forn(i, 1, m)
    {
        int u, v; scanf("%d%d\n", &u, &v);
        if (!dd[u][v])
        {
            e[u].push_back(v);
            e[v].push_back(u);
            cc++;
            dd[u][v]=true; dd[v][u]=true;
        }
    }
    m=cc;
}
//////

void dfs(int u)
{
    d[u]=false; cou++;
    for(int v : e[u])
        if (d[v]) dfs(v);
}

bool calc(int x, int y)
{
    if (x+y==1) return false;
    if (x+y==2) return true;
    if (x+y==3) return false;
    if (f[x][y]!=-1) return f[x][y];
    bool rr=false;
    if (x>0) rr=rr || calc(x-1, y);
    if (y>1) rr=rr || (!calc(x+1, y-2));
    if (rr==false) f[x][y]=0; else f[x][y]=1;
    return rr;
}

void process()
{
    forn(u, 1, n) d[u]=true;
    m=-m;
    forn(u, 1, n)
        if (d[u])
        {
            cou=0; dfs(u);
            num[cou % 2]++;
            m+=cou*(cou-1)/2;
        }

    forn(u, 0, n)
        forn(v, 0, n)
            f[u][v]=-1;
    bool res=calc(num[0], num[1]);
    if (m % 2!=0) res=!res;

    if (num[0]+num[1]==1) res=false;
    if (num[0]+num[1]==2) res=true;
    if (res) cout << "Theodor"; else cout << "Maxim";
}
//////

int main()
{
    freopen("join.inp", "r", stdin);
    freopen("join.out", "w", stdout);
    enter();
    process();
}
