# drzewo


```mermaid
flowchart TB
    %% Pokolenie dziadków
    DziadekMM["Dziadek (tata mamy)"]
    BabciaMM["Babcia (mama mamy)"]
    DziadekMT["Dziadek (tata taty)"]
    BabciaMT["Babcia (mama taty)"]

    %% Pokolenie rodziców
    Mama["Mama"]
    DziadekMM --> Mama
    BabciaMM --> Mama
    
    Tata["Tata"]
    DziadekMT --> Tata
    BabciaMT --> Tata


    %% Wy
    Ja["Ja"]
    Mama --> Ja
    Tata --> Ja
    
    Siostra["Siostra"]
    Mama --> Siostra
    Tata --> Siostra
    
flowchart LR
    DziadekMM --- BabciaMM
    DziadekMT --- BabciaMT
    Mama --- Tata

```