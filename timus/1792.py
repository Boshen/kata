line = map(int, raw_input().split())

for i in range(8):
    if (line[1]+line[2]+line[3]) % 2 == line[4] and (line[0]+line[2]+line[3]) % 2 == line[5] and (line[0]+line[1]+line[3]) % 2 == line[6]:
        break
    else:
        line[i] = 1 - line[i]
        if i != 0:
            line[i-1] = 1 - line[i-1]

print ' '.join(str(i) for i in line)

