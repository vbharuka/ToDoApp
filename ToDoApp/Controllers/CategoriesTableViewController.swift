//
//  CategoriesTableViewController.swift
//  ToDoApp
//
//  Created by Globallogic on 01/09/18.
//  Copyright © 2018 Globallogic. All rights reserved.
//
import CoreData
import UIKit

class CategoriesTableViewController: UITableViewController {

    var categories = [Categories]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBAction func addButtonPressed(_ sender: Any) {
       
        var txtField = UITextField()
        
        let alert = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)
        
        let add = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newCategory = Categories(context: self.context)
            newCategory.name = txtField.text
            self.categories.append(newCategory)
            self.saveCategory()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            txtField = alertTextField
        }
        alert.addAction(add)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: View Controllers
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
    }
    
    // MARK: Table View Data Source Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoriesCell", for: indexPath)
        cell.textLabel?.text = categories[indexPath.row].name
        return cell
    }
    
    // MARK: Table View Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ToDoList", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categories[indexPath.row]
        }
    }
    
    // MARK: Data Manipulation Methods
    
    func saveCategory(){
        do{
            try context.save()
        }catch{
            print("Error while saving context \(error)")
        }
        
        tableView.reloadData()
    }
    
    
    func loadCategories(with request : NSFetchRequest<Categories> = Categories.fetchRequest()  ){
        do{
            categories = try context.fetch(request)
        }catch{
            print("Error while fetching context \(error)")
        }
        
        tableView.reloadData()
        
    }


}
