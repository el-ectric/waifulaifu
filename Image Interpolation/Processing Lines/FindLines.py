from declarations           import *
from ProcessLines_helpers   import *

# Finds the horizontal center of the path
def center_horizontal(black_mask, black_pix_coords, current_location, MAX_LINE_WIDTH, width):
    min = current_location
    max = current_location
    # Finds the minimum value
    while True:
        if min[0] > 0:
            if black_mask[min[0] - 1][min[1]] == 1:
                min = [min[0] - 1, min[1]]
            else:
                break
        else:
            break
    # Finds the maximum value
    while True:
        if max[0] < width:
            if black_mask[max[0] + 1][max[1]] == 1:
                max = [max[0] + 1, max[1]]
            else:
                break
        else:
            break
    # If the line is thin enough to be considered a path
    if (max[0]-min[0]) < MAX_LINE_WIDTH:
        for n in range(min[0], max[0]+1):
            black_mask[n][current_location[1]] = 0
            if (n, current_location[1]) in black_pix_coords:
                black_pix_coords.remove((n, current_location[1]))
        return [(int)((min[0]+max[0])/2), current_location[1]]
    # If the line is not thin enough to be considered a path
    else:
        for n in range(min[0], max[0]+1):
            black_mask[n][current_location[1]] = 2
            if (n, current_location[1]) in black_pix_coords:
                black_pix_coords.remove((n, current_location[1]))
        return -1

# Finds the vertical center of the path
def center_vertical(black_mask, black_pix_coords, current_location, MAX_LINE_WIDTH, height):
    min = current_location
    max = current_location
    # Finds the minimum value
    while True:
        if min[1] > 0:
            if black_mask[min[0]][min[1] - 1] == 2:
                min = [min[0], min[1] - 1]
            else:
                break
        else:
            break
    # Finds the maximum value
    while True:
        if max[1] < height:
            if black_mask[max[0]][max[1] + 1] == 2:
                max = [max[0], max[1] + 1]
            else:
                break
        else:
            break
    # If the line is thin enough to be considered a path
    if (max[1]-min[1]) < MAX_LINE_WIDTH:
        for n in range(min[1], max[1]+1):
            black_mask[current_location[0]][n] = 0
            if (current_location[0], n) in black_pix_coords:
                black_pix_coords.remove((current_location[0], n))
        return [current_location[0], (int)((min[1]+max[1])/2)]
    # If the line is not thin enough to be considered a path
    else:
        for n in range(min[0], max[0]+1):
            black_mask[current_location[0]][n] = 3
            if (current_location[0], n) in black_pix_coords:
                black_pix_coords.remove((current_location[0], n))
        return -1

def getBestCombine(path, compare, linesearch):
    if path == compare:
        return 0
    head2tail = dist(compare[0], path[-1])
    tail2tail = dist(compare[-1], path[-1])
    head2head = dist(compare[0], path[0])
    best = min(head2tail, tail2tail, head2head)
    if best > linesearch:
        return 0
    if best == head2tail:
        return 1
    elif best == tail2tail:
        return 2
    else:
        return 3

#combine paths if they are close
def CombineLines(paths, iterations):
    for n in range(iterations):
        # Prioritizes closer lines first
        mergeAngle = n ** 3 * (MAX_MERGE_ANGLE / iterations ** 3)
        mergeDist  = n * (COMBINE_LINE_THRESHOLD / iterations)
        lineSearch = n * (COMBINE_LINE_SEARCH / iterations)
        for path in (path for path in paths if len(path) > ANGLE_SEARCH_DEPTH ):
            for compare in paths:
                depth = LINK_LINES_DEPTH
                #handler for when the depth is shorter than the declared value
                minimum_depth = min(len(path), len(compare))
                if minimum_depth < depth:
                    depth = minimum_depth
                best_option = getBestCombine(path, compare,lineSearch)
                #checks the head and tail
                if best_option == 1:
                    result = MergeLine(path, compare, paths, depth, mergeAngle, mergeDist)
                    if result == 1:
                        break
                #checks the tails
                elif best_option == 2:
                    compare.reverse()
                    result = MergeLine(path, compare, paths, depth, mergeAngle, mergeDist)
                    if result == 1:
                        break
                #checks the heads
                elif best_option == 3:
                    path.reverse()
                    result = MergeLine(path, compare, paths, depth, mergeAngle, mergeDist)
                    if result == 1:
                        break

# Merges lines that are close
def MergeLine(path, compare, paths, depth, mergeAngle, mergeDist):
    #finds the shortest link between the paths to smooth out jagged lines
    #format of shortest_link: [path index, compare index, shortest length]
    shortest_link = [0, 0, float("inf")]
    path_angle = angle(path[-(ANGLE_SEARCH_DEPTH  + 1)], path[-1])
    if len(compare) < ANGLE_SEARCH_DEPTH:
        compare_angle = angle(path[-1], center_of_mass(compare))
    else:
        compare_angle = angle(compare[0], compare[ANGLE_SEARCH_DEPTH - 1])
    angle_diff = abs(path_angle - compare_angle)
    if mergeAngle == 0:
        range_bonus = 1
    else:
        range_bonus = 1 + RANGE_MULTIPLIER * (mergeAngle - angle_diff) / mergeAngle
    if  angle_diff < mergeAngle:
        for x in range(depth):
            for y in range(depth):
                length = dist(path[-(x+1)], compare[y])
                if length < shortest_link[2] and length < mergeDist * range_bonus:
                    shortest_link = [x, y, length]
        #connects the shortest paths and adds the clipped paths
        if shortest_link[2] != float("inf"):
            new_path = path[: -(shortest_link[0] + 1)] + compare[shortest_link[1]:]
            clipped_path = path[len(path) - shortest_link[0]:] 
            clipped_compare = compare[:shortest_link[1]]
            if len(clipped_path) > 0:
                paths.append(clipped_path)
            if len(clipped_compare) > 0:
                paths.append(clipped_compare)
            paths.append(new_path)
            paths.remove(compare)
            paths.remove(path)
            return 1
        else:
            return 0
    else:
        return 0
