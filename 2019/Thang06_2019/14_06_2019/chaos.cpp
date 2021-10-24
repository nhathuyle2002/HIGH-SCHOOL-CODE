#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
using namespace std;
//////

const
    int maxn=1e3+100;
int a, b, c, d;
bool dd[maxn];
long long n;
//////

void enter()
{
    cin >> a >> b >> c >> d >> n;
    forn(i, 0, d) dd[i]=false;
}
//////

void process()
{
    dd[a]=true;
    while (n-->0)
    {
        a=a*b-c;
        if (a<=0)
        {
            a=0;
            break;
        }
        a=min(a, d);
        if (a==d || dd[a]) break;
        dd[a]=true;
    }
    cout << a;
}
//////

int main()
{
    freopen("chaos.inp", "r", stdin);
    freopen("chaos.out", "w", stdout);
    enter();
    process();
}
