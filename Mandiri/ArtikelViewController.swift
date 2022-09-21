//
//  ArtikelViewController.swift
//  Mandiri
//
//  Created by Aritio modernland on 16/03/22.
//

import UIKit

class ArtikelViewController: BaseViewController,UISearchBarDelegate {

    @IBOutlet weak var tvList: UITableView!
    @IBOutlet weak var vEmptyState: UIView!
    @IBOutlet weak var lblDashboard: UILabel!
    
    @IBOutlet weak var btnKembali: UIButton!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    let vm = ArtikelViewModel()
    var id = ""
    var kategori = ""
    
    var newsArtikel = [NewsArtikel]()
    var filteredEmployees = [NewsArtikel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filteredEmployees = newsArtikel
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupTableView()
        getListArtikel()

        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func setupTableView() {
        tvList.delegate = self
        tvList.dataSource = self
        
        let nearestNib = UINib.init(nibName: "ListMenu2TableViewCell", bundle: nil)
        tvList.register(nearestNib, forCellReuseIdentifier: "ListMenu")
    }
    
    func getListArtikel() {
        let apiKey = "bcbfc1d35e3d4524a1e98180f64ad260"
        showLoading()
        vm.postListArtikel(
            apiKey : apiKey,
            sources : self.id,
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
        let storyboard = UIStoryboard.init(name: "Source", bundle: nil)
        let secondVc = storyboard.instantiateViewController(withIdentifier: "CategoriesViewController") as! CategoriesViewController
        secondVc.kategori = self.kategori
        secondVc.modalPresentationStyle = .fullScreen
        secondVc.modalTransitionStyle = .crossDissolve
                
        present(secondVc, animated: true, completion: nil)
    }
    
}

extension ArtikelViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(listIOM.count)
        return filteredEmployees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListMenu", for: indexPath) as! ListMenu2TableViewCell
        
        cell.lblNomor.text = filteredEmployees[indexPath.row].author
        cell.lblTitle.text = filteredEmployees[indexPath.row].description
        cell.lblSubTitle.text = filteredEmployees[indexPath.row].title
        cell.lblStatus.text = filteredEmployees[indexPath.row].url
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard.init(name: "WebView", bundle: nil)
        let secondVc = storyboard.instantiateViewController(withIdentifier: "WebViewViewController") as! WebViewViewController
        secondVc.url = filteredEmployees[indexPath.row].url ?? ""
        secondVc.id = self.id
        secondVc.modalPresentationStyle = .fullScreen
        secondVc.modalTransitionStyle = .crossDissolve
                
        present(secondVc, animated: true, completion: nil)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        filteredEmployees = searchText.isEmpty ? filteredEmployees : filteredEmployees.filter { filteredEmployees in
            return filteredEmployees.description?.range(of: searchText, options: .caseInsensitive) != nil
        }
        self.tvList.reloadData()
    }
}
