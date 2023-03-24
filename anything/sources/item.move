module anything::product_module {

    use std::ascii::{Self, String};
    use sui::object::{Self, UID};
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};

    //insipred by 
    //https://docs.medusajs.com/api/admin#tag/Product/operation/PostProducts

   struct Product has key, store {
    id: UID,
    title: String,
    subtitle: String,
    description: String,
    // is_giftcard: bool,
    // discountable: bool,
    // images: vector<String>,
    thumbnail: String,
    handle: String, //slug
    // status: String,
    type: ProductType,
    // collection_id: String,
    // tags: vector<Tag>,
    // sales_channels: vector<SalesChannel>,
    // categories: vector<Category>,
    // options: vector<Option>,
    // variants: vector<Variant>,
    weight: u64,
    length: u64,
    height: u64,
    width: u64,
    hs_code: String,
    origin_country: String,
    mid_code: String,
    // material: String,
    // metadata: map<String, Value>,
    // app-specific metadata. We do not enforce a metadata format and delegate this to app layer.
    // metadata: vector<u8>,
}

// struct ProductType {
//     id: String,
//     value: String,
// }

// struct Tag {
//     id: String,
//     value: String,
// }

// struct SalesChannel {
//     id: String,
// }

// struct Category {
//     id: String,
// }

// struct Option {
//     title: String,
// }

// struct Variant {
//     title: String,
//     sku: String,
//     ean: String,
//     upc: String,
//     barcode: String,
//     hs_code: String,
//     inventory_quantity: u64,
//     allow_backorder: bool,
//     manage_inventory: bool,
//     weight: u64,
//     length: u64,
//     height: u64,
//     width: u64,
//     origin_country: String,
//     mid_code: String,
//     material: String,
//     metadata: map<String, Value>,
//     prices: vector<Price>,
//     options: vector<Option>,
// }

// struct Price {
//     // Define fields for price
// }

// struct Value {
//     // Define fields for value
// }

}