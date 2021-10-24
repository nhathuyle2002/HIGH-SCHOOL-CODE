#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
using namespace std;
//////

long long x;
long long p2[33];
//////

int query(long long x, int last)
{

    if (x==1) return 1;
    while (p2[last-1]>=x) --last;
    return 1-query(x-p2[last-1], last-1);
}

int main()
{
    freopen("digit.inp", "r", stdin);
    freopen("digit.out", "w", stdout);
    cin >> x;
    p2[0]=1;
    forn(i, 1, 32) p2[i]=p2[i-1]*2;
    cout << query(x, 32);
}
