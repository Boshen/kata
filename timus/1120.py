import sys
import gc
import math

gc.disable()

N = int(sys.stdin.readline())

N *= 2

div = [1]

for i in xrange(2, int(math.sqrt(N))+1):
    if N % i == 0:
        div.append(N/i)
        div.append(i)

div.sort(reverse=True)

for num in div:
    r = N / num
    r = r - num + 1
    if r > 0 and r % 2 == 0:
        print r/2, num
        break


