import json
import random
available_tiles = ['empty_tile', 'rock', 'transfer_tile', 'void_tile']
tile_weights = [0.4, 0.1, 0.1, 0.4]
room = {}
room['grid'] = {}
room['dimensions'] = {'width':20, 'height':15}
room['starting_positions'] = {"x":1, "y":1}
room['connections'] = {
	'left': False,
	'right': False,
	'up': False,
	'down': False
}
def get_random_tile(tiles, tile_weights):
    return random.choices(tiles, weights=tile_weights)[0]

def randomize_room():
	for i in range(room['dimensions']['width']):
		row = {}
		for j in range(room['dimensions']['height']):
			tile = {}
			tile['name'] = get_random_tile(available_tiles, tile_weights)
			row[str(j)] = tile
		room['grid'][str(i)] = row

# initiate room with empty tiles
for i in range(room['dimensions']['width']):
	row = {}
	for j in range(room['dimensions']['height']):
		tile = {}
		#tile = {'id': j}
		tile['name'] = 'empty_tile'
		row[str(j)] = tile
	room['grid'][str(i)] = row

randomize_room()

with open('room.json', 'w') as f:
    json.dump(room, f)
    #print(room)
	# print(room)


