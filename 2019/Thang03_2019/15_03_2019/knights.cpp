#include <iostream>
#include <stdio.h>
#include <vector>

using namespace std;
//////



const
    int base=1e9+9,
    maxn=90;

typedef long long LL;
struct matrix
{
    LL d[maxn][maxn];
    LL *operator [] (int i) {return d[i];}
};

int n, m, mbn;
matrix d, dv, c;
int f1[maxn];
LL res;
vector<int> q;
//////

LL power_int(int a, int b)
{
    if (b==0) return 1;
    LL p=power_int(a, b>>1);
    p=p*p % base;
    if ((b&1)==1) p=p*a % base;
    return p;
}

matrix operator * (matrix &a, matrix &b)
{
    matrix c;
    for (int i=0; i<maxn; i++)
        for (int j=0; j<maxn; j++) c[i][j]=0;
    for (int i=0; i<maxn; i++)
        for (int j=0; j<maxn; j++)
            for (int k=0; k<maxn; k++)
                c[i][j]=(c[i][j]+a[i][k]*b[k][j]) % base;
    return c;
}

matrix power_matrix(int b)
{
    if (b==0) return dv;
    matrix p=power_matrix(b>>1);
    p=p*p;
    if ((b&1)==1) p=p*d;
    return p;
}

int getb(int x, int i)
{
    return (x>>(i-1)) & 1;
}
//////

void enter()
{
    scanf("%d%d", &m, &n);
    for (int i=0; i<maxn; i++) dv[i][i]=1;
    mbn=1<<(2*m);
}
//////

void process2()
{
    q.clear();
    for (int i=0; i<mbn; i++)
    {
        q.push_back(i);
        for (int j=0; j<mbn; j++)
            if ((i>>2==(j&3)) && ((getb(i, 2)&getb(j, 3))!=1) && ((getb(i, 1)&getb(j, 4))!=1)) d[i][j]=1;
    }

    for (int i=0; i<q.size(); i++)
        if (q[i]>>2==0) f1[i]=1;
}
//////

void process3()
{
    q.clear();
    for (int i=0; i<mbn; i++)
        if ((getb(i, 1)&getb(i, 6))!=1 && (getb(i, 3)&getb(i, 4))!=1) q.push_back(i);

    for (int i=0; i<q.size(); i++)
        for (int j=0; j<q.size(); j++)
        {
            bool ok=true;
            int x=q[i], y=q[j];
            if (x>>3!=(y&7)) ok=false;
            if (((getb(x, 1)|getb(x, 3))&getb(y, 5))==1) ok=false;
            if ((getb(x, 2)&(getb(y, 4)|getb(y, 6)))==1) ok=false;
            if (ok) d[i][j]=1;
        }

    for (int i=0; i<q.size(); i++)
        if (q[i]>>3==0) f1[i]=1;
}
//////

void process4()
{
    q.clear();
    for (int i=0; i<mbn; i++)
        if ((getb(i, 1)&getb(i, 7))!=1 && (getb(i, 2)&getb(i, 8))!=1 && (getb(i, 3)&getb(i, 5))!=1 && (getb(i, 4)&getb(i, 6))!=1) q.push_back(i);

    for (int i=0; i<q.size(); i++)
        for (int j=0; j<q.size(); j++)
        {
            bool ok=true;
            int x=q[i], y=q[j];
            if (x>>4!=(y&15)) ok=false;
            if (((getb(x, 1)|getb(x, 3))&getb(y, 6))==1) ok=false;
            if ((getb(x, 2)&(getb(y, 5)|getb(y, 7)))==1) ok=false;
            if (((getb(x, 2)|getb(x, 4))&getb(y, 7))==1) ok=false;
            if ((getb(x, 3)&(getb(y, 6)|getb(y, 8)))==1) ok=false;
            if (ok) d[i][j]=1;
        }

    for (int i=0; i<q.size(); i++)
        if (q[i]>>4==0) f1[i]=1;
}
//////

int main()
{
    freopen("knights.inp", "r", stdin);
    freopen("knights.out", "w", stdout);
    enter();
    if (m==1)
    {
        cout << power_int(2, n);
        return 0;
    } else
    if (m==2) process2(); else
    if (m==3) process3(); else
    if (m==4) process4();

    c=power_matrix(n-1);
    res=0;
    for (int i=0; i<q.size(); i++)
        for (int j=0; j<q.size(); j++)
            res=(res+c[i][j]*f1[j]) % base;
    cout << res;
}
