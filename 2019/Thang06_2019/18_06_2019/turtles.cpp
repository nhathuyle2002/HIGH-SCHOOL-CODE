#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
using namespace std;
//////

struct data
{
    int d, cou, ma, mi;
};
const
    int maxn=1e5+100;
int h, w, n, coutp, q;
data x[maxn], y[maxn];
//////

void enter()
{
    scanf("%d%d\n", &h, &w);
    scanf("%d\n", &n);
    coutp=0;
    forn(i, 1, n)
    {
        int r, c;
        scanf("%d%d\n", &r, &c);

        if (x[r].cou==0) x[r]={0, 1, c, c}; else
        {
            coutp-=x[r].d;
            x[r].cou++;
            x[r].ma=max(x[r].ma, c);
            x[r].mi=min(x[r].mi, c);
            if (x[r].ma-x[r].mi+1==x[r].cou) x[r].d=0; else x[r].d=1;
            coutp+=x[r].d;
        }

        if (y[c].cou==0) y[c]={0, 1, r, r}; else
        {
            coutp-=y[c].d;
            y[c].cou++;
            y[c].ma=max(y[c].ma, r);
            y[c].mi=min(y[c].mi, r);
            if (y[c].ma-y[c].mi+1==y[c].cou) y[c].d=0; else y[c].d=1;
            coutp+=y[c].d;
        }
    }
    if (coutp==0) cout << "YES" << '\n'; else cout << "NO" << '\n';
}
//////

void process()
{
    scanf("%d\n", &q);
    forn(i, 1, q)
    {
        int r, c;
        scanf("%d%d\n", &r, &c);

        if (x[r].cou==0) x[r]={0, 1, c, c}; else
        {
            coutp-=x[r].d;
            x[r].cou++;
            x[r].ma=max(x[r].ma, c);
            x[r].mi=min(x[r].mi, c);
            if (x[r].ma-x[r].mi+1==x[r].cou) x[r].d=0; else x[r].d=1;
            coutp+=x[r].d;
        }

        if (y[c].cou==0) y[c]={0, 1, r, r}; else
        {
            coutp-=y[c].d;
            y[c].cou++;
            y[c].ma=max(y[c].ma, r);
            y[c].mi=min(y[c].mi, r);
            if (y[c].ma-y[c].mi+1==y[c].cou) y[c].d=0; else y[c].d=1;
            coutp+=y[c].d;
        }

        if (coutp==0) cout << "YES" << '\n'; else cout << "NO" << '\n';
    }
}
//////

int main()
{
    freopen("turtles.inp", "r", stdin);
    freopen("turtles.out", "w", stdout);
    enter();
    process();
}
