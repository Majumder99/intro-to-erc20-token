//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract SouravToken is ERC20Capped, ERC20Burnable{
    address payable public owner;
    //erc20(nameofthetoken, tickersymbol)
    constructor(uint256 cap) ERC20("Sourav", "SM") ERC20Capped(cap * (10 ** decimals())){
        owner = msg.sender;
        // initial supply to myself
        // 1 token = 1 + 18 zeros 000000000000000000
        //initial supply will be 70 million 
        //capped will be 100 million
        // because solidity doesn't support float arithemetic 
        _mint(owner, 70000000 * (10 ** decimals()));
    }
}