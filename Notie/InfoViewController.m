//
//  InfoViewController.m
//  Notie
//
//  Created by Amir on 9/22/16.
//  Copyright © 2016 Emersad. All rights reserved.
//

#import "InfoViewController.h"
#import "A0SimpleKeychain.h"

@interface InfoViewController ()

@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)signOutButton:(id)sender {
    [[A0SimpleKeychain keychain] deleteEntryForKey:@"userLoggedIn"];
    [[A0SimpleKeychain keychain] deleteEntryForKey:@"username"];
    [[A0SimpleKeychain keychain] deleteEntryForKey:@"password"];
    [UIApplication sharedApplication].delegate.window.rootViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Decide"];
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
