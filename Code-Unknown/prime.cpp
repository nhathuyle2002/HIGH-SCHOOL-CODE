#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); i++)
#define ford(i,a,b) for(int i=(a); i>=(b); i--)

using namespace std;
//////

const
    int maxd=1e6+100, maxnt=32000;
int L, R;
bool nt[maxnt+1];
bool d[maxd];
int res;
//////

void init_prime()
{
    forn(i, 1, maxnt) nt[i]=true; d[1]=false;
    forn(i, 2, maxnt)
        if (nt[i])
        forn(j, i, maxnt/i) nt[i*j]=false;
}
//////

void process()
{
    scanf("%d%d", &L, &R);
    forn(i, 0, R-L) d[i]=true;
    forn(x, 2, maxnt)
        if (nt[x])
        {
            int i=R- L- R % x;
            while (i>=0 && sqrt(L+i)>=x)
            {
                d[i]=false;
                i-=x;
            }
        }
    res=0;
    forn(i, 0, R-L)
        if (d[i]) res++;
    cout << res;
}
//////

int main()
{
    freopen("prime.inp", "r", stdin);
    freopen("prime.out", "w", stdout);
    init_prime();
    process();
}
