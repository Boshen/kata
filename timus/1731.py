n, m = map(int, raw_input().split())

print ' '.join(map(str,range(1, n+1)))
print ' '.join(map(str,[1+i*n for i in range(1, m+1)]))
