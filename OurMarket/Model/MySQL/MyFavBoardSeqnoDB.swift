//
//  DBModel.swift
//  ServerJason_01
//
//  Created by TJ on 12/03/2020.
//  Copyright © 2020 TJ. All rights reserved.
//

import Foundation

class MyFavBoardSeqnoDB: NSObject{
    // Properties
    var myFavBoardSeqno: Int?
    
    // Empty Constructor
    override init(){
        
    }
    
    init(myFavBoardSeqno: Int?){
        self.myFavBoardSeqno = myFavBoardSeqno
    }
}
