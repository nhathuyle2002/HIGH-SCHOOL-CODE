#include <iostream>

using namespace std;
////////

const
    int maxn=5e3+100;

int n;
int a[maxn];
int f[maxn][maxn];
////////

void enter()
{
    scanf("%d", &n);
    for (int i=1; i<=n; i++) scanf("%d", &a[i]);
    int nn=n;
    n=1;
    for (int i=2; i<=nn; i++)
    {
        if (a[i]==a[n]) continue;
        n++;
        a[n]=a[i];
    }
}
////////

void process()
{
    for (int leng=2; leng<=n; leng++)
        for (int i=1; i<=n-leng+1; i++)
        {
            int j=i+leng-1;
            f[i][j]=min(f[i+1][j], f[i][j-1])+1;
            if (a[i]==a[j]) f[i][j]=min(f[i][j], f[i+1][j-1]+1);
        }
    cout << f[1][n];
}
////////

int main()
{
    enter();
    process();
}
