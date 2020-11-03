clc;
clear;
close all;
 
%% Funcion Objetivo

fun =@(x) sum(x.^4);
 
%% Parametros
 
% # Individuos en la poblacion
tam = 2;
% Valores Minimos y Maximos
vMin= -10;
vMax= 10;
% Numero de Iteraciones
numIte = 20;
% Distribucion para la mutuacion
AB = -1:1:1;

% Cantidad de dimenciones
NumVari = 3; 

%% LLenar la poblacion original 
 
Poblacion = int16.empty(tam,0);
 
for i=1:tam
    Poblacion = [Poblacion;randi([vMin vMax],1,NumVari)];  %#ok<*AGROW>
end

%% Algoritmo Genetico
MejorValor=zeros(numIte,1);
 
for Iteracion=1:numIte
    %CrossOver
    for i=1:tam
        if(NumVari == 2)
            if(i == tam)
             Poblacion = [Poblacion; [Poblacion(i,1)  Poblacion(1,2)]];
            else
             Poblacion = [Poblacion; [Poblacion(i,1)  Poblacion(i+1,2)]];
            end
        else
            if(i == tam)
             Poblacion = [Poblacion; [Poblacion(i,1)  Poblacion(1,2) Poblacion(1,3)]];
            else
             Poblacion = [Poblacion; [Poblacion(i,1)  Poblacion(i+1,2) Poblacion(i+1,3)]];
            end   
        end
    end 
    %Poblacion es size 2*tam 
    %Seleccion
    %Orden para seleccion competitiva 
     NuevaPoblacion = int16.empty(tam,0);
     randomOrder = randperm(tam*2);
     for i=1:2:tam*2
        %competencia de randomOrder[i] contr randomOrder[I+1]
        %Fitness
        if(fun(Poblacion(randomOrder(i),:)) < fun(Poblacion(randomOrder(i+1),:)))
            NuevaPoblacion = [NuevaPoblacion ; Poblacion(randomOrder(i),:)];
        else 
            NuevaPoblacion = [NuevaPoblacion ; Poblacion(randomOrder(i+1),:)];
        end     
     end 
     Poblacion = NuevaPoblacion;
     %Mutuacion
     for i=1:tam
        Poblacion(i,1) = Poblacion(i,1) + AB(randi(length(AB)));
        Poblacion(i,2) = Poblacion(i,2) + AB(randi(length(AB)));
        if(NumVari == 3)
            Poblacion(i,3) = Poblacion(i,3) + AB(randi(length(AB)));
        end 
     end
     min = intmax('int16');
      for i=1:tam
        if(fun(Poblacion(i,:)) < min)
            min = fun(Poblacion(i,:));
            minVal = Poblacion(i,:);
        end
      end   
     disp(['Iteracion ' num2str(Iteracion) ': ' num2str(min)]);
     MejorValor(Iteracion)=min;
     
end
 
%% Results
 
plot(MejorValor); xlabel('Iteracion'); ylabel('Mejor Valor'); grid on;


 