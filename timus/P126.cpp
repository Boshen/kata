#include <iostream>
#include <algorithm>
using namespace std;
int a[25000];
int main(){
    int n;
    cin >> n;

    long i=0;
    while(true){
        cin >> a[i];
        if(a[i]==-1)break;
        i++;
    }
    for(long j=n-1;j<i;j++){
        cout << *max_element(a+j+1-n,a+j+1) << endl;
    }
    return 0;
}
