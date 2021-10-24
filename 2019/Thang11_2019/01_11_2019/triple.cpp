#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
#define repn(i,a,b) for(int i=(a); i<(b); ++i)
using namespace std;
//////

const
    int maxn=1e5+100;
int n, M;
int a[maxn];
long long res;
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
    fastscan(n); fastscan(M);
    forn(i, 1, n) fastscan(a[i]);
    sort(a+1, a+n+1);
}
//////

void process()
{
    res=0;
    int sum;
    forn(i, 1, n-2)
    {
        int k1=n, k2=n;
        forn(j, i+1, n-1)
        {
            sum=a[i]+a[j];
            if (k1<j) k1=j;
            while (k1>j && sum+a[k1]>=M) --k1;
            while (k2>j && sum+a[k2]>M) --k2;
            if (k2<=j) break;
            res+=k2-k1;
        }
    }
    res%=int(1e9+7);
    cout << res;
}
//////

void check()
{
    res=0;
    forn(i, 1, n)
        forn(j, i+1, n)
            forn(k, j+1, n)
                if (a[i]+a[j]+a[k]==M) ++res;
    cout << '\n' << res;
}
//////

int main()
{
    freopen("triple.inp", "r", stdin);
    freopen("triple.out", "w", stdout);
    enter();
    process();
    //check();
}
