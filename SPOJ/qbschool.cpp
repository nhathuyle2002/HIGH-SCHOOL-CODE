    #include <iostream>
    #include <stdio.h>
    #include <vector>
    #include <queue>
    #include <utility>

    #define for(i,a,b) for (int i=(a); i<=(b); i++)
    #define fi first
    #define se second

    using namespace std;

    typedef pair<int, int> pii;

    const
        int maxn=5010,
        maxm=20010,
        oo=1e9;

    struct cmp
    {
        bool operator()(pii x, pii y)
        {
            return x.se>y.se;
        }
    };

    int n, m;
    vector<pii> e[maxn];
    priority_queue<pii, vector<pii>, cmp> q;
    int d[maxn];
    long long f[maxn];

    void enter()
    {
        scanf("%d%d", &n, &m);
        for(u,1,n) e[u].clear();
        for(i,1,m)
        {
            int k,u,v,c;
            scanf("%d%d%d%d", &k, &u, &v, &c);
            e[u].push_back(pii(v,c));
            if (k==2) e[v].push_back(pii(u,c));
        }
    }

    void process()
    {
        for(u,1,n)
        {
            d[u]=oo;
            f[u]=0;
        }
        while (!q.empty()) q.pop();
        d[1]=0; f[1]=1;
        q.push(pii(1,0));
        do
        {
            if (q.empty()) return;
            pii u=q.top(); q.pop();
            if (u.se>d[u.fi]) continue;
            if (u.fi==n) return;
            for(i,0,int(e[u.fi].size())-1)
            {
                pii v=e[u.fi][i];
                if (u.se+v.se<d[v.fi])
                {
                    d[v.fi]=u.se+v.se;
                    f[v.fi]=f[u.fi];
                    q.push(pii(v.fi,d[v.fi]));
                } else
                if (u.se+v.se==d[v.fi]) f[v.fi]+=f[u.fi];
            }
        }
        while (true);
    }

    int main()
    {
        //freopen("qbschool.inp", "r", stdin);
        //freopen("qbschool.out", "w", stdout);
        enter();
        process();
        printf("%d %lld", d[n], f[n]);
        return 0;
    }
