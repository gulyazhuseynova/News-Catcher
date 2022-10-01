//
//  HomeVC.swift
//  News
//
//  Created by Gulyaz Huseynova on 08.09.22.
//

import UIKit
import SDWebImage


class HomeVC: UIViewController  {
    var checkLang = "EN"
    var newsManager = NewsManager()
    var newsInHomeVC : NewsData?
    var headlines : NewsData?
    var newsTyped = ""
    var checkVar = true
    
    
    @IBOutlet weak var todayDate: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchTextField: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var newsLanguage: UIButton!
    @IBOutlet weak var languageView: UIView!

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setBindings()
        newsManager.getRequestCollection(lang: checkLang)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        languageView.isHidden = true
        tableView.dataSource = self
        tableView.delegate = self
        collectionView.dataSource = self
        collectionView.delegate = self
        searchTextField.delegate = self
        newsLanguage.layer.cornerRadius = newsLanguage.frame.height / 3
        
        todayDate.text = Date.now.getFormattedDate(format: "MMMM dd, yyyy")
    }
    
    
    
    @IBAction func languageButton(_ sender: UIButton) {
        if checkVar == true{
            checkVar = false
            languageView.isHidden = false
        }else{
            checkVar = true
            languageView.isHidden = true
        }
    }
    @IBAction func englishPressed(_ sender: UIButton) {
        
        checkLang = "EN"
        newsLanguage.setTitle(checkLang, for: .normal)
        
        newsManager.getRequest(info: newsTyped , lang: "en")
      
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.newsManager.getRequestCollection(lang: "en")
        }
        
        languageView.isHidden = true
        checkVar = true
    }
    
    @IBAction func russianPressed(_ sender: UIButton) {
        
        checkLang = "RU"
        newsLanguage.setTitle(checkLang, for: .normal)
    
        newsManager.getRequest(info: newsTyped , lang: "ru")
    
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.newsManager.getRequestCollection(lang: "ru")
        }
        languageView.isHidden = true
        checkVar = true
    }
    
    func setBindings() {
        newsManager.success = {item in
            DispatchQueue.main.async {
                self.newsInHomeVC = item
                self.tableView.reloadData()
            }
        }
        newsManager.success2 = {item in
            DispatchQueue.main.async {
                self.headlines = item
                self.collectionView.reloadData()
            }
        }
    }
    
}

extension HomeVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        newsInHomeVC?.articles.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! TableViewCell
        
        if let news = newsInHomeVC?.articles[indexPath.row] {
            cell.topic.text = news.topic
            cell.title.text = news.title
            
            if let date = news.date as? Date?{
                cell.dateLabel.text = date?.getFormattedDate(format: "dd.MM.yy")
            }
            
            cell.author.text = news.author
            cell.newsImage.sd_setImage(with: news.media, placeholderImage: UIImage(named: "placeholder.png"))
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
        detailVC.modalPresentationStyle = .overFullScreen
        detailVC.newsInDetailVC = newsInHomeVC?.articles[indexPath.row]
        
        present(detailVC, animated: true, completion: nil)
    }
}

extension HomeVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        headlines?.articles.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReusableCell", for: indexPath) as! CollectionViewCell
        if let headline = headlines?.articles[indexPath.row]{
            cell.topic.text = headline.topic
            cell.title.text = headline.title
            cell.image.sd_setImage(with: headline.media, placeholderImage: UIImage(named: "placeholder.png"))
        }
//        if let date = headlines?.articles.first?.date as? Date?{
//            self.todayDate.text = date?.getFormattedDate(format: "dd.MM.yy")
//
//        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
        detailVC.modalPresentationStyle = .overFullScreen
        detailVC.newsInDetailVC = headlines?.articles[indexPath.row]
        
        present(detailVC, animated: true, completion: nil)
    }
    
}


extension HomeVC: UISearchBarDelegate {
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchTextField.endEditing(true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if searchTextField.text != ""{
            newsTyped = searchTextField.text!
            newsManager.getRequest(info: newsTyped, lang: checkLang )
            searchTextField.text = ""
        }
    }
    
}

extension Date {
    func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}
