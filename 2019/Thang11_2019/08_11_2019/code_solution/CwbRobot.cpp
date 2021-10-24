#include <bits/stdc++.h>

template <typename T> inline void read(T &x) {
    char c;
    while (!isdigit(c = getchar()));
    x = c - 48;
    while (isdigit(c = getchar()))
        x = (x << 3) + (x << 1) + c - 48;
}

using namespace std;
#define fname "CwbRobot"

#define bit(x, i) ((x >> i - 1) & 1)
#define mp make_pair
#define fi first
#define se second
const int N = 211;
const int NN = 2011;
int n, m, d, res, w[N], a[NN], cnt[N], b[N], s[1111], f[N][27][27][27], g[N][1111];
int ch[NN], pos[NN], ke[NN];
set <pair <int, int> > S;
void Try(int x) {
    if (x > n) {
        int sum = 0, ans = 0;
        for (int i = 1; i <= n; i++)
            cnt[a[i]] = 0;
        for (int i = 1; i <= n; i++) {
            if (cnt[a[i]])
                ans++,
                cnt[a[i]] = 0,
                sum -= w[a[i]];
            if (b[i]) {
                if (sum + w[a[i]] <= m)
                    sum += w[a[i]],
                    cnt[a[i]] = 1;
            }
        }
        res = max(res, ans);
        return;
    }
    b[x] = 0;
    Try(x + 1);
    b[x] = 1;
    Try(x + 1);
}
void sub2() {
    for (int i = 0; i <= n; i++)
        for (int x = 0; x <= d; x++)
            for (int y = 0; y <= d; y++)
                for (int z = 0; z <= d; z++)
                    f[i][x][y][z] = -n * n;
    f[0][0][0][0] = 0;
    for (int i = 1; i <= n; i++) {
        for (int x = 0; x <= d; x++) {
            for (int y = 0; y <= d; y++) {
                for (int z = 0; z <= d; z++) {
                    if (w[x] + w[y] + w[z] > m)
                        continue;
                    f[i][x][y][z] = f[i - 1][x][y][z];
                    if (!x)
                        f[i][x][y][z] = max(f[i][x][y][z], f[i - 1][a[i]][y][z] + 1);
                    if (!y)
                        f[i][x][y][z] = max(f[i][x][y][z], f[i - 1][x][a[i]][z] + 1);
                    if (!z)
                        f[i][x][y][z] = max(f[i][x][y][z], f[i - 1][x][y][a[i]] + 1);
                    if (x == a[i]) {
                        f[i][x][y][z] = max(f[i][x][y][z], f[i - 1][0][y][z]);
                        f[i][x][y][z] = max(f[i][x][y][z], f[i - 1][x][y][z] + 1);
                    }
                    if (y == a[i]) {
                        f[i][x][y][z] = max(f[i][x][y][z], f[i - 1][x][0][z]);
                        f[i][x][y][z] = max(f[i][x][y][z], f[i - 1][x][y][z] + 1);
                    }
                    if (z == a[i]) {
                        f[i][x][y][z] = max(f[i][x][y][z], f[i - 1][x][y][0]);
                        f[i][x][y][z] = max(f[i][x][y][z], f[i - 1][x][y][z] + 1);
                    }
                }
            }
        }
    }
    for (int x = 0; x <= d; x++)
        for (int y = 0; y <= d; y++)
            for (int z = 0; z <= d; z++)
                res = max(res, f[n][x][y][z]);
    cout << res << '\n';
}
void sub3() {
    for (int i = 0; i < (1 << d); i++)
        for (int j = 1; j <= d; j++)
            if (bit(i, j)) {
                int k = i - (1 << j - 1);
                s[i] = s[k] + w[j];
                break;
            }
    for (int i = 0; i <= n; i++)
        for (int j = 0; j < (1 << d); j++)
            g[i][j] = -n * n;
    g[0][0] = 0;
    for (int i = 1; i <= n; i++)
        for (int j = 0; j < (1 << d); j++) {
            if (s[j] <= m) {
                g[i][j] = g[i - 1][j];
                int k = j | (1 << a[i] - 1);
                g[i][j] = max(g[i][j], g[i - 1][k] + 1);
                if (bit(j, a[i])) {
                    k = j - (1 << a[i] - 1);
                    g[i][j] = max(g[i - 1][k], g[i][j]);
                }
            }
        }
    for (int i = 0; i < (1 << d); i++)
        res = max(res, g[n][i]);
    cout << res << '\n';
}
void sub4() {
    for (int i = n; i > 0; i--) {
        ke[i] = pos[a[i]];
        pos[a[i]] = i;
    }
    int lim = m / w[1];
    for (int i = 1; i <= n; i++) {
        S.erase(mp(-i, a[i]));
        ch[a[i]] = 0;
        if (ke[i]) {
            S.insert(mp(-ke[i], a[i]));
            ch[a[i]] = 1;
        }
        if (S.size() > lim) {
            pair <int, int> p = *S.begin();
            ch[p.se] = 0;
            S.erase(p);
            if (p.se != a[i])
                res--;
        }
        if (ch[a[i]])
            res++;
    }
    cout << res << '\n';
}
int main() {
    ios_base::sync_with_stdio(0);
    cout.tie(0);
    if (fopen(fname".inp", "r")) {
        freopen(fname".inp", "r", stdin);
        freopen(fname".out", "w", stdout);
    }
    read(n);
    read(m);
    read(d);
    for (int i = 1; i <= n; i++) {
        char c;
        while (!isalpha(c = getchar()));
        a[i] = c - 'a' + 1;
    }
    for (int i = 1; i <= d; i++)
        read(w[i]);
    if (n <= 20) {
        Try(1);
        cout << res << '\n';
        return 0;
    }
    if (n > 200) {
        sub4();
        return 0;
    }
    if (m <= 3) {
        sub2();
        return 0;
    }
    if (d <= 10) {
        sub3();
        return 0;
    }
}
