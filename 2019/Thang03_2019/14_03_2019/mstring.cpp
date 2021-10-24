#include <iostream>
#include <stdio.h>
#include <string.h>

using namespace std;
//////

const
    int maxn=2e3+10, base=1e9+7;

int n;
char s[maxn];
int f[maxn][maxn];
//////

void enter()
{
    scanf("%s", s+1);
    n=strlen(s+1);
}
//////

void process()
{
    for (int i=1; i<=n; i++) for (int j=1; j<=n; j++)
    {
        f[i][j]=f[i-1][j]+f[i][j-1]-f[i-1][j-1];
        if (s[i]==s[j]) f[i][j]+=f[i-1][j-1]+1;
        f[i][j]=(f[i][j] % base +base) % base;
    }
    cout << f[n][n];
}

int main()
{
    freopen("mstring.inp", "r", stdin);
    freopen("mstring.out", "w", stdout);
    enter();
    process();
}
