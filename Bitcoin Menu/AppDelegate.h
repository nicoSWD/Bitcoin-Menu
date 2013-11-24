//
//  AppDelegate.h
//  Bitcoin Menu
//
//  Created by Nicolas Oelgart on 23/11/13.
//  Copyright (c) 2013 Nicolas Oelgart. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate, NSMenuDelegate>
{
    IBOutlet NSMenu *statusMenu;
    NSStatusItem *statusItem;
}


@property (assign) IBOutlet NSWindow *window;
@property (nonatomic, retain) NSDictionary *prices;

@end
