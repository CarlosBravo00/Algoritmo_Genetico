clc;
clear;
close all;
%% Parametros
inp = struct;
% # Individuos en la poblacion
inp.tam = 2;
% Valores Minimos y Maximos
inp.vMin= -100;
inp.vMax= 100;
% Numero de Iteraciones
inp.numIte = 50;
% Mutuacion
inp.TazaMut = .8;
inp.MinMut = -5;
inp.MaxMut = 5;
% Cantidad de dimenciones
inp.NumVari = 3; 
% idBfm
inp.idBfm = 28;

%% Funcion Objetivo
bfm();
fun =@(x) bfm(inp.idBfm, x);
 
%% Algoritmo Genetico

Poblacion = zeros(inp.tam,0);
MejorValor = zeros(inp.numIte,1);
 
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
    %Mutuacion
    for i=1:inp.tam
        for j=1:inp.NumVari
          if( rand(1,1) < inp.TazaMut )
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
     min = intmax('int16');
      for i=1:inp.tam
        if(fun(Poblacion(i,:)) < min)
            min = fun(Poblacion(i,:));
            minVal = Poblacion(i,:);
        end
      end   
     disp(['Iteracion ' num2str(Iteracion) ': ' num2str(min)]);
     MejorValor(Iteracion)= min;
end
 
%% Results
 
plot(MejorValor); xlabel('Iteracion'); ylabel('Mejor Valor'); grid on;


 