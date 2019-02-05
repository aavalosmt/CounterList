//
//  Array.swift
//  CounterList
//
//  Created by Aldo Antonio Martinez Avalos on 2/4/19.
//  Copyright © 2019 Cornershop. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {
    
    // Given two ordered arrays returns the indices where elements changed
    // T(n, m) = O(n) worst case scenario
    // T(n, m) = O(m) best case scenario
    // Where m < n
    func addedIndices(oldArray: Array<Element>) -> [Int] {
        guard oldArray.count <= count else { return [] }
        
        let oldCount = oldArray.count
        var indices: [Int] = []
        var index: Int = 0
        
        for element in self {
            guard index < oldCount else {
                indices.append(contentsOf: Array<Int>((index)...(count - 1)))
                return indices
            }
            let oldElement = oldArray[index]
            
            guard oldElement == element else {
                if let firstIndex = firstIndex(of: element) {
                    indices.append(firstIndex)
                } else {
                    indices.append(index)
                }
                continue
            }
            index += 1
        }
        return indices
    }
    
}
