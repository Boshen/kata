import fractions
N, M = map(int, raw_input().split())
N -= 1
M -= 1
a = fractions.gcd(N,M)
if a == 1:
    print N+M-1
else:
    print N+M-a
