//
//  DecideViewController.m
//  Notie
//
//  Created by Amir on 9/20/16.
//  Copyright © 2016 Emersad. All rights reserved.
//

#import "DecideViewController.h"
#import "A0SimpleKeychain.h"

@interface DecideViewController ()

@end

@implementation DecideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[[A0SimpleKeychain keychain] deleteEntryForKey:@"userLoggedIn"];
    NSString *userLogStatus = [[A0SimpleKeychain keychain] stringForKey:@"userLoggedIn"];
    if ([userLogStatus isEqualToString:@"YES"]) {
        NSLog(@"NOTIELOG : user logged in before");
        [UIApplication sharedApplication].delegate.window.rootViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Main"];
    }
    else {
        [UIApplication sharedApplication].delegate.window.rootViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Login"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
