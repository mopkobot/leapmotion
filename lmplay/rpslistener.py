# -*- coding: utf-8 -*-
import Leap
import client

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

        if len(frame.hands):
            # Get the first hand
            left_hand = frame.hands[0]
            right_hand = frame.hands[1]
            # Check if the hand has any fingers
            left_fingers = len(left_hand.fingers)
            right_fingers = len(right_hand.fingers)
            def _hand_type(finger_count):
                # 0:拳头，2：剪刀， 5：布
                res = 0
                if finger_count == 0:
                    res = 0
                elif finger_count >= 1 and finger_count <= 3:
                    res = 2
                elif finger_count >= 4:
                    res = 5
                
                return res
            
            # move and not grasp
            data = {
                    'type': 201,
                    'left': left_fingers,#_hand_type(left_fingers),
                    'right': right_fingers,#_hand_type(right_fingers),
            }
            client.send(client.hands_address, data)

    def state_string(self, state):
        if state == Leap.Gesture.STATE_START:
            return "STATE_START"

        if state == Leap.Gesture.STATE_UPDATE:
            return "STATE_UPDATE"

        if state == Leap.Gesture.STATE_STOP:
            return "STATE_STOP"

        if state == Leap.Gesture.STATE_INVALID:
            return "STATE_INVALID"