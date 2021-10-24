#include <iostream>
#include <stdio.h>
#include <vector>

using namespace std;
//////

const
    int maxn=1e3+100;
int n, coutp;
vector<int> e[maxn];
int d[maxn];
vector<int> q1[maxn], q2[maxn];
bool f[maxn][maxn*2+1];
int id[maxn];
vector<int> r1, r2;
//////

void enter()
{
    scanf("%d", &n);
    int u, v;
    while (scanf("%d%d", &u, &v)>0)
    {
        e[u].push_back(v);
        e[v].push_back(u);
    }
}
//////

void dfs(int u)
{
    if (d[u]==1) q1[coutp].push_back(u); else q2[coutp].push_back(u);

    for (int i=0; i<e[u].size(); i++)
    {
        int v=e[u][i];
        if (d[v]!=0) continue;
        if (d[u]==1) d[v]=2; else d[v]=1;
        dfs(v);
    }
}
//////

void init()
{
    coutp=0;
    for (int i=1; i<=n; i++)
        if (d[i]==0)
        {
            coutp++;
            d[i]=1;
            dfs(i);
        }
}
//////

void process()
{
    f[0][maxn]=1;
    for (int i=1; i<=coutp; i++)
    {
        int x=q1[i].size()-q2[i].size();
        for (int j=0; j<=maxn*2; j++)
        {
            if (j-x>=0 && f[i-1][j-x]) f[i][j]=1;
            if (j+x<=maxn*2 && f[i-1][j+x]) f[i][j]=1;
        }
    }
    int j;
    for (int k=0; k<=n; k++)
    {
        if (f[coutp][maxn+k])
        {
            j=maxn+k;
            break;
        }
        if (f[coutp][maxn-k])
        {
            j=maxn-k;
            break;
        }
    }
    for (int i=coutp; i>=1; i--)
    {
        int x=q1[i].size()-q2[i].size();
        if (j-x>=0 && f[i-1][j-x])
        {
            j=j-x;
            id[i]=1;
        } else
        if (j+x<=maxn*2 && f[i-1][j+x])
        {
            j=j+x;
            id[i]=2;
        }
    }
    for (int i=1; i<=coutp; i++)
    if (id[i]==1)
    {
        for (int j=0; j<q1[i].size(); j++) r1.push_back(q1[i][j]);
        for (int j=0; j<q2[i].size(); j++) r2.push_back(q2[i][j]);
    } else
    if (id[i]==2)
    {
        for (int j=0; j<q2[i].size(); j++) r1.push_back(q2[i][j]);
        for (int j=0; j<q1[i].size(); j++) r2.push_back(q1[i][j]);
    }
}
//////

void print()
{
    cout << r1.size() << ' ' << r2.size() << '\n';
    for (int i=0; i<r1.size(); i++) cout << r1[i] << ' ';
    cout << '\n';
    for (int i=0; i<r2.size(); i++) cout << r2[i] << ' ';
}
//////

int main()
{
    freopen("meeting.inp", "r", stdin);
    freopen("meeting.out", "w", stdout);
    enter();
    init();
    process();
    print();
}
