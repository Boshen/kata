#include <iostream>
using namespace std;
int main(){

    int a,b;
    cin >> a >> b;
    
    cout << (a%2!=0 && b%2==0 ?  "no" : "yes") << endl;

    return 0;
}
