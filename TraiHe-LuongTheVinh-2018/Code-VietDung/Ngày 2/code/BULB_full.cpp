#include <iostream>
#include <stdio.h>
#include <vector>
#define For(i,a,b) for(int i=a; i<=b; i++)
#define x first
#define y second
#define mp make_pair

using namespace std;
const int N = 10010, K = 30010;
typedef pair<int, int> data;
vector<data> e[N];
int r, m, n, k, a[N], dd[N], dem, kt[K];
bool found;

void nhap()
{
    freopen("BULB.INP","r",stdin);
    freopen("BULB.OUT","w",stdout);
    scanf("%d%d%d\n", &m, &n, &k);
    string ta, tb;
    getline(cin, ta);
    getline(cin, tb);
    For(i,0,ta.length()-1)
        if (ta[i] != tb[i]) a[i+1] = 1;
    int u, v;
    For(i,1,k)
    {
        scanf("%d%d\n", &u, &v);
        e[v+m].push_back(mp(u, i));
        e[u].push_back(mp(v+m, i));
    }
}
void dfs(int u)
{
    if (a[u] == 1)
    {
        a[u] = 0;
        found = true; return;
    }
    dd[u] = dem;
    For(i,0,(int)e[u].size()-1)
    {
        int v = e[u][i].x, t = e[u][i].y;
        if (dd[v] < dem)
        {
            dfs(v);
            if (found)
            {
                r-= kt[t] - (kt[t]^1);
                kt[t]^= 1;
                break;
            }
        }
    }
}
void xuly()
{
    n+= m;
    For(u,1,n)
        if (a[u] == 1)
        {
            found = false;
            a[u] = 0;  dem++;
            dfs(u);
            if (!found)
            {
                printf("-1"); return;
            }
        }
    printf("%d\n", r);
    For(i,1,k) if (kt[i]) printf("%d ", i);
}
int main()
{
    nhap();
    xuly();
    return 0;
}
