#include <iostream>
#include <stdio.h>
#include <vector>
#include <map>
#define For(i,a,b) for(int i=a; i<=b; i++)

using namespace std;
const int N = 40;
int n, tests, ans;
int mau[N], c[N];
vector<int> e[N];
map<int, int> m;

int bit(int x, int i) {return (x >> (i-1)) & 1;}
void nhap()
{
    freopen("LAMPS.INP","r",stdin);
    freopen("LAMPS.OUT","w",stdout);
    scanf("%d%d", &n, &tests);
    int u, v;
    For(i,1,n-1)
    {
        scanf("%d%d\n", &u, &v);
        e[u].push_back(v);
        e[v].push_back(u);
    }
}
void update(int u, int c[])
{
    c[u]^= 1;
    For(i,0,(int)e[u].size()-1) c[e[u][i]]^= 1;
}
void xuly()
{
    int t = (1 << n/2)-1;
    For(x,0,t)
    {
        For(i,1,n) c[i] = mau[i];
        For(i,1,n/2)
            if (bit(x, i) == 1) update(i, c);
        int bt = 0;
        For(i,1,n) bt+= c[i] << (i-1);
        m[bt] = x;
    }
    ans = -1;
    t = (1 << (n - n/2)) - 1;
    For(x,0,t)
    {
        For(i,1,n) c[i] = 1;
        For(i,n/2+1, n)
            if (bit(x, i-n/2) == 1) update(i, c);
        int bt = 0;
        For(i,1,n) bt+= c[i] << (i-1);
        if (m.find(bt) != m.end())
        {
            ans = (x << (n/2) ) + m[bt];
            return;
        }
    }
}
void run()
{
    while (tests--)
    {
        For(i,1,n) scanf("%d", &mau[i]);
        m.clear();
        xuly();
        if (ans == -1) printf("-1\n");
        else
        {

            int kq = 0;
            For(i,1,n) kq+= bit(ans, i);
            printf("%d", kq);
            For(i,1,n)
                if (bit(ans, i) == 1) printf(" %d", i);
            printf("\n");

           // For(i,1,n) if (bit(ans, i) == 1) update(i, mau);
            //For(i,1,n) if (mau[i] == 0) printf("aasd\n");
        }
    }
}

int main()
{
    nhap();
    run();
    return 0;
}
