#include <iostream>
#include <stdio.h>
#include <deque>
#include <vector>
#include <math.h>

using namespace std;
////////

long long a, b;
int k, s, res;
vector<int> pr;
deque<long long> q;
////////

void enter()
{
    scanf("%lld%lld%d%d", &a, &b, &k, &s);
}
////////

void init()
{
    int maxn=1e5+100;
    int d[maxn];
    for (int i=1; i<=maxn; i++) d[i]=0;

    pr.clear();
    for (int i=2; i<=maxn; i++)
    if (d[i]==0)
    {
        pr.push_back(i);
        for (int j=i; j<=maxn/i; j++) d[i*j]=i;
    }
}
////////

bool prime(long long x)
{
    if (x<1) return false;
    for (int i=0; i<pr.size(); i++)
        if (pr[i]>sqrt(x)) return true; else
        if (x % pr[i]==0) return false;
}

void process()
{
    q.clear();
    while (a<=b)
    {
        if (prime(a)) q.push_back(a);
        //cout << q.size() << ' ' <<  q.front()<< ' ' << q.back() << '\n';
        while (q.size()>k) q.pop_front();
        if (q.size()==k && q.back()-q.front()==s && q.back()==a) res++;
        a++;
    }
    cout << res;
}

int main()
{
    freopen("primetuple.inp", "r", stdin);
    freopen("primetuple.out", "w", stdout);
    enter();
    init();
    process();
}
