# -*- coding: utf-8 -*-
import OSC

#host = '192.168.1.144'
host = '127.0.0.1'
port = 7110
grasp_address = '/grasp'
swipe_address = '/swipe'
hands_address = '/hands'
tracking_address = '/trac'
client = None

def get_client():
    global client
    if not client:
        client = OSC.OSCClient()
        client.connect( (host, port) ) # note that the argument is a tupple and not two arguments
    
    return client

def mapping(position):
    # maping to the screen
    if position[0] < -280:
        px = 0
    elif position[0] > 280:
        px =1
    else:
        px = (position[0] - (-280)) / (280 * 2)


    if position[1] < 50:
        py = 0
    elif position[1] > 500:
        py =1
    else:
        py = (position[1] - (50)) / (50 + 500)
    # reverse Y axis
    py = 1 - py
    # dont change Z axis
    pz = position[2]
    return px,py,pz

def send(address, data):
    myclient = get_client()
    msg = OSC.OSCMessage() #  we reuse the same variable msg used above overwriting it
    msg.setAddress(address)
    
    if address == grasp_address:
        msg.append(data.get('type'))
        msg.append(data.get('count'))
        #msg.append(data.get('position'))
        for item in mapping(data.get('position')):
            msg.append(item)

        print data.get('type'), data.get('count'), data.get('position')

    elif address == swipe_address:
        msg.append(data.get('type'))
        msg.append(data.get('speed'))
        for item in mapping(data.get('position')):
            msg.append(item)

        for item in data.get('direction'):
            msg.append(item)

        print data.get('type'), data.get('speed'), data.get('position'), data.get('direction')

    elif address == hands_address:
        msg.append(data.get('type'))
        msg.append(data.get('state'))
        for item in mapping(data.get('position')):
            msg.append(item)

        print data.get('type'), data.get('state'), data.get('position')
        
    client.send(msg) # now we dont need to tell the client the address anymore