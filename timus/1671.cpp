#include <stdio.h>
#include <iostream>
#include <vector>
#include <string>
#include <map>
#include <set>
#include <list>
#include <algorithm>

using namespace std;

struct TNode {
    TNode *Parent;
    int Rank;
    TNode() : Parent(0) , Rank(0) { }
};

struct TEdge {
    TNode *From;
    TNode *To;
    bool IsInQ;
    TEdge() : From(0) , To(0) , IsInQ(false) { }
};

struct TDisjointSet {
    int ConnectedComponentsCount;

    TDisjointSet(int size) {
        ConnectedComponentsCount = size;
    }

    TNode* FindSetRoot(TNode *node) {
        if (node != node->Parent)
            node->Parent = FindSetRoot(node->Parent);
        return node->Parent;
    }

    void UnionRoots(TNode *r1, TNode *r2) {
        ConnectedComponentsCount--;
        if (r1->Rank > r2->Rank)
            r2->Parent = r1;
        else {
            r1->Parent = r2;
            if (r1->Rank == r2->Rank)
                (r2->Rank)++;
        }
    }

    void Process(TEdge &edge) {
        TNode *fromRoot = FindSetRoot(edge.From);
        TNode *toRoot = FindSetRoot(edge.To);
        if (fromRoot != toRoot)
            UnionRoots(fromRoot, toRoot);
    }
};

int main() {

    int N, M, Q;

    scanf("%d %d\n", &N, &M);

    vector<TNode> nodes(N);
    for (int i = 0; i < N; i++)
        nodes[i].Parent = &nodes[i];

    vector<TEdge> edges(M);
    int from, to;
    for (int i = 0; i < M; ++i) {
        scanf("%d %d\n", &from, &to);
        TEdge &edge = edges[i];
        edge.From = &(nodes[from-1]);
        edge.To = &(nodes[to-1]);
    }

    scanf("%d\n", &Q);
    vector<TEdge*> qedges(Q);
    int qnum;
    for (int i = 0; i < Q; ++i) {
        scanf("%d", &qnum); 
        TEdge &qedge = edges[qnum-1];
        qedge.IsInQ = true;
        qedges[i] = &qedge;
    }

    TDisjointSet ds(N);

    for (vector<TEdge>::iterator iter = edges.begin(), end = edges.end(); iter != end; ++iter) {
        TEdge &edge = *iter;
        if (edge.IsInQ)
            continue;
        ds.Process(edge);
    }

    vector<int> result;
    for (vector<TEdge*>::reverse_iterator iter = qedges.rbegin(), end = qedges.rend(); iter != end; ++iter) {
        TEdge &edge = **iter;
        result.push_back(ds.ConnectedComponentsCount);
        ds.Process(edge);
    }

    for (vector<int>::const_reverse_iterator iter = result.rbegin(), end = result.rend(); iter != end; ++iter)
        printf("%d ", *iter);
    printf("\n");

    return 0;
}
