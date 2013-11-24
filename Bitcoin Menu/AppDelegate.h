//
//  AppDelegate.h
//  Bitcoin Menu
//
//  Created by Nicolas Oelgart on 23/11/13.
//  Copyright (c) 2013 Nicolas Oelgart. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>
{
    IBOutlet NSMenu *statusMenu;
    NSStatusItem *statusItem;
}

- (void)reloadData;
- (void)setDefaultCurrency:(NSMenuItem*)clickedItem;

@property (assign) IBOutlet NSWindow *window;
@property (nonatomic, retain) NSDictionary *prices;

@end
