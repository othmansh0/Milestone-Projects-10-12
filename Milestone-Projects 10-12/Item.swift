//
//  Person.swift
//  Milestone-Projects 10-12
//
//  Created by othman shahrouri on 9/4/21.
//

import UIKit

class Item: NSObject,Codable {
    var name:String
    var caption:String
    
    init(name: String, caption: String) {
        self.name = name
        self.caption = caption
    }
}
