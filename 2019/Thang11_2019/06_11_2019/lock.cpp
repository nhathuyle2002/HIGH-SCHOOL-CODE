#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
#define repn(i,a,b) for(int i=(a); i<(b); ++i)
using namespace std;
//////

const
    int maxn=1e5+100;
int n, maxD, K;
int a[maxn];
bool dd[maxn];
int top, Q[maxn];
long long res, sum[maxn];
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
    fastscan(n); fastscan(maxD); fastscan(K);
    forn(i, 1, n) fastscan(a[i]);
}
//////

void query(int i)
{
    if (!dd[i]) return;
    Q[++top]=a[i]; dd[i]=false;
    query((i+K-1)%n+1);
}

void xuly()
{
    sort(Q+1, Q+top+1);
    /*sum[0]=0;
    forn(i, 1, top) sum[i]=sum[i-1]+Q[i];
    long long ans=1e15;
    forn(i, 1, top)
        ans=min(ans, 1LL*(i-1)*Q[i]-sum[i-1]+sum[top]-sum[i]-1LL*Q[i]*(n-i));*/
    long long ans=0;
    forn(i, 1, top)
        ans+=abs(Q[i]-Q[(top+1)/2]);
    res+=ans;
}

void process()
{
    forn(i, 1, n) dd[i]=true;
    res=0;
    forn(i, 1, n)
        if (dd[i])
        {
            top=0; query(i);
            xuly();
        }
    cout << res;
}
//////

int main()
{
    freopen("lock.inp", "r", stdin);
    freopen("lock.out", "w", stdout);
    enter();
    process();
}
