//
//  ImageURLRetrievalService.swift
//  EmployeeDirectoryApp
//
//  Created by harsha BV on 9/20/23.
//

import Foundation
import UIKit

    
class ImageStroageCache: NSObject, NSDiscardableContent {
    
    // also helps us to keep saved images from cache even after the application is in background state - Reduces server retrieval
    public var image : UIImage
    
     init(image: UIImage) {
        self.image = image
    }
    
    func beginContentAccess() -> Bool {
        return true
    }
    
    func endContentAccess() {
        // not needed in this context
    }
    
    func discardContentIfPossible() {
        // not needed in this context
    }
    
    func isContentDiscarded() -> Bool {
        return false
    }
}
