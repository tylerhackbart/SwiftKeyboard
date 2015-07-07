//
//  KeyboardViewController.swift
//  AC Keyboard
//
//  Created by Tyler Hackbart on 2015-07-07.
//  Copyright (c) 2015 Hackbart. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {

    @IBOutlet var nextKeyboardButton: UIButton!

    override func updateViewConstraints() {
        super.updateViewConstraints()
    
        // Add custom view sizing constraints here
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let buttonTitles = ["Q","W","E","R","T","S","U"]
        var buttons = createButtons(buttonTitles)
        var topRow = UIView(frame: CGRectMake(0,0,320,40))
        
        for button in buttons {
            topRow.addSubview(button)
        }
        self.view.addSubview(topRow)
        
        func createButtons(titles: [String]) -&gt; [UIButton] {
            var buttons = [UIButton]()
            
            for title in titles {
                let button = UIButton.buttonWithType(.System) as UIButton
                button.setTitle(title, forState: .Normal)
                button.setTranslatesAuthoresizingMaskIntoContraints(false)
                button.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
                button.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
                button.addTarget(self, action: "keyPressed", forControlEvents: .touchUpInside)
                buttons.append(button)
            }
            
            return buttons
        }
        
        func keyPressed(sender: AnyObject?) {
            let button = sender as UIButton
            let title = button.titleForState(.Normal)
            (textDocumentProxy as UIKeyInput).insertTitle(title!)
        }
        
        func addConstraints(buttons: [UIButton], containingView: UIView){
        
            for (index, button) in enumerate(buttons) {
                var topConstraint = NSLayoutConstraint(item: button, attribute: .Top, relatedBy: .Equal, toItem: containingView, attribute: .Top, multiplier: 1.0, constant: 1)
                var bottomConstraint = NSLayoutConstraint(item: button, attribute: .Bottom, relatedBy: .Equal, toItem: containingView, attribute: .Bottom, multiplier: 1.0, constant: -1)
                var leftConstraint : NSLayoutConstraint!
                
                if index == 0 {
                    leftConstraint = NSLayoutConstraint(item: button, attribute: .Left, relatedBy: .Equal, toItem: containingView, attribute: .Left, multiplier: 1.0, constant: 1)
                }else {
                    leftConstraint = NSLayoutConstraint(item: button, attribute: .Left, relatedBy: .Equal, toItem: buttons[index-1], attribute: .Right, multiplier: 1.0, constant: 1)
                    var widthConstraint = NSLayoutConstraint(item: buttons[0], attribute: .Width, relatedBy: .Equal, toItem: button, attribute: .Width, multiplier: 1.0, constant: 0)
                    containingView.addConstraint(widthConstraint)
                }
                var rightConstraint : NSLayoutConstraint!
                
                if index == buttons.count - 1 {
                    rightConstraint = NSLayoutConstraint(item: button, attribute: .Right, relatedBy: .Equal, toItem: containingView, attribute: .Width, multiplier: 1.0 , constant: 0)
                }else{
                    rightConstraint = NSLayoutConstraint(item: button, attribute: .Right, relatedBy: .Equal, toItem: buttons[index+1], attribute: .Left, multiplier: 1.0, constant: -1)
                }
            }
        
        
        }
        
        addConstraints(buttons, containingView: topRow)
        
        self.nextKeyboardButton = UIButton.buttonWithType(.System) as! UIButton
    
        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), forState: .Normal)
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.setTranslatesAutoresizingMaskIntoConstraints(false)
    
        self.nextKeyboardButton.addTarget(self, action: "advanceToNextInputMode", forControlEvents: .TouchUpInside)
        
        self.view.addSubview(self.nextKeyboardButton)
    
        var nextKeyboardButtonLeftSideConstraint = NSLayoutConstraint(item: self.nextKeyboardButton, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1.0, constant: 0.0)
        var nextKeyboardButtonBottomConstraint = NSLayoutConstraint(item: self.nextKeyboardButton, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1.0, constant: 0.0)
        self.view.addConstraints([nextKeyboardButtonLeftSideConstraint, nextKeyboardButtonBottomConstraint])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }

    override func textWillChange(textInput: UITextInput) {
        // The app is about to change the document's contents. Perform any preparation here.
    }

    override func textDidChange(textInput: UITextInput) {
        // The app has just changed the document's contents, the document context has been updated.
    
        var textColor: UIColor
        var proxy = self.textDocumentProxy as! UITextDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.Dark {
            textColor = UIColor.whiteColor()
        } else {
            textColor = UIColor.blackColor()
        }
        self.nextKeyboardButton.setTitleColor(textColor, forState: .Normal)
    }

}
