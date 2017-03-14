//
//  setAbuse.swift
//  Sabad
//
//  Created by Mehrshad JM on 2/10/17.
//  Copyright © 2017 Mehrshad Jalilmasir. All rights reserved.
//

import UIKit
import MessageUI

class support: UIViewController, MFMailComposeViewControllerDelegate, PopupContentViewController ,UITextFieldDelegate{

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var phone: UITextField!
    @IBOutlet var message: UITextField!
    
    var closeHandler: (() -> Void)?
    
    @IBOutlet weak var button: UIButton! {
        
        didSet {
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.frame.size = CGSize(width: SCREEN_SIZE.width ,height: SCREEN_SIZE.height - 100)
        
        let tapGesture6 = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        tapGesture6.cancelsTouchesInView = true
        scrollView.addGestureRecognizer(tapGesture6)
    }
    
    class func instance() -> support {
        
        let storyboard = UIStoryboard(name: "support", bundle: nil)
        return storyboard.instantiateInitialViewController() as! support
    }
    
    func sizeForPopup(_ popupController: PopupController, size: CGSize, showingKeyboard: Bool) -> CGSize {
        
        return CGSize(width: SCREEN_SIZE.width - 4 ,height: SCREEN_SIZE.height - 100)
    }
    
    @IBAction func sendMessage(_ sender: Any) {
        
        sendEmail()
    }
    
    func sendEmail() {
        
        guard let message = message.text , let phone = phone.text else
        {
            return
        }
        
        if phone.characters.count < 11
        {
            let alert = UIAlertController(title: "", message: "شماره موبایل را به صورت صحیح وارد کنید!", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "تایید", style: UIAlertActionStyle.default, handler: { action in
                switch action.style{
                case .default:
                    
                    break
                    
                case .cancel:
                    
                    print("cancel")
                    break
                    
                case .destructive:
                    
                    print("destructive")
                    break
                }
            }))
            
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        if MFMailComposeViewController.canSendMail() {
            
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["Buy@cando.ir"])
            mail.setSubject(phone)
            mail.setMessageBody(message , isHTML: true)
            
            present(mail, animated: true)
            
        } else {
            
            let alert = UIAlertController(title: "", message: "امکان ارسال ایمیل وجود ندارد", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "تایید", style: UIAlertActionStyle.default, handler: { action in
                switch action.style{
                case .default:
                    
                    self.closeHandler?()
                    break
                    
                case .cancel:
                    
                    print("cancel")
                    break
                    
                case .destructive:
                    
                    print("destructive")
                    break
                }
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        switch(result.rawValue) { // <-- Here, note .value is being used
            
        case MFMailComposeResult.cancelled.rawValue: // <-- And here as well!
            
            print("Cancelled")
            break
            
        case MFMailComposeResult.saved.rawValue:
            
            self.dismiss_(controller: controller)
            print("sent")
            break
            
        case MFMailComposeResult.sent.rawValue:
            
            self.dismiss_(controller: controller)
            print("saved")
            break
            
        default:
            print("Default")
        }
    }
    
    func dismiss_(controller: MFMailComposeViewController)
    {
        
        controller.dismiss(animated: true) {
            
            let alert = UIAlertController(title: "", message: "ایمیل به پشتیبانی ارسال شد.", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "تایید", style: UIAlertActionStyle.default, handler: { action in
                switch action.style{
                case .default:
                    
                    self.closeHandler?()
                    break
                    
                case .cancel:
                    
                    print("cancel")
                    break
                    
                case .destructive:
                    
                    print("destructive")
                    break
                }
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func back(_ sender: Any) {
        
        closeHandler?()
    }
    
    func hideKeyboard() {
        
        self.view.endEditing(true)
    }
}
