from declarations import *
from ProcessLines_helpers import *

def findFills(width, height, black_mask):
    #finds fill candidates with black mask
    available_fill_chunks = []
    directions = [(0, 1), (1, 1), (1, 0), (1, -1), (0, -1), (-1, -1), (-1, 0), (-1, 1)]

    for row in range((int)(height/CHUNK_SIZE)):
        for col in range((int)(width/CHUNK_SIZE)):
            surrounding_sum = 0
            if row != 0 and row < (int)(height/CHUNK_SIZE) - 1 and col !=0 and col < (int)(width/CHUNK_SIZE) - 1:
                for n in directions:
                    surrounding_sum += len(list_black_in_chunk([row, col], black_mask, width, height))
            if surrounding_sum > 0.9*8*CHUNK_SIZE**2:
                available_fill_chunks.append([row, col])

    # Finds the large fills with the fill candidates
    fills = []
    while len(available_fill_chunks) > 0:
        start = get_start(available_fill_chunks)
        fill_chunks = []
        fill_chunks =  find_next_fill(available_fill_chunks, black_mask, fill_chunks, start, width, height)
        fill = []
        if len(fill_chunks) > 30:
            fill_chunk_start = center_of_mass(fill_chunks)
            cum_dist = 0
            for x in fill_chunks:
                cum_dist = dist(fill_chunk_start, x)
            if cum_dist/len(fill_chunks) < 0.5:
                for f in fill_chunks:
                    chunk_blacks = list_black_in_chunk(f, black_mask, width, height)
                    for c in chunk_blacks:
                        fill.append(c)
                fills.append(fill)

    # Removes fills from black mask
    for fill in fills:
        for f in fill:
            black_mask[f[0]][f[1]] = 0
    
    return fills




def find_next_fill(available_fill_chunks, black_mask, fill, coords, width, height):
    fill.append(coords)
    directions = [(0, 1), (1, 1), (1, 0), (1, -1), (0, -1), (-1, -1), (-1, 0), (-1, 1)]
    for direction in directions:
        x = coords[0] + direction[0]
        y = coords[1] + direction[1]
        if x >= 0 and y >= 0 and x <= height and y <= width:
            if [x, y] in available_fill_chunks:
                available_fill_chunks.remove([x, y])
                find_next_fill(available_fill_chunks, black_mask, fill, [x, y], width, height)
            else:
                if len_black_in_chunk_threshold([x, y], black_mask, width, height) != 0 and [x, y] not in fill:
                    fill.append([x, y])
    return fill