import UIKit


class FirstViewToSecondViewPushAnimator: NSObject, UIViewControllerAnimatedTransitioning {

  // MARK: Public

  func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
    return 0.5
  }

  func animateTransition(context: UIViewControllerContextTransitioning) {
    let fromView = context.viewForKey(UITransitionContextFromViewKey)!
    let toView   = context.viewForKey(UITransitionContextToViewKey)!

    let fromViewButton = fromView.subviews.first as! UIButton
    let toViewButton   = toView.subviews.first as! UIButton

    toViewButton.transform = CGAffineTransformMakeScale(0, 0)

    context.containerView()!.insertSubview(toView, belowSubview: fromView)

    UIView.animateWithDuration(
      0.5,
      animations: {
        fromView.backgroundColor = UIColor.clearColor()
        fromViewButton.transform  = CGAffineTransformInvert(CGAffineTransformMakeTranslation(fromView.frame.width, 0))
      },
      completion: { _ in
        context.completeTransition(!context.transitionWasCancelled())

        UIView.animateWithDuration(0.5,
          delay:                   0,
          usingSpringWithDamping:  0.5,
          initialSpringVelocity:   0,
          options:                 [],
          animations:              { toViewButton.transform = CGAffineTransformIdentity },
          completion:              nil
        )
      }
    )
  }

}
