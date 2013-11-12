import sys
c = int(sys.stdin.readline())

s = c % 3

print 1 if s else 2
if s:
    print s
