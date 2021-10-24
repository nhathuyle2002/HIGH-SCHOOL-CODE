#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
using namespace std;
//////

const
    int maxn=1e5+100;
int n;
long long sum;
int a[maxn];
//////

void enter()
{
    scanf("%d\n", &n);
    forn(i, 1, n) scanf("%d", &a[i]);
    sort(a+1, a+n+1);
}
//////

void process()
{
    sum=0;
    forn(i, 1, n) sum+=a[i];
    ford(i, n, 1)
        if (sum/i>=a[i])
        {
            cout << i;
            return;
        }
    cout << 0;
}
//////

int main()
{
    freopen("merlin.inp", "r", stdin);
    freopen("merlin.out", "w", stdout);
    enter();
    process();
}
