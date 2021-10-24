#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
using namespace std;
//////

const
    int maxn=1e5+100;
long long n, Q, R;
//////

void enter()
{
    cin >> n;
}
//////

void process()
{
    Q=n/5; R=n%5;
    cout << (Q+1)*R*30+Q*(Q+1)/2*30*5;
}
//////

int main()
{
    freopen("microwave.inp", "r", stdin);
    freopen("microwave.out", "w", stdout);
    enter();
    process();
}
