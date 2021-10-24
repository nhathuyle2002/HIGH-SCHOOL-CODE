#include <iostream>
#include <stdio.h>
#define For(i,a,b) for(int i=a; i<=b; i++)

using namespace std;
const int N = 300100;
int e[N][4], d[N], dd[N], in_queue[N];
int n, r;

void nhap()
{
    freopen("GROUPDIV.INP","r",stdin);
    freopen("GROUPDIV.OUT","w",stdout);
    scanf("%d\n" , &n);
    For(i,1,n)
    {
        scanf("%d", &e[i][0]);
        For(j,1,e[i][0]) scanf("%d", &e[i][j]);
    }
}
void xuly()
{
    For(i,1,n)
        if (e[i][0] > 1)
        {
            d[++r] = i;
            in_queue[i] = true;
        }
    while (r)
    {
        int u = d[r], dem = 0;
        r--; in_queue[u] = false;
        For(i,1,e[u][0])
        {
            int v = e[u][i];
            if (dd[v] == dd[u]) dem++;
        }
        if (dem > 1)
        {
            dd[u]^= 1;
            For(i,1,e[u][0])
            {
                int v = e[u][i];
                if (dd[u] == dd[v] && !in_queue[v])
                {
                    int dem = 0;
                    For(j, 1, e[v][0])
                        if (dd[v] == dd[e[v][j]]) dem++;
                    if (dem < 2) continue;
                    in_queue[v] = true;
                    d[++r] = v;
                }
            }
        }
    }
}
int main()
{
    nhap();
    xuly();
    printf("YES\n");
    For(i,1,n)
        if (dd[i] == 0) cout << i << ' ';//printf("%d ", i);
    printf("\n");
    For(i,1,n)
        if (dd[i] == 1) cout << i << ' ';//printf("%d ", i);
    return 0;
}
