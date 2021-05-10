//
//  TaskModel.swift
//  ToDoListApp
//
//  Created by Akshay Nandane on 10/05/21.
//  Copyright © 2021 com.app.connectme. All rights reserved.
//

import Foundation
import UIKit

enum Priority: Int {
    case High
    case Medium
    case Low
}

struct  Task {
    let title: String
    let priority: Priority
}
