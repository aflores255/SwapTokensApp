//1. License
//SPDX-License-Identifier: MIT

//2. Solidity
pragma solidity 0.8.28;

import "forge-std/Test.sol";
import "../src/SwapTokensApp.sol";

//3. Contract

contract SwapTokensAppTest is Test{


    SwapTokensApp swapTokensApp;
    address routerAddress = 0x4752ba5DBc23f44D87826276BF6Fd6b1C372aD24; // Arbitrum one
    address user1 = 0x3931dAb967C3E2dbb492FE12460a66d0fe4cC857; // Holder USDC
    address user2 = 0x52Aa899454998Be5b000Ad077a46Bbe360F4e497; //Holder USDT
    address USDC = 0xaf88d065e77c8cC2239327C5EDb3A432268e5831; // USDC Address in Arbitrum One Mainnet
    address USDT = 0xFd086bC7CD5C481DCC9C85ebE478A1C0b69FCbb9; // USDT Address in Arbitrum One Mainnet
    address WBTC = 0x2f2a2543B76A4166549F7aaB2e75Bef0aefC5B0f; //WBTC Address in Arbitrum One Mainnet

    function setUp() public{


        swapTokensApp = new SwapTokensApp(routerAddress);

    }

    function testInitialDeploy() public view{

        assert(swapTokensApp.RouterV2Address() == routerAddress);

    }

    function testSwapTokensShortPath() public{
        uint256 amountIn_ = 10 * 1e6;
        uint256 amountOutMin_ = 9 * 1e6;
        uint256 deadline_ = 1744303346 + 6000;
        address[] memory path_ = new address[](2);
        path_[0] = USDC;
        path_[1] = USDT;

        vm.startPrank(user1);
        uint256 userToken1BalanceBefore = IERC20(USDC).balanceOf(user1);
        uint256 userToken2BalanceBefore = IERC20(USDT).balanceOf(user1);

        IERC20(USDC).approve(address(swapTokensApp), amountIn_);
        swapTokensApp.swapTokens(amountIn_, amountOutMin_, path_, deadline_);

        uint256 userToken1BalanceAfter = IERC20(USDC).balanceOf(user1);
        uint256 userToken2BalanceAfter = IERC20(USDT).balanceOf(user1);

        assert(userToken1BalanceAfter == userToken1BalanceBefore - amountIn_);
        assert(userToken2BalanceBefore < userToken2BalanceAfter && (userToken2BalanceAfter-userToken2BalanceBefore >= amountOutMin_));

        vm.stopPrank();
       


    }

     function testSwapTokensLongPath() public{
        
        uint256 amountIn_ = 10 * 1e6;
        uint256 amountOutMin_ = 0.00001 * 1e8;
        uint256 deadline_ = 1744303346 + 6000;
        address[] memory path_ = new address[](3);

        path_[0] = USDT;
        path_[1] = USDC;
        path_[2] = WBTC;

        vm.startPrank(user2);
        uint256 userToken1BalanceBefore = IERC20(USDT).balanceOf(user2);
        uint256 userToken2BalanceBefore = IERC20(WBTC).balanceOf(user2);
 
        IERC20(USDT).approve(address(swapTokensApp), amountIn_);
        swapTokensApp.swapTokens(amountIn_, amountOutMin_, path_, deadline_);

        uint256 userToken1BalanceAfter = IERC20(USDT).balanceOf(user2);
        uint256 userToken2BalanceAfter = IERC20(WBTC).balanceOf(user2);
        
        assert(userToken1BalanceAfter == userToken1BalanceBefore - amountIn_);
        assert(userToken2BalanceBefore < userToken2BalanceAfter && (userToken2BalanceAfter-userToken2BalanceBefore >= amountOutMin_));

        vm.stopPrank();
       


    }



}