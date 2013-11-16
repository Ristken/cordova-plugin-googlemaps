//
//  Circle.m
//  SimpleMap
//
//  Created by masashi on 11/8/13.
//
//

#import "Circle.h"

@implementation Circle

-(void)setGoogleMapsViewController:(GoogleMapsViewController *)viewCtrl
{
  self.mapCtrl = viewCtrl;
}
-(void)createCircle:(CDVInvokedUrlCommand *)command
{
  NSDictionary *json = [command.arguments objectAtIndex:1];
  float latitude = [[json valueForKey:@"lat"] floatValue];
  float longitude = [[json valueForKey:@"lng"] floatValue];
  float radius = [[json valueForKey:@"radius"] floatValue];
  CLLocationCoordinate2D position = CLLocationCoordinate2DMake(latitude, longitude);
  GMSCircle *circle = [GMSCircle circleWithPosition:position radius:radius];
  
  if ([[json valueForKey:@"visible"] boolValue]) {
    circle.map = self.mapCtrl.map;
  }
  NSArray *rgbColor = [json valueForKey:@"fillColor"];
  circle.fillColor = [rgbColor parsePluginColor];
  
  rgbColor = [json valueForKey:@"strokeColor"];
  circle.strokeColor = [rgbColor parsePluginColor];
  
  circle.strokeWidth = [[json valueForKey:@"strokeWidth"] floatValue];
  circle.zIndex = [[json valueForKey:@"zIndex"] floatValue];
  
  NSString *key = [NSString stringWithFormat:@"circle%d", circle.hash];
  [self.mapCtrl.overlayManager setObject:circle forKey: key];
  
  
  CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: key];
  [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}
@end