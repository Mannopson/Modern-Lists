//
//  DummyModel.swift
//  ListCollectionView
//
//  Created by AzizOfficial on 3/7/22.
//

import Foundation

struct DummyModel: Hashable {
//    enum Section: CaseIterable, CustomStringConvertible {
//        case options, upnext
//    }
    
    let text: String
    let title: String
//    let section: Section
    private let identifier = UUID()
    
    init(text: String, title: String) {
        self.text = text
        self.title = title
    }
}

extension DummyModel {
//    var description: String {
//        switch self {
//        case .options: return "Options"
//        case .upnext: return "Upnext"
//        }
//    }
    var dummies: [DummyModel] {
        return [
            DummyModel.init(text: "Cell", title: "First"),
            DummyModel.init(text: "Cell", title: "Second"),
            DummyModel.init(text: "Cell", title: "Third")
            ]
//        switch self {
//        case .options:
//            return [
//                DummyModel.init(text: "Cell", title: "First", section: self),
//                DummyModel.init(text: "Cell", title: "Second", section: self)
//                ]
//        case .upnext:
//            return [
//                DummyModel.init(text: "Cell", title: "First", section: self),
//                DummyModel.init(text: "Cell", title: "Second", section: self),
//                DummyModel.init(text: "Cell", title: "Third", section: self)
//                ]
//        }
    }
}
