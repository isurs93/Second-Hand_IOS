    //
    //  FavTableViewController.swift
    //  OurMarket
    //
    //  Created by binybing on 05/04/2020.
    //  Copyright © 2020 binybing. All rights reserved.
    //

    import UIKit

    class FavTableViewController: UITableViewController,FavList,cntFav {
      
        var countFav = [countFavDB]()
        var favList : NSArray = NSArray()
        
        @IBOutlet var tableListView: UITableView!
        override func viewDidLoad() {
            super.viewDidLoad()
            tableListView.rowHeight = 160
            getFavData()
            // Uncomment the following line to preserve selection between presentations
            // self.clearsSelectionOnViewWillAppear = false
            
            // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
            // self.navigationItem.rightBarButtonItem = self.editButtonItem
        }
        
        override func viewWillAppear(_ animated: Bool) {
            getFavData()
            
            self.tableListView.reloadData()
        }
        
        
        func getFavData(){
            let fav = BoardFav()
            fav.delegate = self
            fav.downloadItems()
            
            let cntFav = CountFav()
                   cntFav.delegate = self
                   cntFav.downloadItems()
        }
        // MARK: - Table view data source
        
        override func numberOfSections(in tableView: UITableView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            return 1
        }
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of rows
            return favList.count
        }
        
        //protocol
        func favListloaded(items: NSArray) {
            favList = items
            self.tableListView.reloadData()
        }
        
        func cntFav(items: NSArray) {
                for index in 0 ..< items.count{
                        let data : countFavDB = items[index] as! countFavDB
                        countFav.append(data)
                    }
          }
        
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "favCell", for: indexPath) as! FavTableViewCell
            
            let data = favList[indexPath.row] as! BoardDB
            let requestURL = loadWebPage(url: "\(data.board_StrImage!)")
            cell.webView.load(requestURL)
            cell.webView.sizeToFit()
            cell.lblTitle.text = "\( data.board_Title!)"
            cell.lblPrice.text="\(data.board_Price!)"
            cell.lblTitle.textAlignment = .right
                  cell.lblPrice.textAlignment = .right
        
            
            cell.btnFav.setImage(UIImage(named: "like_selected"), for: UIControl.State.normal)
            cell.lblHit.text = "\(data.board_hit!)"
            
            var cntFavInt = 0
                   for i in 0 ..< countFav.count{
                       if countFav[i].bSeqno == data.board_Seqno{
                           cntFavInt = countFav[i].cnt!
                       }
                   }
            cell.lblFav.text = "\(cntFavInt)"
            
            
            if data.board_isDone == 1{
                            cell.imageDealComplete.image = UIImage(named: "dealComplete")
                        cell.webView.tintColor = .gray
               
                        }
            
            
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
            
            if segue.identifier == "favDetail"{
                let cell = sender as! UITableViewCell
                let indexPath = self.tableListView.indexPath(for: cell) //몇번째 cell 선택인지 알아내기
                let detailView = segue.destination as!  FavDetailViewController
                
                list = favList[indexPath!.row] as! BoardDB
                
                detailView.detail(title: list.board_Title!, content: list.board_Content!, price: list.board_Price!, id: list.user_Id!, bSeqno: list.board_Seqno!, uSeqno: list.board_uSeqno!, cnt: 1, urlImage: list.board_StrImage!,addr:list.board_Sido!)
                
            }
            
            
            
        }
        
        
    }
