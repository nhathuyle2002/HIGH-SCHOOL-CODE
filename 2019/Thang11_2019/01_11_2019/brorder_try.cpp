#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
#define repn(i,a,b) for(int i=(a); i<(b); ++i)
using namespace std;
//////

const
    int maxn=1e6+100, maxn2=5000, base=1e9+7;
int nTest, n;
char s[maxn];
int f2[maxn2+1][maxn2+1];
long long GT[maxn];
long long res;
//////

void enter()
{
    n=0;
    register char c=getchar();
    for(; c=='(' || c==')'; c=getchar()) s[++n]=c;
}
//////

void init2()
{
    f2[0][0]=1;
    forn(i, 1, maxn2)
        forn(j, 0, i)
        {
            f2[i][j]=f2[i-1][j];
            if (j>0) f2[i][j]=(f2[i][j]+f2[i][j-1]) % base;
        }

    GT[0]=1;
    forn(i, 1, 1e6)
        GT[i]=GT[i-1]*i % base;
}

void process2()
{
    res=0;
    int u=n/2, v=n/2;
    forn(len, 1, n)
        if (s[len]=='(') v--; else
        {
            if (v>0) res=(res+f2[u][v-1]);
            u--;
        }
    cout << (res+1)%base << '\n';
}
//////

long long power(long long a, long long b)
{
    if (b==0) return 1;
    long long c=power(a, b>>1);
    c=c*c % base;
    if (b&1) c=c*a % base;
    return c;
}

void process()
{
    res=0;
    int a=n/2, b=n/2;
    forn(len, 1, n)
        if (s[len]=='(') a--; else
        {
            if (a>0) res+=GT[(a-1)+b]*(b+1-(a-1))%base*power(GT[a-1], base-2)%base*power(GT[b+1], base-2)%base;
            b--;
        }
    cout << (res+1) << '\n';
}
//////

int main()
{
    freopen("brorder.inp", "r", stdin);
    freopen("brorder_try.out", "w", stdout);
    scanf("%d\n", &nTest);
    while (nTest--)
    {
        init2();
        enter();
        //process();
        if (n/2<=maxn2) process2();
    }
}
