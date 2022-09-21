//
//  CategoriesViewController.swift
//
//

import UIKit

class ViewController: BaseViewController,UISearchBarDelegate  {
    
    @IBOutlet weak var tvList: UITableView!
    @IBOutlet weak var lblDashboard: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var CategeryArray = ["business","entertainment","general","health","science","sports","technology"]
    var filteredData: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filteredData = CategeryArray
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupTableView()
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func setupTableView() {
        tvList.delegate = self
        tvList.dataSource = self
        
        let nearestNib = UINib.init(nibName: "ListNameTableViewCell", bundle: nil)
        tvList.register(nearestNib, forCellReuseIdentifier: "ListMenu")
    }
}
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(listIOM.count)
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListMenu", for: indexPath) as! ListNameTableViewCell
        cell.lblName.text = self.filteredData[indexPath.row]
        
        return cell
    }
    
    
    // This method updates filteredData based on the text in the Search Box
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // When there is no text, filteredData is the same as the original data
        // When user has entered text into the search box
        // Use the filter method to iterate over all items in the data array
        // For each item, return true if the item should be included and false if the
        // item should NOT be included
        filteredData = searchText.isEmpty ? CategeryArray : CategeryArray.filter({(dataString: String) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return dataString.range(of: searchText, options: .caseInsensitive) != nil
        })

        tvList.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard.init(name: "Source", bundle: nil)
        let secondVc = storyboard.instantiateViewController(withIdentifier: "CategoriesViewController") as! CategoriesViewController
        secondVc.kategori = self.CategeryArray[indexPath.row]
        secondVc.modalPresentationStyle = .fullScreen
        secondVc.modalTransitionStyle = .crossDissolve
                
        present(secondVc, animated: true, completion: nil)
    }
    
}
