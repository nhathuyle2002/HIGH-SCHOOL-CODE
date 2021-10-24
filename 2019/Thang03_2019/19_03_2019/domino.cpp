#include <bits/stdc++.h>

#define forn(i,a,b) for (int i=(a); i<=(b); i++)
#define repn(i,a,b) for (int i=(a); i<(b); i++)

using namespace std;
//////

const
    int maxn=55, maxg=maxn*10, oo=1e7;
int n;
int a[maxn], f[maxn][2*maxg+1];
vector<int> q;
//////

void enter()
{
    scanf("%d\n", &n);
    forn(i, 1, n) scanf("%d", &a[i]);
    forn(i, 1, n)
    {
        int x; scanf("%d", &x);
        a[i]-=x;
    }
}
//////

void trace(int i, int j)
{
    if (i==0) return;
    if (f[i][j]==f[i-1][j-a[i]]) trace(i-1, j-a[i]); else
    {
        trace(i-1, j+a[i]);
        q.push_back(i);
    }
}

void process()
{
    forn(j, 0, 2*maxg) f[0][j]=oo;
    f[0][maxg]=0;

    forn(i, 1, n) forn(j, 0, 2*maxg)
    {
        f[i][j]=oo;
        if (j-a[i]>=0) f[i][j]=min(f[i][j], f[i-1][j-a[i]]);
        if (j+a[i]<=2*maxg) f[i][j]=min(f[i][j], f[i-1][j+a[i]]+1);
    }

    int jres=-1;
    forn(j, 0, maxg)
    {
        if (f[n][maxg-j]<oo) jres=maxg-j;
        if (f[n][maxg+j]<oo && (jres==-1 || f[n][maxg+j]<f[n][jres])) jres=maxg+j;
        if (jres>-1) break;
    }

    cout << abs(jres-maxg) << ' ' << f[n][jres] << '\n';
    //q.clear(); trace(n, jres);
    //repn(i, 0, q.size()) cout << q[i] << ' ';
}
//////

int main()
{
    freopen("domino.inp", "r", stdin);
    freopen("domino.out", "w", stdout);
    enter();
    process();
}
