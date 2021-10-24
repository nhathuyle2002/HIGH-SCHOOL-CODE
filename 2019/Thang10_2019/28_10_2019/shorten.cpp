#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
#define repn(i,a,b) for(int i=(a); i<(b); ++i)
using namespace std;
//////

const
    int maxn=26;

typedef struct Trie* tNode;
struct Trie
{
    tNode child[maxn];
    int len;
    bool en;
    priority_queue<int> val;
};
//////

tNode getNode()
{
    tNode p= new Trie;
    repn(i, 0, maxn) p->child[i]=nullptr;
    p->len=0; p->en=false;
    return p;
}
//////

void Add_string(tNode p, const char s[])
{
    int ns=strlen(s);
    repn(i, 0, ns)
    {
        int index=s[i]-'a';
        if (!p->child[index])
        {
            p->child[index]=getNode();
            p->child[index]->len=i+1;
        }
        p=p->child[index];
    }
    p->en=true;
}
//////

void solve(tNode &p)
{
    repn(index, 0, maxn)
        if (p->child[index])
        {
            tNode q=p->child[index];
            solve(q);
            if (p->val.size()<q->val.size())
                p->val.swap(q->val);
            while (!q->val.empty()) p->val.push(q->val.top()), q->val.pop();
        }
    if (p->len==0) return;
    if (!p->en) p->val.pop();
    p->val.push(p->len);
}
//////

int main()
{
    freopen("shorten.inp", "r", stdin);
    freopen("shorten.out", "w", stdout);

    tNode root=getNode();

    int n; scanf("%d\n", &n);
    char s[100100];
    while (scanf("%s\n", s)!=EOF)
        Add_string(root, s);

    solve(root);
    int res=0;
    while (!root->val.empty()) res+=root->val.top(), root->val.pop();
    cout << res;
}
