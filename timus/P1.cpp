#include <iostream>
#include <cmath>
#include <cstdio>
using namespace std;

double a[128*1024];
int main(void){

    int n = 0;
    double x;
    while(cin>>x){
        a[n] = sqrt(x);
        n++;
    }
        
    while(n){
        printf("%.4lf\n", a[--n]);
    }

    return 0;
}
