//
//  ChatViewController.swift
//  FireChat
//
//  Created by gayan perera on 11/27/18.
//  Copyright © 2018 gayan perera. All rights reserved.
//

import UIKit
import Firebase


class ChatViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
    
    @IBOutlet weak var chatViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var chatTableView: UITableView!
    private let animals: [String] = ["Horse", "Set the estimatedRowHeight or implement the height estimation delegate method. ... “Our table view cells have to resize (gulp!) dynamically! ... Make sure Also create XIB file is unchecked and that the language is set to Swift. ... Make sure Also create XIB file is unchecked and that the language is set to Swift.... Make sure Also create XIB file is unchecked and that the language is set to Swift.", "Camel", "Sheep", "Goat"]

    
    @IBOutlet weak var chatBtn: UIButton!
    @IBOutlet weak var chatTextFeild: UITextField!
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self,selector: #selector(keyboardWillShow),name: UIResponder.keyboardWillShowNotification,object:nil)
        
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(Viewtapped))
        view.addGestureRecognizer(tapgesture)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

       let textFeildCell = UINib(nibName: "ChatTableViewCell", bundle: nil)
        self.chatTableView.register(textFeildCell, forCellReuseIdentifier: "CustomViewCell")
        
        chatTableView.rowHeight = UITableView.automaticDimension
        chatTableView.estimatedRowHeight = 10
        
    }
    
    @IBAction func UserLoguot(_ sender: UIBarButtonItem) {
        do{
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        }
        catch{
            print("erro")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return animals.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:ChatTableViewCell = chatTableView.dequeueReusableCell(withIdentifier: "CustomViewCell") as! ChatTableViewCell
        cell.senderMessage.text = animals[indexPath.row]
        
        return cell
    }
  
     func textFieldDidEndEditing(_ textField: UITextField) {
        view.endEditing(true)
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        UIView.animate(withDuration: 0.1)
        {
            self.chatViewBottomConstraint.constant = 271;
            self.view.layoutIfNeeded()
        }
        
    }
    
   @objc func Viewtapped (){
        view.endEditing(true)
    UIView.animate(withDuration: 0.1)
    {
        self.chatViewBottomConstraint.constant = 0;
        self.view.layoutIfNeeded()
    }
    }
    
    
    
    @objc func keyboardWillShow(notification: Notification) {
        let userInfo:NSDictionary = notification.userInfo! as NSDictionary
        let keyboardFrame:NSValue = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
        let keyboardHeight = keyboardFrame.cgRectValue.height
        // do whatever you want with this keyboard height
    }
}
