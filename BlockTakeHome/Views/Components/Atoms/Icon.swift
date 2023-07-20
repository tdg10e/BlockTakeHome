//
//  Icon.swift
//  BlockTakeHome
//
//  Created by Tremaine Grant on 7/19/23.
//

import SwiftUI

import Foundation
import SwiftUI

enum Icon: Equatable {
    case sfSymbol(SFSymbols)
    case custom(CustomIcons)
}

enum SFSymbols: String {
    case filter = "line.3.horizontal.decrease.circle"
    case person = "person"
    case magnifyingGlass = "magnifyingglass"
    case checkmark = "checkmark"
}

//For custom images/icons we add to the asset library
enum CustomIcons: String {
    case missingIcon = "missing"
}
