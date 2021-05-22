// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse and unparse this JSON data, add this code to your project and do:
//
//    record, err := UnmarshalRecord(bytes)
//    bytes, err = record.Marshal()

package client

import "bytes"
import "errors"
import "encoding/json"

func UnmarshalRecord(data []byte) (Record, error) {
	var r Record
	err := json.Unmarshal(data, &r)
	return r, err
}

func (r *Record) Marshal() ([]byte, error) {
	return json.Marshal(r)
}

type Record struct {
	Data  *Data  `json:"data"`  
	ID    string `json:"id"`    
	KindA *KindA `json:"kind_a"`
	KindB KindB  `json:"kind_b"`
	KindC KindC  `json:"kind_c"`
}

type Data struct {
	RawData []int64 `json:"raw_data"`
}

type KindAClass struct {
	A *AClass `json:"A,omitempty"`
	C *CClass `json:"C,omitempty"`
}

type AClass struct {
	Description string `json:"description"`
	Value       int64  `json:"value"`      
}

type CClass struct {
	ID string `json:"id"`
}

// If `#[serde(tag = "type")]` is set, all variants is merged as optional property.
//
// ```python @dataclass class Kind: type: TypeEnum description: Optional[str] = None value:
// Optional[int] = None id: Optional[str] = None ```
//
// ```go type Kind struct { Description *string `json:"description,omitempty"` Type
// Type    `json:"type"` Value       *int64  `json:"value,omitempty"` ID          *string
// `json:"id,omitempty"` } ```
//
// ```swift struct Kind: Codable { let kindDescription: String? let type: TypeEnum let
// value: Int? let id: String? ```
type KindB struct {
	Description *string `json:"description,omitempty"`
	Type        Type    `json:"type"`                 
	Value       *int64  `json:"value,omitempty"`      
	ID          *string `json:"id,omitempty"`         
}

type KindC struct {
	Content *Content `json:"content,omitempty"`
	Type    Type     `json:"type"`             
}

type Content struct {
	Description *string `json:"description,omitempty"`
	Value       *int64  `json:"value,omitempty"`      
	ID          *string `json:"id,omitempty"`         
}

type KindAEnum string
const (
	KindAB KindAEnum = "B"
	KindAD KindAEnum = "D"
)

type Type string
const (
	A Type = "A"
	C Type = "C"
	TypeB Type = "B"
	TypeD Type = "D"
)

// See [Enum representations · Serde](https://serde.rs/enum-representations.html) for
// details.
type KindA struct {
	Enum       *KindAEnum
	KindAClass *KindAClass
}

func (x *KindA) UnmarshalJSON(data []byte) error {
	x.KindAClass = nil
	x.Enum = nil
	var c KindAClass
	object, err := unmarshalUnion(data, nil, nil, nil, nil, false, nil, true, &c, false, nil, true, &x.Enum, false)
	if err != nil {
		return err
	}
	if object {
		x.KindAClass = &c
	}
	return nil
}

func (x *KindA) MarshalJSON() ([]byte, error) {
	return marshalUnion(nil, nil, nil, nil, false, nil, x.KindAClass != nil, x.KindAClass, false, nil, x.Enum != nil, x.Enum, false)
}

func unmarshalUnion(data []byte, pi **int64, pf **float64, pb **bool, ps **string, haveArray bool, pa interface{}, haveObject bool, pc interface{}, haveMap bool, pm interface{}, haveEnum bool, pe interface{}, nullable bool) (bool, error) {
	if pi != nil {
		*pi = nil
	}
	if pf != nil {
		*pf = nil
	}
	if pb != nil {
		*pb = nil
	}
	if ps != nil {
		*ps = nil
	}

	dec := json.NewDecoder(bytes.NewReader(data))
	dec.UseNumber()
	tok, err := dec.Token()
	if err != nil {
		return false, err
	}

	switch v := tok.(type) {
	case json.Number:
		if pi != nil {
			i, err := v.Int64()
			if err == nil {
				*pi = &i
				return false, nil
			}
		}
		if pf != nil {
			f, err := v.Float64()
			if err == nil {
				*pf = &f
				return false, nil
			}
			return false, errors.New("Unparsable number")
		}
		return false, errors.New("Union does not contain number")
	case float64:
		return false, errors.New("Decoder should not return float64")
	case bool:
		if pb != nil {
			*pb = &v
			return false, nil
		}
		return false, errors.New("Union does not contain bool")
	case string:
		if haveEnum {
			return false, json.Unmarshal(data, pe)
		}
		if ps != nil {
			*ps = &v
			return false, nil
		}
		return false, errors.New("Union does not contain string")
	case nil:
		if nullable {
			return false, nil
		}
		return false, errors.New("Union does not contain null")
	case json.Delim:
		if v == '{' {
			if haveObject {
				return true, json.Unmarshal(data, pc)
			}
			if haveMap {
				return false, json.Unmarshal(data, pm)
			}
			return false, errors.New("Union does not contain object")
		}
		if v == '[' {
			if haveArray {
				return false, json.Unmarshal(data, pa)
			}
			return false, errors.New("Union does not contain array")
		}
		return false, errors.New("Cannot handle delimiter")
	}
	return false, errors.New("Cannot unmarshal union")

}

func marshalUnion(pi *int64, pf *float64, pb *bool, ps *string, haveArray bool, pa interface{}, haveObject bool, pc interface{}, haveMap bool, pm interface{}, haveEnum bool, pe interface{}, nullable bool) ([]byte, error) {
	if pi != nil {
		return json.Marshal(*pi)
	}
	if pf != nil {
		return json.Marshal(*pf)
	}
	if pb != nil {
		return json.Marshal(*pb)
	}
	if ps != nil {
		return json.Marshal(*ps)
	}
	if haveArray {
		return json.Marshal(pa)
	}
	if haveObject {
		return json.Marshal(pc)
	}
	if haveMap {
		return json.Marshal(pm)
	}
	if haveEnum {
		return json.Marshal(pe)
	}
	if nullable {
		return json.Marshal(nil)
	}
	return nil, errors.New("Union must not be null")
}
