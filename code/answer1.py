from mysql import connector as mysql
import csv

db = mysql.connect(
  host="localhost",
  user="root",
  passwd="root"
)

cursor = db.cursor()

cursor.execute("CREATE DATABASE IF NOT EXISTS mydb")

cursor.execute("SHOW DATABASES")

## 'fetchall()' method fetches all the rows from the last executed statement
databases = cursor.fetchall() ## it returns a list of all databases present

## printing the list of databases
print(databases)

## showing one by one database
for database in databases:
    print(database)

db = mysql.connect(
  host="localhost",
  user="root",
  passwd="root",
  database="mydb",
)

cursor = db.cursor()

cursor.execute("DROP TABLE IF EXISTS Group45")

cursor.execute("CREATE TABLE Group45(id VARCHAR(25), technique VARCHAR(255), d_id VARCHAR(255), n_samples VARCHAR(25), t_samples VARCHAR(255), pubmed_id VARCHAR(25))")

csv_data = csv.reader(open('Group45.csv'),delimiter="\t")
# execute and insert the csv into the database.
for row in list(csv_data)[1:]:
	# print('INSERT INTO Group45 VALUES (%s, %s, %s, %s, %s, %s)',row)
	cursor.execute('INSERT INTO Group45 VALUES (%s, %s, %s, %s, %s, %s)',row)
	print(row)
#close the connection to the database.
db.commit()

print ("CSV has been imported into the database")

cursor.execute("SELECT * FROM Group45")

result = cursor.fetchall()

for x in result:
  print(x)

cursor.close()

# Source: https://www.datacamp.com/community/tutorials/mysql-python, https://www.w3schools.com/