

import UIKit
import RealmSwift

class CategoryViewController: SwapTableViewController {
    
    // peivate varibales
    private var categoryItems:Results<Category>?
    private let userDefaults = UserDefaults.standard
    private let relam = try! Realm()
    @IBOutlet var categoryList: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        LoadData()
        
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        cell.textLabel?.text = categoryItems?[indexPath.row].name ?? "there are no goceries"
        return cell;
    }
   
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "GoToTodoeyPage", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ViewController
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categoryItems?[indexPath.row]
        }
    }
    
    override func UpdateModel(Indexpath: IndexPath) {
        if let category = self.categoryItems?[Indexpath.row] {
            do{
                try self.relam.write {
                    self.relam.delete(category)
                    //     tableView.reloadData()
                }
            }
            catch{
                print("remove data from relam \(error)")
            }
        }
    }
    
    @IBAction func AddButton(_ sender: Any) {
        var newItem = UITextField()
        let alert = UIAlertController(title: "Add New Item", message: " ", preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "Add", style: .default) { (alertAction) in
            let item = Category()
            item.name = newItem.text!
            self.SaveItems(catergory: item)
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Enter Item name"
            newItem = textField
        }
        alert.addAction(action)
        present(alert,animated:true,completion:nil)
    }
    
    func LoadData() {
        categoryItems = relam.objects(Category.self)
    }
    
    func SaveItems(catergory:Category) {
        do {
            try relam.write {
                relam.add(catergory)
            }
        }catch{
            print("save current datamodel to \(error)")
        }
        self.categoryList.reloadData()
        
    }
}
