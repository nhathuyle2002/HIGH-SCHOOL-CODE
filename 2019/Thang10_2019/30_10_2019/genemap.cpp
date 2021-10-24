#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
#define repn(i,a,b) for(int i=(a); i<(b); ++i)
using namespace std;
//////

typedef pair<long long, long long> pLL;
const
    int maxn=1e5+100, maxlen=210, base=211, modul=1e9+7;
int n, K, ns;
char s[maxlen];
long long pow_[maxlen];
int cou;
pLL a[maxn];
long long res;
//////

long long get_hash(int L, int R)
{
    long long ans=0;
    forn(i, L, R)
        ans=(ans*base+s[i]) % modul;
    return ans;
}

void enter()
{
    scanf("%d%d\n", &n, &K);
    pow_[0]=1;
    forn(i, 1, K+1) pow_[i]=pow_[i-1]*base % modul;

    cou=0;
    forn(i, 1, n)
    {
        scanf("%s\n", s+1); ns=strlen(s+1);
        if (ns<K) continue;
        s[0]='@'; s[ns+1]='@';
        ++cou;
        a[cou].first=get_hash(1, K)*pow_[K]+get_hash(ns-K+1, ns);
        if (ns==K) a[cou].second=-cou; else a[cou].second=get_hash(1, K+1)*pow_[K+1]+get_hash(ns-K, ns);
    }
    sort(a+1, a+cou+1);
}
//////

void process()
{
    res=0;
    int j=1, i2=1;
    forn(i, 1, cou)
    {
        for(; j<=cou; ++j)
            if (a[j].first==a[i].first) break;
        for(; i2<=cou; ++i2)
            if (a[i2]==a[i]) break;
        res+=i2-j;
    }
    cout << res % modul;
}
//////

int main()
{
    freopen("genemap.inp", "r", stdin);
    freopen("genemap.out", "w", stdout);
    enter();
    process();
}
