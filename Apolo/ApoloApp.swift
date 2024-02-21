//
//  ApoloApp.swift
//  Apolo
//
//  Created by Sina Vosough Nia on 12/1/1402 AP.
//

import SwiftUI

@main
struct ApoloApp: App {
    let vm = ApoloViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView(vm: vm )
                
        }
    }
}
