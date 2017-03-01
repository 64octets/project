clc;
clear all;
close all;
load mw
pred = mw(1:end,1:8);
pred1=reshape(pred,64,1);
pred2=.5+pred1;
al=1;
gr=1;
dat=[pred1 pred2];
out = roc_draw(dat,al,gr);
