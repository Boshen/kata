import re

s = raw_input()

r = re.compile("([0-9]+)([a-zA-Z]+)")
m = r.match(s)

n = int(m.group(1))
s = m.group(2)

if n <= 2:
    if s in 'AD':
        print 'window'
    else:
        print 'aisle'
elif n <= 20:
    if s in 'AF':
        print 'window'
    else:
        print 'aisle'
else:
    if s in 'AK':
        print 'window'
    elif s in 'CDGH':
        print 'aisle'
    else:
        print 'neither'

    

