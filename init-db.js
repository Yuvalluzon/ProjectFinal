db = db.getSiblingDB("GYM_mongodb");
db.GYM_mongodb_tb.drop() 

db.GYM_mongodb_tb.insertMany([
    {
        "first_name": "Carlos ",
        "last_name": "Alcaraz" ,
        "birth_date":"5/5/2003",
        "weight": "67.2",
        "height": "176",
        "training_program": "AB",
    },

    {
        "first_name": "Rafael ",
        "last_name": "Nadal" ,
        "birth_date":"3/6/1986",
        "weight": "81",
        "height": "182",
        "training_program": "Full-Body"
    },
    {
        "first_name": "Luka ",
        "last_name": "Doncic" ,
        "birth_date":"28/2/1999",
        "weight": "104 ",
        "height": "201",
        "training_program": "ABC"
    },
]);