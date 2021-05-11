//
//  AddTaskViewController.swift
//  ToDoListApp
//
//  Created by Akshay Nandane on 10/05/21.
//  Copyright © 2021 com.app.connectme. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class addTaskViewController: UIViewController {
    
    private let taskSubject = PublishSubject<Task>()
    
    var taskSubjectObservable: Observable<Task> {
        return taskSubject.asObservable()
    }
    
    @IBOutlet var TaskDesciTextField: UITextField!
    @IBOutlet var prioritySegmentedController: UISegmentedControl!
    
    
    override func viewDidLoad() {
        
    }
    
    @IBAction func saveTaskAction(){
        
        guard let priority = Priority(rawValue: self.prioritySegmentedController.selectedSegmentIndex), let title = self.TaskDesciTextField.text else {
            return
        }
        
        let task = Task(title: title, priority: priority)
        taskSubject.onNext(task)
        self.dismiss(animated: true, completion: nil)
    }
    
}
