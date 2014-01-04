// BatterySafe By TheJailPad
#import <UIKit/UIKit.h>
#import <SpringBoard/SBBrightnessController.h>
#import <Preferences/PSCellularDataSettingsDetail.h>

    NSMutableDictionary *settings = [NSMutableDictionary dictionaryWithContentsOfFile:
    [NSString stringWithFormat:@"%@/Library/Preferences/%@", NSHomeDirectory(), @"com.thejailpad.batterysafepref.plist"]];

    @interface SBUIController : NSObject 
    +(id)sharedInstance;
    -(BOOL)isOnAC;
    @end


    @interface BluetoothManager
    -(BOOL)setEnabled:(BOOL)enabled;
    -(BOOL)setPowered:(BOOL)powered;
    +(id)sharedInstance;
    @end

    @interface SBWiFiManager
    -(id)sharedInstance;
    -(void)setWiFiEnabled:(BOOL)enabled;
    @end
    
    @interface PSCellularDataSettingsDetail
    -(void)setEnabled:(BOOL)enabled;
    @end
     
    @interface BatterySafe : NSObject <UIAlertViewDelegate> {
    @private
        UIAlertView *avBrightness;
        UIAlertView *avWifi;
        UIAlertView *avBluetooth;
        UIAlertView *avLTE;


    }
    @end
     
    @implementation BatterySafe

    - (void)show
    {
        avBrightness = [[UIAlertView alloc] initWithTitle:@"BatterySafe"
                                             message:@"You're almost out of battery, would you like to lower your brightness to save some battery?"
                                            delegate:self
                                            cancelButtonTitle:@"No"
                                            otherButtonTitles: @"Yes" , nil];
        [avBrightness show];
        
                               if ([[settings objectForKey:@"enabledwifi"] boolValue]) {

                avWifi = [[UIAlertView alloc] initWithTitle:@"BatterySafe"
                                             message:@"You're almost out of battery, would you turn off WIFI to save some battery?"
                                            delegate:self
                                            cancelButtonTitle:@"No"
                                            otherButtonTitles: @"Yes" , nil];
        [avWifi show];
        }
                             if ([[settings objectForKey:@"enabledbluetooth"] boolValue]) {

                avBluetooth = [[UIAlertView alloc] initWithTitle:@"BatterySafe"
                                             message:@"You're almost out of battery, would you like to turn off Bluetooth your brightness to save some battery?"
                                            delegate:self
                                            cancelButtonTitle:@"No"
                                            otherButtonTitles: @"Yes" , nil];
        [avBluetooth show];
        }
        
                             if ([[settings objectForKey:@"enabledcellulardata"] boolValue]) {

                avLTE = [[UIAlertView alloc] initWithTitle:@"BatterySafe"
                                             message:@"You're almost out of battery, would you like to turn off Cellular Data to save some battery?"
                                            delegate:self
                                            cancelButtonTitle:@"No"
                                            otherButtonTitles: @"Yes" , nil];
        [avLTE show];
        }
    }
     
    - (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
        if (alertView == avBrightness) {
            if (buttonIndex != alertView.cancelButtonIndex) {
                [[%c(SBBrightnessController) sharedBrightnessController] setBrightnessLevel:0.0];
            
            }
        }else if (alertView ==avBluetooth) {
                 if (buttonIndex != alertView.cancelButtonIndex) {
                     if ([[settings objectForKey:@"enabledbluetooth"] boolValue]) {
                      [(BluetoothManager *)[objc_getClass("BluetoothManager") sharedInstance] setEnabled:NO];
                      [(BluetoothManager *)[objc_getClass("BluetoothManager") sharedInstance] setPowered:NO];
                    }
                 }
       }else if (alertView == avWifi) {
                 if (buttonIndex != alertView.cancelButtonIndex) {
                       if ([[settings objectForKey:@"enabledwifi"] boolValue]) {
                          [[objc_getClass("SBWiFiManager") sharedInstance] setWiFiEnabled:NO];
                       }
                }
     }else if (alertView ==avLTE) {
                 if (buttonIndex != alertView.cancelButtonIndex) {
                     if ([[settings objectForKey:@"enabledcellulardata"] boolValue]) {
                
                        PSCellularDataSettingsDetail *PSCDSD = [[PSCellularDataSettingsDetail alloc] init];
                        [PSCDSD setEnabled:NO];
                       
                        [PSCDSD release];
                    }
                }
            }
     }
     
    @end

    static unsigned int warnAt = 20;
    int validatealert = 0;
     
    %hook SBLowPowerAlertItem
    
    +(void)setBatteryLevel:(unsigned int)fp8{
       
        //Ont créer la variable de SBUIController pour voir si une prise est connecter
        warnAt = [[settings objectForKey:@"POURCENTAGESET"]intValue];
        SBUIController *ACconnect=[objc_getClass("SBUIController") sharedInstance];
     
        // Ont vérifie si validatealert est à zero si ont est pas trop bas et si ont est pas connecter
        if(validatealert==0&&fp8<=warnAt&&![ACconnect isOnAC]&&[[settings objectForKey:@"enabled"] boolValue]){
            BatterySafe *bsafe = [[BatterySafe alloc] init];
            [bsafe show];
               
            validatealert = 1;
        }
     
        // ont regarde si l'idevice est connecter a la prise éléctrique et que le niveau de batterie est supérieu au niveau d'alert
        if([ACconnect isOnAC]&&fp8>warnAt) {
            validatealert = 0;
        }
    }
    
    %end