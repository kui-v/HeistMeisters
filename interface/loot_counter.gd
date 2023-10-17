extends NinePatchRect

const LOOT_SPRITE : String = "res://assets/GFX/Loot/suitcase.png"

func _ready():
	hide()


func collect_loot():
	show()
	$MarginContainer/VBoxContainer/LootCounter.add_icon_item(load(LOOT_SPRITE), false)
