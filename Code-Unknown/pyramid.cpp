#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); i++)
#define ford(i,a,b) for(int i=(a); i>=(b); i--)

using namespace std;
//////

const
    int maxn=1e4+100, maxchar=25;
int n, m;
char S[maxn];
int f[maxn][maxchar+1];
///////

void enter()
{
    scanf("%s\n", S+1); n=strlen(S+1);
    forn(i, 1, n)
    {
        forn(x, 0, 25) f[i][x]=f[i-1][x];
        f[i][S[i]-'A']++;
    }
}
///////

void process()
{
    scanf("%d\n", &m);
    while (m--)
    {
        int k; char cc;
        scanf("%d %c\n", &k, &cc);
        int c=cc-'A';
        int posd=1+1LL*k*(k-1)/2 % n;
        if (n-posd+1>=k)
        {
            cout << f[posd+k-1][c]-f[posd-1][c] << '\n';
            continue;
        }
        long long sum=f[n][c]-f[posd-1][c];
        k-=n-posd+1;
        sum+=1LL*(k/n)*f[n][c];
        k=k % n;
        sum+=f[k][c];
        cout << sum << '\n';
    }
}
///////

int main()
{
    freopen("pyramid.inp", "r", stdin);
    freopen("pyramid.out", "w", stdout);
    enter();
    process();
}
