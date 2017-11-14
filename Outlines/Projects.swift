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
    
    @discardableResult
    convenience init(title: String, `in` context: NSManagedObjectContext) {
        self.init(context: context)
        
        self.title = title
    }
}

extension NSFetchedResultsController {
    @objc func project(at indexPath: IndexPath) -> Project {
        return object(at: indexPath) as! Project
    }
}
