#include <iostream>
#include <stdio.h>
#include <vector>
#include <string.h>

using namespace std;
///////

const
    int maxn=5e2+100;

int m, n;
char a[maxn][maxn], b[maxn][maxn];
int dx[maxn], dy[maxn];
bool ok;
vector<int> ot1, ot2;
///////

void enter()
{
    scanf("%d%d", &m, &n);
    for (int i=1; i<=m; i++)
        scanf("%s", a[i]+1);
    for (int i=1; i<=m; i++)
        scanf("%s", b[i]+1);
}
///////

void dfs(int u, int typ)
{
    if (typ==0)
    {
        for (int j=1; j<=n; j++)
        {
            int x;
            if (a[u][j]!=b[u][j]) x=1-dx[u]; else x=dx[u];
            if (dy[j]==-1)
            {
                dy[j]=x;
                dfs(j, 1);
            } else
            if (dy[j]!=x) ok=false;
            if (!ok) break;
        }
    } else
    if (typ==1)
    {
        for (int i=1; i<=m; i++)
        {
            int x;
            if (a[i][u]!=b[i][u]) x=1-dy[u]; else x=dy[u];
            if (dx[i]==-1)
            {
                dx[i]=x;
                dfs(i, 0);
            } else
            if (dx[i]!=x) ok=false;
            if (!ok) break;
        }
    }
}

void process()
{
    for (int i=1; i<=m; i++) dx[i]=-1;
    for (int j=1; j<=n; j++) dy[j]=-1;
    ok=true;
    dx[1]=0;
    dfs(1, 0);
    if (!ok) cout << -1; else
    {
        ot1.clear();
        for (int i=1; i<=m; i++)
            if (dx[i]==1) ot1.push_back(i);
        for (int j=1; j<=n; j++)
            if (dy[j]==1) ot1.push_back(-j);

        ot2.clear();
        for (int i=1; i<=m; i++)
            if (dx[i]==0) ot2.push_back(i);
        for (int j=1; j<=n; j++)
            if (dy[j]==0) ot2.push_back(-j);


        if (ot1.size()<ot2.size())
        {
            cout << ot1.size() << '\n';
            for (int i=0; i<ot1.size(); i++) cout << ot1[i] << ' ';
        } else
        {
            cout << ot2.size() << '\n';
            for (int i=0; i<ot2.size(); i++) cout << ot2[i] << ' ';
        }
    }
}
///////

int main()
{
    freopen("inverse.inp", "r", stdin);
    freopen("inverse.out", "w", stdout);
    enter();
    process();
}
