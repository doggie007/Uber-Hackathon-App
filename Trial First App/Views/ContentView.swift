//
//  ContentView.swift
//  Trial First App
//
//  Created by James Tcheng on 14/07/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            CoursesView()
                .tabItem {
                    Label("Courses", systemImage: "text.book.closed.fill")
                }
            RunModelView()
                .tabItem{
                    Label("", systemImage: "plus.circle.fill")}
            ClimateModelsView()
                .tabItem {
                    Label("Climate Models", systemImage: "globe.europe.africa.fill")
                }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
