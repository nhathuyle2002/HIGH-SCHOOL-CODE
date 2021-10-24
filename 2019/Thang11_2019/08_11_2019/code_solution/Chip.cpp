#include <bits/stdc++.h>

using namespace std;
#define fname "Chip"
#define fi first
#define se second
const int N = 511;
int n, m, h, a[N], start[N], finish[N], ans[N][N];
char res[N][N];
pair <int, int> b[N];
void check() {
    for (int j = 1; j <= m; j++) {
        int i = 1, cnt = 0;
        while (i <= n) {
            int dem = 0;
            if (!ans[i][j])
                i++;
            while (ans[i][j])
                dem++,
                i++;
            if (dem % h) {
                cout << "NO";
                exit(0);
            }
            cnt += dem / h;
        }
        if (cnt != b[j].fi) {
            cout << "NO";
            exit(0);
        }
    }
    for (int i = 1; i <= n; i++) {
        int cnt = 0;
        for (int j = 1; j <= m; j++)
            if (!ans[i][j])
                cnt++;
        if (cnt != a[i]) {
            cout << "NO";
            exit(0);
        }
    }
}
bool cmp(pair <int, int> a, pair <int, int> b) {
    if (a.fi == b.fi)
        return a.se < b.se;
    return a.fi > b.fi;
}
int main() {
    ios_base::sync_with_stdio(0);
    cin.tie(0); cout.tie(0);
    if (fopen(fname".inp", "r")) {
        freopen(fname".inp", "r", stdin);
        freopen(fname".out", "w", stdout);
    }
    cin >> n >> m >> h;
    for (int i = 1; i <= n; i++)
        cin >> a[i];
    for (int i = 1; i <= m; i++) {
        cin >> b[i].fi;
        if (b[i].fi * h > n) {
            cout << "NO";
            return 0;
        }
        b[i].se = i;
    }
    sort(b + 1, b + m + 1, cmp);
    for (int i = 1; i <= m; i++)
        for (int j = 1; j <= b[i].fi * h; j++)
            ans[j][i] = 1;
    for (int i = 1; i <= n; i++) {
        int cnt = 0;
        for (int j = 1; j <= m; j++)
            if (!ans[i][j])
                cnt++;
        for (int j = m; j > 0; j--) {
            if (cnt == a[i])
                break;
            if (ans[i][j]) {
                int dem = 0;
                for (int k = 1; k < i; k++)
                    if (ans[k][j])
                        dem++;
                if (dem % h)
                    continue;
                for (int k = i + 1; k <= n; k++) {
                    if (!ans[k][j]) {
                        ans[k][j] = 1;
                        ans[i][j] = 0;
                        cnt++;
                        break;
                    }
                }

            }
        }
        if (cnt != a[i]) {
            cout << "NO";
            return 0;
        }
    }
    check();
    for (int i = 1; i <= m; i++)
        start[i] = -n - 10;
    for (int i = 1; i <= n; i++)
        for (int j = 1; j <= m; j++) {
            if (!ans[i][j])
                res[i][b[j].se] = '*',
                finish[j] = i;
            else {
                if (start[j] + h - 1 == i || h == 1)
                    res[i][b[j].se] = '+',
                    finish[j] = i;
                else
                    if (finish[j] + 1 == i)
                        res[i][b[j].se] = '+',
                        start[j] = i;
                    else
                        res[i][b[j].se] = '|';
            }
        }
    cout << "YES\n";
    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= m; j++)
            cout << res[i][j];
        cout << '\n';
    }
}
