#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
#define repn(i,a,b) for(int i=(a); i<(b); ++i)
using namespace std;
//////

const
    int maxn=1e5+100;
int M, K, n, T;
int b[maxn];
long long res;
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
    fastscan(M); fastscan(K); fastscan(n); fastscan(T);
    if (M-n<K)
    {
        cout << -1;
        exit(0);
    }
    forn(i, 1, n) fastscan(b[i]);
    b[++n]=M+1;
    sort(b+1, b+n+1);
}
//////

void process()
{
    forn(i, 1, n)
        if (b[i]-i>=K)
        {
            int pos=b[i-1]+K-(b[i-1]-(i-1));
            res=1LL*K*T+1LL*pos*(pos+1)/2;
            forn(j, 1, i-1) res-=b[j];
            cout << res;
            return;
        }
}
//////

int main()
{
    freopen("spasta.inp", "r", stdin);
    freopen("spasta.out", "w", stdout);
    enter();
    process();
}
