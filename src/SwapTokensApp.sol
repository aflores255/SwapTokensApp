//1. License
//SPDX-License-Identifier: MIT

//2. Solidity
pragma solidity 0.8.28;

import "./interfaces/IRouterV2.sol";
import "../lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import "../lib/openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol";

//3. Contract

contract SwapTokensApp {
    using SafeERC20 for IERC20;

    //Variables
    address public RouterV2Address;
    //Events

    event SwapTokens(address tokenIn, address tokenOut, uint256 amountIn, uint256 amountOut);

    /**
     * @notice Contract constructor
     * @param RouterV2Address_ Address of the DEX router to be used for swaps
     */
    constructor(address RouterV2Address_) {
        RouterV2Address = RouterV2Address_;
    }

    /**
     * @notice Swaps tokens via the configured DEX router using a provided path
     * @param amountIn_ Amount of input tokens to be swapped
     * @param amountOutMin_ Minimum acceptable amount of output tokens (slippage protection)
     * @param path_ Array of token addresses representing the swap path
     * @param deadline_ Unix timestamp after which the transaction will revert
     */
    function swapTokens(uint256 amountIn_, uint256 amountOutMin_, address[] memory path_, uint256 deadline_) external {
        //Get first Token
        IERC20(path_[0]).safeTransferFrom(msg.sender, address(this), amountIn_);
        //Approve
        IERC20(path_[0]).approve(RouterV2Address, amountIn_);
        //Swap
        uint256[] memory amountsOut_ =
            IRouterV2(RouterV2Address).swapExactTokensForTokens(amountIn_, amountOutMin_, path_, msg.sender, deadline_);

        emit SwapTokens(path_[0], path_[path_.length - 1], amountIn_, amountsOut_[amountsOut_.length - 1]);
    }
}
