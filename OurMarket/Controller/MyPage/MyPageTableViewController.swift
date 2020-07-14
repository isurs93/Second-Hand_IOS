//
//  MyPageTableViewController.swift
//  OurMarket
//
//  Created by binybing on 08/04/2020.
//  Copyright © 2020 binybing. All rights reserved.
//

import UIKit

class MyPageTableViewController: UITableViewController,myPageTotal,cntFav,selectMyFav {
    
    
    var countFav = [countFavDB]()
    var boardDB = [BoardDB]()
    var myPageList : NSArray = NSArray()
    
    @IBOutlet var tableViewList: UITableView!
    
    
    var cnt = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view did load")
        tableViewList.rowHeight = 160
        // getMyPageData()
        
        
        self.navigationItem.title = "\(user_info.user_Id!)"
        
    }
    
    func getMyPageData(){
        let myPage = MyPage()
        myPage.delegate = self
        myPage.downloadItems()
        
        let cntFav = CountFav()
        cntFav.delegate = self
        cntFav.downloadItems()
        
        let selectMyFav = LikesSQL()
        selectMyFav.delegate = self
        selectMyFav.selectMyLikes()
    }
    // MARK: - Table view data source
    
    override func viewWillAppear(_ animated: Bool) {
        print("view will appear")
        getMyPageData()
        self.tableViewList.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return boardDB.count
    }
    
    func itemDownloaded(items: NSArray) {
        boardDB.removeAll()
        myPageList = items
        
        for i in 0 ..< myPageList.count{
            let data = myPageList[i] as! BoardDB
            boardDB.append(data)
        }
        
        
        self.tableViewList.reloadData()
    }
    
    func cntFav(items: NSArray) {
        for index in 0 ..< items.count{
            let data : countFavDB = items[index] as! countFavDB
            print(data.bSeqno!,data.cnt!,"cntFav in MYPAGE controller")
            countFav.append(data)
        }
    }
    
    func selectMyFav(items: NSArray) {
        myFavList.removeAll()
        for index in 0..<items.count{
            let data: MyFavBoardSeqnoDB = items[index] as! MyFavBoardSeqnoDB
            myFavList.append(data)
        }
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myPageCell", for: indexPath) as! MyPageTableViewCell
        
        let data = myPageList[indexPath.row] as! BoardDB
        let requestURL = loadWebPage(url: "\(data.board_StrImage!)")
        
        cell.webView.load(requestURL)
        cell.webView.sizeToFit()
        cell.lblTitle.text = "\( data.board_Title!)"
        cell.lblPrice.text="\(data.board_Price!)"
        cell.lblTitle.textAlignment = .right
        cell.lblPrice.textAlignment = .right
        // print(myFavList.count,"myFavList count in myPage controller ", countFav.count)
        var btnFavString = "like_unselected"
        for i in 0 ..< myFavList.count{
            if  myFavList[i].myFavBoardSeqno == data.board_Seqno{
                btnFavString = "like_selected"
                // print(myFavList[i].myFavBoardSeqno! , list.board_Seqno!,"my fav compare")
                break
            }
        }
        
        var cntFavInt = 0
        for i in 0 ..< countFav.count{
            
            if countFav[i].bSeqno == data.board_Seqno{
                cntFavInt = countFav[i].cnt!
            }
        }
        
        cell.cntFav.text="\(cntFavInt)"
        
        cell.btnFav.setImage(UIImage(named: btnFavString), for: UIControl.State.normal)
        cell.cntHit.text = "\(data.board_hit!)"
        
        
        
        if data.board_isDone == 1{
            cell.imageDealComplete.image = UIImage(named: "dealComplete")
            cell.webView.tintColor = .gray
            
        }
        
        // Configure the cell...
        
        return cell
    }
    //webView
    func loadWebPage(url:String)->URLRequest{
        let myUrl = URL(string: url)
        //print(myUrl!,"loadWebPage")
        let myRequest = URLRequest(url: myUrl!)
        // print(myRequest)
        
        return myRequest
        
    }
    
    
    //swipe
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        print("swipe action start! ", indexPath,indexPath.row,self.boardDB[indexPath.row].board_Seqno!,self.boardDB[indexPath.row].board_Title!)
        
        let bSeqno = self.boardDB[indexPath.row].board_Seqno
        
        let done = UIContextualAction(style: .normal, title: "Done"){ action, view, completion in
            
            
            self.isDone(bSeqno: bSeqno!)
            //도장쾅!!! 해야함
            self.tableViewList.reloadData()
            
            completion(true)
        }
        
        let delete = UIContextualAction(style: .destructive, title: "Delete"){
            action, view, completion in
            
            self.deleteMyBoard(bSeqno: bSeqno!)
            self.boardDB.remove(at: (indexPath as NSIndexPath).row)
            self.tableViewList.reloadData()
            completion(true)
        }
        
        
        return UISwipeActionsConfiguration(actions: [delete, done])
    }
    
    func deleteMyBoard(bSeqno:Int){
        print("delete date clicked ")
        let insertDeleteDate = BoardInsert()
        insertDeleteDate.insertDeleteDate(bSeqno: bSeqno)
    }
    
    func isDone(bSeqno:Int){
        print("delete date clicked ")
        let insertIsDone = BoardInsert()
        insertIsDone.insertIsDone(bSeqno: bSeqno)
        
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
        if segue.identifier == "myPageToDetail"{
            let cell = sender as! UITableViewCell
            let indexPath = self.tableViewList.indexPath(for: cell) //몇번째 cell 선택인지 알아내기
            let detailView = segue.destination as!  MyBoardDetailViewController
            
            list = myPageList[indexPath!.row] as! BoardDB
            
            for i in 0 ..< myFavList.count{
                if  myFavList[i].myFavBoardSeqno == list.board_Seqno{
                    cnt = 1
                   
                    break
                }
                
            }
            
            let boardInsert = BoardInsert()
            boardInsert.updateBoardHit(bSeqno: list.board_Seqno!)
            
            detailView.getData(list: list,cnt:cnt)
            
            //                detailView.detail(title: list.board_Title!, content: list.board_Content!, price: list.board_Price!, id: list.user_Id!, bSeqno: list.board_Seqno!, uSeqno: list.board_uSeqno!, cnt: cnt, urlImage: list.board_StrImage!,addr:list.board_Sido!)
            
        }
    }
    
}
