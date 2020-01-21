from tkinter import *


def clicked():
    res = "Welcome to " + txt.get()
    lbl.configure(text=res)

window = Tk()

window.title("tkinter tutorial")
window.geometry('350x200')

lbl = Label(window, text="Hello", font=("Arial Bold",50))

lbl.grid(column=0, row=0)

txt = Entry(window,width=10)

txt.focus()

txt.grid(column=1, row=0)

btn = Button(window, text="Click Me", bg="orange", fg="red",\
             command=clicked)
btn.grid(column=2,row=0)


window.mainloop()


