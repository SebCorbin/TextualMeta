//
//  TPIMeta.m
//  TextualMeta
//
//  Created by SebCorbin on 12/01/2016.
//  Copyright © 2016 SebCorbin. All rights reserved.
//

#import "TPIMeta.h"
#import "HTMLParser/HTMLParser.h"

@implementation TPIMeta

- (NSString*)processInlineMediaContentURL:(NSString *)resource {
    // Try to load the html from resource
    NSError* error = nil;
    NSStringEncoding encoding;
    NSString* html = [NSString stringWithContentsOfURL:[NSURL URLWithString:resource] encoding:encoding error:&error];
    if (error) {
        return nil;
    }

    // Parse the html
    HTMLParser *parser = [[HTMLParser alloc] initWithString:html error:&error];
    if (error) {
        return nil;
    }
    
    HTMLNode *headNode = [parser head];
    
    NSArray *metaTags = [headNode findChildTags:@"meta"];
    
    for (HTMLNode *inputNode in metaTags) {
        if ([[inputNode getAttributeNamed:@"property"] isEqualToString:@"og:image"]) {
            return [inputNode getAttributeNamed:@"content"];
        }
    }
    
    return nil;
}

@end
