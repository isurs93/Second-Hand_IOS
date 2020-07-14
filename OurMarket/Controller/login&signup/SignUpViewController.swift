//
//  SignUpViewController.swift
//  OurMarket
//
//  Created by binybing on 28/03/2020.
//  Copyright © 2020 binybing. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var txtPwCheck: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtTel: UITextField!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtPw: UITextField!
    @IBOutlet weak var txtId: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btnSignUp(_ sender: UIButton) {
        
        getUserInfo()
        
    }
    
    func getUserInfo(){
        
        let id = txtId.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let pw = txtPw.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let pwCheck = txtPwCheck.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let name = txtName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let tel = txtTel.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let email = txtEmail.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if checkPw(pw1: pw, pw2: pwCheck){ // 비번1,2 가 동일하면,,
            
            let signUpSql = SignUpSQL()
            if signUpSql.insertUserInfo(id: id, pw: pw, name: name, tel: tel, email: email){
                let alert = UIAlertController(title: "Alert", message: "data inserted", preferredStyle: UIAlertController.Style.alert)
                let alertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(alertAction)
                self.present(alert, animated: true, completion: nil)
                
            }else{
                let alert = UIAlertController(title: "Alert", message: "failed to insert data", preferredStyle: UIAlertController.Style.alert)
                let alertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(alertAction)
                self.present(alert, animated: true, completion: nil)
                
            }
            
        }else{
            let alert = UIAlertController(title: "Alert", message: "please check your password", preferredStyle: UIAlertController.Style.alert)
            let alertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(alertAction)
            self.present(alert, animated: true, completion: nil)
        }
        
        
    }
    
    func checkPw(pw1:String?,pw2:String?)->Bool{
        if pw1 != pw2 {
            return false
        }
        return true
    }
    
    
    @IBAction func btnBackToLogin(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
