//
//  Groups.swift
//  Outlines
//
//  Created by Erick Sanchez on 11/13/17.
//  Copyright © 2017 Erick Sanchez. All rights reserved.
//

import Foundation
import CoreData

extension Group {
    
}

extension Hierarchy {
    var group: Group {
        return self.info! as! Group
    }
}
