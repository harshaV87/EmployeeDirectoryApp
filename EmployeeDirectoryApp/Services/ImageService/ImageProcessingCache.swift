//
//  ImageProcessingCache.swift
//  EmployeeDirectoryApp
//
//  Created by harsha BV on 9/20/23.
//

import Foundation
import UIKit

@MainActor
protocol ImageCacheService {
    var placeHolderTempImage : UIImage {get set}
    func imageFromCache(url: String) -> ImageStroageCache?
    func load(url: String, employeeSummaryItem: EmployeeSummaryLayout, completion: @escaping (EmployeeSummaryLayout, UIImage?) -> Void)
}

@MainActor
final class ImageProcessingCache: ImageCacheService {
    // temp image while images are loading here
    var placeHolderTempImage: UIImage = UIImage(named: "loaderDefault") ??  UIImage(systemName: "square.and.arrow.up")!
    // cache of images - key as the url string itself
    private let cachedImages = NSCache<NSString, ImageStroageCache>()
    // loading responses as an array for each item
    private var loadingResponsesForimageResponses = [NSString : [(EmployeeSummaryLayout, UIImage?) -> Void]]()
    
    // get from cache
    func imageFromCache(url: String) -> ImageStroageCache? {
        // image from cache
        return cachedImages.object(forKey: NSString(string: url))
    }
    
    func load(url: String, employeeSummaryItem: EmployeeSummaryLayout, completion: @escaping (EmployeeSummaryLayout, UIImage?) -> Void) {
        // start check with cachedImage
        if let cachedAvailableImage = imageFromCache(url: url) {
            // as it is a main actor, we dont need to dispatch it on main thread
            completion(employeeSummaryItem, cachedAvailableImage.image)
            // we dont want it to continue
            return
        }
         //accounting for multiple requests as it is async
        if loadingResponsesForimageResponses[NSString(string: url)] != nil {
            loadingResponsesForimageResponses[NSString(string: url)]?.append(completion)
            return
        } else {
            loadingResponsesForimageResponses[NSString(string: url)] = [completion]
        }
        // if no available image in cache, we have to retrieve it
        guard let URL = URL(string: url) else {return}
        URLSession.shared.dataTask(with: URL) { data, response, error in
            if error == nil {
                guard let data = data, let outputImage = UIImage(data: data)
                ,let blocks = self.loadingResponsesForimageResponses[NSString(string: url)]
                else {
                    completion(employeeSummaryItem, nil)
                    return
                }
                // if none of them fails and it fall through, cache images
                self.cachedImages.setObject(ImageStroageCache(image: outputImage), forKey: NSString(string: url), cost: data.count)
                for block in blocks {
                    // all added requests
                    block(employeeSummaryItem, outputImage)
                }
                return
            }
        }.resume()
    }
    
    
    
    
}



