thickness, cover, left, right = map(int, raw_input().split())

print abs((right-left)*(cover*2+thickness) - thickness)
