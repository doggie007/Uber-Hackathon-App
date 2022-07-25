//
//  ClimateModel.swift
//  Trial First App
//
//  Created by James Tcheng on 24/07/2022.
//

import Foundation

struct ClimateModelInput: Codable, Hashable{
    var carbon_emissions: [String]
}

class ClimateModelOutput: Codable{
    var years: [Int]
    var temperatures: [Double]
    var carbons: [Double]
}


class Api : ObservableObject{
    @Published var output: ClimateModelOutput?
    @Published var done = false
    
    func callAPI(inputData: ClimateModelInput){
        self.done = false
        guard let url = URL(string: "https://intense-mountain-45621.herokuapp.com/run") else {
                print("Invalid url...")
                return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: AnyHashable] = ["data": inputData.carbon_emissions]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        print("STARTED TO POST REQUEST")
        let task = URLSession.shared.dataTask(with: request) {data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let response = try JSONDecoder().decode(ClimateModelOutput.self, from: data)
                print("SUCCESS!")
                self.output = response
                self.done = true
                return
            }
            catch {
                print(error)
            }
        }
        task.resume()
        
    }

}
