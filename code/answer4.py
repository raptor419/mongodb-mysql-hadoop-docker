import pandas as pd
import json
data = pd.read_csv('Group45.csv',delimiter="\t")
your_json = data.to_json(orient='records')
parsed = json.loads(your_json)
print(json.dumps(parsed, indent=4, sort_keys=True))
data.to_json('Group45.json',orient='records')
