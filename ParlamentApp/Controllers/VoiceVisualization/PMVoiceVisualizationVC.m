//
//  PMVoiceVisualizationVC.m
//  ParlamentApp
//
//  Created by DenisDbv on 06.12.13.
//  Copyright (c) 2013 brandmill. All rights reserved.
//

#import "PMVoiceVisualizationVC.h"
#import "UIImage+UIImageFunctions.h"
#import "UIView+GestureBlocks.h"
#import <MZTimerLabel/MZTimerLabel.h>
#import "UIView+Screenshot.h"
#import "NSString+SizeToFit.h"
#import "PMImageReviewController.h"

@interface PMVoiceVisualizationVC ()

@end

@implementation PMVoiceVisualizationVC
{
    UIButton *closeButton;
    UIButton *saveButton;
    UIButton *resetButton;
    UIButton *settingButton;
    
    BOOL attractorIsFullView;
    
    MZTimerLabel *timer;
    
    UIActivityIndicatorView *saveIndicator;
    
    UIImageView *arrowsFullView;
    
    PMMailManager *mailManager;
    UIImage *attractorSnapshot;
}
@synthesize attractorView;
@synthesize titleLabel1, titleLabel2, titleLabel3, titleLabel4;
@synthesize timerLabel;

@synthesize finishView, finishTitle1, finishTitle2, finishTitle3, finishTitle4;

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
    
    self.navigationController.navigationBarHidden = YES;
    
    if(!IS_OS_7_OR_LATER)
        [[AppDelegateInstance() rippleViewController] disableDraw:YES];
    
    finishView.alpha = 0;
    finishView.backgroundColor = [UIColor clearColor];
    
    finishTitle1.font = [UIFont fontWithName:@"MyriadPro-Cond" size:30.0];
    finishTitle1.backgroundColor = [UIColor clearColor];
    finishTitle1.textColor = [UIColor colorWithRed:216.0/255.0 green:219.0/255.0 blue:228.0/255.0 alpha:1.0];
    finishTitle1.textAlignment = NSTextAlignmentCenter;
    
    finishTitle2.font = [UIFont fontWithName:@"MyriadPro-Cond" size:30.0];
    finishTitle2.backgroundColor = [UIColor clearColor];
    finishTitle2.textColor = [UIColor colorWithRed:216.0/255.0 green:219.0/255.0 blue:228.0/255.0 alpha:1.0];
    finishTitle2.textAlignment = NSTextAlignmentCenter;
    
    finishTitle3.font = [UIFont fontWithName:@"MyriadPro-Cond" size:15.0];
    finishTitle3.backgroundColor = [UIColor clearColor];
    finishTitle3.textColor = [UIColor colorWithRed:216.0/255.0 green:219.0/255.0 blue:228.0/255.0 alpha:1.0];
    finishTitle3.textAlignment = NSTextAlignmentCenter;
    
    finishTitle4.font = [UIFont fontWithName:@"MyriadPro-Cond" size:45.0];
    finishTitle4.backgroundColor = [UIColor clearColor];
    finishTitle4.textColor = [UIColor colorWithRed:216.0/255.0 green:219.0/255.0 blue:228.0/255.0 alpha:1.0];
    finishTitle4.textAlignment = NSTextAlignmentCenter;
    
    attractorIsFullView = NO;
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.height;
    
    UIImage *closeImage = [[UIImage imageNamed:@"close-voice.png"] scaleProportionalToRetina];
    closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton addTarget:self action:@selector(onVoiceClose:) forControlEvents:UIControlEventTouchUpInside];
    [closeButton setImage:closeImage forState:UIControlStateNormal];
    [closeButton setImage:closeImage forState:UIControlStateHighlighted];
    closeButton.frame = CGRectMake(139.0, 313.0, closeImage.size.width, closeImage.size.height);
    [self.view addSubview:closeButton];
    
    UIImage *saveVoiceImage = [[UIImage imageNamed:@"save-voice.png"] scaleProportionalToRetina];
    saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveButton addTarget:self action:@selector(onVoiceSave:) forControlEvents:UIControlEventTouchUpInside];
    [saveButton setImage:saveVoiceImage forState:UIControlStateNormal];
    [saveButton setImage:saveVoiceImage forState:UIControlStateHighlighted];
    saveButton.frame = CGRectMake(766.0, 313.0, saveVoiceImage.size.width, saveVoiceImage.size.height);
    [self.view addSubview:saveButton];
    
    UIImage *resetVoiceImage = [[UIImage imageNamed:@"reset-voice.png"] scaleProportionalToRetina];
    resetButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [resetButton addTarget:self action:@selector(onVoiceReset:) forControlEvents:UIControlEventTouchUpInside];
    [resetButton setImage:resetVoiceImage forState:UIControlStateNormal];
    [resetButton setImage:resetVoiceImage forState:UIControlStateHighlighted];
    resetButton.frame = CGRectMake(401.0, 650.0, resetVoiceImage.size.width, resetVoiceImage.size.height);
    [self.view addSubview:resetButton];
    
    UIImage *settingImage = [[UIImage imageNamed:@"settings-close.png"] scaleProportionalToRetina];
    settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    settingButton.alpha = 0.0;
    [settingButton addTarget:self action:@selector(onSettingClose:) forControlEvents:UIControlEventTouchUpInside];
    [settingButton setImage:settingImage forState:UIControlStateNormal];
    [settingButton setImage:settingImage forState:UIControlStateHighlighted];
    settingButton.frame = CGRectMake(screenWidth - settingImage.size.width - 10, 10, settingImage.size.width, settingImage.size.height);
    [self.view addSubview:settingButton];
    
    titleLabel1.font = [UIFont fontWithName:@"MyriadPro-Cond" size:22.0];
    titleLabel1.backgroundColor = [UIColor clearColor];
    titleLabel1.textColor = [UIColor colorWithRed:216.0/255.0 green:219.0/255.0 blue:228.0/255.0 alpha:1.0];
    titleLabel1.textAlignment = NSTextAlignmentCenter;
    
    titleLabel2.font = [UIFont fontWithName:@"MyriadPro-Cond" size:22.0];
    titleLabel2.backgroundColor = [UIColor clearColor];
    titleLabel2.textColor = [UIColor colorWithRed:216.0/255.0 green:219.0/255.0 blue:228.0/255.0 alpha:1.0];
    titleLabel2.textAlignment = NSTextAlignmentCenter;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    titleLabel2.text = [NSString stringWithFormat:@"%@, СКАЖИТЕ СВОИ ДАННЫЕ В МИКРОФОН", [userDefaults objectForKey:@"_firstname"]];
    
    titleLabel3.font = [UIFont fontWithName:@"MyriadPro-Cond" size:15.0];
    titleLabel3.backgroundColor = [UIColor clearColor];
    titleLabel3.textColor = [UIColor colorWithRed:216.0/255.0 green:219.0/255.0 blue:228.0/255.0 alpha:1.0];
    titleLabel3.textAlignment = NSTextAlignmentCenter;
    
    titleLabel4.font = [UIFont fontWithName:@"MyriadPro-Cond" size:15.0];
    titleLabel4.backgroundColor = [UIColor clearColor];
    titleLabel4.textColor = [UIColor colorWithRed:216.0/255.0 green:219.0/255.0 blue:228.0/255.0 alpha:1.0];
    titleLabel4.textAlignment = NSTextAlignmentCenter;
}

-(void) viewWillAppear:(BOOL)animated
{
    [attractorView initialization];
    
    timer = [[MZTimerLabel alloc] initWithLabel:timerLabel andTimerType:MZTimerLabelTypeTimer];
    [timer setCountDownTime:60*5];
    [timer setTimeFormat:@"mm:ss"];
    timerLabel.font = [UIFont systemFontOfSize:45.0f];
    timerLabel.textColor = [UIColor colorWithRed:216.0/255.0 green:219.0/255.0 blue:228.0/255.0 alpha:1.0];
    [timer startWithEndingBlock:^(NSTimeInterval countTime) {
        [self onVoiceClose:closeButton];
    }];
    [timer start];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

-(void) onVoiceClose:(UIButton*)btn
{
    [self unload];
    
    if(!IS_OS_7_OR_LATER)
        [[AppDelegateInstance() rippleViewController] disableDraw:NO];
    
    CGPoint location = btn.center;
    [[AppDelegateInstance() rippleViewController] myTouchWithPoint:location];
    
    [UIView animateWithDuration:0.05 animations:^{
        btn.transform = CGAffineTransformMakeScale(0.95, 0.95);
    }
                     completion:^(BOOL finished){
                         
                         [UIView animateWithDuration:0.05f animations:^{
                             btn.transform = CGAffineTransformMakeScale(1, 1);
                         } completion:^(BOOL finished) {
        
                             if(IS_OS_7_OR_LATER)   {
                                 self.formSheetController.transitionStyle = MZFormSheetTransitionStyleFade;
                                 [self.formSheetController dismissFormSheetControllerAnimated:NO completionHandler:^(MZFormSheetController *formSheetController) {
                                     
                                 }];
                             } else {
                                 [self dismissFormSheetControllerAnimated:NO completionHandler:^(MZFormSheetController *formSheetController) {
                                     formSheetController.transitionStyle = MZFormSheetTransitionStyleFade;
                                 }];
                             }
                         }];
                     }];
}

-(void) unload
{
    [timer pause];
    timer = nil;
    
    attractorSnapshot = attractorView.snapshotImage;
    
    [attractorView releaseView];
    [attractorView removeFromSuperview];
    attractorView = nil;
}

-(void) onVoiceSave:(UIButton*)btn
{
    [btn setEnabled:NO];
    UIImage *saveClearImage = [UIImage imageNamed:@"clear_button.png"];
    [btn setImage:saveClearImage forState:UIControlStateNormal];
    [btn setImage:saveClearImage forState:UIControlStateHighlighted];
    
    saveIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [self.view addSubview:saveIndicator];
    //saveIndicator.frame = CGRectMake(btn.frame.origin.x+10, btn.frame.origin.y+10, 25, 25);
    saveIndicator.center = btn.center;
    [saveIndicator startAnimating];
    
    [UIView animateWithDuration:0.05 animations:^{
        btn.transform = CGAffineTransformMakeScale(0.95, 0.95);
    }
                     completion:^(BOOL finished){
                         
                         [UIView animateWithDuration:0.05f animations:^{
                             btn.transform = CGAffineTransformMakeScale(1, 1);
                         } completion:^(BOOL finished) {
                             //
                         }];
                     }];
    
    [timer pause];
    [attractorView snapShoting];
    
    [self performSelector:@selector(finishSavingSnapshot) withObject:nil afterDelay:2.0];
    
    /*UIImage *img = [attractorView imageRepresentation];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[self changeWhiteColorTransparent:img]];
    imgView.frame = CGRectInset(imgView.frame, -50, -50);
    [self.view addSubview:imgView];*/
}

-(void) mailSendSuccessfully
{
    //[self performSelector:@selector(finishSavingSnapshot) withObject:nil afterDelay:0.0];
}

-(void) mailSendFailed
{
    //[self performSelector:@selector(finishSavingSnapshot) withObject:nil afterDelay:0.0];
}

-(void) finishSavingSnapshot
{
    //[self unload];
    attractorSnapshot = attractorView.snapshotImage;
    
    if(!IS_OS_7_OR_LATER)
        [[AppDelegateInstance() rippleViewController] disableDraw:NO];
    
    [self initResultImage];
    
    [saveIndicator stopAnimating];
    [saveIndicator removeFromSuperview];
    
    /*saveButton.alpha = 0.0;
    resetButton.alpha = 0.0;
    titleLabel1.alpha = titleLabel2.alpha = titleLabel3.alpha = titleLabel4.alpha = 0.0;
    timerLabel.alpha = 0.0;
    settingButton.alpha = 0.0;
    attractorView.alpha = 0.0;
    
    PMTimeManager *timeManager = [[PMTimeManager alloc] init];
    finishTitle4.text = [NSString stringWithFormat:@"СПАСИБО И %@!", [timeManager titleTimeArea]];
    finishView.alpha = 1.0;
    
    UIImage *saveVoiceImage = [[UIImage imageNamed:@"save-voice.png"] scaleProportionalToRetina];
    [saveButton setImage:saveVoiceImage forState:UIControlStateNormal];
    [saveButton setImage:saveVoiceImage forState:UIControlStateHighlighted];
    [saveButton setEnabled:YES];*/
}

-(void) finishGenerateImage:(UIImage*)image
{
    __weak id wself = self;
    
    dispatch_sync( dispatch_get_main_queue(), ^{
        closeButton.alpha = 0;
        saveButton.alpha = 0;
        
        PMImageReviewController *imageReviewController = [[PMImageReviewController alloc] initWithImage2:image :@"Изображение голоса" :@"voice.png" :eToUser];
        imageReviewController.delegate = (id)wself;
        
        if( IS_OS_7_OR_LATER )  {
            MZFormSheetController *formSheet = [[MZFormSheetController alloc] initWithSize:self.view.bounds.size viewController:imageReviewController];
            formSheet.transitionStyle = MZFormSheetTransitionStyleSlideAndBounceFromRight;
            
            formSheet.willDismissCompletionHandler = ^(UIViewController *presentedFSViewController) {
                [wself showAllContext];
            };
            [formSheet presentFormSheetController:formSheet animated:YES completionHandler:^(MZFormSheetController *formSheetController) {
                
            }];
        } else  {
            UINavigationController *navCntrl = [[UINavigationController alloc] init];
            navCntrl.navigationBarHidden = YES;
            
            [[MZFormSheetBackgroundWindow appearance] setBackgroundColor:(__bridge CGColorRef)([UIColor clearColor])];
            [self presentFormSheetWithViewController:navCntrl animated:NO transitionStyle:MZFormSheetTransitionStyleSlideAndBounceFromLeft
                                   completionHandler:^(MZFormSheetController *formSheetController) {
                                       
                                       formSheetController.landscapeTopInset = 0.0f;
                                       
                                       formSheetController.willDismissCompletionHandler = ^(UIViewController *presentedFSViewController) {
                                           [wself showAllContext];
                                       };
                                       
                                       /*[formSheetController presentViewController:voiceVC animated:NO completion:^{
                                        
                                        }];*/
                                       [formSheetController presentViewController:[[UINavigationController alloc] initWithRootViewController:imageReviewController] animated:NO completion:^{
                                           
                                       }];
                                   }];
        }
    });
}

-(void) sendSuccessfulFromReviewController
{
     [self unload];
    
     saveButton.alpha = 0.0;
     resetButton.alpha = 0.0;
     titleLabel1.alpha = titleLabel2.alpha = titleLabel3.alpha = titleLabel4.alpha = 0.0;
     timerLabel.alpha = 0.0;
     settingButton.alpha = 0.0;
     attractorView.alpha = 0.0;
     
     PMTimeManager *timeManager = [[PMTimeManager alloc] init];
     finishTitle4.text = [NSString stringWithFormat:@"СПАСИБО И %@!", [timeManager titleTimeArea]];
     finishView.alpha = 1.0;
     
     UIImage *saveVoiceImage = [[UIImage imageNamed:@"save-voice.png"] scaleProportionalToRetina];
     [saveButton setImage:saveVoiceImage forState:UIControlStateNormal];
     [saveButton setImage:saveVoiceImage forState:UIControlStateHighlighted];
     [saveButton setEnabled:YES];
    
    closeButton.alpha = 1.0;
}

-(void) backFromReviewController
{
    closeButton.alpha = saveButton.alpha = 1;
    
    [saveButton setEnabled:YES];
    UIImage *saveVoiceImage = [[UIImage imageNamed:@"save-voice.png"] scaleProportionalToRetina];
    [saveButton setImage:saveVoiceImage forState:UIControlStateNormal];
    [saveButton setImage:saveVoiceImage forState:UIControlStateHighlighted];
    
    [timer reset];
    [timer start];
    [attractorView resetAttractors];
}

-(void) initResultImage
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        UIImage *backgroundImage;
        if([[userDefaults objectForKey:@"_sex"] isEqualToString:@"ЖЕНСКИЙ"])
        {
            backgroundImage = [UIImage imageNamed:@"back_2.png"];
        }
        else
            backgroundImage = [UIImage imageNamed:@"back_texture2.png"];
        
        CGRect backgroundRect = CGRectMake(0, 0, backgroundImage.size.width, backgroundImage.size.height);
        CGRect figureRect = CGRectMake((backgroundRect.size.width - (backgroundImage.size.width - 110))/2, backgroundImage.size.width-250, backgroundImage.size.width - 110, 530);
        
        /*UIGraphicsBeginImageContextWithOptions(attractorSnapshot.size, NO, 2.0);
        CGContextRef context = UIGraphicsGetCurrentContext();
        [[UIColor blackColor] set];
        CGContextFillRect(context, CGRectMake(0, 0, attractorSnapshot.size.width, attractorSnapshot.size.height));
        //CGContextSetBlendMode(context, kCGBlendModeCopy);
        CGContextDrawImage(context, CGRectMake(0, 0, attractorSnapshot.size.width, attractorSnapshot.size.height), attractorSnapshot.CGImage);
        UIImage *resultingImage2 = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        NSData* imageData =  UIImageJPEGRepresentation(attractorSnapshot, 1.0);
        UIImage *jpgImage = [self changeWhiteColorTransparent:[UIImage imageWithData:imageData]];*/
        
        NSData* imageData =  UIImagePNGRepresentation(attractorSnapshot);
        UIImage *pngImage = [UIImage imageWithData:imageData];
        
        UIGraphicsBeginImageContextWithOptions(backgroundImage.size, NO, 2.0);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextTranslateCTM(context, 0, backgroundImage.size.height);
        CGContextScaleCTM(context, 1.0, -1.0);
        CGContextDrawImage(context, backgroundRect, backgroundImage.CGImage);
        CGContextDrawImage(context, figureRect, pngImage.CGImage);
        
        CGContextTranslateCTM(context, 0, backgroundImage.size.height);
        CGContextScaleCTM(context, 1.0, -1.0);
        
        NSString *names = [NSString stringWithFormat:@"%@ %@", [userDefaults objectForKey:@"_firstname"], [userDefaults objectForKey:@"_lastname"]];
        UIFont *font = [UIFont fontWithName:@"MyriadPro-Cond" size:40.0];
        CGRect textRect = CGRectMake(0, 0, backgroundRect.size.width, backgroundRect.size.height);
        CGFloat oneHeight = 0;
        if([names respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)])
        {
            //iOS 7
            
            NSDictionary *att = @{NSFontAttributeName:font, NSForegroundColorAttributeName: [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5]};
            CGSize size = [names sizeWithAttributes:att];
            oneHeight = size.height;
            
            textRect.origin.x = (backgroundRect.size.width - size.width)/2;
            textRect.origin.y = 250 + figureRect.size.height + 40;
            
            [names drawInRect:textRect withAttributes:att];
        }
        else
        {
            CGSize size = [names sizeWithFont:font];
            oneHeight = size.height;
            
            textRect.origin.x = (backgroundRect.size.width - size.width)/2;
            textRect.origin.y = figureRect.origin.y + figureRect.size.height + 40;
            
            [[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5] set];
            [names drawInRect:textRect withFont:font];
        }
        
        UIImage *logoImage = [UIImage imageNamed:@"the-art-text.png"];
        [logoImage drawInRect:CGRectMake((backgroundRect.size.width-logoImage.size.width)/2, textRect.origin.y + oneHeight + 20, logoImage.size.width, logoImage.size.height)];
        
        names = @"*Индивидуальность как искусство";
        font = [UIFont fontWithName:@"MyriadPro-Cond" size:16.0];
        textRect = backgroundRect;
        if([names respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)])
        {
            //iOS 7
            
            NSDictionary *att = @{NSFontAttributeName:font, NSForegroundColorAttributeName: [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5]};
            CGSize size = [names sizeWithAttributes:att];
            textRect.origin.x = (backgroundRect.size.width - size.width)-10;
            textRect.origin.y = backgroundRect.size.height-20-size.height;
            
            [names drawInRect:textRect withAttributes:att];
        }
        else
        {
            CGSize size = [names sizeWithFont:font];
            oneHeight = size.height;
            
            textRect.origin.x = (backgroundRect.size.width - size.width)-10;
            textRect.origin.y = backgroundRect.size.height-20-size.height;
            
            [[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5] set];
            [names drawInRect:textRect withFont:font];
        }
        
        UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        [self finishGenerateImage:resultingImage];
        
        /*names = [NSString stringWithFormat:@"%@ %@", [userDefaults objectForKey:@"_firstname"], [userDefaults objectForKey:@"_lastname"]];
        mailManager = [[PMMailManager alloc] init];
        mailManager.delegate = (id)self;
        [mailManager sendMessageWithTitle:names text:@"Изображение голоса" image:resultingImage filename:@"voice.png" toPerson:eToUser];*/
    });
}

-(UIImage *)changeWhiteColorTransparent: (UIImage *)image
{
    CGImageRef rawImageRef=image.CGImage;
    const float colorMasking[6] = {222, 255, 222, 255, 222, 255};
    UIGraphicsBeginImageContext(image.size);
    CGImageRef maskedImageRef=CGImageCreateWithMaskingColors(rawImageRef, colorMasking);
    {
        //if in iPhone
        CGContextTranslateCTM(UIGraphicsGetCurrentContext(), 0.0, image.size.height);
        CGContextScaleCTM(UIGraphicsGetCurrentContext(), 1.0, -1.0);
    }
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, image.size.width, image.size.height), maskedImageRef);
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    CGImageRelease(maskedImageRef);
    UIGraphicsEndImageContext();
    return result;
}

- (UIImage *)convertImageToGrayScale:(UIImage *)image
{
    // Create image rectangle with current image width/height
    CGRect imageRect = CGRectMake(0, 0, image.size.width, image.size.height);
    
    // Grayscale color space
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    
    // Create bitmap content with current image size and grayscale colorspace
    CGContextRef context = CGBitmapContextCreate(nil, image.size.width, image.size.height, 8, 0, colorSpace, kCGImageAlphaNone);
    
    // Draw image into current context, with specified rectangle
    // using previously defined context (with grayscale colorspace)
    CGContextDrawImage(context, imageRect, [image CGImage]);
    
    /* changes start here */
    // Create bitmap image info from pixel data in current context
    CGImageRef grayImage = CGBitmapContextCreateImage(context);
    
    // release the colorspace and graphics context
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    
    // make a new alpha-only graphics context
    context = CGBitmapContextCreate(nil, image.size.width, image.size.height, 8, 0, nil, kCGImageAlphaOnly);
    
    // draw image into context with no colorspace
    CGContextDrawImage(context, imageRect, [image CGImage]);
    
    // create alpha bitmap mask from current context
    CGImageRef mask = CGBitmapContextCreateImage(context);
    
    // release graphics context
    CGContextRelease(context);
    
    // make UIImage from grayscale image with alpha mask
    UIImage *grayScaleImage = [UIImage imageWithCGImage:CGImageCreateWithMask(grayImage, mask) scale:image.scale orientation:image.imageOrientation];
    
    // release the CG images
    CGImageRelease(grayImage);
    CGImageRelease(mask);
    
    // return the new grayscale image
    return grayScaleImage;
    
    /* changes end here */
}

-(void) onVoiceReset:(UIButton*)btn
{
    [UIView animateWithDuration:0.05 animations:^{
        btn.transform = CGAffineTransformMakeScale(0.95, 0.95);
    }
                     completion:^(BOOL finished){
                         
                         [UIView animateWithDuration:0.05f animations:^{
                             btn.transform = CGAffineTransformMakeScale(1, 1);
                         } completion:^(BOOL finished) {
                             
                         }];
                     }];
    
    [timer reset];
    [attractorView resetAttractors];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(finishView.alpha == 1.0) {
        for (UITouch *touch in touches)
        {
            CGPoint location;
            if(touch.view == finishView)
                location = [finishView convertPoint:[touch locationInView:touch.view] toView:self.view];
            else
                location = [self.view convertPoint:[touch locationInView:touch.view] toView:self.view];
            [[AppDelegateInstance() rippleViewController] myTouchWithPoint:location];
        }
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(finishView.alpha == 1.0) {
        for (UITouch *touch in touches)
        {
            CGPoint location;
            if(touch.view == finishView)
                location = [finishView convertPoint:[touch locationInView:touch.view] toView:self.view];
            else
                location = [self.view convertPoint:[touch locationInView:touch.view] toView:self.view];
            [[AppDelegateInstance() rippleViewController] myTouchWithPoint:location];
        }
    }
}

-(void) attractorScaleValue:(CGFloat)scale
{
    if(scale > 1.3 && !attractorIsFullView)
    {
        attractorIsFullView = YES;
        [self attractorViewToFullScreen];
    }
}

-(void) createFirstAttractor
{
    arrowsFullView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"arrows-fullview.png"] scaleProportionalToRetina]];
    arrowsFullView.alpha = 0;
    arrowsFullView.center = attractorView.center;
    [self.view addSubview:arrowsFullView];
    
    [UIView animateWithDuration:0.5 animations:^{
        [UIView setAnimationRepeatCount:3];
        arrowsFullView.alpha = 1.0;
    } completion:^(BOOL finished) {
        arrowsFullView.alpha = 0;
        [arrowsFullView removeFromSuperview];
    }];
}

-(void) attractorViewToFullScreen
{
    [UIView animateWithDuration:0.3f animations:^{
        attractorView.frame = self.view.bounds;
        attractorView.scale = 1.0;
        attractorView.lastScale = 1.0;
        closeButton.alpha = 0.0;
        saveButton.alpha = 0.0;
        resetButton.alpha = 0.0;
        titleLabel1.alpha = titleLabel2.alpha = titleLabel3.alpha = titleLabel4.alpha = 0.0;
        timerLabel.alpha = 0.0;
        settingButton.alpha = 1.0;
    } completion:^(BOOL finished) {
        
    }];
}

-(void) onSettingClose:(UIButton*)button
{
    attractorIsFullView = NO;
    
    [UIView animateWithDuration:0.3f animations:^{
        attractorView.frame = CGRectMake(337.0, 189.0, 350.0, 350.0);
        attractorView.scale = 1.0;
        attractorView.lastScale = 1.0;
        closeButton.alpha = 1.0;
        saveButton.alpha = 1.0;
        resetButton.alpha = 1.0;
        titleLabel1.alpha = titleLabel2.alpha = titleLabel3.alpha = titleLabel4.alpha = 1.0;
        timerLabel.alpha = 1.0;
        settingButton.alpha = 0.0;
    } completion:^(BOOL finished) {
        
    }];
}

@end
