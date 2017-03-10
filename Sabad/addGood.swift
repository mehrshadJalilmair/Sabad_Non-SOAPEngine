//
//  addGood.swift
//  Sabad
//
//  Created by Mehrshad JM on 3/10/17.
//  Copyright © 2017 Mehrshad Jalilmasir. All rights reserved.
//

import UIKit
import DatePickerDialog

class addGood: UIViewController , UIScrollViewDelegate , UIImagePickerControllerDelegate, UINavigationControllerDelegate , UITextFieldDelegate{
    
    var store:Store!
    var haveImage = false
    var imageAddress = ""
    @IBOutlet var scrollView: UIScrollView!
    
    let imagePicker = UIImagePickerController()
    
    let ImagesContainer : UIView! = {
        
        let filterView = UIView()
        filterView.backgroundColor = UIColor.green
        filterView.translatesAutoresizingMaskIntoConstraints = false
        filterView.layer.cornerRadius = 3
        filterView.layer.masksToBounds = true
        filterView.backgroundColor = UIColor.red
        return filterView
    }()
    lazy var logo: UIImageView! = {
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named:"nedstark")
        imageView.tag = 0
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pickLogo(_:))))
        return imageView
    }()
    
    lazy var delLogoImageBtn: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 80, g: 101, b: 161)
        //button.setTitle("پیگیری", for: .normal)
        button.setImage(UIImage(named: "ic_delete_forever_white"), for: .normal)
        button.tintColor = UIColor.white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.isHidden = true
        //button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        
        //button.semanticContentAttribute = .forceRightToLeft
        button.showsTouchWhenHighlighted = true
        button.tag = 0
        button.addTarget(self, action: #selector(delImage(_:)), for: .touchUpInside)
        return button
    }()
    
    let NameContainer : UIView! = {
        
        let filterView = UIView()
        filterView.backgroundColor = UIColor.green
        filterView.translatesAutoresizingMaskIntoConstraints = false
        filterView.layer.cornerRadius = 3
        filterView.layer.masksToBounds = true
        filterView.backgroundColor = UIColor.red
        return filterView
    }()
    let NameLabel: UILabel! = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.black
        label.text = "* عنوان کالا"
        label.textAlignment = .right
        label.backgroundColor = UIColor.red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let NameTextFieald: FloatLabelTextField! = {
        
        let NameTextFieald = FloatLabelTextField()
        NameTextFieald.font = UIFont.systemFont(ofSize: 14)
        NameTextFieald.textColor = UIColor.black
        NameTextFieald.textAlignment = .center
        NameTextFieald.placeholder = "عنوان کالا..."
        NameTextFieald.textAlignment = .center
        NameTextFieald.backgroundColor = UIColor.white
        NameTextFieald.tintColor = UIColor.red
        NameTextFieald.translatesAutoresizingMaskIntoConstraints = false
        return NameTextFieald
    }()
    
    
    
    let PriceContainer : UIView! = { //price
        
        let filterView = UIView()
        filterView.backgroundColor = UIColor.green
        filterView.translatesAutoresizingMaskIntoConstraints = false
        filterView.layer.cornerRadius = 3
        filterView.layer.masksToBounds = true
        filterView.backgroundColor = UIColor.red
        return filterView
    }()
    let PriceLabel: UILabel! = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.black
        label.text = "* قیمت کالا"
        label.textAlignment = .right
        label.backgroundColor = UIColor.red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let PriceTextField: FloatLabelTextField! = {
        
        let NameTextFieald = FloatLabelTextField()
        NameTextFieald.font = UIFont.systemFont(ofSize: 14)
        NameTextFieald.textColor = UIColor.black
        NameTextFieald.textAlignment = .center
        NameTextFieald.placeholder = "قیمت کالا"
        NameTextFieald.textAlignment = .center
        NameTextFieald.backgroundColor = UIColor.white
        NameTextFieald.tintColor = UIColor.red
        NameTextFieald.keyboardType = .numberPad
        NameTextFieald.translatesAutoresizingMaskIntoConstraints = false
        return NameTextFieald
    }()
    
    
    let DescriptionContainer : UIView! = { //description
        
        let filterView = UIView()
        filterView.backgroundColor = UIColor.green
        filterView.translatesAutoresizingMaskIntoConstraints = false
        filterView.layer.cornerRadius = 3
        filterView.layer.masksToBounds = true
        filterView.backgroundColor = UIColor.red
        return filterView
    }()
    let DescriptionLabel: UILabel! = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.black
        label.text = "توضیحات"
        label.textAlignment = .right
        label.backgroundColor = UIColor.red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let DescriptionTextField: FloatLabelTextField! = {
        
        let NameTextFieald = FloatLabelTextField()
        NameTextFieald.font = UIFont.systemFont(ofSize: 14)
        NameTextFieald.textColor = UIColor.black
        NameTextFieald.textAlignment = .center
        NameTextFieald.placeholder = "توضیحات"
        NameTextFieald.textAlignment = .center
        NameTextFieald.backgroundColor = UIColor.white
        NameTextFieald.tintColor = UIColor.red
        NameTextFieald.keyboardType = .phonePad
        NameTextFieald.translatesAutoresizingMaskIntoConstraints = false
        return NameTextFieald
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        openGettingStoreFields = false
        
        initImagesContainer()
        initNameContainer()
        initPriceContainer()
        initDescriptionContainer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        setScrollViewContentSize()
    }
    
    override func viewDidLayoutSubviews() {
        
        delLogoImageBtn.layer.cornerRadius = delLogoImageBtn.frame.size.width/2
        delLogoImageBtn.clipsToBounds = true
        
        NameTextFieald.layer.cornerRadius = 3
        NameTextFieald.layer.masksToBounds = true
        //NameTextFieald.hintYPadding = -100
        NameTextFieald.titleYPadding = -2
        
        PriceTextField.layer.cornerRadius = 3
        PriceTextField.layer.masksToBounds = true
        //PriceTextField.hintYPadding = -20
        PriceTextField.titleYPadding = -2
        
        DescriptionTextField.layer.cornerRadius = 3
        DescriptionTextField.layer.masksToBounds = true
        //DescriptionTextFieald.hintYPadding = -20
        DescriptionTextField.titleYPadding = -2
        
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        tapGesture1.cancelsTouchesInView = true
        NameContainer.addGestureRecognizer(tapGesture1)
        
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        tapGesture2.cancelsTouchesInView = true
        PriceContainer.addGestureRecognizer(tapGesture2)
        
        let tapGesture6 = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        tapGesture6.cancelsTouchesInView = true
        DescriptionLabel.addGestureRecognizer(tapGesture6)
    }
    
    func setScrollViewContentSize() {
        
        var height: CGFloat
        
        let lastViewYPos = self.DescriptionContainer.frame.origin.y  // this is absolute positioning, not relative
        let lastViewHeight = self.DescriptionContainer.frame.size.height
        
        height = lastViewYPos + lastViewHeight + 5
        
        scrollView.contentSize.height = height
        
        scrollView.isUserInteractionEnabled = true
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
    }
    
    func initImagesContainer()
    {
        //let width = ((SCREEN_SIZE.width) / 2) - 10
        let height = ((SCREEN_SIZE.width) / 4)
        
        scrollView.addSubview(ImagesContainer)
        //x
        var horizontalConstraint = NSLayoutConstraint(item: ImagesContainer, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        //y
        var verticalConstraint = NSLayoutConstraint(item: ImagesContainer, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.top, multiplier: 1, constant: +5)
        //w
        var widthConstraint = NSLayoutConstraint(item: ImagesContainer, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: -10)
        //h
        var heightConstraint = NSLayoutConstraint(item: ImagesContainer, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: height)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        ImagesContainer.addSubview(logo)
        //x
        horizontalConstraint = NSLayoutConstraint(item: logo, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: ImagesContainer, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0)
        //y
        verticalConstraint = NSLayoutConstraint(item: logo, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: ImagesContainer, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: +5.5)
        //w
        widthConstraint = NSLayoutConstraint(item: logo, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: ImagesContainer, attribute: NSLayoutAttribute.width, multiplier: 1/4, constant: -5)
        //h
        heightConstraint = NSLayoutConstraint(item: logo, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: height - 5)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        ImagesContainer.addSubview(delLogoImageBtn)
        //x
        horizontalConstraint = NSLayoutConstraint(item: delLogoImageBtn, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: logo, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 2)
        //y
        verticalConstraint = NSLayoutConstraint(item: delLogoImageBtn, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: logo, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 2)
        //w
        widthConstraint = NSLayoutConstraint(item: delLogoImageBtn, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: logo, attribute: NSLayoutAttribute.width, multiplier: 1/3, constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: delLogoImageBtn, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: logo, attribute: NSLayoutAttribute.width, multiplier: 1/3, constant: 0)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
    
    func initNameContainer()
    {
        scrollView.addSubview(NameContainer)
        //x
        var horizontalConstraint = NSLayoutConstraint(item: NameContainer, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: ImagesContainer, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: +5)
        //y
        var verticalConstraint = NSLayoutConstraint(item: NameContainer, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        //w
        var widthConstraint = NSLayoutConstraint(item: NameContainer, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: -10)
        //h
        var heightConstraint = NSLayoutConstraint(item: NameContainer, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 60)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        NameContainer.addSubview(NameLabel)
        //x
        horizontalConstraint = NSLayoutConstraint(item: NameLabel, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: NameContainer, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: -3)
        //y
        verticalConstraint = NSLayoutConstraint(item: NameLabel, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: NameContainer, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        //w
        widthConstraint = NSLayoutConstraint(item: NameLabel, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: NameContainer, attribute: NSLayoutAttribute.width, multiplier: 1/2, constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: NameLabel, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 20)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        NameContainer.addSubview(NameTextFieald)
        //x
        horizontalConstraint = NSLayoutConstraint(item: NameTextFieald, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: NameContainer, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: -3)
        //y
        verticalConstraint = NSLayoutConstraint(item: NameTextFieald, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: NameLabel, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: +5)
        //w
        widthConstraint = NSLayoutConstraint(item: NameTextFieald, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: NameContainer, attribute: NSLayoutAttribute.width, multiplier: 3/4, constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: NameTextFieald, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute , multiplier: 1, constant: 30)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
    
    func initPriceContainer()
    {
        scrollView.addSubview(PriceContainer)
        //x
        var horizontalConstraint = NSLayoutConstraint(item: PriceContainer, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: NameContainer, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: +5)
        //y
        var verticalConstraint = NSLayoutConstraint(item: PriceContainer, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        //w
        var widthConstraint = NSLayoutConstraint(item: PriceContainer, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: -10)
        //h
        var heightConstraint = NSLayoutConstraint(item: PriceContainer, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 60)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        PriceContainer.addSubview(PriceLabel)
        //x
        horizontalConstraint = NSLayoutConstraint(item: PriceLabel, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: PriceContainer, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: -3)
        //y
        verticalConstraint = NSLayoutConstraint(item: PriceLabel, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: PriceContainer, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        //w
        widthConstraint = NSLayoutConstraint(item: PriceLabel, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: PriceContainer, attribute: NSLayoutAttribute.width, multiplier: 1/2, constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: PriceLabel, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 20)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        PriceContainer.addSubview(PriceTextField)
        //x
        horizontalConstraint = NSLayoutConstraint(item: PriceTextField, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: PriceContainer, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: -3)
        //y
        verticalConstraint = NSLayoutConstraint(item: PriceTextField, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: PriceLabel, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: +5)
        //w
        widthConstraint = NSLayoutConstraint(item: PriceTextField, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: PriceContainer, attribute: NSLayoutAttribute.width, multiplier: 3/4, constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: PriceTextField, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute , multiplier: 1, constant: 30)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
    
    func initDescriptionContainer()
    {
        scrollView.addSubview(DescriptionContainer)
        //x
        var horizontalConstraint = NSLayoutConstraint(item: DescriptionContainer, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: PriceContainer, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: +5)
        //y
        var verticalConstraint = NSLayoutConstraint(item: DescriptionContainer, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        //w
        var widthConstraint = NSLayoutConstraint(item: DescriptionContainer, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: -10)
        //h
        var heightConstraint = NSLayoutConstraint(item: DescriptionContainer, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 60)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        DescriptionContainer.addSubview(DescriptionLabel)
        //x
        horizontalConstraint = NSLayoutConstraint(item: DescriptionLabel, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: DescriptionContainer, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: -3)
        //y
        verticalConstraint = NSLayoutConstraint(item: DescriptionLabel, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: DescriptionContainer, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        //w
        widthConstraint = NSLayoutConstraint(item: DescriptionLabel, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: DescriptionContainer, attribute: NSLayoutAttribute.width, multiplier: 1/2, constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: DescriptionLabel, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 20)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        DescriptionContainer.addSubview(DescriptionTextField)
        //x
        horizontalConstraint = NSLayoutConstraint(item: DescriptionTextField, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: DescriptionContainer, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: -3)
        //y
        verticalConstraint = NSLayoutConstraint(item: DescriptionTextField, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: DescriptionLabel, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: +5)
        //w
        widthConstraint = NSLayoutConstraint(item: DescriptionTextField, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: DescriptionContainer, attribute: NSLayoutAttribute.width, multiplier: 3/4, constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: DescriptionTextField, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute , multiplier: 1, constant: 30)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
}

extension addGood
{
    @IBAction func back(_ sender: Any) {
        
        self.dismiss(animated: true) {
            
            
        }
    }
    @IBAction func confirm(_ sender: Any) {
        
        guard let name = NameTextFieald.text, let price = PriceTextField.text , let description = DescriptionTextField.text else {
            
            
            print("Form is not valid")
            return
        }
        
        if name.isEmpty || price.isEmpty
        {
            let alertWarning = UIAlertView(title:"توجه", message: "* فیلدهای ضروری را پر کنید!", delegate:nil, cancelButtonTitle:"تایید", otherButtonTitles:"")
            alertWarning.show()
            return
        }
        
        if haveImage
        {
            myImageUploadRequest(name: name, price: price, description: description)
        }
        else
        {
            sendInfoToServer(name: name, price: price, description: description)
        }
        
    }
    
    func hideKeyboard() {
        
        self.view.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
    }
    
    
    func pickLogo(_ sender: AnyObject)
    {
        print("logo")
        chooseSource()
    }
    
    func chooseSource()
    {
        let alert:UIAlertController=UIAlertController(title: "انتخاب عکس از :", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        let cameraAction = UIAlertAction(title: "دوربین", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
            self.openCamera()
        }
        let gallaryAction = UIAlertAction(title: "گالری", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
            self.openGallary()
        }
        let cancelAction = UIAlertAction(title: "لغو", style: UIAlertActionStyle.cancel)
        {
            UIAlertAction in
        }
        
        // Add the actions
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera))
        {
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            self .present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alertWarning = UIAlertView(title:"توجه", message: "دوربین در دسترس نیست!", delegate:nil, cancelButtonTitle:"تایید", otherButtonTitles:"")
            alertWarning.show()
            
        }
    }
    func openGallary()
    {
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    //PickerView Delegate Methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var image : UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"]  as? UIImage{
            
            image = editedImage
        }
        else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            
            image = originalImage
        }
        
        haveImage = true
        logo.image = image
        delLogoImageBtn.isHidden = false
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController)
    {
        print("picker cancel.")
    }
    
    func delImage(_ sender: AnyObject)
    {
        delLogoImageBtn.isHidden = true
        logo.image = UIImage(named: "nedstark")
        haveImage = false
    }

    func myImageUploadRequest(name:String , price:String ,description:String)
    {
        let myUrl = NSURL(string: "http://94.182.4.13:8012/SabadPic/Image/Upload.php?num=6")
        
        let request = NSMutableURLRequest(url:myUrl! as URL)
        request.httpMethod = "POST"
        
        let boundary = generateBoundaryString()
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        
        var imageData = Data()
        
        imageData = UIImageJPEGRepresentation(logo.image!, 0.4)!
        
        request.httpBody = createBodyWithParameters(parameters: [:], filePathKey: "uploaded_file", imageDataKey: imageData as NSData, boundary: boundary) as Data
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            
            if error != nil {
                
                DispatchQueue.main.async {
                    
                    
                }
                print("error=\(error)")
                return
            }
            let httpResponse = response as? HTTPURLResponse
            
            if httpResponse?.statusCode != 200
            {
                DispatchQueue.main.async {
                    
                    
                }
                return
            }
            
            self.sendInfoToServer(name: name, price: price , description: description)
        }
        task.resume()
    }
    
    func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: NSData, boundary: String) -> NSData
    {
        let body = NSMutableData();
        
        if parameters != nil {
            
            
            for (key, value) in parameters! {
                body.appendString(string: "--\(boundary)\r\n")
                body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString(string: "\(value)\r\n")
            }
            
        }
        
        let now = Date()
        let nowcalendar = Calendar.current
        
        let year = nowcalendar.component(.year, from: now)
        let month = nowcalendar.component(.month, from: now)
        let day = nowcalendar.component(.day, from: now)
        let hour = nowcalendar.component(.hour, from: now)
        let min = nowcalendar.component(.minute, from: now)
        let sec = nowcalendar.component(.second, from: now)
        
        let nowDate = "\(year)\(month)\(day)\(hour)\(min)\(sec)"
        
        
        let filename = "ios_\(nowDate).jpg"
        
        imageAddress = "http://94.182.4.13:8012/SabadPic/Image/Store/\(filename)"
        
        let mimetype = "image/jpg"
        
        body.appendString(string: "--\(boundary)\r\n")
        body.appendString(string: "Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
        body.appendString(string: "Content-Type: \(mimetype)\r\n\r\n")
        body.append(imageDataKey as Data)
        body.appendString(string: "\r\n")
        
        body.appendString(string: "--\(boundary)--\r\n")
        return body
    }
    
    func generateBoundaryString() -> String {
        
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    func sendInfoToServer(name:String , price:String ,description:String)
    {
        print("here")
    }
}

