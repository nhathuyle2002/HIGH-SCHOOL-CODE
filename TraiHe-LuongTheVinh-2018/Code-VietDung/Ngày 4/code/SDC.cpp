#include <iostream>
#include <stdio.h>
#include <vector>
#define For(i,a,b) for(int i=a; i<=b; i++)

using namespace std;
const int N = 1010;
int n, m, a, b, s[N], u[10*N], v[10*N], c[10*N];
void nhap()
{
    freopen("SDC.INP","r",stdin);
    freopen("SDC.OUT","w",stdout);
    scanf("%d%d%d%d", &n, &m, &a, &b);
    For(i,1,m)
    {
        scanf("%d%d%d\n", &u[i], &v[i], &c[i]);

    }
}
void xuly()
{
    bool found; int dem = 0;
    For(i,1,n) s[i] = a;
    do{
        found = false;
        if (++dem > n)
        {
            printf("NO"); return;
        }
        For(i,1,m)
            if (s[v[i]] - s[u[i]] > c[i])
            {
                s[u[i]] = s[v[i]] - c[i];
                found = true;
                if (s[u[i]] > b)
                {
                    printf("NO"); return;
                }
            }
    } while (found);
    printf("YES\n");
    For(i,1,n) printf("%d ", s[i]);
}

int main()
{
    nhap();
    xuly();
    return 0;
}
