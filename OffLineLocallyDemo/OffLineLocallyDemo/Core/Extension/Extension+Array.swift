//
//  Extension+Array.swift
//  OffLineLocallyDemo
//
//

import Foundation

extension Array where Element: Equatable {
    mutating func addOrReplace(_ element: Element) {
        if let index = self.firstIndex(of: element) {
            self.replaceSubrange(index...index, with: [element])
        } else {
            self.append(element)
        }
    }
}
