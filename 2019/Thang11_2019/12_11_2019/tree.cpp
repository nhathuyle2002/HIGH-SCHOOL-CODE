#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
#define repn(i,a,b) for(int i=(a); i<(b); ++i)
using namespace std;
//////

const
    int maxn=1e3;
int n, m;
priority_queue<pair<int, int> > b[maxn+1];
vector<int> W[maxn+1];
int f[maxn+1];
//////

void fastscan(int &number)
{
    number=0;
    register char c=getchar();
    while (c<48 || c>57) c=getchar();
    for(; c>47 && c<58; c=getchar())
        number=number*10+c-48;
}

void maximize(int &x, int y) { if (x<y) x=y;}

void enter()
{
    fastscan(n); fastscan(m);
    forn(i, 1, n)
    {
        int c, v, w;
        fastscan(c); fastscan(v); fastscan(w);
        b[c].push({v, w});
    }
    forn(c, 1, maxn)
        forn(i, 1, maxn/c)
        {
            if (b[c].empty()) break;
            pair<int, int> p=b[c].top(); b[c].pop();
            W[c].push_back(p.first);
            p.first-=p.second;
            if (p.first>0) b[c].push(p);
        }
}
//////

void process()
{
    forn(sc, 0, maxn) f[sc]=0;
    forn(c, 1, maxn)
        for(int v : W[c])
            ford(sc, maxn, c) maximize(f[sc], f[sc-c]+v);
    forn(sc, 1, maxn) maximize(f[sc], f[sc-1]);

    while (m--)
    {
        int sc; fastscan(sc);
        cout << f[sc] << ' ';
    }
}
//////

int main()
{
    freopen("tree.inp", "r", stdin);
    freopen("tree.out", "w", stdout);
    enter();
    process();
}
