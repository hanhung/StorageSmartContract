pragma solidity ^0.4.17;

contract Storage {
    struct Bid {
        uint price;
        address provider;
        string ipfs_id;
        bool approval;
    }

    Bid[] public bids;
    address public manager;
    uint public priceCap;

    constructor(uint cap) public payable {
        manager = msg.sender;
        priceCap = cap;
    }

    function createBid(uint price, string ipfs_id) public {
        require(price <= priceCap);

        Bid memory newBid = Bid({
           price: price,
           provider: msg.sender,
           ipfs_id: ipfs_id,
           approval: false
        });

        bids.push(newBid);
    }

    function approveBid(uint id) public {
        Bid storage bid = bids[id];
        require(manager == msg.sender);
        require(address(this).balance >= bid.price);

        bid.provider.transfer(bid.price);
        bid.approval = true;
    }

    function getIpfsId(uint id) public view returns(string) {
        return bids[id].ipfs_id;
    }

    function getBid(uint id) public view returns(uint, address, string, bool) {
        Bid memory bid = bids[id];
        return (bid.price, bid.provider, bid.ipfs_id, bid.approval);
    }

    function getBidSize() public view returns(uint) {
        return bids.length;
    }
}
