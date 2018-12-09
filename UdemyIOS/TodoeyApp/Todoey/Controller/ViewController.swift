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
    private let todoeyItems : [String] = ["Apple","mango","grapes","pinaapple",]
    //public properties
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.todoList.register(UINib(nibName: "TodoTableViewCell", bundle: nil), forCellReuseIdentifier: "TodoTableViewCell")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoeyItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TodoTableViewCell = todoList.dequeueReusableCell(withIdentifier: "TodoTableViewCell") as! TodoTableViewCell
        cell.textLabel?.text = todoeyItems[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
    }
    


}

