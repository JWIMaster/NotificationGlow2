@import UIKit;
@import QuartzCore;	

@interface NCNotificationViewController : UIViewController
@property (nonatomic, strong) UIView *notificationView;
@end

static BOOL enableGlow;

//Create a preference file that contains a BOOL value from the on/off switch
static void preferencesChanged() {
	NSUserDefaults *prefs = [[NSUserDefaults alloc] initWithSuiteName:@"com.jwi.NotificationGlow2Prefs"];
	enableGlow = [prefs objectForKey:@"enableGlow"] ? [prefs boolForKey:@"enableGlow"] : YES;
}

//Constantly check if any preference has changed
%ctor {
	preferencesChanged();
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
	self.notificationView.backgroundColor = [UIColor clearColor];
	self.notificationView.layer.cornerRadius = 20;

	//Make and outer edge glow for the final effect
	self.notificationView.layer.shadowColor = [UIColor greenColor].CGColor;
	self.notificationView.layer.shadowOpacity = 0.7;
	self.notificationView.layer.shadowRadius = 10;
	self.notificationView.layer.shadowOffset = CGSizeZero;
	[self.view insertSubview:self.notificationView atIndex:0];
}

%end

