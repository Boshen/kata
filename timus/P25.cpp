#include <iostream>
#include <algorithm>
using namespace std;

int a[102];
int main(){
    int n;
    cin >> n; 
    for(int i=0;i<n;i++)
        cin >> a[i];

    sort(a,a+n);
    int sum=0;
    for(int i=0;i<n/2+1;i++)
        sum+=(a[i]/2+1);

    cout << sum << endl;
    return 0;
}
