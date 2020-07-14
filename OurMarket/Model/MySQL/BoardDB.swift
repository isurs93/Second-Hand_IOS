//
//  DBModel.swift
//  ServerJason_01
//
//  Created by TJ on 12/03/2020.
//  Copyright © 2020 TJ. All rights reserved.
//

import Foundation

class BoardDB: NSObject{
    // Properties
   
    var board_Seqno: Int?
    var board_Title: String?
    var board_Content: String?
    var board_hit: Int?
    var board_Sido: String?
    var board_Latitude: Double?
    var board_Longitude: Double?
    var board_InsertDate: String?
    var board_isDone: Int?
    var board_Price: Int?
    var user_Id:String?
    var board_uSeqno: Int?
    var board_StrImage: String?
    
    
    // Empty Constructor
    override init(){
        
    }
    
  init(board_Seqno:Int?) {
        self.board_Seqno = board_Seqno
    }
    
    init(board_Seqno: Int?, board_Title: String?, board_Content: String?, board_hit: Int?,board_Sido:String?,board_Latitude:Double?,board_Longitude:Double?,board_InsertDate:String?,board_isDone:Int?,board_Price:Int?,user_Id:String?,board_uSeqno:Int?,board_StrImage:String?){
        self.board_Seqno = board_Seqno
        self.board_Title = board_Title
        self.board_Content = board_Content
        self.board_hit = board_hit
        self.board_Sido = board_Sido
        self.board_Latitude = board_Latitude
        self.board_Longitude = board_Longitude
        self.board_InsertDate = board_InsertDate
        self.board_isDone = board_isDone
        self.board_Price = board_Price
        self.user_Id = user_Id
        self.board_uSeqno = board_uSeqno
        self.board_StrImage = board_StrImage
        
    }
    
}
