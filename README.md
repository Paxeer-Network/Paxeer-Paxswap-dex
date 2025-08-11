# 🌊 PaxSwap - Decentralized Exchange Protocol

[![Solidity](https://img.shields.io/badge/Solidity-^0.8.30-blue.svg)](https://soliditylang.org/)
[![Network](https://img.shields.io/badge/Network-Paxeer-green.svg)](https://paxeer.app)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

PaxSwap is a comprehensive decentralized exchange (DEX) protocol built for the Paxeer Network. It provides automated market making (AMM), liquidity provision, yield farming, and token swapping capabilities.

**Note**: The Paxeer Network uses PAX as its native gas token (not ETH). All transaction fees are paid in PAX.

## ✨ Features

- **Multi-Pool Creation**: Create trading pairs for any ERC20 tokens
- **Automated Market Making**: Constant product formula (x * y = k) for efficient trading
- **Liquidity Provision**: Add/remove liquidity and earn trading fees
- **Token Swapping**: Swap between any tokens with optimal routing
- **Yield Farming**: Stake LP tokens to earn DEW rewards
- **Native ETH Support**: Seamless ETH/WETH integration
- **Fee Collection**: Protocol fees for sustainable development

## 🏗️ Architecture

### Core Contracts

1. **DewSwapFactory** (`DewSwapFactory.sol`) - Creates and manages trading pairs
2. **DewSwapPair** (`DewSwapPair.sol`) - Individual AMM pools for token pairs
3. **DewSwapRouter** (`DewSwapRouter.sol`) - Handles swaps and liquidity operations
4. **DewFarm** (`DewFarm.sol`) - Yield farming and staking rewards
5. **DewToken** (`DewToken.sol`) - Native protocol token (DEW)

### Libraries

- **DewSwapLibrary** (`libraries/DewSwapLibrary.sol`) - Mathematical functions and utilities
- **UQ112x112** (`libraries/UQ112x112.sol`) - Fixed-point arithmetic for price calculations

## 📋 Deployed Contracts (Paxeer Network)

| Contract | Address | Purpose |
|----------|---------|---------|
| **DewToken** | `0xE3f28b9832e785120ffE444d47BC5f2a824EA766` | Native DEX token |
| **DewSwapFactory** | `0xf10f49fFa851042ea2e081b270650E75E90f77A3` | Pair creation |
| **DewSwapRouter** | `0x7C6354B4a49aA2E20e025ea4C9387aC66e6e6a33` | Trading interface |
| **DewFarm** | `0xc84D3Bf79eecC0404f30f4BA1903583C7AAdBDb9` | Yield farming |
| **DEW/WETH Pair** | `0x535b87Ac04593De9a6c0BB7441A876d68bd9D6A0` | Main trading pair |

### Network Configuration
- **Network**: Paxeer Network
- **Chain ID**: 80000
- **RPC URL**: `https://rpc-paxeer-network-djjz47ii4b.t.conduit.xyz/DgdWRnqiV7UGiMR2s9JPMqto415SW9tNG`
- **Explorer**: https://paxscan.paxeer.app:443
- **WETH**: `0xD0C1a714c46c364DBDd4E0F7b0B6bA5354460dA7`

## 🚀 Quick Start

### Prerequisites

- Node.js 16+
- Hardhat
- Paxeer Network RPC access

### Installation

```bash
npm install
```

### Compilation

```bash
npx hardhat compile
```

### Testing

```bash
npx hardhat test
```

### Deployment Scripts

1. **Deploy all contracts**:
```bash
npx hardhat run scripts/deploy.js --network paxeer-network
```

2. **Add initial liquidity**:
```bash
npx hardhat run scripts/addLiquidity.js --network paxeer-network
```

3. **Setup farming pools**:
```bash
npx hardhat run scripts/setupFarm.js --network paxeer-network
```

4. **Create trading pairs**:
```bash
npx hardhat run scripts/createTradingPairs.js --network paxeer-network
```

## 📊 Usage Examples

### Creating a Trading Pair

```javascript
// Create a new trading pair
await factory.createPair(tokenA.address, tokenB.address);
const pairAddress = await factory.getPair(tokenA.address, tokenB.address);
```

### Adding Liquidity

```javascript
// Add liquidity to a pair
await router.addLiquidity(
  tokenA.address,
  tokenB.address,
  amountA,
  amountB,
  amountAMin,
  amountBMin,
  to,
  deadline
);
```

### Swapping Tokens

```javascript
// Swap exact tokens for tokens
await router.swapExactTokensForTokens(
  amountIn,
  amountOutMin,
  [tokenA.address, tokenB.address],
  to,
  deadline
);
```

### Yield Farming

```javascript
// Stake LP tokens in farm
await lpToken.approve(farm.address, amount);
await farm.deposit(poolId, amount);

// Claim rewards
await farm.deposit(poolId, 0); // Deposit 0 to claim

// Withdraw LP tokens
await farm.withdraw(poolId, amount);
```

## 💰 Tokenomics

### DEW Token

- **Total Supply**: 1,000,000 DEW
- **Decimals**: 18
- **Use Cases**:
  - Yield farming rewards
  - Governance (future implementation)
  - Fee discounts
  - Liquidity mining incentives

### Fee Structure

- **Trading Fee**: 0.3% per swap
  - 0.25% to liquidity providers
  - 0.05% to protocol (if enabled)

## 🔧 Key Functions

### Factory Functions

- `createPair(tokenA, tokenB)` - Create new trading pair
- `getPair(tokenA, tokenB)` - Get pair address
- `allPairs(index)` - Get pair by index
- `allPairsLength()` - Total number of pairs

### Router Functions

- `addLiquidity()` - Add liquidity to pair
- `removeLiquidity()` - Remove liquidity from pair
- `swapExactTokensForTokens()` - Swap with exact input
- `swapTokensForExactTokens()` - Swap with exact output
- `getAmountsOut()` - Calculate swap output amounts
- `getAmountsIn()` - Calculate required input amounts

### Farm Functions

- `add(allocPoint, lpToken)` - Add new farming pool
- `deposit(pid, amount)` - Stake LP tokens
- `withdraw(pid, amount)` - Unstake LP tokens
- `pendingDew(pid, user)` - View pending rewards

## 🔗 Integration

### Frontend Integration

```javascript
// Connect to contracts
const factory = new ethers.Contract(factoryAddress, factoryABI, provider);
const router = new ethers.Contract(routerAddress, routerABI, provider);

// Get pair info
const pairAddress = await factory.getPair(tokenA, tokenB);
const pair = new ethers.Contract(pairAddress, pairABI, provider);
const reserves = await pair.getReserves();

// Calculate swap amounts
const amountsOut = await router.getAmountsOut(amountIn, [tokenA, tokenB]);
```

### Price Calculation

```javascript
// Get token price from reserves
function getPrice(reserve0, reserve1, decimals0, decimals1) {
  const price = (reserve1 * (10 ** decimals0)) / (reserve0 * (10 ** decimals1));
  return price;
}
```

## 🛡️ Security Features

- **Reentrancy Protection**: Lock mechanism in critical functions
- **Overflow Protection**: SafeMath library usage
- **Access Control**: Owner-only functions for admin operations
- **Slippage Protection**: Minimum amount guarantees
- **Deadline Protection**: Time-bound transactions

## 🧪 Testing

The protocol includes comprehensive tests covering:

- Factory pair creation
- Router liquidity operations
- Token swapping functionality
- Yield farming mechanics
- Edge cases and error conditions

Run tests with:
```bash
npx hardhat test
```

## 📁 Project Structure

```
dewswap-dex/
├── contracts/
│   ├── DewSwapFactory.sol
│   ├── DewSwapPair.sol
│   ├── DewSwapRouter.sol
│   ├── DewFarm.sol
│   ├── DewToken.sol
│   ├── interfaces/
│   │   ├── IDewSwapFactory.sol
│   │   ├── IDewSwapPair.sol
│   │   ├── IDewSwapRouter.sol
│   │   ├── IERC20.sol
│   │   └── IWETH.sol
│   └── libraries/
│       ├── DewSwapLibrary.sol
│       └── UQ112x112.sol
├── scripts/
│   ├── deploy.js
│   ├── addLiquidity.js
│   ├── setupFarm.js
│   ├── testSwaps.js
│   └── createTradingPairs.js
├── test/
│   └── DewSwap.test.js
├── deployments.json
└── README.md
```

## ⚠️ Important Notes

1. **Testnet First**: Always test on testnet before mainnet deployment
2. **Slippage**: Set appropriate slippage tolerance for transactions
3. **Deadlines**: Use reasonable deadlines for time-sensitive operations
4. **Approvals**: Check token approvals before transactions
5. **Gas Optimization**: Consider gas costs for complex operations

## 🔄 Upgrade Path

The protocol is designed with upgradability in mind:

1. Factory can be upgraded to support new pair types
2. Router can be upgraded for better routing algorithms
3. Farm can be upgraded with new reward mechanisms
4. Additional utility contracts can be added

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

---

**Built with ❤️ for the Paxeer Network ecosystem**
