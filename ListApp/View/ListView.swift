//
//  ListView.swift
//  ListApp
//
//  Created by Jakub Malczyk on 03/03/2022.
//

import SwiftUI

struct ListView: View {
    
    @EnvironmentObject var taskVM : TaskViewModel
    
    var body: some View {
        
        NavigationView{
            
            List{
                ForEach(taskVM.sortedDays) {day in
                    Section(header:
                                Text(day.day)
                        .font(.title2)
                        .fontWeight(.light)
                    ){
                        ForEach(day.dailyTasks.sorted(by: {$0.hour < $1.hour}), id: \.hour) {task in
                            
                            HStack{
                                
                                Image(systemName: task.complete ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(task.complete ? Color.green : Color.red)
                                
                                Text(task.tittle)
                                    .font(.system(size: 20))
                                    .fontWeight(.light)
                                
                                Spacer()
                                
                                Text(task.hour)
                                    .font(.system(size: 20))
                                    .fontWeight(.light)
                            }
                            .swipeActions {
                                Button(role: .destructive){
                                    taskVM.deleteTask(day: day, task: task)
                                } label:{
                                    Label("Delete", systemImage: "trash.circle.fill")
                                }
                                Button{
                                    taskVM.completeTask(day: day, task: task)
                                } label:{
                                    Label("Done", systemImage: "checkmark.circle.fill")
                                }
                                .tint(.green)
                            }
                        }
                        // : Foreach (Tasks)
                        
                    } // ForEach (Days)
                }
            }
            .navigationTitle("Your tasks")
        }
    }// : Zstack
    
}


struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
            .environmentObject(TaskViewModel())
    }
}
