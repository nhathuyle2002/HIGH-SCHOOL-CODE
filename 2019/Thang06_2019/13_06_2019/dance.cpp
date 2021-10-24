#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
using namespace std;
//////

const
    int maxn=1e6+100;
int n;
int s[maxn], d[2*maxn];
long long res;
//////

void enter()
{
    scanf("%d\n", &n);
    res=0;
    s[0]=maxn; d[s[0]]++;
    forn(i, 1, n)
    {
        char x;
        scanf("%c", &x);
        if (x=='a') s[i]=s[i-1]+1; else s[i]=s[i-1]-1;
        res+=d[s[i]];
        d[s[i]]++;
    }
}
//////

void process()
{
    cout << res;
}
//////

int main()
{
    freopen("dance.inp", "r", stdin);
    freopen("dance.out", "w", stdout);
    enter();
    process();
}
