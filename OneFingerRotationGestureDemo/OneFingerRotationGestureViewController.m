//
//  CircularGestureViewController.m
//  Used by Hind Almerekhi - QCRI ~ ALT "QFI Wheel" project demonstration
//  Monday 22nd of April 2013

#import "OneFingerRotationGestureViewController.h"

@interface OneFingerRotationGestureViewController ()
{
@private CGFloat imageAngle;
@private OneFingerRotationGestureRecognizer *gestureRecognizer;
@private NSString *character;
//@private NSMutableArray *arabicCharacters;
//@private int numberOfchars;
//@private float angValue;
}

- (void) updateTextDisplay;
- (void) setupGestureRecognizer;
@end

@implementation OneFingerRotationGestureViewController

@synthesize image;
@synthesize textDisplay;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
    {
        // Custom initialization
        imageAngle = 0;
        character = @"أ";
    }
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupGestureRecognizer];
    [self updateTextDisplay];
    //NSMutableArray *arabicCharacters = [[NSMutableArray alloc] init];
    //numberOfchars = 26;
    //angValue = 360/26;

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    image = nil;
    textDisplay = nil;
    gestureRecognizer = nil;
}

#pragma mark - UIViewController methods

// Any rotation is supported.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

// To make things easier, the gesture recognizer is removed before rotation...
- (void) willRotateToInterfaceOrientation: (UIInterfaceOrientation) toInterfaceOrientation
                                 duration: (NSTimeInterval) duration
{
    [self.view removeGestureRecognizer: gestureRecognizer];
    
    // improvement opportunity: translate the rotation angle
    imageAngle = 0;
    image.transform = CGAffineTransformIdentity;
}

// ... and added afterwards.
- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self setupGestureRecognizer];
    [self updateTextDisplay];
}

#pragma mark - CircularGestureRecognizerDelegate protocol

- (void) rotation: (CGFloat) angle
{
//    arabicCharacters = [NSMutableArray arrayWithObjects:@"آ",@"ب",@"ك",@"د",@"ي",@"ف",
//                        @"ج",@"ه",@"آ",@"ج",@"ك",@"ل",@"م",@"ن",@"و",@"ب",@"ك",@"ر",@"س",
//                        @"ت",@"أ",@"ف",@"و",@"سك",@"ي",@"ز",nil];
    // calculate rotation angle
    imageAngle += angle;
    if (imageAngle > 360)
        imageAngle -= 360;
    else if (imageAngle < 0)
        imageAngle += 360;
    
    // rotate image and update text field
    image.transform = CGAffineTransformMakeRotation(imageAngle *  M_PI / 180);
    [self updateTextDisplay];
    //for(int i = 0; i<numberOfchars; i++){
        
    //}
    //Here instead of showing the angle I would like to display the Arabic letter that corresponds to the selected English letter
    

}

- (void) finalAngle: (CGFloat) angle
{
       // circular gesture ended, update text field
    [self updateTextDisplay];
    //Adding this line will make the clear button work but all the other buttons will perform the same!
    //imageAngle = 0;
    
}

#pragma mark - Helper methods

// Updates the text field with the current rotation angle.
- (void) updateTextDisplay
{
 textDisplay.text = [NSString stringWithFormat: @"%.2f", imageAngle];
//    if(imageAngle == 0 || imageAngle == 0.55){
//        character = @"آ";
//        textDisplay.text = character;
//    }
//    if(imageAngle == -14.31){
//        character = @"ب";
//        textDisplay.text = character;
//    }
//textDisplay.text = character;
}

// Addes gesture recognizer to the view (or any other parent view of image. Calculates midPoint
// and radius, based on the image position and dimension.
- (void) setupGestureRecognizer
{
    // calculate center and radius of the control
    CGPoint midPoint = CGPointMake(image.frame.origin.x + image.frame.size.width / 2,
                                   image.frame.origin.y + image.frame.size.height / 2);
    CGFloat outRadius = image.frame.size.width / 2;
    
    // outRadius / 3 is arbitrary, just choose something >> 0 to avoid strange
    // effects when touching the control near of it's center
    gestureRecognizer = [[OneFingerRotationGestureRecognizer alloc] initWithMidPoint: midPoint
                                                                         innerRadius: outRadius / 3
                                                                         outerRadius: outRadius
                                                                              target: self];
    [self.view addGestureRecognizer: gestureRecognizer];
}

//- (IBAction)Clear:(id)sender {
//    //[[self textDisplay] setText:@""];
//}
//- (IBAction)Reset:(id)sender {
//    [self viewDidLoad];
//}
@end



