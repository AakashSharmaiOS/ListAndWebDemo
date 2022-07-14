import Foundation
struct NewsModel : Codable {
	var status : String?
	var totalResults : Int?
	var articles : [Articles]?

	enum CodingKeys: String, CodingKey {

		case status = "status"
		case totalResults = "totalResults"
		case articles = "articles"
	}
}

struct Articles : Codable {
    var source : Source?
    var author : String?
    var title : String?
    var description : String?
    var url : String?
    var urlToImage : String?
    var publishedAt : String?
    var content : String?

    enum CodingKeys: String, CodingKey {

        case source = "source"
        case author = "author"
        case title = "title"
        case description = "description"
        case url = "url"
        case urlToImage = "urlToImage"
        case publishedAt = "publishedAt"
        case content = "content"
    }
}

struct Source : Codable {
    var id : String?
    var name : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
    }
}
