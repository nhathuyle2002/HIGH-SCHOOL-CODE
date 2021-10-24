#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
#define repn(i,a,b) for(int i=(a); i<(b); ++i)
using namespace std;
//////

string X, S, Y, s1, s2;
int f[2001][2001], posx, poss, rlen;
//////

void reduce(string &s)
{
    bool ok=true;
    int pos;
    while (ok)
    {
        ok=false;
        pos=s.find("Aa");
        if (pos!=-1) s.erase(pos, 2), ok=true;
        pos=s.find("aA");
        if (pos!=-1) s.erase(pos, 2), ok=true;
        pos=s.find("Bb");
        if (pos!=-1) s.erase(pos, 2), ok=true;
        pos=s.find("bB");
        if (pos!=-1) s.erase(pos, 2), ok=true;
    }
}
//////

void sub_str()
{
    rlen=0; posx=0; poss=0;
    int d;
    repn(i, 0, X.size())
        repn(j, 0, S.size())
        {
            if (i==0 || j==0) d=0; else d=f[i-1][j-1];
            if (X[i]==S[j]) f[i][j]=d+1; else f[i][j]=0;
            if (f[i][j]>rlen)
            {
                rlen=f[i][j];
                posx=i-rlen+1; poss=j-rlen+1;
            }
        }
}
//////

void neg(string &s)
{
    repn(i, 0, s.size())
        if (s[i]=='a') s[i]='A'; else
        if (s[i]=='b') s[i]='B'; else
        if (s[i]=='A') s[i]='a'; else
        if (s[i]=='B') s[i]='b';
    repn(i, 0, s.size()/2) swap(s[i], s[s.size()-i-1]);
}
//////

int main()
{
    freopen("subword.inp", "r", stdin);
    freopen("subword.out", "w", stdout);
    cin >> X >> S;
    Y=S;
    reduce(X);
    reduce(S);
    if (S.size()==0)
    {
        cout << X+Y;
        return 0;
    }

    sub_str();

    s1=""; s2="";
    forn(i, 0, poss-1) s1+=S[i];
    repn(i, poss+rlen, S.size()) s2+=S[i];
    neg(s1); neg(s2);
    Y=s1+Y; Y=Y+s2;

    s1=""; s2="";
    forn(i, 0, posx-1) s1+=X[i];
    repn(i, posx+rlen, X.size()) s2+=X[i];
    Y=s1+Y; Y=Y+s2;

    cout << Y;
    return 0;
}
