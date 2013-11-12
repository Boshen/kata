n= 5
for i in range(n):
    u = 0
    v = 1
    for i in range(1, n):
        t = u+v
        u = v
        v = t
print v*2


