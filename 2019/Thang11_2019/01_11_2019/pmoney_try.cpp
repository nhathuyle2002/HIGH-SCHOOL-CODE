#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
#define repn(i,a,b) for(int i=(a); i<(b); ++i)
using namespace std;
//////

const
    int maxn=5e3+100;
const
    long long oo=1e13;
int n;
char a[maxn];
long long f1[maxn][maxn], f2[maxn][maxn];
//////

void enter()
{
    n=0;
    register char c=getchar();
    for(; c!=EOF && c!='\n' && c!=' '; c=getchar())
        a[++n]=c;
}
//////

void process()
{
    forn(i, 0, n)
        forn(j, 0, n+1) f1[i][j]=-oo, f2[i][j]=oo;

    f1[0][0]=0; f2[0][0]=0;
    forn(i, 1, n)
        forn(j, 0, i)
        {
            if (a[i]=='+') {if (j>0) f1[i][j]=f1[i-1][j-1]+j;} else
            if (a[i]=='-') f1[i][j]=f1[i-1][j+1]+j; else
            if (a[i]=='0') f1[i][j]=f1[i-1][j]+j; else
            {
                f1[i][j]=max(f1[i-1][j], f1[i-1][j+1]);
                if (j>0) f1[i][j]=max(f1[i][j], f1[i-1][j-1]);
                f1[i][j]+=j;
            }

            if (a[i]=='+') {if (j>0) f2[i][j]=f2[i-1][j-1]+j;} else
            if (a[i]=='-') f2[i][j]=f2[i-1][j+1]+j; else
            if (a[i]=='0') f2[i][j]=f2[i-1][j]+j; else
            {
                f2[i][j]=min(f2[i-1][j], f2[i-1][j+1]);
                if (j>0) f2[i][j]=min(f2[i][j], f2[i-1][j-1]);
                f2[i][j]+=j;
            }
        }
    if (f2[n][0]>=oo) cout << "NIE"; else cout << f2[n][0] << ' ' << f1[n][0];
}
//////

int main()
{
    freopen("pmoney.inp", "r", stdin);
    freopen("pmoney_try.out", "w", stdout);
    enter();
    process();
}
