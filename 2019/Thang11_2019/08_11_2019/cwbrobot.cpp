#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
#define repn(i,a,b) for(int i=(a); i<(b); ++i)
using namespace std;
//////

typedef pair<int, int> pii;
const
    int maxn=1e5+100, maxn2=210;
int n, m, nd, res;
int a[maxn], W[30], dd[30];
int f[maxn2][4][4][4];
int s[1 << 10], g[maxn2][1 << 10];
int nex[maxn];
set<pii> Q;
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
    fastscan(n); fastscan(m); fastscan(nd);
    forn(i, 1, n) a[i]=getchar()-'a'+1;
    forn(i, 1, nd) fastscan(W[i]);
}
//////

int getb(int x, int i)
{
    return (x >> i-1) & 1;
}

int daob(int x, int i)
{
    return x ^ (1 << i-1);
}

void maximize(int &x, int y) {if (x<y) x=y;}
//////

void sub1()
{
    repn(x, 1, 1 << n)
    {
        int cou=0, s=0;
        forn(i, 1, nd) dd[i]=0;
        forn(i, 1, n)
        {
            if (dd[a[i]]) ++cou, s-=W[a[i]], dd[a[i]]=0;
            if (getb(x, i))
            {
                s+=W[a[i]];
                if (s>m) break;
                dd[a[i]]=1;
            }
        }
        if (s<=m && cou>res) res=cou;
    }
}
//////

void sub2()
{
    forn(i, 0, n)
        forn(x, 0, m)
            forn(y, 0, m)
                forn(z, 0, m)
                    f[i][x][y][z]=-maxn;
    f[0][0][0][0]=0;
    forn(i, 1, n)
        forn(x, 0, m)
            forn(y, 0, m)
                forn(z, 0, m)
                if (W[x]+W[y]+W[z]>m) continue; else
                {
                    f[i][x][y][z]=f[i-1][x][y][z];

                    if (x==0) maximize(f[i][0][y][z], f[i-1][a[i]][y][z]+1);
                    if (y==0) maximize(f[i][x][0][z], f[i-1][x][a[i]][z]+1);
                    if (z==0) maximize(f[i][x][y][0], f[i-1][x][y][a[i]]+1);

                    if (x==a[i])
                    {
                        maximize(f[i][x][y][z], f[i-1][0][y][z]);
                        maximize(f[i][x][y][z], f[i-1][x][y][z]+1);
                    }
                    if (y==a[i])
                    {
                        maximize(f[i][x][y][z], f[i-1][x][0][z]);
                        maximize(f[i][x][y][z], f[i-1][x][y][z]+1);
                    }
                    if (z==a[i])
                    {
                        maximize(f[i][x][y][z], f[i-1][x][y][0]);
                        maximize(f[i][x][y][z], f[i][x][y][z]+1);
                    }
                }
    forn(x, 0, m)
        forn(y, 0, m)
            forn(z, 0, m) maximize(res, f[n][x][y][z]);
}
//////

void sub3()
{
    repn(x, 0, 1 << nd)
    {
        s[x]=0;
        forn(i, 1, nd)
            if (getb(x, i))
            {
                s[x]+=s[daob(x, i)]+W[i];
                break;
            }
    }
    forn(i, 0, n)
        repn(x, 0, 1 << nd)
            g[i][x]=-maxn;

    g[0][0]=0;
    forn(i, 1, n)
        repn(x, 0, 1 << nd)
            if (s[x]>m) continue; else
            {
                g[i][x]=g[i-1][x];
                if (getb(x, a[i]))
                {
                    maximize(g[i][x], g[i-1][x]+1);
                    maximize(g[i][x], g[i-1][daob(x, a[i])]);
                }
                else
                {
                    // bit a[i] cua x la 0
                    maximize(g[i][x], g[i-1][daob(x, a[i])]+1);
                }
            }
    repn(x, 0, 1 << nd)
        maximize(res, g[n][x]);
}
//////

void sub4()
{
    ford(i, n, 1)
    {
        nex[i]=dd[a[i]];
        dd[a[i]]=i;
    }

    int lim=m/W[1];
    Q.clear();
    forn(i, 1, n)
    {
        if (Q.find({-i, a[i]})!=Q.end())
        {
            Q.erase({-i, a[i]});
            ++res;
        }
        if (nex[i])
            Q.insert({-nex[i], a[i]});
        while (Q.size()>lim)
            Q.erase(Q.begin());
    }
}
//////

int main()
{
    freopen("cwbrobot.inp", "r", stdin);
    freopen("cwbrobot.out", "w", stdout);
    enter();
    res=0;
    if (n<=20) sub1(); else
    if (n>200) sub4(); else
    if (m<=3) sub2(); else
    if (nd<=10) sub3();
    cout << res;
}
