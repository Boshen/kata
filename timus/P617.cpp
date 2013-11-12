#include <iostream>
#include <map>

using namespace std;
int main(){
    int N;
    cin >> N;
    map<int,int> v;
    int tmp;
    for(int i=0;i<N;i++){
        cin >> tmp;
        if(!v.count(tmp)){
            v.insert(pair<int,int>(tmp,1));
        }else{
            v[tmp]++;
        }
    }
    int sum=0;
    for(map<int,int>::iterator it=v.begin();it!=v.end();it++){
        sum+= (it->second)/4;
    }
    cout << sum << endl;

}
