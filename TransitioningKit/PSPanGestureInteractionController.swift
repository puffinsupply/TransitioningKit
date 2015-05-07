//  The MIT License (MIT)
//
//  Copyright (c) 2015 Adam Michela, The Puffin Supply Project
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.


import UIKit


@objc public protocol PSPanGestureInteractionControllerDelegate {
  optional func handlePanGestureBeganLeft(#gestureRecognizer: UIPanGestureRecognizer, viewController: UIViewController, interactionController: UIPercentDrivenInteractiveTransition)
  optional func handlePanGestureBeganRight(#gestureRecognizer: UIPanGestureRecognizer, viewController: UIViewController, interactionController: UIPercentDrivenInteractiveTransition)
  optional func handlePanGestureBeganUp(#gestureRecognizer: UIPanGestureRecognizer, viewController: UIViewController, interactionController: UIPercentDrivenInteractiveTransition)
  optional func handlePanGestureBeganDown(#gestureRecognizer: UIPanGestureRecognizer, viewController: UIViewController, interactionController: UIPercentDrivenInteractiveTransition)

  optional func handlePanGestureEndedLeft(#gestureRecognizer: UIPanGestureRecognizer, viewController: UIViewController, interactionController: UIPercentDrivenInteractiveTransition)
  optional func handlePanGestureEndedRight(#gestureRecognizer: UIPanGestureRecognizer, viewController: UIViewController, interactionController: UIPercentDrivenInteractiveTransition)
  optional func handlePanGestureEndedUp(#gestureRecognizer: UIPanGestureRecognizer, viewController: UIViewController, interactionController: UIPercentDrivenInteractiveTransition)
  optional func handlePanGestureEndedDown(#gestureRecognizer: UIPanGestureRecognizer, viewController: UIViewController, interactionController: UIPercentDrivenInteractiveTransition)
}


public class PSPanGestureInteractionController: UIPercentDrivenInteractiveTransition {
  var viewController: UIViewController!
  var delegate:       PSPanGestureInteractionControllerDelegate?

  public init(viewController: UIViewController, delegate: PSPanGestureInteractionControllerDelegate?) {
    super.init()

    self.viewController = viewController
    self.delegate       = delegate

    addPanGestureRecognizer()
  }

  // MARK: Public

  public func handlePanGesture(gestureRecognizer: UIPanGestureRecognizer) {
    switch gestureRecognizer.state {
    case .Began:   handlePanGestureBegan(gestureRecognizer)
    case .Changed: handlePanGestureChanged(gestureRecognizer)
    case .Ended:   handlePanGestureEnded(gestureRecognizer)
    default:       handlePanGestureDefault(gestureRecognizer)
    }
  }

  // MARK: Private

  private var trackingDirection: Direction?

  private enum Orientation: Int {
    case Horizontal = 0
    case Vertical   = 1
  }

  private enum Direction: Int {
    case Left  = 0
    case Right = 1
    case Up    = 2
    case Down  = 3

    var orientation: Orientation {
      switch self {
      case .Left:  return .Horizontal
      case .Right: return .Horizontal
      case .Up:    return .Vertical
      case .Down:  return .Vertical
      }
    }
  }

  private func addPanGestureRecognizer() {
    let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "handlePanGesture:")

    viewController.view.addGestureRecognizer(panGestureRecognizer)
  }

  private func handlePanGestureBegan(gestureRecognizer: UIPanGestureRecognizer) {
    switch panGestureDirection(gestureRecognizer) {
    case .Left:
      trackingDirection = .Left
      delegate?.handlePanGestureBeganLeft?(gestureRecognizer: gestureRecognizer, viewController: viewController, interactionController: self)
    case .Right:
      trackingDirection = .Right
      delegate?.handlePanGestureBeganRight?(gestureRecognizer: gestureRecognizer, viewController: viewController, interactionController: self)
    case .Up:
      trackingDirection = .Up
      delegate?.handlePanGestureBeganUp?(gestureRecognizer: gestureRecognizer, viewController: viewController, interactionController: self)
    case .Down:
      trackingDirection = .Down
      delegate?.handlePanGestureBeganDown?(gestureRecognizer: gestureRecognizer, viewController: viewController, interactionController: self)
    }
  }

  private func handlePanGestureChanged(gestureRecognizer: UIPanGestureRecognizer) {
    if !trackingDirectionDidChange(gestureRecognizer) {
      let translation = gestureRecognizer.translationInView(viewController.view)

      var percentComplete: CGFloat!

      switch trackingDirection!.orientation {
      case .Horizontal: percentComplete = fabs(translation.x / CGRectGetWidth(viewController.view.bounds))
      case .Vertical:   percentComplete = fabs(translation.y / CGRectGetHeight(viewController.view.bounds))
      }

      updateInteractiveTransition(percentComplete)
    }
  }

  private func handlePanGestureEnded(gestureRecognizer: UIPanGestureRecognizer) {
    switch trackingDirection! {
    case .Left:
      delegate?.handlePanGestureEndedLeft?(gestureRecognizer: gestureRecognizer, viewController: viewController, interactionController: self)
    case .Right:
      delegate?.handlePanGestureEndedRight?(gestureRecognizer: gestureRecognizer, viewController: viewController, interactionController: self)
    case .Up:
      delegate?.handlePanGestureEndedUp?(gestureRecognizer: gestureRecognizer, viewController: viewController, interactionController: self)
    case .Down:
      delegate?.handlePanGestureEndedDown?(gestureRecognizer: gestureRecognizer, viewController: viewController, interactionController: self)
    }
  }

  private func handlePanGestureDefault(gestureRecognizer: UIPanGestureRecognizer) {
    cancelInteractiveTransition()
  }

  private func panGestureDirection(gestureRecognizer: UIPanGestureRecognizer) -> Direction {
    let velocity = gestureRecognizer.velocityInView(viewController.view)

    switch panGestureOrientation(gestureRecognizer) {
    case .Horizontal: return (velocity.x < 0) ? .Left : .Right
    case .Vertical:   return (velocity.y < 0) ? .Up   : .Down
    }
  }

  private func panGestureOrientation(gestureRecognizer: UIPanGestureRecognizer) -> Orientation {
    let velocity = gestureRecognizer.velocityInView(viewController.view)

    return (fabs(velocity.x) > fabs(velocity.y)) ? .Horizontal : .Vertical
  }

  private func trackingDirectionDidChange(gestureRecognizer: UIPanGestureRecognizer) -> Bool {
    let translation = gestureRecognizer.translationInView(viewController.view)

    switch trackingDirection! {
    case .Left:  return (translation.x > 0)
    case .Right: return (translation.x < 0)
    case .Up:    return (translation.y > 0)
    case .Down:  return (translation.y < 0)
    }
  }
}
