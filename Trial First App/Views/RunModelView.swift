//
//  RunModelView.swift
//  Trial First App
//
//  Created by James Tcheng on 24/07/2022.
//

import SwiftUI
import StockCharts

struct RunModelView: View {
    @State var showModal = false
    @ObservedObject var myApi = Api()
    var body: some View {
        VStack(alignment: .leading, spacing: 20){
            Text("Create your model!")
                .font(.title)
                .fontWeight(.bold)
            Divider()
            InformationView()

            Text("The current implementation is called the ISAM integrated model, which models the effect of atmospheric CO2, and other climate forcings.")
                .font(.subheadline)
            Spacer()
            VStack(alignment: .center){
                Button{
                    showModal.toggle()
                } label: {
                    Label("Start Here", systemImage: "plus.circle")
                }.buttonStyle(BlueButton())
                    .sheet(isPresented: $showModal){
                        SheetView()
                    }
                
            }.frame(maxWidth: .infinity)
            
            
            Spacer()
            
        }.padding()
        
    }
}





struct SheetView: View {
    @Environment(\.dismiss) var dismiss
    @State var a1 = "11"
    @State var a2 = "12"
    @State var a3 = "14"
    @State var a4 = "25"
    @State var a5 = "28"
    @State var a6 = "32"
    @State var showModal = false
    
    var body: some View {
        VStack(alignment:.leading, spacing: 10){
            HStack(){
                Spacer()
                Button{
                    dismiss()
                } label: {
                    Image(systemName: "xmark.circle")

                }
            .buttonStyle(RedButton())
            }
            VStack(alignment:.leading){
                Text("Create your climate model")
                    .font(.title2)
                    .fontWeight(.bold)
                Divider()
                Text("Input the amount of CO2 Emissions for the following years.")
                Text("Amount is in Giga Tonnes.")
                Spacer()
                HStack(){
                    Spacer()
                    Text("Year")
                        .font(.title3)
                        .fontWeight(.medium)
                Spacer()
            }
            }
            HStack{
                VStack{
                    Text("2015")
                    TextField("2015", text:$a1)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(.roundedBorder)
                        .fixedSize()
                }
                Spacer()
                VStack{
                    Text("2020")
                    TextField("2020", text:$a2)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(.roundedBorder)
                        .fixedSize()
                }
                Spacer()
                VStack{
                    Text("2025")
                    TextField("2025", text:$a3)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(.roundedBorder)
                        .fixedSize()
                }
                
            }
            HStack{
                VStack{
                    Text("2050")
                    TextField("2050", text:$a4)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(.roundedBorder)
                        .fixedSize()
                }
                Spacer()
                VStack{
                    Text("2075")
                    TextField("2075", text:$a5)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(.roundedBorder)
                        .fixedSize()
                }
                Spacer()
                VStack{
                    Text("2100")
                    TextField("2100", text:$a6)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(.roundedBorder)
                        .fixedSize()
                }
            }
            
            
            
            Spacer()
            Spacer()
            HStack{
                Spacer()
                Button{
                    showModal.toggle()
                } label: {
                    Label("Run model!", systemImage: "play.circle")
                }.buttonStyle(BlueButton()).shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    .sheet(isPresented: $showModal){
                        FinalSheetView(arr: [a1, a2, a3, a4, a5, a6])
                        
                    }
                Spacer()
            }
                
        }.padding()
        
        
        
    }
}

struct BlueButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color(red: 0, green: 0, blue: 0.3))
            .foregroundColor(.white)
            .clipShape(Capsule())
    }
}

struct RedButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color(red: 0.6, green: 0, blue: 0.0))
            .foregroundColor(.white)
            .clipShape(Capsule())
    }
}


struct InformationView: View{
    var body: some View{
        VStack{
            ZStack(alignment: .topLeading){
                Rectangle()
                    .foregroundColor(Color( red: 0.0, green: 0.0, blue: 1.0, opacity:0.1))
                    .frame(width: 350, height: 130)
                    .cornerRadius(20)
                VStack(alignment: .leading, spacing: 10){
                    
                    Text("Did you know?")
                        .font(.title3)
                        .fontWeight(.bold)
                    Divider()
                    Text("The last decade was the hottest in 125,000 years.")
                    
                    
                }.padding()
            }
        }
    }
}
    
struct FinalSheetView: View{
    @Environment(\.dismiss) var dismiss
    @State var arr: [String]
    @StateObject var myApi = Api()
    var body: some View{
        VStack(alignment:.center){
            VStack{
                HStack(){
                    Spacer()
                    Button{
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle")

                    }
                .buttonStyle(RedButton())
                }
            }
            Spacer()
//            Change to false!!!
            if (myApi.done == false){
                ProgressView()
            }else{
//                Text("\(myApi.output!.years[0])")
//                Text("Hii")
                ScrollView(.vertical){
                    Text("Temperature relative to 1950 (in Celsius)")
                        .font(.title2)
                        .fontWeight(.heavy)
                    
                    ChartView(data: myApi.output!.temperatures,start: "1765",end:"2100")
                    Divider()
                    
                    Text("Carbon Dioxide (ppm)")
                        .font(.title2)
                        .fontWeight(.heavy)
                    
                    ChartView(data: myApi.output!.carbons,start: "1765",end:"2100")
                    
                }
                
                
            }
            
            Spacer()
            
            
            
        }.padding()
            .onAppear{
                myApi.callAPI(inputData: ClimateModelInput(carbon_emissions: arr))
                
            }
    }
}


struct ChartView: View{
    let data: [Double]
    let start: String
    let end: String
    var body: some View{
        ZStack{
//            Rectangle()
//                .frame(width:350,height:500)
//                .cornerRadius(20)
//                .foregroundColor(.gray)
            let lineChartController = LineChartController(prices: data,  dragGesture: true)
            
            VStack(spacing:38){
                LineChartView(lineChartController: lineChartController)
                    .frame(width:350, height:460)
                    .padding()
                VStack{
                    HStack{
                        Text(start)
                        Spacer()
                        Text(end)
                    }
                    Text("Year")
                }
                .padding()
                    
            }
            
        }
    }
}



struct RunModelView_Previews: PreviewProvider {
    static var previews: some View {
//        RunModelView()
        FinalSheetView(arr:["1","2","3","4","5","6"])
    }
}
