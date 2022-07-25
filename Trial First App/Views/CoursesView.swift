//
//  CoursesView.swift
//  Trial First App
//
//  Created by James Tcheng on 24/07/2022.
//

import SwiftUI

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct CoursesView: View {
    var body: some View {
        NavigationView {
            ZStack{
                Color(.white).edgesIgnoringSafeArea(.all)
                VStack(alignment:.center){
                    Divider()
                    Text("Overview")
                        .font(.title2)
                        .fontWeight(.medium)
                    HStack{
                        OverviewView(title: "What are models?")
                        OverviewView(title: "How do they work?")
                    }
                    Spacer()
                    
                    
                    Text("Specific Climate Models")
                        .font(.title2)
                        .fontWeight(.medium)
                    ScrollView(.horizontal){
                        HStack(spacing: 20) {
                            SubCourseView(title: "Energy Balance Model", description: "The simplest model through analysing the energy budget of earth")
                            
                            SubCourseView(title: "Energy Balance Model", description: "The simplest model through analysing the energy budget of earth")
                            SubCourseView(title: "Energy Balance Model", description: "The simplest model through analysing the energy budget of earth")
                        }
                    }
                
            }
                .navigationTitle("Courses")
                .navigationBarTitleDisplayMode(.inline)
            }
            
            
            
        }
    }
}

struct SubCourseView: View{
    var title: String
    var description: String
    
    var body: some View {
        VStack(){
            ZStack(alignment:.topLeading){
                Rectangle()
                    .foregroundColor(.gray)
                    .frame(width: 300, height: 300, alignment: .trailing)
                    .cornerRadius(20)
                VStack(alignment: .leading, spacing: 10){
                    Text(title)
                        .font(.title2)
                        .fontWeight(.bold)
                    Text(description)
                        .font(.callout)
                    Spacer()
                    NavigationLink(destination: Text("Information about climate model will be displayed here")){
                        Label("Learn More", systemImage: "hand.point.right.fill")
                    }
                }.padding()
                    .frame(width:300, height:300)
                
                
            }
        }.padding()
        
    }
}




struct OverviewView: View{
    var title: String
    var body: some View{
        VStack{
            ZStack(alignment: .bottom){
                Rectangle()
                    .foregroundColor(.gray)
                    .frame(width: 160, height: 160, alignment: .trailing)
                    .cornerRadius(20)
                ZStack{
                    Rectangle()
                        .foregroundColor(Color(UIColor.lightGray))
                        .frame(width:160, height:20)
                        .cornerRadius(20, corners: [.bottomLeft, .bottomRight])

                    NavigationLink(destination: Text("Overview will be displayed here")){
                        Text(title)
                            .font(.callout)
                    }
                }
                
            }
        
        }
    }
}


struct CoursesView_Previews: PreviewProvider {
    static var previews: some View {
        CoursesView()
    }
}
