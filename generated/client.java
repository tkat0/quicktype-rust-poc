// Converter.java

// To use this code, add the following Maven dependency to your project:
//
//
//     com.fasterxml.jackson.core     : jackson-databind          : 2.9.0
//     com.fasterxml.jackson.datatype : jackson-datatype-jsr310   : 2.9.0
//
// Import this package:
//
//     import client.Converter;
//
// Then you can deserialize a JSON string with
//
//     Record data = Converter.fromJsonString(jsonString);

package client;

import java.io.IOException;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.module.SimpleModule;
import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.core.JsonProcessingException;
import java.util.*;
import java.time.LocalDate;
import java.time.OffsetDateTime;
import java.time.OffsetTime;
import java.time.ZoneOffset;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeFormatterBuilder;
import java.time.temporal.ChronoField;

public class Converter {
    // Date-time helpers

    private static final DateTimeFormatter DATE_TIME_FORMATTER = new DateTimeFormatterBuilder()
            .appendOptional(DateTimeFormatter.ISO_DATE_TIME)
            .appendOptional(DateTimeFormatter.ISO_OFFSET_DATE_TIME)
            .appendOptional(DateTimeFormatter.ISO_INSTANT)
            .appendOptional(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.SX"))
            .appendOptional(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ssX"))
            .appendOptional(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"))
            .toFormatter()
            .withZone(ZoneOffset.UTC);

    public static OffsetDateTime parseDateTimeString(String str) {
        return ZonedDateTime.from(Converter.DATE_TIME_FORMATTER.parse(str)).toOffsetDateTime();
    }

    private static final DateTimeFormatter TIME_FORMATTER = new DateTimeFormatterBuilder()
            .appendOptional(DateTimeFormatter.ISO_TIME)
            .appendOptional(DateTimeFormatter.ISO_OFFSET_TIME)
            .parseDefaulting(ChronoField.YEAR, 2020)
            .parseDefaulting(ChronoField.MONTH_OF_YEAR, 1)
            .parseDefaulting(ChronoField.DAY_OF_MONTH, 1)
            .toFormatter()
            .withZone(ZoneOffset.UTC);

    public static OffsetTime parseTimeString(String str) {
        return ZonedDateTime.from(Converter.TIME_FORMATTER.parse(str)).toOffsetDateTime().toOffsetTime();
    }
    // Serialize/deserialize helpers

    public static Record fromJsonString(String json) throws IOException {
        return getObjectReader().readValue(json);
    }

    public static String toJsonString(Record obj) throws JsonProcessingException {
        return getObjectWriter().writeValueAsString(obj);
    }

    private static ObjectReader reader;
    private static ObjectWriter writer;

    private static void instantiateMapper() {
        ObjectMapper mapper = new ObjectMapper();
        mapper.findAndRegisterModules();
        mapper.configure(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS, false);
        SimpleModule module = new SimpleModule();
        module.addDeserializer(OffsetDateTime.class, new JsonDeserializer<OffsetDateTime>() {
            @Override
            public OffsetDateTime deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
                String value = jsonParser.getText();
                return Converter.parseDateTimeString(value);
            }
        });
        mapper.registerModule(module);
        reader = mapper.readerFor(Record.class);
        writer = mapper.writerFor(Record.class);
    }

    private static ObjectReader getObjectReader() {
        if (reader == null) instantiateMapper();
        return reader;
    }

    private static ObjectWriter getObjectWriter() {
        if (writer == null) instantiateMapper();
        return writer;
    }
}

// Record.java

package client;

import com.fasterxml.jackson.annotation.*;

public class Record {
    private Data data;
    private String id;
    private KindA kindA;
    private KindB kindB;
    private KindC kindC;

    @JsonProperty("data")
    public Data getData() { return data; }
    @JsonProperty("data")
    public void setData(Data value) { this.data = value; }

    @JsonProperty("id")
    public String getID() { return id; }
    @JsonProperty("id")
    public void setID(String value) { this.id = value; }

    @JsonProperty("kind_a")
    public KindA getKindA() { return kindA; }
    @JsonProperty("kind_a")
    public void setKindA(KindA value) { this.kindA = value; }

    @JsonProperty("kind_b")
    public KindB getKindB() { return kindB; }
    @JsonProperty("kind_b")
    public void setKindB(KindB value) { this.kindB = value; }

    @JsonProperty("kind_c")
    public KindC getKindC() { return kindC; }
    @JsonProperty("kind_c")
    public void setKindC(KindC value) { this.kindC = value; }
}

// Data.java

package client;

import com.fasterxml.jackson.annotation.*;

public class Data {
    private long[] rawData;

    @JsonProperty("raw_data")
    public long[] getRawData() { return rawData; }
    @JsonProperty("raw_data")
    public void setRawData(long[] value) { this.rawData = value; }
}

// KindA.java

package client;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;

/**
 * See [Enum representations · Serde](https://serde.rs/enum-representations.html) for
 * details.
 */
@JsonDeserialize(using = KindA.Deserializer.class)
@JsonSerialize(using = KindA.Serializer.class)
public class KindA {
    public KindAClass kindAClassValue;
    public KindAEnum enumValue;

    static class Deserializer extends JsonDeserializer<KindA> {
        @Override
        public KindA deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            KindA value = new KindA();
            switch (jsonParser.currentToken()) {
                case VALUE_STRING:
                    String string = jsonParser.readValueAs(String.class);
                    try {
                        value.enumValue = KindAEnum.forValue(string);
                    } catch (Exception ex) {
                        // Ignored
                    }
                    break;
                case START_OBJECT:
                    value.kindAClassValue = jsonParser.readValueAs(KindAClass.class);
                    break;
                default: throw new IOException("Cannot deserialize KindA");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<KindA> {
        @Override
        public void serialize(KindA obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.kindAClassValue != null) {
                jsonGenerator.writeObject(obj.kindAClassValue);
                return;
            }
            if (obj.enumValue != null) {
                jsonGenerator.writeObject(obj.enumValue);
                return;
            }
            throw new IOException("KindA must not be null");
        }
    }
}

// KindAClass.java

package client;

import com.fasterxml.jackson.annotation.*;

public class KindAClass {
    private A a;
    private C c;

    @JsonProperty("A")
    public A getA() { return a; }
    @JsonProperty("A")
    public void setA(A value) { this.a = value; }

    @JsonProperty("C")
    public C getC() { return c; }
    @JsonProperty("C")
    public void setC(C value) { this.c = value; }
}

// A.java

package client;

import com.fasterxml.jackson.annotation.*;

public class A {
    private String description;
    private long value;

    @JsonProperty("description")
    public String getDescription() { return description; }
    @JsonProperty("description")
    public void setDescription(String value) { this.description = value; }

    @JsonProperty("value")
    public long getValue() { return value; }
    @JsonProperty("value")
    public void setValue(long value) { this.value = value; }
}

// C.java

package client;

import com.fasterxml.jackson.annotation.*;

public class C {
    private String id;

    @JsonProperty("id")
    public String getID() { return id; }
    @JsonProperty("id")
    public void setID(String value) { this.id = value; }
}

// KindAEnum.java

package client;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum KindAEnum {
    B, D;

    @JsonValue
    public String toValue() {
        switch (this) {
            case B: return "B";
            case D: return "D";
        }
        return null;
    }

    @JsonCreator
    public static KindAEnum forValue(String value) throws IOException {
        if (value.equals("B")) return B;
        if (value.equals("D")) return D;
        throw new IOException("Cannot deserialize KindAEnum");
    }
}

// KindB.java

package client;

import com.fasterxml.jackson.annotation.*;

/**
 * If `#[serde(tag = "type")]` is set, all variants is merged as optional property.
 *
 * ```python @dataclass class Kind: type: TypeEnum description: Optional[str] = None value:
 * Optional[int] = None id: Optional[str] = None ```
 *
 * ```go type Kind struct { Description *string `json:"description,omitempty"` Type
 * Type    `json:"type"` Value       *int64  `json:"value,omitempty"` ID          *string
 * `json:"id,omitempty"` } ```
 *
 * ```swift struct Kind: Codable { let kindDescription: String? let type: TypeEnum let
 * value: Int? let id: String? ```
 */
public class KindB {
    private String description;
    private Type type;
    private Long value;
    private String id;

    @JsonProperty("description")
    public String getDescription() { return description; }
    @JsonProperty("description")
    public void setDescription(String value) { this.description = value; }

    @JsonProperty("type")
    public Type getType() { return type; }
    @JsonProperty("type")
    public void setType(Type value) { this.type = value; }

    @JsonProperty("value")
    public Long getValue() { return value; }
    @JsonProperty("value")
    public void setValue(Long value) { this.value = value; }

    @JsonProperty("id")
    public String getID() { return id; }
    @JsonProperty("id")
    public void setID(String value) { this.id = value; }
}

// Type.java

package client;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Type {
    A, B, C, D;

    @JsonValue
    public String toValue() {
        switch (this) {
            case A: return "A";
            case B: return "B";
            case C: return "C";
            case D: return "D";
        }
        return null;
    }

    @JsonCreator
    public static Type forValue(String value) throws IOException {
        if (value.equals("A")) return A;
        if (value.equals("B")) return B;
        if (value.equals("C")) return C;
        if (value.equals("D")) return D;
        throw new IOException("Cannot deserialize Type");
    }
}

// KindC.java

package client;

import com.fasterxml.jackson.annotation.*;

public class KindC {
    private Content content;
    private Type type;

    @JsonProperty("content")
    public Content getContent() { return content; }
    @JsonProperty("content")
    public void setContent(Content value) { this.content = value; }

    @JsonProperty("type")
    public Type getType() { return type; }
    @JsonProperty("type")
    public void setType(Type value) { this.type = value; }
}

// Content.java

package client;

import com.fasterxml.jackson.annotation.*;

public class Content {
    private String description;
    private Long value;
    private String id;

    @JsonProperty("description")
    public String getDescription() { return description; }
    @JsonProperty("description")
    public void setDescription(String value) { this.description = value; }

    @JsonProperty("value")
    public Long getValue() { return value; }
    @JsonProperty("value")
    public void setValue(Long value) { this.value = value; }

    @JsonProperty("id")
    public String getID() { return id; }
    @JsonProperty("id")
    public void setID(String value) { this.id = value; }
}
