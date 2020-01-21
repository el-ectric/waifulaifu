from declarations           import *
from ProcessLines_helpers   import *


def bestIndex(path, compare):
    best_head = float("inf")
    best_tail = float("inf")
    if path[0] != float("inf"):
        for n in range(len(compare)):
            if compare[n] == float("inf"):
                distance = float("inf")
            else:
                distance = dist(path[0], compare[n])
            if distance < best_head:
                best_head = distance
                head_index = n
    if path[-1] != float("inf"):
        for n in range(len(compare)):
            if compare[n] == float("inf"):
                distance = float("inf")
            else:
                distance = dist(path[-1], compare[n])
            if distance < best_tail:
                best_tail = distance
                tail_index = n
    if best_head < INTERSECTION_THRESHOLD or best_tail < INTERSECTION_THRESHOLD:
        if best_head < best_tail:
            return [0, head_index]
        else:
            return [1, tail_index]
    else:
        return float("inf")


# Finds the intersections of the paths
def FindIntersection(paths, width, height):
    points_map = []    
    for row in range(width):
        points_map.append([])
        for col in range(height):
            points_map[-1].append([])

    # utilizes infinity as a stopper to indicate if the path has already created an intersection
    for path in paths:
        for compare in paths:
            if path is not compare:
                index = bestIndex(path, compare)
                if index != float("inf"):
                    if index[0] == 0:
                        path.insert(0, compare[index[1]])
                        path.insert(0, float("inf"))
                    else:
                        path.append(compare[index[1]])
                        path.append(float("inf"))

                    if index[1] == 0:
                        compare.insert(0, float("inf"))
                    elif index[1] == len(compare) - 1:
                        compare.append(float("inf"))
                    else:
                        compare1 = compare[0:index[1] + 1] + [float("inf")]
                        compare2 = [float("inf")] + compare[index[1]:]
                        paths.remove(compare)
                        paths.append(compare1)
                        paths.append(compare2)


    # removes intersection stoppers
    for path in paths:
        while float("inf") in path:
            path.remove(float("inf"))

    for n in range(len(paths)):
        points_map[paths[n][0][0]][paths[n][0][1]].append(n)
        points_map[paths[n][-1][0]][paths[n][-1][1]].append(n)
    return points_map
