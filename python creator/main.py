import json
import random
available_tiles = ['empty_tile', 'rock', 'door', 'wall_tile']
tile_weights = [0.99, 0.01, 0, 0]
room_count = 100

def randomTF():
	return random.random() > 0.5

def get_random_tile(tiles, tile_weights):
    return random.choices(tiles, weights=tile_weights)[0]

class Room:
	def __init__(self, width, height):
		self.width = width
		self.height = height
		self.diversity_score = 0
		self.room_dictionary = {}
		self.room_dictionary['grid'] = {}
		self.room_dictionary['dimensions'] = {'width':self.width, 'height':self.height}
		self.room_dictionary['starting_positions'] = {"x":1, "y":1}
		self.room_dictionary['connections'] = {
			'left': False,
			'right': False,
			'up': False,
			'down': False
			}
		self.room_dictionary['connections']['left'] = randomTF()
		self.room_dictionary['connections']['right'] = randomTF()
		self.room_dictionary['connections']['up'] = randomTF()
		self.room_dictionary['connections']['down'] = randomTF()

	def initiate_empty(self):
		for i in range(self.width):
			self.row = {}
			for j in range(self.height):
				self.tile = {}
				if i == 0 or i == self.width - 1 or j == 0 or j == self.height - 1:
					self.tile['name'] = 'wall_tile'
				else:
					self.tile['name'] = 'empty_tile'
					#self.tile['name'] = get_random_tile(available_tiles, tile_weights)
					#self.diversity_score = self.diversity_score + 5 if tile['name'] == 'rock' else self.diversity_score

				self.row[str(j)] = self.tile
			self.room_dictionary['grid'][str(i)] = self.row

	def extend_from_tile(self):
		self.generate_coords = (random.randint(1, self.width-1), random.randint(1, self.height-1))
		self.extendRight = randomTF()
		self.extendUp = randomTF()
		self.generate_x_start = self.generate_coords[0] if self.extendRight else 0
		self.generate_x_stop = self.width-1 if self.extendRight else self.generate_coords[0]
		self.generate_y_start = self.generate_coords[1] if self.extendUp else 0
		self.generate_y_stop = self.height-1 if self.extendUp else self.generate_coords[1]

		for i in range(self.generate_x_start, self.generate_x_stop):
			for j in range(self.generate_y_start, self.generate_y_stop):
				if self.room_dictionary['grid'][str(i)][str(j)]['name'] == 'empty_tile':
					self.room_dictionary['grid'][str(i)][str(j)]['name'] = 'wall_tile'
					self.diversity_score += 1
	def save_json(self, file_name):
		with open('rooms/{}'.format(file_name), 'w') as file:
			json.dump(self.room_dictionary, file)

if __name__ == "__main__":
	for i in range(room_count):
		r = Room(20, 15)
		r.initiate_empty()
		#r.extend_from_tile()
		r.save_json('room_{}_d{}.json'.format(i, r.diversity_score))
