//
//  ApoloWidgetViewModel.swift
//  ApoloWidgetExtension
//
//  Created by Sina Vosough Nia on 12/2/1402 AP.
//

import Foundation

class ApoloWidgetViewModel {
    var missionsCommanders: [MissionCommanderWidgetModel] = []

    init() {
        loadMissionsCommandersFromUserDefaults()
    }

    func loadMissionsCommandersFromUserDefaults() {
        let sharedDefaults = UserDefaults(suiteName: "group.com.sinavn.Apolo")
        
        if let missionsCommandersData = sharedDefaults?.data(forKey: "missionsCommanders") {
            do {
                 missionsCommanders = (try JSONDecoder().decode([MissionCommanderWidgetModel].self, from: missionsCommandersData))
                print(missionsCommanders)
            } catch let error {
                print("error\(error)")
            }
            
            
        }
    }
}

