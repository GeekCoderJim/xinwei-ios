//
//  UIImage+Extension.h
//
//
//  Created by Ck_Mac on 14-10-3.
//  Copyright (c) 2014年 ck. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

//+(UIImage *)imageWithName:(NSString *)name;
+ (UIImage *)animatedGIFNamed:(NSString *)name;
+ (CGSize) getImageSizeWithImageName:(NSString*)imageName;
+ (UIImage *)compressWithImageName:(UIImage *)imageIcon;
+ (UIImage *) compressAndProportionWithImageName:(UIImage *)sourceImage;
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
@end
