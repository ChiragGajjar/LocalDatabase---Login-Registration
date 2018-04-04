//
//  RegistrationVC.swift
//  LoginRegistrationDB
//
//  Created by apple on 2017-10-26.
//  Copyright © 2017 Doth Solutions. All rights reserved.
//

import UIKit

class RegistrationVC: UIViewController {

    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnRegister(_ sender: Any) {
        let dictParams: NSMutableDictionary? = ["username" : self.txtUsername.text ?? "","email" : self.txtEmail.text ?? "",
            "password" : txtPassword.text ?? ""
        ]
        if MyModel().InsertRecord(mdic: dictParams!){
            print("true")
            self.txtUsername.text = ""
            self.txtEmail.text = ""
            self.txtPassword.text = ""
            MyModel().ShowAlertMessage(strMessage:"Register successfully" as NSString, strTitle:"Information" as NSString, strView: self)
        }else{
            MyModel().ShowAlertMessage(strMessage:"Not register Register" as NSString, strTitle:"Information" as NSString, strView: self)
            print("false")
        }
    }
    
}
