#include <vector>
#include <cstdio>

using namespace std;
vector<char> v1;
vector<char> v2;
int main(){
    int N;
    scanf("%d", &N);
    for(int i=0;i<N;i++){
        char c;
        scanf("\n%c ",&c);
        v1.push_back(c);
        scanf("%c",&c);
        v2.push_back(c);
    }
    int carry=0;
    int sum;
    for(int i=N-1;i>=0;i--){
        sum = (v1[i]-'0')+(v2[i]-'0');
        v1[i]=(sum+carry)%10;
        carry = (sum+carry)/10;
    }
    if(carry!=0){
        printf("%d",carry);
    }
    for(int i=0;i<N;i++){
        printf("%c",v1[i]+'0');
    }
    puts("");

    return 0;
}
