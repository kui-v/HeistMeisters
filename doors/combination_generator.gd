extends Node

func generate_combinations(length : int):
	var combination : Array[int]
	for i in range(length):
		combination.append(randi() % 10)
	return combination
