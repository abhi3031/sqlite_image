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

}
