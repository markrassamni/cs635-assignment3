//
//  Value.swift
//  Assignment3
//
//  Created by Mark Rassamni on 10/14/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

protocol Value: CustomStringConvertible {
    var description: String { get }
    func evaluate(context: Context) -> Int?
}
