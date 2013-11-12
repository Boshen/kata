#include <iostream>
#include <cstdlib>
using namespace std;
int func(void);
void func2(void);
int a[6];
int n;
int main(){
    cin >> n;
    if(n==999999 || n==0){
        cout << "Yes" << endl;
        return 0;
    }
    int orig = n;
    n = orig+1;
    func2();
    if(func()){cout << "Yes" << endl;return 0;}
    n = orig-1;
    func2();
    if(func()) cout << "Yes" << endl;
    else cout << "No" << endl;
    return 0;
}
int func(void){
    return (a[0]+a[1]+a[2])==(a[3]+a[4]+a[5]);
}
void func2(void){
    int i=5;
    while(n!=0){
        a[i] = n%10;
        n/=10;
        i--;
    }
}
