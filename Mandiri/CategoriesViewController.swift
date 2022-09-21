//
//  CategoriesViewController.swift
//  Mandiri
//
//  Created by Aritio modernland on 15/03/22.
//
import UIKit

class CategoriesViewController: BaseViewController,UISearchBarDelegate {
    
    @IBOutlet weak var tvList: UITableView!
    @IBOutlet weak var vEmptyState: UIView!
    @IBOutlet weak var lblDashboard: UILabel!
    
    @IBOutlet weak var txtLanguage: UITextField!
    @IBOutlet weak var btnKembali: UIButton!
    
    @IBOutlet weak var searchBar: UISearchBar!
    

    
    let vm = CategoriesViewModel()
    var kategori = ""
    var searching = 0
    var newsCategories = [NewsCategories]()
    var filteredEmployees = [NewsCategories]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filteredEmployees = newsCategories
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupTableView()
        getListCategories()
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func setupTableView() {
        tvList.delegate = self
        tvList.dataSource = self
        
        let nearestNib = UINib.init(nibName: "TableView", bundle: nil)
        tvList.register(nearestNib, forCellReuseIdentifier: "ListMenu")
    }
    
    func getListCategories() {
        let apiKey = "bcbfc1d35e3d4524a1e98180f64ad260"
        showLoading()
        vm.postListCategories(
            apiKey : apiKey,
            kategori : self.kategori,
            onSuccess: { response in
                self.hideLoading()
                self.filteredEmployees.removeAll()
                for filteredEmployees in response {
                    self.filteredEmployees.append(filteredEmployees)
                }
                if self.filteredEmployees.isEmpty {
                    self.vEmptyState.isHidden = false
                }
                self.tvList.reloadData()
        }, onError: { error in
            self.hideLoading()
            print(error)
            Toast.show(message: error, controller: self)
        }, onFailed: { failed in
            self.hideLoading()
            print(failed)
            Toast.show(message: failed, controller: self)
        })
    }
  
    
    @IBAction func btnKembali(_ sender: UIButton) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let secondVc = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        secondVc.modalPresentationStyle = .fullScreen
        secondVc.modalTransitionStyle = .crossDissolve
                
        present(secondVc, animated: true, completion: nil)
    }
    
}

extension CategoriesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(listIOM.count)
        return filteredEmployees.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListMenu", for: indexPath) as! TableView
        cell.lblSource.text = filteredEmployees[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard.init(name: "Artikel", bundle: nil)
        let secondVc = storyboard.instantiateViewController(withIdentifier: "ArtikelViewController") as! ArtikelViewController
        secondVc.id = filteredEmployees[indexPath.row].id ?? ""
        secondVc.kategori = self.kategori
        secondVc.modalPresentationStyle = .fullScreen
        secondVc.modalTransitionStyle = .crossDissolve
                
        present(secondVc, animated: true, completion: nil)
    }
    
    // This method updates filteredData based on the text in the Search Box
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        filteredEmployees = searchText.isEmpty ? filteredEmployees : filteredEmployees.filter { filteredEmployees in
            return filteredEmployees.name?.range(of: searchText, options: .caseInsensitive) != nil
        }
        tvList.reloadData()
    }
}
