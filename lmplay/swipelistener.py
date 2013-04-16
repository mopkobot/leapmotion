# -*- coding: utf-8 -*-
import Leap
import client
from Leap import SwipeGesture
import globalvar

class SwipeListener(Leap.Listener):
    times = 0
    def on_init(self, controller):
        print "Swipe Listener Initialized"

    def on_connect(self, controller):
        print "Swipe Listener Connected"

        # Enable gestures
        controller.enable_gesture(Leap.Gesture.TYPE_SWIPE);

    def on_disconnect(self, controller):
        print "Swipe Listener Disconnected"

    def on_exit(self, controller):
        print "Swipe Listener Exited"

    def on_frame(self, controller):
        # Get the most recent frame and report some basic information
        frame = controller.frame()
        for gesture in frame.gestures():
            if gesture.type == Leap.Gesture.TYPE_SWIPE:
                swipe = SwipeGesture(gesture)
                position = swipe.position
                
                '''
                print "Swipe id: %d, state: %s, position: %s, direction: %s, speed: %f" % (
                        gesture.id, self.state_string(gesture.state),
                        swipe.position, swipe.direction, swipe.speed)
                '''
                globalvar.swipetimes += 1
                if globalvar.swipetimes > 5 and globalvar.started == False:            
                    # send data
                    position = swipe.position
                    direction = swipe.direction
                    data = {
                        'type': gesture.type,
                        'speed': swipe.speed,
                        'position': (position.x, position.y, position.z),
                        'direction': (direction.x, direction.y, direction.z), 
                     }
                    client.send(client.swipe_address, data)
                    globalvar.started = True


        if not (frame.hands.empty and frame.gestures().empty):
            print ""

    def state_string(self, state):
        if state == Leap.Gesture.STATE_START:
            return "STATE_START"

        if state == Leap.Gesture.STATE_UPDATE:
            return "STATE_UPDATE"

        if state == Leap.Gesture.STATE_STOP:
            return "STATE_STOP"

        if state == Leap.Gesture.STATE_INVALID:
            return "STATE_INVALID"
