import gc
import sys
num = 0
gc.disable()
for i in xrange(input()):
    n = int(sys.stdin.readline())
    if num == 0:
        ans = n
        num = 0
    num += 1 if ans==n else -1
print ans
