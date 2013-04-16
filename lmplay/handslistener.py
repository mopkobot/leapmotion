# -*- coding: utf-8 -*-
import Leap
import globalvar

class HandsListener(Leap.Listener):
    grasping = False
    def on_init(self, controller):
        print "Hands Listener Initialized"

    def on_connect(self, controller):
        print "Hands Listener Connected"

    def on_disconnect(self, controller):
        print "Hands Listener Disconnected"

    def on_exit(self, controller):
        print "Hands Listener Exited"

    def on_frame(self, controller):
        # Get the most recent frame and report some basic information
        frame = controller.frame()

        if len(frame.hands) >= 2 and globalvar.restart == False:
            globalvar.restart = True
            