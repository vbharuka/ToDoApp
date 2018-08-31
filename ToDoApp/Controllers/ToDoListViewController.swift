//
//  ViewController.swift
//  ToDoApp
//
//  Created by Globallogic on 31/08/18.
//  Copyright © 2018 Globallogic. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    // MARK: Locating the document directory which will contain our plist
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    var itemArray = [Item]()

    @IBAction func addItemBtnPressed(_ sender: Any) {
        
        var textField = UITextField()
        
        
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            self.saveItem()
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
        loadItem()
    }
    
    // MARK: Table View delegate methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        // MARK: Toggle the done value of the item selected
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        saveItem()
        
        // MARK: To deselct the row once selected
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func saveItem(){
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        }catch{
            print("Error while encoding the data")
        }
        tableView.reloadData()
        
    }
    
    func loadItem(){
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do{
                itemArray = try! decoder.decode([Item].self, from: data)
            }catch{
                print("Error while decoding the application")
            }
        
        }
        
    }
}

