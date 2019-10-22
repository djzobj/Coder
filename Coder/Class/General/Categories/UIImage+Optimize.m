//
//  UIImage+Optimize.m
//  Coder
//
//  Created by 张得军 on 2019/10/21.
//  Copyright © 2019 张得军. All rights reserved.
//

#import "UIImage+Optimize.h"

@implementation UIImage (Optimize)

- (UIImage *)thumbnailImageForPath:(NSString *)path imageSize:(int)imageSize {
    CGImageRef thumbnailImage;
    CGImageSourceRef imageSource;
    
    CFDictionaryRef imageOptions;
    CFStringRef imageKeys[3];
    CFTypeRef imageValues[3];
    
    CFNumberRef thumbnailSize;
    NSURL *url = [NSURL fileURLWithPath:path];
    //先判断数据是否存在
    imageSource = CGImageSourceCreateWithURL((CFURLRef)url, NULL);
    
    if (imageSource == NULL) {
        fprintf(stderr, "Image source is NULL.");
        return  NULL;
    }
    //创建缩略图等比缩放大小，会根据长宽值比较大的作为imageSize进行缩放
    thumbnailSize = CFNumberCreate(NULL, kCFNumberIntType, &imageSize);
    
    imageKeys[0] = kCGImageSourceCreateThumbnailWithTransform;
    imageValues[0] = (CFTypeRef)kCFBooleanTrue;
    
    imageKeys[1] = kCGImageSourceCreateThumbnailFromImageIfAbsent;
    imageValues[1] = (CFTypeRef)kCFBooleanTrue;
    //缩放键值对
    imageKeys[2] = kCGImageSourceThumbnailMaxPixelSize;
    imageValues[2] = (CFTypeRef)thumbnailSize;
    imageOptions = CFDictionaryCreate(NULL, (const void **) imageKeys,
                                      (const void **) imageValues, 3,
                                      &kCFTypeDictionaryKeyCallBacks,
                                      &kCFTypeDictionaryValueCallBacks);
    //获取缩略图
    thumbnailImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, imageOptions);
    CFRelease(imageOptions);
    CFRelease(thumbnailSize);
    CFRelease(imageSource);
    
    if (thumbnailImage == nil) {
        return nil;
    }
    return [UIImage imageWithCGImage:thumbnailImage];
}

@end
