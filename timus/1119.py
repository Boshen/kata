import heapq as hq
import math

N, M = map(int, raw_input().split())

K = int(raw_input())

diags = {}
for i in xrange(K):
    x, y = map(int, raw_input().split())
    diags[(x-1,y-1)] = 1

q = []
hq.heappush(q, (0.0, 0, 0))
dists = [ [1e9 for i in xrange(N+1)] for j in xrange(M+1)]
dists[0][0] = 0

dist = lambda x1, x2, y1, y2: math.sqrt((x1-x2)*(x1-x2) + (y1-y2)*(y1-y2))
while q:
    (d, x, y) = hq.heappop(q)
    dxy = dists[y][x]

    if x == N and y == M:
        print int((dxy*100)+0.5)
        break
    
    if (x, y) in diags:
        edges = [ (x+1,y), (x,y+1), (x+1,y+1) ]
    else:
        edges = [ (x+1,y), (x,y+1)]

    for n, m in edges:
        if n <= N and m <= M:
            newd =  dist(x, n, y, m) + dxy
            if  newd < dists[m][n]:
                dists[m][n] = newd
                hq.heappush(q, (newd+dist(n,N,m,M), n, m))
