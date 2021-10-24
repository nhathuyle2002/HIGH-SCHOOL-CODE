#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
#define repn(i,a,b) for(int i=(a); i<(b); ++i)
using namespace std;
//////

const
    int maxn=3e5+100, base=998244353;
int n, m;
vector<int> e[maxn];
int d[maxn], cou[2];
long long res;
//////

void fastscan(int &number)
{
    number=0;
    register char c=getchar();
    while (c!='-' && (c<48 || c>57)) c=getchar();
    bool negative=false;
    if (c=='-') negative=true, c=getchar();
    for(; c>47 && c<58; c=getchar())
        number=number*10+c-48;
    if (negative) number=-number;
}

void enter()
{
    fastscan(n); fastscan(m);
    while (m--)
    {
        int u, v;
        fastscan(u); fastscan(v);
        e[u].push_back(v);
        e[v].push_back(u);
    }
}
//////

bool dfs(int u, int typ)
{
    d[u]=typ; cou[typ]++;
    for(int v : e[u])
        if (d[v]!=-1 && d[v]!=1-typ) return false; else
        if (d[v]==-1 && !dfs(v, 1-typ)) return false;
    return true;
}

long long pow2(int m)
{
    if (m==0) return 1%base;
    long long c=pow2(m>>1);
    c=c*c % base;
    if (m&1) c=c*2%base;
    return c;
}

void process()
{
    forn(u, 1, n) d[u]=-1;
    res=1;
    forn(u, 1, n)
        if (d[u]==-1)
        {
            cou[0]=0; cou[1]=0;
            if (!dfs(u, 0))
            {
                cout << 0;
                return;
            }
            res=(res*(pow2(cou[0])+pow2(cou[1]))) % base;
        }
    cout << res;
}
//////

int main()
{
    freopen("bgraph.inp", "r", stdin);
    freopen("bgraph.out", "w", stdout);
    enter();
    process();
}
