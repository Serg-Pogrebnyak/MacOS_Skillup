//
//  CustomStackOfButtons.swift
//  CoreDataTest
//
//  Created by Sergey Pogrebnyak on 11.03.2020.
//  Copyright © 2020 Sergey Pogrebnyak. All rights reserved.
//

import Cocoa

protocol DidTapOnButtonFromCustomStackOfButtonsDelegate {
    func didTapOnButton(withTitle title: String)
}

class CustomStackOfButtons: NSView {

    @IBOutlet fileprivate weak var backgroundView: NSView!
    @IBOutlet fileprivate weak var stackView: NSStackView!
    var delegate: DidTapOnButtonFromCustomStackOfButtonsDelegate?

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("CustomStackOfButtons", owner: self, topLevelObjects: nil)
        self.addSubview(self.backgroundView)
    }

    func generateButtonsStack(arrayOfTitle: [String]) {
        hideAllButtons()

        for title in arrayOfTitle {
            print(title)
            let button = NSButton.init(title: title, target: self, action: #selector(didTapOnButton(sender:)))
            button.setButtonType(.momentaryLight)
            button.bezelStyle = .rounded
            stackView.addArrangedSubview(button)
        }
    }

    func hideAllButtons() {
        for view in stackView.arrangedSubviews {
            stackView.removeView(view)
        }
    }

    @objc fileprivate func didTapOnButton(sender: NSButton) {
        delegate?.didTapOnButton(withTitle: sender.title)
    }
}


