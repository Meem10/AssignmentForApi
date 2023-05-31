//
//  Calories.swift
//  AssignmentForApi
//
//  Created by Mohammed on 11/11/1444 AH.
//

import SwiftUI

struct CalorieRes : Codable {
    let calorie : [Calorie]
}

struct Calorie : Codable  {
    
    let name: String
    let caloriesPerHour, durationMinutes, totalCalories: Int
   
    enum CodingKeys: String, CodingKey {
           case name
           case caloriesPerHour = "calories_per_hour"
           case durationMinutes = "duration_minutes"
           case totalCalories = "total_calories"
       }
}


struct Calories: View {
    @State var calorie = [Calorie]()
    var body: some View {
        VStack{
            List(calorie , id: \.name){ i in
                Text(i.name)
                Text("\(i.caloriesPerHour)")
                
            }.task {
                await loadata()
            }
            
            
        }
    }
    
    func loadata() async{
        let activity = "skiing".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: "https://api.api-ninjas.com/v1/caloriesburned?activity=" + activity!)!
        var request = URLRequest(url: url)
        request.setValue("cjvQ3XCP4HLbEMKIF5Cb2AeIhozQYbrtPiszaiu9", forHTTPHeaderField: "X-Api-Key")
        
        do{
            let (data, response) = try await URLSession.shared.data(from: url)
//            print(String(data: data, encoding: .utf8)!)
//            print(data)
           // print(response)
            let decoderProduct = try JSONDecoder().decode(CalorieRes.self, from: data)
            calorie = decoderProduct.calorie
            
        }
        catch{
            print("did not feach the data \(error)")
            
        }
    }
    
    
    
}


struct Calories_Previews: PreviewProvider {
    static var previews: some View {
        Calories()
    }
}
