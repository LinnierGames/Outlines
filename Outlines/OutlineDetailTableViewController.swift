//
//  OutlineDetailTableViewController.swift
//  Outlines
//
//  Created by Erick Sanchez on 11/13/17.
//  Copyright © 2017 Erick Sanchez. All rights reserved.
//

import UIKit
import CoreData

class OutlineDetailTableViewController: FetchedResultsTableViewController, UITextFieldDelegate {
    
    var project: Project!
    
    var hierarchy: Hierarchy?
    
    // MARK: - RETURN VALUES
    
    private var tableInfo: [Group]? {
        var hierarichalGroups = [Group]()
        if let topGroupHierarchies = fetchedResultsController.fetchedObjects as! [Hierarchy]? {
            for hierarchy in topGroupHierarchies {
                let group = hierarchy.group
                hierarichalGroups += group.flatMap
            }
        }
        
        return hierarichalGroups
    }
    
    // MARK: Table View Data Source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableInfo?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int {
        let row = tableInfo![indexPath.row]
        
        return row.depthLevel
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        
        let group = tableInfo![indexPath.row]
        switch group {
        case is Task:
            let task = group as! Task
            cell.textFieldDoubleTap.text = task.title
        default:
            cell.textFieldDoubleTap.text = group.title
        }
        
        cell.textFieldDoubleTap.delegate = self
        
        return cell
    }
    
    // MARK: - VOID METHODS
    
    private func configureFetch() {
        let fetch: NSFetchRequest<Hierarchy> = Hierarchy.fetchRequest()
        fetch.predicate = NSPredicate(format: "project = %@ AND parent = nil", project)
        fetch.sortDescriptors = [NSSortDescriptor(key: "info.title", ascending: true, selector: #selector(NSString.localizedStandardCompare(_:)))]
        fetchedResultsController = NSFetchedResultsController<NSManagedObject>(
            fetchRequest: fetch as! NSFetchRequest<NSManagedObject>,
            managedObjectContext: AppDelegate.viewContext,
            sectionNameKeyPath: nil, cacheName: nil
        )
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "show":
                break
            default:
                break
            }
        }
    }
    
    // MARK: - IBACTION
    
    @IBAction func pressAdd(_ sender: Any) {
        let alertGroup = UITextAlertController(title: "New Group", message: "enter a title")
        alertGroup.addConfirmAction(action: UIAlertActionInfo(title: "Add", handler: { [weak self] (action) in
            let title = alertGroup.inputField.text!
            Group(title: title, project: self!.project, parent: self!.hierarchy, in: AppDelegate.viewContext)
            AppDelegate.sharedInstance.saveContext()
        }))
        self.present(alertGroup, animated: true)
    }
    
    // MARK: - LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureFetch()
        
        self.title = hierarchy?.info!.title ?? project.title
        self.navigationItem.rightBarButtonItem = editButtonItem
        self.tableView.estimatedRowHeight = 44
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        saveHandler = AppDelegate.sharedInstance.saveContext
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

}
