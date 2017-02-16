//
//  DemoPopupViewController4.swift
//  PopupController
//
//  Created by omatty198 on 2017/01/12.
//  Copyright © 2017年 Daisuke Sato. All rights reserved.
//

import UIKit

final class GoodAddress: UIViewController {

    
    @IBOutlet weak var addressLabel: UILabel!
    var address:String!
    
    var closeHandler: (() -> Void)?

    class func instance() -> GoodAddress {
        
        let storyboard = UIStoryboard(name: "GoodAddress", bundle: nil)
        return storyboard.instantiateInitialViewController() as! GoodAddress
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addressLabel.text = address
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.view.layer.cornerRadius = 4
    }

    // MARK: - Button Action
    @IBAction func tapped() {
        
        closeHandler?()
    }
}

extension GoodAddress: PopupContentViewController {

    func sizeForPopup(_ popupController: PopupController, size: CGSize, showingKeyboard: Bool) -> CGSize {
        
        return CGSize(width: UIScreen.main.bounds.width, height: 74)
    }
}
