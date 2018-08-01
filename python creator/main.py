import json
import random

def randomTF():
	return random.random() > 0.5

def get_random_tile(tiles, tile_weights):
    return random.choices(tiles, weights=tile_weights)[0]

def generate_room():
	available_tiles = ['empty_tile', 'rock', 'transfer_tile', 'void_tile']
	tile_weights = [0.99, 0.01, 0, 0]
	width = 20
	height = 15
	diversity_score = 0
	room = {}
	room['grid'] = {}
	room['dimensions'] = {'width':width, 'height':height}
	room['starting_positions'] = {"x":1, "y":1}
	room['connections'] = {
		'left': False,
		'right': False,
		'up': False,
		'down': False
	}
	generate_coords = (random.randint(1, width-1), random.randint(1, height-1))

	room['connections']['left'] = randomTF()
	room['connections']['right'] = randomTF()
	room['connections']['up'] = randomTF()
	room['connections']['down'] = randomTF()

	# initiate room with empty tiles
	for i in range(width):
		row = {}
		for j in range(height):
			tile = {}
			if i == 0 or i == width - 1 or j == 0 or j == height - 1:
				tile['name'] = 'void_tile'

			else:
				tile['name'] = get_random_tile(available_tiles, tile_weights)
				diversity_score = diversity_score + 5 if tile['name'] == 'rock' else diversity_score
			row[str(j)] = tile
		room['grid'][str(i)] = row


	if generate_coords:
		extendRight = randomTF()
		extendUp = randomTF()
		generate_x_start = generate_coords[0] if extendRight else 0
		generate_x_stop = width-1 if extendRight else generate_coords[0]
		generate_y_start = generate_coords[1] if extendUp else 0
		generate_y_stop = height-1 if extendUp else generate_coords[1]

		for i in range(generate_x_start, generate_x_stop):
			for j in range(generate_y_start, generate_y_stop):
				if room['grid'][str(i)][str(j)]['name'] == 'empty_tile':
					room['grid'][str(i)][str(j)]['name'] = 'void_tile'
					diversity_score += 1
	#room['diversity_score'] = diversity_score

	with open('rooms/python_created_room_d{}.json'.format(diversity_score), 'w') as f:
	    json.dump(room, f)


if __name__ == "__main__":
	room_count = 1000
	for _ in range(room_count):
		room_count = generate_room()
	print(room_count)
	print("{} rooms created".format(room_count))