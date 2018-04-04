//
//  MyModel.swift
//  LoginRegistrationDB
//
//  Created by apple on 2017-10-26.
//  Copyright © 2017 Doth Solutions. All rights reserved.
//

import UIKit
import FMDB

let databaseFileName = "LoginRegisterDB.sqlite"

var pathToDatabase: String!

var database: FMDatabase!




class MyModel: UIViewController {

    public func ShowAlertMessage(strMessage:NSString, strTitle:NSString, strView:UIViewController){
        
        let alertCont : UIAlertController = UIAlertController.init(title: strTitle as String, message: strMessage as String, preferredStyle: UIAlertControllerStyle.alert)
        
        let ok : UIAlertAction = UIAlertAction.init(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        alertCont.addAction(ok)
        strView.present(alertCont, animated: true, completion: nil)
        
    }
    
    
    
   public func createDatabase() -> Bool {
        var created = false
    let documentsDirectory = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString) as String
    pathToDatabase = documentsDirectory.appending("/\(databaseFileName)")
    
        if !FileManager.default.fileExists(atPath: pathToDatabase) {
            database = FMDatabase(path: pathToDatabase!)
            
            if database != nil {
                // Open the database.
                if database.open() {
                    let createMoviesTableQuery = "create table Register (RegID integer primary key autoincrement not null, username text not null, email text not null, password text)"
                    
                    do {
                        try database.executeUpdate(createMoviesTableQuery, values: nil)
                        created = true
                    }
                    catch {
                        print("Could not create table.")
                        print(error.localizedDescription)
                    }
                    
                    // At the end close the database.
                    database.close()
                }
                else {
                    print("Could not open the database.")
                }
            }
             print("create table.")
        }
        return created
    }
    
    func openDatabase() -> Bool {
        if database == nil {
            if FileManager.default.fileExists(atPath: pathToDatabase) {
                database = FMDatabase(path: pathToDatabase)
            }
        }
        if database != nil {
            if database.open() {
                return true
            }
        }
        
        return false
    }
    
    public func InsertRecord(mdic:NSMutableDictionary) -> Bool{
        if MyModel().openDatabase() {
            
            let username:String = mdic.value(forKey: "username") as! String
            let email:String = mdic.value(forKey: "email") as! String
            let password:String = mdic.value(forKey: "password") as!String
         
            do {
                try  database.executeUpdate("INSERT INTO Register (username,email,password) values (?,?,?)", values: [username,email,password])
                
            } catch {
                print("error = \(error)")
                
            }
            return true
        }else{
             print("database not open")
            return false;
        }
    }
    
    func getAllStudentData(mdicData:NSMutableDictionary) -> NSMutableDictionary {
        let dictParams: NSMutableDictionary = NSMutableDictionary()
        
        let emaildata:String = mdicData.value(forKey: "email") as! String
        let passwordData:String = mdicData.value(forKey: "password") as! String
        
        if MyModel().openDatabase() {
            
            let resultSet: FMResultSet! = database.executeQuery("SELECT * FROM Register where email ='\(emaildata)' AND password = '\(passwordData)'", withArgumentsIn: nil)
            
            if (resultSet != nil) {
                if resultSet.next() {
                    
                    let username:String = resultSet.string(forColumn: "username")
                    let email:String = resultSet.string(forColumn: "email")
                    let password:String
                        = resultSet.string(forColumn: "password")
                    let success:String = "true"
                    
                    dictParams.setObject(username, forKey: "username" as NSCopying)
                    dictParams.setObject(email, forKey: "email" as NSCopying)
                    dictParams.setObject(password, forKey: "password" as NSCopying)
                    dictParams.setObject(success, forKey: "success" as NSCopying)
                    
                }else{
                    
                    let success:String = "false"
                    dictParams.setObject(success, forKey: "success" as NSCopying)
                    
                }
            }
            database.close()
         }
        return dictParams
        
    }
}
