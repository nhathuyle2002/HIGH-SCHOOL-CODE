#include <iostream>
#include <stdio.h>
#include <map>
#include <utility>

using namespace std;
///////

int n;
long long k;
int r1, r2;
map<long long, int> a;
//long long b[100010];
///////

void enter()
{
    scanf("%d%lld", &n, &k);
    long long x;
    for (int i=1; i<=n; i++)
    {
        scanf("%lld", &x);
        //b[i]=x;
        map<long long, int> :: iterator it;
        it=a.find(x-k);
        if (it!=a.end())
        {
            r1=i; r2=(*it).second;
            return;
        }
        it=a.find(x+k);
        if (it!=a.end())
        {
            r1=(*it).second; r2=i;
            return;
        }
        a[x]=i;
    }
}

int main()
{
    freopen("seq.inp", "r", stdin);
    freopen("seq.out", "w", stdout);
    enter();
    cout << r1 << ' ' << r2;
}
