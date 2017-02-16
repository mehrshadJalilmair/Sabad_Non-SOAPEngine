
/*var fruits = [
 ("Apple", UIColor.red),
 ("Banana", UIColor.yellow),
 ("Grape", UIColor.purple),
 ("Orange", UIColor.orange)
 ]*/

import UIKit

final class aboutCanDo: UIViewController
{
    
    var closeHandler: (() -> Void)?
    
    class func instance() -> aboutCanDo {
        
        let storyboard = UIStoryboard(name: "aboutCanDo", bundle: nil)
        return storyboard.instantiateInitialViewController() as! aboutCanDo
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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

extension aboutCanDo: PopupContentViewController {
    
    func sizeForPopup(_ popupController: PopupController, size: CGSize, showingKeyboard: Bool) -> CGSize {
        
        return CGSize(width: UIScreen.main.bounds.width, height: 300)
    }
}


