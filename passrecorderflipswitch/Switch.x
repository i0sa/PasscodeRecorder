#import "FSSwitchDataSource.h"
#import "FSSwitchPanel.h"
#import <notify.h>

static NSString * const PREF_PATH = @"/var/mobile/Library/Preferences/com.i0sa.passcoderecorderprefs.plist";
static NSString * const kSwitchKey = @"enabled";


@interface passrecorderflipswitchSwitch : NSObject <FSSwitchDataSource>
@end

@implementation passrecorderflipswitchSwitch

- (FSSwitchState)stateForSwitchIdentifier:(NSString *)switchIdentifier {
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:PREF_PATH];
    id enabled = [dict objectForKey:kSwitchKey];
    BOOL isEnabled = enabled ? [enabled boolValue] : YES;
    return isEnabled ? FSSwitchStateOn : FSSwitchStateOff;
}
 
// Set a new state for the switch.
- (void)applyState:(FSSwitchState)newState forSwitchIdentifier:(NSString *)switchIdentifier {

    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:PREF_PATH];
    NSMutableDictionary *mutableDict = dict ? [[dict mutableCopy] autorelease] : [NSMutableDictionary dictionary];

	switch (newState) {
	case FSSwitchStateIndeterminate:
		break;
	case FSSwitchStateOn:
		[mutableDict setValue:@YES forKey:kSwitchKey];
		break;
	case FSSwitchStateOff:
        [mutableDict setValue:@NO forKey:kSwitchKey];
		break;
	}
	[mutableDict writeToFile:PREF_PATH atomically:YES];
    notify_post("com.i0sa.passcoderecorderprefs.settingschanged");

	return;
}
 
// Provide a proper title instead of its bundle ID:
- (NSString *)titleForSwitchIdentifier:(NSString *)switchIdentifier {
	return @"PassCodeRecorder";
}
 
// Do something different when holding the switch
- (void)applyAlternateActionForSwitchIdentifier:(NSString *)switchIdentifier {
	// ...
	return;
}

@end