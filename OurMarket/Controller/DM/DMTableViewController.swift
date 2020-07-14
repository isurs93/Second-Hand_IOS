//
//  DMTableViewController.swift
//  OurMarket
//
//  Created by binybing on 30/03/2020.
//  Copyright © 2020 binybing. All rights reserved.
//

import UIKit
var chatterSeqnoPass = 0
class DMTableViewController: UITableViewController,SelectChatterID,ChatList,ChatterSeqno {
    
    
    
    
    var chatterList : NSArray = NSArray()
    var chatList = [DmDB]()
    var list = DmDB()
    
    
    @IBOutlet var tableListView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableListView.rowHeight = 100
        findMyChatters()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func findMyChatters(){
        let findChatters = DMSelect()
        findChatters.delegate = self
        findChatters.selectMyChatters()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return chatterList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellDm", for: indexPath) as! DMTableViewCell
        
        // Configure the cell...
        list = chatterList[indexPath.row] as! DmDB
        cell.txtUserId.text = "\(list.chatterId!)"
        cell.txtDm.text = ""
        return cell
    }
    
    //protocol
    func selectChatterId(chatterID: NSArray) {
        print(chatterID, "DM Table View Controller")
        chatterList = chatterID
        
        self.tableListView.reloadData()
    }
    
    func chatList(items: NSArray) {
        
        for i in 0 ..< items.count{
            let data:DmDB = items[i] as! DmDB
            chatList.append(data)
        }
        
    }
    
    func chatterSeqno(chatterSeqno: Int) {
        chatterSeqnoPass = chatterSeqno
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        //dmDetail
        
        if segue.identifier == "goDetailDM"{
            let cell = sender as! UITableViewCell
            let indexPath = self.tableListView.indexPath(for: cell) //몇번째 cell 선택인지 알아내기
            let detailView = segue.destination as! DMDetailViewController
            
            list = chatterList[indexPath!.row] as! DmDB
            
            
            detailView.chatterSeq(chatterSeqno: list.chatterSeqno!, chatterId:list.chatterId! )
            
        }
        
        
    }
    
    
    
    
    
    
    
}
