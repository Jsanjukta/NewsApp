//
//  ListViewController.swift
//  News App
//
//  Created by Krishna on 25/09/19.
//  Copyright © 2019 Krishna. All rights reserved.
//

import UIKit
import CoreData

class ListViewController: UIViewController , UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{
    
    //MARK: - IBOutles and Variables -
    @IBOutlet weak var searchBarNews: UISearchBar!
    @IBOutlet weak var tblListTable: UITableView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    var arrNews = [NewsData]()
    var arrtitle = [String]()
    var arrDesc = [String]()
    
    //MARK: - View lifeCycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "News List"
        loader.stopAnimating()
        searchBarNews.backgroundImage = UIImage()
        ServiceCallGetNews(withSearchString: "")
        // Do any additional setup after loading the view.
    }
    
    //Fetch from local DB
    func fetchData(){
        let arrNewsData = CoreDataManager.sharedInstance.fetchNews()
        for data in arrNewsData as! [NSManagedObject] {
            arrtitle.append(data.value(forKey: "title") as! String)
            arrDesc.append(data.value(forKey: "desc") as! String)
        }
        DispatchQueue.main.async {
            self.tblListTable.reloadData()
        }
    }
    
    //MARK: - UITableView Delegates and DataSource -
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrNews.count  == 0 ? arrtitle.count : arrNews.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as! ListTableViewCell
        cell.lblTitle.text = arrNews.count > 0 ? arrNews[indexPath.section].title : arrtitle[indexPath.section]
        cell.lblDesc.text = arrNews.count > 0 ? arrNews[indexPath.section].newsDesc : arrDesc[indexPath.section]
        if arrNews.count > 0  && self.searchBarNews.text?.count ?? 0 > 3{
            let isSuccess = CoreDataManager.sharedInstance.insertNews(withTitle: arrNews[indexPath.section].title ?? "", withDesc: arrNews[indexPath.section].newsDesc ?? "")
            if isSuccess {
                print("News saved succes")
            }else{
                print("Error in saving News")
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        CELL_ANIMATION.cellAnimating(cell: cell)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if arrNews.count > 0 {
            let detailVC = INITIATE.INITIATE_STORY_BOARD(identifier: "DetailViewController") as! DetailViewController
            detailVC.strContent = self.arrNews[indexPath.section].content
            detailVC.strTitle = self.arrNews[indexPath.section].title
            detailVC.imgUrl = self.arrNews[indexPath.section].imgUrl
            self.navigationController?.pushViewController(detailVC, animated: true)
        } else {
            let alert = UIAlertController(title: "Alert", message: "Please check your internet connection.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //MARK: - UISearchbar delegate -
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
         ServiceCallGetNews(withSearchString: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBarNews.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        ServiceCallGetNews(withSearchString: "")
    }
    
    //MARK: - Service Call Method -
    private func ServiceCallGetNews(withSearchString strSearchText : String){
        loader.startAnimating()
        APIManager.sharedInstance.getRequestAPI(url: APIURL.TOP_HEADLINES + "&q=" + strSearchText) { (news, error) in
            if let error = error {
                print("Get news error: \(error.localizedDescription)")
                self.fetchData()
                return
            }
            guard let news = news  else { return }
            if news.status == "ok"{
                print("Current news Object:")
                print(news)
                self.arrNews = news.articles
                DispatchQueue.main.async {
                    self.loader.stopAnimating()
                    self.tblListTable.reloadData()
                }
            } else {
                print("Some thing went wrong")
            }
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
