#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); i++)
#define ford(i,a,b) for(int i=(a); i>=(b); i--)
using namespace std;
//////

typedef long long LL;
int T, L, R;
//////

LL power(int a, int b, int m)
{
    LL res=1;
    LL a2=a % m;
    while (b>0)
    {
        if ((b & 1)==1) res=res*a2 % m;
        b>>=1;
        a2=a2*a2 % m;
    }
    return res;
}
//////

void factor(int X, int &s, int &d)
{
    s=0; d=0;
    while ((X & 1)==0)
    {
        s++;
        X>>=1;
    }
    d=X;
}
//////

bool calc(int s, int d, int X, int a)
{
    if (X<=a) return true;
    LL r=power(a, d, X);
    if (r==1) return true;
    while (s--)
    {
        if (r==X-1) return true;
        r=r*r % X;
    }
    return false;
}

bool miller_test(int X)
{
    if (X<2) return false;
    if ((X & 1)==0) return X==2;
    int s, d;
    factor(X-1, s, d);
    return calc(s, d, X, 2) && calc(s, d, X, 7) && calc(s, d, X, 61);
}
//////

int main()
{
    freopen("primecount.inp", "r", stdin);
    freopen("primecount.out", "w", stdout);
    scanf("%d\n", &T);
    while (T--)
    {
        scanf("%d%d\n", &L, &R);
        int cou=0;
        forn(x, L, R)
            if (miller_test(x)) cou++;
        cout << cou << '\n';
    }
}
