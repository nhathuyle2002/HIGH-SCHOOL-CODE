#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
#define repn(i,a,b) for(int i=(a); i<(b); ++i)
using namespace std;
//////

typedef vector<long long> bignum;
const
    int maxn=10000, base=1e9;
int n, m;
int sum[maxn];
bignum ans[2][2*maxn+1];
#define ans(i,j) ans[i][(j)+maxn]
//////


void fix(bignum &a)
{
    long long mem=0;
    repn(i, 0, a.size())
    {
        a[i]=a[i]+mem;
        mem=a[i]/base;
        a[i]%=base;
        if (a[i]<0)
        {
            --mem;
            a[i]+=base;
        }
    }
    if (mem>0) a.push_back(mem);
    while (!a.empty() && a.back()==0) a.pop_back();
}

bignum change(int x)
{
    bignum a(1, x);
    fix(a);
    return a;
}

void write(bignum a)
{
    if (a.empty())
    {
        cout << 0;
        return;
    }
    cout << a.back();
    ford(i, int(a.size())-2, 0)
    {
        int cou=9, x=a[i];
        while (x)
        {
            --cou;
            x/=10;
        }
        if (cou==9) cou=8;
        while (cou--) cout << 0;
        cout << a[i];
    }
    cout << '\n';
}

bignum operator + (bignum a, bignum b)
{
    bignum c;
    repn(i, 0, max(a.size(), b.size()))
    {
        c.push_back(0);
        if (i<a.size()) c[i]+=a[i];
        if (i<b.size()) c[i]+=b[i];
    }
    fix(c);
    return c;
}

bignum operator - (bignum a, bignum b)
{
    bignum c;
    repn(i, 0, max(a.size(), b.size()))
    {
        c.push_back(0);
        if (i<a.size()) c[i]+=a[i];
        if (i<b.size()) c[i]-=b[i];
    }
    fix(c);
    return c;
}
//////

void enter()
{
    scanf("%d%d\n", &n, &m);
    sum[0]=0;
    forn(i, 1, n) sum[i]=sum[i-1]+i;
}
//////

void process()
{
    ans(0, 0)=change(1);
    forn(i, 1, n)
    {
        int i2=i&1;
        forn(j, -sum[i], sum[i])
        {
            ans(i2, j)=ans(1-i2, j);
            if (j-i>=-sum[i-1]) ans(i2, j)=ans(i2, j)+ans(1-i2, j-i);
            if (j+i<=sum[i-1]) ans(i2, j)=ans(i2, j)+ans(1-i2, j+i);
        }
    }
    write(ans(n&1, m));
}
//////

int main()
{
    freopen("balance.inp", "r", stdin);
    freopen("balance.out", "w", stdout);
    enter();
    process();
}
