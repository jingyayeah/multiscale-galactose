'''
Created on May 28, 2014

@author: mkoenig
'''
import sqlite3 as lite
import sys


cars = (
    (1, 'Audi', 52642),
    (2, 'Mercedes', 57127),
    (3, 'Skoda', 9000),
    (4, 'Volvo', 29000),
    (5, 'Bentley', 350000),
    (6, 'Hummer', 41400),
    (7, 'Volkswagen', 21600)
)

con = lite.connect('miriam.db')
with con:
    
    cur = con.cursor()    
    cur.execute('SELECT SQLITE_VERSION()')
    data = cur.fetchone()
    print "SQLite version: %s" % data
    
    cur.execute("DROP TABLE IF EXISTS Cars")
    cur.execute("CREATE TABLE Cars(Id INT, Name TEXT, Price INT)")
    # cur.execute("INSERT INTO Cars VALUES(1,'Audi',52642)")
    # cur.execute("INSERT INTO Cars VALUES(2,'Mercedes',57127)")
    cur.executemany("INSERT INTO Cars VALUES(?, ?, ?)", cars)  

with con:        
    cur = con.cursor()    
    cur.execute("SELECT * FROM Cars")
    rows = cur.fetchall()
    for row in rows:
        print row
        
with con:
    con.row_factory = lite.Row
    cur = con.cursor() 
    cur.execute("SELECT * FROM Cars")
    
    col_names = [cn[0] for cn in cur.description]
    print "%s %-10s %s" % (col_names[0], col_names[1], col_names[2])
    
    rows = cur.fetchall()
    for row in rows:
        print "%s %s %s" % (row["Id"], row["Name"], row["Price"])
        