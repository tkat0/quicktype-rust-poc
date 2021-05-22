//! Generate JSON schema from Rust's struct
use schemars::{schema_for, JsonSchema};
use serde::{Deserialize, Serialize};
use std::fs::File;

#[derive(Serialize, Deserialize, JsonSchema)]
struct Record {
    id: String,
    data: Option<Data>,
    kind_a: KindA,
    kind_b: KindB,
    kind_c: KindC,
}
#[derive(Serialize, Deserialize, JsonSchema)]
struct Data {
    raw_data: Vec<i32>,
}

/// This enum split into two objects, enum including B and D, and class including A and C.
/// I think this is a specification of `schemars`.
#[derive(Serialize, Deserialize, JsonSchema)]
enum KindA {
    A { value: i32, description: String },
    B,
    C { id: String },
    D,
}

/// If `#[serde(tag = "type")]` is set, all variants is merged as optional property.
/// See [Enum representations · Serde](https://serde.rs/enum-representations.html) for details.
///
/// ```python
/// @dataclass
/// class Kind:
///     type: TypeEnum
///     description: Optional[str] = None
///     value: Optional[int] = None
///     id: Optional[str] = None
/// ```
///
/// ```go
/// type Kind struct {
/// 	Description *string `json:"description,omitempty"`
/// 	Type        Type    `json:"type"`                 
/// 	Value       *int64  `json:"value,omitempty"`      
/// 	ID          *string `json:"id,omitempty"`         
/// }
/// ```
///
/// ```swift
/// struct Kind: Codable {
/// let kindDescription: String?
/// let type: TypeEnum
/// let value: Int?
/// let id: String?
/// ```
#[derive(Serialize, Deserialize, JsonSchema)]
#[serde(tag = "type")]
enum KindB {
    A { value: i32, description: String },
    B,
    C { id: String },
    D,
}

/// A content property is splitt into a single class that all property is merged as Optional.
/// ```python
/// @dataclass
/// class Content:
///     description: Optional[str] = None
///     value: Optional[int] = None
///     id: Optional[str] = None
/// ```
#[derive(Serialize, Deserialize, JsonSchema)]
#[serde(tag = "type", content = "content")]
enum KindC {
    A { value: i32, description: String },
    B,
    C { id: String },
    D,
}


fn main() {
    // generate JSON schema by `schemars`
    let schema = schema_for!(Record);

    serde_json::to_writer_pretty(&File::create("generated/schema.json").unwrap(), &schema).unwrap();
}
