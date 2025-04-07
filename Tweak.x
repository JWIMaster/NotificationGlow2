@import UIKit;
@import QuartzCore;
#import <GcUniversal/GcColorPickerUtils.h>

@interface NCNotificationViewController : UIViewController
@property (nonatomic, strong) UIView *notificationView;
@end

static BOOL enableGlow;
static NSInteger glowRadius;
static double glowOpacity;



//Create a preference file that contains a BOOL value from the on/off switch
static void preferencesChanged() {
	NSUserDefaults *prefs = [[NSUserDefaults alloc] initWithSuiteName:@"com.jwi.NotificationGlow2Prefs"];
	enableGlow = [prefs objectForKey:@"enableGlow"] ? [prefs boolForKey:@"enableGlow"] : YES;
	glowRadius = [prefs objectForKey:@"glowRadius"] ? [prefs floatForKey:@"glowRadius"] : 10; 
	glowOpacity = [prefs objectForKey:@"glowOpacity"] ? [prefs floatForKey:@"glowOpacity"] : 0.7; 

}

//Constantly check if any preference has changed
%ctor {
	preferencesChanged();
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)preferencesChanged, CFSTR("com.jwi.NotificationGlow2Prefs-Updated"), NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
}




//Main Hook
%hook NCNotificationViewController
%property (nonatomic, strong) UIView *notificationView;

//Obtain notification dimensions
-(void)viewDidLayoutSubviews {
	%orig;
	self.notificationView.frame = self.view.bounds;
	
}

//Inject glow behind each notification
-(void)viewDidLoad {
	%orig;
	if (!enableGlow) {
		return;
	}
	//Create a rectangle that matches the shape of the notification
	self.notificationView = [[UIView alloc] init];
	self.notificationView.backgroundColor = [[UIColor clearColor] colorWithAlphaComponent:0.7];
	self.notificationView.layer.cornerRadius = 20;

	//Make an outer edge glow for the final effect
	
	UIColor *colorWithFallback = [GcColorPickerUtils colorFromDefaults:@"com.jwi.NotificationGlow2Prefs" withKey:@"YourColor" fallback:@"ffffffff"];
	self.notificationView.layer.shadowColor = colorWithFallback.CGColor;
	self.notificationView.layer.shadowOpacity = glowOpacity;
	self.notificationView.layer.shadowRadius = glowRadius;
	self.notificationView.layer.shadowOffset = CGSizeZero;
	[self.view insertSubview:self.notificationView atIndex:0];
}

%end

