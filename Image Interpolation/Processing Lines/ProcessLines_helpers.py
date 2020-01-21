from declarations import *

class Coordinate:
    def __init__(self, x, y):
        self.x = x
        self.y = y
    
    def dist(self, coords2):
        """Returns Euclidean distance between two points"""
        return math.sqrt((self.x - coords2.x) ** 2 + (self.y - coords2.y) ** 2)

    def angle(self, coords2):
        if coords2.x - self.x == 0:
            if coords2.y -self.y > 0:
                return math.pi / 2
            else:
                return 3 * math.pi / 2
        return math.atan((coords2.y - self.y) / (coords2.x - self.x))

    def __str__(self):
        return "[" + str(self.x) + ", " + str(self.y) + "]"

class Path:
    def __init__(self):
        self.path = []

    def add(self, coord):
        self.path.append(coord)

    def curvature(self):
        cur = 0
        for i in range(1, len(self.path) - 1):
            cur += abs(self.path[i - 1].angle(self.path[i]))
        return cur

    def center_of_mass(self):
        x_sum = 0
        y_sum = 0
        for coord in self.path:
            x_sum += coord.x
            y_sum += coord.y
        return Coordinate(x_sum // len(self.path), y_sum // len(self.path))

    def size(self):
        return len(self.path)

    def closeness(self, path2):
        """Measures how similar the path is to another. Lower is better"""
        return 4 * abs(self.size() - path2.size()) + 2 * abs(self.curvature() - path2.curvature()) + self.center_of_mass().dist(path2.center_of_mass())

class Paths:
    def __init__(self):
        self.paths = []

    def add(self, path):
        self.paths.append(path)
    
    def center_of_mass(self):
        pass

    def mapping(self, paths2):
        closeness_chart = np.empty([self.paths.size(), paths2.size()])
        for p1 in range(self.paths.size()):
            for p2 in range(paths2.size()):
                closeness_chart[p1, p2] = self.paths[p1].closeness(paths2.paths[p2])
        mapping = dict()
        while closeness_chart.shape[0] and closeness_chart.shape[1]:
            result = np.where(closeness_chart == np.amin(closeness_chart))
            listOfCoordinates = list(zip(result[0], result[1]))
            coord = listOfCoordinates[0]
            mapping[self.paths[coord[0]]] = paths2.paths[coord[1]]
            closeness_chart = np.delete(closeness_chart, coord[0], 0)
            closeness_chart = np.delete(closeness_chart, coord[1], 1)
            


def create_mask(image):
    # Get All pixels in the image
    width, height = image.size
    pix_val = list(image.getdata())
    pix_sum = list(np.ones(width * height))
    pix_sum = list(np.sum(pix_val, axis=1))

    # 2D array of image, 1 if pixel is black, 0 otherwise
    black_mask = []

    for row in range(width):
        black_mask.append([])
        for col in range(height):
            if pix_sum[col * width + row] < BLACK_THRESHOLD: #check if pixel is black
                black_mask[-1].append(1)
            else:
                black_mask[-1].append(0)

    # Corrects the orientation of black mask
    for line in range(len(black_mask)):
        black_mask[line] = black_mask[line][::-1]

    return [width, height, black_mask]


#########################################################################################################################
# General Math Functions
#########################################################################################################################

def dist(coords1, coords2):
    """Returns Euclidean distance between two points"""
    return math.sqrt((coords1[0] - coords2[0]) ** 2 + (coords1[1] - coords2[1]) ** 2)

def angle(coords1, coords2):
    """Returns the angle from coords1 to coords2"""
    if coords2[0]-coords1[0] == 0:
        if coords2[1]-coords1[1] > 0:
            # return 0
            return math.pi / 2
        else:
            # return math.pi
            return 3 * math.pi / 2
    return math.atan((coords2[1] - coords1[1]) / (coords2[0] - coords1[0]))

#########################################################################################################################
# Set Operations
#########################################################################################################################
                

def mark_visited(inputSet, elements):
    """Removes set elements from set"""
    if elements in inputSet:
        inputSet.remove(elements)



def get_start(available_set):
    """Gets a starting point"""
    if len(available_set) == 0:
        return None
    else:
        return available_set.pop()




def list_black_in_chunk(chunk_coords, black_mask, width, height):
    """Returns list of black pixels in a given chunk"""
    black = []
    for row in range(chunk_coords[0] * CHUNK_SIZE, min((chunk_coords[0] + 1) * CHUNK_SIZE, width)):
        for col in range(chunk_coords[1] * CHUNK_SIZE, min((chunk_coords[1] + 1) * CHUNK_SIZE, height)):
            if black_mask[row][col] == 1:
                black.append((row, col))
    return black

    
def len_black_in_chunk_threshold(small_coords, black_mask, width, height):
    black_count = len(list_black_in_chunk(small_coords, black_mask, width, height))
    if black_count/(CHUNK_SIZE**2) < TOLERANCE:
        return 0
    return black_count


def closest_to_center(chunk_coords, black_mask, width, height):
    """Get closest black pixel to center of a given chunk within that chunk"""
    center = (chunk_coords[0] + CHUNK_SIZE//2, chunk_coords[1] + CHUNK_SIZE//2)
    coords = min(list_black_in_chunk(chunk_coords, black_mask, width, height), key=lambda c: dist(center, c))
    return coords

def center_of_mass_chunk(chunk_coords, black_mask, width, height):
    """gets center of mass for black squares in chunk"""
    sum_coords = (0,0)
    black_list = list_black_in_chunk(chunk_coords, black_mask, width, height)
    for coords in black_list:
        sum_coords = (sum_coords[0] + coords[0], sum_coords[1] + coords[1])
    return (round(sum_coords[0]/len(black_list)), round(sum_coords[1]/len(black_list)))

def center_of_mass_path(path):
    """gets center of mass for path"""
    sum_coords = (0,0)
    for coords in path:
        sum_coords = (sum_coords[0] + coords[0], sum_coords[1] + coords[1])
    return (round(sum_coords[0]/len(path)), round(sum_coords[1]/len(path)))
    


def total_distance(line):
    cum_dist = 0
    for i in range(1, len(line)):
        cum_dist += dist(line[i - 1], line[i])
    return cum_dist

def total_angle(line):
    cum_angle = 0
    for i in range(1, len(line)):
        cum_angle += angle(line[i - 1], line[i])
    return cum_angle

def curvature(path):
    cur = 0
    for i in range(1, len(path) - 1):
        cur += abs(angle(path[i - 1], path[i]))
    return cur/len(path)

def center_of_mass(path):
    x_sum = 0
    y_sum = 0
    for coord in path:
        x_sum += coord[0]
        y_sum += coord[1]
    return (x_sum // len(path), y_sum // len(path))

def center_of_mass_paths(paths):
    x_sum = 0
    y_sum = 0
    count = 0
    for path in paths:
        for coord in path:
            x_sum += coord[0]
            y_sum += coord[1]
            count += 1
    return (x_sum // count, y_sum // count)



def mask2list(mask, width, height):
    output = []
    for a in range(width):
        for b in range(height):
            if len(mask[a][b]) != 0:
                outptut.append[a, b]
    return output