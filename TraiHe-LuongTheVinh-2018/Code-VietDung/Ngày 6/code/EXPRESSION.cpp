#include <iostream>
#include <stdio.h>
#include <string>
#include <algorithm>
#define For(i,a,b) for(int i=a; i<=b; i++)

using namespace std;
string a;
int r;

void nhap()
{
    freopen("EXPRESSION.INP","r",stdin);
    freopen("EXPRESSION.OUT","w",stdout);
    getline(cin, a);
}
long long gcd(long long a, long long b)
{
    while (b)
    {
        long long r = a% b; a = b; b = r;
    }
    return abs(a);
}
long long calc(int vt)
{
    while (a[vt] == ',' || a[vt] == ')' || a[vt] == ' ' || a[vt] == '(') vt++;
    if (a[vt] > '9')
    {
        string t = "";
        t = t+a[vt];  t = t+a[vt+1];  t = t+a[vt+2];
        long long tmp = calc(vt+4);
        if (t == "SUM") return tmp + calc(r);
        if (t == "DIF") return tmp - calc(r);
        if (t == "MAX") return max(tmp, calc(r));
        if (t == "MIN") return min(tmp, calc(r));
        return gcd(tmp, calc(r));
    }
    long long t = 0;
    while ('0' <= a[vt] && a[vt] <= '9')
    {
        t = 10*t + a[vt] - 48;
        vt++;
    }
    r = vt;
    return t;
}
int main()
{
    nhap();
    printf("%lld", calc(0));
}
