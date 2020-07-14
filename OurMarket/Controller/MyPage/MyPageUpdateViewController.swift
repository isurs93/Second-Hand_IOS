//
//  MyPageUpdateViewController.swift
//  OurMarket
//
//  Created by binybing on 30/03/2020.
//  Copyright © 2020 binybing. All rights reserved.
//

import UIKit

class MyPageUpdateViewController: UIViewController ,getUserInfoProtocol{
    
    @IBOutlet weak var txtTelno: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtPw: UITextField!
    @IBOutlet weak var txtId: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // setMyInfo()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        let updated = GetUserInfo()
        updated.delegate = self
        updated.getUpdatedMyInfo()
        
        setMyInfo()
    }
    
    
    @IBAction func btnUpdate(_ sender: UIButton) {
        updateMyInfo()
//        let updated = GetUserInfo()
//        updated.delegate = self
//        updated.getUpdatedMyInfo()
        
    }
    
    func setMyInfo(){
        txtId.text = user_info.user_Id
        txtId.isEnabled = false
        txtPw.text = user_info.user_Password
        txtName.text = user_info.user_Name
        txtEmail.text = user_info.user_Email
        txtTelno.text = user_info.user_Telno
    }
    
    func updateMyInfo(){
        print("updateMyInfo in MypageUpdata")
        
        let pw = txtPw.text!
        let name = txtName.text!
        let email = txtEmail.text!
        let telno = txtTelno.text!
        
        let updateMyInfo = UserInfoUpdate()
        updateMyInfo.updateUserInfo(seqno: String(user_info.user_Seqno!), pw: pw, name: name, tel: telno, email: email)
        
       self.dismiss(animated: true, completion: nil)
//        let updated = GetUserInfo()
//        updated.delegate = self
//        updated.getUpdatedMyInfo()
    }
    
    func userInfo(items: NSArray) {
        print("userInfo in MypageUpdata")
        let feedItem: UserInfoDB = items[0] as! UserInfoDB
        
        user_info.user_Seqno = feedItem.user_Seqno
        user_info.user_Id = feedItem.user_Id
        user_info.user_Password = feedItem.user_Password
        user_info.user_Telno = feedItem.user_Telno
        user_info.user_Email = feedItem.user_Email
        user_info.user_Name = feedItem.user_Name
    }
    
    
}
