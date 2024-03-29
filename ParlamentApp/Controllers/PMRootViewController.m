//
//  PMRootViewController.m
//  ParlamentApp
//
//  Created by DenisDbv on 07.12.13.
//  Copyright (c) 2013 brandmill. All rights reserved.
//

#import "PMRootViewController.h"
#import "PMRootMenuController.h"
#import "PMRegistrationVC.h"
#import <MZFormSheetController/MZFormSheetController.h>

@interface PMRootViewController ()

@end

@implementation PMRootViewController
{
    MZFormSheetController *registraionSheet;
    MZFormSheetController *formSheet;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self windowInitiailization];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

-(void) windowInitiailization
{
    PMRootMenuController *rootMenuViewController = [[PMRootMenuController alloc] initWithNibName:@"PMRootMenuController" bundle:[NSBundle mainBundle]];
    
    if( IS_OS_7_OR_LATER )  {
        formSheet = [[MZFormSheetController alloc] initWithSize:self.view.bounds.size viewController:rootMenuViewController];
        formSheet.transitionStyle = MZFormSheetTransitionStyleFade;
        [formSheet presentFormSheetController:formSheet animated:NO completionHandler:^(MZFormSheetController *formSheetController) {
            NSLog(@"Root menu view controller present");
            
            [registraionSheet dismissFormSheetControllerAnimated:NO completionHandler:^(MZFormSheetController *formSheetController) {
                //
            }];
        }];
    } else  {
        UINavigationController *navCntrl = [[UINavigationController alloc] init];
        navCntrl.navigationBarHidden = YES;
        
        [[MZFormSheetBackgroundWindow appearance] setBackgroundColor:(__bridge CGColorRef)([UIColor clearColor])];
        [self presentFormSheetWithViewController:navCntrl animated:NO transitionStyle:MZFormSheetTransitionStyleFade completionHandler:^(MZFormSheetController *formSheetController) {
            formSheetController.landscapeTopInset = 0.0f;
            //formSheetController.transitionStyle = MZFormSheetTransitionStyleFade;
            [formSheetController presentViewController:rootMenuViewController animated:YES completion:^{
                
            }];
        }];
    }
}

-(void) closeRegistrationAndOpenApp
{
    PMRootMenuController *rootMenuViewController = [[PMRootMenuController alloc] initWithNibName:@"PMRootMenuController" bundle:[NSBundle mainBundle]];
    
    formSheet = [[MZFormSheetController alloc] initWithSize:self.view.bounds.size viewController:rootMenuViewController];
    formSheet.transitionStyle = MZFormSheetTransitionStyleFade;
    [formSheet presentFormSheetController:formSheet animated:NO completionHandler:^(MZFormSheetController *formSheetController) {
        NSLog(@"Root menu view controller present");
        
        [registraionSheet dismissFormSheetControllerAnimated:NO completionHandler:^(MZFormSheetController *formSheetController) {
            //
        }];
    }];
}

-(void) closeAppAndOpenRegistration
{
    PMRegistrationVC *rootMenuViewController = [[PMRegistrationVC alloc] initWithNibName:@"PMRegistrationVC" bundle:[NSBundle mainBundle]];
    
    registraionSheet = [[MZFormSheetController alloc] initWithSize:self.view.bounds.size viewController:rootMenuViewController];
    registraionSheet.transitionStyle = MZFormSheetTransitionStyleFade;
    [registraionSheet presentFormSheetController:registraionSheet animated:NO completionHandler:^(MZFormSheetController *formSheetController) {
        NSLog(@"Registartion view controller present");
        
        [formSheet dismissFormSheetControllerAnimated:NO completionHandler:^(MZFormSheetController *formSheetController) {
            //
        }];
    }];
}

@end
