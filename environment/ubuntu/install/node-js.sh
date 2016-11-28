#!/bin/sh
apt-get install -f -y nodejs
npm i -g nvm express express-generator tape mocha grunt gulp swagger pm2 cheerio istanbul bower nodemon jade
export NODE_PATH=/usr/lib/node_modules
npm cache clean -g
