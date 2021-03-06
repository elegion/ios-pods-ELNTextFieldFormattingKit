//
//  UIImage+ELNUtils.m
//  Megafon
//
//  Created by Alexander Malnev on 08/12/15.
//  Copyright © 2015 e-legion. All rights reserved.
//

#import "UIImage+ELNUtils.h"

@implementation UIImage (ELNUtils)

+ (UIImage *)eln_imageWithSize:(CGSize)size drawingBlock:(void (^)(CGRect rect, CGContextRef context))drawing
{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect drawingRect = CGRectMake(0, 0, size.width, size.height);

    if (drawing) {
        drawing(drawingRect, context);
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)eln_imageWithColor:(UIColor *)color
{
    return [self eln_imageWithSize:CGSizeMake(1, 1) drawingBlock:^(CGRect rect, CGContextRef context) {
        [color setFill];
        [[UIBezierPath bezierPathWithRect:rect] fill];
    }];
}

+ (UIImage *)eln_ovalImageWithSize:(CGSize)size color:(UIColor *)color fill:(BOOL)fill
{
    return [self eln_imageWithSize:size drawingBlock:^(CGRect rect, CGContextRef context) {
        CGFloat px = 1 / [UIScreen mainScreen].scale;
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:UIEdgeInsetsInsetRect(rect, UIEdgeInsetsMake(px, px, px, px))];
        path.lineWidth = 1;
        
        if (fill) {
            [color setFill];
            [path fill];
        } else {
            [color setStroke];
            [path stroke];
        }
    }];
}

@end
