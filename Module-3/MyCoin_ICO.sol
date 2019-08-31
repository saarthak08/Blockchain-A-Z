//MyCoin_ICO

//Version of compiler
pragma solidity^0.5.10;

contract MyCoin_ICO{

    //Introducing the maximum number of MyCoins available for sale
    uint public max_mycoin=1000000;

    //Introducing the USD to MyCoin conversion rate
    uint public usd_to_mycoin=1000;

    //Introducing the total number of mycoins that have been bought by the investors
    uint public total_mycoins_bought=0;

    //Mapping from the investor address to its equity in the MyCoins & USD
    mapping (address => uint) equity_mycoins;
    mapping (address => uint) equity_USD;

    //Checking if any investor can buy MyCoins
    modifier can_buy_myCoins(uint usd_invested){
        require((usd_invested*1000)+total_mycoins_bought<=max_mycoin,"Error! No more MyCoins available");
        _;
    }


    //Getting the equity in MyCoins of investor
    function equity_in_MyCoins(address investor) external view returns(uint){
        return equity_mycoins[investor];
    }

      //Getting the equity in USD of investor
    function equity_in_USD(address investor) external view returns(uint){
        return equity_USD[investor];
    }


    //Buying MyCoins
    function buy_mycoins(address investor, uint usd_invested) external can_buy_myCoins(usd_invested){
        uint mycoins_bought = usd_invested * 1000;
        equity_mycoins[investor] += mycoins_bought;
        equity_USD[investor] = equity_mycoins[investor]/1000;
        total_mycoins_bought += mycoins_bought;
    }

    //Selling MyCoins
    function sell_mycoins(address investor, uint mycoins_sold) external {
        equity_mycoins[investor] -= mycoins_sold;
        equity_USD[investor] = equity_mycoins[investor]/1000;
        total_mycoins_bought -= mycoins_sold;
    }
}