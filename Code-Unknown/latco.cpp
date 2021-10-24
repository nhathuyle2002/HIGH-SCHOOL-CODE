#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
using namespace std;
//////

const
    int maxn=210;
int n, m, res;
int a2[maxn], b2[maxn], a[maxn], b[maxn];
//////

void enter()
{
    scanf("%d%d\n", &n, &m);
    char s[maxn];
    scanf("%s\n", s);
    forn(i, 0, n-1) a2[i]=s[i]-48;
    scanf("%s", s);
    forn(i, 0, n-1) b2[i]=s[i]-48;
}
//////

int process(int k1, int k2)
{
    forn(i, 0, n-1)
    {
        a[i]=a2[(i+k1) % n];
        b[i]=b2[(i+k2) % n];
    }
    int cou=0;
    forn(i, 0, n-m)
        if (a[i]!=b[i])
        {
            ++cou;
            forn(j, i, i+m-1) a[j]=1-a[j];
        }
    forn(i, n-m+1, n-1)
        if (a[i]!=b[i]) return n+1;
    return cou;
}
//////

int main()
{
    freopen("latco.inp", "r", stdin);
    freopen("latco.out", "w", stdout);
    enter();
    res=n+1;
    forn(i, 0, n-1)
    forn(j, 0, n-1)
        res=min(res, process(i, j));
    cout << res;
}
