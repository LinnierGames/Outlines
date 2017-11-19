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
    convenience init(info: HierarchyInfo, project: Project, parent: Hierarchy?, `in` context: NSManagedObjectContext) {
        self.init(context: context)
        
        self.info = info
        self.parent = parent
        self.project = project
    }
}

extension NSFetchedResultsController {
    @objc func hierarchy(at indexPath: IndexPath) -> Hierarchy {
        return object(at: indexPath) as! Hierarchy
    }
}

extension HierarchyInfo {
    
    @discardableResult
    convenience init(title: String = "Untitled", project: Project, parent: Hierarchy?, `in` context: NSManagedObjectContext) {
        self.init(context: context)
        
        self.title = title
        
        Hierarchy(info: self, project: project, parent: parent, in: context)
    }
    
    var children: [HierarchyInfo]? {
        let localizedStandardSort = NSSortDescriptor(key: "info.title", ascending: true)
        if let hierarchies = hierarchy!.children?.sortedArray(using: [localizedStandardSort]) as! [Hierarchy]? {
            let hierarchyInfos = hierarchies.map({ (hierarchy) -> HierarchyInfo in
                return hierarchy.info!
            })
            
            return hierarchyInfos
        } else {
            return nil
        }
    }
    
    var depthLevel: Int {
        var level = 0
        var currentLevel = self.hierarchy
        while (currentLevel != nil) {
            currentLevel = currentLevel!.parent
            level += 1
        }
        
        return level
    }
}
