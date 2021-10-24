#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
#define repn(i,a,b) for(int i=(a); i<(b); ++i)
using namespace std;
//////

typedef pair<int, int> pii;
const
    int maxn=1e5+100, oo=1e8;
int n, m, res[2];
int type[maxn];
vector<int> e[maxn];
int d[maxn];
deque<int> Q, Q2;
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
    forn(i, 1, n)
    {
        type[i]=getchar();
        if (type[i]=='G') type[i]=0; else type[i]=1;
    }
    int u, v;
    while (m--)
    {
        fastscan(u); fastscan(v);
        e[u].push_back(v);
        e[v].push_back(u);
    }
}
//////

void bfs(int S)
{
    forn(u, 1, n) d[u]=oo;
    d[S]=0;
    Q.clear(); Q.push_back(S);
    Q2.clear();
    while (!Q.empty())
    {
        int u=Q.front(); Q.pop_front();
        for(int v : e[u])
        {
            if (d[v]!=oo) continue;
            if (type[v]==type[S])
            {
                d[v]=d[u]+1;
                Q.push_back(v);
            } else
            if (type[v]!=type[S])
            {
                d[v]=d[u]+4;
                Q2.push_back(v);
            }
        }
        while (!Q2.empty() && (Q.empty() || d[Q2.front()]==d[Q.back()]))
        {
            Q.push_back(Q2.front());
            Q2.pop_front();
        }
    }
}

void process()
{
    res[0]=0; res[1]=0;
    forn(u, 1, n)
    {
        bfs(u);
        forn(v, u+1, n)
            if (type[v]==type[u]) res[type[u]]+=d[v];
    }
    cout << res[0] << ' ' << res[1];
}
//////

int main()
{
    freopen("gyalpha.inp", "r", stdin);
    freopen("gyalpha.out", "w", stdout);
    enter();
    process();
}
