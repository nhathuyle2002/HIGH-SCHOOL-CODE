#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
using namespace std;
//////

typedef unsigned long long ULL;
const
    int maxn=1e6+10;

ULL A, B;
int T, M, n;
int f[maxn+1];
//////

void init()
{
    f[0]=0; f[1]=1 % M;
    forn(i, 2, maxn)
    {
        f[i]=(f[i-1]+f[i-2]) % M;
        if (f[i]==f[1] && f[i-1]==f[0])
        {
            n=i-1;
            break;
        }
    }
}
//////

int power(ULL a, ULL b, int m)
{
    if (b==0) return 1 % m;
    int c=power(a, b/2, m);
    c=c*c % m;
    if (b % 2==1) c=c*a % m;
    return c;
}

ULL GCD(ULL a, ULL b)
{
    if (b==0) return a;
    return GCD(b, a % b);
}
//////

int main()
{
    freopen("fib.inp", "r", stdin);
    freopen("fib.out", "w", stdout);
    scanf("%d\n", &T);
    while (T--)
    {
        scanf("%llu%llu%d\n", &A, &B, &M);
        init();
        cout << f[power(A % n, B, n)] << ' ' << f[GCD(A, B) % n] << '\n';
    }
}
