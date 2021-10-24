#include <bits/stdc++.h>

using namespace std;
#define fname "Show"
typedef long long ll;
const ll inf = 1e16;
const int N = 211;
struct ii{
    ll l, r;
    int id;
} a[N];
int n;
ll res, ret, x, y, _x, _y, ans[N], f[N][N][N][2];
bool cmp(ii a, ii b) {
    return a.l < b.l;
}
bool tmp(ii a, ii b) {
    return a.id < b.id;
}
int main() {
    ios_base::sync_with_stdio(0);
    cin.tie(0); cout.tie(0);
    if (fopen(fname".inp", "r")) {
        freopen(fname".inp", "r", stdin);
        freopen(fname".out", "w", stdout);
    }
    cin >> n;
    for (int i = 1; i <= n; i++) {
        cin >> a[i].l >> a[i].r;
        a[i].r += a[i].l;
        a[i].id = i;
    }
    sort(a + 1, a + n + 1, cmp);
    for (int i = 0; i <= n; i++)
        for (int j = 0; j <= n; j++)
            for (int k = 0; k <= n; k++)
                f[i][j][k][0] = f[i][j][k][1] = inf;
    for (int i = 1; i <= n; i++)
        f[i][1][0][0] = a[i].r;
    for (int i = 1; i <= n; i++)
        f[i][0][1][1] = a[i].r;
    for (int i = 1; i <= n; i++)
        for (int j = 0; j <= i; j++)
            for (int k = 0; k <= i; k++) {
                f[i][j][k][0] = min(f[i][j][k][0], f[i - 1][j][k][0]);
                f[i][j][k][1] = min(f[i][j][k][1], f[i - 1][j][k][1]);
                 if (j){
                    f[i][j][k][0] = min(f[i][j][k][0], max(f[i - 1][j - 1][k][0], a[i].r));
                    if (f[i - 1][j - 1][k][1] <= a[i].l)
                        f[i][j][k][0] = min(f[i][j][k][0], a[i].r);
                }
                if (k){
                    f[i][j][k][1] = min(f[i][j][k][1], max(f[i - 1][j][k - 1][1], a[i].r));
                    if (f[i - 1][j][k - 1][0] <= a[i].l)
                        f[i][j][k][1] = min(f[i][j][k][1], a[i].r);
                }
            }
    for (int i = 0; i <= n; i++)
        for (int j = 0; j <= n; j++) {
            if (f[n][i][j][0] < inf && min(i, j) > res) {
                res = min(i, j);
                x = i, y = j;
            }
            if (f[n][i][j][1] < inf && min(i, j) > ret) {
                ret = min(i, j);
                _x = i, _y = j;
            }
        }
    if (res > ret) {
        int mask = 0;
        for (int i = n; i > 0; i--) {
            if ((!x && !y) || f[i][x][y][mask] == f[i - 1][x][y][mask]) {
                ans[a[i].id] = -1;
                continue;
            }
            ans[a[i].id] = mask;
            if (!mask && f[i][x][y][0] == max(f[i - 1][x - 1][y][0], a[i].r)) {
                x--;
                continue;
            }
            if (!mask && f[i - 1][x - 1][y][1] <= a[i].l) {
                x--;
                mask = 1;
                continue;
            }
            if (mask && f[i][x][y][1] == max(f[i - 1][x][y - 1][1], a[i].r)) {
                y--;
                continue;
            }
            if (mask && f[i - 1][x][y - 1][0] <= a[i].l) {
                y--;
                mask = 0;
                continue;
            }
        }
    }
    else {
        x = _x;
        y = _y;
        int mask = 1;
        for (int i = n; i > 0; i--) {
            if (a[i].id == 133)
                ret = 1;
            if ((!x && !y) || f[i][x][y][mask] == f[i - 1][x][y][mask]) {
                ans[a[i].id] = -1;
                continue;
            }
            ans[a[i].id] = mask;
            if (!mask && f[i][x][y][0] == max(f[i - 1][x - 1][y][0], a[i].r)) {
                x--;
                continue;
            }
            if (!mask && f[i - 1][x - 1][y][1] <= a[i].l) {
                x--;
                mask = 1;
                continue;
            }
            if (mask && f[i][x][y][1] == max(f[i - 1][x][y - 1][1], a[i].r)) {
                y--;
                continue;
            }
            if (mask && f[i - 1][x][y - 1][0] <= a[i].l) {
                y--;
                mask = 0;
                continue;
            }
            if (!mask)
                x--;
            else
                y--;
        }
    }
    for (int i = 1; i <= n; i++)
        cout << ans[i] + 1<< ' ';
}
