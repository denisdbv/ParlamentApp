//
//  PMRootMenuController.m
//  ParlamentApp
//
//  Created by DenisDbv on 06.12.13.
//  Copyright (c) 2013 brandmill. All rights reserved.
//

#import "PMRootMenuController.h"

#import "PMSettingsViewContoller.h"
#import "PMVoiceVisualizationVC.h"
#import "UIView+GestureBlocks.h"

@interface PMRootMenuController ()

@end

@implementation PMRootMenuController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (IBAction)onButton:(id)sender
{
    /*PMSettingsViewContoller *settingVC = [[PMSettingsViewContoller alloc] initWithNibName:@"PMSettingsViewContoller" bundle:[NSBundle mainBundle]];
    
    MZFormSheetController *formSheet = [[MZFormSheetController alloc] initWithSize:self.view.bounds.size viewController:settingVC];
    [formSheet presentFormSheetController:formSheet animated:YES completionHandler:^(MZFormSheetController *formSheetController) {
        //
    }];*/
}
@end
