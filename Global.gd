extends Node2D


var inventory: Array = []
var prizes: Array = []
var tokens = 3

func _ready():
	reset_prizes()
	randomize()
	prizes.shuffle()

func place_prize():
	var prize = prizes.pop_front()
	return prize

func add(prize_name):
	inventory.append(prize_name)

func check_prize(prize_name):
	return inventory.has(prize_name)
		
func is_win_condition():
	return inventory.size() == 12

func lose_token():
	tokens -= 1
	return tokens
	
func check_tokens():
	return tokens

func reset():
	inventory.clear()
	tokens = 3
	reset_prizes()
	randomize()
	prizes.shuffle()

func reset_prizes():
	prizes =  ["kirby", "mochi", "game-boy", "boombox", "totoro", "sushi", "hyrule-shield", "tamagotchi", "r2d2", "cat", "cassette", "marvin"]
