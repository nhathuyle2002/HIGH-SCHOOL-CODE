#include <iostream>
#include <stdio.h>
#include <math.h>
#define For(i,a,b) for(int i=a; i<=b; i++)
#define Fod(i,a,b) for(int i=a; i>=b; i--)

using namespace std;
const int N = 2e6+1;
int dd[N+2], n;

void nhap()
{
    freopen("GROUP.INP","r",stdin);
    freopen("GROUP.OUT","w",stdout);
    scanf("%d", &n);
}
void snt()
{
    int sq = sqrt(2*n);
    For(i,2,sq)
        if (!dd[i])
        {
            int j = i*i;
            while (j <= 2*n)
            {
                dd[j] = 1; j+= i;
            }
        }
}
void ptich(int n)
{
    if (n == 0) return;
    Fod(i,n-1,1)
        if (!dd[n+i])
        {
            For(j,i,(n+i)/2) printf("%d %d\n", j, n-j+i);
            ptich(i-1);
            break;
        }
}

int main()
{
    nhap();
    snt();
    n-= n% 2;
    printf("%d\n", n/2);
    ptich(n);
    return 0;
}
