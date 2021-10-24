#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
#define repn(i,a,b) for(int i=(a); i<(b); ++i)
using namespace std;
//////

typedef pair<int, int> point;

const
    int maxn=1e5+100;
int ns;
char s[maxn];
point T[maxn], last;
double res, delta, sbd;
//////

void enter()
{
    ns=strlen(s+1);
    if (s[ns]!='S') ns++;

    T[0]={0, 0};
    repn(i, 1, ns)
    {
        T[i]=T[i-1];
        if (s[i]=='U') T[i].second++; else T[i].first++;
    }
    last=T[ns-1];
}
//////

int area(point x, point y, point z)
{
    return (y.first-x.first)*(y.second+x.second)
        +  (z.first-y.first)*(z.second+y.second)
        +  (x.first-z.first)*(x.second+z.second);
}

double sqr(double x) {return x*x;}

void calc(point L, point R)
{
    double y1=fabs(1.0*L.first*delta-L.second), y2=fabs(1.0*R.first*delta-R.second);
    if (1LL*area(L, T[0], last)*area(R, T[0], last)>=0)
        res+=(y2+y1)*(R.first-L.first)/2;
    else
        res+=sbd*sqr(y1/last.second)+sbd*sqr(y2/last.second);
}
//////

void process()
{
    if (last.first==0 || last.second==0)
    {
        cout << "0.000";
        return;
    }
    res=0;
    delta=1.0*last.second/last.first;
    sbd=1.0*last.first*last.second/2;

    point L=T[0];
    s[ns]='U';
    repn(i, 1, ns)
    {
        if (i>1 && s[i]=='R' && s[i-1]=='U') L=T[i-1];
        if (s[i]=='R' && s[i+1]=='U') calc(L, T[i]);
    }

    res=trunc(res*1000+0.5)/1000;
    //cout << setprecision(3) << fixed << res;
    printf("%0.3f", res);
}
//////

void process2()
{
    point P={0, 0}, Q={0, 0};
    repn(i, 1, ns)
        if (s[i]=='U') Q.second++; else Q.first++;
    if (Q.first==0 || Q.second==0)
    {
        cout << "0.000";
        return;
    }

    res=0;
    delta=1.0*Q.first/Q.second;
    sbd=1.0*Q.first*Q.second/2;

    point A={0, 0};
    repn(i, 1, ns)
    {
        point B=A;
        if (s[i]=='U') ++B.second; else
        {
            ++B.first;
            double y1=fabs(A.second-1.0*A.first/delta), y2=fabs(B.second-1.0*B.first/delta);
            if (area(A, P, Q)*area(B, P, Q)>=0) res+=(y1+y2)/2; else
                res+=sbd*(y1/Q.second)*(y1/Q.second)+sbd*(y2/Q.second)*(y2/Q.second);
        }
        A=B;
    }
    cout << setprecision(3) << fixed << res;
}
//////

int main()
{
    freopen("area.inp", "r", stdin);
    freopen("area.out", "w", stdout);
    int cc=0;
    while (scanf("%s", s+1)!=EOF)
    {
        ++cc;
        if (cc==255)
        {
            cc++;
            cc--;
        }
        enter();
        //process2();
        process();
        cout << '\n';
    }
}
