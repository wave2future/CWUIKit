//
//  CWGeometry.h
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
//     * Neither the name of Jayway AB nor the names of its contributors may 
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

#import <UIKit/UIKit.h>


CG_INLINE CGSize
CWCGPointDictance(CGPoint p1, CGPoint p2)
{
    return CGSizeMake(p2.x - p1.x, p2.y - p1.y);
}


CG_INLINE CGPoint
CWCGRectCenter(CGRect r) {
    return CGPointMake(r.origin.x + r.size.width / 2, 
                       r.origin.y + r.size.height / 2);
}

CG_INLINE BOOL 
CWRectFitsRect(CGRect rect1, CGRect rect2) {
	return (rect1.size.width <= rect2.size.width && rect1.size.height <= rect2.size.height);
}

CG_INLINE CGRect 
CWRectScaleToFillRect(CGRect rect1, CGRect rect2) {
	CGFloat ratio = rect1.size.height / rect1.size.width;
    CGRect rect = CGRectMake(rect1.origin.x, rect1.origin.y, rect2.size.width, rect2.size.width * ratio);
    if (!CWRectFitsRect(rect, rect2)) {
        rect = CGRectMake(rect1.origin.x, rect1.origin.y, rect2.size.height / ratio, rect2.size.height);
	}
    return rect;
}

CG_INLINE CGRect 
CWRectCenterInRect(CGRect rect1, CGRect rect2) {
	CGFloat x = rect2.origin.x + (rect2.size.width - rect1.size.width) / 2;
	CGFloat y = rect2.origin.y + (rect2.size.height - rect1.size.height) / 2;
	return CGRectMake(x, y, rect1.size.width, rect1.size.height);
}

CG_INLINE CGRect 
CWRectFitAndCenterInRect(CGRect rect1, CGRect rect2) {
	if (!CWRectFitsRect(rect1, rect2)) {
		rect1 = CWRectScaleToFillRect(rect1, rect2);
    }
    return CWRectCenterInRect(rect1, rect2);
}
