// Example code that deserializes and serializes the model.
// extern crate serde;
// #[macro_use]
// extern crate serde_derive;
// extern crate serde_json;
//
// use generated_module::[object Object];
//
// fn main() {
//     let json = r#"{"answer": 42}"#;
//     let model: [object Object] = serde_json::from_str(&json).unwrap();
// }

use serde::{Serialize, Deserialize};

#[derive(Debug, Serialize, Deserialize)]
pub struct Record {
    #[serde(rename = "data")]
    data: Option<Data>,

    #[serde(rename = "id")]
    id: String,

    #[serde(rename = "kind_a")]
    kind_a: KindA,

    #[serde(rename = "kind_b")]
    kind_b: KindB,

    #[serde(rename = "kind_c")]
    kind_c: KindC,
}

#[derive(Debug, Serialize, Deserialize)]
pub struct Data {
    #[serde(rename = "raw_data")]
    raw_data: Vec<i64>,
}

#[derive(Debug, Serialize, Deserialize)]
pub struct KindAClass {
    #[serde(rename = "A")]
    a: Option<A>,

    #[serde(rename = "C")]
    c: Option<C>,
}

#[derive(Debug, Serialize, Deserialize)]
pub struct A {
    #[serde(rename = "description")]
    description: String,

    #[serde(rename = "value")]
    value: i64,
}

#[derive(Debug, Serialize, Deserialize)]
pub struct C {
    #[serde(rename = "id")]
    id: String,
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
#[derive(Debug, Serialize, Deserialize)]
pub struct KindB {
    #[serde(rename = "description")]
    description: Option<String>,

    #[serde(rename = "type")]
    kind_b_type: Type,

    #[serde(rename = "value")]
    value: Option<i64>,

    #[serde(rename = "id")]
    id: Option<String>,
}

#[derive(Debug, Serialize, Deserialize)]
pub struct KindC {
    #[serde(rename = "content")]
    content: Option<Content>,

    #[serde(rename = "type")]
    kind_c_type: Type,
}

#[derive(Debug, Serialize, Deserialize)]
pub struct Content {
    #[serde(rename = "description")]
    description: Option<String>,

    #[serde(rename = "value")]
    value: Option<i64>,

    #[serde(rename = "id")]
    id: Option<String>,
}

/// See [Enum representations · Serde](https://serde.rs/enum-representations.html) for
/// details.
#[derive(Debug, Serialize, Deserialize)]
#[serde(untagged)]
pub enum KindA {
    Enum(KindAEnum),

    KindAClass(KindAClass),
}

#[derive(Debug, Serialize, Deserialize)]
pub enum KindAEnum {
    #[serde(rename = "B")]
    B,

    #[serde(rename = "D")]
    D,
}

#[derive(Debug, Serialize, Deserialize)]
pub enum Type {
    #[serde(rename = "A")]
    A,

    #[serde(rename = "B")]
    B,

    #[serde(rename = "C")]
    C,

    #[serde(rename = "D")]
    D,
}
