#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
using namespace std;
//////

const
    int maxn=210;
int n;
int h[maxn], f[maxn];
bool d[maxn][maxn];
//////

void enter()
{
    cin >> n;
    forn(i, 1, n) cin >> h[i];

    forn(i, 1, n)
    {
        d[i][i]=true;
        d[i][i+1]=true;
    }

    forn(sl, 3, n)
        forn(i, 1, n-sl+1)
        {
            int j=i+sl-1;
            d[i][j]=false;
            forn(mid, i+1,
                  j-1)
                if (d[i][mid] && d[mid][j] && (h[mid]-h[i])*(h[mid]-h[j])>0) d[i][j]=true;
        }
}
//////

void process()
{
    f[1]=1;
    forn(i, 2, n)
    {
        f[i]=-maxn;
        ford(j, i-1, 1)
            if (d[j][i] && h[i]>=h[j]) f[i]=max(f[i], f[j]+1);
    }
    if (f[n]>=2) cout << n-f[n]; else cout << -1;
}
//////

int main()
{
    freopen("oaks.inp", "r", stdin);
    freopen("oaks.out", "w", stdout);
    enter();
    process();
}
