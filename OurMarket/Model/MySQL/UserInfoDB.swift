//
//  DBModel.swift
//  ServerJason_01
//
//  Created by TJ on 12/03/2020.
//  Copyright © 2020 TJ. All rights reserved.
//

import Foundation

class UserInfoDB: NSObject{
    // Properties
    var user_Seqno: Int?
    var user_Id: String?
    var user_Password: String?
    var user_Name: String?
    var user_Telno: String?
    var user_Email: String?
    
    // Empty Constructor
    override init(){
        
    }
    
    init(user_Seqno: Int?, user_Id: String?, user_Password: String?, user_Name: String?,user_Telno:String?,user_Email:String?){
        self.user_Seqno = user_Seqno
        self.user_Id = user_Id
        self.user_Password = user_Password
        self.user_Name = user_Name
        self.user_Telno = user_Telno
        self.user_Email = user_Email
    }
}
