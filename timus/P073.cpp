#include <iostream>
#include <cmath>
using namespace std;
int data[401];
int main() {
    int n;
    cin>>n;
    data[1]=1;
    data[2]=2;
    for (int i=3;i<=n;++i) {
        int min=data[i-1]+1;
        for (int j=2;j<=20;++j) {
            if (i>=j*j) {
                if (min>data[i-j*j]+1) min=data[i-j*j]+1;
            }
            else break;
        }
        data[i]=min;
    }
    for(int i=0;i<401;i++){
        cout << data[i] <<endl;
    }
    return 0;
}
