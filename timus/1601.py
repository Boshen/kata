import sys

start_of_sentence = True
while 1:
    s = sys.stdin.read(1)
    if not s:
        break

    if start_of_sentence:
        if s.islower():
            s = s.upper()
        if s.isupper():
            start_of_sentence = False
    else:
        if s.isupper():
            s = s.lower()
    
    if s in ['.', '?', '!']:
        start_of_sentence = True

    sys.stdout.write(s)


