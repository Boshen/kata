n, k = map(int, raw_input().split())

sumb = k
sumg = 0
for i in range(n):
    b, g = map(int, raw_input().split())
    sumb += b
    sumg += g

if sumb >= sumg+2*(n+1):
    print sumb - sumg - 2*(n+1)
else:
    print 'Big Bang!'

