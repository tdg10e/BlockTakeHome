//
//  Debouncer.swift
//  BlockTakeHome
//
//  Created by Tremaine Grant on 7/19/23.
//

import Foundation

class Debouncer {
    private var timer: Timer?
    private let delay: TimeInterval

    var callback: (() -> Void)?

    init(delay: TimeInterval) {
        self.delay = delay
    }

    func call() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: delay, repeats: false) { [weak self] _ in
            self?.callback?()
        }
    }
}
