import operator
x = map(int, raw_input().split())
money = int(raw_input())
y = [10, 50, 100, 500, 1000, 5000]
maxx = sum(map(operator.mul, x, y))/money
x[x.index(next(xx for xx in x if xx > 0))] -= 1
minn = sum(map(operator.mul, x, y))/money + 1
print maxx-minn+1
print ' '.join(map(str, range(minn,maxx+1)))
