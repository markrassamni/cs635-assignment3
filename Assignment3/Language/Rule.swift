//
//  Rule.swift
//  Assignment3
//
//  Created by Mark Rassamni on 10/1/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

protocol Rule: CustomStringConvertible {
    var description: String { get } // Swift toString()
    func evaluate(values: Context) -> Bool 
}
