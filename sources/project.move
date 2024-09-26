module LostFound::Registry {

    use aptos_framework::coin::{transfer, Coin};
    use aptos_framework::aptos_coin::AptosCoin;
    use aptos_framework::signer;
    use aptos_framework::aptos_account;

    struct FoundItem has store, key {
        finder: address,
        description: vector<u8>,
        reward: u64, // Optional reward in AptosCoin
    }

    // Function to register a found item
    public fun register_item(account: &signer, description: vector<u8>, reward: u64) {
        let finder = signer::address_of(account);
        let item = FoundItem {
            finder,
            description,
            reward,
        };
        move_to(account, item);
    }

    // Function for the owner to claim the found item and pay the reward to the finder
    public fun claim_item(account: &signer, finder: address, reward: u64) {
        // Transfer the reward to the finder
        transfer<AptosCoin>(account, finder, reward);
    }
}
