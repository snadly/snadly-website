module.exports = {
  apps: [{
    name: 'kilo-website',
    script: 'dist/server/entry.mjs',
    cwd: '/opt/kilo-website',
    env: {
      HOST: '127.0.0.1',
      PORT: 4322,
      NODE_ENV: 'production',
    },
  }],
};
