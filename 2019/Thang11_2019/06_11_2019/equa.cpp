#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
#define repn(i,a,b) for(int i=(a); i<(b); ++i)
using namespace std;
//////

const
    int maxn=2e3+100;
int n, top, res;
int A, B, C;
double ans[maxn];
//////

void ptb2()
{
    int delta=B*B-4*A*C;
    if (delta<0) return; else
    if (delta==0) ans[++top]=-1.0*B/(2*A); else
    {
        ans[++top]=(-B-sqrt(delta))/(2*A);
        ans[++top]=(-B+sqrt(delta))/(2*A);
    }
}

void ptb1()
{
    ans[++top]=-1.0*C/B;
}
//////

int main()
{
    freopen("equa.inp", "r", stdin);
    freopen("equa.out", "w", stdout);
    scanf("%d\n", &n);
    top=0;
    while (n--)
    {
        scanf("%d%d%d\n", &A, &B, &C);
        if (A==0 && B==0 && C==0) {cout << -1; return 0; } else
        if (A!=0) ptb2(); else
        if (B!=0) ptb1();
    }
    sort(ans+1, ans+top+1);
    ans[0]=1e9; res=0;
    forn(i, 1, top)
        if (ans[i]!=ans[i-1]) ++res;
    cout << res;
    return 0;
}
