import sys
import gc

gc.disable()

s = sys.stdin.readline()

ans = 1000

sandro = 'Sandro'

for i in xrange(len(s)-6):
    cost = 0
    for j in xrange(6):
        if s[i+j] == sandro[j]:
            continue

        cost += 5

        if j == 0 and s[i+j].islower() and s[i+j].upper() != sandro[j]:
            cost += 5

        if j > 0 and s[i+j].isupper() and s[i+j].lower() != sandro[j]:
            cost += 5

    ans = min(ans, cost)

print ans
