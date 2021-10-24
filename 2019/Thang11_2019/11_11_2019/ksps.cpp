#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
#define repn(i,a,b) for(int i=(a); i<(b); ++i)
using namespace std;
//////

const
    int maxn=1e5+100, maxn2=1e7+100;
const
    long long base=211, modul=1e9+7;
int nX, A, B, top;
int a[10];
long long _hashX, _powX, _hashY[maxn2];
//////

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
    fastscan(A); fastscan(B);
    _hashX=0; _powX=1;
    register char c=getchar();
    nX=0;
    for(; c>47 && c<58; c=getchar())
    {
        ++nX;
        _hashX=(_hashX*base+c) % modul;
        _powX=_powX*base % modul;
    }
}
//////

long long getHash(int L, int R)
{
    return (_hashY[R]-_hashY[L-1]*_powX+modul*modul) % modul;
}

void process()
{
    _hashY[0]=0; top=0;
    int x=A/B;
    while (x>0)
    {
        a[++top]=x%10;
        x/=10;
    }
    if (top==0) a[++top]=0;
    forn(i, 1, top)
    {
        _hashY[i]=(_hashY[i-1]*base+a[top-i+1]+48) % modul;
        if (i>=nX && getHash(i-nX+1, i)==_hashX)
        {
            cout << i-nX+1;
            return;
        }
    }

    A%=B;
    while (top<maxn2)
    {
        int x=A*10/B; A=A*10%B;
        _hashY[++top]=(_hashY[top-1]*base+x+48) % modul;
        if (top>=nX && getHash(top-nX+1, top)==_hashX)
        {
            cout << top-nX+1;
            return;
        }
    }
    cout << 0;
}
//////

int main()
{
    freopen("ksps.inp", "r", stdin);
    freopen("ksps.out", "w", stdout);
    enter();
    process();
}
