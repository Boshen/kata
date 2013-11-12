import gc
import sys


gc.disable()

N = int(sys.stdin.readline())

inspects = map(int, sys.stdin.readlines())

inspect = 0

pocket = []
for i in xrange(1, N+1):
    pocket.append(i)
    while pocket and pocket[-1] == inspects[inspect]:
        pocket.pop()
        inspect += 1

print 'Cheater' if pocket else 'Not a proof'
