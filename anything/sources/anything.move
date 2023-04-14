module anything::anything {

    use std::ascii::{Self, String};
    use sui::object::{Self, UID};
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};

    struct Product has key, store {
        id: UID,
        title: String,
        subtitle: String, 
        description: String,
        thumbnail: String,
        handle: String, //slug
        status: String,
        // vendor: address,
    }

   fun new(
    title: vector<u8>,
    subtitle: vector<u8>,
    description: vector<u8>,
    thumbnail: vector<u8>,
    handle: vector<u8>, 
      ctx: &mut TxContext
      ): Product {
        Product {
            id: object::new(ctx),
            title: ascii::string(title),
            subtitle: ascii::string(subtitle),
            description: ascii::string(description),
            thumbnail: ascii::string(thumbnail),
            handle: ascii::string(handle),
            status: ascii::string(b"draft"),
            // vendor: tx_context::sender(ctx), 
            }
    }

    public fun get_product(self: &Product): (String, String, String, String, String, String) {
        (self.title, self.subtitle, self.description, self.thumbnail, self.handle, self.status)
    }

    public entry fun create(
        title: vector<u8>,
        subtitle: vector<u8>,
        description: vector<u8>,
        thumbnail: vector<u8>,
        handle: vector<u8>,
      ctx: &mut TxContext) {
        let product = new(title, subtitle, description, thumbnail, handle, ctx);
        transfer::transfer(product, tx_context::sender(ctx))
    }
}

//TODO: make it so that vendor can be sent by someone else ie erc712 in eth
//TODO: seperate product and listing

#[test_only]
module anything::anything_tests {

    use sui::test_scenario;
    use anything::anything::{Self, Product};
    use sui::object;
    use sui::tx_context;
    use std::ascii::{Self, String};

      #[test]
    fun test_create() {
    let owner = @0x1;
    // Create a Product and transfer it to @owner.
    let scenario_val = test_scenario::begin(owner);
    let scenario = &mut scenario_val;
    {
        let ctx = test_scenario::ctx(scenario);
        anything::create(
        b"Wow Butter",
        b"Butter that makes you go wow",
        b"Weed butter from pasture raised cows will be your best baking companion",
        b"https://leafly-cms-production.imgix.net/wp-content/uploads/2014/03/29200228/recipe-how-to-make-basic-cannabutter.jpg?auto=format,compress&w=1100",
        b"wow-butter",
        ctx);
    };

    // Check that @not_owner does not own the just-created ColorObject.
    let not_owner = @0x2;
    test_scenario::next_tx(scenario, not_owner);
    {
        assert!(!test_scenario::has_most_recent_for_sender<Product>(scenario), 0);
    };
    // Check that @owner indeed owns the just-created ColorObject.
    // Also checks the value fields of the object.
    test_scenario::next_tx(scenario, owner);
    {
        let object = test_scenario::take_from_sender<Product>(scenario);
        
        let (
        title,
        subtitle, 
        description,
        thumbnail,
        handle, 
        status,
        // vendor
        ) = anything::get_product(&object);

        assert!(title == ascii::string(b"Wow Butter") && 
        subtitle == ascii::string(b"Butter that makes you go wow") &&
        description == ascii::string(b"Weed butter from pasture raised cows will be your best baking companion") &&
        thumbnail == ascii::string(b"https://leafly-cms-production.imgix.net/wp-content/uploads/2014/03/29200228/recipe-how-to-make-basic-cannabutter.jpg?auto=format,compress&w=1100")
        , 0);
        // 
       
        // description == b"Weed butter from pasture raised cows will be your best baking companion" &&
        // thumbnail == b"https://leafly-cms-production.imgix.net/wp-content/uploads/2014/03/29200228/recipe-how-to-make-basic-cannabutter.jpg?auto=format,compress&w=1100" &&
        // handle == b"wow-butter" &&
        // status == b"draft" &&
        // vendor == owner
       

    test_scenario::return_to_sender(scenario, object);
    };
    test_scenario::end(scenario_val);
    }
}

//   text: vector<u8>,
        // ref_id: Option<address>,
        // metadata: vector<u8>,