#import "VeloxFolderViewProtocol.h"
/*Velox Folder Pugin*/


@interface XuiteYoVeloxFolderView : UIView <VeloxFolderViewProtocol, UIWebViewDelegate>
//Add properties, iVars here
@property (retain) UIWebView *webview;
@property (retain) UIActivityIndicatorView *indicator;
@end

@implementation XuiteYoVeloxFolderView

@synthesize webview, indicator;

-(UIView *)initWithFrame:(CGRect)aFrame{
	self = [super initWithFrame:aFrame];
    if (self){
		self.backgroundColor = [UIColor darkGrayColor];
		self.indicator = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleWhite] autorelease];
		self.indicator.hidden = YES;

		//Add subviews, load data, etc.
		self.webview = [[[UIWebView alloc] initWithFrame: self.bounds] autorelease];
		self.webview.delegate = self;
		self.webview.backgroundColor = [UIColor clearColor];
		[self.webview setOpaque:NO];
		[self addSubview: self.webview];

		self.indicator.center = self.webview.center;
		[self addSubview: self.indicator];

		// configure swipe
		UISwipeGestureRecognizer *swipeGestureRecognizer = [[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(back)] autorelease];
		swipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
		[self.webview addGestureRecognizer:swipeGestureRecognizer];

		NSURLRequest *request = [NSURLRequest requestWithURL: [NSURL URLWithString: @"http://yo.xuite.net/m/viewspot.php"]];
		[self.webview loadRequest: request];

	}
    return self;
}


+(int)folderHeight{
	return 350; //Make folder bigger on i5 devices?
}

- (void) back {
	[webview stringByEvaluatingJavaScriptFromString: @"window.history.back();"];
}

// UIWebView Delegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
	self.indicator.hidden = NO;
	[self.indicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
	[self.indicator stopAnimating];
	self.indicator.hidden = YES;

	NSString *script = @"$('<style>#hd {display: none;}</style>').appendTo($('body'));";
	[webview stringByEvaluatingJavaScriptFromString: script];
}

@end
