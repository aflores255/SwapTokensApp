//1. License
//SPDX-License-Identifier: MIT

//2. Solidity
pragma solidity 0.8.28;

//3. Interface
interface IRouterV2 {
    /**
     * @notice Swaps an exact amount of input tokens for as many output tokens as possible
     * @param amountIn The amount of input tokens to send
     * @param amountOutMin The minimum amount of output tokens expected (slippage protection)
     * @param path Array of token addresses representing the swap path
     * @param to Recipient address for the output tokens
     * @param deadline Unix timestamp after which the transaction will revert
     * @return amounts The list of token amounts at each step of the swap
     */
    function swapExactTokensForTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);
}
