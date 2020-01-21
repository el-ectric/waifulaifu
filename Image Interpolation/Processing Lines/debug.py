from declarations import *

class debug:
    #plot fills
    def plotFills(fills):
        print("Length of fills:   ", len(fills))
        for fill in fills:
            x=[]
            y=[]
            for f in fill:
                x.append(f[0])
                y.append(f[1])
            plt.scatter(x, y, s = 1)
            plt.axis('equal')


    #plot paths
    def plotPaths(paths):
        fig, ax = plt.subplots(figsize=(5,5))
        print("Length of paths: ", len(paths))
        for path in paths:
            x=[]
            y=[]
            for p in path:
                x.append(p[0])
                y.append(p[1])
            ax.plot(x, y, linewidth=1)
        # Used to return the plot as an image rray
        fig.canvas.draw()       # draw the canvas, cache the renderer
        image = np.frombuffer(fig.canvas.tostring_rgb(), dtype='uint8')
        image  = image.reshape(fig.canvas.get_width_height()[::-1] + (3,))

        return image


    #plot intersections
    def plotIntersections(intersections, width, height):
        x=[]
        y=[]
        counter = 0
        for a in range(width):
            for b in range(height):
                if len(intersections[a][b]) != 0:
                    x.append(a)
                    y.append(b)
                    counter = counter + 1
        plt.scatter(x, y, s = 3)
        plt.axis('equal')
        print("Length of Intersections: ", counter)

    def returnBuffer(fig):
        # Used to return the plot as an image rray
        fig.canvas.draw()       # draw the canvas, cache the renderer
        image = np.frombuffer(fig.canvas.tostring_rgb(), dtype='uint8')
        image  = image.reshape(fig.canvas.get_width_height()[::-1] + (3,))

        return image

    def createGIF(plotData):
        kwargs_write = {'fps':1.0, 'quantizer':'nq'}
        imageio.mimsave('./Animation.gif', plotData, fps=5)
    


    