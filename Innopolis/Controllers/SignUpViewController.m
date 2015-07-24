//
//  LoginViewController.m
//  ITOPK
//
//  Created by Aleksey Novikov on 23/05/15.
//  Copyright (c) 2015 Aleksey Novikov. All rights reserved.
//

#import "SignUpViewController.h"
/// signup
#import "NetwokManager+SignUp.h"
#import "LoginNavigationController.h"



@interface SignUpViewController () <UITextFieldDelegate>{
    UITextField *_activeTextfield;
}

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *familyTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordConfirmation;
@property (weak, nonatomic) IBOutlet UITextField *mailTextField;

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.nameTextField.layer.cornerRadius        = self.familyTextField.layer.cornerRadius =
    self.phoneTextField.layer.cornerRadius       = self.passwordTextField.layer.cornerRadius =
    self.passwordConfirmation.layer.cornerRadius = self.mailTextField.layer.cornerRadius = 6;

    self.passwordConfirmation.secureTextEntry = self.passwordConfirmation.secureTextEntry = YES;
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
- (IBAction)signUpAction:(id)sender {
    [self tryToSignUp];
}

- (void) tryToSignUp{
    if (self.mailTextField.text.length == 0) {
        [[[UIAlertView alloc] initWithTitle:@"Пустое поле"
                                    message:@"email обязателен"
                                   delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ОК", nil] show];
        
        return;
    }
    
    
    
    if (self.passwordTextField.text.length == 0) {
        [[[UIAlertView alloc] initWithTitle:@"Пустое поле"
                                    message:@"Пароль обязателен"
                                   delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ОК", nil] show];
        
        return;
    }
    else{
        if (![self.passwordTextField.text isEqualToString:self.passwordConfirmation.text]) {
            
            [[[UIAlertView alloc] initWithTitle:@"Ошибка ввода"
                                        message:@"Пароли не совпадают"
                                       delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ОК", nil] show];
            
            return;
        }
    }
    
    
    if (self.nameTextField.text.length == 0) {
        [[[UIAlertView alloc] initWithTitle:@"Пустое поле"
                                    message:@"Имя обязательно"
                                   delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ОК", nil] show];
        
        return;
    }
    
    
    [[NetwokManager sharedNetworkManager]
     signUpUserWithEmail:self.mailTextField.text
     password:self.passwordTextField.text
     name:self.nameTextField.text
     surname:self.familyTextField.text
     phone:self.phoneTextField.text
     onCompletion:^(BOOL success) {
         [JNKeychain saveValue:self.mailTextField.text forKey:@"email"];
         
         [[[UIAlertView alloc] initWithTitle:@"Регистрация пройдена"
                                     message:@"Вы зарегистрированы!"
                                    delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ОК", nil] show];
         
         [((LoginNavigationController *)self.parentViewController) closeEntrance];
         
     } onError:^(NSError *error) {
         
     }];
}


- (IBAction)hideKeyboard:(id)sender {
    [_activeTextfield resignFirstResponder];
}

#pragma mark - TextField delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    _activeTextfield = textField;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self tryToSignUp];
    
    return YES;
}
@end
