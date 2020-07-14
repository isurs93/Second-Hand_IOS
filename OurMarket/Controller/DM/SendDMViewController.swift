//
//  SendDMViewController.swift
//  OurMarket
//
//  Created by binybing on 31/03/2020.
//  Copyright © 2020 binybing. All rights reserved.
//

import UIKit

class SendDMViewController: UIViewController {

 
    @IBOutlet weak var lblReceiverId: UILabel!
    
    @IBOutlet weak var lblTitle: UITextField!
    
    @IBOutlet weak var txtContent: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(boardUserSeqno!,"send dm view controller")
        // Do any additional setup after loading the view.
    
        lblReceiverId.text = "\(bId!)님께"
    }
    

    @IBAction func btnOk(_ sender: UIButton) {
       
    insert()
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func insert(){
        let title = lblTitle.text!
        let content = txtContent.text!
        let sendMessage = DMSendMessage()
        if sendMessage.sendMessage(title: title, content: content,chatter:boardUserSeqno!){//insert 성공!
            
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
