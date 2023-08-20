#!/usr/bin/env python3

import pygame

pygame.init()
# window width ( 2 * 3ds width )
win_x = 800
# window height ( 2 * 3ds height )
win_y = 480
# setup screen object
screen = pygame.display.set_mode((win_x, win_y))
# setup clock so it doesnt murder ur computer
clock = pygame.time.Clock()

# background color
bg_flat = (255, 255, 255)
# foreground color
fg_flat = (4, 0, 1)
# color for qbby stand-in
qb_flat = (5, 5, 5)
# size of tiles
tile_size = int(win_y / 10)
half_tile = int(tile_size / 2)


def collider(tile_array, positions):
	xpos, ypos = positions
	positions = (xpos, ypos)
	return positions	

def game_loop(tile_array, startpos):
	qbby_x, qbby_y = startpos
	qbby_x *= tile_size
	qbby_y *= tile_size
	# walk speed in steps
	qbby_w = 3
	print(qbby_x, qbby_y)
	running = True
	while running:
		screen.fill(bg_flat)
		for y in range(len(tile_array)):
			for x in range(len(tile_array[y])):
				if tile_array[x][y] == 1:
					pygame.draw.rect(screen, fg_flat, (x*tile_size, y*tile_size, tile_size, tile_size))
		for event in pygame.event.get():
			match event.type:
				case pygame.QUIT:
					running = False

		key = pygame.key.get_pressed()
		if key[pygame.K_UP]:
			qbby_y -= qbby_w
		if key[pygame.K_DOWN]:
			qbby_y += qbby_w
		if key[pygame.K_LEFT]:
			qbby_x -= qbby_w
		if key[pygame.K_RIGHT]:
			qbby_x += qbby_w
		

		pygame.draw.rect(screen, fg_flat, (qbby_x - half_tile, qbby_y - half_tile, tile_size, tile_size), 0, 4)
		pygame.draw.rect(screen, bg_flat, (qbby_x - half_tile + 4, qbby_y - half_tile + 4, tile_size - 8, tile_size - 8))
		pygame.draw.rect(screen, (255,0,0), (qbby_x - 1, qbby_y - 1, 2, 2))

		# collision
		qbby_x, qbby_y = collider(tile_array, (qbby_x, qbby_y))
		pygame.display.flip()
		clock.tick(60)

# main
# init test level array
tile_array = [ [0] * 100 for i in range(100) ]
# coords: [x][y], 0 indexed
for i in range(17):
	tile_array[i][8] = 1
	tile_array[i][9] = 1
for i in range(8, 17):
	tile_array[i][7] = 1
game_loop(tile_array, (0, 7))
