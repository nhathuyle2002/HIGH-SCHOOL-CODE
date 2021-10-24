#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
#define repn(i,a,b) for(int i=(a); i<(b); ++i)
using namespace std;
//////

typedef pair<int, int> pii;
const
    int maxn=1e5+100;
int nTest, n, w1, w2, w3, nb, nc;
pii a[maxn], b[maxn], c[maxn];
double res;
//////

bool compare1(pii x, pii y) {return x.first<y.first;}
bool compare2(pii x, pii y) {return x.second>y.second;}

void fastscan(int &number)
{
    number=0;
    register char c=getchar();
    while (c!='-' && (c<48 || c>57)) c=getchar();
    bool negative=false;
    if (c=='-') negative=true, c=getchar();
    for(; c>47 && c<58; c=getchar())
        number=number*10+c-48;
    if (negative) number=-number;
}

void enter()
{
    fastscan(n); fastscan(w1); fastscan(w2); fastscan(w3);
    nb=0; nc=0;
    forn(i, 1, n)
    {
        fastscan(a[i].first); fastscan(a[i].second);
        if (a[i].first<=a[i].second) b[++nb]=a[i]; else c[++nc]=a[i];
    }
    sort(b+1, b+nb+1, compare1);
    sort(c+1, c+nc+1, compare2);
    forn(i, 1, nb) a[i]=b[i];
    forn(i, 1, nc) a[i+nb]=c[i];
}
//////

double cnp(int a, int a0, int b, int b0)
{
    double L=0, R=2e9, mid1, mid2;
    forn(loop, 1, 80)
    {
        mid1=(L*2+R)/3;
        mid2=(L+R*2)/3;
        if (max(a*mid1+a0, b*mid1+b0)<max(a*mid2+a0, b*mid2+b0)) R=mid2; else L=mid1;
    }
    return L;
}

double calc(int tmin, int tmax)
{
    double t1=cnp(w1, -w1*tmin, -w2, w2*tmax), t2=cnp(-w2, w2*tmax, w3, 0);
    double r1=max(max(w1*t1-w1*tmin, -w2*t1+w2*tmax), w3*t1), r2=max(max(w1*t2-w1*tmin, -w2*t2+w2*tmax), w3*t2);
    return min(r1, r2);
}

void process()
{
    res=2e9;
    int t, tmax, tmin;
    forn(start, 1, n)
    {
        t=a[start].first;
        tmin=t+a[start].second; tmax=tmin;
        forn(i, 1, n)
        if (i!=start)
        {
            t+=a[i].first;
            if (tmax<t) tmax=t;
            tmax+=a[i].second;
        }
        res=min(res, calc(tmin, tmax));
    }
    printf("%0.1f\n", res);
}
//////

int main()
{
    freopen("arthur.inp", "r", stdin);
    freopen("arthur.out", "w", stdout);
    fastscan(nTest);
    while (nTest--)
    {
        enter();
        process();
    }
}
