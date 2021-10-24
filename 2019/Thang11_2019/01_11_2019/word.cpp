#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
#define repn(i,a,b) for(int i=(a); i<(b); ++i)
using namespace std;
//////

const
    int maxn=1e2+100, maxm=1e5+100;
int n, m, top, res;
int a[maxn][maxn];
int len[maxm], nc;
long long _hash[maxm], b[maxm];
long long c[maxm];
//////

void enter()
{
    scanf("%d\n", &n);
    forn(i, 1, n)
    {
        forn(j, 1, n) scanf("%d", &a[i][j]);
        scanf("\n");
    }
    scanf("%d\n", &m);
    register char x;
    forn(i, 1, m)
    {
        x=getchar();
        len[i]=0; _hash[i]=0;
        for(; x>='0' && x<='1'; x=getchar())
        {
            ++len[i];
            _hash[i]+=_hash[i]+x-48;
        }
    }
}
//////

long long _get(int i, int L, int R)
{
    long long ans=0;
    forn(j, L, R)
        ans+=ans+a[i][j];
    return ans;
}

void process()
{
    res=0;
    forn(leng, 1, 50)
    {
        top=0;
        forn(i, 1, n)
            forn(j, 1, n-leng+1) b[++top]=_get(i, j, j+leng-1);
        sort(b+1, b+top+1);
        nc=0; c[0]=-1;
        forn(i, 1, m)
            if (len[i]==leng) c[++nc]=_hash[i];
        sort(c+1, c+nc+1);
        forn(i, 1, nc)
            if (c[i]!=c[i-1])
                res+=upper_bound(b+1, b+top+1, c[i])-lower_bound(b+1, b+top+1, c[i]);
    }
    cout << res;
}
//////

int main()
{
    freopen("word.inp", "r", stdin);
    freopen("word.out", "w", stdout);
    enter();
    process();
}
