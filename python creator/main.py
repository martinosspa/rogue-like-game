import json
import random
from pprint import pprint
import numpy as np
available_tiles = ['empty_tile', 'rock', 'door', 'wall_tile']
tile_weights = [0.9, 0.01, 0, 0]
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
		self.middle_coords = (int(self.width/2 if self.width % 2 == 0 else (self.width-1)/2), int(self.height/2 if self.height % 2 == 0 else (self.height-1)/2))
		self.odd_in_x = not self.width % 2 == 0
		self.odd_in_y = not self.height % 2 == 0

	def get_adjusted_tiles(self, coords):
		self.tiles = []
		if type(coords) == tuple:
			print('coords: {}'.format(coords))
			for i in range(self.width):
				for j in range(self.height):
					if self.room_dictionary['grid'][str(i)][str(j)]['name'] == 'empty_tile':
						if (i == coords[0] - 1 or
						   i == coords[0] + 1 or
						   j == coords[1] - 1 or
						   j == coords[1] + 1):
							#print((i,j))
							self.tiles.append((i, j))

			#self.tiles.remove(coords)

		return self.tiles

	def initiate_empty(self):
		for i in range(self.width):
			self.row = {}
			for j in range(self.height):
				self.tile = {}
				if i == 0 or i == self.width - 1 or j == 0 or j == self.height - 1:
					self.tile['name'] = 'wall_tile'
				else:
					self.tile['name'] = 'empty_tile'
					#self.diversity_score = self.diversity_score + 5 if tile['name'] == 'rock' else self.diversity_score

				self.row[str(j)] = self.tile
			self.room_dictionary['grid'][str(i)] = self.row
	def generate_random(self):
		for i in range(1, self.width-1):
			for j in range(1, self.height-1):
				self.tile = get_random_tile(available_tiles, [15, 5, 0, 8])
				if self.tile == 'rock':
					self.diversity_score += 1
				elif self.tile == 'wall_tile':
					self.diversity_score += 2

				self.room_dictionary['grid'][str(i)][str(j)]['name'] = self.tile


	def generate_symmetry(self):
		self.side_width = self.middle_coords[0] - 1
		self.side_height = self.middle_coords[1] - 1
		
		#generate normal side
		self.side = []
		for i in range(self.side_width):
			self.row = []
			for j in range(self.side_height):
				self.row.append(get_random_tile(available_tiles, [100, 2, 0, 3]))
			self.side.append(self.row)
		
		#flip side
		self.a = np.fliplr(self.side)
		self.b = np.flipud(self.side)
		self.c = np.fliplr(self.b)

		for i in range(1, int(self.middle_coords[0])):
			for j in range(1, int(self.middle_coords[1])):
				self.changeX = int(self.odd_in_x)
				self.changeY = int(self.odd_in_y)
				self.room_dictionary['grid'][str(i)][str(j)]['name'] = self.side[i-1][j-1] #up left
				self.room_dictionary['grid'][str(i + self.side_width + self.changeX)][str(j)]['name'] = self.b[i-1][j-1] #up right
				self.room_dictionary['grid'][str(i)][str(j + self.side_height + self.changeY)]['name'] = self.a[i-1][j-1] #down left
				self.room_dictionary['grid'][str(i + self.side_width + self.changeX)][str(j + self.side_height + self.changeY)]['name'] = self.c[i-1][j-1] #down right

	def solvable(self):
		#for connection in self.room_dictionary['connections']:
		self.starting_pos = (self.middle_coords[0], 1)
		self.walkable_tiles = []
		self.open_set = [self.starting_pos]
		self.closed_set = []
		self.best_dist = 0
		self.target_location = (self.middle_coords[0], self.height-2)
		self.current_path = []
		#print(self.starting_pos, self.target_location)

		while len(self.open_set) > 0:
			self.top_position = len(self.open_set)-1
			self.neighbors = self.get_adjusted_tiles(self.open_set[self.top_position])
			for neighbor in self.neighbors:
				if neighbor not in self.open_set and neighbor not in self.closed_set:
					self.open_set.append(neighbor)
			self.closed_set.append(self.open_set[self.top_position])
			self.open_set.pop(self.top_position)
			
			if self.target_location in self.open_set or self.target_location in self.neighbors:
				return True
		return False

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
	rooms = []
	total_diversity = 0
	room_count = 3
	print('Generating...')
	for i in range(room_count):
		r = Room(20, 15)
		r.initiate_empty()
		#r.generate_from_random_tile()
		#r.generate_symmetry()
		r.generate_random()
		if r.solvable() and not r.room_dictionary in rooms:
			total_diversity += r.diversity_score
			rooms.append(r.room_dictionary)
			r.save_json('room_d{}.json'.format(r.diversity_score))

	print('{} rooms solvable from {}'.format(len(rooms), room_count))
	average_diversity = total_diversity/len(rooms)
	print('average_diversity: {}'.format(average_diversity))