# -*- coding: utf-8 -*-
################################################################################
# Copyright (C) 2012-2013 Leap Motion, Inc. All rights reserved.               #
# Leap Motion proprietary and confidential. Not for distribution.              #
# Use subject to the terms of the Leap Motion SDK Agreement available at       #
# https://developer.leapmotion.com/sdk_agreement, or another agreement         #
# between Leap Motion and you, your company or other organization.             #
################################################################################

import Leap, sys
import fingerlistener

def main():
    # Create a paml listener
    #palm_listener = PalmListener()
    # Create a gesture listener
    #ges_listener = GestureListener()
    # Create a finger listener
    finger_listener = fingerlistner.FingerListener()
    # Create a controller
    controller = Leap.Controller()

    # Have the sample listener receive events from the controller
    controller.add_listener(ges_listener)

    # Keep this process running until Enter is pressed
    print "Press Enter to quit..."
    sys.stdin.readline()

    # Remove the listeners when done
    controller.remove_listener(finger_listener)


if __name__ == "__main__":
    main()
