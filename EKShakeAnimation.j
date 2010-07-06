@import "LPViewAnimation.j"

@implementation EKShakeAnimation : CPObject
{
	id		_view;
	int		_currentStep;
	int		_delta;
	CGPoint	_origin;
	int		_steps;
	float	_stepDuration;
	CPTimer _timer;
}

- (id)initWithView:(id)aView
{
	self = [super init];
	if(self) {
		_view = aView;
		_currentStep = 1;
		_delta = 7;
		_origin = [aView frame].origin;
		_steps = 5;
		_stepDuration = 0.05;
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
			[self animateWithOrigin:_origin];
		}, _stepDuration);
	} else {
		var prefix = (_currentStep % 2 == 1) ? -1 : 1;

		[self animateWithOrigin:CGPointMake(_origin.x + _delta*prefix, _origin.y)];

		_currentStep++;
	}

}

- (void)animateWithOrigin:(CGPoint)origin
{
	var animation = [[LPViewAnimation alloc] initWithViewAnimations:[{
		    @"target": _view,
		    @"animations": [[LPOriginAnimationKey, [_view frame].origin, origin]]
	}]];
	[animation setAnimationCurve:CPAnimationLinear];
	[animation setDuration:_stepDuration];
	[animation startAnimation];
}

@end
