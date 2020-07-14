//
//  DMDetailViewController.swift
//  OurMarket
//
//  Created by binybing on 06/04/2020.
//  Copyright © 2020 binybing. All rights reserved.
//

import UIKit

class DMDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource , ChatList {
    var chatList : NSArray = NSArray()
    var chatSeq : Int?
    var chatId:String?
    var setIndexPath:IndexPath?
    
    let timeSelector : Selector = #selector(DMDetailViewController.updateDM)
    let interval = 1.0
    var timer : Timer?
    
    @IBOutlet weak var tfDM: UITextField!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        setTableView()
       
        let list = DMSelect()
        list.delegate2 = self
        list.downLoadChatList(chatterSeqno:  chatSeq!)
        //스크롤 최근대화에 포커스
                 let endIndex = IndexPath(row: chatList.count-1 , section: 0)
                 if chatList.count != 0 {
                     self.tableView.scrollToRow(at: endIndex, at: .bottom, animated: false)
                 }
        timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: timeSelector, userInfo: nil, repeats: true)
        // Do any additional setup after loading the view.
    }
    func setTableView(){
        self.navigationItem.title = "\(chatId!)"
        
        tableView.rowHeight = 60
        tableView.separatorStyle = .none
        
    }
    
    func chatterSeq(chatterSeqno:Int,chatterId:String){
        chatSeq = chatterSeqno
        chatId = chatterId
    }
    
    func chatList(items: NSArray) {
        chatList = items
        self.tableView.reloadData()
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailDM", for: indexPath) as! DMDetailTableViewCell
        
        setIndexPath = indexPath
        
        //한줄한줄에 대한거니까 [DmDB]가 아닌  DmDB로
        let data = chatList[indexPath.row] as! DmDB
        
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
    
    @IBAction func btnInsertDM(_ sender: UIButton) {
        dmInsert()
        tfDM.text = ""
    }
    
    
    func dmInsert(){
        let title = tfDM.text!
        let content = tfDM.text!
        
        let sendMessage = DMSendMessage()
        sendMessage.sendMessage(title: title, content: content, chatter:chatSeq! )
        
    }
    @objc func updateDM() {
        
        let list = DMSelect()
        list.delegate2 = self
        list.downLoadChatList(chatterSeqno:  chatSeq!)
        
        let endIndex = IndexPath(row: chatList.count-1 , section: 0)
               if chatList.count != 0 {
                   self.tableView.scrollToRow(at: endIndex, at: .bottom, animated: false)
               }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
