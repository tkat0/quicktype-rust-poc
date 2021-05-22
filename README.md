# quicktype-rust-poc

A PoC that generates client implementation to handle JSON with Rust and quicktype

You can try following procedure with:

```bash
yarn install
yarn build
```

1. Implement JSON schema with Rust using:
    - [Serde JSON](https://crates.io/crates/serde_json)
    - [Schemars](https://crates.io/crates/schemars)
    - See [main.rs](./main.rs)
2. Generate JSON schema with `cargo build`
    - See [generated/schema.json](./generated/schema.json)
3. Generate client implementations with [quicktype](https://github.com/quicktype/quicktype)
    - Generate Go, Java, Python, Swift and Rust clients
        - See [generated](./generated) directory
    - Use JavaScript API of quicktype
        - See [index.ts](./index.ts)

