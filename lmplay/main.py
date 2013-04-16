# -*- coding: utf-8 -*-
################################################################################
# Copyright (C) 2012-2013 Leap Motion, Inc. All rights reserved.               #
# Leap Motion proprietary and confidential. Not for distribution.              #
# Use subject to the terms of the Leap Motion SDK Agreement available at       #
# https://developer.leapmotion.com/sdk_agreement, or another agreement         #
# between Leap Motion and you, your company or other organization.             #
################################################################################
import time
import Leap, sys
import swipelistener, grasplistener, handslistener
import globalvar

def main():
    #Create a controller
    controller = Leap.Controller()
    
    # add restart hand listener
    hands_listener = handslistener.HandsListener()
    controller.add_listener(hands_listener)
    
    while True:
        if globalvar.restart:
            # 1. add a starting gesture lisenter
            swipe_listener = swipelistener.SwipeListener()
            controller.add_listener(swipe_listener)
            # wait for starting gesture
            while not globalvar.started:
                print 'not started'
                time.sleep(0.8)
                globalvar.times = 0

            # to be enable next time
            globalvar.started = False

            print 'started'
            # has started, remove the listener
            controller.remove_listener(swipe_listener)
            
            # 2. starting grasp
            grasp_listener = grasplistener.GraspListener()
            controller.add_listener(grasp_listener)
            globalvar.restart = False
            while globalvar.restart == False:
               time.sleep(0.8)

            print 'end grasp'
            controller.remove_listener(grasp_listener)
            time.sleep(3)
            print 'restart'
        else:
            time.sleep(1)
    
    # never run here
    controller.remove_listener(hands_listener)

if __name__ == "__main__":
    main()
