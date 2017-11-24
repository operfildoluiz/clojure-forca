defmodule Forca do
    @total_vidas 6
    @palavra_secreta ["F","I","C","T","U","R","E"]

    def comeca_jogo() do
        IO.puts("Bem-vindo ao jogo da forca. Favor usar CAPS LOCK")
        jogo(@total_vidas, @palavra_secreta, [])
    end

    defp jogo(vidas, palavra, acertos) do
        imprime(vidas, palavra, acertos)

        cond do
            (vidas == 0) -> perdeu(vidas)
            (acertou_tudo(palavra, acertos)) -> ganhou()
            true ->
                chute = IO.gets("Próxima Letra\n") |> String.replace("\n", "")
                if (acertou(chute, palavra)) do
                    IO.puts("Acertou a letra!")
                    jogo(vidas, palavra, (acertos ++ [chute]))
                else
                  IO.puts("Errou a letra!")
                  jogo((vidas - 1), palavra, acertos)
              end
          end

      end

      defp imprime(vidas, palavra, acertos) do
        IO.puts("Vidas: #{vidas}")

        for letra <- palavra do
            if (letra in acertos) do
                IO.write("#{letra} ")
            else
                IO.write("_ ")
            end
        end
        IO.puts("")
    end

    defp acertou_tudo(palavra, acertos) do
        Enum.empty?(letras_faltantes(palavra, acertos))
    end

    defp letras_faltantes(palavra, acertos) do
        palavra -- acertos
    end

    defp acertou(chute, palavra) do
        Enum.member?(palavra, chute)
    end

    defp perdeu(vidas) do
        IO.puts("Você perdeu com #{vidas}... A palavra era #{@palavra_secreta}")
    end

    defp ganhou() do
        IO.puts("Você ganhou!!")
    end

end

# Forca.comeca_jogo
