//
//  ViewController.swift
//  Todoey
//
//  Created by gayan perera on 12/9/18.
//  Copyright © 2018 gayan perera. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    //outlets
    @IBOutlet weak var todoList: UITableView!
    
    //private properties
    private var todoeyItems:[Items] = [Items]()
    private let userDefaults = UserDefaults.standard
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //public properties
    
    
    //overrrde methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.todoList.register(UINib(nibName: "TodoTableViewCell", bundle: nil), forCellReuseIdentifier: "TodoTableViewCell")
        LoadData()
    }
    
    //outlet methosds
    @IBAction func AddnewItem(_ sender: Any) {
        var newItem = UITextField()
        let alert = UIAlertController(title: "Add New Item", message: " ", preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "Add", style: .default) { (alertAction) in
            let item = Items(context: self.context)
            item.item = newItem.text!
            item.done = false
            self.todoeyItems.append(item)
            self.SaveItems()
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
        SaveItems()
        tableView.reloadData()
    }
    func SaveItems() {
        do {
            try context.save();
        }catch{
            print("save current datamodel to \(error)")
        }
        self.todoList.reloadData()
    }
    
    func LoadData() {
        let request : NSFetchRequest<Items> = Items.fetchRequest()
        do{
            todoeyItems = try context.fetch(request)
        } catch{
            print("fectuting error \(error)")
        }
    }
}

