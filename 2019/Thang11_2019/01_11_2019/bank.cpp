#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
#define repn(i,a,b) for(int i=(a); i<(b); ++i)
using namespace std;
//////

const
    int maxn=1e5+100, maxt=50;
int n, T, res;
pair<int, int> a[maxn];
bool d[maxn];
//////

void fastscan(int &number)
{
    number=0;
    register char c=getchar();
    bool negative=false;
    if (c=='-') negative=true, c=getchar();
    for(; c>47 && c<58; c=getchar())
        number=number*10+c-48;
    if (negative) number=-number;
}

void enter()
{
    fastscan(n); fastscan(T);
    forn(i, 1, n) fastscan(a[i].first), fastscan(a[i].second);
}
//////

void process()
{
    forn(i, 1, n) d[i]=true;
    a[0].first=0;
    res=0;
    ford(t, T, 0)
    {
        int imax=0;
        forn(i, 1, n)
            if (a[i].second>=t && d[i] && a[i].first>a[imax].first) imax=i;
        res+=a[imax].first; d[imax]=false;
    }
    cout << res;
}
//////

int main()
{
    freopen("bank.inp", "r", stdin);
    freopen("bank.out", "w", stdout);
    enter();
    process();
}
