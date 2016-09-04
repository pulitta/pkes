defmodule Pkes.Handler do

    def start_link(ref, socket, transport, opts) do
        pid = spawn_link(__MODULE__, :init, [ref, socket, transport, opts])
        {:ok, pid}
    end
           
    def init(ref, socket, transport, _Opts = []) do
        :ok = :ranch.accept_ack(ref)
        loop(socket, transport)
    end

    def loop(socket, transport) do
        case transport.recv(socket, 0, get_ranch_timeout) do
            {:ok, data} ->
              transport.send(socket, Pkes.Encryptor.handle(data))
              loop(socket, transport)
            _           ->
              :ok = transport.close(socket)
        end
    end

    defp get_ranch_timeout do
        case Application.get_env(:ranch, :timeout) do
            nil      -> raise "Ranch timeout is not configured"
            timeout  -> timeout
        end
    end
end