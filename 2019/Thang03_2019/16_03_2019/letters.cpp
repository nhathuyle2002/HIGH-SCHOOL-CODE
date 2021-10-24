#include <iostream>
#include <stdio.h>
#include <string.h>

using namespace std;
//////

const
    int maxn=4e2+10;

int n, m, k;
char a[maxn][maxn];
int da[maxn][maxn];
int d[maxn];
long long res;
//////

void enter()
{
    scanf("%d%d%d\n", &n, &m, &k);
    for (int i=1; i<=n; i++)
    {
        scanf("%s", a[i]+1);
        for (int j=1; j<=m; j++)
        {
            da[i][j]=da[i][j-1];
            if (a[i][j]=='a') da[i][j]++;
        }
    }
}
//////

void process()
{
    res=0;
    for (int y1=1; y1<=m; y1++) for (int y2=y1+1; y2<=m; y2++)
    {
        for (char x='a'; x<='z'; x++) d[x-'a']=0;
        int x2=1, sum=0;
        for (int x1=1; x1<=n; x1++)
        {
            while (x2<=n && sum+da[x2][y2]-da[x2][y1-1]<=k)
            {
                sum+=da[x2][y2]-da[x2][y1-1];
                if (a[x2][y1]==a[x2][y2]) d[a[x2][y1]-'a']++;
                x2++;
            }
            if (a[x1][y1]==a[x1][y2])
            {
                d[a[x1][y1]-'a']--;
                res+=d[a[x1][y1]-'a'];
            }
            sum-=da[x1][y2]-da[x1][y1-1];
        }
    }
    cout << res;
}
//////

int main()
{
    freopen("letters.inp", "r", stdin);
    freopen("letters.out", "w", stdout);
    enter();
    process();
}
