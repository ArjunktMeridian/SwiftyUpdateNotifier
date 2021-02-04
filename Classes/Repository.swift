//
//  Repository.swift
//  SwiftyUpdateNotifier
//
//  Created by mac on 04/02/21.
//

import Foundation
struct VersionCheckModel : Codable {
    var resultCount : Int?
    var results : [VersionResults]?

}


struct VersionResults : Codable {
    var artworkUrl512 : String?
    var screenshotUrls : [String]?
    var ipadScreenshotUrls : [String]?
    var appletvScreenshotUrls : [String]?
    var artistViewUrl : String?
    var artworkUrl60 : String?
    var artworkUrl100 : String?
    var supportedDevices : [String]?
    var advisories : [String]?
    var isGameCenterEnabled : Bool?
    var features : [String]?
    var kind : String?
    var languageCodesISO2A : [String]?
    var averageUserRatingForCurrentVersion : Int?
    var userRatingCountForCurrentVersion : Int?
    var trackContentRating : String?
    var trackCensoredName : String?
    var trackViewUrl : String?
    var contentAdvisoryRating : String?
    var fileSizeBytes : String?
    var averageUserRating : Int?
    var trackId : Int?
    var trackName : String?
    var releaseDate : String?
    var genreIds : [String]?
    var formattedPrice : String?
    var primaryGenreName : String?
    var minimumOsVersion : String?
    var isVppDeviceBasedLicensingEnabled : Bool?
    var sellerName : String?
    var currentVersionReleaseDate : String?
    var releaseNotes : String?
    var primaryGenreId : Int?
    var currency : String?
    var description : String?
    var artistId : Int?
    var artistName : String?
    var genres : [String]?
    var price : Double?
    var bundleId : String?
    var version : String?
    var wrapperType : String?
    var userRatingCount : Int?

}

final class Repository {
    
    private let apiClient: APIClient!
    private var url: String!
    
    init(apiClient: APIClient, url: String) {
        self.apiClient = apiClient
        self.url = url
    }
    
    func getVersion(_ completion: @escaping ((Result<VersionCheckModel>) -> Void)) {
        
        let resource = Resource(url: URL(string: url)!)
        
        apiClient.load(resource) { (result) in
            
            switch result {
            case .success(let data):
                do {
                    let items = try JSONDecoder().decode(VersionCheckModel.self, from: data)
                    completion(.success(items))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
    
}
