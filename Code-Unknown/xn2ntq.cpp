#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
using namespace std;
//////

const
    int maxn=2e6+200;

int prime[maxn], nex[maxn], cou, gmax;
int n, a[maxn], pp[maxn];
vector<int> e[maxn];
int match[maxn], dd[maxn];
int res, rx[maxn], ry[maxn];
//////

void init()
{
    prime[0]=1; prime[1]=1;
    forn(i, 2, maxn-1)
        if (prime[i]==0)
            forn(j, i, (maxn-1)/i) prime[i*j]=1;
    nex[maxn-1]=maxn-1;
    ford(i, maxn-2, 0)
        if (prime[i]==0) nex[i]=i;
        else nex[i]=nex[i+1];
}
//////

void enter()
{
    scanf("%d\n", &n);
    cou=0; gmax=0;
    forn(i, 1, n)
    {
        scanf("%d", &a[i]);
        gmax=max(gmax, a[i]);
        if (pp[a[i]]==0) cou++;
        pp[a[i]]=i;
    }
}
//////

void process1()
{
    res=0;
    int dem=n/2;
    while (res<dem)
    {
        int i=nex[n+1]-n, j=n;
        while (i<j)
        {
            res++;
            rx[res]=pp[i]; ry[res]=pp[j];
            i++; j--;
        }
        n=nex[n+1]-n-1;
    }
}
//////

bool dfs(int u)
{
    dd[u]=cou;
    for(int v : e[u])
        if (match[v]==0)
        {
            match[u]=v;
            match[v]=u;
            return true;
        } else
        if (dd[match[v]]<cou && dfs(match[v]))
        {
            match[u]=v;
            match[v]=u;
            return true;
        }
    return false;
}

void process2()
{
    forn(i, 1, n) e[i].clear();
    forn(i, 1, n)
        forn(j, i+1, n)
        if (a[i]!=1 && a[j]!=1 && prime[a[i]+a[j]]==0)
        {
            e[i].push_back(j);
            e[j].push_back(i);
            if (match[i]==0 && match[j]==0)
            {
                match[i]=j;
                match[j]=i;
            }
        }
    forn(i, 1, n) dd[i]=0;
    cou=0;
    forn(i, 1, n)
        if (match[i]==0 && a[i] % 2==1)
        {
            cou++;
            dfs(i);
        }
    forn(i, 1, n)
        if (a[i]>1 && prime[a[i]+1]==0) e[0].push_back(i);
    int bf=0;
    forn(i, 1, n)
        if (a[i]==1)
        {
            e[i]=e[0];
            cou++;
            if (!dfs(i))
            {
                if (bf==0) bf=i; else
                {
                    match[bf]=i;
                    match[i]=bf;
                    bf=0;
                }
            }
        }
    res=0;
    forn(i, 1, n)
        if (match[i]>0)
        {
            res++;
            rx[res]=i; ry[res]=match[i];
            match[match[i]]=0; match[i]=0;
        }
}
//////

void print()
{
    cout << res << '\n';
    forn(i, 1, res) cout << rx[i] << ' ' << ry[i] << '\n';
}
//////

int main()
{
    freopen("xn2ntq.inp", "r", stdin);
    freopen("xn2ntq.out", "w", stdout);
    init();
    enter();
    if (cou==n && gmax==n) process1();
    else process2();
    print();
}
