from declarations import *
from ProcessLines_helpers import *

# x_small = x(round((0:fftSize-1)*length(x)/fftSize+1, 0))
# y_small = y(round((0:fftSize-1)*length(y)/fftSize+1, 0))
# xx_small = xx(round((0:fftSize-1)*length(xx)/fftSize+1, 0))
# yy_small = yy(round((0:fftSize-1)*length(yy)/fftSize+1, 0))

def resize_line(line, size):
    """This function resizes lines but only shrinks it well"""
    indicies = []
    output_line = []
    for n in range(size):
        indicies.append((int)(n*len(line)/size))
    for n in indicies:
        output_line.append(line[n])
    return output_line

def combine_lines(line1, line2, weight):
    """This function returns the weighted average of lines with the same length"""
    line1 = np.array(line1)
    line2 = np.array(line2)
    line1 = weight * line1
    line2 = (1-weight) * line2
    try1 = line1 + line2
    try2 = line1 + line2[::-1]

    avg_dist = weight * total_distance(line1) + (1 - weight) * total_distance(line2)
    dist1 = total_distance(try1)
    dist2 = total_distance(try2)
    if abs(avg_dist - dist1) <= abs(avg_dist - dist2):
        return try2
    else:
        return try1

def interpolate_mapping(mapping, weight):
    out_paths = []
    for m in mapping:
        l1 = len(m[0])
        l2 = len(m[1])
        larger = max(l1, l2)
        smaller = min(l1, l2)
        if l1 == larger:
            m[0] = resize_line(m[0], smaller)
        else:
            m[1] = resize_line(m[1], smaller)
        out_paths.append(combine_lines(m[0], m[1], weight))
    return out_paths