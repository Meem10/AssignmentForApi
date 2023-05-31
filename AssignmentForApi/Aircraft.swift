//
//  Aircraft.swift
//  AssignmentForApi
//
//  Created by Mohammed on 11/11/1444 AH.
//

import SwiftUI


struct AircraftsRes : Codable {
    var aircraft : [Aircrafts]
}

struct Aircrafts: Codable  {
    let manufacturer, model, engineType, engineThrustLBFt: String
    let maxSpeedKnots, cruiseSpeedKnots, ceilingFt, takeoffGroundRunFt: String
    let landingGroundRollFt, grossWeightLbs, emptyWeightLbs, lengthFt: String
    let heightFt, wingSpanFt, rangeNauticalMiles: String

    enum CodingKeys: String, CodingKey {
        case manufacturer, model
        case engineType = "engine_type"
        case engineThrustLBFt = "engine_thrust_lb_ft"
        case maxSpeedKnots = "max_speed_knots"
        case cruiseSpeedKnots = "cruise_speed_knots"
        case ceilingFt = "ceiling_ft"
        case takeoffGroundRunFt = "takeoff_ground_run_ft"
        case landingGroundRollFt = "landing_ground_roll_ft"
        case grossWeightLbs = "gross_weight_lbs"
        case emptyWeightLbs = "empty_weight_lbs"
        case lengthFt = "length_ft"
        case heightFt = "height_ft"
        case wingSpanFt = "wing_span_ft"
        case rangeNauticalMiles = "range_nautical_miles"
    }
}

struct Aircraft: View {
    @State var aircraft = [Aircrafts]()
    var body: some View {
        VStack {
            List(aircraft , id: \.model){ i in
                Text(i.engineType)
            }.task {
                await loadDate()
            }
            
        }
    }
    
    func loadDate()async{
        let activity = "skiing".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: "https://api.api-ninjas.com/v1/caloriesburned?activity=" + activity!)!
        var request = URLRequest(url: url)
        request.setValue("cjvQ3XCP4HLbEMKIF5Cb2AeIhozQYbrtPiszaiu9", forHTTPHeaderField: "X-Api-Key")
        
        do{
            let (data, response) = try await URLSession.shared.data(from: url)
            print(String(data: data, encoding: .utf8)!)
            print(data)
            print(response)
            let decoderProduct = try JSONDecoder().decode(AircraftsRes.self, from: data)
            aircraft = decoderProduct.aircraft
            
        }
        catch{
            print("did not feach the data \(error)")
            
        }
    }
}

struct Aircraft_Previews: PreviewProvider {
    static var previews: some View {
        Aircraft()
    }
}
