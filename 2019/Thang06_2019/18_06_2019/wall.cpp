#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
using namespace std;
//////

const
    int maxn=1e5+100;
int n, m;
int a[maxn], b[maxn];
//////

void enter()
{
    scanf("%d\n", &n);
    forn(i, 1, n) scanf("%d", &a[i]);
    scanf("%d\n", &m);
    forn(i, 1, m) scanf("%d", &b[i]);
}
//////

void process()
{
    int L=0, R=2e8+1, mid;
    while (L<R)
    {
        mid=(L+R)/2;
        int ok=1, j=1;
        forn(i, 1, n)
            if (a[i]<mid)
            {
                while (j<=m && a[i]+b[j]<mid) j++;
                if (j>m)
                {
                    ok=0;
                    break;
                } else j++;
            }
        if (ok==1) L=mid+1; else R=mid;
    }

    cout << L-1 << ' ';
    int cou=0;
    forn(i, 1, n)
        if (a[i]<L-1) cou++;
    cout << cou;
}
//////

int main()
{
    freopen("wall.inp", "r", stdin);
    freopen("wall.out", "w", stdout);
    enter();
    process();
}
