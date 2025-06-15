"use client";

import { useEffect, useState } from "react";
import Web3 from "web3";

declare global {
  interface Window {
    ethereum?: any;
    web3?: {
      currentProvider: any;
    };
  }
}

export default function Home() {
  const [web3, setWeb3] = useState<Web3 | null>(null);
  const [account, setAccount] = useState(null);
  const [balance, setBalance] = useState("0");
  const [recipient, setRecipient] = useState("");
  const [amount, setAmount] = useState("");

  //useEffect(() => {
  //  async function loadBlockChainData() {
  //    if (web3) {
  //      const accounts = await web3.eth.getAccounts();
  //      setAccount(accounts[0]);
  //      const networkId = await web3.eth.net.getId();
  //      //@ts-ignore
  //      const networkData = Proger.networks[networkId];

  //      if (networkData) {
  //        const token = new web3.eth.Contract(Proger.abi, networkData.address);
  //        const balance = await token.methods.balanceOf(account).call();
  //        //@ts-ignore
  //        setBalance(balance.toString());
  //      } else {
  //        console.log("Токен не поддерживается");
  //      }
  //    }
  //  }

  //  if (web3) {
  //    loadBlockChainData();
  //  }
  //}, [web3, account]);

  const connectWallet1 = async () => {
    if (typeof window.ethereum !== "undefined" && window.ethereum.isMetaMask) {
      try {
        const accounts = await window.ethereum.request({
          method: "eth_requestAccounts",
        });

        const web3Instance = new Web3(window.ethereum);
        setWeb3(web3Instance); // если ты используешь состояние
        setAccount(accounts[0]); // или что тебе нужно
      } catch (error) {
        console.error("Ошибка подключения:", error);
      }
    } else {
      alert("MetaMask не установлен!");
    }
  };

  const transferTokens = async (recipient: any, amount: any) => {};
  return (
    <div className="grid grid-rows-[20px_1fr_20px] items-center justify-items-center min-h-screen p-8 pb-20 gap-16 sm:p-20 font-[family-name:var(--font-geist-sans)]">
      <main className="flex flex-col gap-[32px] row-start-2 items-center sm:items-start">
        <button onClick={connectWallet1}>Подключить кошелёк</button>
        <h1>Ваш аккаунт: {account}</h1>
        <h1>Ваш баланс: {balance}</h1>
        <h1>Ваш баланс: {balance}</h1>
        <h1>Ваш баланс: {balance}</h1>

        <h1>Transfer token</h1>
        <form
        //onSubmit={(e) => {
        //  e.preventDefault();
        //  transferTokens(recipient, amount);
        //}}
        >
          <div>
            <label>Addres:</label>
            <input
              type="text"
              value={recipient}
              onChange={(e) => setRecipient(e.target.value)}
            />
          </div>
          <div>
            <label>Сумма:</label>
            <input
              type="text"
              value={amount}
              onChange={(e) => setAmount(e.target.value)}
            />
          </div>

          <button>Отправить</button>
        </form>
      </main>
    </div>
  );
}
