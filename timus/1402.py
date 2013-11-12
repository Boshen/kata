import math

N = int(raw_input())
count = 0
for i in range(2, N+1):
    count += math.factorial(N)/(math.factorial(N-i))

print count

