import pandas as pd
from flask import Flask,request,jsonify,render_template
import sklearn 
import pickle
import os
import numpy as np
from flask_cors import CORS

# Assuming the model file is in the same directory as the script
model_file = "Final_model_iguess.pkl"
model_file = "Final_model_iguess.pkl"

# Check if the file exists
if os.path.exists(model_file):
    with open(model_file, 'rb') as f:
        model = pickle.load(f)
else:
    print("Model file not found!")
app=Flask(__name__,template_folder='template')

CORS(app, resources={r"/*": {"origins": "*"}})

X_test=pd.read_csv("cleaned_2.csv")
X_test=X_test.drop(labels=["N (mg/Kg)","P  (mg/Kg)","K  (mg/Kg)","Unnamed: 0"],axis=1)
@app.route('/')
def Home():
    return render_template("index1.html")
@app.route('/predict/<int:x>')
def predict(x):
    
    
    prediction=np.array(model.predict(X_test.loc[[x]]))
    
    return jsonify(prediction.tolist())
@app.route('/parameters/<int:x>')
def params(x):
    params=X_test.loc[x]
    return jsonify(params.tolist())
if __name__=="__main__":
    app.run(debug=True)
