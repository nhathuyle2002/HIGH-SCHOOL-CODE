#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
using namespace std;
//////

const
    double err=1e-15;
double D, a1, a2, V, T;
//////

void enter()
{
    scanf("%lf%lf%lf%lf%lf", &D, &a1, &a2, &V, &T);
}
//////

void process()
{
    double L=0, R=V;
    while (abs(R-L)>=err)
    {
        double v=(R+L)/2;
        if (v*v/(2*a1)+v*v/(2*a2)+v*T<=D) L=v; else R=v;
    }
    T=L/a1+L/a2+(D-L*L/(2*a1)-L*L/(2*a2))/L;

    cout << setprecision(8) << fixed << T;
}
//////

int main()
{
    freopen("checkout.inp", "r", stdin);
    freopen("checkout.out", "w", stdout);
    enter();
    process();
}
