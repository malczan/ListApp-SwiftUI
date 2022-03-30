//
//  TaskViewModel.swift
//  ListApp
//
//  Created by Jakub Malczyk on 04/03/2022.
//

import Foundation
import SwiftUI


class TaskViewModel : ObservableObject{
    
    let daysListKey : String = "task_key" // saving key
    
    @Published var daysList : [DayListModel] = []{
        didSet{
            saveTask()
        }
    }
    
    
    var taskNumber : Int{
        
        var taskNumber = 0
        
        for day in daysList{
            taskNumber += day.dailyTasks.count
        }
        return taskNumber
    }
    

    var sortedDays : [DayListModel] {
        get {
            daysList.sorted(by: {$0.day < $1.day})
        } set {
            daysList = newValue
        }
    }
    
    func updateDayList(tittle : String, date : Date){ // adding tasks to the list
        
            let day = getDate(date: date)
            let hour = getHour(date: date)
            
            if daysList.contains(where: { $0.day == day}){
                let index = daysList.firstIndex(where: {$0.day == day})
                if daysList[index!].dailyTasks.contains(where: { $0.tittle != tittle && $0.hour != hour}){
                    daysList[index!].dailyTasks.append(TaskListModel(complete: false,tittle: tittle, hour: hour))
                }
            } else {
                daysList.append(DayListModel(day: day, dailyTasks: [TaskListModel(complete: false, tittle: tittle, hour: hour)]))
            }
    }
    
    
    
    func completeTask(day : DayListModel, task: TaskListModel){ // toggle - completed or not
        
        if let i = daysList.firstIndex(where: {$0.dailyTasks == day.dailyTasks }){
            if let j = daysList[i].dailyTasks.firstIndex(where: {$0.tittle == task.tittle && $0.hour == task.hour}){
                daysList[i].dailyTasks[j] = task.updateCompletion()
            }
        }
    }
    
    
    func deleteTask(day : DayListModel, task: TaskListModel){
        
        if let i = daysList.firstIndex(where: {$0.dailyTasks == day.dailyTasks}){
            if let j = daysList[i].dailyTasks.firstIndex(where: {$0.tittle == task.tittle && $0.hour == task.hour}){
                if daysList[i].dailyTasks.count == 1{
                    daysList[i].dailyTasks.remove(at: j)
                    daysList.remove(at: i)
                } else {
                    daysList[i].dailyTasks.remove(at: j)
                }
            }
        }
        
    }
    
    // MARK: DATE
    
    
    private func getDate(date : Date) -> String{
        
        let components = date.get(.day, .month, .year)
        if let day = components.day, let month = components.month, let year = components.year{
            
            if String(day).count == 1 && String(month).count == 1{
                return "0\(day)-0\(month)-\(year)"
            } else if String(day).count == 1 && String(month).count == 2{
                return "0\(day)-\(month)-\(year)"
            } else if String(day).count == 2 && String(month).count == 1{
                return "\(day)-0\(month)-\(year)"
            } else {
                return "\(day)-\(month)-\(year)"
            }
        }
            else {
            return ""
        }
        
    }

    private func getHour(date : Date) -> String{
        
        let compnents = date.get(.hour, .minute)
        if let hour = compnents.hour, let minute = compnents.minute{
            
            if String(hour).count == 1 && String(minute).count == 1{
                return "0\(hour):0\(minute)"
            } else if String(hour).count == 1 && String(minute).count == 2 {
                return "0\(hour):\(minute)"
            } else if String(hour).count == 2 && String(minute).count == 1 {
                return "\(hour):0\(minute)"
            } else {
                return "\(hour):\(minute)"
            }
        } else {
            return ""
        }
    }
    
    
    // MARK: SAVING
    
    func saveTask(){
        if let encodedData = try? JSONEncoder().encode(daysList){
            UserDefaults.standard.set(encodedData, forKey: daysListKey)
        }
    }
    
    func loadTask(){
        guard
            let data = UserDefaults.standard.data(forKey: daysListKey),
            let savedTasks = try? JSONDecoder().decode([DayListModel].self, from: data)
        else { return }
        self.daysList = savedTasks
    }
    
}


extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}

