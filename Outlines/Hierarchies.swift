//
//  Hierarchies.swift
//  Outlines
//
//  Created by Erick Sanchez on 11/13/17.
//  Copyright © 2017 Erick Sanchez. All rights reserved.
//

import Foundation
import CoreData

extension Hierarchy {
    
    @discardableResult
    convenience init(info: HierarchyInfo, parent: Hierarchy?, `in` context: NSManagedObjectContext) {
        self.init(context: context)
        
        self.info = info
        self.parent = parent
    }
}

extension HierarchyInfo {
    
    @discardableResult
    convenience init(title: String = "Untitled", parent: Hierarchy?, `in` context: NSManagedObjectContext) {
        self.init(context: context)
        
        self.title = title
        
        Hierarchy(info: self, parent: parent, in: context)
    }
}
