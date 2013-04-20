# -*- coding: utf-8 -*-
import Leap
import globalvar
import time
import client

class HandsListener(Leap.Listener):
    grasping = False
    last_time = 0
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
        current_time = time.time()
        if len(frame.hands) >= 2 and globalvar.restart == False and (current_time - self.last_time) > 2:
            hand = frame.hands[0]
            # send data
            position = hand.palm_position
            data = {
                'type': 110,
                'state': 1,
                'position': (position.x, position.y, position.z)
             }
            index = 0
            while index < 20:
                index += 1
                client.send(client.hands_address, data)
            # set restart
            globalvar.restart = True
            