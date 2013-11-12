
N, K = map(int, raw_input().split())

done = N

i = 1
time = 0
while i <= K and i < N:
    i = i + i
    time += 1

if i >= N:
    print time
else:
    print time + (N-i+K-1) / K
