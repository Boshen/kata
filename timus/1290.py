l = []
N = int(raw_input())
for i in xrange(N):
    l.append(int(raw_input()))

l = sorted(l, reverse=True)

print '\n'.join(map(str,l)),
