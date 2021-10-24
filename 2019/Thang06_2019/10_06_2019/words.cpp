#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
using namespace std;
//////

const
    int base=1e9+7;
int n, k;
long long res;
//////

void enter()
{
    cin >> n >> k;
}
//////

long long power(int a, int p)
{
    if (p==0) return 1;
    long long tm=power(a, p/2);
    tm=tm*tm % base;
    if (p % 2==0) return tm;
    else return tm*a % base;
}

void process()
{
    long long s1=power(k, (n+1)/2), s2=power(k, n);
    res=s1+(s2-s1)*power(2, base-2);
    cout << (res% base+base) % base;
}
//////

int main()
{
    freopen("words.inp", "r", stdin);
    freopen("words.out", "w", stdout);
    enter();
    process();
}
