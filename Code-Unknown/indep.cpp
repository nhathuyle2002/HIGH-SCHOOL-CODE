#include <bits/stdc++.h>
#define forn(i, a, b) for (int i=(a); i<=(b); ++i)
#define ford(i, a, b) for (int i=(a); i>=(b); --i)
using namespace std;
//////

const
    int maxn=2e5+100;
char s[maxn];
stack<int> Q;
int n;
vector<int> e[maxn];
int f[maxn][2][2];
//////

void enter()
{
    scanf("%s", s+1);
    n=strlen(s+1);
    Q.push(1); Q.push(1);
    forn(i, 2, n)
    {
        int pos=Q.top(); Q.pop();
        e[pos].push_back(i);
        if (s[i]=='S' || s[i]=='P')
        {
            Q.push(i); Q.push(i);
        }
    }
}
//////

void dfs(int u)
{
    if (s[u]=='g')
    {
        f[u][0][0]=0;
        f[u][0][1]=1;
        f[u][1][0]=1;
        f[u][1][1]=0;
        return;
    }

    int u1=e[u][0], u2=e[u][1];
    dfs(u1); dfs(u2);

    if (s[u]=='S')
    {
        f[u][0][0]=max(f[u1][0][0]+f[u2][0][0], f[u1][0][1]+f[u2][1][0]-1);
        f[u][0][1]=max(f[u1][0][0]+f[u2][0][1], f[u1][0][1]+f[u2][1][1]-1);
        f[u][1][0]=max(f[u1][1][0]+f[u2][0][0], f[u1][1][1]+f[u2][1][0]-1);
        f[u][1][1]=max(f[u1][1][0]+f[u2][0][1], f[u1][1][1]+f[u2][1][1]-1);
    }
    else
    if (s[u]=='P')
    {
        f[u][0][0]=f[u1][0][0]+f[u2][0][0];
        f[u][0][1]=f[u1][0][1]+f[u2][0][1]-1;
        f[u][1][0]=f[u1][1][0]+f[u2][1][0]-1;
        f[u][1][1]=f[u1][1][1]+f[u2][1][1]-2;
    }
}

void process()
{
    dfs(1);
    cout << max(max(f[1][0][0], f[1][0][1]), max(f[1][1][0], f[1][1][1]));
}
//////

int main()
{
    freopen("indep.inp", "r", stdin);
    freopen("indep.out", "w", stdout);
    enter();
    process();
}
