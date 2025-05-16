
# 🔁 SwapTokensApp - Secure Token Swaps Using Uniswap V2 Router

## 📌 Description
**SwapTokensApp** is a Solidity smart contract that enables users to swap ERC-20 tokens via a multi-hop route using a compatible DEX router (like Uniswap V2 or similar). The contract interacts with a specified router and uses the SafeERC20 library from OpenZeppelin for secure token handling.

The contract is built with **Solidity 0.8.28**, follows best practices, and is fully tested using **Foundry**.

---

## 🚀 Features

| **Feature** | **Description** |
|-------------|-----------------|
| 🔄 **Token Swaps** | Swap tokens through a customizable path of any length. |
| 🛡️ **Safe Transfers** | Uses `SafeERC20` from OpenZeppelin to securely transfer and approve tokens. |
| 🧩 **Composable** | Integrates easily with other DeFi protocols or user interfaces. |
| 🧪 **Foundry Tests** | Thoroughly tested with unit tests using real user addresses and token contracts on Arbitrum. |
| 📝 **Event Emission** | Emits a `SwapTokens` event with details of every successful swap. |

---

## 📜 Contract Details

### ⚙️ Constructor

```solidity
constructor(address RouterV2Address_)
```

Sets the router address to be used for token swaps.

### 🔧 Functions

| **Function** | **Description** |
|--------------|------------------|
| `swapTokens(uint256 amountIn_, uint256 amountOutMin_, address[] memory path_, uint256 deadline_)` | Transfers tokens from the user, approves the router, and performs a swap along the given path. |

### 📡 Events

| **Event** | **Description** |
|-----------|-----------------|
| `SwapTokens(address tokenIn, address tokenOut, uint256 amountIn, uint256 amountOut)` | Emitted after a successful swap. |

---

## 🧪 Testing with Foundry

All core functionality has been tested with real addresses and tokens on **Arbitrum One**.

### ✅ Implemented Tests

| **Test** | **Description** |
|----------|------------------|
| `testInitialDeploy` | Verifies correct initialization of the router address. |
| `testSwapTokensShortPath` | Swaps tokens directly between two tokens (e.g., USDC → USDT). |
| `testSwapTokensLongPath` | Swaps tokens through a longer path (e.g., USDT → USDC → WBTC). |


### 📊 Coverage Report

| File                    | % Lines         | % Statements     | % Branches      | % Functions     |
|-------------------------|------------------|-------------------|------------------|------------------|
| `src/SwapTokensApp.sol` | 100.00% (8/8) | 100.00% (6/6) | 100.00% (0/0) | 100.00% (2/2)   |

---

## 🔗 Dependencies

- [OpenZeppelin Contracts](https://github.com/OpenZeppelin/openzeppelin-contracts)
- [Foundry](https://book.getfoundry.sh/)
- [Uniswap V2 Compatible Router Interface](https://github.com/aflores255/SwapTokensApp/blob/master/src/interfaces/IRouterV2.sol)

---

## 🛠️ How to Use

### 🔧 Prerequisites

- Foundry installed (`forge install`)
- Access to the Arbitrum One network (or compatible)
- ETH and supported tokens (e.g., USDT, USDC, WBTC)

### 🧪 Run Tests

```bash
forge test
```

### 🚀 Deployment

1. Clone the repo:
    ```bash
    git clone https://github.com/aflores255/SwapTokensApp.git
    cd SwapTokensApp
    ```
2. Deploy using Foundry, Hardhat, or any preferred tool, passing the router address as constructor parameter.

---

## 📄 License

This project is licensed under the **MIT License**.
