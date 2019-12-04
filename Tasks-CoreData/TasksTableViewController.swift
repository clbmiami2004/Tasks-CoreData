//
//  TasksTableViewController.swift
//  Tasks-CoreData
//
//  Created by Lambda_School_Loaner_201 on 12/3/19.
//  Copyright © 2019 Christian Lorenzo. All rights reserved.
//

import UIKit
import CoreData

class TasksTableViewController: UITableViewController {
    
    //This is absurdly inefficient!!!
    //The fetch reuest will be executed every time we access Tasks!
    //We will fix this in a future class
    private var tasks: [Task] {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        let moc = CoreDataStack.shared.mainContext
        do{
            return try moc.fetch(fetchRequest)
        }catch {
            print("Error fetching tasks: \(error)")
            return []
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    //MARK: Functions:
    
    
    
    
    // MARK: - Table view data source
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Task Cell", for: indexPath)
        
        let task = tasks[indexPath.row]
        cell.textLabel?.text = task.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let task = tasks[indexPath.row]
            let moc = CoreDataStack.shared.mainContext
            moc.delete(task)
            
            do {
                try moc.save()
                tableView.reloadData()
            }catch {
                moc.reset()
                print("Error saving managed object context: \(error)")
            }
        }
    }
}
