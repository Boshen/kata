n = int(raw_input())

w = map(int, raw_input().split())

summ = sum(w)
result = summ

def dp(index, current):
    global result
    global summ
    if index == n:
        if abs(2*current-summ) < result:
            result = abs(2*current-summ)
    else:
        dp(index+1, current)
        dp(index+1, current+w[index])

dp(0, 0)

print result
