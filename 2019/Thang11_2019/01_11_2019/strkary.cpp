#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
#define repn(i,a,b) for(int i=(a); i<(b); ++i)
using namespace std;
//////

const
    int maxn=2e5+100;
const
    long long base=211, modul=1e9+7;
int n, res, top, ans[maxn];
char s[maxn];
long long _hash[maxn], _pow[maxn], b[maxn];
//////

void enter()
{
    scanf("%s", s+1); n=strlen(s+1);
    _hash[0]=0; _pow[0]=1;
    forn(i, 1, n)
    {
        _hash[i]=(_hash[i-1]*base+s[i]) % modul;
        _pow[i]=_pow[i-1]*base % modul;
    }
}
//////

long long _get(int L, int R)
{
    long long ans=_hash[R]-_hash[L-1]*_pow[R-L+1];
    return (ans+modul*modul) % modul;
}

void process()
{
    res=0;
    ford(len, n, 1)
    if (n%len==0)
    {
        top=0;
        forn(i, 1, len)
            b[++top]=(_get(i, len)*_pow[i-1]+_get(1, i-1)) % modul;
        sort(b+1, b+top+1);
        bool ok=true;
        for(int i=len+1; i<=n; i+=len)
        {
            long long H=_get(i, i+len-1);
            int pos=lower_bound(b+1, b+top+1, H)-b;
            if (pos>top || b[pos]!=H)
            {
                ok=false;
                break;
            }
        }
        if (ok) ans[++res]=n/len;
    }
    cout << res << '\n';
    forn(i, 1, res) cout << ans[i] << ' ';
}
//////

int main()
{
    freopen("strkary.inp", "r", stdin);
    freopen("strkary.out", "w", stdout);
    enter();
    process();
}
