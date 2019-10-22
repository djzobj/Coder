//
//  Test.swift
//  Coder
//
//  Created by 张得军 on 2019/10/18.
//  Copyright © 2019 张得军. All rights reserved.
//

import Foundation
import UIKit

class TestController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let systemGesture = interactivePopGestureRecognizer else {return}
        
        let targets = systemGesture.value(forKey: "_targets") as? [NSObject]
        
        guard let targetObjc = targets?.first else {return}
        
        guard let target = targetObjc.value(forKey: "target") else {return}
        
        let action = Selector(("handleNavigationTransition:"))
        
        let customGesture = UIPanGestureRecognizer()
        customGesture.addTarget(target, action: action)
        
        guard let gestureView = systemGesture.view else {return}
        gestureView.addGestureRecognizer(customGesture)
        
    }
    
    func downsample(imageAt imageURL: URL, to pointSize: CGSize, scale: CGFloat) -> UIImage
        {
            let sourceOpt = [kCGImageSourceShouldCache : false] as CFDictionary
            // 其他场景可以用createwithdata (data并未decode,所占内存没那么大),
            let source = CGImageSourceCreateWithURL(imageURL as CFURL, sourceOpt)!
            
            let maxDimension = max(pointSize.width, pointSize.height) * scale
            let downsampleOpt = [kCGImageSourceCreateThumbnailFromImageAlways : true,
                                 kCGImageSourceShouldCacheImmediately : true ,
                                 kCGImageSourceCreateThumbnailWithTransform : true,
                                 kCGImageSourceThumbnailMaxPixelSize : maxDimension] as CFDictionary
            let downsampleImage = CGImageSourceCreateThumbnailAtIndex(source, 0, downsampleOpt)!
            return UIImage(cgImage: downsampleImage)
    }
}
