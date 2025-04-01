# 🚀 SimpleAuction – Smart Contract for Blind Auctions  

A **secure**, **efficient**, and **trustless** smart contract for conducting **blind auctions** on **zkSync Sepolia Testnet**. This contract ensures **fair bidding**, **secure fund management**, and **automated settlement** for the highest bidder.  

🔗 **Live Contract on zkSync**:  
[✅ View on zkSync Explorer](https://sepolia.explorer.zksync.io/address/0x63d3E50A4326a547A75C37068De531aB6F690dAc#contract#contract-info)  

---

## 📜 Overview  

- **Language:** Solidity (`^0.8.24`)  
- **Network:** zkSync Sepolia Testnet  
- **Purpose:** Conduct **blind auctions** with automated bid tracking & secure payments.  

---

## ⚡ Key Features  

✔ **Blind Auction Mechanism** – Ensures private & fair bidding.  
✔ **Secure Highest Bid Tracking** – Automatically records the top bidder.  
✔ **Safe Withdrawals** – Non-winning bidders can **securely withdraw** funds.  
✔ **Optimized for zkSync** – Uses `call{value: X}("")` instead of `.transfer()` for **better gas efficiency**.  
✔ **Automated Settlement** – Transfers the highest bid to the **auction beneficiary** upon completion.  

---

## 🔍 Security Considerations  

- **Reentrancy Protection**: Uses best practices to prevent reentrancy attacks.  
- **Optimized for Layer 2**: Fully compatible with **zkSync**, ensuring lower fees & fast execution.  
- **Failsafe Withdrawals**: Ensures users can reclaim their funds securely.  

---

## 📥 Clone the Repository

To get a local copy up and running, run the following command:
```bash
git clone https://github.com/EmadXYZ/SimpleAuction.git
```

## 📄 License  

This project is licensed under the **MIT License** – you're free to use, modify, and distribute it!  

📌 **Contributions are welcome! Feel free to fork, improve, and submit a pull request.** 🤝  

---
