defmodule Pkes.Encryptor do

    def handle(data) do
        get_crypto_module.encrypt(get_key,data)
    end

    # Get public key from config
    defp get_key() do
        case Application.get_env(:pkes, :key_path) do
            nil         -> raise "Key path is not configured"
            key_path    ->
                case File.read(key_path) do
                    {:ok, key}       -> key
                    {:error, reason} -> raise "Unable to read key file: #{reason}"
                end
        end 
    end
           
    # Get crypto module name from config
    defp get_crypto_module() do
        case Application.get_env(:pkes, :crypto_module) do
            nil             -> raise "Crypto module is not configured"
            crypto_module   -> crypto_module
        end
    end
end