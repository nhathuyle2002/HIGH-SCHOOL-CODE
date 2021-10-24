/*#include <cstdio>
#include <iostream>
#include <algorithm>

using namespace std;

const int N = 200 + 2;
const int INF = 1e9;

const int dx[4] = {-1, -1, 1, 1};
const int dy[4] = {-1, 1, -1, 1};

int n, m;
int a[N][N];
int mnDiff[N * 2], mxDiff[N * 2];
int sze[N * 2];
int f[N * 2][N][N];

int GetVal(int sum, int diff)
{
    if ((sum ^ diff) & 1) return -INF;
    int i = (sum + diff) / 2, j = (sum - diff) / 2;
    if (1 <= i && i <= n && 1 <= j && j <= m) return a[i][j];
    return -INF;
}

int main()
{
    freopen("BROTHERS.inp", "r", stdin);
    freopen("BROTHERS.out", "w", stdout);
    cin.tie(NULL); ios_base::sync_with_stdio(false);
    cin >> n >> m;
    for (int i = 1; i <= n; ++i)
        for (int j = 1; j <= m; ++j)
            cin >> a[i][j];

    fill(mnDiff, mnDiff + n + m + 1, 1e9);
    fill(mxDiff, mxDiff + n + m + 1, -1e9);

    for (int i = 1; i <= n; ++i)
        for (int j = 1; j <= m; ++j) {
            mnDiff[i + j] = min(mnDiff[i + j], i - j);
            mxDiff[i + j] = max(mxDiff[i + j], i - j);
        }

    for (int k = 2; k <= n + m; ++k) {
        sze[k] = mxDiff[k] - mnDiff[k] + 1;
        for (int i = 0; i < sze[k]; ++i)
            fill(f[k][i], f[k][i] + sze[k], -INF);
    }
    sze[1] = 1;

    f[2][0][0] = 0;
    for (int k = 2; k < n + m; ++k) {
        for (int i = 0; i < sze[k]; ++i)
            for (int j = i; j < sze[k]; ++j)
                if (f[k][i][j] != -INF)
                    for (int dir = 0; dir < 4; ++dir) {
                        int p = i + dx[dir] + mnDiff[k] - mnDiff[k + 1];
                        int q = j + dy[dir] + mnDiff[k] - mnDiff[k + 1];
                        if (0 <= p && p < sze[k + 1] && 0 <= q && q < sze[k + 1] && (p != q || k + 1 == n + m))
                            f[k + 1][p][q] = max(f[k + 1][p][q], f[k][i][j] + GetVal(k + 1, p + mnDiff[k + 1]) + GetVal(k + 1, q + mnDiff[k + 1]));
                    }
    }
    cout << f[n + m][0][0];
    return 0;
}
*/


#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); i++)
#define ford(i,a,b) for(int i=(a); i>=(b); i--)
using namespace std;
//////

typedef pair<int, int> pii;
const
    int maxn=210, maxk=2*maxn;
const
    int oo=1e9;
int n, m;
int a[maxn][maxn], id[maxn][maxn];
int f[maxk][maxn][maxn];
vector<int> q;
//////

void enter()
{
    scanf("%d%d\n", &n, &m);
    forn(i, 1, n)
        forn(j, 1, m) scanf("%d", &a[i][j]);
}
//////

void process()
{
    forn(x, 0, n+1)
        forn(y, 0, m+1) id[x][y]=-1;
    id[1][1]=0; f[1][0][0]=0;
    id[1][2]=0; id[2][1]=1; f[2][0][1]=a[1][2]+a[2][1];

    forn(k, 3, n+m-2)
    {
        q.clear();
        forn(x, 1, n)
        {
            int y=k-x+1;
            if (y>0 && y<=m)
            {
                id[x][y]=q.size();
                q.push_back(x);
            }
        }
        forn(i, 0, q.size()-1)
        {
            int x=q[i], y=k-q[i]+1, wi=a[x][y];
            int i1=id[x-1][y], i2=id[x][y-1];
            forn(j, i+1, q.size()-1)
            {
                x=q[j]; y=k-q[j]+1;
                int wj=a[x][y];
                int j1=id[x-1][y], j2=id[x][y-1];
                f[k][i][j]=-oo;
                if (i1>=0 && j1>=0 && i1!=j1) f[k][i][j]=max(f[k][i][j], f[k-1][i1][j1]+wi+wj);
                if (i1>=0 && j2>=0 && i1!=j2) f[k][i][j]=max(f[k][i][j], f[k-1][i1][j2]+wi+wj);
                if (i2>=0 && j1>=0 && i2!=j1) f[k][i][j]=max(f[k][i][j], f[k-1][i2][j1]+wi+wj);
                if (i2>=0 && j2>=0 && i2!=j2) f[k][i][j]=max(f[k][i][j], f[k-1][i2][j2]+wi+wj);
            }
        }
    }
    cout << f[n+m-2][0][1];
}
//////

int main()
{
    freopen("brothers.inp", "r", stdin);
    freopen("brothers.out", "w", stdout);
    enter();
    process();
}

