//
//  ApoloWidget.swift
//  ApoloWidget
//
//  Created by Sina Vosough Nia on 12/2/1402 AP.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    var vm = ApoloWidgetViewModel()
    // what system shows when there is no data
    func placeholder(in context: Context) -> ApoloEntry {
        let entry = ApoloEntry(date: Date(), MissionCommanderWidget: MissionCommanderWidgetModel(commander: vm.missionsCommanders[1].commander, mission: vm.missionsCommanders[1].mission, lunchDate: vm.missionsCommanders[1].lunchDate))
        return entry
    }
    // shows data at the real moment to preview a real widget
    // show placeHolder if the data needed to be downloaded
    func getSnapshot(in context: Context, completion: @escaping (ApoloEntry) -> ()) {
        let entry = ApoloEntry(date: Date(), MissionCommanderWidget: MissionCommanderWidgetModel(commander: vm.missionsCommanders[1].commander, mission: vm.missionsCommanders[1].mission, lunchDate: vm.missionsCommanders[1].lunchDate))
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [ApoloEntry] = []
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for mission in vm.missionsCommanders {
            let entryDate = Calendar.current.date(byAdding: .hour, value: mission.hashValue, to: currentDate)!
            let entry = ApoloEntry(date: entryDate, MissionCommanderWidget: MissionCommanderWidgetModel(commander:mission.commander , mission: mission.mission, lunchDate: mission.lunchDate))
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}
// model
struct ApoloEntry: TimelineEntry {
    let date: Date
    let MissionCommanderWidget: MissionCommanderWidgetModel
}
// view
struct ApoloWidgetEntryView : View {
    var entry: ApoloEntry

    var body: some View {
        ZStack {
            ContainerRelativeShape().fill(.blue.gradient)

            VStack {
                Text("commander:")
                    .foregroundStyle(.black.gradient)
                Text(entry.MissionCommanderWidget.commander)
                    .font(.caption)
                    .minimumScaleFactor(0.6)
                    .fontWeight(.heavy)
                Text("mission:")
                    .foregroundStyle(.black.gradient)
                   
                Text(entry.MissionCommanderWidget.mission)
                    .font(.title)
                    .fontWeight(.heavy)
                    .minimumScaleFactor(0.7)
            }
            .foregroundStyle(.white)
            
        }
        
    }
}

// widget Configuration
struct ApoloWidget: Widget {
    let kind: String = "ApoloWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                ApoloWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                ApoloWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("Apolo Widget")
        .description("this widget will show Apolo missions with their commander")
        .supportedFamilies([.systemSmall])
    }
}

#Preview(as: .systemSmall) {
    ApoloWidget()
} timeline: {
    ApoloEntry(date: Date(), MissionCommanderWidget: MissionCommanderWidgetModel(commander: "Edward H. White II", mission: "Apollo 7", lunchDate: "1968-12-21"))
    ApoloEntry(date: Date(), MissionCommanderWidget: MissionCommanderWidgetModel(commander: "James A. McDivitt", mission: "Apollo 9", lunchDate: "1968-12-21"))
    }
