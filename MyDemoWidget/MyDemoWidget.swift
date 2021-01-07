//
//  MyDemoWidget.swift
//  MyDemoWidget
//
//  Created by Xiaochun Shen on 2021/1/7.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), secondsElapsed: 10)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), secondsElapsed: 10)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
//        var entries: [SimpleEntry] = []
//
//        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
//        let currentDate = Date()
//        for hourOffset in 0 ..< 5 {
//            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
//            let entry = SimpleEntry(date: entryDate)
//            entries.append(entry)
//        }
//
//        let timeline = Timeline(entries: entries, policy: .atEnd)
//        completion(timeline)
        
        var entries = [SimpleEntry]()
        let currentDate = Date()
        for secondOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .second, value: secondOffset * 10, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, secondsElapsed: secondOffset * 10)
            entries.append(entry)
        }
        
//        let timeline = Timeline(entries: entries, policy: .never)
//        let timeline = Timeline(entries: entries, policy: .atEnd)
        let timeline = Timeline(entries: entries, policy: .after(Calendar.current.date(byAdding: .second, value: 90, to: currentDate)!))
        completion(timeline)
        
        
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let secondsElapsed: Int
}

struct MyDemoWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        Text("\(entry.secondsElapsed) seconds elapsed")
    }
}

@main
struct MyDemoWidget: Widget {
    let kind: String = "MyDemoWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            MyDemoWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

//struct MyDemoWidget_Previews: PreviewProvider {
//    static var previews: some View {
//        MyDemoWidgetEntryView(entry: SimpleEntry(date: Date()))
//            .previewContext(WidgetPreviewContext(family: .systemSmall))
////            .redacted(reason: .placeholder)
//    }
//}
