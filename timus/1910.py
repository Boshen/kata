N = int(raw_input())

line = map(int, raw_input().split())

maxx = 0
index = 0
for i in range(1, N-1):
    s = line[i]+line[i-1]+line[i+1]
    if s > maxx:
        maxx = s
        index = i

print maxx, index+1
