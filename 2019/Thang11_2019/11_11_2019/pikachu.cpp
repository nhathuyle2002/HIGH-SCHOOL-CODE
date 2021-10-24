#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
#define repn(i,a,b) for(int i=(a); i<=(b); --i)
using namespace std;
//////

typedef pair<int, int> pii;
typedef pair<pii, int> piii;
const
    int maxn=1e3+100;
const
    pii path[4]={{-1, 0}, {0, 1}, {1, 0}, {0, -1}};
int n, m, ans, ir ,jr;
int a[maxn][maxn];
int f[maxn][maxn][4];
deque<piii> Q;
//////

void fastscan(int &number)
{
    number=0;
    register char c=getchar();
    while (c<48 || c>57) c=getchar();
    for(; c>47 && c<58; c=getchar())
        number=number*10+c-48;
}

void enter()
{
    fastscan(n); fastscan(m);
    forn(i, 1, n)
        forn(j, 1, m)
            fastscan(a[i][j]);
}
//////

bool check()
{
    forn(i, 1, n)
        forn(j, 1, m)
            if (a[i][j]>0) return false;
    return true;
}

bool bfs(int i0, int j0)
{
    forn(i, 0, n+1)
        forn(j, 0, m+1)
            forn(div, 0, 3)
                f[i][j][div]=1e9;
    Q.clear();
    forn(div, 0, 3)
    {
        f[i0][j0][div]=1;
        Q.push_back({{i0, j0}, div});
    }

    while (!Q.empty())
    {
        int x=Q.front().first.first, y=Q.front().first.second, k=Q.front().second;
        Q.pop_front();

        if ((x!=i0 || y!=j0) && a[x][y]==a[i0][j0])
        {
            ir=x; jr=y;
            return true;
        }

        forn(div, 0, 3)
        {
            int i=x+path[div].first, j=y+path[div].second;
            if (i<0 || j<0 || i>n+1 || j>m+1) continue;
            if (a[i][j]>0 && a[i][j]!=a[i0][j0]) continue;

            int dd=0;
            if (div!=k) dd=1;
            if (f[x][y][k]+dd<f[i][j][div] && f[x][y][k]+dd<=ans)
            {
                f[i][j][div]=f[x][y][k]+dd;
                if (dd==0) Q.push_front({{i, j}, div});
                    else Q.push_back({{i, j}, div});
            }
        }
    }
    return false;
}

bool match()
{
    bool ok=false;
    forn(i, 1, n)
        forn(j, 1, m)
            if (a[i][j]>0)
                if (bfs(i, j))
                {
                    ok=true;
                    a[i][j]=0;
                    a[ir][jr]=0;
                }
    return ok;
}
//////

void process()
{
    if (check())
    {
        cout << 0;
        return;
    }

    ans=0;
    while (ans<10)
    {
        ++ans;
        while (match());
        if (check())
        {
            cout << ans;
            return;
        }
    }
    cout << -1;
}
//////

int main()
{
    freopen("pikachu.inp", "r", stdin);
    freopen("pikachu.out", "w", stdout);
    enter();
    process();
}
/*#include<bits/stdc++.h>
using namespace std;
/// from HUNG MINE with love <3
typedef pair <int, int> ii;
typedef pair <ii, int> iii;
int tx[] = {0, -1, 1, 0, 0};
int ty[] = {0, 0, 0, -1, 1};
int f[1011][1011][6], d[1011][1011], ti, m, n, a[1011][1011], hc[1101], xto, yto, mad, k, ress = 0;
bool bfs (int xs, int ys) {
      //cerr << k;
      for (int i = 0; i <= m + 1; ++ i) {
            for (int j = 0; j <= n + 1; ++ j) {
                  for (int h = 0; h <= 4; ++ h) {
                        f[i][j][h] = 1e9;
                  }
            }
      }
      deque <iii> q;
      q.push_front (iii (ii (xs, ys), 0));
      f[xs][ys][0] = 0;
      xto = 0;
      yto = 0;
      mad = 1e9;
      int cnt = 0;
      while (q.size ()) {
            int x = q.front ().first.first;
            int y = q.front ().first.second;
            int pre = q.front ().second;
            if (a[x][y] == a[xs][ys] && (x != xs || y != ys)) {
                  xto = x;
                  yto = y;
                  mad = min (mad, f[x][y][pre]);
                  break;
            }
            q.pop_front ();
            if (f[x][y][pre] > k) continue;
            for (int j = 1; j <= 4; ++ j) {
                  int xx = x + tx[j];
                  int yy = y + ty[j];
                  if (a[xx][yy] != a[xs][ys] && (xx < 0 || yy < 0 || xx > m + 1 || yy > n + 1 || a[xx][yy] > 0)) continue;
                  //cerr << xx << " " << yy << "\n";
                  int uv = 0;
                  if (pre != j) uv = 1;
                  //cerr << uv;
                  if (f[xx][yy][j] > f[x][y][pre] + uv) {
                        f[xx][yy][j] = f[x][y][pre] + uv;
                        //d[xx][yy] = 1;
                        if (uv == 0) {
                              q.push_front (iii (ii (xx, yy), j));
                        }
                        else {
                              q.push_back (iii (ii (xx, yy), j));
                        }
                  }
            }
      }
      //cerr << xto << " " << yto << "\n";
      if (xto != 0 && yto != 0 && mad <= k) return true;
      return false;
}
bool check () {
      for (int i = 1; i <= m; ++ i) {
            for (int j = 1; j <= n; ++ j) {
                  if (a[i][j] > 0) return false;
            }
      }
      return true;
}
bool fi () {
      int ok = 0;
      for (int i = 1; i <= m; ++ i) {
            for (int j = 1; j <= n; ++ j) {
                  if (a[i][j] > 0) {
                        hc[a[i][j]] = 1;
                  }
            }
      }
      for (int i = 1; i <= m; ++ i) {
            for (int j = 1; j <= n; ++ j) {
                  if (a[i][j] > 0 && hc[a[i][j]] == 1) {
                        if (bfs (i, j)) {
                              ok = 1;
                              a[i][j] = 0;
                              a[xto][yto] = 0;
                        }
                        hc[a[i][j]] = 0;
                  }
            }
      }
      return ok;
}
int main () {
      if (fopen ("test.inp", "r")) {
            freopen ("test.inp", "r", stdin);
      }
      else {
            freopen ("PIKACHU.inp", "r", stdin);
            freopen ("PIKACHU.out", "w", stdout);
      }

      ios_base :: sync_with_stdio (0);
      cin.tie (0);
      cout.tie (0);
      cin >> m >> n;
      for (int i = 1; i <= m; ++ i) {
            for (int j = 1; j <= n; ++ j) {
                  cin >> a[i][j];
            }
      }
      for (k = 1; k <= 7; ++ k) {
            if (check ()) break;
            while (1) {
                  if (! fi ()) break;
            }
//            for (int i = 1; i <= m; ++ i) {
//                  for (int j = 1; j <= n; ++ j) {
//                        cerr << a[i][j] << " ";
//                  }cerr << "\n";
//            }cerr << "\n";
      }
      if (k >= 7) cout << 2;
      else cout << k - 1;
}*/
