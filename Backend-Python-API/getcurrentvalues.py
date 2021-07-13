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

class Atmosphere(Resource):
    # methods go here
    def get(self):
        #Grove - Temperature&Humidity Sensor connected to port D18
        sensor = DHT('11', 18)
        humi, temp = sensor.read()
        
        today = date.today()
        ctoday = str(today)
        
        t = time.localtime()
        current_time = time.strftime("%H:%M:%S", t)
        
        # connects to SQLite database. File is named "sensordata.db" without the quotes
        # WARNING: your database file should be in the same directory of the app.py file or have the correct path
        conn=sqlite3.connect('sensordata.db')
        c=conn.cursor()

        c.execute("""INSERT INTO dhtreadings (temperature, humidity, currentdate, currentime) VALUES ((?), (?), (?), (?))""", (temp, humi, today, current_time));
        
        conn.commit()
        conn.close()
        
        Details = {
            'humidity': humi,
            'temperature': temp,
            'date' : ctoday,
            'ctime' : current_time
            
        }
            
        
        return Details, 200  # return data and 200 OK code
    pass