"use client";

import { useEffect, useState } from "react";
import Web3 from "web3";
import Proger from "./Proger";

export default function Home() {
  const [web3, setWeb3] = useState(null);
  const [account, setAccount] = useState("");
  const [balance, setBalance] = useState(0);
  const [recipient, setRecipient] = useState("");
  const [amount, setAmount] = useState("");

  useEffect(() => {
    async function loadWeb3() {
      //@ts-ignore
      if (window.ethereum) {
        //@ts-ignore
        const web3 = new Web3(window.ethereum);
        //@ts-ignore
        await window.ethereum.enable();
        //@ts-ignore
        setWeb3(web3);
        //@ts-ignore
      } else if (window.web3) {
        //@ts-ignore
        setWeb3(new Web3(window.web3.currentProvider));
      } else {
        console.log("Браузер не поддерживает систему");
      }
    }

    async function loadBlockChainData() {
      //@ts-ignore
      const accounts = await web3.eth.getAccounts();
      setAccount(accounts[0]);
      //@ts-ignore
      const networkId = await web3.eth.net.getId();
      //@ts-ignore
      const networkData = Proger.networks[networkId];

      if (networkData) {
        //@ts-ignore
        const token = new web3.eth.Contract(Proger.abi, networkData.address);
        //@ts-ignore
        let balance = await token.methods.balanceOf(account[0].call());
        setBalance(balance.toString());
      } else {
        console.log("Токен не поддерживается");
      }
    }

    if (web3) {
      loadBlockChainData;
    } else {
      loadWeb3();
    }
  }, [web3]);

  //@ts-ignore
  const transferTokens = async (recipient, amount) => {};
  return (
    <div className="grid grid-rows-[20px_1fr_20px] items-center justify-items-center min-h-screen p-8 pb-20 gap-16 sm:p-20 font-[family-name:var(--font-geist-sans)]">
      <main className="flex flex-col gap-[32px] row-start-2 items-center sm:items-start">
        <h1>Ваш аккаунт: {account}</h1>
        <h1>Ваш баланс: {balance}</h1>
        <h1>Ваш баланс: {balance}</h1>
        <h1>Ваш баланс: {balance}</h1>

        <h1>Transfer token</h1>
        <form
          onSubmit={(e) => {
            e.preventDefault();
            transferTokens(recipient, amount);
          }}
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
