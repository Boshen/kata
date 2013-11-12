#include <iostream>
#include <string>
using namespace std;

int main(){
    int n;
    cin >> n;
    int e,m,l;
    e=m=l=0;
    string s, s2;
    for(int i=0;i<n;i++){
        cin >> s >> s2;
        if(s[0]=='E'){e++; continue;}
        if(s[0]=='M'){m++; continue;}
        if(s[0]=='L') l++;
    }
    
    if( e>m && e>l ) cout << "Emperor Penguin" << endl;
    if( m>l && m>e ) cout << "Macaroni Penguin" << endl;
    if( l>m && l>e ) cout << "Little Penguin" << endl;
    return 0;
}

