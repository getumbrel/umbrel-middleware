const lightningLogic = require('logic/lightning');

const delay = ms => new Promise(resolve => setTimeout(resolve, ms));

const ONE_SECOND = 1000;
const INTERVAL = 10 * ONE_SECOND;

module.exports = class LndUnlocker {
  constructor(password) {
    this.password = password;
    this.running = false;
  }

  async unlock() {
    try {
      await lightningLogic.unlockWallet(this.password);
      console.log('LndUnlocker: Wallet unlocked!');
    } catch (e) {
      console.log(`LndUnlocker: Couldn't unlock wallet`);
    }
  }

  async start() {
    if (this.running) {
      throw new Error('Already running');
    }
    this.running = true;
    while (this.running) {
      await this.unlock();
      await delay(INTERVAL);
    }
  }

  stop() {
    this.running = false;
  }
}
