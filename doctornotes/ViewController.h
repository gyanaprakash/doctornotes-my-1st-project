//
//  ViewController.h
//  doctornotes
//
//  Created by Mac on 19/12/13.
//  Copyright (c) 2013 nacreservices. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddPatientViewController.h"

@interface ViewController : UIViewController<UINavigationBarDelegate,UINavigationControllerDelegate>
{
    UIButton *addPateintButtn;
    UIButton *pateintDetail;
    UIButton *appointment;
    UIButton *more;
    UIButton *aboutUs; 
}
@property(nonatomic,retain)UIButton *addPateintButtn;
@property(nonatomic,retain)UIButton *pateintDetail;
@property(nonatomic,retain)UIButton*appointment;
@property(nonatomic,retain)UIButton *more;
@property(nonatomic,retain)UIButton *aboutUs;

-(void)buttonClicked:(id)sender;
@end
