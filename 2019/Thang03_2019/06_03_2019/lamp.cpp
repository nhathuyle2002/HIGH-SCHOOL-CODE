#include <iostream>
#include <stdio.h>
#include <vector>

using namespace std;
//////


typedef long long ll;
const   int maxn=1e5+10, maxn2=1e2+10, maxm=1e5+100;

int n, m;
int x[maxm], y[maxm];
//ll aa[maxn];
vector<int> e[maxn];
bool dd[maxn];
ll res;
//////

void enter()
{
    scanf("%d%d\n", &n, &m);
    for (int i=1; i<=m; i++)
        scanf("%d%d\n", &x[i], &y[i]);
}
//////

/*void process1()
{
    int d[maxn2][maxn2];
    for (int i=1; i<=n; i++)
        for (int j=1; j<=n; j++) d[i][j]=0;

    res=ll(n)*(n-1)*(n-2)/6;

    for (int t=1; t<=m; t++)
    {
        d[x[t]][y[t]]=1-d[x[t]][y[t]];
        int w=d[y[t]][x[t]]=d[x[t]][y[t]];

        for (int i=1; i<=n; i++)
            if (i!=x[t] && i!=y[t])
        {
            int w1=d[i][x[t]], w2=d[i][y[t]];
            if (w1==w2 && w2==w) res+=1; else
            if (w1==w2 && w2!=w) res-=1;
        }
        aa[t]=res;
        cout << res << '\n';
    }
}*/
//////

void process()
{
    for (int u=1; u<=n; u++)
    {
        e[u].clear();
        dd[u]=false;
    }

    res=ll(n)*(n-1)*(n-2)/6;

    for (int t=1; t<=m; t++)
    {
        int u=x[t], v=y[t];
        int cou0=n-2, cou1=0;

        int dt=-1;
        for (int i=0; i<e[u].size(); i++)
        {
            int y=e[u][i];
            if (y==v) dt=i; else
            {
                dd[y]=true;
                cou0--;
            }
        }
        if (dt!=-1)
        {
            swap(e[u].back(), e[u][dt]);
            e[u].pop_back();
        }
        else e[u].push_back(v);

        dt=-1;
        for (int i=0; i<e[v].size(); i++)
        {
            int y=e[v][i];
            if (y==u) dt=i; else
            {
                if (dd[y]) cou1++;
                else cou0--;
            }
        }
        if (dt!=-1)
        {
            swap(e[v].back(), e[v][dt]);
            e[v].pop_back();
        }
        else e[v].push_back(u);

        if (dt==-1) res=res-cou0+cou1; else res=res-cou1+cou0;

        //if (res!=aa[t]) cout << t << '\n';
        cout << res << '\n';

        dd[u]=false; dd[v]=false;
        for (int i=0; i<e[u].size(); i++)
            dd[e[u][i]]=false;
    }
}
//////

int main()
{
    freopen("lamp.inp", "r", stdin);
    freopen("lamp.out", "w", stdout);
    enter();
    //process1();
    process();
}
