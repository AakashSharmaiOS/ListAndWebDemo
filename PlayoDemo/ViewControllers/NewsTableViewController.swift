//
//  ViewController.swift
//  PlayoDemo
//
//  Created by Dev iOS on 7/14/22.
//

import UIKit

class NewsTableViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        getNewsData(pull: false)
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refreshTableView), for: .valueChanged)
        self.newsTableView.addSubview(refreshControl)
    }
    
    //MARK: Variables
    let refreshControl = UIRefreshControl()
    var newsData = NewsModel()
    let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
    
    //MARK: Outlets
    @IBOutlet weak var newsTableView: UITableView!
    
    
    //MARK: Actions
    @objc func refreshTableView(){
        getNewsData(pull: true)
    }
    
    //MARK: Functions
    func getNewsData(pull:Bool){
        if !pull {
        showLoader()
        }
        APIClass().CallAPI { responseData, error in
            if error == nil {
                do {
                    self.newsData = try JSONDecoder().decode(NewsModel.self, from: responseData!)
                    DispatchQueue.main.async {
                        self.refreshControl.endRefreshing()
                        self.newsTableView.reloadData()
                        self.alert.dismiss(animated: false, completion: nil)
                    }
                } catch {
                    print(error)
                }
            }else {
                self.alert.dismiss(animated: false, completion: nil)
                print(error?.localizedDescription ?? "")
            }
        }
    }

    func downloadImage(_ imageUrl: String?) -> UIImage{
        let url = URL(string: imageUrl ?? "")
        let imageData = try? Data(contentsOf: url!)
        return UIImage(data: imageData!) ?? UIImage()
    }
    
    func showLoader(){
        alert.view.tintColor = UIColor.black
        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50)) as UIActivityIndicatorView
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    
}

//TableviewExtension
extension NewsTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.newsData.articles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell") as! NewsTableViewCell
        let dict = self.newsData.articles?[indexPath.row]
        cell.titleLabel.text = dict?.title
        cell.authorLabel.text = dict?.author
        cell.descriptionLabel.text = dict?.description
        //get image directly
        DispatchQueue.main.async {
            cell.newsImage.image = self.downloadImage(dict?.urlToImage)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dict = self.newsData.articles?[indexPath.row]
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        vc.newsURL = dict?.url ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
