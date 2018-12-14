//
//  CategoryViewController.swift
//  Todoey
//
//  Created by gayan perera on 12/14/18.
//  Copyright © 2018 gayan perera. All rights reserved.
//

import UIKit
import CoreData
class CategoryViewController: UITableViewController {
    
    // peivate varibales
    private var categoryItems = [Category]()
    private let userDefaults = UserDefaults.standard
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet var categoryList: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        LoadData()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryItems.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = categoryList.dequeueReusableCell(withIdentifier: "goceryTableCell") as! UITableViewCell
        cell.textLabel?.text = categoryItems[indexPath.row].name
        return cell;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "GoToTodoeyPage", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ViewController
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categoryItems[indexPath.row]
        }
    }
    @IBAction func AddButton(_ sender: Any) {
        var newItem = UITextField()
        let alert = UIAlertController(title: "Add New Item", message: " ", preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "Add", style: .default) { (alertAction) in
            let item = Category(context: self.context)
            item.name = newItem.text!
            self.categoryItems.append(item)
            self.SaveItems()
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Enter Item name"
            newItem = textField
        }
        alert.addAction(action)
        present(alert,animated:true,completion:nil)
    }
    
    func LoadData(find request:NSFetchRequest<Category> = Category.fetchRequest()) {
        do{
            categoryItems = try context.fetch(request)
        } catch{
            print("fectuting error \(error)")
        }
    }
    func SaveItems() {
        do {
            try context.save();
        }catch{
            print("save current datamodel to \(error)")
        }
        self.categoryList.reloadData()
        
    }
}
