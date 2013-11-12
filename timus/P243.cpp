#include <cstdio>
int main(){
    char c;
    char r;
    while(scanf(" %c",&c)!=EOF||(printf("%d\n",r)&0))
        r = (r*10+c-'0')%7;

    return 0;
}
