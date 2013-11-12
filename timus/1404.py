import sys
import gc

gc.disable()

string = sys.stdin.readline()

step = [ord(string[0]) - ord('a')]
if step[0]-5 < 0:
    ans = [ ord('z')+step[0]-4-ord('a') ]
else:
    ans  = [step[0]-5]
    
for s in string[1:]:
    for letter in xrange(26):
        if (step[-1] + letter) % 26 == ord(s) - ord('a'):
            ans.append(letter)
            step.append(step[-1]+letter)
            break
    
print ''.join(map(lambda s: chr(s+ord('a')), ans))

