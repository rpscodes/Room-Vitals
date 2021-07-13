#!/usr/bin/env python3
import getcurrentvalues
import gethistoricvalues
from flask import Flask, render_template, request
from flask_restful import Resource, Api, reqparse

app = Flask(__name__)
api = Api(app)

PresentValues = getcurrentvalues.Atmosphere
HistoricValues = gethistoricvalues.Historic

api.add_resource(PresentValues, '/atmos')  # '/atmos' is our entry point for getting current values
api.add_resource(HistoricValues, '/historic')  # '/historic' is our entry point for getting Historic Values

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')


