//
//  QuestionViewController.m
//  ITOPK
//
//  Created by Aleksey Novikov on 23/05/15.
//  Copyright (c) 2015 Aleksey Novikov. All rights reserved.
//

#import "QuestionViewController.h"
#import "MLPAutoCompleteTextField.h"
#import "NetwokManager+Ask.h"
#import "Section.h"
#import "SectionDetail.h"
#import "Speaker.h"

@interface QuestionViewController() <UITextViewDelegate>

//@property (weak, nonatomic) IBOutlet MLPAutoCompleteTextField *topTextView;
@property (weak, nonatomic) IBOutlet UITextView *questionView;

@property (nonatomic,strong) NSArray *speakersToAsk;

@end

@implementation QuestionViewController{
    UITextView *_activeTextView;
    NSArray *speakersNames;
}

//-(NSArray *)getSpekersFromSectionWithID:(NSNumber *)sectionID{
//    NSMutableArray * resultArray = [NSMutableArray new];
//    SectionDetail *details = [SectionDetail findDetailBySectionID:sectionID];
//    NSDictionary *speakers = [NSKeyedUnarchiver unarchiveObjectWithData:details.speakers];
//    NSArray *speakersArray = [speakers valueForKey:@"name"];
//    for (NSString *speaker in speakersArray) {
//        [resultArray addObject:[Speaker findSpeakerWithName:speaker]];
//    }
//    return resultArray;
//}

- (void)resetTextViews{
//    _topTextView.text= @"";
//    if (_sectionID) {
//        _topTextView.placeholder = @"СПИКЕР";
//    } else if (_speakerID) {
//        _topTextView.placeholder = @"СЕКЦИЯ";
//    }
    _questionView.text = @"Введите вопрос";
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self resetTextViews];
    _speakerID = 0;
    
//    _topTextView.autoCompleteDataSource = self;
//    _topTextView.autoCompleteDelegate = self;
    
//    _speakersToAsk = [self getSpekersFromSectionWithID:_sectionID];
//    speakersNames = [_speakersToAsk valueForKey:@"name"];
    // Dismiss the keyboard when the user taps outside of a text field
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard:)];
    [self.view addGestureRecognizer:singleTap];
//    [_topTextView removeGestureRecognizer:singleTap];

//    _topTextView.
    
    
}

//-(NSArray *)autoCompleteTextField:(MLPAutoCompleteTextField *)textField possibleCompletionsForString:(NSString *)string{
//    return speakersNames;
//}
//- (void)autoCompleteTextField:(MLPAutoCompleteTextField *)textField
//  didSelectAutoCompleteString:(NSString *)selectedString
//       withAutoCompleteObject:(id<MLPAutoCompletionObject>)selectedObject
//            forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    _speakerID = [Speaker findSpeakerWithName:selectedString].speakerID;
//}


- (void)textViewDidBeginEditing:(UITextView *)textView{
    textView.text = @"";
    _activeTextView = textView;
}

//- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
//    [theTextField resignFirstResponder];
//    return YES;
//}

- (IBAction)askQuestion:(id)sender {
  
    
    if ( [_questionView.text isEqualToString:@"Введите вопрос"] || _questionView.text.length == 0) {
        [[[UIAlertView alloc] initWithTitle:@"Ошибка"
                                    message:@"Введите вопрос"
                                   delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ОК", nil] show];
    }
    
    [[NetwokManager sharedNetworkManager] askQuestion:_questionView.text
                                     relatedToSection:_sectionID
                                            toSpeaker:_speakerID
                                         onCompletion:^(BOOL success) {
                                             [self resetTextViews];
                                             DLog(@"SUCCES!!");
                                         }
                                              onError:^(NSError *error) {
                                                  [[[UIAlertView alloc] initWithTitle:@"Ошибка"
                                                                              message:@"Не удалось задать вопрос"
                                                                             delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ОК", nil] show];
                                                  
                                              }];
}

- (IBAction)hideKeyboard:(id)sender {
    [_activeTextView resignFirstResponder];
}


@end
