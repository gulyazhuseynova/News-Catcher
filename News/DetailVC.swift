//
//  DetailVC.swift
//  News
//
//  Created by Gulyaz Huseynova on 14.09.22.
//

import UIKit

class DetailVC: UIViewController {
    
    let defaults = UserDefaults.standard
    var newsInDetailVC : Articles?
    var checkVar = true
    var checkSave = true
    
    @IBOutlet weak var readMoreLabel: UILabel!
    @IBOutlet weak var separatorLine: UIView!
    @IBOutlet weak var returnText: UILabel!
    @IBOutlet weak var shareText: UIButton!
    @IBOutlet weak var saveText: UIButton!
    @IBOutlet weak var saveBackView: UIView!
    @IBOutlet weak var whiteView: UIView!
    @IBOutlet weak var returnButtonText: UIButton!
    @IBOutlet weak var returnBack: UIView!
    @IBOutlet weak var moreBack: UIView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var topicBack: UIView!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var excerpt: UILabel!
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var topic: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        navigationController?.navigationBar.isHidden = true
        hideOptions()
        
        returnLabelTapRecognizer ()
        readMoreLabelTapRecognizer ()
    }
    
    func setUpView() {
        topicBack.layer.cornerRadius = topicBack.frame.height / 3
        returnBack.layer.cornerRadius = returnBack.frame.height / 2
        moreBack.layer.cornerRadius = moreBack.frame.height / 2
        moreBack.layer.cornerRadius = moreBack.frame.height / 2
        whiteView.layer.cornerRadius = whiteView.frame.height / 20
        saveBackView.layer.cornerRadius = saveBackView.frame.height / 5
        
        topic.text = newsInDetailVC?.topic
        newsTitle.text = newsInDetailVC?.title
        author.text = newsInDetailVC?.author
        excerpt.text = newsInDetailVC?.excerpt
        summary.text = newsInDetailVC?.summary
        returnText.text = " ← \(newsInDetailVC?.title ?? "")"
        image.sd_setImage(with: newsInDetailVC?.media, placeholderImage: UIImage(named: "placeholder.png"))
    }
    
    func returnLabelTapRecognizer (){
        let tap = UITapGestureRecognizer(target: self, action: #selector(DetailVC.tapFunction1))
        returnText.isUserInteractionEnabled = true
        returnText.addGestureRecognizer(tap)
    }
    
    func readMoreLabelTapRecognizer () {
        let tap = UITapGestureRecognizer(target: self, action: #selector(DetailVC.tapFunction2))
        readMoreLabel.isUserInteractionEnabled = true
        readMoreLabel.addGestureRecognizer(tap)
    }
    
    @objc func tapFunction1(sender:UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
    }
    
    
    @objc func tapFunction2(sender:UITapGestureRecognizer) {
        
        guard let url = newsInDetailVC?.link, //Create non-optional URL to our website
              UIApplication.shared.canOpenURL(url) else {return}   //Check if app can open this URL
    
        UIApplication.shared.open(url) //Open our website in Safari
    }
    
    @IBAction func morePressed(_ sender: UIButton) {
        if checkVar == true {
            unhideOptions()
            checkVar = false
            rememberSaveSelected()
        }else{
            hideOptions()
            checkVar = true
        }
    }
    
    func rememberSaveSelected () {
        if let item = try? JSONEncoder().encode(newsInDetailVC) {
            if (defaults.array(forKey: "SV") as? [Data])?.contains(item) ?? false {
                self.saveText.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
            }else{
                self.saveText.setImage(UIImage(systemName: "bookmark"), for: .normal)
            }
        }

    }
    
    @IBAction func savePressed(_ sender: UIButton) {
        let encodedData = try? JSONEncoder().encode(newsInDetailVC)
        if let item = encodedData {
            if let arr = defaults.array(forKey: "SV"){
                var arrvalues = arr as! [Data]
                
                if arrvalues.contains(item) {
                    arrvalues = arrvalues.filter{$0 != item}
                    self.defaults.set(arrvalues, forKey: "SV")
                    self.defaults.synchronize()
                    self.saveText.setImage(UIImage(systemName: "bookmark"), for: .normal)
                }else{
                    arrvalues.append(item) // if list doesn't contain that element, append it
                    self.defaults.set(arrvalues, forKey: "SV")
                    self.defaults.synchronize()
                    self.saveText.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
                }
                
            }else{
                defaults.set([item], forKey: "SV")
            }
            
        }
        
    }
    
    @IBAction func sharePressed(_ sender: UIButton) {
        if let link = newsInDetailVC?.link {
            share(link: link)
        }
        checkVar = false
        hideOptions()
    }
    
    func share(link: URL) {
        let objectsToShare = [link] as [Any]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        self.present(activityVC, animated: true, completion: nil)
        
    }
    
    func hideOptions() {
        saveBackView.isHidden = true
        saveText.isHidden = true
        shareText.isHidden = true
        separatorLine.isHidden = true
    }
    func unhideOptions() {
        saveBackView.isHidden = false
        saveText.isHidden = false
        shareText.isHidden = false
        separatorLine.isHidden = false
        
    }
}

