#include <iostream>
#include <string>

using namespace std;
void An(int n){
    for(int i=1;i<n;i++)
        cout << "sin(" << i << (i%2==0?"+":"-");
    cout << "sin(" << n;
    for(int i=1;i<=n;i++)
        cout << ")";
}
void Sn(int n){
    for(int i=1;i<n;i++)
        cout << "(";
    for(int i=1;i<n;i++){
        An(i);
        cout << "+" << n-i+1 << ")";
    }
    An(n);
    cout << "+1";
}
int main(){
    int N;
    cin >> N;
    Sn(N);
    cout << endl;

    return 0;
}
