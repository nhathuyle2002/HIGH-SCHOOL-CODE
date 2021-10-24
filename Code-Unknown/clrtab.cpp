#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
using namespace std;
//////

typedef pair<int, int> pii;
const
    int maxn=60;
int T, m, n;
int a[maxn][maxn], b[maxn][maxn], c[maxn];
set<pii> Q[maxn];
vector<pii> q1, q2;
//////

void enter()
{
    scanf("%d%d\n", &m, &n);
    forn(i, 1, m)
    {
        forn(j, 1, n)
        {
            scanf("%d", &a[i][j]);
            c[a[i][j]]++;
        }
        scanf("\n");
    }
    c[0]=m*n+1;
}
//////

void process()
{
    forn(j, 1, n)
    {
        int p=0;
        forn(i, 1, n)
            if (c[i]>0 && c[i]<c[p]) p=i;
        if (c[p]>=m)
        {
            forn(i, 1, m) b[i][j]=p;
            c[p]-=m;
        } else
        {
            int pos=0;
            forn(i, 1, n)
                if (i!=p && c[i]<c[pos] && c[i]+c[p]>=m) pos=i;
            forn(i, 1, c[p]) b[i][j]=p;
            forn(i, c[p]+1, m) b[i][j]=pos;
            c[pos]-=m-c[p]; c[p]=0;
        }
    }
}
//////

void print()
{
    forn(i, 1, n) Q[i].clear();
    forn(i, 1, m)
        forn(j, 1, n)
            Q[a[i][j]].insert({i, j});

    q1.clear(); q2.clear();
    forn(i, 1, m)
        forn(j, 1, n)
        {
            Q[a[i][j]].erase({i, j});
            if (a[i][j]==b[i][j]) continue;

            pii p=*Q[b[i][j]].begin(); Q[b[i][j]].erase(p);
            q1.push_back({i, j}); q2.push_back(p);

            a[p.first][p.second]=a[i][j];
            Q[a[i][j]].insert(p);
        }

    cout << q1.size() << '\n';
    if (q1.size()>0)
    forn(i, 0, q1.size()-1)
        cout << q1[i].first << ' ' << q1[i].second << ' ' << q2[i].first << ' ' << q2[i].second << '\n';
}
//////

int main()
{
    freopen("clrtab.inp", "r", stdin);
    freopen("clrtab.out", "w", stdout);
    scanf("%d\n", &T);
    while (T--)
    {
        enter();
        process();
        print();
    }
}
