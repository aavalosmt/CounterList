//
//  UITableView.swift
//  CounterList
//
//  Created by Aldo Antonio Martinez Avalos on 2/5/19.
//  Copyright © 2019 Cornershop. All rights reserved.
//

import UIKit

extension UITableView {
    func isLastVisibleCell(at indexPath: IndexPath) -> Bool {
        guard let lastIndexPath = indexPathsForVisibleRows?.last else {
            return false
        }
        return lastIndexPath == indexPath
    }
}
