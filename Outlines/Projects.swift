//
//  Projects.swift
//  Outlines
//
//  Created by Erick Sanchez on 11/13/17.
//  Copyright © 2017 Erick Sanchez. All rights reserved.
//

import Foundation
import CoreData

extension Project {
    convenience init(title: String, `in` context: NSManagedObjectContext) {
        self.init(context: context)
        
        self.title = title
    }
}
