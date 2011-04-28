//
//  UIImage+CWResize.m
//  CWUIKit
//  Created by Fredrik Olsson 
//
//  Copyright (c) 2011, Jayway AB All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * Neither the name of the Jayway nor the names of its contributors may 
//       be used to endorse or promote products derived from this software 
//       without specific prior written permission.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
//  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
//  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
//  DISCLAIMED. IN NO EVENT SHALL JAYWAY AB BE LIABLE FOR ANY DIRECT, INDIRECT, 
//  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT 
//  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR 
//  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF 
//  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE 
//  OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF 
//  ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

#import "UIImage+CWResize.h"


@implementation UIImage (CWResize)

-(UIImage*)imageByResizingToFitSize:(CGSize)size scaleUpIfNeeded:(BOOL)scaleUp;
{
    CGSize originalSize = self.size;
    if (scaleUp || (size.width < originalSize.width) || (size.height < originalSize.height)) {
        CGRect rect = CGRectZero;
        if (originalSize.width > originalSize.height) {
            rect.size = CGSizeMake(size.width, size.height * (originalSize.height / originalSize.width));
        } else {
            rect.size = CGSizeMake(size.width * (originalSize.width / originalSize.height), size.height);
        }
        UIGraphicsBeginImageContext(rect.size);
        [self drawInRect:rect];
        UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image;
    } else {
    	return [[self retain] autorelease];
    }	
}

-(UIImage*)imageByApsectFillToSize:(CGSize)size withInset:(UIEdgeInsets)insets;
{
    UIGraphicsBeginImageContext(size);
    size = UIEdgeInsetsInsetRect(CGRectMake(0, 0, size.width, size.height), insets).size;
    CGSize originalSize = self.size;
    CGRect rect;
    if (originalSize.width > originalSize.height) {
        rect.size = CGSizeMake(size.width, size.height * (originalSize.height / originalSize.width));
        rect.origin = CGPointMake(insets.left, insets.top + (size.height - rect.size.height) / 2);
    } else {
        rect.size = CGSizeMake(size.width * (originalSize.width / originalSize.height), size.height);
        rect.origin = CGPointMake(insets.left +(size.width - rect.size.width) / 2, insets.top);
    }
    [self drawInRect:rect];
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

-(UIImage*)imageCroppedToSquareWithSide:(CGFloat)sideLength;
{
	// used code from http://www.nickkuh.com/iphone/how-to-create-square-thumbnails-using-iphone-sdk-cg-quartz-2d/2010/03/	
	

	UIImageView *mainImageView = [[UIImageView alloc] initWithImage:self];
	BOOL widthGreaterThanHeight = (self.size.width > self.size.height);
	float sideFull = (widthGreaterThanHeight) ? self.size.height : self.size.width;
	CGRect clippedRect = CGRectMake(0, 0, sideFull, sideFull);
	//creating a square context the size of the final image which we will then
	// manipulate and transform before drawing in the original image
	UIGraphicsBeginImageContext(CGSizeMake(sideLength, sideLength));
	CGContextRef currentContext = UIGraphicsGetCurrentContext();
	CGContextClipToRect( currentContext, clippedRect);
	CGFloat scaleFactor = sideLength/sideFull;
	if (widthGreaterThanHeight) {
		//a landscape image – make context shift the original image to the left when drawn into the context
		CGContextTranslateCTM(currentContext, - ((self.size.width - sideFull) /2 ) * scaleFactor, 0);
	}
	else {
		//a portfolio image – make context shift the original image upwards when drawn into the context
		CGContextTranslateCTM(currentContext, 0, -((self.size.height - sideFull) / 2) * scaleFactor);
	}
	CGContextScaleCTM(currentContext, scaleFactor, scaleFactor);
	[mainImageView.layer renderInContext:currentContext];
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	[mainImageView release];
	return image;
}

@end
