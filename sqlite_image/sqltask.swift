//
//  sqltask.swift
//  sqlite_image
//
//  Created by TOPS on 9/27/18.
//  Copyright © 2018 TOPS. All rights reserved.
//

import UIKit

class sqltask: NSObject {
    
    
    func insertdata(dml:String) -> Bool{
        let  path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0];
        let fullpath = path.appending("/mydb.db");
        var status:Bool?
        
        var db:OpaquePointer? = nil;
        
        if sqlite3_open(fullpath, &db) == SQLITE_OK {
            var stmt:OpaquePointer? = nil;
            if sqlite3_prepare_v2(db, dml, -1, &stmt, nil) == SQLITE_OK {
                
                sqlite3_step(stmt)
                status = true;
            }
            sqlite3_finalize(stmt)
            sqlite3_close(db);
            
        }

        
        return status!;
    }

    func getdata(query:String) -> [Any] {
        
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let path1 = path[0]
        let finalpath = path1.appending("/mydb.db");
        print(finalpath)
        
        var arr:[Any] = [];
        var status:Bool = false
        var db:OpaquePointer? = nil
        
        if sqlite3_open(finalpath, &db) == SQLITE_OK {
            
            var stmt:OpaquePointer? = nil;
            
            if sqlite3_prepare_v2(db, query, -1, &stmt, nil) == SQLITE_OK {
                
                while sqlite3_step(stmt) == SQLITE_ROW {
                    
                    var brr :[String] = [];
                    
                    let id = String(cString: sqlite3_column_text(stmt, 0))
                    let name = String(cString: sqlite3_column_text(stmt, 1))
                    let email = String(cString: sqlite3_column_text(stmt, 2))
                    let image = String(cString: sqlite3_column_text(stmt, 3))
                    
                    
                    brr.append(id)
                    brr.append(name)
                    brr.append(email)
                    brr.append(image)
                    
                    
                    arr.append(brr)
                }
            }
            sqlite3_finalize(stmt)
            sqlite3_close(db)
        }
        return arr
    }
    



}
