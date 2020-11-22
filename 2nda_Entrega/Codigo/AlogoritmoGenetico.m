clc;
clear;
close all;
%% Parametros
% # Individuos en la poblacion
inp.tam = 3;
% Valores Minimos y Maximos
inp.vMin= 100;
inp.vMax= 200;
% Numero de Iteraciones
inp.numIte = 1000;
% Mutuacion
inp.TasaMut = .7;
inp.MinMut = -10;
inp.MaxMut = 10;
% Cantidad de dimenciones
inp.NumVari = 3; 
% idBfm
inp.idBfm = 1;

algoritmoGenetico(inp);

%% Algoritmo Genetico

function algoritmoGenetico(inp)

	fun =@(x) bfm(inp.idBfm, x);
    
    Poblacion = zeros(inp.tam,0);
    MejorValor = zeros(inp.numIte,1);
    PeorValor = zeros(inp.numIte,1);
    PromedioValor = zeros(inp.numIte,1);
    Sol = [];

    for i=1:inp.tam
        Poblacion = [Poblacion;randi([inp.vMin inp.vMax],1,inp.NumVari)];  %#ok<*AGROW>
    end
    
    for Iteracion=1:inp.numIte
        %CrossOver
        Hijos = zeros(inp.tam,0);
        for i=1:inp.tam
            if(inp.NumVari == 2)
                if(i == inp.tam)
                 Hijos = [Hijos; [Poblacion(i,1)  Poblacion(1,2)]];
                else
                 Hijos = [Hijos; [Poblacion(i,1)  Poblacion(i+1,2)]];
                end
            else
                if(i == inp.tam)
                 Hijos = [Hijos; [Poblacion(i,1)  Poblacion(1,2) Poblacion(1,3)]];
                else
                 Hijos = [Hijos; [Poblacion(i,1)  Poblacion(i+1,2) Poblacion(i+1,3)]];
                end   
            end
        end 
        %Mutuacion de Hijos
        for i=1:inp.tam
            for j=1:inp.NumVari
              if( rand(1,1) <= inp.TasaMut )
                 Hijos(i,j) = Hijos(i,j) + randi([inp.MinMut inp.MaxMut],1,1);
              end
           end
        end
        Poblacion = [Poblacion ; Hijos]; %Poblacion es size 2*tam 
        %Seleccion
        %Orden para seleccion competitiva 
         NuevaPoblacion = zeros(inp.tam,0);
         randomOrder = randperm(inp.tam*2);
         for i=1:2:inp.tam*2
            %competencia de randomOrder[i] contr randomOrder[I+1]
            %Fitness
            if(fun(Poblacion(randomOrder(i),:)) < fun(Poblacion(randomOrder(i+1),:)))
                NuevaPoblacion = [NuevaPoblacion ; Poblacion(randomOrder(i),:)];
            else 
                NuevaPoblacion = [NuevaPoblacion ; Poblacion(randomOrder(i+1),:)];
            end     
         end 
         Poblacion = NuevaPoblacion;
         min = inf;
         max = -inf;
         Agen = 0;
          for i=1:inp.tam
            if(fun(Poblacion(i,:)) < min)
                min = fun(Poblacion(i,:));
                Agen = [Poblacion(i,:) min];
            end
            if(fun(Poblacion(i,:)) > max)
                max = fun(Poblacion(i,:));
            end
          end   
         Sol = [Sol ; Agen];
         MejorValor(Iteracion)= min;
         PeorValor(Iteracion)= max;
         PromedioValor(Iteracion)= (min + max)/2;
    end
    
    hold on; grid on;
    xlabel('Iteracion'); ylabel('Valores');
    plot(MejorValor); 
    plot(PeorValor);
    plot(PromedioValor);
    legend('Mejor valor','Peor valor','Valor promedio')
    hold off;
    
    Sol
    plot3(Sol(:,1), Sol(:,2),Sol(:,3));
    grid on;
    xlabel('x')
    ylabel('y')
    zlabel('Valor')
    
end

 