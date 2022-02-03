//
//  Sequence.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/1/22.
//

import Foundation

extension Sequence {
    func sorted<T: Comparable>(comparingKeyPath keyPath: KeyPath<Element, T>, ascending: Bool = true) -> [Element] {
        return self.sorted(by: { ($0[keyPath: keyPath] < $1[keyPath: keyPath]) == ascending })
    }
}
