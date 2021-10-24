#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); i++)
#define repn(i,a,b) for(int i=(a); i<(b); i++)
using namespace std;
//////

const
    int maxn=500;
int n;
int a[maxn][maxn], f[maxn][maxn];
vector<int> q;
//////

void enter()
{
    scanf("%d\n", &n);
    forn(i, 1, n)
    {
        forn(j, 1, i) scanf("%d", &a[i][j]);
        scanf("\n");
    }
}
//////

void process()
{
    forn(i, 1, n)
    {
        forn(j, 1, i-1)
            f[i][j]=max(f[i-1][j], f[i-1][j-1])+a[i][j];
        f[i][i]=f[i-1][i-1]+a[i][i];
    }
    int jres=0; f[n][0]=-1;
    forn(j, 1, n)
        if (f[n][j]>f[n][jres]) jres=j;
    cout << f[n][jres] << '\n';
    q.clear();
    for(int i=n; i>=1; i--)
    {
        q.push_back(a[i][jres]);
        if (jres==i) jres--; else
        if (f[i-1][jres-1]+a[i][jres]==f[i][jres]) jres--;
    }
    for(int i=q.size()-1; i>=0; i--) cout << q[i] << ' ';
}

int main()
{
    freopen("triangle.inp", "r", stdin);
    freopen("triangle.out", "w", stdout);
    enter();
    process();
}
