@implementation EKShakeAnimation : CPObject
{
	id		_view;
	int		_currentStep;
	int		_delta;
	CGRect		_viewFrame;
	int		_steps;
	float		_stepDuration;
	CPTimer 	_timer;
}

- (id)initWithView:(id)aView
{
	self = [super init];
	if(self) {
		_view = aView;
		_currentStep = 1;
		_delta = 7;
		_viewFrame = [aView frame];
		_steps = 5;
		_stepDuration = 0.07;
		_timer = [CPTimer scheduledTimerWithTimeInterval:_stepDuration target:self selector:@selector(timerDidFire) userInfo:nil repeats:YES];
		[_timer fire];	
	}
	return self;
}

- (void)timerDidFire
{
	if (_currentStep == _steps) {
		[_timer invalidate];
		setTimeout(function() {
			[self animateToFrame:_viewFrame];
		}, _stepDuration);
	} else {
		var prefix = (_currentStep % 2 == 1) ? -1 : 1;

		[self animateToFrame:CGRectMake(_viewFrame.origin.x + _delta*prefix, _viewFrame.origin.y, _viewFrame.size.width, _viewFrame.size.height)];

		_currentStep++;
	}
}

- (void)animateToFrame:(CGRect)aFrame
{
	var animation = [[CPViewAnimation alloc] initWithViewAnimations:[
		[CPDictionary dictionaryWithJSObject:{
			CPViewAnimationTarget:_view, 
			CPViewAnimationStartFrame:_viewFrame,
			CPViewAnimationEndFrame:aFrame
		}]
	]];
	[animation setAnimationCurve:CPAnimationLinear];
	[animation setDuration:_stepDuration];
	[animation startAnimation];
	_viewFrame = aFrame;
}

@end
