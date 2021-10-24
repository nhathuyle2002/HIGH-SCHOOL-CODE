#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
#define repn(i,a,b) for(int i=(a); i<(b); ++i)
using namespace std;
//////

const
    int maxn=1e6+100;
int n, T;
char a[maxn];
int dmin[maxn], dmax[maxn];
long long maxs, mins;
//////

void enter()
{
    n=0;
    register char c=getchar();
    for(; c!=EOF && c!='\n' && c!=' '; c=getchar())
        a[++n]=c;
}

void not_exist()
{
    cout << "NIE";
    exit(0);
}
//////

void init()
{
    dmax[n+1]=0;
    ford(i, n, 1)
    {
        dmax[i]=dmax[i+1];
        if (a[i]=='+') dmax[i]--; else
        if (a[i]=='-') dmax[i]++; else
        if (a[i]=='0') ; else
        if (a[i]=='_') dmax[i]++;
    }

    dmin[n+1]=0;
    ford(i, n, 1)
    {
        dmin[i]=dmin[i+1];
        if (a[i]=='+') dmin[i]--; else
        if (a[i]=='-') dmin[i]++; else
        if (a[i]=='0') ; else
        if (a[i]=='_') dmin[i]--;
        if (dmin[i]<0) dmin[i]=0;
    }
}

void process_max()
{
    T=0; maxs=0;
    forn(i, 1, n)
    {
        if (a[i]=='+') ++T; else
        if (a[i]=='-') --T; else
        if (a[i]=='0') ; else
        if (a[i]=='_')
        {
            if (T+1<=dmax[i+1]) ++T; else
            if (T<=dmax[i+1]) ; else
            if (T-1<=dmax[i+1]) --T; else
            not_exist();
        }
        if (T<dmin[i+1]) not_exist();
        maxs+=T;
    }
}

void process_min()
{
    T=0; mins=0;
    forn(i, 1, n)
    {
        if (a[i]=='+') ++T; else
        if (a[i]=='-') --T; else
        if (a[i]=='0') ; else
        if (a[i]=='_')
        {
            if (T-1>=dmin[i+1]) --T; else
            if (T>=dmin[i+1]) ; else
            if (T+1>=dmin[i+1]) ++T; else
            not_exist();
        }
        if (T>dmax[i+1]) not_exist();
        mins+=T;
    }
}
//////

int main()
{
    freopen("pocketmoney.inp", "r", stdin);
    freopen("pocketmoney.out", "w", stdout);
    enter();
    init();
    process_max();
    process_min();
    cout << mins << ' ' << maxs;
}
