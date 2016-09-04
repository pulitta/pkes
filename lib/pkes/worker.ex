defmodule Pkes.Worker do
    use GenServer
    
    def start_link do
        opts = [port: get_ranch_port, ip: get_ranch_ip]
        {:ok, _} = :ranch.start_listener(:Pkes, 100, :ranch_tcp, opts, Pkes.Handler, [])
    end

    defp get_ranch_port do
        case Application.get_env(:ranch, :port) do
            nil  -> raise "Ranch port is not configured"
            port -> port
        end
    end

    defp get_ranch_ip do
        case Application.get_env(:ranch, :ip) do
            nil -> raise "Ranch ip is not configured"
            ip  -> ip
        end
    end
end