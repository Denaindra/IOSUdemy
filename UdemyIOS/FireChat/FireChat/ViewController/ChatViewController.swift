//
//  ChatViewController.swift
//  FireChat
//
//  Created by gayan perera on 11/27/18.
//  Copyright © 2018 gayan perera. All rights reserved.
//

import UIKit
import Firebase


class ChatViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var chatTableView: UITableView!
    private let animals: [String] = ["Horse", "Cow", "Camel", "Sheep", "Goat"]

    override func viewDidLoad() {
        super.viewDidLoad()

       let textFeildCell = UINib(nibName: "ChatTableViewCell", bundle: nil)
        self.chatTableView.register(textFeildCell, forCellReuseIdentifier: "CustomViewCell")

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
        cell.senderName.text = animals[indexPath.row]
        return cell
    }
    
    
}
