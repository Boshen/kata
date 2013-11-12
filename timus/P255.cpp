#include <iostream>
using namespace std;

int main(){
int n, t;
cin >> n;
long u =0;
long v=1;
for(int i=0;i<n-1;i++){
t = u + v;
u = v;
v = t;
}
cout << (v*2)<<endl;
return 0;
}
