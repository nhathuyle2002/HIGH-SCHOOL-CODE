#define taskname "EXPRESSION"
#include <iostream>
#include <cstdio>
#include <string>
#include <stack>
#include <vector>
using namespace std;
typedef long long lli;
string s;
vector<string> exp;
bool InvalidGCD = false;

void Enter()
{
    getline(cin, s);
    string w = "";
    for (int i = 0; i < s.length(); i++)
        if (s[i] != '(' && s[i] != ')' && s[i] != ',')
            w.push_back(s[i]);
        else
            if (w != "")
            {
                exp.push_back(w);
                w = "";
            }
    if (w != "")
        exp.push_back(w);
}

lli Tolli(const string& s)
{
    lli res = 0;
    for (char c: s)
        res = res * 10 + c - '0';
    return res;
}

bool IsNum(const string& s)
{
    return s[0] >= '0' && s[0] <= '9';
}

lli gcd(lli a, lli b)
{
    if (a == b && b == 0)
        InvalidGCD = true;
    while (b != 0)
    {
        lli r = a % b;
        a = b;
        b = r;
    }
    return a >= 0 ? a : -a;
}

void Solve()
{
    stack<lli> Stack;
    vector<string>::const_reverse_iterator it;
    for (it = exp.rbegin(); it != exp.rend(); it++)
        if (IsNum(*it))
            Stack.push(Tolli(*it));
        else
        {
            lli x = Stack.top(); Stack.pop();
            lli y = Stack.top(); Stack.pop();
            if (*it == "SUM")
                Stack.push(x + y);
            else if (*it == "DIF")
                Stack.push(x - y);
            else if (*it == "MAX")
                Stack.push(max(x, y));
            else if (*it == "MIN")
                Stack.push(min(x, y));
            else
                Stack.push(gcd(x, y));

        }
    if (InvalidGCD) cout << "INVALID";
    else cout << Stack.top();
}

int main()
{
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);
    freopen(taskname".inp", "r", stdin);
    freopen(taskname".out", "w", stdout);
    Enter();
    Solve();
}
