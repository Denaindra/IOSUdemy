//
//  LoginViewController.swift
//  FireChat
//
//  Created by gayan perera on 11/27/18.
//  Copyright © 2018 gayan perera. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD
class LoginViewController: UIViewController {
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passWrdFeild: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func LoginClick(_ sender: Any) {
        
        
        SVProgressHUD.show();
        Auth.auth().signIn(withEmail: userNameField.text!, password: passWrdFeild.text!) { (loginResponse, erro) in
            if erro != nil {
                print (erro!)
            }
            else {
                SVProgressHUD.dismiss()
                self.performSegue(withIdentifier: "logingToChat", sender: self)
            }
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
