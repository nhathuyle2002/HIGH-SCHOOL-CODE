#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); i++)
#define repn(i,a,b) for(int i=(a); i<(b); i++)
using namespace std;
//////

const
    int maxn=5e4+100, maxlg=16;
int n, q, nlg;
int Q_max[maxn][maxlg], Q_min[maxn][maxlg];
//////

void enter()
{
    scanf("%d%d\n", &n, &q);
    nlg=log2(n);
    forn(i, 1, n)
    {
        scanf("%d\n", &Q_max[i][0]);
        Q_min[i][0]=Q_max[i][0];
    }
    forn(k, 1, nlg)
        forn(i, 1, n-(1<<k)+1)
        {
            Q_max[i][k]=max(Q_max[i][k-1], Q_max[i+(1<<(k-1))][k-1]);
            Q_min[i][k]=min(Q_min[i][k-1], Q_min[i+(1<<(k-1))][k-1]);
        }
}
//////

int query_MAX(int L, int R)
{
    int lg=log2(R-L+1);
    return max(Q_max[L][lg], Q_max[R-(1<<lg)+1][lg]);
}

int query_MIN(int L, int R)
{
    int lg=log2(R-L+1);
    return min(Q_min[L][lg], Q_min[R-(1<<lg)+1][lg]);
}

void process()
{
    while (q--)
    {
        int L, R;
        scanf("%d%d\n", &L, &R);
        cout << query_MAX(L, R)-query_MIN(L, R) << '\n';
    }
}

int main()
{
    freopen("milk.inp", "r", stdin);
    freopen("milk.out", "w", stdout);
    enter();
    process();
}
