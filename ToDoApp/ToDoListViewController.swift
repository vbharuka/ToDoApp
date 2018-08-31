//
//  ViewController.swift
//  ToDoApp
//
//  Created by Globallogic on 31/08/18.
//  Copyright © 2018 Globallogic. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    // MARK: UserDefault object created
    let defaults = UserDefaults.standard
    
    var itemArray = ["Shopping", "Studying", "Calling"]

    @IBAction func addItemBtnPressed(_ sender: Any) {
        
        var textField = UITextField()
        
        
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            self.itemArray.append(textField.text!)
            // MARK: Saving the data into defaults
            self.defaults.set(self.itemArray, forKey: "ToDoArray")
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: Retrieving the data from user defaults
        if let saveArray = defaults.array(forKey: "ToDoArray") {
            itemArray = saveArray as! [String]
        }
    }
    
    // MARK: Table View delegate methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        // MARK: Add checkmark when row is selected
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark

        }
        
        
        // MARK: To deselct the row once selected
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

