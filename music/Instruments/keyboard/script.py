########################################################################
# INSTRUMENT ENSEMBLE SYNTHESIZER 1000
# Purpose: 	1. make cool-ass sounds that sound like a ensemble of
#               instruments (strings, voices, maybe some others) in
#               an insanely precise (customizable) way.  Use a model
#               of the sound that has very detailed parameters. Some
#               starting parameters: 
#                   pitch 
#                   vibrato frequency 
#                   vibrato width
#                   attack
#                   decay
#                   timbre
#                   number of instruments
#                   fourier series
#               2. make it extremely easy for the user to do (1)
#               (via a hella-intuitive GUI). 
#
# Author:	your mom
#
########################################################################
# REQUIREMENTS
# 1. 
########################################################################
#
# STATE MACHINE STATES
# start: 	
#                   Action:
#                       -Set up the GUI.
#               
#                   Next State:
#                       editScore
# editInstrument:        
# editScore:
# genSound:	
# quit:	
#
########################################################################

import time
import os
from tkinter import *
from tkinter import ttk

# declare global variables
pitches = [];
lengths = [];
volumes = [];
bpm = 100;

class Instrument:
    def __init__(self):
        self.numOscillators = 1;

def main():

    state = 'start'
	
    while 1:
       if  state ==  'start':
           state = start()
       elif state == 'editInstrument':
           state = editSound()
       elif state == 'editScore':
           state = editScore()
       elif state == 'genSound':
           state = genSound()
       elif state == 'end':
           end()

def start():
    os.system('cls')
    time.sleep(1);

    window = Tk()
    window.configure(background="black")
    window.protocol("WM_DELETE_WINDOW", exit)
    window.title("Instrument Ensemble Synthesizer 1000")
    window.geometry('500x500')

    # Define style

    # Play intro video

    # Notebook widget
    tab_control = ttk.Notebook(window)
    tab1 = ttk.Frame(tab_control)
    tab_control.add(tab1, text='Score')
    tab_control.pack(expand=1, fill='both') 

    # Set up instrument tab
    lbl = Label(tab1, text="Hello")
    lbl.grid(column=0,row=0)

    tab2 = ttk.Frame(tab_control)
    tab_control.add(tab2, text='Instrument')
    tab_control.pack(expand=1, fill='both') 

    numOscLabel = Label(tab2, text="Number of Oscillators:", font=(\
                        "Arial Bold", "14"))
    numOscLabel.grid(row= 0, column= 0, columnspan = 100, sticky='W')

    rowValue = 0


    attackFourierLbl= Label(tab2, text="Attack Fourier Series", font=("\
                            Arial Bold","24"))
    attackFourierLbl.grid(row=rowValue,column=0,columnspan=10, sticky='W')
    rowValue = rowValue+1

    attackFourierCoeffSliders = []
    attackFourierCoeffEntry = []

    for k in range(0,10):
         attackFourierCoeffSliders.append(Scale(tab2, from_=100, to=0))
         attackFourierCoeffSliders[k].grid(column=k,row=rowValue)
    
    rowValue = rowValue+1

    for k in range(0,10): 
         attackFourierCoeffEntry.append(Entry(tab2,width=3))
         attackFourierCoeffEntry[k].grid(column=k,row=rowValue)
    rowValue = rowValue+1

    attackDecayLbl = Label(tab2, text="Attack Decay", font=("Arial", \
                           "14"))
    attackDecayLbl.grid(row=rowValue,column=0,columnspan=3, sticky='W')
    rowValue = rowValue+1

    susFourierLbl= Label(tab2, text="Sustain Fourier Series", font=("\
                            Arial Bold","24"))
    susFourierLbl.grid(row=rowValue,column=0,columnspan=10, sticky='W')
    rowValue = rowValue + 1

    susFourierCoeffSliders = []
    susFourierCoeffEntry = []

    for k in range(0,10):
         susFourierCoeffSliders.append(Scale(tab2, from_=100, to=0))
         susFourierCoeffSliders[k].grid(column=k,row=rowValue)

    rowValue = rowValue+1

    for k in range(0,10):         
         susFourierCoeffEntry.append(Entry(tab2,width=3))
         susFourierCoeffEntry[k].grid(column=k,row=rowValue)
    
    rowValue = rowValue +1

    sustainDecayLbl = Label(tab2, text="Sustain Decay:", font=("Arial",\
                           "14"))
    sustainDecayLbl.grid(row=rowValue,column=0,columnspan=3, sticky='W')
    rowValue = rowValue + 1

    window.mainloop() 

    return 'editScore'

def end():
    exit()

def editScore():
    print("editScore")
    pass

main()
