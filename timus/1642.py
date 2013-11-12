n, x = map(int, raw_input().split())

obs = map(int, raw_input().split())

x1 = -1000
x2 = 1000

for i in obs:
    if i < 0:
        x1 = max(x1, i)
    if i > 0:
        x2 = min(x2, i)

if x1 < x < x2:
    if x > 0:
        print x, x-2*x1
    else:
        print 2*x2-x, -x
else:
    print 'Impossible'
