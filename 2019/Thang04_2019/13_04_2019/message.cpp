#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
using namespace std;
//////

typedef long long LL;
const
    int maxn=1e5+100, oo=1e6;
int T, n, L;
LL M;
char a[55], b[55];
LL pw[maxn];
int d[55][27];
LL f[maxn][55], sum[maxn];
LL res;
//////

void enter()
{
    scanf("%d%lld\n", &n, &M);
    scanf("%s\n", a+1); L=strlen(a+1);
}
//////

bool check(int x, int y)
{
    int j=0;
    forn(i, x, y)
    {
        j++;
        if (b[i]!=a[j]) return false;
    }
    return true;
}

int calc(int l, char x)
{
    forn(i, 1, l) b[i]=a[i];
    b[++l]=x;
    forn(i, 1, l)
        if (check(i, l)) return l-i+1;
    return 0;
}

void init()
{
    pw[0]=1 % M;
    forn(i, 1, n-L) pw[i]=pw[i-1]*26 % M;
    forn(x, 'a', 'z') d[0][x-'a']=0;
    d[0][a[1]-'a']=1;
    forn(i, 1, L)
        forn(x, 'a', 'z')
            d[i][x-'a']=calc(i, x);
}
//////

LL modul(LL a, LL b, LL M)
{
    if (a==0) return 0;
    return (modul(a/10, b*10 % M, M) + a%10 * b % M) % M;
}

void process()
{
    forn(i, 0, n-L)
    {
        sum[i]=0;
        forn(j, 0, L) f[i][j]=0;
    }
    f[0][L]=1 % M;
    forn(i, 0, n-L)
        forn(j, 0, L)
        if (f[i][j]>0)
        {
            sum[i]=(sum[i]+f[i][j]) % M;
            forn(x, 'a', 'z')
                if (d[j][x-'a']<L)
                f[i+1][d[j][x-'a']]=(f[i+1][d[j][x-'a']]+f[i][j]) % M;
        }
    res=0;
    forn(i, 0, n-L)
        res=(res+modul(sum[n-i-L], pw[i], M)) % M;
    cout << res << '\n';
}
//////

int main()
{
    freopen("message.inp", "r", stdin);
    freopen("message.out", "w", stdout);
    scanf("%d\n", &T);
    while (T--)
    {
        enter();
        init();
        process();
    }
}
