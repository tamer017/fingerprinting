clc
clear all;
close all;
AP1 = [6,15.5625];
AP2 = [17.5,4];
AP3 = [25.5,15.5625];
AP4 = [33.5,4];
AP5 = [45,15.5625];
APS=[AP1 AP2 AP3 AP4 AP5];
Walls=[
    0,0;52,0;52,20;46,20;52,20;52,15;0,15;0,0;6,0;6,15;14,15;14,0;22,0;22,15;30,15;30,0;38,0;38,15;46,15;46,0;38,0;38,8;30,8;30,15;
    22,15;22,8;14,8;14,15;0,15;0,20;46,20;46,16.5;2,16.5;2,15;2,20;6,20;6,16.5;10,16.5;10,20;14,20;14,16.5;18,16.5;18,20;22,20;22,16.5;
    26,16.5;26,20;30,20;30,16.5;34,16.5;34,20;38,20;38,16.5;42,16.5;42,20;46,20;46,16.5;];
x=0.5;
rpowers=[];
fc=2.4*10^9;
c=3*10^8;
lamda=c/fc;
pt=-10;
PAF=3;
n=3;
gt=0;
gr=0;
xtotal=x;
ytotal=x;
length=0;
nmf=[];
sizeX=104;
sizeY=40;
sizeT=sizeX*sizeY;
rAP1=input("enter the power received from AP1 : ");
rAP2=input("enter the power received from AP2 : ");
rAP3=input("enter the power received from AP3 : ");
rAP4=input("enter the power received from AP4 : ");
rAP5=input("enter the power received from AP5 : ");
rectangles();
while xtotal<=52
    i=1;
    while ytotal<=20
        nfm=numberofIntersections([xtotal ytotal],APS,Walls);
        plot(xtotal,ytotal,".");
        length=length+1;
        % the distance between the referance point and APS
        d=sqrt((xtotal-APS(1:2:end)).^2+(ytotal-APS(2:2:end)).^2);
        rpowers(length,:)=pt+gt+gr-10*log(((4*pi.*d)/lamda).^3)-nfm.*3;
        ytotal=ytotal+x;
    end
    ytotal=x;
    length; 
    xtotal=xtotal+x;
end
plot(Walls(:,1),Walls(:,2));
plot(AP1(1),AP1(2),"*");
plot(AP2(1),AP2(2),"*");
plot(AP3(1),AP3(2),"*");
plot(AP4(1),AP4(2),"*");
plot(AP5(1),AP5(2),"*");
text(AP1(1),AP1(2),"AP1");
text(AP2(1),AP2(2),"AP2");
text(AP3(1),AP3(2),"AP3");
text(AP4(1),AP4(2),"AP4");
text(AP5(1),AP5(2),"AP5");
xAxis = x:x:52;
yAxis = x:x:20;
index =findMinimumd(sizeT,rAP1,rAP2,rAP3,rAP4,rAP5,rpowers)
location=[index/sizeY-mod(index,sizeY)/sizeY mod(index,sizeY)].*0.5;
plot(location(1),location(2),'--gs','LineWidth',2,'MarkerSize',10,'MarkerEdgeColor','k','MarkerFaceColor','r')
text(location(1),location(2),"here");
disp("you are in location x = "+location(1)+" and y = "+location(2))
plotContours(xAxis,yAxis,rpowers,sizeY,sizeX,sizeT);

%calculate the differences in received powers between the input point and
%all the APS
function index =findMinimumd(sizeT,rAP1,rAP2,rAP3,rAP4,rAP5,rpowers)
differences=1:sizeT;
mind=Inf;
index=0;
for i=1:sizeT
    rpower=rpowers(i,:);
    differences(i)=sqrt((rpower(1)-rAP1)^2+(rpower(2)-rAP2)^2+(rpower(3)-rAP3)^2+(rpower(4)-rAP4)^2+(rpower(5)-rAP5)^2);
    if mind>differences(i)
        mind=differences(i);
        index=i;
    end
end
end
%plotting the contour graphs of the received signals from the APS
function plotContours(xAxis,yAxis,rpowers,sizeY,sizeX,sizeT)
figure(2)
[X,Y] = meshgrid(xAxis,yAxis);
for i=1:5
    Z = reshape(rpowers(:,i),sizeY,sizeX);
    subplot(2,3,i)
    contourf(X,Y,Z)
    title("AP"+i);
end
totalReceivedPower=ones(1,sizeT);
for i=1:4160
    totalReceivedPower(i)=sum(rpowers(i,:));
    Z = reshape(totalReceivedPower(:),sizeY,sizeX);
    subplot(2,3,6)
    contourf(X,Y,Z)
    title("total APS");
end
end
%count the number of intersections of the walls and the segment between the
%points and all the APS the return valueis 1:5 array each index represent
%the number of intersections between the segment between the point and AP i
function intersections=numberofIntersections(point,APS,Walls)
intersections=zeros(1,5);
for i=1:5
    %plot(Walls(:,1),Walls(:,2),[APS(2*i-1) point(1)],[APS(2*i) point(2)]);
    %plot(Walls(:,1),Walls(:,2));
    hold on
    [x,y]=curveintersect(Walls(:,1),Walls(:,2),[APS(2*i-1) point(1)],[APS(2*i) point(2)]);
    intersections(i)=length(unique(transpose([transpose(x); transpose(y)]),'rows'));
end
end
%to draw the colored rectangles that represent each room
function rectangles()
Walls=[0,0,6,15;
    6,0,8,15;
    38,0,8,15;  %b
    46,0,6,15;
    14,0,8,8;
    14,8,8,7;   %g
    30,0,8,8;
    30,8,8,7;
    22,0,3,15;  %y
    27,0,3,15;
    25,0,2,15;   %m
    0,15,2,5;
    2,16.5,4,3.5;
    6,16.5,4,3.5;
    10,16.5,4,3.5;
    14,16.5,4,3.5;
    18,16.5,4,3.5;
    22,16.5,4,3.5;    %c
    26,16.5,4,3.5;
    30,16.5,4,3.5;
    34,16.5,4,3.5;
    38,16.5,4,3.5;
    42,16.5,4,3.5];
[r c]=size(Walls);
for i=1:r
    wall=Walls(i,:);
    if(i<5)
        rectangle('Position',wall,'FaceColor','b','EdgeColor','k','LineWidth',0.5);
    else
        if(i<9)
            rectangle('Position',wall,'FaceColor','g','EdgeColor','k','LineWidth',0.5);
        else
            if(i<11)
                rectangle('Position',wall,'FaceColor','y','EdgeColor','k','LineWidth',0.5);
            else
                if(i<12)
                    rectangle('Position',wall,'FaceColor','m','EdgeColor','k','LineWidth',0.5);
                else
                    rectangle('Position',wall,'FaceColor','c','EdgeColor','k','LineWidth',0.5);
                end
            end
        end
    end 
end
end




