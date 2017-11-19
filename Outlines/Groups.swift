//
//  Groups.swift
//  Outlines
//
//  Created by Erick Sanchez on 11/13/17.
//  Copyright © 2017 Erick Sanchez. All rights reserved.
//

import Foundation
import CoreData
//[a,b]
//- a
// - a.a
//  - a.a.a
//  - a.a.b
// - a.b
// - a.c
//- b
//
//a,
//a.a,
//a.a.a,
//a.a.b,
//a.b,
//a.c,
//b

extension Group {
    
    /**
     If the list contains a child, return true
     
     If count of children is zero or the list is nil, this will return nil.
     Otherwise, if the list is not empty, return true
     */
    var hasChildren: Bool {
        if children != nil {
            return children!.count != 0
        } else {
            return false
        }
    }
    
    /**
     If the list contains a task, return true
     
     If count of children is zero or the list is nil, this will return nil.
     Otherwise, if the list is not empty, check if the first child is `Task`
     */
    var hasTasks: Bool? {
        if let childrens = children {
            if let firstChild = childrens.first {
                return firstChild is Task
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    var flatMap: [Group] {
        func aux(currentGroup: Group) -> [Group] {
            var list = [Group]()
            
            list.insert(currentGroup, at: 0)
            if currentGroup.hasChildren {
                let children = currentGroup.children! as! [Group]
                for child in children {
                    list += aux(currentGroup: child)
                }
            }
            
            return list
        }
        
        return aux(currentGroup: self)
    }
}

extension Hierarchy {
    var group: Group {
        return self.info! as! Group
    }
}
