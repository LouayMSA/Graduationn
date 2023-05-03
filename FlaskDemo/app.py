import re
from datetime import datetime

from flask import Flask, render_template, request
import pickle
from NLPyesornoCarDiagnoses import execute_bot

app = Flask(__name__)
model = pickle.load(open('savedmodel.sav', 'rb'))

@app.route("/")
def home():
    return execute_bot()

""" @app.route("/predict" , methods=['POST' , 'GET'])
def predict():
    symptomA= str(request['yes_no'])
    symptomB= str(request['yes_no'])
    symptomC= str(request['yes_no'])
    request = model()
    return render_template ('index.html', ""locals) """
    

if __name__ == '__main__':
    app.run(debug=True)





# @app.route("/hello/<name>")
# def hello_there(name):
#     now = datetime.now()
#     formatted_now = now.strftime("%A, %d %B, %Y at %X")

#     # Filter the name argument to letters only using regular expressions. URL arguments
#     # can contain arbitrary text, so we restrict to safe characters only.
#     match_object = re.match("[a-zA-Z]+", name)

#     if match_object:
#         clean_name = match_object.group(0)
#     else:
#         clean_name = "Friend"

#     content = "Hello there, " + clean_name + "! It's " + formatted_now
#     return content