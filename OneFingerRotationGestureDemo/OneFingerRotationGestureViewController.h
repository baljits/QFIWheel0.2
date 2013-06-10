//
//  CircularGestureViewController.h
//  Used by Hind Almerekhi - QCRI ~ ALT "QFI Wheel" project demonstration
//  Monday 22nd of April 2013

#import <UIKit/UIKit.h>

#import "OneFingerRotationGestureRecognizer.h"

@interface OneFingerRotationGestureViewController : UIViewController <OneFingerRotationGestureRecognizerDelegate>
@property  (nonatomic, strong) IBOutlet UIImageView *image;
@property  (nonatomic, strong) IBOutlet UITextField *textDisplay;
- (IBAction)Reset:(id)sender;
@end
