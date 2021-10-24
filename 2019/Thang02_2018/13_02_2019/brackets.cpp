#include <iostream>
#include <stdio.h>
#include <vector>
#include <string.h>

using namespace std;
///////////

const
    int maxn=1e5+100,
    maxn2=1e4;

int n;
char s[maxn];
char res[maxn];
int f[maxn2][maxn2];
int cou;
///////////

void enter()
{
    scanf("%s", s+1);
    n=strlen(s+1);
}
///////////

void truyvet(int i, int j)
{
    if (i==0) return;
    if (j==0) res[i]=')';
    else
    if (j==n) res[i]='(';
    else
    if (s[i]=='(')
    {
        if (f[i-1][j-1]<f[i-1][j+1]+1) res[i]='(';
        else res[i]=')';
    }
    else
    if (s[i]==')')
    {
        if (f[i-1][j-1]+1<f[i-1][j+1]) res[i]='(';
        else res[i]=')';
    }
    if (res[i]=='(') truyvet(i-1, j-1);
    else truyvet(i-1, j+1);
}

void process1()
{
    f[0][0]=0;
    for (int j=1; j<=n; j++)
        f[0][j]=n+1;
    for (int i=1; i<=n; i++)
        if (s[i]=='(')
        {
            for (int j=0; j<=n; j++)
            {
                if (j==0) f[i][j]=f[i-1][j+1]+1; else
                if (j==n) f[i][j]=f[i-1][j-1]; else
                f[i][j]=min(f[i-1][j-1], f[i-1][j+1]+1);
            }
        }
        else
        if (s[i]==')')
        {
            for (int j=0; j<=n; j++)
            {
                if (j==0) f[i][j]=f[i-1][j+1]; else
                if (j==n) f[i][j]=f[i-1][j-1]+1; else
                f[i][j]=min(f[i-1][j-1]+1, f[i-1][j+1]);
            }
        }
    cout << f[n][0] << '\n';
    res[n+1]='\0';
    truyvet(n,0);
    cout << res+1;
}
//////////

void process2()
{
    cou=0;
    vector<int> q;
    q.clear();
    for (int i=1; i<=n; i++) res[i]='('; res[n+1]='\0';
    for (int i=1; i<=n; i++)
        if (s[i]=='(') q.push_back(i); else
        {
            if (q.empty())
            {
                q.push_back(i);
                //res[i]='(';
                cou++;
            } else
            {
                res[i]=')';
                q.pop_back();
            }
        }
    if (!q.empty())
    for (int i=q.size()-1; i>=q.size()/2; i--)
    {
            res[i]=')';
            cou++;
    }
    cout << cou << '\n';
    cout << res+1;
}
///////////

int main()
{
    freopen("brackets.inp", "r", stdin);
    freopen("brackets.out", "w", stdout);
    enter();
    if (n<=8000) process1(); else
    process2();
}
