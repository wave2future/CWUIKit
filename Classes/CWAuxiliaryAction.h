//
//  CWAuxiliaryAction.h
//  eBokus
//
//  Created by Fredrik Olsson on 2011-03-10.
//  Copyright 2011 Jayway. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CWAuxiliaryAction;
typedef void (^CWAuxiliaryActionHandler)(CWAuxiliaryAction*);

@interface CWAuxiliaryAction : NSObject {
@private
    NSString* _title;
    CWAuxiliaryActionHandler _handler;
    NSInteger _tag;
}

@property (nonatomic, copy, readonly) NSString* localizedTitle;
@property (nonatomic, copy, readonly) CWAuxiliaryActionHandler handler;
@property (nonatomic, assign) NSInteger tag;

+(id)actionWithTitle:(NSString*)title handler:(CWAuxiliaryActionHandler)handler;
+(id)actionWithTitle:(NSString*)title handler:(CWAuxiliaryActionHandler)handler tag:(NSInteger)tag;
-(id)initWithLocalizedTitle:(NSString*)title handler:(CWAuxiliaryActionHandler)handler;

@end


@interface UIAlertView (AuxiliaryAction)

@property (nonatomic, copy) CWAuxiliaryActionHandler dismissHandler;

+(UIAlertView*)alertViewWithTitle:(NSString*)title message:(NSString*)message auxiliaryActions:(NSArray*)actions cancelButtonTitle:(NSString*)cancelTitle;
+(UIAlertView*)alertViewWithTitle:(NSString*)title message:(NSString*)message cancelButtonTitle:(NSString*)cancelTitle otherTitlesAndAuxiliaryActions:(NSString*)firstTitle, ... NS_REQUIRES_NIL_TERMINATION;

@end


@interface UIActionSheet (AuxiliaryAction)

@property (nonatomic, copy) CWAuxiliaryActionHandler dismissHandler;

+(UIActionSheet*)actionSheetWithAuxiliaryActions:(NSArray*)actions cancelButtonTitle:(NSString*)cancelTitle;
+(UIActionSheet*)actionSheetWithCancelButtonTitle:(NSString*)cancelTitle otherTitlesAndAuxiliaryActions:(NSString*)firstTitle, ... NS_REQUIRES_NIL_TERMINATION;

@end
