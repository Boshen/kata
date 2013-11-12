n, t, s = map(int, raw_input().split())
y = map(int, raw_input().split())

for x in y:

    if x >= s:
        print '%.6f' % (x + (t-(x-s))/2.0)
    else:
        print '%.6f' % (s + (t-(s-x))/2.0)
        

