#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
using namespace std;
//////

const
    int maxn=1e6+100;
int n;
char a[maxn];
//////

void enter()
{
    scanf("%s", a+1);
    n=strlen(a+1);
}
//////

void process()
{
    bool ok=false;
    forn(i, 1, n)
        if (a[i]!=9) ok=true;
    if (!ok)
    {
        cout << 1;
        forn(i, 1, n-1) cout << 0;
        cout << 1;
        return;
    }
    int choose=0;
    ok=false;
    forn(i, n-n/2+1, n)
    {
        if (a[i]==a[n-i+1]) continue;
        if (choose==0)
        {
            if (a[i]!=a[n-i+1]) choose=1;
            if (a[i]>a[n-i+1]) ok=false; else ok=true;
        }
        a[i]=a[n-i+1];
    }
    if (!ok)
    ford(i, n-n/2, 1)
        if (a[i]!=9)
        {
            a[i]++;
            break;
        } else
        {
            a[i]=0; a[n-i+1]=0;
        }
    forn(i, 1, n) cout << a[i];
}
//////

int main()
{
    freopen("palin_vo27.inp", "r", stdin);
    freopen("palin_vo27.out", "w", stdout);
    enter();
    process();
}
