(ns forca.core
  (:gen-class))

(def total-de-vidas 6)
(def palavra-secreta "ITUBAINA")

(defn perdeu [] (println "Voce perdeu"))
(defn ganhou [] (println "Voce ganhou"))

(defn letras-faltantes [palavra acertos]
    (remove (fn [letra] (contains? acertos (str letra))) palavra )
)

(defn le-letra! [] (read-line))

(defn acertou-a-palavra-toda? [palavra acertos]
    (empty? (letras-faltantes palavra acertos))
)

(defn acertou? [chute palavra]
    (.contains palavra chute)
)

(defn imprime-forca [vidas palavra acertos]
    (println "Vidas: " vidas)
    (doseq [letra (seq palavra)]
            (if (contains? acertos (str letra))
                (print letra " ")
                (print "_ ")
            )
    )
    (println)
)

(defn jogo [vidas palavra acertos]
   (imprime-forca vidas palavra acertos)
   (cond
        (= vidas 0) (perdeu)
        (acertou-a-palavra-toda? palavra acertos) (ganhou)
        :else
        (let [chute (le-letra!)]
             (if (acertou? chute palavra)
                (do
                    (println "Acertou a letra!")
                    (recur vidas palavra (conj acertos chute))
                )
                (do
                    (println "Errou a letra!")
                    (recur (dec vidas) palavra acertos)
                )
             )
        )
   )
)

(defn comeca-jogo [] (jogo total-de-vidas palavra-secreta #{}))

(defn -main  [& args]
  (comeca-jogo))
