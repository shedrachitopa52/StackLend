# StackLend Protocol 🏦

A decentralized lending protocol built on the Stacks blockchain that enables peer-to-peer lending using STX as collateral.

## 🌟 Features

- 🔒 **Secure Lending**: Fully collateralized loans backed by STX
- 💸 **P2P Transactions**: Direct lending between users
- ⚡ **Smart Contracts**: Built with secure Clarity language
- 📊 **Flexible Terms**: Customizable loan amounts, interest rates, and durations

## 🔧 Smart Contract Interface

### Loan Data Structure
```clarity
{
    borrower: principal,
    lender: (optional principal),
    amount: uint,
    collateral: uint,
    interest-rate: uint,
    due-block-height: uint,
    repaid: uint,
    status: string-ascii
}
```

### Core Functions

#### Request Loan
```clarity
(request-loan (loan-id uint) 
             (amount uint) 
             (collateral uint) 
             (interest-rate uint) 
             (due-block-height uint))
```

#### Fund Loan
```clarity
(fund-loan (loan-id uint))
```

## 🔄 Loan Status Flow

1. `requested` - Initial loan request created
2. `funded` - Loan funded by lender
3. `repaid` - Loan successfully repaid
4. `defaulted` - Loan defaulted after due date

## 🛠️ Development Setup

### Prerequisites

- [Clarinet](https://github.com/hirosystems/clarinet) - Clarity development tool
- [Stacks Wallet](https://www.hiro.so/wallet) - For testing transactions
- [Node.js](https://nodejs.org/) - v14 or higher

### Local Development

```bash
# Clone repository
git clone https://github.com/yourusername/stacklend.git

# Install Clarinet
curl --proto '=https' --tlsv1.2 -sSf https://install.clarinet.sh | sh

# Run tests
clarinet test

# Start local development chain
clarinet integrate
```


## 📋 Project Structure

```
StackLend/
├── contracts/
│   └── StackLend.clar
├── tests/
│   └── stacklend_test.ts
├── settings/
│   └── Devnet.toml
└── Clarinet.toml
```

## 🔐 Security Considerations

- All loans are over-collateralized
- Smart contract functions include proper validation
- Uses `try!` for safe STX transfers
- Implements secure state transitions

## 📜 License

This project is licensed under the MIT License. See LICENSE for details.

## 🤝 Contributing

Contributions are welcome! Please read our Contributing Guidelines first.
