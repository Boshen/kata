#include <iostream>
#include <string>
using namespace std;
int main(){
    int h,w,n;
    string word;
    cin >> h >> w >> n;
    int curLen = 0;
    int curLine = 0;
    int numPage = 1;
    for(int i=0;i<n;i++){
        cin >> word;
        int len = word.length();
        // perfect fit
        if(curLen+len==w){
            curLine++;
            curLen=0;
        }else if(curLen+len>w){
            curLine++;
            curLen=len+1;
        }else{
            curLen+=len+1;
        }
        if(curLine==h){
            numPage++;
            curLine=0;
        }
    }
    if(curLen==0 && curLine==0){
        numPage-=1;
    }
    cout << numPage << endl;
    return 0;
}
