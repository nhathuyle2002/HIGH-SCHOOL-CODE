#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
#define repn(i,a,b) for(int i=(a); i<(b); ++i)
using namespace std;
//////

const
    int maxn=1e3+100;
int m, n, K;
long long last_day;
int a[maxn], b[maxn];
bool dd[maxn];
//////

bool compare(int x, int y) {return x>y;}

void enter()
{
    scanf("%d%d%d\n", &m, &n, &K);
    forn(i, 1, m) scanf("%d", &a[i]);
    sort(a+1, a+m+1, compare);
    forn(i, 1, n) scanf("%d", &b[i]);
    sort(b+1, b+n+1, compare);
}
//////

void xoa(int speed)
{
    long long left_day=last_day;
    forn(i, 1, n)
        if (dd[i] && b[i]+speed<=left_day)
        {
            dd[i]=false;
            left_day-=speed;
        }
}

void process()
{
    long long L=1, R=1e11+100;
    while (L<R)
    {
        last_day=(L+R)/2;
        forn(i, 1, n) dd[i]=true;
        forn(i, 1, m)
            xoa((K-1)/a[i]+1);
        bool ok=true;
        forn(i, 1, n)
            if (dd[i]) { ok=false; break; }
        if (ok) R=last_day; else L=last_day+1;
    }
    cout << L-1;
}
//////

int main()
{
    freopen("budget.inp", "r", stdin);
    freopen("budget.out", "w", stdout);
    enter();
    process();
}
