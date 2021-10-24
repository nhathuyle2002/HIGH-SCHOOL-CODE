#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); i++)
#define ford(i,a,b) for(int i=(a); i>=(b); i--)

#define F first
#define S second
using namespace std;
//////

typedef pair<int, int> pii;
const
    int maxn=1e5+100;

int n, m;
pair<pii, int> a[maxn];
pair<pii, pii> b[maxn];
map<pii, int> MAP;
int match[maxn];
///////

void enter()
{
    scanf("%d\n", &n);
    forn(i, 1, n)
    {
        scanf("%d%d\n", &a[i].F.F, &a[i].F.S);
        a[i].S=i;
    }
    sort(a+1, a+n+1);
    scanf("%d\n", &m);
    forn(i, 1, m)
    {
        scanf("%d%d%d\n", &b[i].F.F, &b[i].F.S, &b[i].S.F);
        b[i].S.S=i;
    }
    sort(b+1, b+m+1);
}
///////

void process()
{
    int j=1;
    forn(i, 1, n)
    {
        while (j<=m && b[j].F.F<=a[i].F.F)
        {
            MAP[pii(b[j].F.S, b[j].S.S)]=b[j].S.F;
            j++;
        }
        map<pii, int> :: iterator it=MAP.lower_bound(pii(a[i].F.S, 0));
        if (it==MAP.end())
        {
            cout << "NO";
            return;
        }
        pii p=(*it).F; int p2=(*it).S-1;
        match[a[i].S]=p.S;
        if (p2==0) MAP.erase(it); else MAP[p]=p2;
    }
    cout << "YES" << '\n';
    forn(i, 1, n)
        cout << match[i] << ' ';
}
///////

int main()
{
    freopen("singer.inp", "r", stdin);
    freopen("singer.out", "w", stdout);
    enter();
    process();
}
