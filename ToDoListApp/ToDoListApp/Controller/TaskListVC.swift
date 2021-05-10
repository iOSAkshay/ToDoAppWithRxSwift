//
//  TaskListVC.swift
//  ToDoListApp
//
//  Created by Akshay Nandane on 10/05/21.
//  Copyright © 2021 com.app.connectme. All rights reserved.
//

import Foundation
import UIKit

class TaskListVC: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet var prioritySegmentControl: UISegmentedControl!
    @IBOutlet var taskTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    //Delagate and Data source methods of TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        return cell
    }
    
}
