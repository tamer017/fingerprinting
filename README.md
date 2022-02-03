# fingerprinting

    Location signature/fingerprinting:
    This technique searches the given input signals pattern with all the other signals in the database and 
    match with the point whichcorresponds to the nearest neighbor in the signal hyperspace.
     
    in this project i will find the location of a receiver in agiven area (2nd floor C3 building in GUC) using fingerprinting by
    knowingthe power received from each Access point.
   ![Capture](https://user-images.githubusercontent.com/83555471/152442496-b79ff013-0002-471e-9555-708f28ca3be6.PNG)

    The above is 2nd floor C3 building in GUC; which is Indoor covered by 5 WLAN Access Points (AP)
    .Partition Attenuation Factor (PAF) = 3 dB per wall. The stairs impact on the wireless channel 
    can be neglected. The AP transmission power is 20 dBm. Free space path loss is assumed for channel
    characteristics with factor =3. Grx and Gtx are unity gains. The carrier frequency (fc) = 2.4GHz.
     
     the lingth of the building is 52 meters and the width is 20 meters 

    the location of the Access points are :
    AP1 = [6,15.5625];
    AP2 = [17.5,4];
    AP3 = [25.5,15.5625];
    AP4 = [33.5,4];
    AP5 = [45,15.5625];
    
    [0,0] is the origin and it is at the bottom left of the figure above 
    the coordinates for locations of the wall are :
    Walls=[0,0,6,15;6,0,8,15;14,0,8,8;14,8,8,7;22,0,3,15;25,0,2,15;27,0,3,15;
    30,0,8,8;30,8,8,7;38,0,8,15;46,0,6,15;0,15,2,5;2,16.5,4,3.5;6,16.5,4,3.5;
    10,16.5,4,3.5;14,16.5,4,3.5;18,16.5,4,3.5;22,16.5,4,3.5;26,16.5,4,3.5;30,
    16.5,4,3.5;34,16.5,4,3.5;38,16.5,4,3.5;42,16.5,4,3.5];
    
     value of the received power every 0.5 m  from the AP location and extended to the building area of coverage. 
     these points are called reference points.
     in this building we have 4160 reference points.
     52*20*2*2 =4160
    the location of the receiver is calculated be comparing the power received at each reference pointand at the receiver point .
     computing the lest distance between the Reference point and the “fingerprints” using Root Mean Square(RMS) using the bellow formula:
  ![Capture](https://user-images.githubusercontent.com/83555471/152444830-12a97694-962c-4682-8193-23d68d3903b6.PNG)
       
       the power is calculated using the given formula 
          pr=pt+gt+gr-10*log(((4*pi.*d)/lamda).^n)-nfm.*3 
          where 
          pt : power transmitted 
          gt : transmitter gain
          gr : receiver gain
          n : Free space path loss is assumed for channel characteristics with factor =3
          nfm : Partition Attenuation Factor (PAF) per wall
          


#how to run the code 

    enter the power received from each Access Point and the output will be your location and plot it 
    in the graph and also Plot the value of the received power every 0.5 m (or any other reference point) from the AP
    location and extended to the building area of coverage “Using contour function in MATLAB”.

    for example if 
     the power received from AP1 : -100
     the power received from AP2 : -150
     the power received from AP3 : -250
     the power received from AP4 : -300
     the power received from AP5 : -350
     you are in location x = 5.5 and y = 15
     
![Capture2](https://user-images.githubusercontent.com/83555471/152445954-f103780d-387a-496e-8e8f-2a8c832067bb.PNG)



the red square is representing the receiver location which is very close tho the Ap1 and Ap2 since it receives the highest power from them

![Capture1](https://user-images.githubusercontent.com/83555471/152445982-0f3bd91b-5d96-47c9-8610-854b837a3cde.PNG)

     



