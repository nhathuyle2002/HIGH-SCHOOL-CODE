#include <iostream>
#include <stdio.h>
#include <string.h>
#include <algorithm>

using namespace std;
///////

typedef pair<int, int> pii;
const
    int maxn=1e5+100;
int n;
char s[maxn];
int h[maxn], d[maxn][4];
int cou;
pii q[2*maxn];
int res;
///////

void enter()
{
    scanf("%s", s+1);
    n=strlen(s+1);
}
///////

void process()
{
    h[0]=0; memset(d[0], 0, sizeof(d[0]));
    for (int i=1; i<=n; i++)
    {
        for (int j=0; j<4; j++) d[i][j]=d[i-1][j];
        if (s[i]=='F')
        {
            h[i]=h[i-1];
            d[i][h[i]]++;
        }
        else if (s[i]=='R')
            h[i]=(h[i-1]+1) % 4;
        else if (s[i]=='L')
            h[i]=(h[i-1]-1+4) % 4;
    }

    cou=0;
    for (int i=1; i<=n; i++)
    {
        int a[4], b[4], c[4];
        for (int j=0; j<4; j++) a[j]=d[i-1][j];
        for (int j=0; j<4; j++) b[j]=d[n][j]-d[i][j];
        if (s[i]=='F')
        {
            for (int j=0; j<4; j++) c[j]=a[j]+b[(j-1+4) % 4];
            cou++; q[cou]=make_pair(c[1]-c[3], c[0]-c[2]);
            for (int j=0; j<4; j++) c[j]=a[j]+b[(j+1) % 4];
            cou++; q[cou]=make_pair(c[1]-c[3], c[0]-c[2]);
        } else
        if (s[i]=='L')
        {
            for (int j=0; j<4; j++) c[j]=a[j]+b[(j-1+4) % 4];
            c[h[i-1]]++;
            cou++; q[cou]=make_pair(c[1]-c[3], c[0]-c[2]);
            for (int j=0; j<4; j++) c[j]=a[j]+b[(j+2) % 4];
            cou++; q[cou]=make_pair(c[1]-c[3], c[0]-c[2]);
        } else
        if (s[i]=='R')
        {
            for (int j=0; j<4; j++) c[j]=a[j]+b[(j+1) % 4];
            c[h[i-1]]++;
            cou++; q[cou]=make_pair(c[1]-c[3], c[0]-c[2]);
            for (int j=0; j<4; j++) c[j]=a[j]+b[(j+2) % 4];
            cou++; q[cou]=make_pair(c[1]-c[3], c[0]-c[2]);
        }
    }

    sort(q+1, q+cou+1); q[0].first=maxn;
    res=0;
    for (int i=1; i<=cou; i++)
        if (q[i]!=q[i-1]) res++;

    cout << res;
}
///////

void process2()
{
    h[0]=0; memset(d[0], 0, sizeof(d[0]));
    cou=0;
    for (int t=1; t<=n; t++)
    {
        char ss=s[t];
        if (ss!='F')
        {
            s[t]='F';
            for (int i=1; i<=n; i++)
        {
            for (int j=0; j<4; j++) d[i][j]=d[i-1][j];
            if (s[i]=='F')
            {
                h[i]=h[i-1];
                d[i][h[i]]++;
            }
            else if (s[i]=='R')
                h[i]=(h[i-1]+1) % 4;
            else if (s[i]=='L')
                h[i]=(h[i-1]-1+4) % 4;
        }
            cou++; q[cou]=make_pair(d[n][1]-d[n][3], d[n][0]-d[n][2]);
        }
        if (ss!='L')
        {
            s[t]='L';
            for (int i=1; i<=n; i++)
        {
            for (int j=0; j<4; j++) d[i][j]=d[i-1][j];
            if (s[i]=='F')
            {
                h[i]=h[i-1];
                d[i][h[i]]++;
            }
            else if (s[i]=='R')
                h[i]=(h[i-1]+1) % 4;
            else if (s[i]=='L')
                h[i]=(h[i-1]-1+4) % 4;
        }
            cou++; q[cou]=make_pair(d[n][1]-d[n][3], d[n][0]-d[n][2]);
        }
        if (ss!='R')
        {
            s[t]='R';
            for (int i=1; i<=n; i++)
        {
            for (int j=0; j<4; j++) d[i][j]=d[i-1][j];
            if (s[i]=='F')
            {
                h[i]=h[i-1];
                d[i][h[i]]++;
            }
            else if (s[i]=='R')
                h[i]=(h[i-1]+1) % 4;
            else if (s[i]=='L')
                h[i]=(h[i-1]-1+4) % 4;
        }
            cou++; q[cou]=make_pair(d[n][1]-d[n][3], d[n][0]-d[n][2]);
        }
        s[t]=ss;
    }

    sort(q+1, q+cou+1); q[0].first=maxn;
    res=0;
    for (int i=1; i<=cou; i++)
        if (q[i]!=q[i-1]) res++;

    cout << res << '\n';
}

///////

int main()
{
    freopen("wrongdir.inp", "r", stdin);
    freopen("wrongdir.out", "w", stdout);
    enter();
    //process2();
    process();
}
