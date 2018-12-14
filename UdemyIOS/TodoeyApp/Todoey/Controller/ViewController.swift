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
        
//        context.delete(todoeyItems[indexPath.row])
//        todoeyItems.remove(at: indexPath.row)
        todoeyItems[indexPath.row].done = !todoeyItems[indexPath.row].done
        SaveItems()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func SaveItems() {
        do {
            try context.save();
        }catch{
            print("save current datamodel to \(error)")
        }
        self.todoList.reloadData()
    }
    
    func LoadData(find request:NSFetchRequest<Items> = Items.fetchRequest()) {
     
        do{
            todoeyItems = try context.fetch(request)
        } catch{
            print("fectuting error \(error)")
        }
    }
}

extension ViewController:UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Items> = Items.fetchRequest()
        request.predicate = NSPredicate(format: "item CONTAINS[cd] %@", searchBar.text!)
        request.sortDescriptors = [NSSortDescriptor(key: "item", ascending: true)]
        print(searchBar.text!)
        LoadData(find:request)
        self.todoList.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            LoadData()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}
