#include <iostream>
#include <stdio.h>
#include <vector>

using namespace std;
//////

typedef pair<int, int> pii;
const
    int maxn=1e6+100, STEP=100;
int T, n, k;
long long res;
int a[maxn];
int d[2*maxn];
vector<pii> query[maxn];
vector<int> val;
//////

void enter()
{
    scanf("%d%d\n", &n, &k);
    for (int i=1; i<=n; i++) scanf("%d", &a[i]);
    scanf("\n");
}
//////

void add_query(int L, int R, int x)
{
    if (L>R) return;
    query[L].push_back(pii(x, 1));
    query[R+1].push_back(pii(x, -1));
}

void answer_query(int pos)
{
    for (int i=0; i<query[pos].size(); i++)
    {
        pii p=query[pos][i];
        res+=1LL*p.second*d[p.first];
    }
}

void clear_query(int L, int R)
{
    for (int i=0; i<val.size(); i++) d[val[i]]=0;
    val.clear();
    for (int i=L; i<=R+1; i++) query[i].clear();
}

void solve(int L, int R)
{
    int gmax, gmin, gmax2, gmin2, i, j, j2, mid;

    if (R-L+1<k) return;
    if (R-L+1<=STEP)
    {
        for (i=L; i<=R-k+1; i++)
        {
            gmax=0; gmin=n+1;
            for (j=i; j<=R; j++)
            {
                gmax=max(gmax, a[j]);
                gmin=min(gmin, a[j]);
                if (j-i+1>=k && gmax-gmin==j-i) res++;
            }
        }
        return;
    }
    mid=(L+R) >> 1;
    //Case 1: max in [mid+1, R], min in [mid+1, R]
    j=mid+1; gmax=0, gmin=n+1;
    for (i=mid+1; i<=R; i++)
    {
        gmax=max(gmax, a[i]);
        gmin=min(gmin, a[i]);
        while (j>L && a[j-1]<gmax && a[j-1]>gmin) j--;
        if (j<mid+1 && i-j==gmax-gmin && i-j+1>=k) res++;
    }
    //Case 2: max in [L, mid], min in [L, mid]
    j=mid; gmax=0; gmin=n+1;
    for (i=mid; i>=L; i--)
    {
        gmax=max(gmax, a[i]);
        gmin=max(gmin, a[i]);
        while (j<R && a[j+1]<gmax && a[j+1]>gmin) j++;
        if (j>mid && j-i==gmax-gmin && j-i+1>=k) res++;
    }
    //Case 3: max in [mid+1, R], min in [L, mid]
    j=mid+1; j2=mid+1; gmax=0; gmin=n+1; gmin2=n+1;
    for (i=mid+1; i<=R; i++)
    {
        gmax=max(gmax, a[i]);
        gmin=min(gmin, a[i]);
        while (j>L && a[j-1]<gmax) j--;
        while (j2>L && gmin2>gmin)
        {
            j2--;
            gmin2=min(gmin2, a[j2]);
        }
        add_query(j, min(j2, i-k+1) , gmax-i+maxn);
    }
    gmin2=n+1;
    for (i=mid; i>=L; i--)
    {
        gmin2=min(gmin2, a[i]);
        val.push_back(gmin2-i+maxn);
        d[val.back()+maxn]++;
        answer_query(i);
    }
    clear_query(L, mid);
    //Case 4: min in [mid+1, R], max in [L, mid]
    j=mid+1; j2=mid+1; gmax=0; gmin=n+1; gmax2=0;
    for (i=mid+1; i<=R; i++)
    {
        gmax=max(gmax, a[i]);
        gmin=min(gmin, a[i]);
        while (j>L && a[j-1]>gmin) j--;
        while (j2>L && gmax2<gmax)
        {
            j2--;
            gmax2=max(gmax2, a[j2]);
        }
        add_query(j, min(j2, i-k+1) , gmin-i+maxn);
    }
    gmax2=0;
    for (i=mid; i>=L; i--)
    {
        gmax2=max(gmax2, a[i]);
        val.push_back(gmax2-i+maxn);
        d[val.back()+maxn]++;
        answer_query(i);
    }
    clear_query(L, mid);
}
//////

void process2()
{
    res=0;
    int gmin, gmax;
    for (int i=1; i<=n-k+1; i++)
    {
        gmin=n+1; gmax=0;
        for (int j=i; j<=n; j++)
        {
            gmin=min(gmin, a[j]);
            gmax=max(gmax, a[j]);
            if (j-i+1>=k && gmax-gmin==j-i) res++;
        }
    }
    cout << res << '\n';
}
//////

int main()
{
    freopen("subse.inp", "r", stdin);
    freopen("subse.out", "w", stdout);
    scanf("%d\n", &T);
    while (T--)
    {
        enter();
        //process2();
        res=0; solve(1, n);
        cout << res << '\n';
    }
}
