import itertools

def dotproduct(x, y):
	return sum(itertools.imap(operator.mul, x, y))

# The function WeylLength(ct, m) computes the length of representations,
# using Table 1 (p. 27) of Ben Moonen's notes on Mumford Tate groups
# { http://www.math.ru.nl/~bmoonen/DOCS/CEBnotesMT.pdf }

def WeylLength(ct, m):
	l = ct[1]

	if ct[0] == 'A':
		return sum(m)
	elif ct[0] == 'B':
		return m[l-1] + 2*sum(m[:l-1])
	elif ct[0] == 'C':
		S1 = 2*sum(m)
		S2 = dotproduct(m, range(1,l+1))
		return min(S1, S2)
	elif ct[0] == 'D':
		S1 = m[l-2] + m[l-1] + 2*sum(m[:l-2])
		S2 = (l-1) * (m[l-2] + m[l-1]) / 2 + dotproduct(m[:l-2], range(1,l-1))
		S3 = (l*m[l-2] + (l-2)*m[l-1]) / 2 + dotproduct(m[:l-2], range(1,l-1))
		S4 = ((l-2)*m[l-2] + l*m[l-1]) / 2 + dotproduct(m[:l-2], range(1,l-1))

		if l % 2 == 1:
			return min(S1, S2)
		else:
			return min(S1, S3, S4)
	elif ct == ['E', 6]:
		return dotproduct(m, [2,2,3,4,3,2])
	elif ct == ['E', 7]:
		S1 = dotproduct(m, [2,3,4,6,5,4,3])
		S2 = dotproduct(m, [4,4,6,8,6,4,2])
		return min(S1, S2)
	elif ct == ['E', 8]:
		return dotproduct(m, [4,6,8,12,10,8,6,4])
	elif ct == ['F', 4]:
		return dotproduct(m, [4,6,4,2])
	elif ct == ['G', 2]:
		return dotproduct(m, [2,4])

def CandidateGroups(dim, level):
	cts = [ ['A',1], ['A',2], ['A',3], ['B',2], ['B',3], ['C',3] ] + [ ['A',l] for l in range(4,20) ] + [ ['B',l] for l in range(4,20) ] + [ ['C',l] for l in range(4,20) ] + [ ['D',l] for l in range(4,5) ] + [ ['E',6], ['E',7], ['E',8], ['F',4], ['G',2] ]
	for ct in cts:
		l = ct[1]
		ms = itertools.product(range(1,3), repeat = l)
		for m in ms:
			if WeylDim(ct, m) == dim and WeylLength(ct, m) < level:
				print (ct, m)
