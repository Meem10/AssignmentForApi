//
//  CryptoPrice.swift
//  AssignmentForApi
//
//  Created by Mohammed on 11/11/1444 AH.
//

import SwiftUI


struct CryptoRe : Codable{
    let crypto : [Crypto]
}


struct Crypto: Codable, Identifiable {
    let id: String
    let symbol, price: String
    let timestamp: Int
}

struct CryptoPrice: View {
    @State var crypto = [Crypto]()
    var body: some View {
        
        VStack {
            Text("crypto Price")
                .font(.largeTitle)
                .bold()
            List(crypto){ i in
                Text("\(i.timestamp)")
                Text(i.price)
                Text(i.symbol)
                
            }.task {
                await loadData()
            }
                
            }
        .padding()
        
        
    }
    func loadData() async {
        guard let url = URL(string: "https://api.api-ninjas.com/v1/caloriesburned?activity="+activity!) else {
            return
        }
        
        let activity = "skiing".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        var request = URLRequest(url: url)
        request.setValue("cjvQ3XCP4HLbEMKIF5Cb2AeIhozQYbrtPiszaiu9", forHTTPHeaderField: "X-Api-Key")
        
        do{
            let (data, response) = try await URLSession.shared.data(from: url)
            print(String(data: data, encoding: .utf8)!)
            print(data)
            print(response)
            let decoderProduct = try JSONDecoder().decode(Crypto.self, from: data)
            crypto = decoderProduct.crypto
            
            
        }
        catch{
            print("did not feach the data \(error)")
            
        }

    }
    
}
struct CryptoPrice_Previews: PreviewProvider {
    static var previews: some View {
        CryptoPrice()
    }
}
