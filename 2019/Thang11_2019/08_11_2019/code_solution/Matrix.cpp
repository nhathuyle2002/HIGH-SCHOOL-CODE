#include <bits/stdc++.h>

using namespace std;
#define fname "Matrix"
typedef pair <int, int> ii;
const int N = 111;
const int M = 3011;
int n, exits, cnt, s, t, res, sum, a[N], b[N], ans[N][N], ret[N][N], dg[N], ct[N], _dg[N], _ct[N];
int ds[N], bac[N];
set <ii> S;
void Try(int x, int y) {
    if (exits)
        return;
    if (y > n) {
        Try(x + 1, 1);
        return;
    }
    if (x > n) {
        for (int i = 1; i <= n; i++)
            if (dg[i] + ct[i] != a[i])
                return;
        for (int i = 1; i <= n; i++)
            if (_dg[i] + _ct[i] != b[i])
                return;
        exits = 1;
        cout << "YES\n";
        for (int i = 1; i <= n; i++) {
            for (int j = 1; j <= n; j++)
                cout << ans[i][j] << ' ';
            cout << '\n';
        }
        return;
    }
    Try(x, y + 1);
    if (x == y) return;
    if (x > y) {
        _ct[y]++;
        _dg[x]++;
        if (_ct[y] + _dg[y] > b[y] || _dg[x] + _ct[x] > b[x]) {
            _ct[y]--;
            _dg[x]--;
            return;
        }
    }
    else {
        ct[y]++;
        dg[x]++;
        if (ct[y] + dg[y] > a[y] || dg[x] + ct[x] > a[x]) {
            ct[y]--;
            dg[x]--;
            return;
        }
    }
    ans[x][y] = 1;
    Try(x, y + 1);
    ans[x][y] = 0;
    if (x > y)
        _ct[y]--, _dg[x]--;
    else
        ct[y]--, dg[x]--;
}
void TryUp(int x, int y) {
    if (exits == 2)
        return;
    if (y > n) {
        TryUp(x + 1, 1);
        return;
    }
    if (x > n) {
        for (int i = 1; i <= n; i++)
            if (dg[i] + ct[i] != a[i])
                return;
        exits++;
        for (int i = 1; i <= n; i++)
            for (int j = 1; j <= n; j++)
                if (j > i)
                    ret[i][j] = ans[i][j];
        return;
    }
    TryUp(x, y + 1);
    if (y <= x)
        return;
    ct[y]++;
    dg[x]++;
    if (ct[y] + dg[y] > a[y] || dg[x] + ct[x] > a[x]) {
        ct[y]--;
        dg[x]--;
        return;
    }
    ans[x][y] = 1;
    TryUp(x, y + 1);
    ans[x][y] = 0;
    ct[y]--, dg[x]--;
}
void TryDown(int x, int y) {
    if (exits)
        return;
    if (y > n) {
        TryDown(x + 1, 1);
        return;
    }
    if (x > n) {
        for (int i = 1; i <= n; i++)
            if (_dg[i] + _ct[i] != b[i])
                return;
        exits++;
        for (int i = 1; i <= n; i++)
            for (int j = 1; j <= n; j++)
                if(i > j)
                    ret[i][j] = ans[i][j];
        return;
    }
    TryDown(x, y + 1);
    if (y >= x)
        return;
    _ct[y]++;
    _dg[x]++;
    if (_ct[y] + _dg[y] > b[y] || _dg[x] + _ct[x] > b[x]) {
        _ct[y]--;
        _dg[x]--;
        return;
    }
    ans[x][y] = 1;
    TryDown(x, y + 1);
    ans[x][y] = 0;
    _ct[y]--, _dg[x]--;
}
bool cmp(int a, int b) {
    return bac[a] > bac[b];
}
int main() {
    ios_base::sync_with_stdio(0);
    cin.tie(0); cout.tie(0);
    if (fopen(fname".inp", "r")) {
        freopen(fname".inp", "r", stdin);
        freopen(fname".out", "w", stdout);
    }
    cin >> n;
    for (int i = 1; i <= n; i++)
        cin >> a[i];
    for (int i = 1; i <= n; i++)
        cin >> b[i];
//    if (n <= 5) {
//        Try(1, 1);
//        if (!exits)
//            cout << "NO";
//        return 0;
//    }
//    if (n <= 7) {
//        TryDown(2, 1);
//        if (!exits) {
//            cout << "NO";
//            return 0;
//        }
//        TryUp(1, 2);
//        if (exits == 1) {
//            cout << "NO";
//            return 0;
//        }
//        cout << "YES\n";
//        for (int i = 1; i <= n; i++) {
//            for (int j = 1; j <= n; j++)
//                cout << ret[i][j] << ' ';
//            cout << '\n';
//        }
//        return 0;
//    }
    for (int i = 1; i <= n; i++)
        bac[i] = a[i],
        ds[i] = i;
    for (int i = 1; i <= n; i++) {
        sort(ds + 1, ds + n + 1, cmp);
        int u = ds[1];
        for (int j = 2; j <= n; j++) {
            if (bac[ds[j]] <= 0)
                continue;
            if (!bac[u]) break;
            ans[min(u, ds[j])][max(u, ds[j])] = 1;
            bac[u]--;
            bac[ds[j]]--;
        }
        if (bac[u] > 0) {
            cout << "NO";
            return 0;
        }
        bac[u]--;
    }
    for (int i = 1; i <= n; i++)
        bac[i] = b[i],
        ds[i] = i;
    for (int i = 1; i <= n; i++) {
        sort(ds + 1, ds + n + 1, cmp);
        int u = ds[1];
        if (!bac[u])
            break;
        for (int j = 2; j <= n; j++) {
            if (bac[ds[j]] <= 0 )
                continue;
            if (!bac[u]) break;
            ans[max(u, ds[j])][min(u, ds[j])] = 1;
            bac[u]--;
            bac[ds[j]]--;
        }
        if (bac[u] > 0) {
            cout << "NO";
            return 0;
        }
        bac[u]--;
    }
    cout << "YES\n";
    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= n; j++)
            cout << ans[i][j] << ' ';
        cout << '\n';
    }
}
//    s = cnt = 1;
//    t = cnt = 2;
//    for (int i = 1; i <= n; i++) {
//        for (int j = 1; j <= n; j++) {
//            if (i == j)
//                continue;
//            id[i][j] = ++cnt;
//            c[s][cnt] = 2;
//            ke[cnt].push_back(s);
//            ke[s].push_back(cnt);
//        }
//    }
//    for (int i = 1; i <= n; i++) {
//        nhan[i] = ++cnt;
//        c[cnt][t] = a[i];
//        sum += a[i];
//        ke[t].push_back(cnt);
//        ke[cnt].push_back(t);
//        _nhan[i] = ++cnt;
//        c[cnt][t] = b[i];
//        sum += b[i];
//        ke[cnt].push_back(t);
//        ke[t].push_back(cnt);
//    }
//    for (int i = 1; i <= n; i++) {
//        dg[i] = ++cnt;
//        c[dg[i]][nhan[i]] = a[i];
//        ke[nhan[i]].push_back(dg[i]);
//        ke[dg[i]].push_back(nhan[i]);
//        ct[i] = ++cnt;
//        c[ct[i]][nhan[i]] = a[i];
//        ke[nhan[i]].push_back(ct[i]);
//        ke[ct[i]].push_back(nhan[i]);
//        _dg[i] = ++cnt;
//        c[_dg[i]][_nhan[i]] = a[i];
//        ke[_nhan[i]].push_back(_dg[i]);
//        ke[_dg[i]].push_back(_nhan[i]);
//        _ct[i] = ++cnt;
//        c[_ct[i]][_nhan[i]] = a[i];
//        ke[_nhan[i]].push_back(_ct[i]);
//        ke[_ct[i]].push_back(_nhan[i]);
//    }
//    for (int i = 1; i <= n; i++)
//        for (int j = 1; j <= n; j++) {
//            if (i == j)
//                continue;
//            if (i > j) {
//                c[id[i][j]][_dg[i]] = 1;
//                ke[id[i][j]].push_back(dg[i]);
//                ke[_dg[i]].push_back(id[i][j]);
//                c[id[i][j]][_ct[j]] = 1;
//                ke[id[i][j]].push_back(_ct[j]);
//                ke[_ct[j]].push_back(id[i][j]);
//            }
//            else {
//                c[id[i][j]][dg[i]] = 1;
//                ke[id[i][j]].push_back(dg[i]);
//                ke[dg[i]].push_back(id[i][j]);
//                c[id[i][j]][ct[j]] = 1;
//                ke[id[i][j]].push_back(ct[j]);
//                ke[ct[j]].push_back(id[i][j]);
//            }
//        }
//    while (Find())
//        Inc();
//    if (res != sum) {
//        cout << "NO";
//        return 0;
//    }
//    cout << "YES\n";
//    for (int i = 1; i <= n; i++) {
//        for (int j = 1; j <= n; j++)
//            cout << (f[s][id[i][j]] > 0) << ' ';
//        cout << '\n';
//    }
//}
