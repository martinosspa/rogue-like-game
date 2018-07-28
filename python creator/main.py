import json
room = {}
room['grid'] = {}
room['dimensions'] = {'width':20,
		'height':15
		}
for i in range(room['dimensions']['width']):
	row = {}
	for j in range(room['dimensions']['height']):
		tile = {}
		#tile = {'id': j}
		tile['name'] = 'empty_tile'

		row[str(j)] = tile
	room['grid'][str(i)] = row






with open('room.json', 'w') as f:
    json.dump(room, f)
#print(room)


