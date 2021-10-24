#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
#define repn(i,a,b) for(int i=(a); i<(b); ++i)
using namespace std;
//////

const
    int maxn=1e6+100, base=1e9+7;
int nTest, n;
char s[maxn];
long long GT[maxn], phiGT[maxn];
long long res;
//////

void enter()
{
    n=0;
    register char c=getchar();
    for(; c=='(' || c==')'; c=getchar()) s[++n]=c;
}
//////

long long power(long long &a, long long b)
{
    if (b==0) return 1;
    long long c=power(a, b>>1);
    c=c*c % base;
    if (b&1) c=c*a % base;
    return c;
}

void init2()
{
    GT[0]=1;
    forn(i, 1, 5e5+2)
        GT[i]=GT[i-1]*i % base;
    phiGT[0]=1;
    forn(i, 1, 5e5+2)
        phiGT[i]=power(GT[i], base-2);
}
//////

void process()
{
    res=0;
    int a=n/2, b=n/2;
    forn(len, 1, n)
        if (s[len]=='(') a--; else
        {
            if (a>0) res=(res+GT[(a-1)+b]*(b+1-(a-1))%base*phiGT[a-1]%base*phiGT[b+1]%base) % base;
            b--;
        }
    cout << (res+1)%base << '\n';
}
//////

int main()
{
    freopen("brorder.inp", "r", stdin);
    freopen("brorder.out", "w", stdout);
    init2();
    scanf("%d\n", &nTest);
    while (nTest--)
    {
        enter();
        process();
    }
}
