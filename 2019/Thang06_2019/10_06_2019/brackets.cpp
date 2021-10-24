#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
using namespace std;
//////

const
    int maxn=1e5+100;
int n, ns, cou;
char s[maxn];
int ms[100], d[5];
vector<char> Q;
char open, close;
//////

void enter()
{
    scanf("%d\n", &n);
    forn(i, 1, 4)
    {
        char c;
        scanf("%c", &c);
        d[c]=i;
    }
    scanf("\n");
    scanf("%s", s+1);
    ns=strlen(s+1);
}
//////

char dao(char i)
{
    if (i=='(') return ')'; else return ']';
}

void process()
{
    Q.clear();
    forn(i, 1, ns)
        if (s[i]=='(' || s[i]=='[') Q.push_back(s[i]); else Q.pop_back();

    if (d['(']<d['['])
    {
        open='('; close=')';
    } else
    {
        open='['; close=']';
    }
    int p=Q.size();
    cou=(n-ns-Q.size())/2;

    forn(i, ns+1, n)
        if (Q.empty())
        {
            s[i]=open;
            Q.push_back(open);
            cou--;
        }
        else
        if (cou==0)
        {
            s[i]=dao(Q.back());
            Q.pop_back();
        }
        else
        {
            char c=dao(Q.back());
            if (d[open]<d[c])
            {
                s[i]=open;
                Q.push_back(open);
                cou--;
            } else
            {
                s[i]=c;
                Q.pop_back();
            }
        }

    forn(i, 1, n) cout << s[i];
}
//////

int main()
{
    freopen("brackets.inp", "r", stdin);
    freopen("brackets.out", "w", stdout);
    enter();
    process();
}
