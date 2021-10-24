#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
#define repn(i,a,b) for(int i=(a); i<(b); ++i)
using namespace std;
//////

const
    int maxn=3e5+100, maxn2=200, maxnt=46, base=123456789;

struct data
{
    int g[maxnt];
    void reset()
    {
        repn(i, 0, maxnt) g[i]=0;
    }
    int& operator[] (int i) {return g[i];}
};


int n;
int dprime[maxn2+1], pos_prime[maxn2+1];
int a[maxn];
vector<int> prime, Q;
int child[maxn][3];
data W[maxn];
//////

void init()
{
    forn(i, 1, maxn2) dprime[i]=i;
    forn(i, 2, maxn2)
        if (dprime[i]==i)
        {
            pos_prime[i]=prime.size();
            prime.push_back(i);
            for(int j=i*i; j<=maxn2; j+=i) dprime[j]=i;
        }
}
//////

void fastscan(int &number)
{
    number=0;
    register char c=getchar();
    while (c!='-' && (c<48 || c>57)) c=getchar();
    bool negative=false;
    if (c=='-') negative=true, c=getchar();
    for(; c>47 && c<58; c=getchar())
        number=number*10+c-48;
    if (negative) number=-number;
}

void enter()
{
    fastscan(n);
    forn(i, 1, 3*n+1) fastscan(a[i]);
    Q.clear(); Q.push_back(0);
    for(int i=1; i<=3*n+1; ++i)
    {
        int u=Q.back(); Q.pop_back();
        child[u][++child[u][0]]=i;
        if (a[i]==-1) continue;
        ++i; Q.push_back(i); Q.push_back(i-1);
        child[u][++child[u][0]]=i;
    }
}
//////

data convert(int x)
{
    data c; c.reset();
    while (x>1)
    {
        ++c[pos_prime[dprime[x]]];
        x/=dprime[x];
    }
    return c;
}

data operator* (data a, data b)
{
    data c; c.reset();
    repn(i, 0, maxnt) c[i]=a[i]+b[i];
    return c;
}

data operator/ (data a, data b)
{
    data c; c.reset();
    repn(i, 0, maxnt) c[i]=a[i]-b[i];
    return c;
}

data GCD (data a, data b)
{
    data c; c.reset();
    repn(i, 0, maxnt) c[i]=min(a[i], b[i]);
    return c;
}

data LCM (data a, data b)
{
    data c; c.reset();
    repn(i, 0, maxnt) c[i]=max(a[i], b[i]);
    return c;
}
//////

void dfs(int u)
{
    if (child[u][0]==1)
    {
        W[u]=convert(1);
        return;
    }
    int u1=child[u][1], u2=child[u][2];
    dfs(u1); dfs(u2);
    data d1=convert(a[u1]), d2=convert(a[u2]);
    W[u]=(W[u2]*d2)/(GCD(W[u1]*d1, W[u2]*d2))*W[u1]*convert(a[u1]+a[u2])/d2;
    //W[u]=LCM(W[u1]*d1, W[u2]*d2)/(W[u1]*d1)*convert(a[u1]+a[u2])/d2;
}

long long power(int a, int b)
{
    if (b==0) return 1%base;
    long long c=power(a, b>>1);
    c=c*c % base;
    if (b&1) c=c*a % base;
    return c;
}

void process()
{
    dfs(0);
    long long res=1;
    repn(i, 0, maxnt)
        res=res*power(prime[i], W[0][i]) % base;
    cout << res;
}
//////

int main()
{
    freopen("eureka.inp", "r", stdin);
    freopen("eureka.out", "w", stdout);
    init();
    enter();
    process();
}
