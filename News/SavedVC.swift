//
//  SavedVC.swift
//  News
//
//  Created by Gulyaz Huseynova on 16.09.22.
//

import UIKit

class SavedVC: UIViewController {
    var dataFromDetail: Articles?
    let defaults = UserDefaults.standard
    var savedList: [Articles] = []
    
    @IBOutlet weak var todaysDate: UILabel!
    @IBOutlet weak var emptyCheck: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        savedList = []
        if let arr = defaults.array(forKey: "SV") {
            for data in arr{
                let arrValues = data as! Data
                if let decodedData = try? JSONDecoder().decode(Articles.self, from: arrValues){
                    self.savedList.append(decodedData)
                }
            }
            tableView.reloadData()
            print("reloaded")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        todaysDate.text = Date.now.getFormattedDate(format: "MMMM dd, yyyy")
        
    }
    
}

extension SavedVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if savedList.count == 0 {
            emptyCheck.text = "No news saved yet"
        }else {
            emptyCheck.isHidden = true
        }
        
        return savedList.count
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! TableViewCell
        
        let item = savedList[indexPath.row]
        cell.topic.text = item.topic
        cell.title.text = item.title
        
        if let date = item.date as? Date?{
            cell.dateLabel.text = date?.getFormattedDate(format: "dd.MM.yy")
        }
        
        cell.author.text = item.author
        cell.newsImage.sd_setImage(with: item.media, placeholderImage: UIImage(named: "placeholder.png"))
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SaveToDetail" {
            if let destination = segue.destination as? DetailVC{
                destination.newsInDetailVC = dataFromDetail
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.dataFromDetail = savedList[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        print("aaa")
        self.performSegue(withIdentifier: "SaveToDetail", sender: self)
        
    }
}



