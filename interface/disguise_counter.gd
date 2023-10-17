extends ItemList

const DISGUISE_BOX : String = "res://assets/GFX/PNG/Tiles/tile_129.png"

func update_disguises(num_disguises : int):
	clear()
	for digsuises in range(num_disguises):
		add_icon_item(load(DISGUISE_BOX), false)
