#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
using namespace std;
//////

const
    int maxn=22, maxk=110;
int n, m, K;
int a[maxn][maxn];
int pos[maxk][maxn];
bool dd[maxn];
int b[maxn];
int res, rr[maxn];
//////

void sort(int t, int cot)
{
    forn(i, 1, n) pos[t][i]=pos[t-1][i];
    forn(i, 1, n)
        ford(j, n-1, i)
            if (a[pos[t][j]][cot]>a[pos[t][j+1]][cot])
                swap(pos[t][j], pos[t][j+1]);
}
//////

void enter()
{
    scanf("%d%d%d\n", &n, &m, &K);
    forn(i, 1, n)
    {
        pos[0][i]=i;
        forn(j, 1, m)
            scanf("%d", &a[i][j]);
        scanf("\n");
    }
    forn(i, 1, K)
    {
        int j; scanf("%d", &j);
        sort(i, j);
    }
    forn(i, 1, n)
        pos[maxk][i]=pos[K][i];
}
//////

bool update(int t)
{
    forn(i, 1, n)
        if (pos[t][i]!=pos[maxk][i]) return false;
    res=t;
    forn(i, 1, t) rr[i]=b[i];
    return true;
}

void dequy(int t)
{
    if (update(t)) return;
    if (t+1>=res) return;
    forn(j, 1, m)
        if (dd[j])
        {
            dd[j]=false;
            b[t+1]=j;
            sort(t+1, j);
            dequy(t+1);
            dd[j]=true;
        }
}

void process()
{
    forn(j, 1, m) dd[j]=true;
    res=m+1;
    dequy(0);
    cout << res << '\n';
    forn(i, 1, res) cout << rr[i] << ' ';
}
//////

int main()
{
    freopen("sctab.inp", "r", stdin);
    freopen("sctab.out", "w", stdout);
    enter();
    process();
}
