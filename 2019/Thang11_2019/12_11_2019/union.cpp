#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
#define repn(i,a,b) for(int i=(a); i<(b); ++i)
using namespace std;
//////

const
    int maxn=3e5+10;
int n, top, dpos;
int leng[maxn], X[maxn][61];
int Trie[maxn*61][2];
//////

void fastscan(long long &number)
{
    number=0;
    register char c=getchar();
    while (c<48 || c>57) c=getchar();
    for(; c>47 && c<58; c=getchar())
        number=number*10+c-48;
}

void enter()
{
    scanf("%d\n", &n);
    long long x;
    forn(i, 1, n)
    {
        fastscan(x);
        leng[i]=-1;
        while (x>1) X[i][++leng[i]]=x&1, x/=2;
    }
    for(dpos=0; dpos<60; ++dpos)
    {
        bool ok=true;
        forn(i, 1, n)
            if (leng[i]<dpos || (i>1 && X[i][leng[i]-dpos]!=X[i-1][leng[i-1]-dpos]))
            {
                ok=false;
                break;
            }
        if (!ok) break;
    }
}
//////

void process()
{
    top=0;
    Trie[0][0]=-1; Trie[0][1]=-1;

    int node, nex, nx;
    forn(t, 1, n)
    {
        node=0;
        nx=leng[t]-dpos;
        while (nx>=0)
        {
            nex=X[t][nx]; --nx;
            if (Trie[node][nex]==-1)
            {
                ++top;
                Trie[top][0]=-1; Trie[top][1]=-1;
                Trie[node][nex]=top;
            }
            node=Trie[node][nex];
        }
    }
    cout << top;
}
//////

int main()
{
    freopen("union.inp", "r", stdin);
    freopen("union.out", "w", stdout);
    enter();
    process();
}

/*#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
#define repn(i,a,b) for(int i=(a); i<(b); ++i)
using namespace std;
//////

struct TrieNode
{
    int child[2];
    TrieNode()
    {
        forn(i, 0, 1) child[i]=-1;
    }
};
const
    int maxn=3e5+100;
int n, result;
long long a[maxn];
bitset<64> X;
vector<TrieNode> Trie;
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
    fastscan(n);
    forn(i, 1, n) scanf("%lld", &a[i]);
}
//////

void dfs(int node, bool type)
{
    if (node==-1) return;
    if (type) ++ result;
    if (!type && Trie[node].child[0]!=-1 && Trie[node].child[1]!=-1) type=true;
    forn(nex, 0, 1)
        dfs(Trie[node].child[nex], type);
}

void process()
{
    Trie.clear();
    Trie.push_back(TrieNode());

    forn(t, 1, n)
    {
        X=a[t];
        int pos=63;
        for(; pos>=0; --pos)
            if (X[pos]==1) break;
        int node=0;
        for(; pos>=0; --pos)
        {
            int nex=X[pos];
            if (Trie[node].child[nex]==-1)
            {
                Trie[node].child[nex]=Trie.size();
                Trie.push_back(TrieNode());
            }
            node=Trie[node].child[nex];
        }
    }

    result=0;
    dfs(0, 0);
    cout << result;
}
//////

int main()
{
    freopen("union.inp", "r", stdin);
    freopen("union.out", "w", stdout);
    enter();
    process();
}*/
