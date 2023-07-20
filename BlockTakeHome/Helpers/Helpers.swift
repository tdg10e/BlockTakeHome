//
//  Helpers.swift
//  BlockTakeHome
//
//  Created by Tremaine Grant on 7/19/23.
//

import Foundation

@discardableResult public func main(closure: @escaping () -> Void) -> DispatchWorkItem {
    let task = DispatchWorkItem(block: closure)
    DispatchQueue.main.async(
        execute: task)
    return task
}
