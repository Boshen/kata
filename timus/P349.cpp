#include <iostream>
#include <cmath>
using namespace std;

int main(){
    int n;
    cin >> n;
    for(int a=1;a<=100;a++){
        for(int b=1;b<=100;b++){
            for(int c=1;c<=100;c++){
                if( (int)pow((double)a,n)+(int)pow((double)b,n)==(int)pow((double)c,n)){
                    if(a!=b && b!=c && a!=c){
                        cout << a << " " << b << " " << c << endl;
                        return 0;}
                }
            }

        }
    }
    cout << -1 << endl;
    return 0;
}
