
/*var fruits = [
 ("Apple", UIColor.red),
 ("Banana", UIColor.yellow),
 ("Grape", UIColor.purple),
 ("Orange", UIColor.orange)
 ]*/

import UIKit

class Filter: UIViewController, PopupContentViewController, UITableViewDataSource , UITableViewDelegate , UITextFieldDelegate
{
    let types:[String] = ["همه اجناس" , "اجناس جدید" , "تخفیف ها"]
    
    var tapGesture:UITapGestureRecognizer!
    
    var closeHandler: (() -> Void)?
    
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var searchFor: UITextField!
    @IBOutlet weak var _Town: UIButton!
    @IBOutlet weak var _Type: UIButton!
    @IBOutlet weak var typesContainer: UIView!
    @IBOutlet weak var townContainer: UIView!
    
    var whichList = false //false == town list && true == mall list
    
    let cellId = "listId"
    
    //type dialog view + buttons
    lazy var typeDialogView : UIView! =
        {
            let dV = UIView()//(frame: CGRect(0, 0, SCREEN_SIZE.width/2 + SCREEN_SIZE.width/4, 60))
            dV.backgroundColor = UIColor.lightGray
            dV.layer.cornerRadius = 10
            dV.clipsToBounds = true
            dV.translatesAutoresizingMaskIntoConstraints = false
            return dV
    }()
    lazy var AllGoodsButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 80/255, green: 101/255, blue: 161/255 , alpha: 1)
        button.setTitle("همه اجناس", for: .normal)
        //button.setImage(UIImage(named: "ic_refresh"), for: .normal)
        button.tintColor = UIColor.white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.textColor = UIColor.white
        button.addTarget(self, action: #selector(AllGoodsType), for: .touchUpInside)
        return button
    }()
    lazy var NewGoodsButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 80/255, green: 101/255, blue: 161/255 , alpha: 1)
        button.setTitle("اجناس جدید", for: .normal)
        //button.setImage(UIImage(named: "ic_refresh"), for: .normal)
        button.tintColor = UIColor.white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.textColor = UIColor.white
        button.addTarget(self, action: #selector(NewGoodsType), for: .touchUpInside)
        return button
    }()
    lazy var OffsButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 80/255, green: 101/255, blue: 161/255 , alpha: 1)
        button.setTitle("تخفیف ها", for: .normal)
        //button.setImage(UIImage(named: "ic_refresh"), for: .normal)
        button.tintColor = UIColor.white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.textColor = UIColor.white
        button.addTarget(self, action: #selector(OffsType), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
    
        super.viewDidLoad()
        
        
        self.tableView.keyboardDismissMode = .onDrag
        
        typesContainer.layer.borderWidth = 1
        typesContainer.layer.borderColor = UIColor.black.cgColor
        typesContainer.layer.masksToBounds = true
        
        townContainer.layer.borderWidth = 1
        townContainer.layer.borderColor = UIColor.black.cgColor
        townContainer.layer.masksToBounds = true
        
        configTypeDialog()
        self.typeDialogView.isHidden = true
        
        selectedMallId = -1
        selectedTownId = -1
        filterType = 1
        isConfirmFiltering = false
        
        whichList = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTownList), name: NSNotification.Name(rawValue: "townListRecieved"), object: nil)
        
        searchFor.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        self.tableView.isHidden = true
        self.searchFor.isHidden = true
        typesContainer.isHidden = false
        
        if townList.count == 0
        {
            request.GetTownList()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        self.view.layer.cornerRadius = 4
        self.view.frame.origin.y = self.view.frame.origin.y - (self.parent?.tabBarController?.tabBar.frame.height)!/2 + 10.0
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        closeHandler?()
        print("here")
    }
    
    
    class func instance() -> Filter {
        
        let storyboard = UIStoryboard(name: "Filter", bundle: nil)
        return storyboard.instantiateInitialViewController() as! Filter
    }
    
    func sizeForPopup(_ popupController: PopupController, size: CGSize, showingKeyboard: Bool) -> CGSize {
        
        return CGSize(width: SCREEN_SIZE.width - 4, height: SCREEN_SIZE.height - 2 * (self.parent?.tabBarController?.tabBar.frame.height)!)
    }
    
    func configTypeDialog()
    {
        view.addSubview(typeDialogView)
        
        //x
        var horizontalConstraint = NSLayoutConstraint(item: typeDialogView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        //y
        var verticalConstraint = NSLayoutConstraint(item: typeDialogView, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0)
        //w
        var widthConstraint = NSLayoutConstraint(item: typeDialogView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: SCREEN_SIZE.width/2 + SCREEN_SIZE.width/4)
        //h
        var heightConstraint = NSLayoutConstraint(item: typeDialogView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: SCREEN_SIZE.height/4)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        typeDialogView.addSubview(AllGoodsButton)
        //x
        horizontalConstraint = NSLayoutConstraint(item: AllGoodsButton, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: typeDialogView, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
        //y
        verticalConstraint = NSLayoutConstraint(item: AllGoodsButton, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: typeDialogView, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        //w
        widthConstraint = NSLayoutConstraint(item: AllGoodsButton, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: typeDialogView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: AllGoodsButton, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: typeDialogView, attribute: NSLayoutAttribute.height, multiplier: 1/3, constant: 0)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        typeDialogView.addSubview(NewGoodsButton)
        //x
        horizontalConstraint = NSLayoutConstraint(item: NewGoodsButton, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: typeDialogView, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
        //y
        verticalConstraint = NSLayoutConstraint(item: NewGoodsButton, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: AllGoodsButton, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
        //w
        widthConstraint = NSLayoutConstraint(item: NewGoodsButton, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: typeDialogView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: NewGoodsButton, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: typeDialogView, attribute: NSLayoutAttribute.height, multiplier: 1/3, constant: 0)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        typeDialogView.addSubview(OffsButton)
        //x
        horizontalConstraint = NSLayoutConstraint(item: OffsButton, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: typeDialogView, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
        //y
        verticalConstraint = NSLayoutConstraint(item: OffsButton, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: NewGoodsButton, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
        //w
        widthConstraint = NSLayoutConstraint(item: OffsButton, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: typeDialogView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        //h
        heightConstraint = NSLayoutConstraint(item: OffsButton, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: typeDialogView, attribute: NSLayoutAttribute.height, multiplier: 1/3, constant: 0)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
    
    func configuerTouchOutOfTypeDialog()
    {
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(TouchOutOfDialog))
        tapGesture.numberOfTapsRequired = 1
        view.addGestureRecognizer(tapGesture)
    }
}

extension Filter
{
    func reloadTownList()
    {
        DispatchQueue.main.async {
            
            self.tableView.reloadData()
        }
    }
    
    @IBAction func closeFiltering(_ sender: AnyObject) {
        
        closeHandler?()
    }
    
    @IBAction func selectTownFiltering(_ sender: AnyObject) {
        
        if self.tableView.isHidden
        {
            self.tableView.isHidden = false
            self.searchFor.isHidden = false
            self.typesContainer.isHidden = true
            selectedMallId = -1
            selectedTownId = -1
            whichList = false
            townMallList = townMallListCopy
            townList = townListCopy
            searchFor.text = ""
            tableView.reloadData()
        }
        else
        {
            self.tableView.isHidden = true
            self.searchFor.isHidden = true
            self.typesContainer.isHidden = false
        }
    }
    
    @IBAction func selectTypeFiltering(_ sender: AnyObject) {
        
        configuerTouchOutOfTypeDialog()
        self.typeDialogView.isHidden = false
        filterType = -1
        self.view.bringSubview(toFront: self.typeDialogView)
    }
    
    @IBAction func confirmFiltering(_ sender: AnyObject) {
        
        isConfirmFiltering = true
        closeHandler?()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if !whichList {
            
            return townList.count
        }
        return townMallList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! FilterTableViewCell
        if !whichList {
            
            cell.label.text = townList[indexPath.row].twName
            cell.rightIcon.image = UIImage(named: "ic_room_36pt")
            cell.leftIcon.image = UIImage(named: "moreinfo")
        }
        else
        {
            cell.label.text = townMallList[indexPath.row].MallName as! String?
            cell.rightIcon.image = UIImage(named: "ic_room_36pt")
            cell.leftIcon.image = UIImage(named: "moreinfo")
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if !whichList
        {
            selectedTownIndex = indexPath.row
            selectedTownId = townList[indexPath.row].Id!
            self.GetTownMallList(TwId: selectedTownId)
            townList = townListCopy
            searchFor.text = ""
        }
        else
        {
            whichList = false
            selectedMallId = townMallList[indexPath.row].Id as! Int
            self.tableView.isHidden = true
            self.searchFor.isHidden = true
            self.typesContainer.isHidden = false
            if selectedTownId == -1
            {
                self._Town.setTitle(("همه شهرها - \(townMallList[indexPath.row].MallName!)") , for: UIControlState.normal)
            }
            else
            {
                self._Town.setTitle(("\(townList[selectedTownIndex].twName!) - \(townMallList[indexPath.row].MallName!)") , for: UIControlState.normal)
            }
            townMallList = townMallListCopy
            searchFor.text = ""
        }
    }
    
    func textFieldDidChange(_ textField: UITextField) {
        
        if !whichList
        {
            if textField.text! == "" {
                
                townList = townListCopy
            }
            else
            {
                townList = [Town]()
                for town in townListCopy {
                    
                    if (town.twName?.contains(textField.text!))! {
                        
                        townList.append(town)
                    }
                }
            }
            self.tableView.reloadData()
        }
        else
        {
            if textField.text! == "" {
                
                townMallList = townMallListCopy
            }
            else
            {
                townMallList = [Mall]()
                for mall in townMallListCopy {
                    
                    if (mall.MallName?.contains(textField.text!))! {
                        
                        townMallList.append(mall)
                    }
                }
            }
            self.tableView.reloadData()
        }
    }
    
    func GetTownMallList(TwId:Int)
    {
        let soapMessage = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><MallForFilter xmlns=\"http://BuyApp.ir/\"><twId>\(TwId)</twId></MallForFilter></soap:Body></soap:Envelope>"
        
        let soapLenth = String(soapMessage.characters.count)
        let theUrlString = Request.webServiceAddress
        let theURL = NSURL(string: theUrlString)
        let mutableR = NSMutableURLRequest(url: theURL! as URL)
        
        mutableR.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        mutableR.addValue("text/html; charset=utf-8", forHTTPHeaderField: "Content-Type")
        mutableR.addValue(soapLenth, forHTTPHeaderField: "Content-Length")
        mutableR.httpMethod = "POST"
        mutableR.httpBody = soapMessage.data(using: String.Encoding.utf8)
        
        let configuration: URLSessionConfiguration = URLSessionConfiguration.default
        let session : URLSession = URLSession(configuration: configuration)
        
        let dataTask = session.dataTask(with: mutableR as URLRequest) {data,response,error in
            
            if error == nil
            {
                if let httpResponse = response as? HTTPURLResponse
                {
                    print(httpResponse.statusCode)
                    
                    var dictionaryData = NSDictionary()
                    
                    do
                    {
                        dictionaryData = try XMLReader.dictionary(forXMLData: data) as NSDictionary
                        
                        //let mainDict = dictionaryData.objectForKey("soap:Envelope")!.objectForKey("soap:Body")!.objectForKey("TownListResponse")!.objectForKey("TownListResult")   ?? NSDictionary()
                        let mainDict3 = dictionaryData.object(forKey: "soap:Envelope") as! NSDictionary
                        let mainDict2 = mainDict3.object(forKey: "soap:Body") as! NSDictionary
                        let mainDict1 = mainDict2.object(forKey: "MallForFilterResponse") as! NSDictionary
                        let mainDict = mainDict1.object(forKey: "MallForFilterResult") as! NSDictionary
                        
                        //print(mainDict1)
                        //print(mainDict)
                        
                        if mainDict.count > 0{
                            
                            let mainD = NSDictionary(dictionary: mainDict as [NSObject : AnyObject])
                            var cont = mainD["text"] as? String
                            cont = "{ \"content\" : " + cont! + "}"
                            
                            let data = (cont)?.data(using: .utf8)!
                            
                            guard let _result = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String : AnyObject] else{
                                
                                return
                            }
                            
                            if let _malls = _result["content"] as? [AnyObject]{
                                
                                townMallList = [Mall]()
                                var newmall = Mall(Id: -1 as AnyObject, twId: -1 as AnyObject , MallName: "همه پاساژها و محدوده ها" as AnyObject, MallDescription: "" as AnyObject , MallAddress: "" as AnyObject , MallTel: "" as AnyObject , MallLogo: "" as AnyObject , MallActive: false as AnyObject, IsMall: true as AnyObject , Stores:0 as AnyObject)
                                townMallList.append(newmall)
                                for mall in _malls{
                                    
                                    if let actmall = mall as? [String : AnyObject]{
                                        
                                        newmall = Mall(Id: actmall["Id"]!, twId: -1 as AnyObject , MallName: actmall["MallName"]!, MallDescription: "" as AnyObject , MallAddress: "" as AnyObject , MallTel: "" as AnyObject , MallLogo: "" as AnyObject , MallActive: false as AnyObject, IsMall: actmall["IsMall"]!, Stores: 0 as AnyObject)//Stores: actmall["Stores"]!)
                                        townMallList.append(newmall)
                                    }
                                }
                                if townMallList.count > 0
                                {
                                    self.whichList = true
                                    townMallListCopy = townMallList
                                    
                                    DispatchQueue.main.async {
                                        
                                        self.tableView.reloadData()
                                    }
                                }
                            }
                        }
                        else{
                            
                        }
                    }
                    catch
                    {
                        //print("Your Dictionary value nil")
                    }
                }
            }
            else
            {
                print("nil data")
            }
        }
        dataTask.resume()
    }
    
    //search dialog funcs
    func AllGoodsType()
    {
        self.view.removeGestureRecognizer(self.tapGesture)
        filterType = -1
        self.typeDialogView.isHidden = true
        self._Type.setTitle(types[filterType + 1], for: UIControlState.normal)
    }
    func NewGoodsType()
    {
        self.view.removeGestureRecognizer(self.tapGesture)
        filterType = 0
        self.typeDialogView.isHidden = true
        self._Type.setTitle(types[filterType + 1], for: UIControlState.normal)
    }
    func OffsType()
    {
        self.view.removeGestureRecognizer(self.tapGesture)
        filterType = 1
        self.typeDialogView.isHidden = true
        self._Type.setTitle(types[filterType + 1], for: UIControlState.normal)
    }
    func TouchOutOfDialog()
    {
        typeDialogView.isHidden = true
        self.view.removeGestureRecognizer(self.tapGesture)
    }
}

class FilterTableViewCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var rightIcon: UIImageView!
    @IBOutlet weak var leftIcon: UIImageView!
}
