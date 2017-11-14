//
//  OutlineDetailTableViewController.swift
//  Outlines
//
//  Created by Erick Sanchez on 11/13/17.
//  Copyright © 2017 Erick Sanchez. All rights reserved.
//

import UIKit
import CoreData

class OutlineDetailTableViewController: FetchedResultsTableViewController {
    
    var project: Project!
    
    var hierarchy: Hierarchy?
    
    // MARK: - RETURN VALUES
    
    // MARK: Table View Data Source
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let hierarchy = fetchedResultsController.hierarchy(at: indexPath)
        switch hierarchy.info! {
        case is Task:
            let task = hierarchy.info! as! Task
            cell.textLabel!.text = task.title
        case is Group:
            let group = hierarchy.info! as! Group
            cell.textLabel!.text = group.title
        default:
            break
        }
        
        return cell
    }
    
    // MARK: - VOID METHODS
    
    private func configureFetch() {
        let fetch: NSFetchRequest<Hierarchy> = Hierarchy.fetchRequest()
        if let currentHierarchy = hierarchy {
            fetch.predicate = NSPredicate(format: "project = %@ AND parent = %@", project, currentHierarchy)
        } else {
            fetch.predicate = NSPredicate(format: "project = %@ AND parent = nil", project)
        }
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
                let vc = segue.destination as! OutlineDetailTableViewController
                let row = fetchedResultsController.hierarchy(at: tableView.indexPath(for: sender as! UITableViewCell)!)
                vc.hierarchy = row
                vc.project = project // TODO : remove passing project to every view controller
            default:
                break
            }
        }
    }
    
    // MARK: - IBACTIONS
    
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
        
        saveHandler = AppDelegate.sharedInstance.saveContext
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.navigationItem.rightBarButtonItem = editButtonItem
    }

}
