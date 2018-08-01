import json
import random
from pprint import pprint
import numpy as np
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
		self.middle_coords = (self.width/2 if self.width % 2 == 0 else (self.width-1)/2, self.height/2 if self.height % 2 == 0 else (self.height-1)/2)
		print('middle coords: {}'.format(self.middle_coords))
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

	def generate_symmetry(self):
		self.side_width = int(self.middle_coords[0]) 
		self.side_height = int(self.middle_coords[1])
		#generate normal side
		self.side = []
		for i in range(self.side_width):
			self.row = []
			for j in range(self.side_height):

				self.row.append(get_random_tile(available_tiles, [5, 2, 0, 3]))
				#self.room_dictionary['grid'][str(i)][str(j)]['name'] = get_random_tile(available_tiles, [1/3, 1/3, 0, 1/3])
			self.side.append(self.row)

		#flip side
		self.a = np.fliplr(self.side)
		self.b = np.flipud(self.side)
		self.c = np.fliplr(self.b)

		for i in range(1, self.side_width):
			for j in range(1, self.side_height):
				self.room_dictionary['grid'][str(i)][str(j)]['name'] = self.side[i][j]
				self.room_dictionary['grid'][str(i + self.side_width - 1)][str(j)]['name'] = self.b[i][j]
				self.room_dictionary['grid'][str(i)][str(j + self.side_height - 1)]['name'] = self.a[i][j]
				self.room_dictionary['grid'][str(i + self.side_width -  1)][str(j + self.side_height - 1)]['name'] = self.c[i][j]




	def generate_from_random_tile(self):
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
	for i in range(1):
		r = Room(20, 14)
		r.initiate_empty()
		#r.generate_from_random_tile()
		r.generate_symmetry()
		r.save_json('room_{}_d{}.json'.format(i, r.diversity_score))
