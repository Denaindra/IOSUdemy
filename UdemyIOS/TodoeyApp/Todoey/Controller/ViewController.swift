//
//  ViewController.swift
//  Todoey
//
//  Created by gayan perera on 12/9/18.
//  Copyright © 2018 gayan perera. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    //outlets
    @IBOutlet weak var todoList: UITableView!
    
    //private properties
    private var todoeyItems:Results<Item>?
    private let userDefaults = UserDefaults.standard
    private var relam = try! Realm()
    
    //public properties
    var selectedCategory : Category? {
        didSet{
            LoadData()
        }
    }
    //overrrde methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.todoList.register(UINib(nibName: "TodoTableViewCell", bundle: nil), forCellReuseIdentifier: "TodoTableViewCell")
    }
    
    //outlet methosds
    @IBAction func AddnewItem(_ sender: Any) {
        var newItem = UITextField()
        let alert = UIAlertController(title: "Add New Item", message: " ", preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "Add", style: .default) { (alertAction) in
            
            if let selectedCategory = self.selectedCategory {
                do {
                    try self.relam.write {
                        let item = Item()
                        item.item = newItem.text!
                        selectedCategory.items.append(item);
                    }
                }catch{
                    print("erro occor \(error)")
                }
            }
            self.todoList.reloadData()
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Enter Item name"
            newItem = textField
        }
        alert.addAction(action)
        present(alert,animated:true,completion:nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoeyItems?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TodoTableViewCell = todoList.dequeueReusableCell(withIdentifier: "TodoTableViewCell") as! TodoTableViewCell
        
        if let item = todoeyItems?[indexPath.row] {
            cell.textLabel?.text = item.item
            cell.accessoryType = item.done ? .checkmark :.none
        }else {
            cell.textLabel?.text = "There are no categories"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let selectedItem = todoeyItems?[indexPath.row]
        {
            do{
                try relam.write {
                    relam.delete(selectedItem)
                   // selectedItem.done = !selectedItem.done
                }
            }catch{
                print("Selected item error \(error) ")
            }
        }
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func LoadData() {
        do{
            todoeyItems = selectedCategory?.items.sorted(byKeyPath: "item", ascending: true)
        } catch{
            print("fectuting error \(error)")
        }
    }
}

extension ViewController:UISearchBarDelegate {
    
    //    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    //        let request : NSFetchRequest<Items> = Items.fetchRequest()
    //        request.predicate = NSPredicate(format: "item CONTAINS[cd] %@", searchBar.text!)
    //        request.sortDescriptors = [NSSortDescriptor(key: "item", ascending: true)]
    //        print(searchBar.text!)
    //        LoadData(find:request)
    //        self.todoList.reloadData()
    //    }
    //
    //    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    //        if searchBar.text?.count == 0 {
    //            LoadData()
    //            DispatchQueue.main.async {
    //                searchBar.resignFirstResponder()
    //            }
    //        }
    //    }
}
