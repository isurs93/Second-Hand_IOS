//
//  DBModel.swift
//  ServerJason_01
//
//  Created by TJ on 12/03/2020.
//  Copyright © 2020 TJ. All rights reserved.
//

import Foundation

class DmDB: NSObject{
    // Properties
   
    var dm_Seqno: Int?
    var dm_bSend: Int?
    var dm_bReceive: Int?
    var dm_Content: String?
    var dm_InsertDate: String?
    
    var dm_SendDelete: String?
    var dm_ReceiveDelete: String?
    var dm_Title: String?
    
    var chatterSeqno: Int?
    var chatterId: String?
    
   
    
    
    // Empty Constructor
    override init(){
        
    }
    
  init(chatterSeqno:Int?) {
        self.chatterSeqno = chatterSeqno
    }
    init(chatterId:String?) {
          self.chatterId = chatterId
      }
    
    init(chatterId:String?,chatterSeqno:Int?) {
             self.chatterId = chatterId
         self.chatterSeqno = chatterSeqno
         }
    
    init(dm_Seqno: Int?, dm_bSend: Int?, dm_bReceive: Int?, dm_Content: String?,dm_InsertDate:String?,dm_SendDelete:String?,dm_ReceiveDelete:String?,dm_Title:String?,chatterSeqno:Int?,chatterId:String?){
        self.dm_Seqno = dm_Seqno
        self.dm_bSend = dm_bSend
        self.dm_bReceive = dm_bReceive
        self.dm_Content = dm_Content
        self.dm_InsertDate = dm_InsertDate
        self.dm_SendDelete = dm_SendDelete
        self.dm_ReceiveDelete = dm_ReceiveDelete
        self.dm_Title = dm_Title
        
    }
    
}
