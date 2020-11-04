# Project starNotary-Dapp

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

Node.js runtime environment is required.

### Installing

Install all required dependencies

```
$ npm install
```

Install truffle

```
$ npm install -g truffle
```

### Steps to run a local ethereum network, and deploy your token contract to this local network

1) Open a Terminal window, and make sure you are inside your project directory

2) Run the command `truffle develop` (to run a local ethereum network)

3) Use the command `compile` (to compile your solidity contract files)

4) Use the command `migrate --reset` (to deploy your contract to the locally running ethereum network)

5) Use the command `test` (to unit tests the contract)

6) For running the Front End of the DAPP, open another terminal window and go inside the project directory, and run:

```
cd app
npm run dev
```

### Optional - To deploy token contract on Rinkeby

Setup [Infura](https://infura.io/)

Copy project id and paste in truffle-config.js file

Add metamask seed in truffle-config.js file

```
truffle migrate --reset --network rinkeby
```

### Other information

Truffle version used:

```
v5.1.51
```

OpenZeppelin version used:

```
v3.2.0
```

ERC-721 Token Name:

```
JGStar
```

ERC-721 Token Symbol:

```
JGT
```

Contract Address:


0xc74182010971a6d30652fcfbccc947b7d0d45ce2
