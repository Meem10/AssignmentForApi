//
//  holidays.swift
//  AssignmentForApi
//
//  Created by Mohammed on 11/11/1444 AH.
//

import SwiftUI

struct HolidayRe : Codable{
    let holiday : [Holiday]
}


struct Holiday: Codable , Identifiable{
    let id: String
    let country, iso: String
    let year: Int
    let date, day, name, type: String
}

struct holidays: View {
    @State var holiday = [Holiday]()
    var body: some View {
        VStack{
            List(holiday){ i in
                Text(i.country)
                
            }.task {
                await loadDate()
            }
            
            
            
        }
    }
    
    
    func loadDate() async{
        
        let url = URL(string: "https://api.api-ninjas.com/v1/holidays?country=ca&year=2022")!
        var request = URLRequest(url: url)
        request.setValue("cjvQ3XCP4HLbEMKIF5Cb2AeIhozQYbrtPiszaiu9", forHTTPHeaderField: "X-Api-Key")
        
        do{
            let (data, response) = try await URLSession.shared.data(from: url)
            print(response)
            print(data)
            let decoderProduct = try JSONDecoder().decode(HolidayRe.self, from: data)
            holiday = decoderProduct.holiday
            
            
        } catch{
            print("did not feach the data \(error)")
            
        }
            
        }
        
    }


struct holidays_Previews: PreviewProvider {
    static var previews: some View {
        holidays()
    }
}
