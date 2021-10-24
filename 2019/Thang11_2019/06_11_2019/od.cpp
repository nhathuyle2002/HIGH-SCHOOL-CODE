#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
#define repn(i,a,b) for(int i=(a); i<(b); ++i)
using namespace std;
//////

struct data
{
    int lab, sum;
};
const
    int maxn=1e5+100;
int n, m;
int X[maxn], Y[maxn], type[maxn];
map<int, data> MP;
//////

void fastscan(int &number)
{
    number=0;
    register char c=getchar();
    while (c<48 || c>57) c=getchar();
    for(; c>47 && c<58; c=getchar())
        number=number*10+c-48;
}

void enter()
{
    fastscan(n); fastscan(m);
    register char c;
    forn(i, 1, m)
    {
        fastscan(X[i]); fastscan(Y[i]); --X[i];
        c=getchar();
        if (c=='o') type[i]=1; else type[i]=0;
        for(; c>'a' && c<'z'; c=getchar());
    }
}
//////

int find_root(int p)
{
    int p2=MP[p].lab;
    if (p2<0) return p;
    int p3=find_root(p2);
    MP[p].lab=p3;
    MP[p].sum=MP[p].sum ^ MP[p2].sum;
    return p3;
}

void process()
{
    forn(i, 1, m)
    {
        if (MP.find(X[i])==MP.end()) MP[X[i]]={-1, 0};
        if (MP.find(Y[i])==MP.end()) MP[Y[i]]={-1, 0};
        int x0=find_root(X[i]), y0=find_root(Y[i]);
        if (x0==y0)
        {
            if ((MP[X[i]].sum ^ MP[Y[i]].sum) == type[i]) continue;
            cout << i-1;
            return;
        }
        else
        if (x0!=y0)
        {
            if (MP[x0].lab>MP[y0].lab) swap(x0, y0);
            MP[x0].lab+=MP[y0].lab;
            MP[y0].lab=x0;
            MP[y0].sum=MP[X[i]].sum ^ MP[Y[i]].sum ^ type[i];
        }
    }
    cout << m;
}
//////

int main()
{
    freopen("od.inp", "r", stdin);
    freopen("od.out", "w", stdout);
    enter();
    process();
}
