//
//  ProjectViewController.swift
//  Outlines
//
//  Created by Erick Sanchez on 11/13/17.
//  Copyright © 2017 Erick Sanchez. All rights reserved.
//

import UIKit
import CoreData

class ProjectViewController: FetchedResultsTableViewController {
    
    // MARK: - RETURN VALUES
    
    // MARK: Table View Data Source
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let project = fetchedResultsController.project(at: indexPath)
        cell.textLabel!.text = project.title
        
        return cell
    }
    
    // MARK: - VOID METHODS
    
    private func configureFetch() {
        let fetch: NSFetchRequest<Project> = Project.fetchRequest()
        fetch.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.localizedStandardCompare(_:)))]
        fetchedResultsController = NSFetchedResultsController<NSManagedObject>(
            fetchRequest: fetch as! NSFetchRequest<NSManagedObject>,
            managedObjectContext: AppDelegate.viewContext,
            sectionNameKeyPath: nil, cacheName: nil
        )
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "show project":
                let vc = segue.destination as! OutlineDetailTableViewController
                let project = fetchedResultsController.project(at: tableView.indexPath(for: sender as! UITableViewCell)!)
                vc.project = project
            default:
                break
            }
        }
    }
    
    // MARK: - IBACTIONS
    
    @IBAction func pressAdd(_ sender: Any) {
        let alertProject = UITextAlertController(title: "New Project", message: "enter a title")
        alertProject.addConfirmAction(action: UIAlertActionInfo(title: "Add", handler: { (action) in
            let title = alertProject.inputField.text!
            Project(title: title, in: AppDelegate.viewContext)
            AppDelegate.sharedInstance.saveContext()
        }))
        self.present(alertProject, animated: true)
    }
    // MARK: - LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureFetch()
        
        saveHandler = AppDelegate.sharedInstance.saveContext
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.navigationItem.rightBarButtonItem = editButtonItem
    }

}
