defmodule PkesTest do
  use ExUnit.Case
  doctest Pkes

  setup do
        Application.delete_env(:pkes, :key_path, [])
        Application.delete_env(:pkes, :crypto_module, [])
    end

    test "No key_path in config" do
        Application.put_env(:pkes, :crypto_module, "test/crypto_mock", [])
        assert_raise(RuntimeError, 
                    "Key path is not configured", 
                    fn -> 
                        Pkes.Encryptor.handle("123") 
                    end)
    end

    test "No crypto module in config" do
                assert_raise(RuntimeError, 
                    "Crypto module is not configured", 
                    fn -> 
                        Pkes.Encryptor.handle("123") 
                    end)
    end

    test "No key file" do
        Application.put_env(:pkes, :crypto_module, "test/crypto_mock", [])
        Application.put_env(:pkes, :key_path, "test.pub", [])
        assert_raise(RuntimeError, 
                    "Unable to read key file: enoent", 
                    fn -> 
                        Pkes.Encryptor.handle("123") 
                    end)
    end

    test "Success" do
        Application.put_env(:pkes, :key_path, "test/key.pub", [])
        Application.put_env(:pkes, :crypto_module, :crypto_mock, [])
        result = Pkes.Encryptor.handle("123") 
        assert "123" == result
    end
end
