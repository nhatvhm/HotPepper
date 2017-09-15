//
//  HPThumbnailProxyView.m
//  HotPepper
//
//

#import "HPThumbnailProxyView.h"

@interface HPThumbnailProxyView () {
    UIImage *_realImage;
    UIImage *_dummyImage;
}

@end

@implementation HPThumbnailProxyView

- (id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        NSString *filepath = [NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], @"noImage.png"];
        if([[NSFileManager defaultManager] fileExistsAtPath:filepath]) {
            _dummyImage = [[UIImage alloc] initWithContentsOfFile:filepath];
        }else{
            /*
             Unrecoverable error. Display error dialog.
             */
        }
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    if (_realImage == nil) {
        
        //
        [_dummyImage drawInRect:rect];
        
        if(_imageURL) {
            //
            dispatch_queue_t mainQueue = dispatch_get_main_queue();
            dispatch_queue_t defaultPriorityQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_async(defaultPriorityQueue, ^{
                
                //
                NSURL *imageURL = [NSURL URLWithString:_imageURL];
                NSData *rawImage = [NSData dataWithContentsOfURL:imageURL];
                _realImage = [[UIImage alloc] initWithData:rawImage];
                
                //
                if(_realImage) {
                    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 0.25*NSEC_PER_SEC);
                    dispatch_after(time, mainQueue, ^{
                        [self setNeedsDisplay];
                    });
                }else{
                    //Re-download retry after 5 seconds
                    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 5.0*NSEC_PER_SEC);
                    dispatch_after(time, mainQueue, ^{
                        [self setNeedsDisplay];
                    });
                }
            });
        }
        
    } else {
        [_realImage drawInRect:rect];
    }
}

- (UIImage*) image {
    return _realImage ? _realImage : _dummyImage;
}

@end
