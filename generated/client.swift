// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let record = try Record(json)

import Foundation

// MARK: - Record
struct Record: Codable {
    let data: DataClass?
    let id: String
    let kindA: KindA
    let kindB: KindB
    let kindC: KindC

    enum CodingKeys: String, CodingKey {
        case data, id
        case kindA = "kind_a"
        case kindB = "kind_b"
        case kindC = "kind_c"
    }
}

// MARK: Record convenience initializers and mutators

extension Record {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Record.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        data: DataClass?? = nil,
        id: String? = nil,
        kindA: KindA? = nil,
        kindB: KindB? = nil,
        kindC: KindC? = nil
    ) -> Record {
        return Record(
            data: data ?? self.data,
            id: id ?? self.id,
            kindA: kindA ?? self.kindA,
            kindB: kindB ?? self.kindB,
            kindC: kindC ?? self.kindC
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - DataClass
struct DataClass: Codable {
    let rawData: [Int]

    enum CodingKeys: String, CodingKey {
        case rawData = "raw_data"
    }
}

// MARK: DataClass convenience initializers and mutators

extension DataClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(DataClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        rawData: [Int]? = nil
    ) -> DataClass {
        return DataClass(
            rawData: rawData ?? self.rawData
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

/// See [Enum representations · Serde](https://serde.rs/enum-representations.html) for
/// details.
enum KindA: Codable {
    case enumeration(KindAEnum)
    case kindAClass(KindAClass)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(KindAEnum.self) {
            self = .enumeration(x)
            return
        }
        if let x = try? container.decode(KindAClass.self) {
            self = .kindAClass(x)
            return
        }
        throw DecodingError.typeMismatch(KindA.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for KindA"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .enumeration(let x):
            try container.encode(x)
        case .kindAClass(let x):
            try container.encode(x)
        }
    }
}

// MARK: - KindAClass
struct KindAClass: Codable {
    let a: A?
    let c: C?

    enum CodingKeys: String, CodingKey {
        case a = "A"
        case c = "C"
    }
}

// MARK: KindAClass convenience initializers and mutators

extension KindAClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(KindAClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        a: A?? = nil,
        c: C?? = nil
    ) -> KindAClass {
        return KindAClass(
            a: a ?? self.a,
            c: c ?? self.c
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - A
struct A: Codable {
    let aDescription: String
    let value: Int

    enum CodingKeys: String, CodingKey {
        case aDescription = "description"
        case value
    }
}

// MARK: A convenience initializers and mutators

extension A {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(A.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        aDescription: String? = nil,
        value: Int? = nil
    ) -> A {
        return A(
            aDescription: aDescription ?? self.aDescription,
            value: value ?? self.value
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - C
struct C: Codable {
    let id: String
}

// MARK: C convenience initializers and mutators

extension C {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(C.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        id: String? = nil
    ) -> C {
        return C(
            id: id ?? self.id
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum KindAEnum: String, Codable {
    case b = "B"
    case d = "D"
}

/// If `#[serde(tag = "type")]` is set, all variants is merged as optional property.
///
/// ```python @dataclass class Kind: type: TypeEnum description: Optional[str] = None value:
/// Optional[int] = None id: Optional[str] = None ```
///
/// ```go type Kind struct { Description *string `json:"description,omitempty"` Type
/// Type    `json:"type"` Value       *int64  `json:"value,omitempty"` ID          *string
/// `json:"id,omitempty"` } ```
///
/// ```swift struct Kind: Codable { let kindDescription: String? let type: TypeEnum let
/// value: Int? let id: String? ```
// MARK: - KindB
struct KindB: Codable {
    let kindBDescription: String?
    let type: TypeEnum
    let value: Int?
    let id: String?

    enum CodingKeys: String, CodingKey {
        case kindBDescription = "description"
        case type, value, id
    }
}

// MARK: KindB convenience initializers and mutators

extension KindB {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(KindB.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        kindBDescription: String?? = nil,
        type: TypeEnum? = nil,
        value: Int?? = nil,
        id: String?? = nil
    ) -> KindB {
        return KindB(
            kindBDescription: kindBDescription ?? self.kindBDescription,
            type: type ?? self.type,
            value: value ?? self.value,
            id: id ?? self.id
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum TypeEnum: String, Codable {
    case a = "A"
    case b = "B"
    case c = "C"
    case d = "D"
}

// MARK: - KindC
struct KindC: Codable {
    let content: Content?
    let type: TypeEnum
}

// MARK: KindC convenience initializers and mutators

extension KindC {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(KindC.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        content: Content?? = nil,
        type: TypeEnum? = nil
    ) -> KindC {
        return KindC(
            content: content ?? self.content,
            type: type ?? self.type
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Content
struct Content: Codable {
    let contentDescription: String?
    let value: Int?
    let id: String?

    enum CodingKeys: String, CodingKey {
        case contentDescription = "description"
        case value, id
    }
}

// MARK: Content convenience initializers and mutators

extension Content {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Content.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        contentDescription: String?? = nil,
        value: Int?? = nil,
        id: String?? = nil
    ) -> Content {
        return Content(
            contentDescription: contentDescription ?? self.contentDescription,
            value: value ?? self.value,
            id: id ?? self.id
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}
