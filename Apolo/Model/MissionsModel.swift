//
//  MissionsModel.swift
//  Apolo
//
//  Created by Sina Vosough Nia on 12/1/1402 AP.
//

import Foundation
import SwiftyJSON

struct MissionsModel: Codable {
    let id: Int
    let crew: [Crew]
    let description: String
    let launchDate: String?
    
    init?(json: JSON) {
        guard let id = json["id"].int,
              let description = json["description"].string else {
            return nil
        }
        self.id = id
        self.description = description
        self.launchDate = json["launchDate"].string
        
        var crewArray: [Crew] = []
        for crewJSON in json["crew"].arrayValue {
            if let name = crewJSON["name"].string,
               let role = crewJSON["role"].string {
                crewArray.append(Crew(name: name, role: role))
            }
        }
        self.crew = crewArray
    }
}

struct Crew: Codable {
    let name, role: String
}


