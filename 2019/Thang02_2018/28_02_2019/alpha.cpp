#include <iostream>
#include <stdio.h>
#include <math.h>
#include <vector>
#include <algorithm>

using namespace std;
///////

struct data
{
    long long g, h;
};

const
    int maxn=1e6+100,
    maxnt=1e5+100;

int cou;
int dnt[maxn], nt[maxnt], leaf[maxn];
data it[maxnt*4];
int base, nq;
///////

void build(int id, int l, int r)
{
    it[id].g=1; it[id].h=0;

    if (l==r)
    {
        leaf[nt[l]]=id;
        it[id].g=nt[l] % base;
    }
    else
    {
        int mid=(l+r)/2;
        build(id*2, l, mid);
        build(id*2+1, mid+1, r);
    }
}

void init()
{
    dnt[1]=1;
    for (int i=2; i<=maxn; i++)
        if (dnt[i]==0)
    {
        cou++;
        nt[cou]=i;
        dnt[i]=i;
        for (int j=i; j<=maxn/i; j++) dnt[i*j]=i;
    }
    build(1, 1, cou);
}
///////

long long power(long long a, long long b)
{
    if (b==0) return 1;
    long long c=power(a, b/2);
    if (b % 2==0) return c*c % base; else
        return (c*c % base)*a % base;
}

long long gcd(long long a, long long b)
{
    if (b==0) return a;
    return gcd(b, a % b);
}

void update(int x, int hh)
{
    int i=leaf[x];
    it[i].h+=hh;
    i/=2;
    while (i>0)
    {
        data it1=it[i*2], it2=it[i*2+1];
        it[i].h=gcd(it1.h, it2.h);
        long long t1, t2;
        if (it[i].h>0) t1=power(it1.g, it1.h/it[i].h); else t1=1;
        if (it[i].h>0) t2=power(it2.g, it2.h/it[i].h); else t2=1;
        it[i].g=t1*t2 % base;
        i/=2;
    }
}

void process()
{
    int cc, cc2;
    int q[100], d[100];
    int ms, a, b;
    while (nq>0)
    {
        //int ms, a, b;
        scanf("%d", &ms);
        if (ms==3)
        {
            if (it[1].h==0) cout << 1 << ' ' << 1 << '\n'; else
                cout << it[1].g << ' ' << it[1].h << '\n';
        } else
        {
            scanf("%d%d", &a, &b);
            cc=0;
            while (a>1)
            {
                int x=dnt[a];
                //if (ms==1) update(q[i], d[i]*b); else
                //update(q[i], -d[i]*b);
                cc++; q[cc]=x;
                a/=x;
            }
            sort(q+1, q+cc+1);
            q[0]=0; cc2=0;
            for (int i=1; i<=cc; i++)
                if (q[i]==q[cc2]) d[cc2]++; else
            {
                cc2++;
                q[cc2]=q[i]; d[cc2]=1;
            }
            for (int i=1; i<=cc2; i++)
                if (ms==1) update(q[i], d[i]*b); else
                update(q[i], -d[i]*b);
        }
        scanf("\n");
        nq--;
    }
    //cout << power(2,30)*power(3,6) % base *power(5,5) % base *power(7, 15) % base *power(11,2) % base;
}
///////

int main()
{
    freopen("alpha.inp", "r", stdin);
    freopen("alpha.out", "w", stdout);
    scanf("%d%d\n", &base, &nq);
    init();
    process();
}
