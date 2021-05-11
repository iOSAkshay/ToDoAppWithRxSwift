//
//  TaskListVC.swift
//  ToDoListApp
//
//  Created by Akshay Nandane on 10/05/21.
//  Copyright © 2021 com.app.connectme. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class TaskListVC: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    let disposeBag = DisposeBag()
    @IBOutlet var prioritySegmentControl: UISegmentedControl!
    @IBOutlet var taskTableView: UITableView!
    
    private var tasks = BehaviorRelay<[Task]>(value: [])
    private var filteredTasks = [Task]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    //Delagate and Data source methods of TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = self.filteredTasks[indexPath.row].title
        return cell
    }
    
    @IBAction func priorityValueChanged(segmentedControl: UISegmentedControl){
        
        let priority = Priority(rawValue: segmentedControl.selectedSegmentIndex - 1)
        filterTask(priority: priority)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navVC = segue.destination as? UINavigationController, let addTVC = navVC.viewControllers.first as? addTaskViewController else {
            fatalError("Fatal error found...")
        }
        
        addTVC.taskSubjectObservable
            .subscribe(onNext: { [unowned self] task in
                
                let priority = Priority(rawValue: self.prioritySegmentControl.selectedSegmentIndex - 1)
                
                var existingTask = self.tasks.value
                existingTask.append(task)
                self.tasks.accept(existingTask)
                
                self.filterTask(priority: priority)
                
            }).disposed(by: disposeBag)
        
    }
    
    private func updateTableView(){
        DispatchQueue.main.async {
            self.taskTableView.reloadData()
        }
    }
    
    private func filterTask(priority: Priority?){
        if priority == nil{
            self.filteredTasks = self.tasks.value
            self.updateTableView()
        } else {
            self.tasks.map { tasks in
                return tasks.filter { $0.priority == priority }
            }.subscribe(onNext: { [weak self] tasks in
                self?.filteredTasks = tasks
                self?.updateTableView()
                print(tasks)
            }).disposed(by: disposeBag)
        }
    }
}
