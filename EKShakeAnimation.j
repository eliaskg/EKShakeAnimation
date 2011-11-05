@implementation EKShakeAnimation : CPObject
{
    id      target;
    int     currentStep;
    int     delta;
    CG      targetFrame;
    int     steps;
    float   stepDuration;
    CPTimer timer;
}

- (id)initWithView:(id)aView
{
    if(self = [super init])
    {
        target       = aView;
        targetFrame  = [target frame];
        currentStep  = 1;
        delta        = 7;
        steps        = 5;
        stepDuration = 0.07;
        timer        = [CPTimer scheduledTimerWithTimeInterval:stepDuration target:self selector:@selector(timerDidFire) userInfo:nil repeats:YES];
        
        [timer fire];    
    }
    
    return self;
}

- (void)timerDidFire
{
    if (currentStep === steps)
    {
        [timer invalidate];
        
        setTimeout(function()
        {
            [self animateToFrame:targetFrame];
        }, stepDuration);
    }
    else
    {
        var prefix = (currentStep % 2 === 1) ? -1 : 1;

        [self animateToFrame:CGRectMake(targetFrame.origin.x + delta * prefix, 
                                        targetFrame.origin.y,
                                        targetFrame.size.width,
                                        targetFrame.size.height)];

        currentStep++;
    }
}

- (void)animateToFrame:(CGRect)aFrame
{
    var animation = [[CPViewAnimation alloc] initWithViewAnimations:[
        [CPDictionary dictionaryWithJSObject:{
            CPViewAnimationTargetKey:target, 
            CPViewAnimationStartFrameKey:targetFrame,
            CPViewAnimationEndFrameKey:aFrame
        }]
    ]];
    [animation setAnimationCurve:CPAnimationLinear];
    [animation setDuration:stepDuration];
    [animation startAnimation];
    targetFrame = aFrame;
}

@end
