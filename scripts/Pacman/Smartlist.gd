extends Node

var set = []
func append(obj):
	for i in range(set.size()):
		if set[i].f > obj.f:
			set.insert(i, obj)
			return
	set.append(obj)

func get_top():
	var obj = set[0]
	set.remove(0)
	return obj
	
func get_size():
	return set.size()

func has(obj):
	var start = 0
	var end = set.size() -1
	
	while(start <= end):
		var m = (start + end)/2
		if set[m] == obj: return true
		if set [m].f < obj.f: start = m + 1
		else: end = m - 1
		
	return false