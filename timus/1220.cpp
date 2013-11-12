#include <cstdio>
#include <string>

#define MAX_OPS         100000
#define MAX_STACKS      1000

int N;
int STACK[MAX_OPS];                     
int COUNT[MAX_STACKS + 1];
int STACK_POINTER[MAX_STACKS + 1];

int main(){

    int stack, value;
    char op[8];

    for (int i = 0; i <= MAX_STACKS; i++)
        COUNT[i] = 0;

    scanf("%d", &N);

    for (int i = 0; i < N; i++){
        scanf("%s %d", op, &stack);
        if (op[1] == 'U'){
            scanf("%d", &value);
            COUNT[stack]++;
        }
    }

    STACK_POINTER[0] = 0;
    for (int i = 0; i < MAX_STACKS; i++)
        STACK_POINTER[i+1] = STACK_POINTER[i] + COUNT[i];

    fseek(stdin, 0, SEEK_SET);

    scanf("%d", &N);

    for (int i = 0; i < N; i++){
        scanf("%s %d", op, &stack);
        if (op[1] == 'U'){
            scanf("%d", &value);
            STACK[STACK_POINTER[stack]++] = value;
        }else{
            printf("%d\n", STACK[--STACK_POINTER[stack]]);

        }

    }

    return 0;
}
