//
//  DMStartViewController.swift
//  OurMarket
//
//  Created by binybing on 10/04/2020.
//  Copyright © 2020 binybing. All rights reserved.
//

import UIKit

class DMStartViewController: UIViewController,ChatList, UITableViewDelegate, UITableViewDataSource{
    var chatList : NSArray = NSArray()
       var chatSeq = mapToDMChatterSeqno
       var chatId:String?
       var setIndexPath:IndexPath?
       
       let timeSelector : Selector = #selector(DMDetailViewController.updateDM)
       let interval = 1.0
       var timer : Timer?
    

    @IBOutlet weak var txtDM: UITextField!
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        setTableView()
        
        let chat = DMSelect()
        chat.delegate2 = self
        chat.downLoadChatList(chatterSeqno: mapToDMChatterSeqno)
      
        timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: timeSelector, userInfo: nil, repeats: true)
    }
    
    @objc func updateDM() {
        
        let list = DMSelect()
        list.delegate2 = self
        list.downLoadChatList(chatterSeqno:  mapToDMChatterSeqno)
        
        let endIndex = IndexPath(row: chatList.count-1 , section: 0)
               if chatList.count != 0 {
                   self.tableView.scrollToRow(at: endIndex, at: .bottom, animated: false)
               }
    }
    
    func setTableView(){
        // self.navigationItem.title = "\(chatId!)"
         
         tableView.rowHeight = 60
         tableView.separatorStyle = .none
         
     }
    
//    func chatterSeq(chatterSeqno:Int,chatterId:String){
//          chatSeq = chatterSeqno
//          chatId = chatterId
//      }
      
   
      
    func chatList(items: NSArray) {
          chatList = items
                self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        chatList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "dmStartCell", for: indexPath) as! DMStartTableViewCell
        
        setIndexPath = indexPath
        
        //한줄한줄에 대한거니까 [DmDB]가 아닌  DmDB로
        let data = chatList[indexPath.row] as! DmDB
       chatId = data.chatterId
        
        if data.dm_bSend == user_info.user_Seqno{
            cell.chatContent.textAlignment = .right
        }else{
            cell.chatContent.textAlignment = .left
        }
        cell.label.sizeToFit()
        let newSize = cell.label.sizeThatFits( CGSize(width: cell.label.frame.width, height: CGFloat.greatestFiniteMagnitude))
        // cell.label.frame.height = newSize.height
        // cell.chatContent.text = data.dm_Title!+"\n"+data.dm_Content!
        cell.chatContent.text = data.dm_Content!
        // Configure the cell...
        
        return cell
    }
    
    @IBAction func btnSend(_ sender: UIButton) {
        dmInsert()
    }
    func dmInsert(){
          let title = txtDM.text!
          let content = txtDM.text!
          
          let sendMessage = DMSendMessage()
          sendMessage.sendMessage(title: title, content: content, chatter:mapToDMChatterSeqno )
          
      }

}
