//
//  LoginVC.swift
//  LoginRegistrationDB
//
//  Created by apple on 2017-10-26.
//  Copyright © 2017 Doth Solutions. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnLogin(_ sender: Any) {
        if (self.txtUsername.text=="") {
             MyModel().ShowAlertMessage(strMessage:"Blank username" as NSString, strTitle:"Information" as NSString, strView: self)
        }else if (self.txtPassword.text==""){
            MyModel().ShowAlertMessage(strMessage:"Blank Password" as NSString, strTitle:"Information" as NSString, strView: self)
        }else{
       
            var result:NSMutableDictionary
        
            let dictParams: NSMutableDictionary? = ["email" : self.txtUsername.text! , "password" : self.txtPassword.text! ]
            result = MyModel().getAllStudentData(mdicData: dictParams!)
            
            let success:String = result.value(forKey: "success") as! String
            
            print("result = \(result)")
            if success == "true"{
                let next = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
                self.navigationController?.pushViewController(next, animated: true)
            }else{
                MyModel().ShowAlertMessage(strMessage:"wrong or not exit email" as NSString, strTitle:"Information" as NSString, strView: self)
            }
        }
    }
    @IBAction func btnRegister(_ sender: Any) {
        let next = self.storyboard?.instantiateViewController(withIdentifier: "RegistrationVC") as! RegistrationVC
        self.navigationController?.pushViewController(next, animated: true)
    }
}
