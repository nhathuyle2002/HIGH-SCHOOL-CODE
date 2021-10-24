#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
using namespace std;
//////

const
    int maxn=1e5+100, base=1e9+7;
long long n;
//////

void enter()
{
    cin >> n;
}
//////

long long power(long long a, long long b)
{
    if (b==0) return 1;
    long long c=power(a, b/2);
    c=c*c % base;
    if (b % 2==1) c=c*a % base;
    return c;
}

void process()
{
    cout << power(2, n-1);
}
//////

int main()
{
    freopen("stadium.inp", "r", stdin);
    freopen("stadium.out", "w", stdout);
    enter();
    process();
}
