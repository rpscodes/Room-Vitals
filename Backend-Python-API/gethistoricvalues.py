#!/usr/bin/env python3

import time
import sqlite3
import json
import collections


from seeed_dht import DHT
from flask import Flask, render_template, request
from picamera import PiCamera
from time import sleep
from datetime import date, time, datetime
import time
from flask_restful import Resource, Api, reqparse

class Historic(Resource):
    # methods go here
    def get(self):
        parser = reqparse.RequestParser()  # initialize
        
        parser.add_argument('Date', required=True)  # add args
        args = parser.parse_args()  # parse arguments to dictionary
        DateQueried = args['Date']
        
       
        
        # connects to SQLite database. File is named "sensordata.db" without the quotes
        # WARNING: your database file should be in the same directory of the app.py file or have the correct path
        conn=sqlite3.connect('sensordata.db')
        c=conn.cursor()
        c.execute("SELECT temperature, humidity, currentime FROM dhtreadings WHERE currentdate=?", (DateQueried,));
        rows = c.fetchall()
        #json_data = json.dumps(row)
        objects_list = []
        for row in rows:
            d = collections.OrderedDict()
            d['Historictemperature'] = row[0]
            d['Historichumidity'] = row[1]
            d['Historictime'] = row[2]
            objects_list.append(d)
            
        print(objects_list[0])
        j = json.dumps(objects_list) 
        
        conn.commit()
        conn.close()
        
        return objects_list, 200  # return data and 200 OK code
    pass
