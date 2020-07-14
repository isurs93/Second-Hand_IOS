//
//  SQLiteForMainPage.swift
//  Emoda
//
//  Created by Piano on 2020/03/18.
//  Copyright © 2020 Piano. All rights reserved.
//

import Foundation
import SQLite3 // ******

class LoginHistory{
    
    var userInfo = [GetUserInfo]()
    
    var db: OpaquePointer?

    init() {
        
    }
    
    func sqlSet() {
        // SQLite 생성하기
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("Emoda.sqlite")
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK{
            print("error opening database")
        }
        
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS Market_userInfo (user_Seqno INTEGER PRIMARY KEY AUTOINCREMENT, user_Id TEXT, user_Pw TEXT, user_Name TEXT, user_Telno TEXT, user_Email TEXT)", nil, nil, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }
     
        
    }
    
    // 기존 로그인 기록이 있다면 그것을 조회하여 로그인 없이 다이어리 입장
//    func userInfoSetIfExist() -> [GetUserInfo] {
//        userInfo.removeAll()
//        let queryString = "SELECT userInfo_Email, userInfo_Nickname FROM UserInfo"
//        var stmt: OpaquePointer?
//
//        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
//            let errmsg = String(cString: sqlite3_errmsg(db)!)
//            print("error preparing select: \(errmsg)")
//        }
//
//        while (sqlite3_step(stmt) == SQLITE_ROW){
//            let user_Id = String(cString: sqlite3_column_text(stmt, 0))
//            let User_Pw = String(cString: sqlite3_column_text(stmt, 1))
//           userInfo.append(GetUserInfo(user_Seqno: userInfo_Email, userInfo_Nickname: userInfo_Nickname))
//        }
//        return userInfo
//
//    }
    
  
    
}
