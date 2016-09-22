//
//  ViewController.m
//  Notie
//
//  Created by Amir on 9/20/16.
//  Copyright © 2016 Emersad. All rights reserved.
//

#import "ViewController.h"
#import "A0SimpleKeychain.h"
#import "MLInputDodger.h"

@interface ViewController () <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *noteTextView;
@property NSTimer *updater;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _noteTextView.delegate = self;
    _updater = [NSTimer scheduledTimerWithTimeInterval:0.1f
                                                target:self selector:@selector(update:) userInfo:nil repeats:YES];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.view.shiftHeightAsDodgeViewForMLInputDodger = 50.0f;
    [self.view registerAsDodgeViewForMLInputDodgerWithOriginalY:self.view.frame.origin.y];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
    
}

- (void) textViewDidBeginEditing:(UITextView *) textView {
    [_updater invalidate];
    NSLog(@"NOTIELOG start");
}

- (void) textViewDidEndEditing:(UITextView *) textView {
    [_updater fire];
    NSLog(@"NOTIELOG end");
}

- (void)update:(NSTimer *)timer {
    NSString *username = [[A0SimpleKeychain keychain] stringForKey:@"username"];
    NSString *urlString = [NSString stringWithFormat:@"http://amirfarsad.me/Notie/fetch.php?username=%@",username];
    NSURL *url = [NSURL URLWithString:urlString];
    NSString *result = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    _noteTextView.text = result;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)updateButton:(id)sender {
    NSString *username = [[A0SimpleKeychain keychain] stringForKey:@"username"];
    NSString *urlString = [NSString stringWithFormat:@"http://amirfarsad.me/Notie/bump.php?username=%@&text=%@",username,_noteTextView.text];
    urlString = [urlString stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSLog(@"NOTIELOG %@",urlString);
    NSURL *url = [NSURL URLWithString:urlString];
    NSString *result = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"NOTIELOG %@",result);
    if ([result isEqualToString:@"I_AM_DONE"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Bumped Successfully!" message:@"Your message successfully bumped to other devices." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alert show];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Please try again later." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alert show];
    }
}

@end
