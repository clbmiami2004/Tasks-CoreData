//
//  TaskDetailViewController.swift
//  Tasks-CoreData
//
//  Created by Lambda_School_Loaner_201 on 12/3/19.
//  Copyright © 2019 Christian Lorenzo. All rights reserved.
//

import UIKit

class TaskDetailViewController: UIViewController {
    
    
    var task: Task? {
        didSet {
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    @IBAction func saveTask(_ sender: UIBarButtonItem) {
        guard let name = textField.text, !name.isEmpty else {return}
        
        let notes = notesTextView.text
        
        if let task = task {
            //Editing an existing task
            task.name = name
            task.notes = notes
        }else {
            //Creating a new task
            let _ = Task(name: name, notes: notes)
        }
        
        do {
            let moc = CoreDataStack.shared.mainContext
            try moc.save()
        }catch {
            print("Error saving managed object context: \(error)")
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var notesTextView: UITextView!
    
    
    
    
    
//MARK: Functions:
    
    private func updateViews() {
           guard isViewLoaded else {return}
           
           title = task?.name ?? "Create Task"
           textField.text = task?.name
           notesTextView.text = task?.notes
       }
    
}
