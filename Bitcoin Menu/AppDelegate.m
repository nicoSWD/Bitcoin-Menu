//
//  AppDelegate.m
//  Bitcoin Menu
//
//  Created by Nicolas Oelgart on 23/11/13.
//  Copyright (c) 2013 Nicolas Oelgart. All rights reserved.
//

#import "AppDelegate.h"
#import "AFNetworking.h"

static NSString *currentCurrency = @"USD";

@implementation AppDelegate


- (void)awakeFromNib
{
    statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [statusItem setMenu:statusMenu];
    [statusItem setTitle:@"Loading..."];
    [statusItem setImage:[NSImage imageNamed:@"bitcoin"]];
    [statusItem setAlternateImage:[NSImage imageNamed:@"bitcoin-alt"]];
    [statusItem setHighlightMode:YES];
    
    [self reloadData];
    [NSTimer scheduledTimerWithTimeInterval:20.0 target:self selector:@selector(reloadData) userInfo:nil repeats:YES];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *currency = [defaults objectForKey:@"selected-currency"];
    
    if (currency)
    {
        currentCurrency = currency;
    }
}


- (void)reloadData
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://blockchain.info/ticker" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        self.prices = (NSDictionary*)responseObject;
        
        [statusMenu removeAllItems];
        statusItem.title = [NSString stringWithFormat:@"%01.2f %@",
                            [[[responseObject objectForKey:currentCurrency] objectForKey:@"15m"] floatValue],
                            [[responseObject objectForKey:currentCurrency] objectForKey:@"symbol"]];
        
        NSString *title;
        
        for (NSString *currency in responseObject)
        {
            title = [NSString stringWithFormat:@"%@: %01.2f %@",
                     currency,
                     [[[responseObject objectForKey:currency] objectForKey:@"15m"] floatValue],
                     [[responseObject objectForKey:currency] objectForKey:@"symbol"]];
            
            [statusMenu addItemWithTitle:title action:@selector(setDefaultCurrency:) keyEquivalent:@""];
        }
        
        [statusMenu addItem:[NSMenuItem separatorItem]];
        [statusMenu addItemWithTitle:@"Quit" action:@selector(terminate:) keyEquivalent:@""];
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        NSLog(@"Error: %@", error);
    }];
}


- (void)setDefaultCurrency:(NSMenuItem*)clickedItem
{
    long menuItemIndex = (long)[statusMenu indexOfItem:clickedItem];
    currentCurrency = [self.prices.allKeys objectAtIndex:menuItemIndex];

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:currentCurrency forKey:@"selected-currency"];
    [defaults synchronize];
    
    [self reloadData];
}

@end