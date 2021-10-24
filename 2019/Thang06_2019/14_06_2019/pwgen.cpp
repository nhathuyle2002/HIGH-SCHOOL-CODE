#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
using namespace std;
//////

const
    int maxn=1e5+100;
int n, a, b, c;
char x[4][2], y[4][2];
//////

void enter()
{
    cin >> n >> b >> c >> a;

    x[1][0]='0'; x[1][1]='1';
    x[2][0]='A'; x[2][1]='B';
    x[3][0]='a'; x[3][1]='b';

    y[1][0]='9'; y[1][1]='8';
    y[2][0]='Z'; y[2][1]='Y';
    y[3][0]='z'; y[3][1]='y';
}
//////

void process()
{
    forn(i, 1, n)
        if (i<=n-b-c) cout << x[1][(i-1)%2]; else
        if (i<=n-c) cout << x[2][(i-1-(n-b-c))%2]; else
        cout << x[3][(i-1-(n-c))%2];

    cout << '\n';

    forn(i, 1, n)
        if (i<=n-a-b) cout << y[3][(i-1)%2]; else
        if (i<=n-a) cout << y[2][(i-1-(n-a-b))%2]; else
        cout << y[1][(i-1-(n-a))%2];
}
//////

int main()
{
    //freopen("pwgen.inp", "r", stdin);
    //freopen("pwgen.out", "w", stdout);
    enter();
    process();
}
