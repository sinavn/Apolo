//
//  AstronautsModel.swift
//  Apolo
//
//  Created by Sina Vosough Nia on 12/1/1402 AP.
//

import Foundation
import SwiftyJSON

struct AstronautsModel: Codable {
    let id: String
    let name: String
    let description: String
    
    init?(json:JSON) {
        guard let id = json["id"].string ,
              let name = json["name"].string,
              let description = json["description"].string else{
            return nil
        }
        self.id = id
        self.name = name
        self.description = description
                
    }
}

