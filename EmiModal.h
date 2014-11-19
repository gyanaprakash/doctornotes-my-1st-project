//
//  EmiModal.h
//  doctornotes
//
//  Created by Gyana on 06/10/2014.
//  Copyright (c) 2014 nacreservices. All rights reserved.
//

#import <Foundation/Foundation.h>

//**************************************************************************************************************************

#define ALERT_VIEW(title,msg) [[[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show]

#define PLIST_NAME @"PersonalData.plist"

#define POP_TO_VIEWCONTROLLER_ANIMATED [self.navigationController popViewControllerAnimated:YES]

#define SHARED_APPLICATION(URL) [[UIApplication sharedApplication]openURL:[NSURL URLWithString:URL]];

//**************************************************************************************************************************

@interface EmiModal : NSObject

@end
