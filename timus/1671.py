import sys
import gc

gc.disable()

class Node:
    def __init__(self):
        self.parent = None
        self.rank   = 0

class Edge:
    def __init__(self, fr, to):
        self.fr     = fr
        self.to     = to
        self.isInQ  = False

class UnionFind:

    def __init__(self, size):
        self.connectedComponentsCount = size
        self.roots = {}

    def find_root(self, node):
        while node != node.parent:
            node = node.parent
        return node.parent

    def union(self, node1, node2):
        self.connectedComponentsCount -= 1
        if node1.rank > node2.rank:
            node2.parent = node1
        else:
            node1.parent = node2
            if node1.rank == node2.rank:
                node2.rank += 1

    def process(self, edge):
        fromRoot = self.find_root(edge.fr)
        toRoot = self.find_root(edge.to)
        if fromRoot != toRoot:
            self.union(fromRoot, toRoot)

N, M = map(int, sys.stdin.readline().split())

nodes = []
for i in range(N):
    nodes.append(Node())
    nodes[-1].parent = nodes[-1]

edges = []
for i in range(M):
    fr, to = map(int, sys.stdin.readline().split())
    edges.append(Edge(nodes[fr-1], nodes[to-1]))

Q = int(sys.stdin.readline())

removes = map(int, sys.stdin.readline().split())

qedges = []
qedges = [edges[remove-1] for remove in removes]
for qedge in qedges:
    qedge.isInQ = True

uf = UnionFind(N)

for edge in edges:
    if not edge.isInQ:
        uf.process(edge)

result = []
for qedge in reversed(qedges):
    result.append(uf.connectedComponentsCount)
    uf.process(qedge)

for r in reversed(result):
    sys.stdout.write(str(r) + " ")
sys.stdout.write('\n')

