def primes(n): 
    if n==2: return [2]
    elif n<2: return []
    s=range(3,n+1,2)
    mroot = n ** 0.5
    half=(n+1)/2-1
    i=0
    m=3
    while m <= mroot:
        if s[i]:
            j=(m*m-3)/2
            s[j]=0
            while j<half:
                s[j]=0
                j+=m
        i=i+1
        m=2*i+3
    return [2]+[x for x in s if x]

ps = []
ans = []
def foo(x, n, i):
    y = x-ps[n-i]
    print x - ps[n-i]
    if y==0:
        ans.append(ps[n-i])
        return
    if y < 2:
        foo( x, n, i+1)
    else:
        ans.append(ps[n-i])
        foo(y, bar(y), 0)


def bar(x):
    for (i,j) in enumerate(ps):
        if j > x:
            return i-1
n = 14983
ps = primes(n)
foo(n, len(ps), 1)
print ps
print ans

