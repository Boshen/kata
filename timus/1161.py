import sys
import math
n = int(sys.stdin.readline())

l = sorted(map(int, sys.stdin.readlines()), reverse=True)

ans = l[0]
for i in xrange(1, n):
    ans = 2 * math.sqrt(ans*l[i])

print '%.2f' % ans

