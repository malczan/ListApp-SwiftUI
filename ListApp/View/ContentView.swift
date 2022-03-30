//
//  ContentView.swift
//  ListApp
//
//  Created by Jakub Malczyk on 03/03/2022.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var taskVM = TaskViewModel()
    
    init() {
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)], for: .normal)
    }

    var body: some View {
        TabView{
            ListView()
                .badge(taskVM.taskNumber)
                .tabItem{
                    Image(systemName: "list.bullet")
                    Text("List")
                }
            AddTaskView()
                .tabItem {
                    Image(systemName: "plus.app")
                        
                    Text("Add task")
                }
                    
        } // TabView
        .accentColor(.purple)
        .environmentObject(taskVM)
        .onAppear {
            taskVM.loadTask()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(TaskViewModel())
    }
}


