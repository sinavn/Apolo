//
//  ApoloViewModel.swift
//  Apolo
//
//  Created by Sina Vosough Nia on 12/1/1402 AP.
//

import Foundation
import SwiftyJSON

class ApoloViewModel : ObservableObject {
    @Published var missions : [MissionsModel] = []
    @Published var astronauts : [String:AstronautsModel] = [:]
    @Published var missionsCommanders : [MissionCommanderModel] = []
    
    init() {
        getMissionData()
        getAstronautsData()
        mapMissionsData()
        saveMissionsCommandersToUserDefaults()
    }
    func getMissionData (){if let url = Bundle.main.url(forResource: "missions", withExtension: "json"),
                              let data = try? Data(contentsOf: url),
                              let json = try? JSON(data: data),
                              let missionsArray = json.array {
        let missions = missionsArray.compactMap { MissionsModel(json: $0) }
        self.missions = missions
    } else {
        print("Failed to parse JSON data for missions.")
    }
    }
    func getAstronautsData () {
        
        if let url = Bundle.main.url(forResource: "astronauts", withExtension: "json"),
           let data = try? Data(contentsOf: url),
           let json = try? JSON(data: data) {
            for (_, subJson):(String, JSON) in json {
                if let astronaut = AstronautsModel(json: subJson) {
                    astronauts[astronaut.id] = astronaut
                }
            }
      } else {
            print("Failed to parse JSON data for astronauts.")
        }
        
    }
    func mapMissionsData(){
        for mission in missions {
            if let commander = mission.crew.first(where: {$0.role=="Commander"}),let commanderAstronauts = astronauts.first(where: {$0.key == commander.name}){
                let firstNineWords = mission.description.split(separator: " ").prefix(2).joined(separator: " ")
                let MissionsCommander = MissionCommanderModel(commander: commanderAstronauts.value.name, mission:firstNineWords , lunchDate: mission.launchDate ?? "")
                missionsCommanders.append(MissionsCommander)
            }
        
        }
    }
    func saveMissionsCommandersToUserDefaults() {
           let sharedDefaults = UserDefaults(suiteName:"group.com.sinavn.Apolo")
        do {
            let missionsCommandersData = try JSONEncoder().encode(missionsCommanders)
            sharedDefaults?.set(missionsCommandersData, forKey:"missionsCommanders")
            sharedDefaults?.synchronize()
        } catch let error {
            print("error\(error)")
        }
           
           
       }
}
