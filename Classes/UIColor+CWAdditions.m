//
//  UIColor+CWAdditions.m
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

#import "UIColor+CWAdditions.h"


@implementation UIColor (CWAdditions)

+(void)rgba:(CGFloat[4])rgba toHSVA:(CGFloat[4])hsva;
{
	CGFloat h,s,v;
	
	// From Foley and Van Dam
	
	CGFloat max = MAX(rgba[0], MAX(rgba[1], rgba[2]));
	CGFloat min = MIN(rgba[0], MIN(rgba[1], rgba[2]));
	
	// Brightness
	v = max;
	
	// Saturation
	s = (max != 0.0f) ? ((max - min) / max) : 0.0f;
	
	if (s == 0.0f) {
		// No saturation, so undefined hue
		h = 0.0f;
	} else {
		// Determine hue
		CGFloat rc = (max - rgba[0]) / (max - min);		// Distance of color from red
		CGFloat gc = (max - rgba[1]) / (max - min);		// Distance of color from green
		CGFloat bc = (max - rgba[2]) / (max - min);		// Distance of color from blue
		
		if (rgba[0] == max) h = bc - gc;					// resulting color between yellow and magenta
		else if (rgba[1] == max) h = 2 + rc - bc;			// resulting color between cyan and yellow
		else /* if (b == max) */ h = 4 + gc - rc;	// resulting color between magenta and cyan
		
		h *= 60.0f;									// Convert to degrees
		if (h < 0.0f) h += 360.0f;					// Make non-negative
	}
	hsva[0] = h;
	hsva[1] = s;
	hsva[2] = v;
	hsva[3] = rgba[3];
}

-(CGColorSpaceModel) colorSpaceModel;
{  
    return CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor));  
}

-(UIColor*)colorByBlendingWithColor:(UIColor*)color fraction:(CGFloat)fraction;
{
	CGFloat src[4];
    CGFloat dst[4];
    [self getRGBA:src];
    [color getRGBA:dst];
    for (int i = 0; i < 4; i++) {
    	dst[i] = src[i] * fraction + dst[i] * (1 - fraction);
    }
    return [UIColor colorWithRed:dst[0] green:dst[1] blue:dst[2] alpha:dst[3]];
}

-(UIColor*)colorByAddingColor:(UIColor*)color;
{
	CGFloat src[4];
    CGFloat dst[4];
    [self getRGBA:src];
    [color getRGBA:dst];
    for (int i = 0; i < 4; i++) {
    	dst[i] = MIN(1, src[i] + dst[i]);
    }
    return [UIColor colorWithRed:dst[0] green:dst[1] blue:dst[2] alpha:dst[3]];
}

-(UIColor*)colorByMultiplyingColor:(UIColor*)color;
{
	CGFloat src[4];
    CGFloat dst[4];
    [self getRGBA:src];
    [color getRGBA:dst];
    for (int i = 0; i < 4; i++) {
    	dst[i] = src[i] * dst[i];
    }
    return [UIColor colorWithRed:dst[0] green:dst[1] blue:dst[2] alpha:dst[3]];
}

-(CGFloat)alpha; 
{  
    const CGFloat *c = CGColorGetComponents(self.CGColor);  
    return c[CGColorGetNumberOfComponents(self.CGColor)-1];  
}

-(BOOL)canProvideRGBComponents;
{  
    return (([self colorSpaceModel] == kCGColorSpaceModelRGB) ||   
            ([self colorSpaceModel] == kCGColorSpaceModelMonochrome));  
}

-(void)getRGBA:(CGFloat[4])pRGBA;
{
	switch (self.colorSpaceModel) {
        case kCGColorSpaceModelRGB:
            memcpy(pRGBA, CGColorGetComponents(self.CGColor), sizeof(CGFloat) * 4);
            break;
        case kCGColorSpaceModelMonochrome:
            pRGBA[0] = pRGBA[1] = pRGBA[2] = CGColorGetComponents(self.CGColor)[0];
            pRGBA[3] = self.alpha;
            break;
    	default:
            break;
    }
}

-(CGFloat)red;  
{  
    const CGFloat *c = CGColorGetComponents(self.CGColor);  
    return c[0];  
}  

-(CGFloat)green; 
{  
    const CGFloat *c = CGColorGetComponents(self.CGColor);
    if (self.colorSpaceModel == kCGColorSpaceModelMonochrome) {
        return c[0]; 
    }
    return c[1];  
}  

-(CGFloat)blue;
{  
    const CGFloat *c = CGColorGetComponents(self.CGColor);  
    if (self.colorSpaceModel == kCGColorSpaceModelMonochrome) {
        return c[0];
    }
    return c[2];
}

-(BOOL)canProvideHSVComponents;
{
	return [self canProvideRGBComponents];
}

-(void)getHSVA:(CGFloat[4])pHSVA;
{
	CGFloat rgba[4];
    [self getRGBA:rgba];
	[UIColor rgba:rgba toHSVA:pHSVA];
}

-(CGFloat)hue;
{
	CGFloat hsva[4];
    [self getHSVA:hsva];
    return hsva[0];
}

-(CGFloat)saturation;
{
	CGFloat hsva[4];
    [self getHSVA:hsva];
    return hsva[1];
}

-(CGFloat)brightness;
{
	CGFloat hsva[4];
    [self getHSVA:hsva];
    return hsva[2];
}

@end

@implementation UIColor (CWStandardColors)

+(UIColor*)cw_tableSeparatorDarkColor;
{
	return [UIColor colorWithWhite:0.67f alpha:1.0f];    
}

+(UIColor*)cw_tableSeparatorLightColor;
{
	return [UIColor colorWithWhite:0.88f alpha:1.0f];    
}

+(UIColor*)cw_tableBackgroundColor;
{
	return [UIColor colorWithWhite:1.0f alpha:1.0f];    
}

+(UIColor*)cw_tableCellBlueTextColor;
{
	return [UIColor colorWithRed:0.22f green:0.33f blue:0.53f alpha:1.0f];
}

+(UIColor*)cw_tableCellGrayTextColor;
{
	return [UIColor colorWithWhite:0.5f alpha:1.0f];    
}

+(UIColor*)cw_infoTextOverPinStripeTextColor;
{
	return [UIColor colorWithRed:0.30f green:0.34f blue:0.42f alpha:1.0f];
}

+(UIColor*)cw_tableCellValue1BlueColor;
{
	return [UIColor colorWithRed:0.22f green:0.33f blue:0.53f alpha:1.0f];
}

+(UIColor*)cw_tableCellValue2BlueColor;
{
	return [UIColor colorWithRed:0.32f green:0.40f blue:0.57f alpha:1.0f];
}


@end
