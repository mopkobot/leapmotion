# -*- coding: utf-8 -*-
import Leap
import client

class GraspListener(Leap.Listener):
    grasping = False
    def on_init(self, controller):
        print "Grasp Listener Initialized"

    def on_connect(self, controller):
        print "Grasp Listener Connected"

    def on_disconnect(self, controller):
        print "Grasp Listener Disconnected"

    def on_exit(self, controller):
        print "Exited"

    def on_frame(self, controller):
        # Get the most recent frame and report some basic information
        frame = controller.frame()

        if not frame.hands.empty:
            # Get the first hand
            hand = frame.hands[0]

            # Check if the hand has any fingers
            fingers = hand.fingers
            count = len(fingers)
            halm_pos = hand.palm_position
            if fingers.empty:
                if self.grasping == False:
                    # a grasp event 
                    data = {
                        'type': 102,
                        'count': count,
                        'position': (halm_pos.x, halm_pos.y, halm_pos.z)
                    }
                    client.send(client.grasp_address, data)
                    self.grasping = True
                else:
                    # grasping and move 
                    data = {
                        'type': 103,
                        'count': count,
                        'position': (halm_pos.x, halm_pos.y, halm_pos.z)
                    }
                    client.send(client.grasp_address, data)
            else:
                # only change to True while count > 1; when count == 1, do not change; 
                # and when count is 0, it will not run into here
                if self.grasping == True and count > 1:
                    # a loosen action
                    data = {
                        'type': 104,
                        'count': count,
                        'position': (halm_pos.x, halm_pos.y, halm_pos.z)
                    }
                    client.send(client.grasp_address, data)
                    self.grasping = False
                elif self.grasping == True and count == 1:
                    # grasping and move
                    data = {
                        'type': 103,
                        'count': count,
                        'position': (halm_pos.x, halm_pos.y, halm_pos.z)
                     }
                    client.send(client.grasp_address, data)
                elif self.grasping == False:
                    # move and not grasp
                    data = {
                        'type': 101,
                        'count': count,
                        'position': (halm_pos.x, halm_pos.y, halm_pos.z)
                     }
                    client.send(client.grasp_address, data)

