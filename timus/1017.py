
N = int(raw_input())
q = [0]*(N+1)

q[0] = 1
for i in range(1, N+1):
    for j in range(N, i-1, -1):
        q[j] += q[j-i]

print q[N]-1
