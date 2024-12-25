from flask import Flask , render_template,jsonify,request
from pymongo import MongoClient
from prometheus_flask_exporter import PrometheusMetrics
from bson.json_util import dumps
from bson.objectid import ObjectId
import pymongo
import os

app = Flask(__name__)
metrics = PrometheusMetrics(app, group_by='endpoint')

def get_db():
    client=MongoClient(host='mongodb://root:Aa123456@mongodb:27017/GYM_mongodb',port=27017,username="root",password="Aa123456",authSource="admin")


    db= client ["GYM_mongodb"]
    return db

@app.route("/")
def Home_Website():
    return render_template('index.html') 

@app.route("/subscriptions")
def fetch_subscriptions():
    db = get_db()
    _subscriptions= db["GYM_mongodb_tb"].find()
    subscriptions = [{"first_name": subscription["first_name"],
                      "last_name": subscription["last_name"],
                      "birth_date":subscription["birth_date"],
                      "weight":subscription["weight"],
                      "height":subscription["height"],
                      "training_program":subscription["training_program"]}
                       for subscription in _subscriptions]

    return jsonify({"subscriptions":subscriptions})

@app.route("/subscriptions_ids", methods=[ "GET"])
def show_all_ids_subcriptions():
    db = get_db()
    _subscriptions= db["GYM_mongodb_tb"].find()
    subscriptions = [{"_id": str(subscription["_id"]),
                      "first_name": subscription["first_name"],
                      "last_name": subscription["last_name"]}  
                       for subscription in _subscriptions]

    return jsonify({"subscriptions":subscriptions})

@app.route("/subscriptions_by_training_program", methods=[ "POST"])
def subscriptions_by_training_program():
    if request.method == 'POST': 
        db = get_db()
        training_program = request.form["training_program"]
        subscription = db["GYM_mongodb_tb"].find({"training_program":training_program})
        sub = dumps(subscription)
        return sub

@app.route("/subscription_by_id", methods=[ "POST"])
def subscription_by_id():
    if request.method == 'POST': 
        db = get_db()
        id=request.form["id"]
        subscription = db["GYM_mongodb_tb"].find_one({"_id":ObjectId(id)})
        sub = dumps(subscription)
        return sub

@app.route("/add_subscription", methods=[ "POST"])
def add_subscription():
    if request.method == 'POST':
        first_name = request.form["first_name"]
        last_name = request.form["last_name"]
        birth_date = request.form["birth_date"] 
        training_program = request.form["training_program"]
        weight=request.form["weight"]
        height=request.form["height"]
        db = get_db()


        subscription= db["GYM_mongodb_tb"].insert_one({"first_name": first_name ,
                                                       "last_name": last_name ,
                                                       "birth_date":birth_date ,
                                                       "height":height,
                                                       "weight":weight,
                                                       "training_program":training_program})

        sub = jsonify(Message='User added successfully!')
        return sub

@app.route("/update_subscription", methods=[ "POST"])
def update_subscription():
    if request.method == 'POST': 
        id=request.form["id"]
        first_name = request.form["first_name"]
        last_name = request.form["last_name"]
        birth_date = request.form["birth_date"] 
        training_program = request.form["training_program"]
        weight=request.form["weight"]
        height=request.form["height"]
        db = get_db()
                

        subscription= db["GYM_mongodb_tb"].update_one({"_id":ObjectId(id)},
                                                      {'$set':{"first_name": first_name,
                                                       "last_name": last_name ,"birth_date":birth_date,
                                                       "training_program":training_program ,"weight":weight ,"height":height}})
        msg = jsonify(Message='User updated successfully!')
        return msg

@app.route("/delete_subscription", methods=[ "POST"])
def delete_subscription():
    if request.method == 'POST': 
        db = get_db()
        id=request.form["id"]
        subscription= db["GYM_mongodb_tb"].delete_one({"_id":ObjectId(id)})
        if subscription.deleted_count:
            msg = jsonify(Message='User delete successfully!')
        else:
            msg = jsonify(Message='Internal Problem!')
    return msg

@app.route("/subscription_BMI", methods =[ "POST" ])
def subscription_BMI():
    if request.method == 'POST':
        db = get_db()
        id=request.form["id"]
        weight= ((db["GYM_mongodb_tb"].find_one({"_id":ObjectId(id)},{"weight":1}))) 
        height= ((db["GYM_mongodb_tb"].find_one({"_id":ObjectId(id)},{"height":1})))

        BMI = round(((((float(weight["weight"]))) / (float(height["height"]))/100)**2),2)
        if BMI <= 18.4:
            msg = jsonify(Message='Your BMI Is Under Weight')
        if BMI <= 24.9:
            msg = jsonify(Message='Your BMI Is Normal Weight')
        if BMI <= 29.9:
            msg = jsonify(Message='Your BMI Is Over Weight')
        if BMI <= 34.9:
            msg = jsonify(Message='Your BMI Is Obesity Weight (Class 1)')
        if BMI <= 39.9:
            msg = jsonify(Message='Your BMI Is Obesity Weight (Class 2)')
        if BMI > 39.9:
            msg = jsonify(Message='Your BMI Is Obesity Weight (Class 3)')
    return msg

@app.route("/id-for-test" , methods= [ "GET" ])
def id_for_e2e_testing():
    if request.method =='GET':
        db = get_db()
        ids=((db["GYM_mongodb_tb"].find_one({},{"_id":1})))
        spacific_id=str(ids["_id"])
        
        return spacific_id
    
    
if __name__ == "__main__":
    app.run(host='0.0.0.0',port=5000)



