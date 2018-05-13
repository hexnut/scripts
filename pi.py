#!/usr/bin/python

# Viete method of computing pi
import math

sq = math.sqrt(2)
pi = sq/2

# Twenty interations produces reasonable accuracy
for i in range(20):
    sq = math.sqrt(2+sq)
    pi = pi*(sq/2)
    print("Pi = " +str(2/pi))
