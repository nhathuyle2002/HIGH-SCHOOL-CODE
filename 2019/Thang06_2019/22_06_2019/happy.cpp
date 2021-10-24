#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
using namespace std;
//////

const
    int maxn=1e5+100;
int n, c[2];
//////

void enter()
{
    cin >> n;
    int x;
    forn(i, 1, n)
    {
        scanf("%d", &x);
        c[x % 2]++;
    }
}
//////

void process()
{
    if (c[0]>c[1]) cout << "Happy"; else cout << "Sad";
}
//////

int main()
{
    freopen("happy.inp", "r", stdin);
    freopen("happy.out", "w", stdout);
    enter();
    process();
}
