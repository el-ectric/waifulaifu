########################################################################
# OPTIMAL FEMALE FACE SEARCH PROGRAM
########################################################################
# Female anime-style face has been parameterized. With human input, this
# program generates the global optimum face.
#
# Parameters
# For each of (eye, mouth, nose, eyebrow, face outline):
# 1. Order of bezier curve
# 2. x and y position of bezier curve.
# 
########################################################################
# [DEFUNCT] Well-defined approach; Too many parameters. I'm lazy. The
# previous (new) approach is more general, less parameters, but will
# require more "computation" as a result.
#
# The face parameters are labeled in an image. They are listed here with
# their ranges of possible values:
# 1. Eye y-position.
# 2. Eye x-position.
# 3. Mouth y-position.
# 4. Eyebrow mid-thickness.
# 5. Eyebrow first length.
# 6. Eyebrow second length.
# 7. Eyebrow tip x y-position.
# 8. Eyebrow Inner upper corner x position.
# 9. Eyebrow inner height.
# 10. Mouth peak x-position.
# 11. Mouth peak vertical distance from center.
# 12. Mouth bottom vertical distance from center.
# 13. Mouth top color (R). 
# 14. Mouth corner vertical distance from center.
# 15. Mouth corner horizontal distance from center.
# 16. Mouth bottom corner x position.
# 17. Mouth top color (G).
# 18. Mouth top color (B).
# 19. Mouth bottom color (R).
# 20. Mouth bottom color (G).
# 21. Mouth bottom color (B).
# 22. Mouth bottom corner y position.
# 23. Face bottom corner x position. (bezier curve point P3 and P5)
# 24. Face bottom corner y position. (bezier curve point P3 and P5)
# 25. Face bottom y position. (bezier curve point P4)
# 26. Face side x position. (bezier curve point P2 and P6)
# 27. Face Bezier order (7k where k > 0)
#
########################################################################

import numpy as np
import math
import matplotlib.pyplot as plt

def binomCoeff(n, k):
    return math.factorial(n)/(math.factorial(k)*math.factorial(n-k))


def calcBezier(controlPoints):
    points = 5
    bezierCurve = np.zeros(points,2)
    bezierOrder = len(controlPoints)-1

    for t in range(0,points):
        sumX = 0
        sumY = 0

        for k in range(0,bezierOrder):
           binCof = binomCoeff(bezierOrder,k)
           sumX = sumX + (binCof*((1-t)**(bezierOrder-k))*(t**k)*\
                  controlPoints[k][0])
           sumY = sumY + (binCof*((1-t)**(bezierOrder-k))*(t**k)*\
                  controlPoints[k][1])

        bezierCurve[t,0] = sumX
        bezierCurve[t,1] = sumY

    return bezierCurve

def calcBezier(controlPoints):
    points = 100
    bezierCurve = np.zeros((points,2))
    bezierOrder = len(controlPoints)-1

    print("length controlpoints = ", bezierOrder)

    print("controlPoints = ")
    print(controlPoints)
    for n in range(0,points):
        sumX = 0
        sumY = 0
        
        t = n/(points-1)

        for k in range(0,bezierOrder+1):
           binCof = binomCoeff(bezierOrder,k)
           sumX = sumX + (binCof*((1-t)**(bezierOrder-k))*(t**k)*\
                  controlPoints[k][0])
           sumY = sumY + (binCof*((1-t)**(bezierOrder-k))*(t**k)*\
                  controlPoints[k][1])
           print("controlPoints[k][1]");
           print(controlPoints[k][1])

        bezierCurve[n,0] = sumX
        bezierCurve[n,1] = sumY

    return bezierCurve

def main():
    #curve = calcBezier([[0,0],[0,1],[1,1]])
    #curve = np.array(curve)
    #print(curve)
    #x = curve[:,0]
    #y = curve[:,1] 
    #plt.plot(x,y)
    #plt.show()

    # Generate initial control points
    eyeOrder = 5;
    eyebrowOrder = 5;
    mouthOrder = 5;
    faceOrder = 5;
    noseOrder = 5;
    
    # Bezier curve control points. Matrices are 2 x order.
    eye = np.zeros((eyeOrder,2))
    eyeBrow = np.zeros((eyebrowOrder,2))
    mouth = np.zeros((mouthOrder,2))
    face = np.zeros((faceOrder,2))
    nose = np.zeros((noseOrder,2))
   
    while True:
        # PLOT CURRENT STATE
        # plot eye
        curve = calcBezier(eye)
        x = curve[:,0]
        y = curve[:,1]
        plt.plot(x,y,'b-')
        # plot mouth
        curve = calcBezier(mouth)
        x = curve[:,0]
        y = curve[:,1]
        plt.plot(x,y,'b-')

        # plot face
        curve = calcBezier(face)
        x = curve[:,0]
        y = curve[:,1]
        plt.plot(x,y,'b-')

        # plot nose
        curve = calcBezier(nose)
        x = curve[:,0]
        y = curve[:,1]
        plt.plot(x,y,'b-')

        # plot eyebrow
        curve = calcBezier(eyebrow)
        x = curve[:,0]
        y = curve[:,1]
        plt.plot(x,y,'b-')
        plt.show()

        # FIND RANDOM DIRECTION 
        # Determine number of dimensions
        numDimension = 

        # generate random vector of gaussian random variables

        # check that the non-order x variables are greater than 0
        # check that all order variables are greater than 0

        # if order increases, then duplicate one control point selected
        # at random

        # if order decreases, then delete one control point selected at
        # random

        # PLOT NEXT STATE 
        quit()
 
main()
