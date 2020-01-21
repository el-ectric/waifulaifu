from declarations           import *
from FindLines              import *
from ProcessLines_helpers   import *


def find_paths(width, height, black_mask):

    #set of all coords of black pixels
    black_pix_coords = set()
    for row in range(width):
        for col in range(height):
            if black_mask[row][col] == 1:
                black_pix_coords.add((row, col))

    # Does a horizontal scan for lines
    paths = []
    while len(black_pix_coords) > 0:
        path = []
        start = get_start(black_pix_coords)
        path.append(center_horizontal(black_mask, black_pix_coords, start, MAX_LINE_WIDTH, width))
        if path[0] != -1:
            while True:
                if (path[-1][1] + 1) < height:
                    if black_mask[path[-1][0]][path[-1][1] + 1] == 1:
                        next_up = center_horizontal(black_mask, black_pix_coords, [path[-1][0], path[-1][1] + 1], MAX_LINE_WIDTH, width)
                        if next_up == -1:
                            break
                        path.append(next_up)
                    else:
                        break
                else:
                    break
            path = path[::-1]
            while True:
                if (path[-1][1] - 1) >= 0:
                    if black_mask[path[-1][0]][path[-1][1] - 1] == 1:
                        next_up = center_horizontal(black_mask, black_pix_coords, [path[-1][0], path[-1][1] - 1], MAX_LINE_WIDTH, width)
                        if next_up == -1:
                            break
                        path.append(next_up)
                    else:
                        break
                else:
                    break
            paths.append(path)

    #set of all coords of black pixels
    black_pix_coords = set()
    for row in range(width):
        black_mask.append([])
        for col in range(height):
            if black_mask[row][col] == 2:
                black_pix_coords.add((row, col))

    # Does a verticle scan for lines
    while len(black_pix_coords) > 0:
        path = []
        start = get_start(black_pix_coords)
        path.append(center_vertical(black_mask, black_pix_coords, start, MAX_LINE_WIDTH, height))
        current_direction = 0
        if path[0] != -1:
            while True:
                if (path[-1][1] + 1) < height and (path[-1][1] - 1) >= 0:
                    if black_mask[path[-1][0] + 1][path[-1][1]] == 2  and (current_direction == 0 or current_direction == 1):
                        next_up = center_vertical(black_mask, black_pix_coords, [path[-1][0] + 1, path[-1][1]], MAX_LINE_WIDTH, height)
                        if next_up == -1:
                            break
                        path.append(next_up)
                        current_directiom = 1
                    elif black_mask[path[-1][0] - 1][path[-1][1]] == 2 and (current_direction == 0 or current_direction == -1):
                        next_up = center_vertical(black_mask, black_pix_coords, [path[-1][0] - 1, path[-1][1]], MAX_LINE_WIDTH, height)
                        if next_up == -1:
                            break
                        path.append(next_up)
                        current_direction = -1
                    else:
                        break
                else:
                    break
            paths.append(path)


    CombineLines(paths, 20)

    # Erases all short paths
    paths = [p for p in paths if len(p) > 4]

    return paths

