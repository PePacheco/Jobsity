//
//  Box.swift
//  Jobsity-Test
//
//  Created by Pedro Gomes Rubbo Pacheco on 21/02/22.
//

import Foundation

class Box<T> {
    typealias Listener = (T) -> Void
    var listener: Listener?

    func bind(listener: Listener?) {
        self.listener = listener
    }

    func bindAndFire(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
    
    func fire() {
        listener?(value)
    }

    var value: T {
        didSet {
            listener?(value)
        }
    }

    init(_ v: T) {
        value = v
    }

}
