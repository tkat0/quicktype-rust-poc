# To use this code, make sure you
#
#     import json
#
# and then, to convert JSON from a string, do
#
#     result = record_from_dict(json.loads(json_string))

from dataclasses import dataclass
from typing import List, Any, Optional, Union, TypeVar, Callable, Type, cast
from enum import Enum


T = TypeVar("T")
EnumT = TypeVar("EnumT", bound=Enum)


def from_list(f: Callable[[Any], T], x: Any) -> List[T]:
    assert isinstance(x, list)
    return [f(y) for y in x]


def from_int(x: Any) -> int:
    assert isinstance(x, int) and not isinstance(x, bool)
    return x


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def from_none(x: Any) -> Any:
    assert x is None
    return x


def from_union(fs, x):
    for f in fs:
        try:
            return f(x)
        except:
            pass
    assert False


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


def to_enum(c: Type[EnumT], x: Any) -> EnumT:
    assert isinstance(x, c)
    return x.value


@dataclass
class Data:
    raw_data: List[int]

    @staticmethod
    def from_dict(obj: Any) -> 'Data':
        assert isinstance(obj, dict)
        raw_data = from_list(from_int, obj.get("raw_data"))
        return Data(raw_data)

    def to_dict(self) -> dict:
        result: dict = {}
        result["raw_data"] = from_list(from_int, self.raw_data)
        return result


@dataclass
class A:
    description: str
    value: int

    @staticmethod
    def from_dict(obj: Any) -> 'A':
        assert isinstance(obj, dict)
        description = from_str(obj.get("description"))
        value = from_int(obj.get("value"))
        return A(description, value)

    def to_dict(self) -> dict:
        result: dict = {}
        result["description"] = from_str(self.description)
        result["value"] = from_int(self.value)
        return result


@dataclass
class C:
    id: str

    @staticmethod
    def from_dict(obj: Any) -> 'C':
        assert isinstance(obj, dict)
        id = from_str(obj.get("id"))
        return C(id)

    def to_dict(self) -> dict:
        result: dict = {}
        result["id"] = from_str(self.id)
        return result


@dataclass
class KindAClass:
    a: Optional[A] = None
    c: Optional[C] = None

    @staticmethod
    def from_dict(obj: Any) -> 'KindAClass':
        assert isinstance(obj, dict)
        a = from_union([A.from_dict, from_none], obj.get("A"))
        c = from_union([C.from_dict, from_none], obj.get("C"))
        return KindAClass(a, c)

    def to_dict(self) -> dict:
        result: dict = {}
        result["A"] = from_union([lambda x: to_class(A, x), from_none], self.a)
        result["C"] = from_union([lambda x: to_class(C, x), from_none], self.c)
        return result


class KindAEnum(Enum):
    B = "B"
    D = "D"


class TypeEnum(Enum):
    A = "A"
    B = "B"
    C = "C"
    D = "D"


@dataclass
class KindB:
    """If `#[serde(tag = "type")]` is set, all variants is merged as optional property.
    
    ```python @dataclass class Kind: type: TypeEnum description: Optional[str] = None value:
    Optional[int] = None id: Optional[str] = None ```
    
    ```go type Kind struct { Description *string `json:"description,omitempty"` Type
    Type    `json:"type"` Value       *int64  `json:"value,omitempty"` ID          *string
    `json:"id,omitempty"` } ```
    
    ```swift struct Kind: Codable { let kindDescription: String? let type: TypeEnum let
    value: Int? let id: String? ```
    """
    type: TypeEnum
    description: Optional[str] = None
    value: Optional[int] = None
    id: Optional[str] = None

    @staticmethod
    def from_dict(obj: Any) -> 'KindB':
        assert isinstance(obj, dict)
        type = TypeEnum(obj.get("type"))
        description = from_union([from_str, from_none], obj.get("description"))
        value = from_union([from_int, from_none], obj.get("value"))
        id = from_union([from_str, from_none], obj.get("id"))
        return KindB(type, description, value, id)

    def to_dict(self) -> dict:
        result: dict = {}
        result["type"] = to_enum(TypeEnum, self.type)
        result["description"] = from_union([from_str, from_none], self.description)
        result["value"] = from_union([from_int, from_none], self.value)
        result["id"] = from_union([from_str, from_none], self.id)
        return result


@dataclass
class Content:
    description: Optional[str] = None
    value: Optional[int] = None
    id: Optional[str] = None

    @staticmethod
    def from_dict(obj: Any) -> 'Content':
        assert isinstance(obj, dict)
        description = from_union([from_str, from_none], obj.get("description"))
        value = from_union([from_int, from_none], obj.get("value"))
        id = from_union([from_str, from_none], obj.get("id"))
        return Content(description, value, id)

    def to_dict(self) -> dict:
        result: dict = {}
        result["description"] = from_union([from_str, from_none], self.description)
        result["value"] = from_union([from_int, from_none], self.value)
        result["id"] = from_union([from_str, from_none], self.id)
        return result


@dataclass
class KindC:
    type: TypeEnum
    content: Optional[Content] = None

    @staticmethod
    def from_dict(obj: Any) -> 'KindC':
        assert isinstance(obj, dict)
        type = TypeEnum(obj.get("type"))
        content = from_union([Content.from_dict, from_none], obj.get("content"))
        return KindC(type, content)

    def to_dict(self) -> dict:
        result: dict = {}
        result["type"] = to_enum(TypeEnum, self.type)
        result["content"] = from_union([lambda x: to_class(Content, x), from_none], self.content)
        return result


@dataclass
class Record:
    id: str
    kind_a: Union[KindAClass, KindAEnum]
    kind_b: KindB
    kind_c: KindC
    data: Optional[Data] = None

    @staticmethod
    def from_dict(obj: Any) -> 'Record':
        assert isinstance(obj, dict)
        id = from_str(obj.get("id"))
        kind_a = from_union([KindAClass.from_dict, KindAEnum], obj.get("kind_a"))
        kind_b = KindB.from_dict(obj.get("kind_b"))
        kind_c = KindC.from_dict(obj.get("kind_c"))
        data = from_union([Data.from_dict, from_none], obj.get("data"))
        return Record(id, kind_a, kind_b, kind_c, data)

    def to_dict(self) -> dict:
        result: dict = {}
        result["id"] = from_str(self.id)
        result["kind_a"] = from_union([lambda x: to_class(KindAClass, x), lambda x: to_enum(KindAEnum, x)], self.kind_a)
        result["kind_b"] = to_class(KindB, self.kind_b)
        result["kind_c"] = to_class(KindC, self.kind_c)
        result["data"] = from_union([lambda x: to_class(Data, x), from_none], self.data)
        return result


def record_from_dict(s: Any) -> Record:
    return Record.from_dict(s)


def record_to_dict(x: Record) -> Any:
    return to_class(Record, x)
