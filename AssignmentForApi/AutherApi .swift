//
//  AutherApi .swift
//  AssignmentForApi
//
//  Created by Mohammed on 10/11/1444 AH.
//

import SwiftUI
import Foundation


var myURL = "https://reqres.in/api/users?page=2"

struct DatumResp :Codable{
    let data : [Datum]
}


// MARK: - Datum
struct Datum: Codable , Identifiable{
    let id: Int
    let email, firstName, lastName: String
    let avatar: String
    
    enum CodingKeys: String, CodingKey {
        case id, email
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar
    }
}

struct AutherApi_: View {
    @State var data = [Datum]()
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 1) {
                ForEach(data , id: \.id) { a in
                    VStack {
                        Text("\(a.firstName)  \(a.lastName)")
                        Text(a.email)
                        AsyncImage(url: URL(string:a.avatar))
                        
                    }.padding()
                   
                    
                }
            }.task {
                await loadData()
        }
        }
        
    }
    func loadData() async {
        guard let url = URL(string: myURL) else {
            print("Invalid URL")
            return
        }
        
        do{
            let (data, response) = try await URLSession.shared.data(from: url)
            print(data)
            print(response)
            let decoderProduct = try JSONDecoder().decode(DatumResp.self, from: data)
            self.data = decoderProduct.data
            
            
        } catch{
            print("did not feach the data \(error)")
            
        }
    }
}

struct AutherApi__Previews: PreviewProvider {
    static var previews: some View {
        AutherApi_()
    }
}
