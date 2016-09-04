use Mix.Config

config :pkes, 
    key_path: "test/key.pub",       # <- Public key path
    crypto_module: :crypto_mock     # <- Crypto module name

config :ranch,
    timeout: 10000,                 # <- Receive timout
    ip: {127,0,0,1},                # <- IP
    port: 1234                      # <- Port
