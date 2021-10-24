#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
using namespace std;
//////

typedef pair<int, int> pii;
const
    int maxn=1e5+100;
int n, m, k;
int t[maxn], d[maxn], a[maxn];
set<pii> Q;
//////

void enter()
{
    scanf("%d%d%d\n", &n, &m, &k);
    forn(i, 1, k) scanf("%d%d%d\n", &t[i], &d[i], &a[i]);
}
//////

void process()
{
    forn(i, 1, k)
    {
        while (!Q.empty())
        {
            pii p=*Q.begin();
            if (p.first<=t[i])
            {
                if (a[p.second]==0) n++; else
                {
                    m++;
                    n++;
                }
                Q.erase(Q.begin());
            } else
            break;
        }
        if (a[i]==0 && n>0)
        {
            n--;
            Q.insert({t[i]+d[i], i});
            cout << "YES" << '\n';
        } else
        if (a[i]==1 && n>0 && m>0)
        {
            n--; m--;
            Q.insert({t[i]+d[i], i});
            cout << "YES" << '\n';
        } else
        cout << "NO" << '\n';
    }
}
//////

int main()
{
    freopen("gruel.inp", "r", stdin);
    freopen("gruel.out", "w", stdout);
    enter();
    process();
}
