//
//  ContentView.swift
//  Apolo
//
//  Created by Sina Vosough Nia on 12/1/1402 AP.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm : ApoloViewModel
    var body: some View {
        VStack {
            List{
                ForEach(vm.missionsCommanders,id: \.self) { mission in
                    HStack{
                        Text(mission.commander)
                        Spacer()
                        Text(mission.mission)
                        Text(mission.lunchDate)
                        
                    }
                    
                }
            }
            
        }
    }
}
#Preview {
    ContentView(vm: ApoloViewModel())
}

