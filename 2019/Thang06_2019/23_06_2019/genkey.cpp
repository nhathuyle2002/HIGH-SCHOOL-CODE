#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
using namespace std;
//////

const
    int maxn=2e5+100;
int n, a, b, c;
char s[maxn];
int _fz[maxn];
long long f[maxn];
//////

void enter()
{
    scanf("%d\n", &n);
    scanf("%s\n", s+1);
    scanf("%d%d%d", &a, &b, &c);
}
//////

void init()
{
    _fz[1]=0;
    int L=1, R=1;
    forn(i, 2, n)
    {
        _fz[i]=0;
        if (i<=R) _fz[i]=min(R-i+1, _fz[i-L+1]);
        while (i+_fz[i]<=n && s[i+_fz[i]]==s[1+_fz[i]]) _fz[i]++;
        if (i+_fz[i]>R)
        {
            R=i+_fz[i]; L=i;
        }
    }
}
//////

void process()
{
    f[0]=0;
    int _pos=1;
    forn(i, 1, n)
    {
        _pos=max(_pos, (i+1)/2);
        while (_pos<i && _pos+_fz[_pos]<i) _pos++;
        f[i]=f[i-1]+a;
        if (_pos<i) f[i]=min(f[i], f[_pos-1]+b+1LL*((_pos-1)*2-i)*c);
    }
    cout << f[n];
}
//////

int main()
{
    freopen("genkey.inp", "r", stdin);
    freopen("genkey.out", "w", stdout);
    enter();
    init();
    process();
}
