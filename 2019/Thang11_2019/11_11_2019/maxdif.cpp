#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
#define repn(i,a,b) for(int i=(a); i<(b); ++i)
using namespace std;
//////

const
    int maxn=1e5+100;
int n, K, res;
int a[maxn], f[maxn];
deque<int> Q;
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
    fastscan(n); fastscan(K);
    forn(i, 1, n) fastscan(a[i]);
    sort(a+1, a+n+1);
}
//////

void process()
{
    K=n-K-1;
    res=2e9;
    forn(i, 2, n)
    {
        while (!Q.empty() && a[i]-a[i-1]>=a[Q.back()]-a[Q.back()-1]) Q.pop_back();
        Q.push_back(i);
        if (i-1>=K)
        {
            while (!Q.empty() && Q.front()<=i-K) Q.pop_front();
            res=min(res, a[Q.front()]-a[Q.front()-1]);
        }
    }
    cout << res;
}
//////

int main()
{
    freopen("maxdif.inp", "r", stdin);
    freopen("maxdif.out", "w", stdout);
    enter();
    process();
}
