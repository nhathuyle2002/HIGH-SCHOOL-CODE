#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
using namespace std;
//////

typedef long long LL;
typedef pair<long long, int> pLi;
const
    int maxn=1e5+100, base=211, modul=1e9+13;

int n, minL;
int len[maxn];
vector<LL> _hash[maxn];
LL _pow[maxn];
int m, cou;
pLi a[maxn];
bool d[maxn];
//////

void enter()
{
    n=0; minL=maxn;
    char s[maxn];

    while (scanf("%s\n", s+1)!=EOF)
    {
        ++n;
        len[n]=strlen(s+1);
        minL=min(minL, len[n]);
        _hash[n].push_back(0);
        forn(i, 1, len[n])
            _hash[n].push_back((_hash[n][i-1]*base+s[i]) % modul);
    }

    _pow[0]=1;
    forn(i, 1, maxn-1)
        _pow[i]=_pow[i-1]*base % modul;
}
//////

LL _get(int i, int L, int R)
{
    return (_hash[i][R]-_hash[i][L-1]*_pow[R-L+1]+1LL*modul*modul) % modul;
}

void process()
{
    int L=1, R=minL+1, mid;
    while (L<R)
    {
        mid=(L+R)/2;
        m=0;
        forn(i, 1, n)
            forn(j, mid, len[i]) a[++m]={_get(i, j-mid+1, j), i};
        sort(a+1, a+m+1);

        forn(i, 1, n) d[i]=false;

        bool ok=false;
        int l1=1, r1=1;
        while (l1<=m)
        {
            cou=0;
            while (r1<=m && a[r1].first==a[l1].first)
            {
                int pos=a[r1].second;
                if (d[pos]==false)
                {
                    d[pos]=true;
                    cou++;
                }
                r1++;
            }
            if (cou==n)
            {
                ok=true;
                break;
            } else
            {
                forn(i, l1, r1-1) d[a[i].second]=false;
                l1=r1;
            }
        }

        if (ok) L=mid+1; else R=mid;
    }

    cout << L-1;
}
//////

int main()
{
    freopen("lcs.inp", "r", stdin);
    freopen("lcs.out", "w", stdout);
    enter();
    process();
}
