#include <iostream>
#include <set>
#include <map>

using namespace std;
int main(){
    long long N,M;
    cin >> N;
    long tmp;
    set<long long> v;
    for(int i=0;i<N;i++){
        cin >> tmp;
        v.insert(tmp);
    }
    cin >> M;
    map<long long,long long> s;
    for(int i=0;i<M;i++){
        cin >> tmp;
        if(s.count(tmp)){
            s[tmp]++;
        }else{
            s.insert(pair<long long ,long long>(tmp,1));
        }
    }
    int total=0;
    for(set<long long>::iterator it=v.begin();it!=v.end();it++){
        if(s.count(*it)){
            total+=s[*it];
        }
    }
    cout << total << endl;
    //for(map<int,int>::iterator it = s.begin();it!=s.end();it++){
    //    cout << it->first << " " << it->second << endl;
    //}



    return 0;
}
