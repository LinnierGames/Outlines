//
//  Tasks.swift
//  Outlines
//
//  Created by Erick Sanchez on 11/13/17.
//  Copyright © 2017 Erick Sanchez. All rights reserved.
//

import Foundation
import CoreData

extension Task {
    
}

extension Hierarchy {
    var task: Task {
        return self.info! as! Task
    }
}
