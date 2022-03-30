//
//  AddTaskView.swift
//  ListApp
//
//  Created by Jakub Malczyk on 03/03/2022.
//

import SwiftUI

struct AddTaskView: View {
    
    
    @State var tittle = ""
    @State var date = Date()
    
    @EnvironmentObject var taskVM : TaskViewModel
    
    var body: some View {
        NavigationView{
            
            Form{
                
                TextField("Task tittle", text: $tittle)
                DatePicker("Task date", selection: $date, in: Date()..., displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                DatePicker("Task hour", selection: $date, displayedComponents: .hourAndMinute)

                      
            }// : Form
            .navigationTitle("Add task")
            .toolbar{
                Button{
                    if tittle.count > 3{
                    
                    taskVM.updateDayList(tittle: tittle, date: date)
                    tittle = ""
                    date = Date()
                    }
                    
                } label: {
                    Label("Add", systemImage: "text.badge.plus")
                }
            }
        }
            
    }
}


struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView()
            .environmentObject(TaskViewModel())
    }
}
