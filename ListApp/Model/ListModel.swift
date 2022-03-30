//
//  ListModel.swift
//  ListApp
//
//  Created by Jakub Malczyk on 03/03/2022.
//

import Foundation
import SwiftUI

struct DayListModel : Identifiable, Codable {
    
    var id = UUID()
    var day : String
    var dailyTasks : [TaskListModel]

    
}

struct TaskListModel : Codable, Equatable{
    var complete : Bool
    var tittle : String
    var hour : String
    
    
    init(complete : Bool, tittle : String, hour : String){
        self.complete = complete
        self.tittle = tittle
        self.hour = hour
    }
    
    
    func updateCompletion() -> TaskListModel{
        return TaskListModel(complete: !complete, tittle: tittle, hour: hour)
    }
    
}





