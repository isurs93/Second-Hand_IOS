//
//  DBModel.swift
//  ServerJason_01
//
//  Created by TJ on 12/03/2020.
//  Copyright © 2020 TJ. All rights reserved.
//

import Foundation

class countFavDB: NSObject{
    // Properties
   
    var bSeqno: Int?
    var cnt: Int?
    
    
    // Empty Constructor
    override init(){
        
    }
    

    
    init(bSeqno: Int?,cnt: Int?){
        self.bSeqno = bSeqno
        self.cnt = cnt
        
    }
    
}
