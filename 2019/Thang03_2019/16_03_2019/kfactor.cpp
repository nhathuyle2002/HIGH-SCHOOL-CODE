#include <iostream>
#include <stdio.h>

using namespace std;
//////

const
    int maxk=1e5+100, maxn=5e6+100;
int k, a, b;
bool prime[maxk];
int d[maxn];
//////

void init_prime()
{
    for (int i=2; i<=k; i++) prime[i]=true;
    for (int i=2; i<=k; i++)
        if (prime[i])
        for (int j=i; j<=k/i; j++) prime[i*j]=false;
}
//////

void process()
{
    for (int i=a; i<=b; i++) d[i-a]=i;

    for (int i=2; i<=k; i++)
        if (prime[i])
        {
            int j=(i-a%i)%i;
            while (j<=b-a)
            {
                while (d[j] % i==0) d[j]/=i;
                j+=i;
            }
        }

    int res=0;
    for (int i=0; i<=b-a; i++)
        if (d[i]==1) res++;
    cout << res;
}
//////

int main()
{
    freopen("kfactor.inp", "r", stdin);
    freopen("kfactor.out", "w", stdout);
    scanf("%d%d%d", &k, &a, &b);
    init_prime();
    process();
}
