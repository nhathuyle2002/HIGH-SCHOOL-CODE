#include <iostream>
#include <stdio.h>
#include <algorithm>

using namespace std;
///////

const
    int maxn=1e5+100;
int n, k, cou;
int a[maxn], d[maxn], l[maxn], r[maxn];
int res;
///////

void enter()
{
    scanf("%d%d\n", &k, &n);
    for (int i=0; i<n; i++) scanf("%d", &a[i]);
    sort(a, a+n);
    a[0]=-maxn;
}
///////

void process()
{
    cou=0;
    for (int i=1; i<n; i++)
        if (a[i]>a[i-1]+1)
        {
            cou++;
            d[cou]=1; l[cou]=a[i]; r[cou]=a[i];
        } else
        if (a[i]==a[i-1]+1)
        {
            d[cou]++;
            r[cou]=a[i];
        }
    res=0;
    for (int i=1; i<=cou; i++) res=max(res, d[i]+1);
    for (int i=1; i<cou; i++)
        if (r[i]+2==l[i+1]) res=max(res, d[i]+1+d[i+1]);
    cout << res;
}
///////

int main()
{
    freopen("lcsu.inp", "r", stdin);
    freopen("lcsu.out", "w", stdout);
    enter();
    process();
}

/*int main()
{
  //  sinh();
    freopen("LCSU.INP", "r", stdin);
    freopen("LCSU.OUT", "w", stdout);
    int n,m,h,j=1,k,i,t=0,res=0;
    int a[110000]={0};
    cin>>n>>k;
    m=0;
    for(int i=1;i<=k;i++)
    {
        cin>>h;
        if(h==0) t++;
        else
        {
            m++;a[m]=h;
        }
    }
    a[0]=0;
    sort(a+1,a+m+1);
    for(i=1;i<=m;i++)
    {
        while(a[i]-a[j]+j-i>t) j++;
        res=max(t+i-j+1,res);
    }
    cout<<res<<endl;
}*/
