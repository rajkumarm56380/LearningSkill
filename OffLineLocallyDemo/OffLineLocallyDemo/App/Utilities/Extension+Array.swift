//
//  Extension+Array.swift
//  OffLineLocallyDemo
//
//  Created by Apple on 15/03/26.
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
