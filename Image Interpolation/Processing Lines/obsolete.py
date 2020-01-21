from declarations import *
###################################################################################################################
# ProcessLines_helpers.py: Old Path Finding Alorithm
# Issues: Path making was not consistant. Problems with doubled lines
def find_next_in_path(black_mask, available_chunks, width, height, small_black_count, path, currentDirection):
    """Finds next coordinate in path"""

    coords = path[-1]

    #first check the direction the line is currently going
    orig_chunk_coords = (coords[0] // CHUNK_SIZE, coords[1] // CHUNK_SIZE)

    if len(path) == 1:
        #check all 8 directions for best black pixel density
        directions = [(0, 1), (1, 1), (1, 0), (1, -1), (0, -1), (-1, -1), (-1, 0), (-1, 1)]
    else:
        #check the 3 directions in the "foward" direction
        direction = angle(path[-2], path[-1])
        directions = directionToCoords(direction)

    new_chunk_coords = [(dir[0] + orig_chunk_coords[0], dir[1] + orig_chunk_coords[1]) for dir in directions]
    new_chunk_coords = [c for c in new_chunk_coords if c in available_chunks]
    if len(new_chunk_coords) == 0:
        return None
    #determines next chunk to go to
    next_chunk_coords = max(new_chunk_coords, key=lambda small_coords: small_black_count[small_coords[0]][small_coords[1]])
    mark_visited(available_chunks, next_chunk_coords)
    chunk_logic = (next_chunk_coords[0] - orig_chunk_coords[0], next_chunk_coords[1] - orig_chunk_coords[1])
    if abs(chunk_logic[0])+abs(chunk_logic[1]) == 2:
        mark_visited(available_chunks, (next_chunk_coords[0], orig_chunk_coords[1]))
        mark_visited(available_chunks, (orig_chunk_coords[0], next_chunk_coords[1]))
    elif abs(chunk_logic[0]) == 1:
        mark_visited(available_chunks, (next_chunk_coords[0], orig_chunk_coords[1] + 1))
        mark_visited(available_chunks, (next_chunk_coords[0], orig_chunk_coords[1] - 1))
    else:
        mark_visited(available_chunks, (orig_chunk_coords[0] + 1, next_chunk_coords[1]))
        mark_visited(available_chunks, (orig_chunk_coords[0] - 1, next_chunk_coords[1]))

    return closest_to_center(next_chunk_coords, black_mask, width, height)



def directionToCoords(direction):
    direction = round(8 * (direction / (2 * math.pi))) % 8
    options = {
        0: [[1, 0], [2, 0], [1, 1], [1, -1]],
        1: [[1, 1], [2, 2], [1, 0], [0, 1]],
        2: [[0, 1], [0, 2], [1, 1], [-1, 1]],
        3: [[-1, 1], [-2, 2], [0, 1], [-1, 0]],
        4: [[-1, 0], [-2, 0], [-1, -1], [-1, 1]],
        5: [[-1, -1], [-2, -2], [-1, 0], [0, -1]],
        6: [[0, -1], [0, -2], [-1, -1], [1, -1]],
        7: [[1, -1], [2, -2], [0, -1], [1, 0]]
    }
    return options[direction]

    
def get_start_chunk(available_chunks, black_mask, width, height):
    """Gets a starting point for a path"""
    if len(available_chunks) == 0:
        return None
    chunk_coords = available_chunks.pop()
    return closest_to_center(chunk_coords, black_mask, width, height)

# End
###################################################################################################################


###################################################################################################################
# FindLines.py: Sort using x or y based on angle
# Issues: Doesn't really do much

def xKey(key):
    return(key[0])

def yKey(key):
    return(key[1])

def SortPath(path, angle):
    direction = round(4 * (angle / (2 * math.pi))) % 4
    xPath = path.copy()
    yPath = path.copy()
    if direction < 2:
        xPath.sort(key = xKey)
        yPath.sort(key = yKey)
    else:
        xPath.sort(key = xKey, reverse = True)
        yPath.sort(key = yKey, reverse = True)
    if total_distance(xPath) < total_distance(yPath):
        return xPath
    else:
        return yPath

def SortPath(path, angle):
    direction = round(4 * (angle / (2 * math.pi))) % 4
    sign = 0
    if direction > 1:
        sign = 1
    if direction % 2 == 0:
        if sign == 0:
            path.sort(key = xKey)
        else:
            path.sort(key = xKey, reverse = True)
    else:
        if sign == 0:
            path.sort(key = yKey)
        else:
            path.sort(key = yKey, reverse = True)


# End
###################################################################################################################

###################################################################################################################
# FindLines.py: Creating intermediate point for when the lines merge
# Issues: Currently does not really help
def create_intermediate_line(point1, point2):
    num_points = round(dist(point1, point2))
    output = []
    for n in range(num_points):
        x = (int)(point1[0] + ((point1[0]-point2[0])/num_points * n))
        y = (int)(point1[1] + ((point1[1]-point2[1])/num_points * n))
        output.append([x, y])
    return output
# End
###################################################################################################################