//SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract SouravToken is ERC20Capped, ERC20Burnable{
    address payable public owner;
    uint256 public blockReward;
    //erc20(nameofthetoken, tickersymbol)
    constructor(uint256 cap, uint256 reward) ERC20("Sourav", "SM") ERC20Capped(cap * (10 ** decimals())){
        owner = payable(msg.sender);
        // initial supply to myself
        // 1 token = 1 + 18 zeros 000000000000000000
        //initial supply will be 70 million 
        //capped will be 100 million
        // because solidity doesn't support float arithemetic 
        _mint(owner, 70000000 * (10 ** decimals()));
        blockReward  = reward;
    }

     function _mint(address account, uint256 amount) internal virtual override(ERC20Capped, ERC20) {
        require(ERC20.totalSupply() + amount <= cap(), "ERC20Capped: cap exceeded");
        super._mint(account, amount);
    }

    //we can't call this function from the outside of the contract
    function _mintMinerReward() internal{
        // here block.coinbase is the address of that node which node has been mined or verified the block
        _mint(block.coinbase, blockReward);
    }

    function _beforeTokenTransfer(address from, address to, uint256 value) internal virtual override{
       if(from != address(0) && to != block.coinbase && block.coinbase != address(0)){
        _mintMinerReward();
       }
       super._beforeTokenTransfer(from, to, value);
    }

    //setting the block reward again after some time 
    function setBlockReward(uint256 reward) public onlyOwner{
        blockReward = reward * (10 ** decimals());
    }
    
    function destroy() public onlyOwner{
        selfdestruct(owner);
    }

    modifier onlyOwner{
        require(msg.sender == owner, "Only the owner can set the reward value");
        _;
    }


} 