let MySQL = require("../src/mysql.js");
let Probe = require("../src/probe.js");

class Import {
    constructor() {
        this.command = "import [options]";
        this.describe = "Import matches";
        this.builder = this.arguments.bind(this);
        this.handler = this.run.bind(this);
        this.mysql = new MySQL();
    }

    arguments(args) {
        args.option("loop", { alias: "l", describe: "Run again after specified number of days", default: 7 });
        args.help();
    }

    async log(message) {
        try {
            await this.mysql.upsert("log", { message: message });
        } catch (error) {
        } finally {
            console.log(message);
        }
    }

    async execute(file) {
        this.log(`Executing file ${file}`);
        await this.mysql.execute(file);
    }

    async download(fileURL, file) {
        return new Promise((resolve, reject) => {
            const http = require("https");
            const fs = require("fs");

            http.get(fileURL, (response) => {
                if (response.statusCode == 200) {
                    let stream = fs.createWriteStream(file);

                    response.pipe(stream);

                    stream.on("finish", () => {
                        stream.close(() => {
                            resolve();
                        });
                    });
                } else {
                    response.resume();
                    reject(new Error(response.statusMessage));
                }
            }).on("error", (error) => {
                fs.unlink(file, () => {
                    reject(error);
                });
            });
        });
    }

    async upsertContents(file) {
        const probe = new Probe();
        const fs = require("node:fs/promises");

        let content = await fs.readFile(file);
        let text = content.toString();

        text = text.replace("\r\n", "\n");
        text = text.replace("\r", "\n");

        let lines = text.split("\n");
        let columns = lines[0].split(",");

        for (let index = 1; index < lines.length; index++) {
            let row = {};
            let values = lines[index].split(",");

            if (values.length == columns.length) {
                for (let i = 0; i < columns.length; i++) {
                    let value = values[i].replace("\r", "");
                    row[columns[i]] = value;
                }

                await this.mysql.upsert("import", row);
            }
        }

        this.log(`Finished import of ${file} in ${probe.toString()}`);
    }

    async import(file) {
        let src = `https://raw.githubusercontent.com/Tennismylife/TML-Database/refs/heads/master/${file}`;
        let dst = `./downloads/${file}`;

        this.log(`Downloading ${file}...`);

        await this.download(src, dst);
        await this.upsertContents(dst);
    }

    async run(argv) {
        let work = async () => {
            try {
                this.mysql.connect();

                await this.import("2024.csv");
                await this.import("2025.csv");
                await this.import("ongoing_tourneys.csv");
                await this.execute("./sql/matches.sql");
            } catch (error) {
                console.error(error.stack);
            } finally {
                this.mysql.disconnect();
            }

            if (argv.loop) {
                let loop = argv.loop;
                this.log(`Waiting for next loop (${loop} minutes)...`);

                setTimeout(() => {
                    work();
                }, 1000);
            }
        };

        await work();
    }
}

module.exports = new Import();
