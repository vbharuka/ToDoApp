//
//  ViewController.swift
//  ToDoApp
//
//  Created by Globallogic on 31/08/18.
//  Copyright © 2018 Globallogic. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    let itemArray = ["Shopping", "Studying", "Calling"]
    override func viewDidLoad() {
        super.viewDidLoad()
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
