import mysql.connector
class Photoshop:

    def query1(self,crsr):

        crsr.execute('SELECT LoginName FROM transactions WHERE TotalAmount > 100')
        result = crsr.fetchall()
        print(result)

    def query2(self,crsr):
        crsr.execute(''' SELECT PhotoID FROM photo WHERE TransID IS NULL OR TransID = '' ''')
        result = crsr.fetchall()
        print(result)

    def query3(self,crsr,model):
        crsr.execute('''SELECT LoginName FROM transactions WHERE TransID IN
        (SELECT TransID FROM photo WHERE PhotoID IN
        (SELECT PHOTOID FROM models WHERE MName = %s))
        AND TransID NOT IN
        (SELECT TransID FROM photo WHERE PhotoID IN
        (SELECT PHOTOID FROM models WHERE MName != %s))
        ''',(model,model,))
        result = crsr.fetchall()
        print(result)

    def query4(self,crsr):
        crsr.execute('SELECT RPName FROM influences WHERE EPName IN (SELECT PName FROM photographer WHERE PNationality = "American")')
        result = crsr.fetchall()
        print(result)

    def query5(self,crsr):
        crsr.execute('''SELECT PName FROM photographer WHERE PName IN
        (SELECT PName FROM photo WHERE PhotoID IN (SELECT DISTINCT PhotoID FROM models))
        AND PName NOT IN (SELECT PName FROM photo WHERE PhotoID IN (SELECT PhotoID FROM abstract))
        AND PName NOT IN (SELECT PName FROM photo WHERE PhotoID IN (SELECT PhotoID FROM landscape))
        ''')
        result = crsr.fetchall()
        print(result)

    def query6(self,crsr):
        crsr.execute('''SELECT TransID,COUNT(*) FROM photo
        GROUP BY TransID
        HAVING COUNT(*)>=3
        ORDER BY COUNT(*) DESC''')
        result = crsr.fetchall()
        print(result)


    def query7(self,crsr,photograhper):
        crsr.execute('''SELECT DISTINCT MName FROM models WHERE PhotoID IN (SELECT PhotoID FROM photo WHERE PName=%s)
        AND PhotoID NOT IN (SELECT PhotoID FROM photo WHERE PName !=%s)
        ''',(photograhper,photograhper,))
        result = crsr.fetchall()
        print(result)

    def __init__(self):
        mydb = mysql.connector.connect(host='localhost',user='root',passwd='SQL2020!nj',database='photoshop')
        crsr = mydb.cursor()
        #self.createDatabase(mydb,crsr)
        option = input("Enter 1-14 to run the corresponding query. Enter q to quit the program")
        while option != 'q':
            if option == '1':
                self.query1(crsr)
                option = input("Enter 1-14 to run the corresponding query. Enter q to quit the program")
            elif option =='2':
                self.query2(crsr)
                option = input("Enter 1-14 to run the corresponding query. Enter q to quit the program")
            elif option == '3':
                model = input('Please enter a models name.')
                self.query3(crsr,model)
                option = input("Enter 1-14 to run the corresponding query. Enter q to quit the program")
            elif option == '4':
                self.query4(crsr)
                option = input("Enter 1-14 to run the corresponding query. Enter q to quit the program")
            elif option == '5':
                self.query5(crsr)
                option = input("Enter 1-14 to run the corresponding query. Enter q to quit the program")
            elif option == '6':
                self.query6(crsr)
                option = input("Enter 1-14 to run the corresponding query. Enter q to quit the program")
            elif option == '7':
                photographer = input('Please enter the photograhpers name.')
                self.query7(crsr,photographer)
                option = input("Enter 1-14 to run the corresponding query. Enter q to quit the program")



Photoshop()
