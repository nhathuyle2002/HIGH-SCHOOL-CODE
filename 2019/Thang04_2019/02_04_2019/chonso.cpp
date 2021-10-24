#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); i++)
#define ford(i,a,b) for(int i=(a); i>=(b); i--)

using namespace std;
//////

const
    int maxn=2e3+100;
int n;
int a[maxn];
int f[maxn][7], trace[maxn][7];
vector<int> out;
///////

void enter()
{
    scanf("%d\n", &n);
    forn(i, 1, n) scanf("%d\n", &a[i]);
}
///////

void process()
{
    forn(i, 1, n)
        forn(x, 1, 6)
            forn(y, 1, 6)
                if ((x>>1)==(y&3))
                {
                    int s;
                    if ((x&1)==1) s=a[i]; else s=0;
                    if (s+f[i-1][y]>f[i][x])
                    {
                        f[i][x]=s+f[i-1][y];
                        trace[i][x]=y;
                    }
                }
    int x=0;
    forn(y, 1, 6)
        if (f[n][y]>f[n][x]) x=y;
    cout << f[n][x] << ' ';
    out.clear();
    while (n>0)
    {
        if ((x&1)==1) out.push_back(n);
        x=trace[n][x]; n--;
    }
    //cout << out.size() << '\n';
    //ford(i, out.size()-1, 0) cout << out[i] << '\n';
}
///////

int main()
{
    freopen("chonso.inp", "r", stdin);
    freopen("chonso.out", "w", stdout);
    enter();
    process();
}
