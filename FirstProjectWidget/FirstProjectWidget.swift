//
//  FirstProjectWidget.swift
//  FirstProjectWidget
//
//  Created by Henrique Bittencourt on 11/7/21.
//

import WidgetKit
import SwiftUI
import Intents
import Multiplatform_App

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct FirstProjectWidgetEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var family

    var body: some View {
        if family == .systemSmall {
            MyWidgetSmall()
        } else {
            MyWidgetMedium()
        }
    }
}

struct MyWidgetSmall: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Newest")
                .font(Font.footnote.smallCaps())
                .foregroundColor(.secondary)
            Text("Matched Geometry Effect")
                .font(.subheadline)
                .fontWeight(.semibold)
            Text("Learn how to quickly transition different views")
                .font(.footnote)
                .foregroundColor(.secondary)
        }
        .padding(12)
    }
}

struct MyWidgetMedium: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Newest")
                .font(Font.footnote.smallCaps())
                .foregroundColor(.secondary)
            ForEach(courseSections.indices) { index in
                if index < 2 {
                    CourseRow(item: courseSections[index])
                }
            }
        }
        .padding(12)
    }
}

@main
struct FirstProjectWidget: Widget {
    let kind: String = "FirstProjectWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            FirstProjectWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct FirstProjectWidget_Previews: PreviewProvider {
    static var previews: some View {
        FirstProjectWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
