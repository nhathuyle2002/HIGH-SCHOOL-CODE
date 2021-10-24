#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
using namespace std;
//////

const
    int maxn=210;
int n, m;
char a[maxn][maxn];
//////

void enter()
{
    scanf("%d%d\n", &n, &m);
    forn(i, 1, n)
    {
        forn(j, 1, m) scanf("%c", &a[i][j]);
        scanf("\n");
    }
}
//////

void process()
{

}
//////

int main()
{
    freopen("f1.inp", "r", stdin);
    freopen("f1.out", "w", stdout);
    enter();
    process();
}
