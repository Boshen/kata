import sys
N, M = map(int, raw_input().split())

l = map(int, sys.stdin.readlines())

for i in xrange(10):
    sys.stdout.write(str(l[(i+M)%N]))
print
