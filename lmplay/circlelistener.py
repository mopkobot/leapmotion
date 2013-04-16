# -*- coding: utf-8 -*-
import Leap
import client
from Leap import CircleGesture
import globalvar

class CircleListener(Leap.Listener):
    times = 0
    def on_init(self, controller):
        print "Circle Listener Initialized"

    def on_connect(self, controller):
        print "Circle Listener Connected"

        # Enable gestures
        controller.enable_gesture(Leap.Gesture.TYPE_CIRCLE);

    def on_disconnect(self, controller):
        print "Circle Listener Disconnected"

    def on_exit(self, controller):
        print "Circle Listener Exited"

    def on_frame(self, controller):
        # Get the most recent frame and report some basic information
        frame = controller.frame()
       
        # Gestures
        for gesture in frame.gestures():
            if gesture.type == Leap.Gesture.TYPE_CIRCLE:
                circle = CircleGesture(gesture)

                # Determine clock direction using the angle between the pointable and the circle normal
                if circle.pointable.direction.angle_to(circle.normal) <= Leap.PI/4:
                    clockwiseness = "clockwise"
                else:
                    clockwiseness = "counterclockwise"

                # Calculate the angle swept since the last frame
                swept_angle = 0
                if circle.state != Leap.Gesture.STATE_START:
                    previous_update = CircleGesture(controller.frame(1).gesture(circle.id))
                    swept_angle =  (circle.progress - previous_update.progress) * 2 * Leap.PI

                print "Circle id: %d, %s, progress: %f, radius: %f, angle: %f degrees, %s" % (
                        gesture.id, self.state_string(gesture.state),
                        circle.progress, circle.radius, swept_angle * Leap.RAD_TO_DEG, clockwiseness)


                '''
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
                '''

    def state_string(self, state):
        if state == Leap.Gesture.STATE_START:
            return "STATE_START"

        if state == Leap.Gesture.STATE_UPDATE:
            return "STATE_UPDATE"

        if state == Leap.Gesture.STATE_STOP:
            return "STATE_STOP"

        if state == Leap.Gesture.STATE_INVALID:
            return "STATE_INVALID"


#############################################################
import Leap, sys
def main():
    #Create a controller
    controller = Leap.Controller()
    # add a circle gesture lisenter
    circle_listener = CircleListener()
    controller.add_listener(circle_listener)
    # wait for end
    print "Press Enter to end grasp..."
    sys.stdin.readline()

    # remove the listener
    controller.remove_listener(circle_listener)

if __name__ == "__main__":
    main()
