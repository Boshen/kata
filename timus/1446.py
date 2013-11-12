import sys
import gc

gc.disable()

N = int(sys.stdin.readline())

Sl = []
Hu = []
Gr = []
Ra = []

for i in xrange(N):
    name = sys.stdin.readline()
    house = sys.stdin.readline()
    if house[0:2] == 'Sl':
        Sl.append(name)
    if house[0:2] == 'Hu':
        Hu.append(name)
    if house[0:2] == 'Gr':
        Gr.append(name)
    if house[0:2] == 'Ra':
        Ra.append(name)

print 'Slytherin:'
print ''.join(Sl)
print 'Hufflepuff:'
print ''.join(Hu)
print 'Gryffindor:'
print ''.join(Gr)
print 'Ravenclaw:'
print ''.join(Ra)
