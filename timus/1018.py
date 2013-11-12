N, Q = map(int, raw_input().split())
tmp = {}
Nodes = {}
costs = {}
while True:
    try:
        fr, to, cost = map(int, raw_input().split())
    except:
        break

    if fr not in tmp:
        tmp[fr] = { }
    
    if to not in tmp:
        tmp[to] = { }

    tmp[fr][to] = cost
    tmp[to][fr] = cost


def build(root):
    if root not in tmp:
        return

    if not tmp[root]:
        tmp.pop(root, None)
        return

    if len(tmp[root])==2:
        left, right = tmp[root]
        tmp[right].pop(root, None)
        tmp[left].pop(root, None)
        Nodes[root] = (left, right)
        costs[right] = tmp[root][right]
        costs[left] = tmp[root][left]
        build(left)
        build(right)

build(1)
costs[1] = 0

cache = {}
def V(x, y):
    if (x,y) in cache:
        return cache[(x,y)]

    if y == 0: return 0
    if y == 1: return costs[x]
    if x not in Nodes: return 0


    a, b = Nodes[x]
    maxx = max(costs[x] + V(a, i) + V(b, y-1-i) for i in xrange(y))

    cache[(x,y)] = maxx
    return maxx

print V(1, Q+1)
