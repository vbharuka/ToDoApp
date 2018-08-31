//
//  Item.swift
//  ToDoApp
//
//  Created by Globallogic on 31/08/18.
//  Copyright © 2018 Globallogic. All rights reserved.
//

import Foundation

// Codable enclosed both encoder and decoder classes
class Item: Codable{
    var title : String = ""
    var done : Bool = false
}
