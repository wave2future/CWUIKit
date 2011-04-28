//
//  SampleAppAppDelegate.m
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

#import "SampleAppAppDelegate.h"

@implementation SampleAppAppDelegate

@synthesize window;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
{    
 	calloutView = [[CWCalloutView alloc] initWithFrame:CGRectMake(0, 0, 120, CWCalloutViewMinimumSize.height)];   
	calloutView.title = @"Title";
    calloutView.subtitle = @"Subtitle";
    UIPanGestureRecognizer* recognizer = [[[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                  action:@selector(didPan:)] autorelease];
    [self.window addGestureRecognizer:recognizer];
    [self.window makeKeyAndVisible];
    
    return YES;
}

-(void)hideCalloutView;
{
	[calloutView dismissAnimated:YES];
}

-(void)didPan:(UIPanGestureRecognizer*)recognizer;
{
	[UIView cancelPreviousPerformRequestsWithTarget:self
                                           selector:@selector(hideCalloutView)
                                             object:nil];
    switch (recognizer.state) {
    	case UIGestureRecognizerStateBegan:
        case UIGestureRecognizerStateChanged:
            [calloutView showFromAnchorPoint:[recognizer locationInView:self.window]
                                      inView:self.window
                                    animated:YES];
            break;
    	default:
            [self performSelector:@selector(hideCalloutView)
                       withObject:nil
                       afterDelay:1.0];
    }
}


@end
