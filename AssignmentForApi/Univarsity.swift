//
//  Univarsity.swift
//  AssignmentForApi
//
//  Created by Mohammed on 11/11/1444 AH.
//

import SwiftUI



struct UnivarsityRes : Codable{
    let result : [UnivarsityWelcome]
}
struct UnivarsityWelcome: Codable {
    let name: String
    let url: String
    let startTime, endTime, duration, in24_Hours: String
    let status: String

    enum CodingKeys: String, CodingKey {
        case name, url
        case startTime = "start_time"
        case endTime = "end_time"
        case duration
        case in24_Hours = "in_24_hours"
        case status
    }
}

typealias Welcome = [UnivarsityWelcome]


struct Univarsity: View {
    @State var result = [UnivarsityWelcome]()
    var body: some View {
        VStack{
            ForEach(result , id: \.name) { result in
                Text(result.name)
            }.task {
                await loadData()
            }
        }
    }
    func loadData() async {
            guard let url = URL(string: "https://kontests.net/api/v1/hacker_earth") else {
                return
            }
        
        do{
            let (data, response) = try await URLSession.shared.data(from: url)
            print(data)
            print(response)
            let decoderProduct = try JSONDecoder().decode(UnivarsityRes.self, from: data)
            result = decoderProduct.result
            
            
        } catch{
            print("did not feach the data \(error)")
            
        }
        }
}

struct Univarsity_Previews: PreviewProvider {
    static var previews: some View {
        Univarsity()
    }
}
