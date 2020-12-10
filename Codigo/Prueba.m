clc;
clear;
close all;
    
%% Parametros
% # Individuos en la poblacion
inp.tam = 3;
% Valores Minimos y Maximos
inp.vMin= 200;
inp.vMax= 300;
% Numero de Iteraciones
inp.numIte = 10;
% Mutuacion
inp.TasaMut = .4;
inp.MinMut = -10;
inp.MaxMut = 10;
% Cantidad de dimenciones
inp.NumVari = 2; 
% idBfm
inp.idBfm = 12;

[ MejorValor, PeorValor, PromedioValor, PobFinal, Solucion] = AlogoritmoGenetico(inp);