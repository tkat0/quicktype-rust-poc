import {
    InputData,
    jsonInputForTargetLanguage,
    JSONSchemaInput,
    FetchingJSONSchemaStore,
    quicktype,
    RendererOptions,
} from 'quicktype-core';
import * as fs from 'fs';

async function generate(
    targetLanguage: string,
    typeName: string,
    inputFilePath: string,
    outputFilePath: string,
    rendererOptions: RendererOptions
) {
    const jsonString = fs.readFileSync(inputFilePath).toString();

    const jsonInput = jsonInputForTargetLanguage(targetLanguage);
    const schemaInput = new JSONSchemaInput(new FetchingJSONSchemaStore());

    await schemaInput.addSource({
        name: typeName,
        schema: jsonString,
    });

    const inputData = new InputData();
    inputData.addInput(schemaInput);

    const { lines } = await quicktype({
        inputData,
        lang: targetLanguage,
        rendererOptions,
    });

    fs.writeFileSync(outputFilePath, lines.join('\n'));
}

async function main() {
    const typeName = 'Record';
    const inputFilePath = 'generated/schema.json';

    // https://github.com/quicktype/quicktype/issues/1399

    // https://github.com/quicktype/quicktype/blob/29f459dc95fe887d9e03cc19d65bc9908364b11a/src/quicktype-core/language/Swift.ts#L48
    generate('swift', typeName, inputFilePath, 'generated/client.swift', {
        'just-types': 'false',
        'struct-or-class': 'struct',
        protocol: 'none',
    });

    // https://github.com/quicktype/quicktype/blob/29f459dc95fe887d9e03cc19d65bc9908364b11a/src/quicktype-core/language/Python.ts#L107
    generate('python', typeName, inputFilePath, 'generated/client.py', {
        'just-types': 'false',
        'python-version': '3.7',
    });

    // https://github.com/quicktype/quicktype/blob/29f459dc95fe887d9e03cc19d65bc9908364b11a/src/quicktype-core/language/Golang.ts#L23
    generate('go', typeName, inputFilePath, 'generated/client.go', {
        'just-types': 'false',
        package: 'client',
    });

    // https://github.com/quicktype/quicktype/blob/29f459dc95fe887d9e03cc19d65bc9908364b11a/src/quicktype-core/language/Java.ts#L29
    generate('java', typeName, inputFilePath, 'generated/client.java', {
        package: 'client',
    });

    // https://github.com/quicktype/quicktype/blob/master/src/quicktype-core/language/Rust.ts#L39
    generate('rust', typeName, inputFilePath, 'generated/client.rs', {
        'derive-debug': 'true',
        'edition-2018': 'true',
    });
}

main();
