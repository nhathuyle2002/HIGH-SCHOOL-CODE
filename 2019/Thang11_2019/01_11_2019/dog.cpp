#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
#define repn(i,a,b) for(int i=(a); i<(b); ++i)
using namespace std;
//////

const
    int maxn=1e3+100, maxT=1e4+100;
int n, m, T;
vector<int> e[maxn];
int w[maxn], ans[maxn];
int tmin[maxn], d[maxn];
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
    fastscan(n);
    forn(i, 1, n) fastscan(w[i]);
    fastscan(m);
    forn(i, 1, m)
    {
        int u, v;
        fastscan(u); fastscan(v);
        e[u].push_back(v);
    }
    fastscan(T);
}
//////

void minimize(int &x, int y) { if (x>y) x=y;}

void process()
{
    forn(i, 1, n) tmin[i]=maxT;
    tmin[1]=0;
    forn(t, 0, T)
    {
        forn(i, 1, n) d[i]=maxT;
        forn(i, 1, n)
            if (tmin[i]==t)
            {
                ++ans[i];
                for(int j : e[i])
                    minimize(d[j], t+w[j]);
                d[i]=-1;
            }
        forn(i, 1, n)
            if (d[i]==-1) tmin[i]=maxT; else
            minimize(tmin[i], d[i]);
    }
    forn(i, 1, n) cout << ans[i] << '\n';
}
//////

int main()
{
    freopen("dog.inp", "r", stdin);
    freopen("dog.out", "w", stdout);
    enter();
    process();
}
