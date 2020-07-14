//
//  ViewController.swift
//  OurMarket
//
//  Created by binybing on 28/03/2020.
//  Copyright © 2020 binybing. All rights reserved.
//

import UIKit
// IP ADDRESS
let coreIP = "http://localhost:8080/market/"
var user_Seqno : Int? = -1
var user_info = UserInfoDB()
class LoginViewController: UIViewController, LoginCheckProtocol, getUserInfoProtocol{
    
    var insert_Id = ""
    var insert_Pw = ""
    
    func userInfo(items: NSArray) {
        
        let feedItem: UserInfoDB = items[0] as! UserInfoDB
        
        user_info.user_Seqno = feedItem.user_Seqno
        user_info.user_Id = feedItem.user_Id
        user_info.user_Password = feedItem.user_Password
        user_info.user_Telno = feedItem.user_Telno
        user_info.user_Email = feedItem.user_Email
        user_info.user_Name = feedItem.user_Name
        

        let alert = UIAlertController(title: "로그인 성공", message: "환영합니다", preferredStyle: UIAlertController.Style.alert)
        let alertAction = UIAlertAction(title: "네", style: UIAlertAction.Style.default, handler: {ACTION in
            self.dismiss(animated: true, completion: nil)
        })

        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
        
        print(user_Seqno!)
    }
    
    
    
    func loginCheckResult(loginResult: Int) {
        print(loginResult , "login view controlller")
        if loginResult == -1{
            let alert = UIAlertController(title: "로그인 실패", message: "정보를 확인해주세요", preferredStyle: UIAlertController.Style.alert)
            let alertAction = UIAlertAction(title: "네", style: UIAlertAction.Style.default, handler: nil)
            
            alert.addAction(alertAction)
            present(alert, animated: true, completion: nil)
            
        }else if loginResult != -1{
            
            user_Seqno = loginResult
            
            //psj
//            let alert = UIAlertController(title: "로그인 성공", message: "환영합니다", preferredStyle: UIAlertController.Style.alert)
//            let alertAction = UIAlertAction(title: "네", style: UIAlertAction.Style.default, handler: {ACTION in
//                self.dismiss(animated: true, completion: nil)
//            })
//
//
//            alert.addAction(alertAction)
//            present(alert, animated: true, completion: nil)
            
            // psj
            let userInfo = GetUserInfo()
            userInfo.delegate = self
            userInfo.loginCheck(id: insert_Id, pw: insert_Pw)
        }
    }
    
    
    @IBOutlet weak var txtPw: UITextField!
    @IBOutlet weak var txtId: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btnLogin(_ sender: UIButton) {
        login()
    }
    @IBAction func btnSignUp(_ sender: UIButton) {
        
        
    }
    
    func login(){
        let id = txtId.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let pw = txtPw.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // psj
        insert_Id = txtId.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        insert_Pw = txtPw.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let loginSQL = LoginSQL()
        loginSQL.delegate = self
        loginSQL.loginCheck(id: id, pw: pw)
        
//        let userInfo = GetUserInfo()
//        userInfo.delegate = self
//        userInfo.loginCheck(id: id, pw: pw)
        
    }
    
    func movePage(){
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let secondViewController = storyboard.instantiateViewController(withIdentifier: "HomeVC") as UIViewController
        navigationController?.pushViewController(secondViewController, animated: true)
    }
    
}

