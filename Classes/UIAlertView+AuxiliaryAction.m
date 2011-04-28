//
//  UIActionSheet+AuxiliaryAction.m
//  CWAuxiliaryActions
//
//  Created by Fredrik Olsson on 2011-04-12.
//  Copyright 2011 Jayway. All rights reserved.
//

#import "CWAuxiliaryAction.h"
#import <objc/runtime.h>

@interface CWAlertViewAuxiliaryActionsDelegate : NSObject <UIAlertViewDelegate> {
@private
	NSArray* _actions;
}

-(id)initWithAuxiliaryActions:(NSArray*)actions;

@end


@implementation UIAlertView (AuxiliaryAction)

static void* actionKey = "auxiliaryActionsKey"; 
static void* dismissKey = "dismissHandlerKey"; 

-(CWAuxiliaryActionHandler)dismissHandler;
{
	return objc_getAssociatedObject(self, dismissKey);
}

-(void)setDismissHandler:(CWAuxiliaryActionHandler)handler;
{
	objc_setAssociatedObject(self, dismissKey, handler, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

+(UIAlertView*)alertViewWithTitle:(NSString*)title message:(NSString*)message auxiliaryActions:(NSArray*)actions cancelButtonTitle:(NSString*)cancelTitle;
{
    CWAlertViewAuxiliaryActionsDelegate* delegate = [[[CWAlertViewAuxiliaryActionsDelegate alloc] initWithAuxiliaryActions:actions] autorelease];
	UIAlertView* alert = [[[UIAlertView alloc] initWithTitle:title
                                                     message:message
                                                    delegate:delegate
                                           cancelButtonTitle:cancelTitle
                                           otherButtonTitles:nil] autorelease];
    for (CWAuxiliaryAction* action in actions) {
        [alert addButtonWithTitle:action.localizedTitle];
    }
    objc_setAssociatedObject(alert, actionKey, delegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return alert;
}

+(UIAlertView*)alertViewWithTitle:(NSString*)title message:(NSString*)message cancelButtonTitle:(NSString*)cancelTitle otherTitlesAndAuxiliaryActions:(NSString*)firstTitle, ...;
{
	NSMutableArray* actions = [NSMutableArray array];
    va_list vl;
    NSString* buttonTitle = firstTitle;
    va_start(vl, firstTitle);
    while (buttonTitle) {
    	CWAuxiliaryActionHandler handler = va_arg(vl, CWAuxiliaryActionHandler);
        [actions addObject:[CWAuxiliaryAction actionWithTitle:buttonTitle handler:handler]];
        buttonTitle = va_arg(vl, NSString*);
    }
    va_end(vl);
    return [self alertViewWithTitle:title message:message auxiliaryActions:actions cancelButtonTitle:cancelTitle];
}

@end


@implementation CWAlertViewAuxiliaryActionsDelegate

-(id)initWithAuxiliaryActions:(NSArray*)actions;
{
	self = [self init];
    if (self) {
    	_actions = [actions copy];
    }
    return self;
}

-(void)dealloc;
{
	[_actions release];
    [super dealloc];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
{
	NSString* title = [alertView buttonTitleAtIndex:buttonIndex];
    for (CWAuxiliaryAction* action in _actions) {
    	if ([title isEqualToString:action.localizedTitle]) {
        	action.handler(action);
            return;
        }
    }
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex;
{
	CWAuxiliaryActionHandler handler = alertView.dismissHandler;
    if (handler) {
        NSString* title = [alertView buttonTitleAtIndex:buttonIndex];
        for (CWAuxiliaryAction* action in _actions) {
            if ([title isEqualToString:action.localizedTitle]) {
                handler(action);
                return;
            }
        }
        handler(nil);
    }
}

@end

