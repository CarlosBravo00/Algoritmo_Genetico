clc;
clear;
close all;
 
%% Definicion del Problema
 
fun =@(x) sum(x.^2);
 
%% Parametros
 
% Tamaño de la Matriz (Una armonia)
tam=3;
tamMat=[1 tam];
%Tamaño de la Memoria Armonica
tamMem=8; 
% Valores Minimos y Maximos
vMin= -10;
vMax= 10;
% Numero de Improvisaciones (Iteraciones)
numImp=100;
% Numero de Armonias Nuevas
numArmN=5;
% Tasa de Consideracion
tCnsdr=0.9;
% Tasa de Ajuste de Tono
tTono=0.1;
% Ancho de Banda de Ajuste de Tono
AB = 0.2;
aBanda=AB*(vMax-vMin);

%% Llenar Memoria Armonica
 
Armonia.Posicion=[];
Armonia.Valor=[];
 
Memoria=repmat(Armonia,tamMem,1);
 
% Creacion de Armonias Iniciales
for i=1:tamMem
    Memoria(i).Posicion=unifrnd(vMin,vMax,tamMat);
    Memoria(i).Valor=fun(Memoria(i).Posicion);
end
 
% Ordenar Armonias (colocando la mejor solucion en el primer puesto)
[~, ordenMat]=sort([Memoria.Valor]);
Memoria=Memoria(ordenMat);
 
MejorSol=Memoria(1);
MejorValor=zeros(numImp,1);
 
%% Busqueda Armonica
 
for Iteracion=1:numImp
    nuevaArm=repmat(Armonia,numArmN,1);
    
    % Creacion de Nuevas Armonias
    for k=1:numArmN
        nuevaArm(k).Posicion=unifrnd(vMin,vMax,tamMat);
        for j=1:tam
            % Solo se agrega la armonia si los valores la tasa de
            % consideracion y la tasa de ajuste de tono iguales o menores a
            % lo previamente establecido
            if rand<=tCnsdr
                i=randi([1 tamMem]);
                nuevaArm(k).Posicion(j)=Memoria(i).Posicion(j);
                if rand<=tTono
                    anchoBanda=aBanda*randn(); 
                    nuevaArm(k).Posicion(j)=nuevaArm(k).Posicion(j)+anchoBanda;
                end
            end
        
        end
        
        % Se aplican los nuevos limites
        nuevaArm(k).Posicion=max(nuevaArm(k).Posicion,vMin);
        nuevaArm(k).Posicion=min(nuevaArm(k).Posicion,vMax);
        nuevaArm(k).Valor=fun(nuevaArm(k).Posicion);
        
    end
    
    % Concatenacion de la memoria con la nueva armonia
    Memoria=[Memoria; nuevaArm];
    
    % Se ordena la memoria nuevamente para actualizar la mejor solucion
    [~, SortOrder]=sort([Memoria.Valor]);
    Memoria=Memoria(SortOrder);
 
    MejorSol=Memoria(1);
    MejorValor(Iteracion)=MejorSol.Valor;
    
    % Desplegar iteraciones
    disp(['Iteracion ' num2str(Iteracion) ': ' num2str(MejorValor(Iteracion))]);
    
    
end
 
%% Results
 
plot(MejorValor); xlabel('Iteracion'); ylabel('Mejor Valor'); grid on;

 