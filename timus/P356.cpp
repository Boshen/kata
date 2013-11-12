#include <iostream>
using namespace std;

int arr[100000], cnt = 0;
bool nprime[1000001];

bool isPrime(int n){
    if(n<=1) return false;
    for(long long i = 2; i * i <= n; i ++)
        if(n % i == 0)
            return false;
    return true;
}

void getFactors(int n, int& b, int &c){
    b = c= 0;
    for(int i = 0; i < cnt; i ++){
        int x = arr[i];
        if(isPrime(n - x)){
            b = x;
            c = n - x;
            return;
        }
    }
}
/*
int foo(int y){
    int i =0;
    while( arr[i++] < y);
    return i-1;
}
void getFactors2(int x, int n, int i, int&b, int &c){
    int y = x - arr[n-i];
    if(y==0){
        c = arr[n-i];
        return;
    }
    if(y<2){
        getFactors2(x,n,i+1,b,c);
    }else{
        b = arr[n-i];
        getFactors2(y, foo(y), 0, b, c);
    }
}
*/
int main(){
    for (long long i = 2; i <= 100000; ++i) {
        if(!nprime[i]){
            arr[cnt++] = i;
            for(long long j = i*i;j<10000;j+=i)
                nprime[j] = true;
        }
    }
    int t, a, b, c;
    for(cin>>t;t--;){
        // goldbach's conjecture
        cin >> a;
        if(isPrime(a))
            cout << a << endl;
        else if(a%2!=0){
            if(isPrime(a-2))
                cout << 2 << " " << a-2 << endl;
            else{
                getFactors(a-3,b,c);
 //               getFactors2(a,foo(a),0,b,c);
                cout << 3 << " " << b << " " << c << endl;
            }
        }else{
            getFactors(a,b,c);
            cout << b << " " << c << endl;
        }
    }
    return 0;
}


