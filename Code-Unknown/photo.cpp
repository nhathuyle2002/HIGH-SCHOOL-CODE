#include <bits/stdc++.h>
#define forn(i, a, b) for (int i=(a); i<=(b); ++i)
#define ford(i, a, b) for (int i=(a); i>=(b); --i)
using namespace std;
//////

const
    int maxn=1e5+100;
int n;
int pos[6][maxn];
int a[maxn];
//////

void enter()
{
    scanf("%d\n", &n);
    forn(i, 1, 5)
        forn(j, 1, n)
        {
            int x; scanf("%d", &x);
            pos[i][x]=j;
        }
}
//////

bool comp(int x, int y)
{
    int cou=0;
    forn(i, 1, 5)
        if (pos[i][x]<pos[i][y]) cou++;
    if (cou>=3) return true; else return false;
}

void process()
{
    forn(i, 1, n) a[i]=i;
    sort(a+1, a+n+1, comp);
    forn(i, 1, n) cout << a[i] << ' ';
}
//////

int main()
{
    freopen("photo.inp", "r", stdin);
    freopen("photo.out", "w", stdout);
    enter();
    process();
}
