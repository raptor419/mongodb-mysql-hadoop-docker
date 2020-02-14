import pandas as pd
import pymongo
import json
client = pymongo.MongoClient('localhost', 27017)
db = client['mgdb'] # Replace mongo db name
collection_name = 'Group45' # Replace mongo db collection name
db_cm = db[collection_name]
data = pd.read_csv('/code/Group45.csv',delimiter="\t")
data_json = json.loads(data.to_json(orient='records'))
db_cm.remove()
print(data_json)
db_cm.insert(data_json)