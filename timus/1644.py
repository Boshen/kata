n = int(raw_input())

hungry = []
satisfied = []

for i in xrange(n):
    a, b = raw_input().split()
    if b[0] == 'h':
        hungry.append(int(a))
    else:
        satisfied.append(int(a))


if hungry:
    maxx = max(hungry)
else:
    maxx = 2

if satisfied:
    minn = min(satisfied)
else:
    minn = 10

if maxx >= minn:
    print 'Inconsistent'
else:
    print minn
