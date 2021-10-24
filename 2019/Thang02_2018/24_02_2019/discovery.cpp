#include <iostream>
#include <stdio.h>
#include <map>
#include <string.h>
#include <vector>
#include <queue>

#define _x first
#define _y second

using namespace std;
//////

typedef pair<int, int> pii;
const
    int maxn=1e6+100;

int ns;
char s[maxn];
map<pii, int> mp;

int n, start, finish;
pii a[maxn];
vector<int> e[maxn];
int trace[maxn];
queue<int> q;
//////

void enter()
{
    scanf("%s", s); ns =strlen(s);

    pii p=pii(0, 0);
    n=1; a[1]=p;
    mp[a[1]]=1; start=1;

    for (int i=0; i<ns; i++)
    {
        pii q=p;
        if (s[i]=='E') q._x++; else
        if (s[i]=='W') q._x--; else
        if (s[i]=='N') q._y++; else
        if (s[i]=='S') q._y--;

        if (mp.find(q)==mp.end())
        {
            n++; a[n]=q;
            mp[q]=n;
        }

        int e1=mp[p], e2=mp[q];
        if (i==ns-1) finish=e2;
        e[e1].push_back(e2);
        e[e2].push_back(e1);

        p=q;
    }
}
//////

void bfs()
{
    for (int i=1; i<=n; i++) trace[i]=0;
    q.push(finish);
    while (true)
    {
        int u=q.front(); q.pop();
        for (int i=0; i<e[u].size(); i++)
        {
            int v=e[u][i];
            if (trace[v]==0)
            {
                trace[v]=u;
                if (v==start) return;
                q.push(v);
            }
        }
    }
}
//////

void process()
{
    int cou=0;
    int u=start;
    while (u!=finish)
    {
        cou++;
        int v=trace[u];
        pii p=a[u], q=a[v];

        if (p._x+1==q._x) s[cou]='W'; else
        if (p._x-1==q._x) s[cou]='E'; else
        if (p._y+1==q._y) s[cou]='S'; else
        if (p._y-1==q._y) s[cou]='N';

        u=v;
    }
    for (int i=cou; i>0; i--) cout << s[i];
}
//////

int main()
{
    freopen("discovery.inp", "r", stdin);
    freopen("discovery.out", "w", stdout);
    enter();
    bfs();
    process();
}
