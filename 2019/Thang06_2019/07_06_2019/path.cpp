#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
using namespace std;
//////

const
    int maxn=1e5+100;
int n, m, minW;
vector<int> e[maxn];
bool d[maxn];
deque<int> Q;
//////

void enter()
{
    cin >> n >> m >> minW;
    forn(i, 1, m)
    {
        int u, v, w;
        scanf("%d%d%d\n", &u, &v, &w);
        if (w>=minW)
        {
            e[u].push_back(v);
            e[v].push_back(u);
        }
    }
}
//////

void process()
{
    Q.clear();
    forn(u, 1, n) d[u]=true;
    Q.push_back(1); d[1]=false;
    while (!Q.empty())
    {
        int u=Q.front(); Q.pop_front();
        for(int v : e[u])
            if (!d[v])
            {
                d[v]=true;
                Q.push_back(v);
            }
        if (d[n]) break;
    }
    if (d[n]) cout << "YES"; else cout << "NO";
}
//////

int main()
{
    freopen("path.inp", "r", stdin);
    freopen("path.out", "w", stdout);
    enter();
    process();
}
