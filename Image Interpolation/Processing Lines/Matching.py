from declarations   import *
from debug          import *
from Fills          import *
from ProcessLines   import *
from Interpolation  import *
from Intersection   import *

def closeness(path1, path2):
    """Measures how similar the path is to another. Lower is better"""
    total_distance1 = total_distance(path1)
    total_distance2 = total_distance(path2)
    return                                                                                      \
        + 1 * abs(total_distance1 - total_distance2) / (total_distance1 + total_distance2) ** 2 \
        + 1 * abs(len(path1) - len(path2)) / (len(path1) + len(path2))                          \
        + 1 * abs(curvature(path1) - curvature(path2))                                          \
        + 1 * abs(dist(center_of_mass(path1), center1) - dist(center_of_mass(path2), center2))  \
        + 1 * dist(center_of_mass(path1), center_of_mass(path2))      



def getIntersections(points_map):
    width = len(points_map)
    height = len(points_map[0])
    intersection_array = []
    for x in range(width):
        for y in range(height):
            intersectionLength = len(points_map[x][y])
            while intersectionLength - 1 >= len(intersection_array):
                intersection_array.append([])
            if intersectionLength != 0:
                intersection_array[intersectionLength - 1].append([])
                for n in range(intersectionLength):
                    intersection_array[intersectionLength - 1][-1].append(points_map[x][y][n]) 
    return intersection_array


mask_info1 = create_mask(image1)
mask_info2 = create_mask(image2)

fills1 = findFills(mask_info1[0], mask_info1[1], mask_info1[2])
fills2 = findFills(mask_info2[0], mask_info2[1], mask_info2[2])

paths1 = find_paths(mask_info1[0], mask_info1[1], mask_info1[2])
paths2 = find_paths(mask_info2[0], mask_info2[1], mask_info2[2])

points1_map = FindIntersection(paths1, mask_info1[0], mask_info1[1])
points2_map = FindIntersection(paths2, mask_info2[0], mask_info2[1])


# Plot for debug
debug.plotPaths(paths1)
debug.plotFills(fills1)
debug.plotIntersections(points1_map, mask_info1[0], mask_info1[1])
plt.show()

# Plot for debug
debug.plotPaths(paths2)
debug.plotFills(fills2)
debug.plotIntersections(points2_map, mask_info2[0], mask_info2[1])
plt.show()


center1 = center_of_mass_paths(paths1)
center2 = center_of_mass_paths(paths2)

intersection_array1 = getIntersections(points1_map)
intersection_array2 = getIntersections(points2_map)

maxIntersectionLength = max(len(intersection_array1), len(intersection_array2))
# print(intersection_array1)
# print(intersection_array2)

charts = []

for n in range(maxIntersectionLength):
    closeness_chart = np.empty((len(intersection_array1[n]), len(intersection_array2[n])))
    for p1 in range(len(intersection_array1[n])):
        for p2 in range(len(intersection_array2[n])):
            closeness_chart[p1, p2] = 0
            for m in range(n + 1):
                closeness_chart[p1, p2] += closeness(paths1[intersection_array1[n][p1][m]], paths2[intersection_array2[n][p2][m]])
    #print (closeness_chart)
    charts.append(closeness_chart)

mapping = []
used_paths_mask = np.ones((2, max(len(paths1), len(paths2))))
for n in range(maxIntersectionLength):
    n = maxIntersectionLength - n - 1
    while charts[n].shape[0] and charts[n].shape[1]:
        result = np.where(charts[n] == np.amin(charts[n]))
        listOfCoordinates = list(zip(result[0], result[1]))
        coord = listOfCoordinates[0]
        #print(coord)
        for m in range(n + 1):
            index1 = intersection_array1[n][coord[0]][m]
            index2 = intersection_array2[n][coord[1]][m]
            if used_paths_mask[0][index1] == 1 and used_paths_mask[1][index2] == 1:
                mapping.append([paths1[index1], paths2[index2]])
                used_paths_mask[0][index1] = 0
                used_paths_mask[1][index2] = 0
        charts[n] = np.delete(charts[n], coord[0], 0)
        charts[n] = np.delete(charts[n], coord[1], 1)

debug.createGIF([debug.plotPaths(interpolate_mapping(mapping, i/10)) for i in range(11)])
