#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
#define repn(i,a,b) for(int i=(a); i<(b); ++i)
using namespace std;
//////

typedef vector<long long> bignum;
const
    int maxn=10000, base=1e9;
int n;
bignum res;
int d[3][3];
bool khonglam[9];
bignum ans[maxn][3];
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
    scanf("%d\n", &n);
    char x;
    forn(i, 0, 2)
        forn(j, 0, 3)
        {
            x=getchar();
            if (j<3 && x=='Y') d[i][j]=1; else
            if (j<3 && x=='N') d[i][j]=0;
        }
    khonglam[1]=true; khonglam[2]=true; khonglam[5]=true;
}
//////

void ccl()
{
    forn(i, 1, n)
        forn(j, 0, 2)
            ans[i][j].clear();
    forn(j, 0, 2) ans[1][j]=change(1);
    forn(i, 2, n)
        forn(j, 0, 2)
            forn(j2, 0, 2)
                if (d[j][j2])
                    ans[i][j]=ans[i][j]+ans[i-1][j2];
}

void dequy(int typ, int last)
{
    ccl();
    bignum sum=ans[n][0]+ans[n][1]+ans[n][2];
    if (sum.empty()) return;
    if (typ==1) res=res+sum;
    else res=res-sum;

    ford(t, last-1, 0)
    {
        int i=t/3, j=t%3;
        if (!khonglam[t] && d[i][j])
        {
            d[i][j]=0; d[j][i]=0;
            dequy(-typ, t);
            d[i][j]=1; d[j][i]=1;
        }
    }
}

void process()
{
    res.clear();
    dequy(1, 9);
    write(res);
}
//////

int main()
{
    freopen("nrow.inp", "r", stdin);
    freopen("nrow.out", "w", stdout);
    enter();
    process();
}
