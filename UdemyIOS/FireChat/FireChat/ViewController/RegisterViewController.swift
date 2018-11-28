//
//  RegisterViewController.swift
//  FireChat
//
//  Created by gayan perera on 11/27/18.
//  Copyright © 2018 gayan perera. All rights reserved.
//

import UIKit
import Firebase;


class RegisterViewController: UIViewController {

    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func RegisterClick(_ sender: Any) {
        
        
        Auth.auth().createUser(withEmail: userNameField.text!, password:passwordField.text!) { (authResult,erro) in

            if erro != nil {
               // print (erro)
            }
            else {
                self.performSegue(withIdentifier: "registerTofireChat", sender: self)
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
