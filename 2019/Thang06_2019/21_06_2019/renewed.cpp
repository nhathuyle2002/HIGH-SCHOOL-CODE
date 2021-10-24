#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
using namespace std;
//////

const
    int maxn=1e5+100;
long long a, k, b, m, n;
//////

void enter()
{
    cin >> a >> k >> b >> m >> n;
}
//////

void process()
{
    long long L=1, R=1e18+1, mid;
    while (L<R)
    {
        mid=(L+R)/2;
        bool ok=false;
        long long day1=mid-mid/k, day2=mid-mid/m;
        if (n/a<=day1 || n/b<=day2) ok=true; else
        if (a*day1+b*day2>=n) ok=true;
        if (ok) R=mid; else L=mid+1;
    }
    cout << R;
}
//////

int main()
{
    freopen("renewed.inp", "r", stdin);
    freopen("renewed.out", "w", stdout);
    enter();
    process();
}
