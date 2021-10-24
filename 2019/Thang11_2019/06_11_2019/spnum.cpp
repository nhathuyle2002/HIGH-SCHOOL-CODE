#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
#define repn(i,a,b) for(int i=(a); i<(b); ++i)
using namespace std;
//////

const
    int maxs=135, maxn=1e7, maxn2=1e5;
int nTest;
long long f[16][10][maxs+1], fsum[16][10][maxs+1];
bool prime[maxs+1];
long long PA, PB;
int len, a[16];
int choose_sqr[maxn+1], Sx[maxn2+1];
long long ans;
//////

inline void fastscan(long long &number)
{
    number=0;
    register char c=getchar();
    while (c<48 || c>57) c=getchar();
    for(; c>47 && c<58; c=getchar())
        number=number*10+c-48;
}
//////

void init()
{
    forn(s, 1, maxs) prime[s]=true;
    prime[0]=false; prime[1]=false;
    forn(s, 2, maxs)
        if (prime[s])
            forn(t, s, maxs/s) prime[s*t]=false;

    Sx[0]=0;
    forn(i, 1, maxn2) Sx[i]=Sx[i/10]+i%10;

    choose_sqr[0]=0;
    forn(x, 1, maxn)
    {
        choose_sqr[x]=choose_sqr[x-1];
        long long y=1LL*x*x;
        int sumx=0;
        while (y>0)
        {
            sumx+=Sx[y%maxn2];
            y/=maxn2;
        }
        if (prime[sumx]) ++choose_sqr[x];
    }

    f[0][0][0]=1;
    forn(i, 1, 15)
        forn(x, 0, 9)
        {
            forn(s, 0, maxs)
            {
                f[i][x][s]=0;
                forn(x2, 0, 9)
                    if (x<=s) f[i][x][s]+=f[i-1][x2][s-x];
            }
            forn(s, 0, maxs)
            {
                fsum[i][x][s]=0;
                if (x>0) fsum[i][x][s]+=fsum[i][x-1][s];
                forn(sumx, 0, maxs)
                    if (s+sumx>maxs) break; else
                    if (prime[s+sumx]) fsum[i][x][s]+=f[i][x][sumx];
            }
        }
}
//////

inline long long getnum(long long R)
{
    len=0;
    while (R>0) a[++len]=R%10, R/=10;

    ans=0; int sum=0;
    ford(i, len, 1)
    {
        if (a[i]>0) ans+=fsum[i][a[i]-1][sum];
        sum+=a[i];
    }
    return ans;
}

inline long long sqr_cou(long long x)
{
    return choose_sqr[int(sqrt(x))];
}
//////

int main()
{
    freopen("spnum.inp", "r", stdin);
    freopen("spnum.out", "w", stdout);

    init();

    scanf("%d\n", &nTest);
    while (nTest--)
    {
        fastscan(PA); fastscan(PB);
        cout << getnum(PB+1)-sqr_cou(PB)-getnum(PA)+sqr_cou(PA-1)<< '\n';
    }
}
