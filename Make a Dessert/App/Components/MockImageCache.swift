//
//  MockImageCache.swift
//  Make a Dessert
//
//  Created by Rafaela on 5/13/23.
//

import Foundation
import SwiftUI

class MockImageCache {
    static private var cache: [URL: Image] = [:]
    static private var lock: NSLock = NSLock()
    
    static subscript(url: URL) -> Image? {
        get {
            lock.lock(); defer { lock.unlock() }
            return cache[url]
        }
        set {
            lock.lock(); defer { lock.unlock() }
            cache[url] = newValue
        }
    }
}
