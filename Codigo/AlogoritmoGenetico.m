%% Algoritmo Genetico
function [ MejorValor, PeorValor, PromedioValor, PobFinal, Solucion] = AlogoritmoGenetico(inp)

	fun =@(x) bfm(inp.idBfm, x);
    
    Solucion = zeros(1,inp.NumVari+1);
    PobFinal = [];
    MejorValor = zeros(inp.numIte,1);
    PeorValor = zeros(inp.numIte,1);
    PromedioValor = zeros(inp.numIte,1);
    
    Poblacion = zeros(inp.tam,inp.NumVari);
    
    for i=1:inp.tam
        for j=1:inp.NumVari
            Poblacion(i,j) = (inp.vMax-inp.vMin).*rand(1,1) + inp.vMin;
        end
    end
    
    for Iteracion=1:inp.numIte
        %CrossOver
        Hijos = zeros(inp.tam,inp.NumVari);
        for i=1:inp.tam-1
            Hijos(i,:) = [Poblacion(i,1)  Poblacion(i+1,2:end)];
        end 
        Hijos(inp.tam,:) = [Poblacion(inp.tam,1)  Poblacion(1,2:end)];
        %Mutuacion de Hijos
        for i=1:inp.tam
            for j=1:inp.NumVari
              if( rand(1,1) <= inp.TasaMut )
                 Hijos(i,j) = Hijos(i,j) + (inp.MaxMut-inp.MinMut).*rand(1,1) + inp.MinMut;
              end
           end
        end
        allPoblacion = [Poblacion ; Hijos]; %Poblacion es size 2*tam 
        %Seleccion
        %Orden para seleccion competitiva 
        randomOrder = randperm(inp.tam*2);
        cont = 1;
        for i=1:2:inp.tam*2
          %competencia de randomOrder[i] contr randomOrder[I+1]
          %Fitness
          if(fun(allPoblacion(randomOrder(i),:)) < fun(allPoblacion(randomOrder(i+1),:)))
             Poblacion(cont,:) = allPoblacion(randomOrder(i),:);
          else 
             Poblacion(cont,:) = allPoblacion(randomOrder(i+1),:);
          end 
          cont = cont + 1;
        end 
        min = inf;
        max = -inf;
        Agen = zeros(inp.tam,inp.NumVari+1);
        minAge = zeros(1,inp.NumVari+1);
        for i=1:inp.tam
          Agen(i,:) = [Poblacion(i,:) fun(Poblacion(i,:))];  
          if(fun(Poblacion(i,:)) < min)
              min = fun(Poblacion(i,:));
              minAge = [Poblacion(i,:) fun(Poblacion(i,:))];
          end
          if(fun(Poblacion(i,:)) > max)
              max = fun(Poblacion(i,:));
          end
        end   
        PobFinal = [PobFinal ; Agen]; %#ok<AGROW>
        MejorValor(Iteracion)= min;
        PeorValor(Iteracion)= max;
        PromedioValor(Iteracion)= (min + max)/2;
        Solucion = minAge;
    end
end

 