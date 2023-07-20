//
//  IconImage.swift
//  BlockTakeHome
//
//  Created by Tremaine Grant on 7/19/23.
//

import Foundation
import SwiftUI

struct IconImage: View {
    let icon: Icon
    let color: Color?
    let width: CGFloat?
    let height: CGFloat?

    init(_ icon: Icon, color: Color? = nil, width: CGFloat? = 20, height: CGFloat? = 20) {
        self.icon = icon
        self.color = color
        self.width = width
        self.height = height
    }

    var body: some View {
        Group {
            switch icon {
            case .sfSymbol(let sfSymbol):
                Image(systemName: sfSymbol.rawValue)
                    .resizable()
                    .frame(width: width, height: height)
                    .foregroundColor(color)
            case .custom(let customIconName):
                Image(customIconName.rawValue)
                    .resizable()
                    .scaledToFit()
            }
        }
    }
}
