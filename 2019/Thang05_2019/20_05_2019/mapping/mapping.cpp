#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
using namespace std;
//////

long long x, y, z;

int main()
{
    freopen("mapping.inp", "r", stdin);
    freopen("mapping.out", "w", stdout);
    cin >> x >> y;
    cout << (x+y-2)*(x+y-1)/2+y << '\n';
    cin >> z;
    long long L=0, R=2*1e9, mid;
    while (L<R)
    {
        mid=(L+R)/2;
        if (mid*(mid+1)/2>=z) R=mid; else L=mid+1;
    }
    y=z-L*(L-1)/2; x=L-y+1;
    cout << x << ' ' << y;
}
