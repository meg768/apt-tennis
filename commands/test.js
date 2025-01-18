let MySQL = require('../src/mysql.js')

class Test {
    constructor() {
        this.command  = ["test [options]", "test [options]"];
        this.describe = "Initia test";
        this.builder  = this.arguments.bind(this);
        this.handler  = this.run.bind(this);
        this.mysql    = new MySQL();
    }

    arguments(args) {
        args.option("symbol", { alias: "s", describe: "Download specified symbol only" });
        args.option("clean", { alias: "l", describe: "Clean out", default: false });
        args.help();
    }

    async connect() {
        await this.mysql.connect();
    }

    async disconnect() {
        await this.mysql.disconnect();
    }

    async execute(file) {
        await this.mysql.execute(file);
    }

    async run(argv) {
        await this.connect();
        await this.execute("./import/data.sql");
        await this.execute("./import/tournaments.sql");
        await this.execute("./import/players.sql");
        await this.disconnect();
    }
}

module.exports = new Test();  
