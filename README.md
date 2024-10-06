# Getting Started 🚀

## About 
This project is a simple implementation of a POC for a Malicious SVG NFT, where the SVG is hosted fully on-chain. This SVG NFT downloads a file (or possibly a malicious file) when opened and is based on my other project https://github.com/Vagebondcur/SVG-Smuggler
---

## Quickstart
```
forge install
forge build
```

## Requirements
1. Git
2. Foundry 

## Usage
### Spin Up a Local Node
Start your local blockchain node to deploy contracts:
```
make anvil
```

### Deploy
With your local node up and running, deploy your contracts with:
```
make deploy
```

### Deployment to testnet or mainnet
Configure Environment Variables

To set up your environment, create a `.env` file with the following variables:

- `$PRIVATE_KEY`: This is your account's private key, which you can obtain from a wallet like [Metamask](https://metamask.io/). **Important:** Use a key that does not hold real funds for development purposes.

- `$SEPOLIA_RPC_URL`: The URL for the Sepolia testnet node you are using. You can acquire this from providers such as [Alchemy](https://www.alchemy.com/).

- **Optional:** Include `ETHERSCAN_API_KEY` if you wish to verify your contract on [Etherscan](https://etherscan.io/).



### Deploy SVG NFT
```
make deploy ARGS="--network sepolia"
make deploy ARGS="--network base-sepolia"
make deploy ARGS="--network base"
```

### Real World PoC
https://opensea.io/assets/base/0x5fa7f34b32be7d53396e9d07e2d2a7c59273946c/0

## Base-64
To get base64 of an image, run
```
echo "data:image/svg+xml;base64,$(base64 -i ./img/poc.svg)"
```
## Gas Estimation
You can estimate how much gas different things cost by running
```
forge snapshot
```
You'll see any output file called `.gas-snapshot`
