//
//  ViewController.swift
//  Todoey
//
//  Created by gayan perera on 12/9/18.
//  Copyright © 2018 gayan perera. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    //outlets
    @IBOutlet weak var todoList: UITableView!
    
    //private properties
    private var todoeyItems:[Items] = [Items]()
    private let userDefaults = UserDefaults.standard
    //public properties
    
    
    //overrrde methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.todoList.register(UINib(nibName: "TodoTableViewCell", bundle: nil), forCellReuseIdentifier: "TodoTableViewCell")
        
        let item1 = Items()
        item1.item = "Apple"
        todoeyItems.append(item1)
        
        let item2 = Items()
        item2.item = "Mango"
        todoeyItems.append(item2)

        let item3 = Items()
        item3.item = "Orange"
        todoeyItems.append(item3)

        let item4 = Items()
        item4.item = "pinapple"
        todoeyItems.append(item4)

        if  let list =  userDefaults.array(forKey: "todoeyItems") as? [Items] {
            todoeyItems = list
        }
        
    }
    
    //outlet methosds
    @IBAction func AddnewItem(_ sender: Any) {
        var newItem = UITextField()
        let alert = UIAlertController(title: "Add New Item", message: " ", preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "Add", style: .default) { (alertAction) in
            
            let item = Items()
            item.item = newItem.text!
            self.todoeyItems.append(item)
            self.userDefaults.set(self.todoeyItems, forKey: "todoeyItems")
            self.todoList.reloadData()
            
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Enter Item name"
            newItem = textField
        }
        alert.addAction(action)
        present(alert,animated:true,completion:nil)
    }
    
    
    //bublic and private methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoeyItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TodoTableViewCell = todoList.dequeueReusableCell(withIdentifier: "TodoTableViewCell") as! TodoTableViewCell
        cell.textLabel?.text = todoeyItems[indexPath.row].item
        cell.accessoryType = todoeyItems[indexPath.row].done ? .checkmark :.none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        todoeyItems[indexPath.row].done = !todoeyItems[indexPath.row].done
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()
    }
    
    
    
}

