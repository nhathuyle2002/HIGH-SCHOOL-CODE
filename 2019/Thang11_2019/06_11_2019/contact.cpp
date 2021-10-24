#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
#define repn(i,a,b) for(int i=(a); i<(b); ++i)
using namespace std;
//////

const
    int maxn=1e5+100, base=1e9+7;
int n, m;
vector<int> e[maxn];
int res;
//////

struct dsu
{
    int Lab[maxn];
    void create() { memset(Lab, -1, sizeof Lab);}
    int Getroot(int p)
    {
        if (Lab[p]<0) return p;
        return Lab[p]=Getroot(Lab[p]);
    }
    void Union(int x, int y)
    {
        if (x>n || y>n) return;
        int x0=Getroot(x), y0=Getroot(y);
        if (x0==y0) return;
        if (Lab[x0]>Lab[y0]) swap(x0, y0);
        Lab[x0]+=Lab[y0];
        Lab[y0]=x0;
    }
} b[17];
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
    forn(k, 0, 16) b[k].create();
    while (m--)
    {
        int u, v, delta;
        fastscan(u); fastscan(v); fastscan(delta);
        ford(k, 16, 0)
            if ((delta>>k)&1)
            {
                b[k].Union(u, v);
                u+= 1<<k; v+= 1<<k;
            }
    }
}
//////

void process()
{
    ford(k, 16, 1)
        forn(v, 1, n)
        {
            int u=b[k].Getroot(v);
            b[k-1].Union(u, v);
            int u2=u+(1<<(k-1)), v2=v+(1<<(k-1));
            b[k-1].Union(u2, v2);
        }
    res=1;
    forn(u, 1, n)
        if (b[0].Getroot(u)==u) res=res*2 % base;
    cout << res;
}
//////

int main()
{
    freopen("contact.inp", "r", stdin);
    freopen("contact.out", "w", stdout);
    enter();
    process();
}
