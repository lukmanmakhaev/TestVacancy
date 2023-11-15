// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let news = try? JSONDecoder().decode(News.self, from: jsonData)

import Foundation

class Responce: Codable {
    let items: [Vacancy]?
    let found, pages, perPage, page: Int?
    let clusters, arguments: JSONNull?
    let suggests: Suggests?
    let fixes: Fixes?
    let alternateURL: String?

    enum CodingKeys: String, CodingKey {
        case items, found, pages
        case perPage
        case page, clusters, arguments, fixes, suggests
        case alternateURL
    }

    init(items: [Vacancy]?, found: Int?, pages: Int?, perPage: Int?, page: Int?, clusters: JSONNull?, arguments: JSONNull?, fixes: Fixes?, suggests: Suggests?, alternateURL: String?) {
        self.items = items
        self.found = found
        self.pages = pages
        self.perPage = perPage
        self.page = page
        self.clusters = clusters
        self.arguments = arguments
        self.fixes = fixes
        self.suggests = suggests
        self.alternateURL = alternateURL
    }
}

// MARK: - Item
class Vacancy: Codable {
    let id: String?
    //let premium: Bool?
    let name: String?
    //let department: Employment?
    //let hasTest, responseLetterRequired: Bool?
    //let area: Area?
    let salary: Salary?
    //let type: Employment?
    //let address: Address?
    //let responseURL, sortPointDistance: JSONNull?
    //let publishedAt, createdAt: Date?
    //let archived: Bool?
    //let applyAlternateURL: String?
    //let showLogoInSearch: Bool?
    //let insiderInterview: JSONNull?
    //let url, alternateURL: String?
    //let relations: [JSONAny]?
    let employer: Employer?
    let snippet: Snippet?
    //let contacts: JSONNull?
    //let schedule: Employment?
    //let workingDays: [JSONAny]?
    //let workingTimeIntervals, workingTimeModes: [Employment]?
    //let acceptTemporary: Bool?
    //let professionalRoles: [Employment]?
    //let acceptIncompleteResumes: Bool?
    //let experience, employment: Employment?
    //let advResponseURL: JSONNull?
    //let isAdvVacancy: Bool?
    //let branding: Branding?

    enum CodingKeys: String, CodingKey {
        case id, name
        case salary
        case employer, snippet
    }
    init(id: String?, name: String?, salary: Salary?, employer: Employer?, snippet: Snippet?) {
        self.id = id
        self.name = name
        self.salary = salary
        self.employer = employer
        self.snippet = snippet
    }

}


// MARK: - Address
class Address: Codable {
    let city, street, building: String?
    let lat, lng: Double?
    let description: JSONNull?
    let raw: String?
    let metro: Metro?
    let metroStations: [Metro]?
    let id: String?

    enum CodingKeys: String, CodingKey {
        case city, street, building, lat, lng, description, raw, metro
        case metroStations
        case id
    }

    init(city: String?, street: String?, building: String?, lat: Double?, lng: Double?, description: JSONNull?, raw: String?, metro: Metro?, metroStations: [Metro]?, id: String?) {
        self.city = city
        self.street = street
        self.building = building
        self.lat = lat
        self.lng = lng
        self.description = description
        self.raw = raw
        self.metro = metro
        self.metroStations = metroStations
        self.id = id
    }
}

// MARK: - Metro
class Metro: Codable {
    let stationName: String?
    let lineName: LineName?
    let stationID, lineID: String?
    let lat, lng: Double?

    enum CodingKeys: String, CodingKey {
        case stationName
        case lineName
        case stationID
        case lineID
        case lat, lng
    }

    init(stationName: String?, lineName: LineName?, stationID: String?, lineID: String?, lat: Double?, lng: Double?) {
        self.stationName = stationName
        self.lineName = lineName
        self.stationID = stationID
        self.lineID = lineID
        self.lat = lat
        self.lng = lng
    }
}

enum LineName: String, Codable {
    case автозаводская = "Автозаводская"
    case первая = "Первая"
    case таганскоКраснопресненская = "Таганско-Краснопресненская"
}

// MARK: - Area
class Area: Codable {
    let id, name: String?
    let url: String?

    init(id: String?, name: String?, url: String?) {
        self.id = id
        self.name = name
        self.url = url
    }
}

// MARK: - Branding
class Branding: Codable {
    let type: String?
    let tariff: String?

    init(type: String?, tariff: String?) {
        self.type = type
        self.tariff = tariff
    }
}

// MARK: - Employment
class Employment: Codable {
    let id, name: String?

    init(id: String?, name: String?) {
        self.id = id
        self.name = name
    }
}

// MARK: - Employer
class Employer: Codable {
    let id, name: String?
    let url, alternateURL: String?
    let logoUrls: LogoUrls?
    let vacanciesURL: String?
    let accreditedItEmployer, trusted: Bool?

    enum CodingKeys: String, CodingKey {
        case id, name, url
        case alternateURL
        case logoUrls = "logo_urls"
        case vacanciesURL = "vacancies_url"
        case accreditedItEmployer
        case trusted
    }

    init(id: String?, name: String?, url: String?, alternateURL: String?, logoUrls: LogoUrls?, vacanciesURL: String?, accreditedItEmployer: Bool?, trusted: Bool?) {
        self.id = id
        self.name = name
        self.url = url
        self.alternateURL = alternateURL
        self.logoUrls = logoUrls
        self.vacanciesURL = vacanciesURL
        self.accreditedItEmployer = accreditedItEmployer
        self.trusted = trusted
    }
}

// MARK: - LogoUrls
class LogoUrls: Codable {
    let the90, the240: String?
    let original: String?

    enum CodingKeys: String, CodingKey {
        case the90 = "90"
        case the240 = "240"
        case original = "original"
    }

    init(the90: String?, the240: String?, original: String?) {
        self.the90 = the90
        self.the240 = the240
        self.original = original
    }
    
}

// MARK: - Salary
class Salary: Codable {
    let from: Int?
    let to: Int?
    let currency: Currency?
    let gross: Bool?
    
    var fullSalaryString: String {
        var fromStr = ""
        var toStr = ""
        var currencyStr = ""
        if let from = from {
            fromStr = "от \(from) "
        }
        if let to = to {
            toStr = "до \(to) "
        }
        if let currency = currency  {
            currencyStr = "\(currency)"
        }
        return fromStr + toStr + currencyStr
    }

    
    init(from: Int?, to: Int?, currency: Currency?, gross: Bool?) {
        self.from = from
        self.to = to
        self.currency = currency
        self.gross = gross
    }
}

enum Currency: String, Codable {
    case BYR = "BYR"
    case KZT = "KZT"
    case RUR = "RUR"
    case UZS = "UZS"
    case EUR = "EUR"
    case USD = "USD"
    case GBP = "GBP"
    case UAH = "UAH"
    case CAD = "CAD"
    case JPY = "JPY"
    case AUD = "AUD"
    case CHF = "CHF"
    case CNY = "CNY"
    case INR = "INR"
    case BRL = "BRL"
    case MXN = "MXN"
    case RUB = "RUB"
    case SAR = "SAR"
    case SEK = "SEK"
    case NOK = "NOK"
    case `TRY` = "TRY"
    case NZD = "NZD"
    case HKD = "HKD"
    case PLN = "PLN"
    case KRW = "KRW"
    case SGD = "SGD"
    case ZAR = "ZAR"
}

// MARK: - Snippet
class Snippet: Codable {
    let requirement, responsibility: String?

    init(requirement: String?, responsibility: String?) {
        self.requirement = requirement
        self.responsibility = responsibility
    }
}

// MARK: - Suggests
class Suggests: Codable {
    let value: String?
    let found: Int?

    init(value: String?, found: Int?) {
        self.value = value
        self.found = found
    }
}

// MARK: - Fixes
class Fixes: Codable {
    let original, fixed: String?

    init(original: String?, fixed: String?) {
        self.original = original
        self.fixed = fixed
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}
