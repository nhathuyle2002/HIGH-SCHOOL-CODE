#include <bits/stdc++.h>
#define forn(i, a, b) for (int i=(a); i<=(b); ++i)
#define ford(i, a, b) for (int i=(a); i>=(b); --i)
using namespace std;
//////

const
    int maxn=1e5+100, maxl=4, base=1e9;

struct bignum
{
    long long g[maxl+1];
};
bignum bdoi(int x)
{
    bignum c;
    c.g[0]=0;
    while (x>0)
    {
        c.g[0]++;
        c.g[c.g[0]]=x % base;
        x/=base;
    }
    return c;
}

bignum operator + (bignum a, bignum b)
{
    bignum c;
    int nho=0;
    c.g[0]=max(a.g[0], b.g[0]);
    forn(i, 1, c.g[0])
    {
        if (i>a.g[0]) a.g[i]=0;
        if (i>b.g[0]) b.g[i]=0;
        c.g[i]=a.g[i]+b.g[i]+nho;
        nho=c.g[i]/base;
        c.g[i]=c.g[i] % base;
    }
    if (nho>0)
    {
        c.g[0]++;
        c.g[c.g[0]]=nho;
    }
    return c;
}
bignum operator * (bignum a, bignum b)
{
    bignum c;
    c.g[0]=a.g[0]+b.g[0];
    forn(i, 1, c.g[0]) c.g[i]=0;
    forn(i, 1, a.g[0])
    {
        long long nho=0;
        forn(j, 1, b.g[0])
        {
            c.g[i+j-1]+=a.g[i]*b.g[j]+nho;
            nho=c.g[i+j-1]/base;
            c.g[i+j-1]=c.g[i+j-1] % base;
        }
        forn(j, i+b.g[0], c.g[0])
        {
            c.g[j]+=nho;
            nho=c.g[j]/base;
            c.g[j]=c.g[j] % base;
        }
    }
    while (c.g[0]>0 && c.g[c.g[0]]==0) c.g[0]--;
    return c;
}

void prbignum(bignum c)
{
    cout << c.g[c.g[0]];
    ford(i, c.g[0]-1, 1)
    {
        int cou=0, x=c.g[i];
        if (x==0) cou=1; else
        while (x>0)
        {
            cou++;
            x/=10;
        }
        forn(i, 1, 9-cou) cout << 0;
        cout << c.g[i];
    }
}

int n;
int c[26][26];
bignum res;
//////

void enter()
{
    char s[11];
    scanf("%d\n", &n);
    forn(i, 1, n)
    {
        scanf("%s\n", s+1);
        c[s[1]-'A'][s[strlen(s+1)]-'A']++;
    }
}
//////

void process()
{
    res=bdoi(0);
    forn(x, 0, 25)
    forn(y, 0, 25)
    forn(z, 0, 25)
    forn(t, 0, 25)
    {
        bignum cou=bdoi(1);
        cou=cou*bdoi(c[x][y]); c[x][y]--;
        if (c[x][z]>=0) cou=cou*bdoi(c[x][z]); c[x][z]--;
        if (c[y][t]>=0) cou=cou*bdoi(c[y][t]); c[y][t]--;
        if (c[z][t]>=0) cou=cou*bdoi(c[z][t]);
        res=res+cou;
        c[x][y]++;
        c[x][z]++;
        c[y][t]++;
    }
    prbignum(res);
}
//////

int main()
{
    freopen("cwords.inp", "r", stdin);
    freopen("cwords.out", "w", stdout);
    enter();
    process();
}
