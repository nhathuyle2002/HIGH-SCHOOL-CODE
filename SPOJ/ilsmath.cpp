#include <iostream>
#include <stdio.h>
#include <math.h>
#include <vector>

using namespace std;
////////////////

int n;
double sum;
vector<int> q;
///////////////

void enter()
{
    scanf("%d", &n);
}
///////////////

void process()
{
    q.clear();
    if (n==1) q.push_back(1);
    sum=0;
    int i=0;
    while (true)
    {
        i++;
        sum+=log10(i);
        if (ceil(sum)==n) q.push_back(i);
        else if (ceil(sum)>n) break;
    }
    if (q.empty()) cout << "NO";
    else
    {
    cout << q.size() << '\n';
    for (int i=0; i<q.size(); i++)
        cout << q[i] << '\n';
    }
}
//////////////////

int main()
{
    //freopen("ilsmath.inp", "r", stdin);
    //freopen("ilsmath.out", "w", stdout);
    enter();
    process();
}
