#include <bits/stdc++.h>
#define forn(i, a, b) for (int i=(a); i<=(b); ++i)
#define ford(i, a, b) for (int i=(a); i>=(b); --i)
using namespace std;
//////

typedef long long ll;
struct data
{
    ll w, v;
    int num;
};

const
    int maxn=17, maxbit=1 << 17;
int n, nb, nc;
ll minW, maxW;
data a[2*maxn];
data b[maxbit], c[maxbit];
deque<int> Q;
ll resV;
int num1, num2;
vector<int> OP;
//////

void enter()
{
    scanf("%d%lld%lld\n", &n, &minW, &maxW);
    forn(i, 1, n) scanf("%lld%lld\n", &a[i].w, &a[i].v);
}
//////

void dequy(int i, int bb, int last, ll sum1, ll sum2, int num)
{
    if (i>last)
    {
        c[++nc]={sum1, sum2, num};
        return;
    }
    dequy(i+1, bb, last, sum1, sum2, num);
    dequy(i+1, bb, last, sum1+a[i].w, sum2+a[i].v, num+(1 << (i-bb)));
}

bool comp(data x, data y)
{
    return x.w<y.w;
}

void init()
{
    nc=0;
    dequy(1, 1, n/2, 0, 0, 0);
    nb=nc;
    forn(i, 1, nb) b[i]=c[i];
    nc=0;
    dequy(n/2+1, n/2+1, n, 0, 0, 0);
    sort(b+1, b+nb+1, comp);
    sort(c+1, c+nc+1, comp);
}
//////

void process()
{
    Q.clear();
    int L=nc, R=nc;
    resV=0;
    forn(i, 1, nb)
    {
        while (L>0 && b[i].w+c[L].w>=minW)
        {
            while (!Q.empty() && c[L].v>=c[Q.back()].v) Q.pop_back();
            Q.push_back(L); L--;
        }
        while (R>0 && b[i].w+c[R].w>maxW)
        {
            while (!Q.empty() && Q.front()>=R) Q.pop_front();
            R--;
        }
        if (!Q.empty() && b[i].v+c[Q.front()].v>resV)
        {
            resV=b[i].v+c[Q.front()].v;
            num1=b[i].num;
            num2=c[Q.front()].num;
        }
    }
    OP.clear();
    forn(i, 1, n/2)
        if ((num1 >> (i-1) & 1)==1) OP.push_back(i);
    forn(i, 1, n-n/2)
        if ((num2 >> (i-1) & 1)==1) OP.push_back(i+n/2);
    cout << OP.size() << '\n';
    if (!OP.empty())
        forn(i, 0, OP.size()-1) cout << OP[i] << ' ';
}
//////

int main()
{
    freopen("dowry.inp", "r", stdin);
    freopen("dowry.out", "w", stdout);
    enter();
    init();
    process();
}
