#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
#define repn(i,a,b) for(int i=(a); i<(b); ++i)
using namespace std;
//////

typedef vector<int> bignum;
const
    int maxn=10000, base=1e9;
int n;
int res;//bignum res;
int d[3][3], d2[3][3];
int x[maxn];
//////

void enter()
{
    scanf("%d\n", &n);
    char x;
    forn(i, 0, 2)
        forn(j, 0, 3)
        {
            x=getchar();
            if (j<3 && x=='Y') d[i][j]=1; else
            if (j<3 && x=='N') d[i][j]=0;
        }
}

void thu(int i)
{
    if (i>n)
    {
        forn(i, 0, 2)
            forn(j, 0, 2) d2[i][j]=0;
        forn(i, 1, n-1)
            d2[x[i]][x[i+1]]=1, d2[x[i+1]][x[i]]=1;
        forn(i, 0, 2)
            forn(j, 0, 2)
                if (d[i][j]!=d2[i][j]) return;
        ++res;
        //forn(i, 1, n) cout << x[i] << ' '; cout << '\n';
        return;
    }
    forn(j, 0, 2)
    {
        x[i]=j;
        thu(i+1);
    }
}
//////

int main()
{
    freopen("nrow.inp", "r", stdin);
    freopen("nrow_try.out", "w", stdout);
    enter();
    res=0;
    thu(1);
    cout << res;
}
