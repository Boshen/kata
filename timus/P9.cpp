#include <iostream>
using namespace std;
long a[10000];
//int foo(int n, int k){
//    if(n==0) return 1;
//    if(n==1) return k-1;
//    return (k-1)*(foo(n-1,k)+foo(n-2,k));
//}

int main(){

    int n, k;
    cin >> n >> k;
    a[0] = 1;
    a[1] = k-1;
    for(int i=2;i<=n;i++){
        a[i] = (k-1)*(a[i-1]+a[i-2]);
    }
    cout << a[n] << endl;
    //cout << foo(n, k) << endl;

    return 0;
} 
