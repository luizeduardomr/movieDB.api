//
//  MovieViewController.swift
//  api-tmdb
//
//  Created by Luiz Eduardo Mello dos Reis on 02/07/21.
//

import UIKit

class MovieViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var movies: [Movie] = []
    let apirequest = ApiRequestPopular()
    var moviesNP: [Movie] = []
    let apirequestNP = ApiRequestNP()
    
    
    @IBOutlet weak var TableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TableView.dataSource = self
        TableView.delegate = self
        
        apirequest.requestApiPopular { (movies) in
            self.movies = movies
            
            DispatchQueue.main.async{
                self.TableView.reloadData()
            }
            
            self.apirequestNP.requestApiNP{ (moviesNP) in
                self.movies = movies}
            DispatchQueue.main.async{
                self.TableView.reloadData()
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //return movies[section].title.count
        if section == 0 {
            return movies.count
        }
        else {
            return moviesNP.count
        }

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = TableView.dequeueReusableCell(withIdentifier: "cellmovie", for: indexPath) as! MovieTableViewCell
            
            let movies = movies[indexPath.row]
            
            cell.title.text = movies.title
            cell.descriptionMovie.text = movies.description
            cell.rating.text = String(movies.rating)
            // requisicao para pegar a imagem
            cell.coverImage.image = UIImage(named: movies.coverImage)
            
            return cell
        }
        else {
            
            let cell = TableView.dequeueReusableCell(withIdentifier: "cellmovie", for: indexPath) as! MovieTableViewCell
            let moviesNP = moviesNP[indexPath.row]
            cell.title.text = moviesNP.title
            cell.descriptionMovie.text = moviesNP.description
            cell.rating.text = String(moviesNP.rating)
            cell.coverImage.image = UIImage(named: moviesNP.coverImage)
            return cell
        }
       
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Lembrem-se de colocar um booleano pra controlar as requisições
        // E lembrem-se de controlarem em que página estamos para pedirmos apenas a próxima
        if (indexPath.row == movies.count - 1) {
            apirequest.requestApiPopular(page: 2) { (movies) in
                self.movies.append(contentsOf: movies)
                
                DispatchQueue.main.async {
                    self.TableView.reloadData()
                }
            }
        }
    }
    

}
    
    
