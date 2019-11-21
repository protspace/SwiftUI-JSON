//: A UIKit based Playground for presenting user interface

import UIKit
import SwiftUI
import PlaygroundSupport

struct Row: View, Codable {
    let id: UUID! = UUID()
    let title: String
    let subtitle: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
            Text(subtitle)
        }
    }
}

struct Table: View, Codable {
    var rows: [Row]

    var body: some View {
        //makeList(rows: rows)
        List(rows, id: \.id) {$0}
    }
}

//func makeList(rows: [Row]) -> AnyView {
//    @Binding var aRow: Row
//    List(rows, id: \.id, selection: $aRow) {$0}
//}

struct Title: View, Codable {
    let text: String
    
    var body: some View {
        Text(text)
    }
}

struct ContentView: View {
    var body: some View {
        Decoder.makeContentView()
    }
}

struct Decoder {
    
    static func makeContentView() -> AnyView {
        print("JSON has to be here: \(playgroundSharedDataDirectory)")
        let url = playgroundSharedDataDirectory.appendingPathComponent("table.json")
        guard
            let string = try? String(contentsOf: url, encoding: .utf8),
            let data = string.data(using: .utf8),
            let table = try? JSONDecoder().decode(Table.self, from: data)
            else {
                return AnyView(Text("Failed to decode JSON 😟"))
        }
        return AnyView(table)
    }
}

PlaygroundPage.current.setLiveView(ContentView())
