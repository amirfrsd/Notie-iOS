//
//  LoginViewController.m
//  Notie
//
//  Created by Amir on 9/22/16.
//  Copyright © 2016 Emersad. All rights reserved.
//

#import "LoginViewController.h"
#import "A0SimpleKeychain.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginButton:(id)sender {
    if (_usernameTextField.text.length == 0 || _passwordTextField.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Something Wrong" message:@"Some fields are empty check please." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alert show];
    }
    else {
        NSString *username = _usernameTextField.text;
        NSString *password = _passwordTextField.text;
        NSString *urlString = [NSString stringWithFormat:@"http://amirfarsad.me/Notie/login.php?username=%@&password=%@",username,password];
        NSURL *url = [NSURL URLWithString:urlString];
        NSString *result = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
        if ([result isEqualToString:@"SUCCESSFULLY_LOGGED_IN"]) {
            [[A0SimpleKeychain keychain] setString:@"YES" forKey:@"userLoggedIn"];
            [[A0SimpleKeychain keychain] setString:username forKey:@"username"];
            [[A0SimpleKeychain keychain] setString:password forKey:@"password"];
            NSLog(@"NOTIELOG : Logged In");
            [UIApplication sharedApplication].delegate.window.rootViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Decide"];
        }
        else {
            NSLog(@"NOTIELOG : Wrong Username/Password");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Verify that your username and password are entered correctly." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
            [alert show];
        }
    }
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
