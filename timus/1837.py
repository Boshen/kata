import sys
import gc
import heapq

gc.disable()

n = int(raw_input())

teams = []
names = set()

for i in xrange(n):
    name = sys.stdin.readline().split()
    teams.append(set(name))
    for s in name:
        names.add(s)

hq = [(0, 'Isenbaev')]
mp = {}

while hq:
    d, name = heapq.heappop(hq)
    if name in mp:
        continue
    mp[name] = d
    for i in xrange(n):
        if name in teams[i]:
            for s in teams[i]:
                if s != name:
                    heapq.heappush(hq, (d+1, s))

for name in sorted(names):
    print name,
    if name in mp:
        print mp[name]
    else:
        print 'undefined'



