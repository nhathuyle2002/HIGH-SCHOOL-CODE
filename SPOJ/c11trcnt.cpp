#include <iostream>
#include <stdio.h>

using namespace std;

const
    int maxn=201,
    oo=1000000000;

int n;
long long x[maxn], y[maxn];
int d[maxn];

void enter()
{
    scanf("%d", &n);
    for (int i=1; i<=n; i++)
        scanf("%lld%lld", &x[i], &y[i]);
}

long long area(int i, int j, int k)
{
    long long s;
    s=(x[j]-x[i])*(y[j]+y[i])+(x[k]-x[j])*(y[k]+y[j])+(x[i]-x[k])*(y[i]+y[k]);
    return s;
}

void process()
{
    for (int i=1; i<=n; i++) d[i]=0;
    int res=0;
    for (int i=1; i<=n; i++)
        for (int j=i+1; j<=n; j++)
            for (int k=j+1; k<=n; k++)
                if (area(i, j, k)!=0)
                {
                    d[i]++;
                    d[j]++;
                    d[k]++;
                    res++;
                }
    cout << res << ' ';
    res=0; d[0]=oo;
    for (int i=1; i<=n; i++)
        if (d[i]<d[res]) res=i;
    cout << res;
}

int main()
{
    //freopen("c11trcnt.inp", "r", stdin);
    //freopen("c11trcnt.out", "w", stdout);
    enter();
    process();
}
