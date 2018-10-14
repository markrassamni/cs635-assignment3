//
//  Expression.swift
//  Assignment3
//
//  Created by Mark Rassamni on 10/2/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

protocol Expression {
    func interpret(context: Context) -> Int?
}
