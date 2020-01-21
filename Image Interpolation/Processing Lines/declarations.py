import imageio
import math
import matplotlib.pyplot    as plt
import numpy                as np
import PIL
import sys,os

from PIL                    import Image
from debug                  import *

# Preprocessing Thresholds
CHUNK_SIZE = 3
BLACK_THRESHOLD = 800
TOLERANCE = 0.4

# Line Merge Thresholds            
COMBINE_LINE_SEARCH = 30        # Maximum distance of the end points for a merge to be considered
COMBINE_LINE_THRESHOLD = 9     # Maximum distance line will still merge
LINK_LINES_DEPTH = 5            # Maximum depth the merge will search for close enough distances
MAX_MERGE_ANGLE = 2 * math.pi     # Maximum difference in angle for merge to be performed
RANGE_MULTIPLIER = 0.1          # Increases the maximum length for merge as a function of how close the angle is
ANGLE_SEARCH_DEPTH = 5

# Sort Lines Thresholds
SORT_DEPTH = 10

# Find Line Threshold
MAX_LINE_WIDTH = 10

# Intersection Threshold
INTERSECTION_THRESHOLD = 10

# Images being compared
image1 = Image.open('historia.png')
image2 = Image.open('HistoriaRotate.png')
