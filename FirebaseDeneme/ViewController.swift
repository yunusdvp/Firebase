//
//  ViewController.swift
//  FirebaseDeneme
//
//  Created by Yunus Emre ÖZŞAHİN on 27.07.2024.
//

import UIKit

class ViewController: UIViewController {
    
    let playerRepository = ServiceContainer.shared.playerRepository
    let imageStorage = FirebaseImageStorage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPlayers()
        // Örnek bir oyuncu ve resim ekleme
        /*let sampleImage = UIImage(named: "sampleImage")!
         let player = Player(id: nil,
         name: "Ahmet Yılmaz",
         position: "Forward",
         skillRating: 85,
         age: 25,
         sports: ["football": true, "volleyball": false],
         gender: "Male",
         profilePhotoURL: nil)
         
         playerRepository.addPlayer(player: player, image: sampleImage) { result in
         switch result {
         case .success:
         print("Oyuncu başarıyla eklendi!")
         //self.fetchPlayers()
         case .failure(let error):
         print("Hata: \(error.localizedDescription)")
         }
         }
         }
         */
        func fetchPlayers() {
            // Oyuncuları filtrelemeden çek
            playerRepository.fetchPlayers(withFilters: []) { result in
                switch result {
                case .success(let players):
                    for player in players {
                        print("Oyuncu: \(player.name), Pozisyon: \(player.position), Yetenek Puanı: \(player.skillRating), ProfileImageUrl:\(player.profilePhotoURL ?? "")")
                        if let profilePhotoURL = player.profilePhotoURL {
                            self.imageStorage.downloadProfileImage(url: profilePhotoURL) { result in
                                switch result {
                                case .success(let image):
                                    // Resmi UI'da göster
                                    print("Resim başarıyla indirildi")
                                    print(player.profilePhotoURL)
                                    // Örneğin bir UIImageView'da göstermek için:
                                    // imageView.image = image
                                case .failure(let error):
                                    print("Resim indirme hatası: \(error.localizedDescription)")
                                }
                            }
                        }
                    }
                case .failure(let error):
                    print("Hata: \(error.localizedDescription)")
                }
            }
        }
    }
}
