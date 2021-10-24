#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
#define repn(i,a,b) for(int i=(a); i<(b); ++i)
using namespace std;
//////

const
    int maxn=1e5+100;
int n;
int a[maxn];
bool d[maxn];
//////

void fastscan(int &number)
{
    number=0;
    register char c=getchar();
    bool negative=false;
    if (c=='-') negative=true, c=getchar();
    for(; c>47 && c<58; c=getchar())
        number=number*10+c-48;
    if (negative) number=-number;
}

void enter()
{
    scanf("%d\n", &n);
    //forn(i, 1, n) scanf("%d", &a[i]);
}
//////

void process()
{
    forn(i, 1, n) d[i]=true;
    int nn=n, cou;
    while (nn>0)
    {
        cou=0;
        forn(i, 1, n)
            if (d[i])
            {
                cout << i << ' '; ++cou;
                if (cou%2==1) d[i]=false, nn--;
            } else cout << 0 << ' ';
        cout << '\n';
        cou=0;
        forn(i, 1, n)
            if (d[i])
            {
                cout << i << ' '; ++cou;
                if (cou%2==0) d[i]=false, nn--;
            } else cout << 0 << ' ';
        cout << '\n';
    }
}
//////

int main()
{
    freopen("mnum.inp", "r", stdin);
    freopen("mnum_try.out", "w", stdout);
    enter();
    process();
}
