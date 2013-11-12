
def difference(l):
    ans = float('inf')
    for i, x in enumerate(l):
        for j, y in enumerate(l):
            if i == j:
                break
            diff = abs(x-y)
            if diff < ans:
                ans = diff
    return ans

l = map(int, raw_input().split())

ans = 0
while True:
    diff = difference(l)
    l.append(diff)
    ans += 1
    if diff == 0:
        break

print ans

